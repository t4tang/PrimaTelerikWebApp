using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using TelerikWebApplication.Class;

namespace TelerikWebApplication.Form.Purchase.InfoRecord
{
    public partial class inv01h06 : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();

        private const int ItemsPerRequest = 10;

        public static string tr_code = null;
        public static string selected_project = null;
               
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lbl_form_name.Text = "Supplier Price Info Record";
                dtp_from.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
                dtp_to.SelectedDate = DateTime.Now;
                Session["action"] = "firstLoad";

            }
        }

        protected void RadAjaxManager1_AjaxRequest(object sender, AjaxRequestEventArgs e)
        {
            try
            {
                if (e.Argument == "Rebind")
                {
                    RadGrid1.MasterTableView.SortExpressions.Clear();
                    RadGrid1.MasterTableView.GroupByExpressions.Clear();
                    RadGrid1.Rebind(); /* Kemudian RadGrid1 akan sorting data by lastupdate (lihat sp_get_purchase_requestH*/

                    //RadGrid1.MasterTableView.Items[0].Selected = true;

                    //RadGrid2.DataSource = GetDataDetailTable(tr_code);
                    //RadGrid2.Rebind();
                }
                else if (e.Argument == "RebindAndNavigate")
                {
                    RadGrid1.MasterTableView.SortExpressions.Clear();
                    RadGrid1.MasterTableView.GroupByExpressions.Clear();
                    //RadGrid1.DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), selected_project);
                    RadGrid1.DataBind();
                    RadGrid1.MasterTableView.CurrentPageIndex = RadGrid1.MasterTableView.PageCount - 1;
                    RadGrid1.MasterTableView.Items[RadGrid1.Items.Count - 1].Selected = true;
                    //RadGrid1.MasterTableView.Items[0].Selected = true;
                    RadGrid2.DataSource = GetDataDetailTable(RadGrid1.MasterTableView.DataKeyNames.ToString());
                    RadGrid2.Rebind();
                    Session["action"] = "list";
                }
            }
            catch (Exception ex)
            {
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
            }
        }

       
          

        #region project
        private static DataTable GetProjectPrm(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT region_code, region_name FROM ms_jobsite WHERE stEdit != 4 AND region_name LIKE @text + '%' UNION SELECT 'ALL','ALL'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_proj_prm_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetProjectPrm(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["region_name"].ToString(), data.Rows[i]["region_name"].ToString()));
            }
        }

        protected void cb_proj_prm_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT region_code FROM ms_jobsite WHERE region_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
                selected_project = dr[0].ToString();
            }
            dr.Close();
            con.Close();
        }
        #endregion

        public DataTable GetDataTable()
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT info_code, supplier_name, type_infoname, cur_code, remark  FROM v_info_recordH where stedit != 4";

            cmd.CommandTimeout = 0;
            cmd.ExecuteNonQuery();
            sda = new SqlDataAdapter(cmd);
            DataTable DT = new DataTable();

            try
            {
                sda.Fill(DT);
            }
            finally
            {
                con.Close();
            }

            return DT;
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            RadGrid1.DataSource = GetDataTable();
            RadGrid1.DataBind();
        }

        protected void RadGrid1_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            (sender as RadGrid).DataSource = GetDataTable();
        }

        protected void RadGrid1_DeleteCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            var code = ((GridDataItem)e.Item).GetDataKeyValue("info_code");

            try
            {
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "update tr_InfoRecord_H set stEdit = 4, LastUpdate = getdate(), userid = @userid where info_code = @info_code";
                cmd.Parameters.AddWithValue("@info_code", code);
                cmd.Parameters.AddWithValue("@userid", public_str.user_id);
                cmd.ExecuteNonQuery();
                con.Close();

                notif.Text = "Data berhasil dihapus";
                notif.Title = "Notification";
                notif.Show();
            }
            catch (Exception ex)
            {
                con.Close();
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "");
                e.Canceled = true;
            }
        }
        protected void RadGrid1_ItemCreated(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                ImageButton editLink = (ImageButton)e.Item.FindControl("EditLink");
                editLink.Attributes["href"] = "javascript:void(0);";
                editLink.Attributes["onclick"] = String.Format("return ShowEditForm('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["info_code"], e.Item.ItemIndex);

                ImageButton printLink = (ImageButton)e.Item.FindControl("PrintLink");
                printLink.Attributes["href"] = "javascript:void(0);";
                printLink.Attributes["onclick"] = String.Format("return ShowPreview('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["info_code"], e.Item.ItemIndex);

            }
        }

        protected void RadGrid1_SelectedIndexChanged(object sender, EventArgs e)
        {
            foreach (GridDataItem item in RadGrid1.SelectedItems)
            {
                tr_code = item["info_code"].Text;
            }

            populate_detail();
            Session["action"] = "list";
        }

        protected void RadGrid1_PreRender(object sender, EventArgs e)
        {
            if (Session["action"].ToString() == "firstLoad")
            {
                if (RadGrid1.MasterTableView.Items.Count > 0)
                    RadGrid1.MasterTableView.Items[0].Selected = true;

                foreach (GridDataItem gItem in RadGrid1.SelectedItems)
                {
                    tr_code = gItem["info_code"].Text;
                }
                populate_detail();
            }
        }

        #region Detail

        private void populate_detail()
        {
            if (tr_code == null)
            {
                RadGrid2.DataSource = new string[] { };
            }
            else
            {
                RadGrid2.DataSource = GetDataDetailTable(tr_code);
            }

            RadGrid2.DataBind();
        }

        public DataTable GetDataDetailTable(string info_code)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT prod_code, spec, qty, min_qty, max_qty, SatQty, harga, disc, validdate, remark  FROM v_info_recordD where info_code = @info_code";
            cmd.Parameters.AddWithValue("@info_code", info_code);
            cmd.CommandTimeout = 0;
            cmd.ExecuteNonQuery();
            sda = new SqlDataAdapter(cmd);
            DataTable DT = new DataTable();

            try
            {
                sda.Fill(DT);
            }
            finally
            {
                con.Close();
            }

            return DT;
        }

        protected void RadGrid2_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            if (tr_code == null)
            {
                (sender as RadGrid).DataSource = new string[] { };
            }
            else
            {
                (sender as RadGrid).DataSource = GetDataDetailTable(tr_code);
            }

        }
        protected void RadGrid2_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            var partCode = ((GridDataItem)e.Item).GetDataKeyValue("prod_code");

            try
            {
                GridEditableItem item = (GridEditableItem)e.Item;
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "delete from tr_InfoRecord_D where prod_code = @prod_code and info_code = @info_code";
                cmd.Parameters.AddWithValue("@info_code", tr_code);
                cmd.Parameters.AddWithValue("@prod_code", partCode);
                cmd.ExecuteNonQuery();
                con.Close();
                RadGrid2.DataBind();

                notif.Text = "Data berhasil dihapus";
                notif.Title = "Notification";
                notif.Show();
            }
            catch (Exception ex)
            {
                con.Close();
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "");
                e.Canceled = true;
            }
        }

        protected void RadGrid2_InsertCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                con.Open();
                GridEditableItem item = (GridEditableItem)e.Item;
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_save_info_recordD";
                cmd.Parameters.AddWithValue("@info_code", tr_code);
                cmd.Parameters.AddWithValue("@prod_code", (item.FindControl("lblProdCode") as Label).Text);
                cmd.Parameters.AddWithValue("@qty", Convert.ToDouble((item.FindControl("txt_qty") as RadTextBox).Text));
                cmd.Parameters.AddWithValue("@min_qty", Convert.ToDouble((item.FindControl("txt_qty_min") as RadTextBox).Text));
                cmd.Parameters.AddWithValue("@max_qty", Convert.ToDouble((item.FindControl("txt_qty_max") as RadTextBox).Text));
                cmd.Parameters.AddWithValue("@harga", Convert.ToDouble((item.FindControl("txt_harga") as RadTextBox).Text));
                cmd.Parameters.AddWithValue("@Disc", Convert.ToDouble((item.FindControl("txt_disc") as RadTextBox).Text));
                cmd.Parameters.AddWithValue("@SatQty", (item.FindControl("lblUom") as Label).Text);
                cmd.Parameters.AddWithValue("@remark", (item.FindControl("txtRemark_d") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@ValidDate", string.Format("{0:yyyy-MM-dd}", (item.FindControl("dtpDelivDate") as RadDatePicker).SelectedDate));
                cmd.ExecuteNonQuery();
                con.Close();

                notif.Show();
            }
            catch (Exception ex)
            {
                con.Close();
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
                e.Canceled = true;
            }
        }

        #endregion

        protected void cb_prod_code_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            string sql = "SELECT top (100) c.Prod_code, c.spec, c.unit, a.Disc FROM tr_InfoRecord_H a JOIN tr_InfoRecord_D b ON b.info_code = a.info_code right JOIN ms_product c " +
                " ON c.Prod_code = b.Prod_code WHERE c.stEdit <> 4 and spec LIKE @spec + '%'";
            SqlDataAdapter adapter = new SqlDataAdapter(sql,
                ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@spec", e.Text);

            DataTable dt = new DataTable();
            adapter.Fill(dt);

            RadComboBox comboBox = (RadComboBox)sender;
            // Clear the default Item that has been re-created from ViewState at this point.
            comboBox.Items.Clear();

            foreach (DataRow row in dt.Rows)
            {
                RadComboBoxItem item = new RadComboBoxItem();
                item.Text = row["Prod_code"].ToString();
                item.Value = row["Prod_code"].ToString();
                item.Attributes.Add("spec", row["spec"].ToString());
                item.Attributes.Add("unit", row["unit"].ToString());
                item.Attributes.Add("Disc", row["Disc"].ToString());
                comboBox.Items.Add(item);

                item.DataBind();
            }
        }

        protected void cb_prod_code_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            Session["Prod_code"] = e.Value;

            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "SELECT c.Prod_code, c.spec, c.unit, a.Disc FROM tr_InfoRecord_H a JOIN tr_InfoRecord_D b ON b.info_code = a.info_code right JOIN ms_product c " +
               " ON c.Prod_code = b.Prod_code WHERE c.stEdit <> 4 and c.prod_code = '" + (sender as RadComboBox).SelectedValue + "'";
               
                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                foreach (DataRow dtr in dt.Rows)
                {
                    RadComboBox cb = (RadComboBox)sender;
                    GridEditableItem item = (GridEditableItem)cb.NamingContainer;
                    RadTextBox tx_qty = (RadTextBox)item.FindControl("txt_qty");
                    RadTextBox tx_qty_min = (RadTextBox)item.FindControl("txt_qty_min");
                    RadTextBox tx_qty_max = (RadTextBox)item.FindControl("txt_qty_max");
                    Label lb_uom = (Label)item.FindControl("lblUom");
                    RadTextBox tx_disc = (RadTextBox)item.FindControl("txt_disch");
                    //RadTextBox tx_harga = (RadTextBox)item.FindControl("txt_harga"); ;
                    //RadDatePicker dt_valid_date = (RadDatePicker)item.FindControl("dtpValidDate");
                    //RadTextBox tx_remark = (RadTextBox)item.FindControl("txtRemark_d");

                    tx_qty.Text = "1";
                    tx_qty_min.Text = "1";
                    tx_qty_max.Text = "999999";
                    lb_uom.Text = dtr["unit"].ToString();
                    tx_disc.Text = dtr["Disc"].ToString();
                    //tx_harga.Text = dtr["harga"].ToString();
                    //dt_valid_date.SelectedDate = Convert.ToDateTime(dtr["ValidDate"].ToString());
                    //tx_remark.Text = dtr["remark"].ToString();
                }

            }
            catch (Exception ex)
            {
                Response.Write("<script language='javascript'>alert('" + ex.Message + "')</script>");
            }
            finally
            {
                con.Close();
            }
        }
    }
}