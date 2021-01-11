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

namespace TelerikWebApplication.Form.Fico.InvoiceIncoming
{
    public partial class acc01h13 : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();

        private const int ItemsPerRequest = 10;

        public static string tr_code = null;
        public static string reff_code = null;
        public static string selected_project = null;
        public static string tax_check = null;
        public static string oTax_check = null;
        public static string pph_check = null;
        public static string tax1 = null;
        public static string tax2 = null;
        public static string tax3 = null;
        private static string GetStatusMessage(int offset, int total)
        {
            if (total <= 0)
                return "No matches";

            return String.Format("Items <b>1</b>-<b>{0}</b> out of <b>{1}</b>", offset, total);
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lbl_form_name.Text = "Invoice Incoming";
                dtp_from.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
                dtp_to.SelectedDate = DateTime.Now;
                selected_project = public_str.site;
                cb_proj_prm.SelectedValue = public_str.site;
                cb_proj_prm.Text = public_str.sitename;

                tr_code = null;
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

                    RadGrid1.MasterTableView.Items[0].Selected = true;

                    RadGrid2.DataSource = GetDataDetailTable(tr_code);
                    RadGrid2.Rebind();
                }
                else if (e.Argument == "RebindAndNavigate")
                {
                    RadGrid1.MasterTableView.SortExpressions.Clear();
                    RadGrid1.MasterTableView.GroupByExpressions.Clear();
                    RadGrid1.DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), selected_project);
                    RadGrid1.DataBind();
                    //RadGrid1.MasterTableView.CurrentPageIndex = RadGrid1.MasterTableView.PageCount - 1;
                    //RadGrid1.MasterTableView.Items[RadGrid1.Items.Count - 1].Selected = true;
                    RadGrid1.MasterTableView.Items[0].Selected = true;
                    RadGrid2.DataSource = GetDataDetailTable(tr_code);
                    RadGrid2.Rebind();
                    Session["action"] = "list";
                }
            }
            catch (Exception ex)
            {
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
            }
        }

        #region TAX
        protected void edt_chkTax1_CheckedChanged(object sender, EventArgs e)
        {
            if ((sender as CheckBox).Checked == true)
            {
                tax_check = "1";
            }
            else
            {
                tax_check = "0";
            }
        }

        protected void edt_chkTax1_PreRender(object sender, EventArgs e)
        {
            if ((sender as CheckBox).Checked == true)
            {
                tax_check = "1";
            }
            else
            {
                tax_check = "0";
            }
        }

        protected void edt_chkOTax_CheckedChanged(object sender, EventArgs e)
        {
            if ((sender as CheckBox).Checked == true)
            {
                oTax_check = "1";
            }
            else
            {
                oTax_check = "0";
            }
        }

        protected void edt_chkOTax_PreRender(object sender, EventArgs e)
        {
            if ((sender as CheckBox).Checked == true)
            {
                oTax_check = "1";
            }
            else
            {
                oTax_check = "0";
            }
        }

        protected void edt_chkTpph_CheckedChanged(object sender, EventArgs e)
        {
            if ((sender as CheckBox).Checked == true)
            {
                pph_check = "1";
            }
            else
            {
                pph_check = "0";
            }
        }

        protected void edt_chkTpph_PreRender(object sender, EventArgs e)
        {
            if ((sender as CheckBox).Checked == true)
            {
                pph_check = "1";
            }
            else
            {
                pph_check = "0";
            }
        }
        #endregion

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

        private void clear_text(ControlCollection ctrls)
        {
            foreach (Control ctrl in ctrls)
            {
                if (ctrl is RadTextBox)
                {
                    ((RadTextBox)ctrl).Text = "";
                }
                else if (ctrl is RadComboBox)
                    ((RadComboBox)ctrl).Text = "";

                clear_text(ctrl.Controls);

            }
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            RadGrid1.DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), cb_proj_prm.SelectedValue);
            RadGrid1.DataBind();
        }

        #region project
        private static DataTable GetProjectPrm(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT region_code, region_name FROM inv00h09 WHERE stEdit != 4 AND region_name LIKE @text + '%' UNION SELECT 'ALL','ALL'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_proj_prm_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
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

        private static DataTable GetProject(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT region_code, region_name FROM inv00h09 WHERE stEdit != 4 AND region_name LIKE @text + '%' ",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }

        protected void cb_project_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT region_code FROM inv00h09 WHERE region_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            }
            dr.Close();
            con.Close();

        }
        #endregion

        #region RadGrid1 GetDataTable
        protected void RadGrid1_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            (sender as RadGrid).DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), cb_proj_prm.SelectedValue);
        }
        public DataTable GetDataTable(string fromDate, string toDate, string project)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_invoice_incomingH";
            cmd.Parameters.AddWithValue("@date", fromDate);
            cmd.Parameters.AddWithValue("@todate", toDate);
            cmd.Parameters.AddWithValue("@project", project);
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
        protected void RadGrid1_PreRender(object sender, System.EventArgs e)
        {
            if (!this.IsPostBack && this.RadGrid1.MasterTableView.Items.Count > 1)
            {
                this.RadGrid1.MasterTableView.Items[0].Edit = false;
                this.RadGrid1.MasterTableView.Rebind();
            }
        }
        protected void RadGrid1_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            var NoBuk = ((GridDataItem)e.Item).GetDataKeyValue("NoBuk"); 

            try
            {
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "UPDATE acc01h13 SET userid = @Usr, lastupdate = GETDATE(), Batal = '1' WHERE (NoBuk = @NoBuk)";
                cmd.Parameters.AddWithValue("@NoBuk", NoBuk);
                cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
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
                editLink.Attributes["onclick"] = String.Format("return ShowEditForm('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["NoBuk"], e.Item.ItemIndex);

                ImageButton printLink = (ImageButton)e.Item.FindControl("PrintLink");
                printLink.Attributes["href"] = "javascript:void(0);";
                printLink.Attributes["onclick"] = String.Format("return ShowPreview('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["NoBuk"], e.Item.ItemIndex);

            }
        }
        protected void RadGrid1_SelectedIndexChanged(object sender, EventArgs e)
        {
            foreach (GridDataItem item in RadGrid1.SelectedItems)
            {
                tr_code = item["NoBuk"].Text;
                reff_code = item["NoPO"].Text;
                tax1 = item["tax1"].Text;
                tax2 = item["tax2"].Text;
                tax3 = item["tax3"].Text;
            }

            populate_detail();
            Session["action"] = "list";
        }
        #endregion

        public DataTable GetDataDetailTable(string NoBuk)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_invoice_incomingD";
            cmd.Parameters.AddWithValue("@NoBuk", NoBuk);
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
                RadGrid2.DataSource = GetDataDetailTable(tr_code);
            }
        }

        protected void RadGrid2_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            var KoBar = ((GridDataItem)e.Item).GetDataKeyValue("KoBar");

            try
            {
                GridEditableItem item = (GridEditableItem)e.Item;
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "delete from acc01h14 where KoBar = @KoBar and NoBuk = @NoBuk";
                cmd.Parameters.AddWithValue("@NoBuk", tr_code);
                cmd.Parameters.AddWithValue("@KoBar", KoBar);
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

        protected void RadGrid2_UpdateCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                con.Open();
                GridEditableItem item = (GridEditableItem)e.Item;
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_save_invoice_incomingD";
                cmd.Parameters.AddWithValue("@NoBuk", tr_code);
                cmd.Parameters.AddWithValue("@KoBar", (item.FindControl("lblProdCode") as Label).Text);
                cmd.Parameters.AddWithValue("@KoRek", 0);
                cmd.Parameters.AddWithValue("@KoBarH", 0);
                cmd.Parameters.AddWithValue("@qty", Convert.ToDouble((item.FindControl("txtPartQty") as RadNumericTextBox).Text));
                cmd.Parameters.AddWithValue("@SatQty", (item.FindControl("lblUom") as Label).Text);
                cmd.Parameters.AddWithValue("@KvrsiQty", 1);
                cmd.Parameters.AddWithValue("@harga", Convert.ToDouble((item.FindControl("txtPrice") as RadTextBox).Text));
                cmd.Parameters.AddWithValue("@SatHrg", 0);
                cmd.Parameters.AddWithValue("@KvrsiHrg", 1);
                cmd.Parameters.AddWithValue("@Disc", Convert.ToDouble((item.FindControl("txtDisc") as RadTextBox).Text));
                cmd.Parameters.AddWithValue("@TDisc", "%");
                cmd.Parameters.AddWithValue("@Freight", 0);
                cmd.Parameters.AddWithValue("@Ass", 0);
                cmd.Parameters.AddWithValue("@Ket", (item.FindControl("txtRemark_d") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@noref", (item.FindControl("lblRefCode") as Label).Text);
                cmd.Parameters.AddWithValue("@ref_date", Convert.ToDouble((item.FindControl("dtp_ReffDate") as RadDatePicker).SelectedDate));
                cmd.Parameters.AddWithValue("@prod_type", (item.FindControl("lblProdType") as Label).Text);
                cmd.Parameters.AddWithValue("@harga2", Convert.ToDouble((item.FindControl("txtSubPrice") as RadTextBox).Text));
                cmd.Parameters.AddWithValue("@tTax", (item.FindControl("edt_chkTax1") as CheckBox).Checked);
                cmd.Parameters.AddWithValue("@tOTax", (item.FindControl("edt_chkOTax") as CheckBox).Checked);
                cmd.Parameters.AddWithValue("@tpph", (item.FindControl("edt_chkTpph") as CheckBox).Checked);
                cmd.Parameters.AddWithValue("@dept_code", (item.FindControl("lbl_cost_ctr") as Label).Text);
                cmd.Parameters.AddWithValue("@tfactor", 0);
                cmd.Parameters.AddWithValue("@Asscost", Convert.ToDouble((item.FindControl("txtOtherCost") as RadTextBox).Text));
                cmd.Parameters.AddWithValue("@RefTransID", reff_code);
                cmd.Parameters.AddWithValue("@prod_code_ori", (item.FindControl("lblProdOri") as Label).Text);
                cmd.Parameters.AddWithValue("@factor", 0);
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

        protected void cb_prod_code_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            string sql = "SELECT TOP (100)[prod_code], [spec] FROM [inv00h01]  WHERE stEdit != '4' AND spec LIKE @spec + '%'";
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
                item.Text = row["prod_code"].ToString();
                item.Value = row["prod_code"].ToString();
                item.Attributes.Add("spec", row["spec"].ToString());

                comboBox.Items.Add(item);

                item.DataBind();
            }
        }

        protected void cb_prod_code_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            Session["prod_code"] = e.Value;

            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "SELECT spec,unit FROM inv00h01 WHERE prod_code = '" + (sender as RadComboBox).SelectedValue + "'";

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                foreach (DataRow dtr in dt.Rows)
                {
                    RadComboBox cb = (RadComboBox)sender;
                    GridEditableItem item = (GridEditableItem)cb.NamingContainer;
                    RadTextBox t_spec = (RadTextBox)item.FindControl("txt_prod_name");
                    RadComboBox cb_prodType = (RadComboBox)item.FindControl("cb_uom_d");
                    RadComboBox cbDept_d = (RadComboBox)item.FindControl("cb_dept_d");

                    t_spec.Text = dtr["spec"].ToString();
                    cb_prodType.Text = dtr["unit"].ToString();
                    //cbDept_d.Text = cb_cost_center.SelectedValue;
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

        protected void cb_prod_code_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT prod_code FROM inv00h01 WHERE spec = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }
    }
}