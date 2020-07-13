using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.Data;
using Telerik.Web.UI;
using TelerikWebApplication.Class;

namespace TelerikWebApplication.Form.Purchase.PurchaseReq
{
    public partial class pur01h01a : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();

        private const int ItemsPerRequest = 10;
        public static string tr_code = null;
        public static string selected_cost_ctr = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lbl_form_name.Text = "Purchase Request";
                dtp_from.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
                dtp_to.SelectedDate = DateTime.Now;
                cb_proj_prm.SelectedValue = public_str.site;
                cb_proj_prm.Text = public_str.sitename;
                
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
                    //GridSort();
                    RadGrid1.Rebind();
                }
                else if (e.Argument == "RebindAndNavigate")
                {
                    RadGrid1.MasterTableView.SortExpressions.Clear();
                    RadGrid1.MasterTableView.GroupByExpressions.Clear();
                    RadGrid1.MasterTableView.CurrentPageIndex = RadGrid1.MasterTableView.PageCount - 1;
                    //GridSort();
                    RadGrid1.Rebind();
                    RadGrid1.MasterTableView.Items[RadGrid1.Items.Count - 1].Selected = true;
                    RadGrid2.DataSource = new string[] { };
                    RadGrid2.Rebind();
                    //RadGrid2.MasterTableView.Caption = tr_code;
                    Session["action"] = "list";
                }
            }
            catch (Exception ex)
            {
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
            }
            
        }

        #region search parameter
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            RadGrid1.DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), cb_proj_prm.SelectedValue);
            RadGrid1.DataBind();
            if (RadGrid1.MasterTableView.Items.Count > 0)
            {
                RadGrid1.MasterTableView.Items[0].Selected = true;
                populate_detail();
            }
        }

        private static DataTable GetProjectPrm(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT region_code, region_name FROM inv00h09 WHERE stEdit != 4 AND region_name LIKE @text + '%' UNION SELECT 'ALL','ALL'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_project_prm_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
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

        #region Header
        public DataTable GetDataTable(string fromDate, string toDate, string project)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_purchase_requestH";
            cmd.Parameters.AddWithValue("@date", fromDate);
            cmd.Parameters.AddWithValue("@todate", toDate);
            cmd.Parameters.AddWithValue("@project", project);
            cmd.Parameters.AddWithValue("@type_pr", "A");
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
        protected void RadGrid1_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            (sender as RadGrid).DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), cb_proj_prm.SelectedValue);
        }
        protected void RadGrid1_DeleteCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            var doc_code = ((GridDataItem)e.Item).GetDataKeyValue("pr_code");

            try
            {
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "UPDATE pur01h01 SET userid = @Usr, lastupdate = GETDATE(), status_pur = '4' WHERE (pr_code = @pr_code)";
                cmd.Parameters.AddWithValue("@pr_code", doc_code);
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
        protected void RadGrid1_SelectedIndexChanged(object sender, EventArgs e)
        {
            populate_detail();
            Session["action"] = "list";
        }
        protected void RadGrid1_ItemCreated(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                ImageButton editLink = (ImageButton)e.Item.FindControl("EditLink");
                editLink.Attributes["href"] = "javascript:void(0);";
                editLink.Attributes["onclick"] = String.Format("return ShowEditForm('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pr_code"], e.Item.ItemIndex);

                ImageButton printLink = (ImageButton)e.Item.FindControl("PrintLink");
                printLink.Attributes["href"] = "javascript:void(0);";
                printLink.Attributes["onclick"] = String.Format("return ShowPreview('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pr_code"], e.Item.ItemIndex);

            }
        }
        protected void RadGrid1_PreRender(object sender, EventArgs e)
        {
            if (Session["action"].ToString() == "firstLoad")
            {
                if (RadGrid1.MasterTableView.Items.Count > 0)
                    RadGrid1.MasterTableView.Items[0].Selected = true;

                populate_detail();
            }
        }
        #endregion        
        
        #region Detail
        protected void RadGrid2_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            foreach (GridDataItem item in RadGrid1.SelectedItems)
            {
                tr_code = item["pr_code"].Text;
            }

            if (tr_code == null)
            {
                RadGrid2.DataSource = new string[] { };
            }
            else
            {
                RadGrid2.DataSource = GetDataDetailTable(tr_code);
            }
        }

        public DataTable GetDataDetailTable(string doc_code)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_purchase_requestD";
            cmd.Parameters.AddWithValue("@doc_code", doc_code);
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

        protected void RadGrid2_DeleteCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            var partCode = ((GridDataItem)e.Item).GetDataKeyValue("part_code");

            try
            {
                GridEditableItem item = (GridEditableItem)e.Item;
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "delete from pur01d01 where prod_code = @part_code and pr_code = @doc_code";
                cmd.Parameters.AddWithValue("@doc_code", tr_code);
                cmd.Parameters.AddWithValue("@part_code", partCode);
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

        protected void cb_prod_code_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            string sql = "SELECT TOP (100)[part_code] as [Prod_code], [part_desc],[doc_code],[qtyRema],[part_unit] FROM [v_purchase_request_reff_typeA]  WHERE [part_desc] LIKE @spec + '%'";
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
                item.Attributes.Add("part_desc", row["part_desc"].ToString());
                item.Attributes.Add("doc_code", row["doc_code"].ToString());
                item.Attributes.Add("qtyRema", row["qtyRema"].ToString());
                item.Attributes.Add("part_unit", row["part_unit"].ToString());

                comboBox.Items.Add(item);

                item.DataBind();
            }
        }

        protected void cb_prod_code_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            Session["part_code"] = e.Value;
            
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "SELECT [part_code], [part_desc],[doc_code],[qtyRema],[part_unit],[date_exec],[remark] FROM "+
                    "[v_purchase_request_reff_typeA] WHERE [part_code] = '" + (sender as RadComboBox).SelectedValue + "'";

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                foreach (DataRow dtr in dt.Rows)
                {
                    RadComboBox cb = (RadComboBox)sender;
                    GridEditableItem item = (GridEditableItem)cb.NamingContainer;
                    Label lb_reff = (Label)item.FindControl("lblRS");
                    RadTextBox tx_qty = (RadTextBox)item.FindControl("txtPartQty");
                    Label lb_uom = (Label)item.FindControl("lblUom");
                    Label lb_cost_ctr = (Label)item.FindControl("lblCostCtr");
                    Label lb_qty_po = (Label)item.FindControl("lblQtyPo");
                    Label lb_soh = (Label)item.FindControl("lblSoh");
                    RadDatePicker dt_deliv_date = (RadDatePicker)item.FindControl("dtpDelivDate");
                    RadTextBox tx_remark = (RadTextBox)item.FindControl("txtRemark_d");

                    lb_reff.Text = dtr["doc_code"].ToString();
                    tx_qty.Text = dtr["qtyRema"].ToString();
                    lb_uom.Text = dtr["part_unit"].ToString();
                    lb_cost_ctr.Text = selected_cost_ctr.ToString();
                    lb_qty_po.Text = string.Format("{0:#,###,##0.00}", 0);
                    lb_soh.Text = string.Format("{0:#,###,##0.00}", 0);
                    dt_deliv_date.SelectedDate = Convert.ToDateTime(dtr["date_exec"].ToString());
                    tx_remark.Text= dtr["remark"].ToString();
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

        protected void RadGrid2_InsertCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                foreach (GridDataItem gItem in RadGrid1.SelectedItems)
                {
                    tr_code = gItem["pr_code"].Text;
                    selected_cost_ctr = gItem["dept_code"].Text;
                }
                con.Open();
                GridEditableItem item = (GridEditableItem)e.Item;                   
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_save_purchase_requestD";
                cmd.Parameters.AddWithValue("@prod_type", "M1");
                cmd.Parameters.AddWithValue("@Prod_code", (item.FindControl("cb_prod_code") as RadComboBox).Text);
                cmd.Parameters.AddWithValue("@no_ref", (item.FindControl("lblRS") as Label).Text);
                cmd.Parameters.AddWithValue("@qty", Convert.ToDouble((item.FindControl("txtPartQty") as RadTextBox).Text));
                cmd.Parameters.AddWithValue("@SatQty", (item.FindControl("lblUom") as Label).Text);
                cmd.Parameters.AddWithValue("@DeliDate", string.Format("{0:yyyy-MM-dd}", (item.FindControl("dtpDelivDate") as RadDatePicker).SelectedDate));
                cmd.Parameters.AddWithValue("@Remark", (item.FindControl("txtRemark_d") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@pr_code", tr_code);
                cmd.Parameters.AddWithValue("@stock_hand", Convert.ToDouble((item.FindControl("lblSoh") as Label).Text));
                cmd.Parameters.AddWithValue("@Prod_code_ori", (item.FindControl("cb_prod_code") as RadComboBox).Text);
                cmd.Parameters.AddWithValue("@dept_code", (item.FindControl("lblCostCtr") as Label).Text);
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

        public DataTable GetDataRefDetailTable(string doc_code)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select * from v_purcahse_requestD_reff where no_ref = @doc_code";
            cmd.Parameters.AddWithValue("@doc_code", doc_code);
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

        private void populate_detail()
        {
            foreach (GridDataItem item in RadGrid1.SelectedItems)
            {
                tr_code = item["pr_code"].Text;
                selected_cost_ctr = item["dept_code"].Text;
            }

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
        #endregion
       
        protected void GridSort()
        {
            GridSortExpression expression = new GridSortExpression();
            expression.FieldName = "pr_code";
            expression.SortOrder = GridSortOrder.Descending;
            RadGrid1.MasterTableView.SortExpressions.AddSortExpression(expression);
            RadGrid1.MasterTableView.Rebind();
        }
    }
}