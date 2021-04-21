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
        public static string selected_project = null;
        DataTable dtValues;

        RadTextBox txt_doc_code;
        RadComboBox cb_priority;
        RadDatePicker dtp_pr;
        RadComboBox cb_type_ref;
        RadComboBox cb_project;
        RadComboBox cb_warehouse;
        RadComboBox cb_cost_ctr;
        RadTextBox txt_remark;
        RadComboBox cb_prepare_by;
        RadComboBox cb_orderBy;
        RadComboBox cb_checked;
        RadComboBox cb_approved;
        Button btnCancel;
        RadGrid Grid2;

        private static string GetStatusMessage(int offset, int total)
        {
            if (total <= 0)
                return "No matches";

            return String.Format("Items <b>1</b>-<b>{0}</b> out of <b>{1}</b>", offset, total);
        }

        public DataTable DetailDtbl()
        {
            dtValues = new DataTable();
            dtValues.Columns.Add("pr_code", typeof(string));
            dtValues.Columns.Add("Prod_code", typeof(string));
            dtValues.Columns.Add("part_desc", typeof(string));
            dtValues.Columns.Add("no_ref", typeof(string));
            dtValues.Columns.Add("stock_hand", typeof(double));
            dtValues.Columns.Add("qty", typeof(double));
            dtValues.Columns.Add("qtypo", typeof(double));
            dtValues.Columns.Add("SatQty", typeof(string));
            dtValues.Columns.Add("dept_code", typeof(string));
            dtValues.Columns.Add("DeliDate", typeof(DateTime));
            dtValues.Columns.Add("Remark", typeof(string));            
            dtValues.Columns.Add("nomor", typeof(int));

            return dtValues;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lbl_form_name.Text = "Purchase Request";
                dtp_from.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
                dtp_to.SelectedDate = DateTime.Now;
                selected_project = public_str.site;
                cb_proj_prm.Text = public_str.sitename;

                tr_code = null;
                Session["action"] = "firstLoad";
                Session["TableDetail"] = null;
                Session["actionDetail"] = null;
                Session["actionHeader"] = null;
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
                    RadGrid1.Rebind();
                }
                else if (e.Argument == "RebindAndNavigate")
                {
                    RadGrid1.MasterTableView.SortExpressions.Clear();
                    RadGrid1.MasterTableView.GroupByExpressions.Clear();
                    RadGrid1.DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), selected_project);
                    RadGrid1.DataBind();
                    //RadGrid1.Rebind();
                    RadGrid1.MasterTableView.CurrentPageIndex = RadGrid1.MasterTableView.PageCount - 1;
                    RadGrid1.MasterTableView.Items[RadGrid1.Items.Count - 1].Selected = true;
                    //RadGrid2.DataSource = new string[] { };
                    //RadGrid2.DataSource = GetDataRefDetailTable(selected_reff_no);
                    //RadGrid2.DataSource = GetDataDetailTable(tr_code);
                    //RadGrid2.Rebind();
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
            RadGrid1.DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), selected_project);
            RadGrid1.DataBind();
            if (RadGrid1.MasterTableView.Items.Count > 0)
            {
                RadGrid1.MasterTableView.Items[0].Selected = true;
                //populate_detail();
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
                selected_project = (sender as RadComboBox).SelectedValue;
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
            (sender as RadGrid).DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), selected_project);
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
            foreach (GridDataItem item in RadGrid1.SelectedItems)
            {
                tr_code = item["doc_code"].Text;
                selected_cost_ctr = item["dept_code"].Text;
            }

            Session["actionEdit"] = "list";

        }
        protected void RadGrid1_ItemCreated(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                //ImageButton editLink = (ImageButton)e.Item.FindControl("EditLink");
                //editLink.Attributes["href"] = "javascript:void(0);";
                //editLink.Attributes["onclick"] = String.Format("return ShowEditForm('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pr_code"], e.Item.ItemIndex);

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

                foreach (GridDataItem gItem in RadGrid1.SelectedItems)
                {
                    tr_code = gItem["pr_code"].Text;
                    selected_cost_ctr = gItem["dept_code"].Text;
                }
            }
        }
        protected void RadGrid1_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                GridDataItem item = e.Item as GridDataItem;
                string kode = item["pr_code"].Text;
                tr_code = kode;

                Session["actionHeader"] = "headerEdit";
                Session["actionDetail"] = null;
            }
        }
        protected void btnNew_Click(object sender, ImageClickEventArgs e)
        {
            Session["TableDetail"] = null;
            Session["actionHeader"] = "headerNew";
            RadGrid1.MasterTableView.IsItemInserted = true;
            RadGrid1.MasterTableView.Rebind();

                        
            //foreach(GridDataItem item in RadGrid1.MasterTableView.Items)
            //{
            //    cb_priority = (RadComboBox)item.FindControl("cb_priority");
            //    dtp_pr = (RadDatePicker)item.FindControl("dtp_pr");
            //    cb_type_ref = (RadComboBox)item.FindControl("cb_type_ref");
            //    cb_project = (RadComboBox)item.FindControl("cb_project");

            //    cb_priority.Text = "High/Urgent";
            //    dtp_pr.SelectedDate = DateTime.Today;
            //    cb_type_ref.Text = "Reservation";
            //    cb_type_ref.Enabled = false;
            //    cb_project.Text = public_str.sitename;
            //}
            
        }

        #endregion

        #region Detail
        protected void RadGrid2_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            if (Session["TableDetail"] == null && Session["actionHeader"].ToString() != "headerEdit") // Insert Session
            {
                (sender as RadGrid).DataSource = new string[] { };
            }
            else
            {
                if (Session["actionHeader"].ToString() == "headerEdit" && Session["actionDetail"] == null)
                {
                    Session["TableDetail"] = null;
                    (sender as RadGrid).DataSource = GetDataDetailTable(tr_code);
                }
                else if (Session["TableDetail"] == null)
                {
                    DetailDtbl();
                }
                else
                {
                    dtValues = (DataTable)Session["TableDetail"];
                }
                (sender as RadGrid).DataSource = dtValues; //populate RadGrid with datatable
                Session["TableDetail"] = dtValues;
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

            //DataTable DT = new DataTable();
            dtValues = new DataTable();

            try
            {
                sda.Fill(dtValues);
            }
            finally
            {
                con.Close();
            }

            return dtValues;
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
                (sender as RadGrid).DataBind();

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
                cmd.CommandText = "SELECT [part_code], [part_desc],[doc_code],[qtyRema],[part_unit],[date_exec],[dept_code],[remark] FROM "+
                    "[v_purchase_request_reff_typeA] WHERE [part_code] = '" + (sender as RadComboBox).SelectedValue + "'";

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                foreach (DataRow dtr in dt.Rows)
                {
                    RadComboBox cb = (RadComboBox)sender;
                    GridEditableItem item = (GridEditableItem)cb.NamingContainer;

                    if (Session["actionDetail"].ToString() == "detailNew")
                    {
                        
                        Label lb_reff = (Label)item.FindControl("lblRS_insert");
                        RadNumericTextBox tx_qty = (RadNumericTextBox)item.FindControl("txtPartQty_insert");
                        Label lb_uom = (Label)item.FindControl("lblUom_insert");
                        Label lb_cost_ctr = (Label)item.FindControl("lblCostCtr_insert");
                        Label lb_qty_po = (Label)item.FindControl("lblQtyPo_insert");
                        Label lb_soh = (Label)item.FindControl("lblSoh_insert");
                        RadDatePicker dt_deliv_date = (RadDatePicker)item.FindControl("dtpDelivDate_insert");
                        RadTextBox tx_remark = (RadTextBox)item.FindControl("txtRemark_d_insert");

                        lb_reff.Text = dtr["doc_code"].ToString();
                        tx_qty.Text = dtr["qtyRema"].ToString();
                        lb_uom.Text = dtr["part_unit"].ToString();
                        lb_cost_ctr.Text = dtr["dept_code"].ToString();
                        lb_qty_po.Text = string.Format("{0:#,###,##0.00}", 0);
                        lb_soh.Text = string.Format("{0:#,###,##0.00}", 0);
                        dt_deliv_date.SelectedDate = Convert.ToDateTime(dtr["date_exec"].ToString());
                        tx_remark.Text = dtr["remark"].ToString();
                    }
                    else if (Session["actionDetail"].ToString() == "detailEdit")
                    {
                        Label lb_reff = (Label)item.FindControl("lblRS_edit");
                        RadNumericTextBox tx_qty = (RadNumericTextBox)item.FindControl("txtPartQty_edit");
                        Label lb_uom = (Label)item.FindControl("lblUom_edit");
                        Label lb_cost_ctr = (Label)item.FindControl("lblCostCtr_edit");
                        Label lb_qty_po = (Label)item.FindControl("lblQtyPo_edit");
                        Label lb_soh = (Label)item.FindControl("lblSoh_edit");
                        RadDatePicker dt_deliv_date = (RadDatePicker)item.FindControl("dtpDelivDate_edit");
                        RadTextBox tx_remark = (RadTextBox)item.FindControl("txtRemark_d_edit");

                        lb_reff.Text = dtr["doc_code"].ToString();
                        tx_qty.Text = dtr["qtyRema"].ToString();
                        lb_uom.Text = dtr["part_unit"].ToString();
                        lb_cost_ctr.Text = dtr["dept_code"].ToString();
                        lb_qty_po.Text = string.Format("{0:#,###,##0.00}", 0);
                        lb_soh.Text = string.Format("{0:#,###,##0.00}", 0);
                        dt_deliv_date.SelectedDate = Convert.ToDateTime(dtr["date_exec"].ToString());
                        tx_remark.Text = dtr["remark"].ToString();
                    }
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
        protected void RadGrid2_UpdateCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                GridEditableItem item = (GridEditableItem)e.Item;

                dtValues = (DataTable)Session["TableDetail"];
                DataRow drValue = dtValues.Rows[0];
                drValue["Prod_code"] = (item.FindControl("cb_prod_code") as Label).Text;
                drValue["part_desc"] = "";
                drValue["no_ref"] = (item.FindControl("lblRS") as Label).Text;
                drValue["qty"] = (item.FindControl("txtPartQty") as RadNumericTextBox).Value;
                drValue["stock_hand"] = (item.FindControl("lblSoh_insert") as Label).Text;
                drValue["qtypo"] = (item.FindControl("lblQtyPo") as Label).Text;
                drValue["SatQty"] = (item.FindControl("lblUom") as Label).Text;
                drValue["dept_code"] = (item.FindControl("lblCostCtr") as Label).Text;
                drValue["DeliDate"] = (item.FindControl("dtpDelivDate") as RadDatePicker).SelectedDate;
                drValue["Remark"] = (item.FindControl("txtRemark_d") as RadTextBox).Text;
                //drValue["nomor"] = 0;

                drValue.EndEdit(); //editing row in datatable
                dtValues.AcceptChanges();
                Session["TableDetail"] = dtValues;
                (sender as RadGrid).Rebind();

            }
            catch (Exception ex)
            {
                //con.Close();
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
                e.Canceled = true;
            }
        }
        protected void RadGrid2_InsertCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                GridEditableItem item = (GridEditableItem)e.Item;

                if (Session["actionDetail"].ToString() == "detailNew" && Session["TableDetail"] == null)
                {
                    DetailDtbl();

                    (sender as RadGrid).DataSource = dtValues; //populate RadGrid with datatable
                    Session["TableDetail"] = dtValues;
                }

                dtValues = (DataTable)Session["TableDetail"];
                DataRow drValue = dtValues.NewRow();
                drValue["Prod_code"] = (item.FindControl("cb_prod_code_insert") as RadComboBox).Text;
                drValue["part_desc"] = "";
                drValue["no_ref"] = (item.FindControl("lblRS_insert") as Label).Text;
                drValue["qty"] = (item.FindControl("txtPartQty_insert") as RadNumericTextBox).Value;
                drValue["stock_hand"] = (item.FindControl("lblSoh_insert") as Label).Text;
                drValue["qtypo"] = (item.FindControl("lblQtyPo_insert") as Label).Text;
                drValue["SatQty"] = (item.FindControl("lblUom_insert") as Label).Text;
                drValue["dept_code"] = (item.FindControl("lblCostCtr_insert") as Label).Text;
                drValue["DeliDate"] = (item.FindControl("dtpDelivDate_insert") as RadDatePicker).SelectedDate;
                drValue["Remark"] = (item.FindControl("txtRemark_d_insert") as RadTextBox).Text;
                drValue["nomor"] = 0;

                dtValues.Rows.Add(drValue); //adding new row into datatable
                dtValues.AcceptChanges();
                Session["TableDetail"] = dtValues;
                (sender as RadGrid).Rebind();
                Session["actionDetail"] = "detailList";

            }
            catch (Exception ex)
            {
                //con.Close();
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
                e.Canceled = true;
            }
            
            //try
            //{
            //    foreach (GridDataItem gItem in RadGrid1.SelectedItems)
            //    {
            //        tr_code = gItem["pr_code"].Text;
            //        selected_cost_ctr = gItem["dept_code"].Text;
            //    }
            //    con.Open();
            //    GridEditableItem item = (GridEditableItem)e.Item;                   
            //    cmd = new SqlCommand();
            //    cmd.CommandType = CommandType.StoredProcedure;
            //    cmd.Connection = con;
            //    cmd.CommandText = "sp_save_purchase_requestD";
            //    cmd.Parameters.AddWithValue("@prod_type", "M1");
            //    cmd.Parameters.AddWithValue("@Prod_code", (item.FindControl("cb_prod_code") as RadComboBox).Text);
            //    cmd.Parameters.AddWithValue("@no_ref", (item.FindControl("lblRS") as Label).Text);
            //    cmd.Parameters.AddWithValue("@qty", Convert.ToDouble((item.FindControl("txtPartQty") as RadTextBox).Text));
            //    cmd.Parameters.AddWithValue("@SatQty", (item.FindControl("lblUom") as Label).Text);
            //    cmd.Parameters.AddWithValue("@DeliDate", string.Format("{0:yyyy-MM-dd}", (item.FindControl("dtpDelivDate") as RadDatePicker).SelectedDate));
            //    cmd.Parameters.AddWithValue("@Remark", (item.FindControl("txtRemark_d") as RadTextBox).Text);
            //    cmd.Parameters.AddWithValue("@pr_code", tr_code);
            //    cmd.Parameters.AddWithValue("@stock_hand", Convert.ToDouble((item.FindControl("lblSoh") as Label).Text));
            //    cmd.Parameters.AddWithValue("@Prod_code_ori", (item.FindControl("cb_prod_code") as RadComboBox).Text);
            //    cmd.Parameters.AddWithValue("@dept_code", (item.FindControl("lblCostCtr") as Label).Text);
            //    cmd.ExecuteNonQuery();
            //    con.Close();
                
            //    notif.Show();
            //}
            //catch (Exception ex)
            //{
            //    con.Close();
            //    RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
            //    e.Canceled = true;
            //}
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

        //private void populate_detail()
        //{
        //    foreach (GridDataItem item in RadGrid1.SelectedItems)
        //    {
        //        tr_code = item["pr_code"].Text;
        //        selected_cost_ctr = item["dept_code"].Text;
        //    }

        //    if (tr_code == null)
        //    {
        //        RadGrid2.DataSource = new string[] { };
        //    }
        //    else
        //    {
        //        RadGrid2.DataSource = GetDataDetailTable(tr_code);
        //    }

        //    RadGrid2.DataBind();
        //}
        #endregion
       
        protected void GridSort()
        {
            GridSortExpression expression = new GridSortExpression();
            expression.FieldName = "pr_code";
            expression.SortOrder = GridSortOrder.Descending;
            RadGrid1.MasterTableView.SortExpressions.AddSortExpression(expression);
            RadGrid1.MasterTableView.Rebind();
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridEditableItem item = (GridEditableItem)btn.NamingContainer;

            txt_doc_code = (RadTextBox)item.FindControl("txt_doc_code");
            cb_priority = (RadComboBox)item.FindControl("cb_priority");
            dtp_pr = (RadDatePicker)item.FindControl("dtp_pr");
            cb_type_ref = (RadComboBox)item.FindControl("cb_type_ref");
            cb_project = (RadComboBox)item.FindControl("cb_project");
            cb_warehouse = (RadComboBox)item.FindControl("cb_warehouse");
            cb_cost_ctr = (RadComboBox)item.FindControl("cb_cost_ctr");
            txt_remark = (RadTextBox)item.FindControl("txt_remark");
            cb_prepare_by = (RadComboBox)item.FindControl("cb_prepare_by");
            cb_orderBy = (RadComboBox)item.FindControl("cb_orderBy");
            cb_checked = (RadComboBox)item.FindControl("cb_checked");
            cb_approved = (RadComboBox)item.FindControl("cb_approved");            
            btnCancel = (Button)item.FindControl("btnCancel");
            Grid2 = (RadGrid)item.FindControl("RadGrid2");


            long maxNo;
            string run = null;
            string trDate = string.Format("{0:dd/MM/yyyy}", dtp_pr.SelectedDate);

            try
            {
                if ((sender as Button).Text == "Update")
                {
                    run = txt_doc_code.Text;
                }
                else
                {
                    con.Open();
                    SqlDataReader sdr;
                    cmd = new SqlCommand("SELECT ISNULL ( MAX ( RIGHT ( pur01h01.pr_code , 4 ) ) , 0 ) + 1 AS maxNo " +
                        "FROM pur01h01 WHERE LEFT(pur01h01.pr_code, 4) = 'PR01' " +
                        "AND SUBSTRING(pur01h01.pr_code, 5, 2) = SUBSTRING('" + trDate + "', 9, 2) " +
                        "AND SUBSTRING(pur01h01.pr_code, 7, 2) = SUBSTRING('" + trDate + "', 4, 2) ", con);
                    sdr = cmd.ExecuteReader();
                    if (sdr.HasRows == false)
                    {
                        //throw new Exception();
                        run = "PR01" + dtp_pr.SelectedDate.Value.Year + dtp_pr.SelectedDate.Value.Month + "0001";
                    }
                    else if (sdr.Read())
                    {
                        maxNo = Convert.ToInt32(sdr[0].ToString());
                        run = "PR01" + (dtp_pr.SelectedDate.Value.Year.ToString()).Substring(dtp_pr.SelectedDate.Value.Year.ToString().Length - 2) +
                            ("0000" + dtp_pr.SelectedDate.Value.Month).Substring(("0000" + dtp_pr.SelectedDate.Value.Month).Length - 2, 2) +
                            ("0000" + maxNo).Substring(("0000" + maxNo).Length - 4, 4);
                    }
                    con.Close();
                }

                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_save_purchase_requestH";
                cmd.Parameters.AddWithValue("@pr_code", run);
                cmd.Parameters.AddWithValue("@Pr_date", string.Format("{0:yyyy-MM-dd}", dtp_pr.SelectedDate.Value));
                cmd.Parameters.AddWithValue("@type_source", cb_type_ref.SelectedValue);
                cmd.Parameters.AddWithValue("@ctrl_no", DBNull.Value);
                cmd.Parameters.AddWithValue("@priority", cb_priority.SelectedValue);
                cmd.Parameters.AddWithValue("@wh_code", cb_warehouse.SelectedValue);
                cmd.Parameters.AddWithValue("@remark", txt_remark.Text);
                cmd.Parameters.AddWithValue("@FreBy", cb_prepare_by.SelectedValue);
                cmd.Parameters.AddWithValue("@OrdBy", cb_orderBy.SelectedValue);
                cmd.Parameters.AddWithValue("@CekBy", cb_checked.SelectedValue);
                cmd.Parameters.AddWithValue("@AppBy", cb_approved.SelectedValue);
                cmd.Parameters.AddWithValue("@region_code", cb_project.SelectedValue);
                cmd.Parameters.AddWithValue("@userid", public_str.user_id);
                cmd.Parameters.AddWithValue("@dept_code", cb_cost_ctr.SelectedValue);
                cmd.Parameters.AddWithValue("@unit_code", DBNull.Value);
                cmd.Parameters.AddWithValue("@model_no", DBNull.Value);
                cmd.Parameters.AddWithValue("@time_reading", DBNull.Value);
                cmd.Parameters.AddWithValue("@type_pr", "A");
                cmd.Parameters.AddWithValue("@Lvl", public_str.level);
                cmd.Parameters.AddWithValue("@doc_type", 1);
                cmd.Parameters.AddWithValue("@asset_id", "NON");
                cmd.ExecuteNonQuery();


                foreach (GridDataItem itemD in Grid2.MasterTableView.Items)
                {
                    Label lbl_prod_code;
                    Label lbl_soh;
                    Label lbl_part_qty;
                    Label lbl_uom;
                    Label lbl_remark;
                    Label lbl_dept_code;
                    //CheckBox chkWaranty;
                    Label lbl_rs;
                    RadDatePicker dtpDelivDate;
                    
                    lbl_prod_code = (Label)itemD.FindControl("lbl_prod_code");
                    lbl_soh = (Label)itemD.FindControl("lblSoh");
                    lbl_part_qty = (Label)itemD.FindControl("lblPartQty");
                    lbl_uom = (Label)itemD.FindControl("lblUom");
                    lbl_remark = (Label)itemD.FindControl("lblRemark_d");
                    lbl_dept_code = (Label)itemD.FindControl("lblCostCtr");
                    //chkWaranty = (CheckBox)itemD.FindControl("chk_waranty");
                    lbl_rs = (Label)itemD.FindControl("lblRS");
                    dtpDelivDate = (RadDatePicker)itemD.FindControl("dtpDelivDate");


                    //con.Open();
                    //GridEditableItem item = (GridEditableItem)e.Item;
                    cmd = new SqlCommand();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Connection = con;
                    cmd.CommandText = "sp_save_purchase_requestD";
                    cmd.Parameters.AddWithValue("@prod_type", "M1");
                    cmd.Parameters.AddWithValue("@Prod_code", lbl_prod_code.Text);
                    cmd.Parameters.AddWithValue("@no_ref", lbl_rs.Text);
                    cmd.Parameters.AddWithValue("@qty", Convert.ToDouble(lbl_part_qty.Text));
                    cmd.Parameters.AddWithValue("@SatQty", lbl_uom.Text);
                    cmd.Parameters.AddWithValue("@DeliDate", dtpDelivDate.SelectedDate);
                    cmd.Parameters.AddWithValue("@Remark", lbl_remark.Text);
                    cmd.Parameters.AddWithValue("@pr_code", tr_code);
                    cmd.Parameters.AddWithValue("@stock_hand", Convert.ToDouble(lbl_soh.Text));
                    cmd.Parameters.AddWithValue("@Prod_code_ori", lbl_prod_code.Text);
                    cmd.Parameters.AddWithValue("@dept_code", lbl_dept_code.Text);
                    cmd.ExecuteNonQuery();


                }

            }
            catch (Exception ex)
            {
                con.Close();
                //Response.Write("<font color='red'>" + ex.Message + "</font>");
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "");
                //RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn","");
            }
            finally
            {
                con.Close();
                notif.Text = "Data berhasil disimpan";
                notif.Title = "Notification";
                notif.Show();
                txt_doc_code.Text = run;

                if ((sender as Button).Text == "Update")
                {
                    ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind();", true);
                }
                else
                {
                    tr_code = run;
                    selected_project = cb_project.SelectedValue;
                    ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind('navigateToInserted');", true);
                    (sender as Button).Text = "Update";
                    btnCancel.Text = "Close";
                }
            }
        }

        #region Priority 
        private static DataTable GetPriority(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT priority_code , prio_desc FROM pur00h06 WHERE prio_desc LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }

        protected void cb_priority_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetPriority(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["prio_desc"].ToString(), data.Rows[i]["prio_desc"].ToString()));
            }

            e.Message = GetStatusMessage(endOffset, data.Rows.Count);
        }

        protected void cb_priority_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT priority_code FROM pur00h06 WHERE prio_desc = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            }
            dr.Close();
            con.Close();
        }
        protected void cb_priority_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT priority_code FROM pur00h06 WHERE prio_desc = '" + (sender as RadComboBox).Text + "'";
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
        #region Reff Type
        protected void cb_type_ref_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadComboBox).Text == "Reservation")
            {
                (sender as RadComboBox).SelectedValue = "1";
            }
            else if ((sender as RadComboBox).Text == "Manual")
            {
                (sender as RadComboBox).SelectedValue = "2";
            }
        }
        protected void cb_type_ref_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Add("Reservation");
            (sender as RadComboBox).Items.Add("Manual");
        }
        protected void cb_type_ref_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if ((sender as RadComboBox).Text == "Reservation")
            {
                (sender as RadComboBox).SelectedValue = "1";
            }
            else if ((sender as RadComboBox).Text == "Manual")
            {
                (sender as RadComboBox).SelectedValue = "2";
            }
        }
        #endregion
        #region Project
        private static DataTable GetProject(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT region_code, region_name FROM inv00h09 WHERE stEdit != 4 AND region_name LIKE @text + '%' ",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_project_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {

            DataTable data = GetProject(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["region_name"].ToString(), data.Rows[i]["region_name"].ToString()));
            }
        }
        //protected void cb_project_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        //{
        //    con.Open();
        //    SqlCommand cmd = new SqlCommand();
        //    cmd.Connection = con;
        //    cmd.CommandType = CommandType.Text;
        //    cmd.CommandText = "SELECT region_code FROM inv00h09 WHERE region_name = '" + (sender as RadComboBox).Text + "'";
        //    SqlDataReader dr;
        //    dr = cmd.ExecuteReader();
        //    while (dr.Read())
        //    {
        //        (sender as RadComboBox).SelectedValue = dr[0].ToString();
        //    }
        //    dr.Close();
        //    con.Close();

        //}

        protected void cb_project_PreRender(object sender, EventArgs e)
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
        #region Warehouse / Storage 
        private static DataTable GetWarehouse(string text, string project)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT wh_code, wh_name FROM inv00h05 WHERE stEdit != 4 AND PlantCode = @PlantCode AND wh_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@PlantCode", project);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_warehouse_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetWarehouse(e.Text, selected_project);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["wh_name"].ToString(), data.Rows[i]["wh_name"].ToString()));
            }
        }

        protected void cb_warehouse_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT wh_code FROM inv00h05 WHERE wh_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            }
            dr.Close();
            con.Close();
        }

        protected void cb_warehouse_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT wh_code FROM inv00h05 WHERE wh_name = '" + (sender as RadComboBox).Text + "'";
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

        #region Cost Center
        protected void LoadCostCtr(string name, string projectID, RadComboBox cb)
        {
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);

            SqlDataAdapter adapter = new SqlDataAdapter("SELECT upper(CostCenter) as code,upper(CostCenterName) as name FROM inv00h11 " +
                "WHERE stEdit <> '4' AND region_code = @project AND CostCenterName LIKE @text + '%'", con);
            adapter.SelectCommand.Parameters.AddWithValue("@project", projectID);
            adapter.SelectCommand.Parameters.AddWithValue("@text", name);
            DataTable dt = new DataTable();
            adapter.Fill(dt);

            cb.DataTextField = "name";
            cb.DataValueField = "code";
            cb.DataSource = dt;
            cb.DataBind();
        }
        protected void cb_cost_ctr_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadCostCtr(e.Text, selected_project, (sender as RadComboBox));

        }
        protected void cb_cost_ctr_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT CostCenter FROM inv00h11 WHERE CostCenterName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["CostCenter"].ToString();
            }
            dr.Close();
            con.Close();
        }
        protected void cb_cost_ctr_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT CostCenter FROM inv00h11 WHERE CostCenterName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["CostCenter"].ToString();
            dr.Close();
            con.Close();
        }
        #endregion

        #region Approval
        protected void LoadManPower(string name, string projectID, RadComboBox cb)
        {
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);

            SqlDataAdapter adapter = new SqlDataAdapter("SELECT upper(name) as name, nik, upper(jabatan) as jabatan FROM inv00h26 " +
                "WHERE stedit <> '4' AND region_code = @project AND name LIKE @text + '%'", con);
            adapter.SelectCommand.Parameters.AddWithValue("@project", projectID);
            adapter.SelectCommand.Parameters.AddWithValue("@text", name);
            DataTable dt = new DataTable();
            adapter.Fill(dt);

            cb.DataTextField = "name";
            cb.DataValueField = "nik";
            cb.DataSource = dt;
            cb.DataBind();
        }
        protected void cb_prepare_by_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadManPower(e.Text, selected_project, (sender as RadComboBox));
        }
        protected void cb_prepare_by_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["nik"].ToString();
            }
            dr.Close();
            con.Close();

        }
        protected void cb_prepare_by_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["nik"].ToString();
            }

            dr.Close();
            con.Close();
        }
        protected void cb_orderBy_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadManPower(e.Text, selected_project, (sender as RadComboBox));
        }
        protected void cb_orderBy_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["nik"].ToString();
            }

            dr.Close();
            con.Close();
        }
        protected void cb_orderBy_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["nik"].ToString();
            }

            dr.Close();
            con.Close();
        }
        protected void cb_received_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["nik"].ToString();
            }

            dr.Close();
            con.Close();
        }
        protected void cb_received_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadManPower(e.Text, selected_project, (sender as RadComboBox));
        }
        protected void cb_received_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["nik"].ToString();
            }

            dr.Close();
            con.Close();
        }
        protected void cb_approved_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadManPower(e.Text, selected_project, (sender as RadComboBox));
        }
        protected void cb_approved_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["nik"].ToString();
            }

            dr.Close();
            con.Close();
        }
        protected void cb_approved_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["nik"].ToString();
            }

            dr.Close();
            con.Close();
        }


        #endregion

        protected void RadGrid2_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == RadGrid.InitInsertCommandName)
            {
                Session["actionDetail"] = "detailNew";
            }
            else if (e.CommandName == RadGrid.EditCommandName)
            {
                Session["actionDetail"] = "detailEdit";
            }
        }

       
    }
}