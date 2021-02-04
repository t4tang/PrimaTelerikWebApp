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

namespace TelerikWebApplication.Form.Preventive_maintenance.MaterialRequest
{
    public partial class inv01h02 : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();

        private const int ItemsPerRequest = 10;
        public static string tr_code = null;
        public static string wo_code = null;
        public static string selected_project = null;
        public static string chartCode_selected;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lbl_form_name.Text = "Material Request";
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
                    RadGrid1.Rebind(); 
                    RadGrid1.MasterTableView.Items[0].Selected = true;

                }
                else if (e.Argument == "RebindAndNavigate")
                {
                    RadGrid1.MasterTableView.SortExpressions.Clear();
                    RadGrid1.MasterTableView.GroupByExpressions.Clear();
                    RadGrid1.DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), selected_project);
                    RadGrid1.DataBind();
                    RadGrid1.MasterTableView.CurrentPageIndex = RadGrid1.MasterTableView.PageCount - 1;

                    RadGrid1.MasterTableView.Items[RadGrid1.Items.Count - 1].Selected = true;
                    RadGrid3.DataSource = new string[] { };
                    RadGrid3.Rebind();
                    
                    Session["action"] = "list";
                    //btnInsertItem.Enabled = true;
                }
            }
            catch (Exception ex)
            {
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
            }
        }

        protected void RadGrid1_PreRender(object sender, EventArgs e)
        {
            if (Session["action"].ToString() == "firstLoad")
            {
                if ((sender as RadGrid).MasterTableView.Items.Count > 0)
                    (sender as RadGrid).MasterTableView.Items[0].Selected = true;

                //btnInsertItem.Enabled = true;

                foreach (GridDataItem item in RadGrid1.SelectedItems)
                {
                    tr_code = item["sro_code"].Text;
                    wo_code = item["trans_id"].Text;
                }

                //if(RadGrid3.MasterTableView.IsItemInserted == false)
                //{
                //    populate_detail();
                //}
            }
        }

        #region project param
        private static DataTable GetProjectPrm(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT region_code, region_name FROM inv00h09 WHERE stEdit != 4 AND region_name LIKE @text + '%' UNION SELECT 'ALL','ALL'",
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
            cmd.CommandText = "SELECT region_code FROM inv00h09 WHERE region_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();

        }
        #endregion

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            RadGrid1.DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), cb_proj_prm.SelectedValue);
            RadGrid1.DataBind();
        }

        private void populate_detail()
        {
            RadGrid3.DataSource = new string[] { };

            if (tr_code == null || RadGrid1.MasterTableView.IsItemInserted == true)
            {
                RadGrid3.DataSource = new string[] { };
            }           
            else
            {                
                RadGrid3.DataSource = GetDataDetailTable(tr_code);
            }
            
            RadGrid3.DataBind();
        }

        private static string GetStatusMessage(int offset, int total)
        {
            if (total <= 0)
                return "No matches";

            return String.Format("Items <b>1</b>-<b>{0}</b> out of <b>{1}</b>", offset, total);
        }

        public DataTable GetDataTable(string fromDate, string toDate, string project)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_material_requestH";
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

        protected void RadGrid1_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            (sender as RadGrid).DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), cb_proj_prm.SelectedValue);
            
        }

        protected void RadGrid1_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            var sro_code = ((GridDataItem)e.Item).GetDataKeyValue("sro_code");

            try
            {
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "UPDATE inv01h02 SET userid = @userid, lastupdate = GETDATE(), void = '4' WHERE (sro_code = @sro_code)";
                cmd.Parameters.AddWithValue("@sro_code", sro_code);
                cmd.Parameters.AddWithValue("@userid", public_str.user_id);
                cmd.ExecuteNonQuery();
                con.Close();

                Label lblOk = new Label();
                lblOk.Text = "Data deleted successfully";
                lblOk.ForeColor = System.Drawing.Color.Teal;
                RadGrid1.Controls.Add(lblOk);
            }
            catch (Exception ex)
            {
                con.Close();
                Label lblError = new Label();
                lblError.Text = "Unable to delete data. Reason: " + ex.Message;
                lblError.ForeColor = System.Drawing.Color.Red;
                RadGrid1.Controls.Add(lblError);
                e.Canceled = true;
            }
        }

        protected void RadGrid1_ItemCreated(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                //ImageButton editLink = (ImageButton)e.Item.FindControl("EditLink");
                //editLink.Attributes["href"] = "javascript:void(0);";
                //editLink.Attributes["onclick"] = String.Format("return ShowEditForm('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["sro_code"], e.Item.ItemIndex);

                ImageButton printLink = (ImageButton)e.Item.FindControl("PrintLink");
                printLink.Attributes["href"] = "javascript:void(0);";
                printLink.Attributes["onclick"] = String.Format("return ShowPreview('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["sro_code"], e.Item.ItemIndex);

            }
        }

        protected void RadGrid1_SelectedIndexChanged(object sender, EventArgs e)
        {
            foreach (GridDataItem item in RadGrid1.SelectedItems)
            {
                tr_code = item["sro_code"].Text;
                wo_code = item["trans_id"].Text;
            }

            populate_detail();
            Session["action"] = "list";
        }

        public DataTable GetDataDetailTable(string sro_code)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_material_requestD";
            cmd.Parameters.AddWithValue("@sro_code", sro_code);
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
        public DataTable GetDataOpertionTable(string trans_id)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT a.*, b.OprName FROM mtc01h03 a, mtc00h25 b WHERE a.chart_code = b.OprCode AND trans_id = @sro_code";
            cmd.Parameters.AddWithValue("@sro_code", trans_id);
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
                (sender as RadGrid).DataSource = GetDataOpertionTable(tr_code);
            }
        }

        protected void RadGrid2_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            var part_code = ((GridDataItem)e.Item).GetDataKeyValue("part_code");

            try
            {
                GridEditableItem item = (GridEditableItem)e.Item;
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "delete from inv01d02 where part_code = @part_code and sro_code = @sro_code";
                cmd.Parameters.AddWithValue("@sro_code", tr_code);
                cmd.Parameters.AddWithValue("@part_code", part_code);
                cmd.ExecuteNonQuery();
                con.Close();
                //RadGrid2.DataBind();

                Label lblsuccess = new Label();
                lblsuccess.Text = "Data deleted";
                lblsuccess.ForeColor = System.Drawing.Color.DarkGray;
                //RadGrid2.Controls.Add(lblsuccess);
            }
            catch (Exception ex)
            {
                con.Close();
                Label lblError = new Label();
                lblError.Text = "Unable to delete data. Reason: " + ex.Message;
                lblError.ForeColor = System.Drawing.Color.Red;
                //RadGrid2.Controls.Add(lblError);
                e.Canceled = true;
            }
        }

        protected void RadGrid3_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            if (tr_code == null || RadGrid1.MasterTableView.IsItemInserted == true)
            {
                (sender as RadGrid).DataSource = new string[] { };
            }
            else
            {
                (sender as RadGrid).DataSource = GetDataDetailTable(tr_code);
                //RadGrid3.MasterTableView.CommandItemSettings.ShowAddNewRecordButton = true;
            }
        }
        protected void btnNew_Click(object sender, ImageClickEventArgs e)
        {
            RadGrid1.MasterTableView.IsItemInserted = true;
            RadGrid1.MasterTableView.Rebind();

            RadGrid3.DataSource = new string[] { };
            RadGrid3.DataBind();
            //btnInsertItem.Enabled = false;

        }

        protected void cb_prod_code_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
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

                    RadNumericTextBox lblQtyRs;
                    Label lbl_UoM;
                    Label lbl_prodType;
                    RadNumericTextBox txtPartQty;

                    if (RadGrid3.MasterTableView.IsItemInserted)
                    {
                        lbl_prodType = (Label)item.FindControl("lbl_prodType_insertTemp");
                        txtPartQty = (RadNumericTextBox)item.FindControl("txt_qty_insertTemp");
                        lblQtyRs = (RadNumericTextBox)item.FindControl("txt_qtyRs_insertTemp");
                        lbl_UoM = (Label)item.FindControl("lbl_UoM_insertTemp");
                    }
                    else
                    {
                        lbl_prodType = (Label)item.FindControl("lbl_prodType_editTemp");
                        txtPartQty = (RadNumericTextBox)item.FindControl("txt_qty_editTemp");
                        lblQtyRs = (RadNumericTextBox)item.FindControl("txt_qtyRs_editTemp");
                        lbl_UoM = (Label)item.FindControl("lbl_UoM_editTemp");
                    }
                    
                    lbl_prodType.Text = "M1";
                    lblQtyRs.Text = "0";
                    lbl_UoM.Text = dtr["unit"].ToString();
                    txtPartQty.Value = 0;
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

        }

        protected void cb_prod_code_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            string sql = "SELECT TOP (100)[prod_code], [spec], [unit] FROM [inv00h01]  WHERE stEdit != '4' AND spec LIKE @spec + '%'";
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
                item.Attributes.Add("unit", row["unit"].ToString());

                comboBox.Items.Add(item);

                item.DataBind();
            }
        }

        protected void btnInsertItem_Click(object sender, EventArgs e)
        {
            if(RadGrid1.MasterTableView.IsItemInserted == false)
            {
                RadGrid3.MasterTableView.IsItemInserted = true;
                RadGrid3.MasterTableView.Rebind();
            }
        }
        
        protected void cb_operation_inserttTemp_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            string sql = "SELECT DISTINCT(mtc01h03.chart_code), mtc00h25.OprName FROM mtc01h03 INNER JOIN mtc00h25 ON mtc00h25.OprCode = mtc01h03.chart_code  WHERE mtc01h03.trans_id = @wo_code " +
                " AND OprName LIKE @OprName + '%'";
            SqlDataAdapter adapter = new SqlDataAdapter(sql,
                ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@wo_code", wo_code);
            adapter.SelectCommand.Parameters.AddWithValue("@OprName", e.Text);

            DataTable dt = new DataTable();
            adapter.Fill(dt);

            RadComboBox comboBox = (RadComboBox)sender;
            // Clear the default Item that has been re-created from ViewState at this point.
            comboBox.Items.Clear();

            foreach (DataRow row in dt.Rows)
            {
                RadComboBoxItem item = new RadComboBoxItem();
                item.Text = row["OprName"].ToString();
                item.Value = row["chart_code"].ToString();
                item.Attributes.Add("spec", row["OprName"].ToString());

                comboBox.Items.Add(item);

                item.DataBind();
            }
        }
        protected void cb_operation_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT OprCode FROM mtc00h25 WHERE OprName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                //(sender as RadComboBox).SelectedValue = dr[0].ToString();
                chartCode_selected = dr[0].ToString();
            dr.Close();
            con.Close();
        }
        protected void RadGrid3_InsertCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                GridEditableItem item = (GridEditableItem)e.Item;
                RadNumericTextBox lblQtyRs;
                Label lbl_UoM;
                Label lbl_prodType;
                RadNumericTextBox txtPartQty;
                RadComboBox cbProdCode;
                //RadComboBox cbChart;
                CheckBox chkWaranty;
                RadTextBox txtRemark;
                Label lblChart;

                if (RadGrid3.MasterTableView.IsItemInserted)
                {
                    lbl_prodType = (Label)item.FindControl("lbl_prodType_insertTemp");
                    txtPartQty = (RadNumericTextBox)item.FindControl("txt_qty_insertTemp");
                    lblQtyRs = (RadNumericTextBox)item.FindControl("txt_qtyRs_insertTemp");
                    lbl_UoM = (Label)item.FindControl("lbl_UoM_insertTemp");
                    cbProdCode = (RadComboBox)item.FindControl("cb_prod_code_insertTemp");
                    //cbChart = (RadComboBox)item.FindControl("cb_operation_insertTemp");
                    chkWaranty = (CheckBox)item.FindControl("chk_waranty_insertTemp");
                    txtRemark = (RadTextBox)item.FindControl("txt_remark_insertTemp");
                }
                else
                {
                    lbl_prodType = (Label)item.FindControl("lbl_prodType_editTemp");
                    txtPartQty = (RadNumericTextBox)item.FindControl("txt_qty_editTemp");
                    lblQtyRs = (RadNumericTextBox)item.FindControl("txt_qtyRs_editTemp");
                    lbl_UoM = (Label)item.FindControl("lbl_UoM_editTemp");
                    cbProdCode = (RadComboBox)item.FindControl("cb_prod_code_editTemp");
                    //cbChart = (RadComboBox)item.FindControl("cb_operation_editTemp");
                    chkWaranty = (CheckBox)item.FindControl("chk_waranty_editTemp");
                    txtRemark = (RadTextBox)item.FindControl("txt_remark_editTemp");
                    lblChart = (Label)item.FindControl("lbl_operation");
                }

                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_save_material_requestD";
                cmd.Parameters.AddWithValue("@prod_type", lbl_prodType.Text);
                cmd.Parameters.AddWithValue("@item", DBNull.Value);
                cmd.Parameters.AddWithValue("@part_qty", Convert.ToDouble(txtPartQty.Text));
                cmd.Parameters.AddWithValue("@sro_code", tr_code);
                cmd.Parameters.AddWithValue("@part_code", cbProdCode.Text);
                cmd.Parameters.AddWithValue("@part_unit", lbl_UoM.Text);
                cmd.Parameters.AddWithValue("@chart_code", chartCode_selected);
                cmd.Parameters.AddWithValue("@trans_id", wo_code);
                cmd.Parameters.AddWithValue("@deliv_date", DBNull.Value);
                if (chkWaranty.Checked == true)
                {
                    cmd.Parameters.AddWithValue("@tWarranty", 1);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@tWarranty", 0);
                }
                cmd.Parameters.AddWithValue("@remark", txtRemark.Text);
                cmd.ExecuteNonQuery();


                //notif.Show();

            }
            catch (Exception ex)
            {
                con.Close();
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
                e.Canceled = true;
            }
            finally
            {
                con.Close();
                //RadGrid3.DataSource = GetDataDetailByChartCode(txt_mr_number.Text, chart_code);
                //RadGrid3.DataBind();
            }
        }

        protected void RadGrid1_UpdateCommand(object sender, GridCommandEventArgs e)
        {
            populate_detail();
        }

        protected void RadGrid1_EditCommand(object sender, GridCommandEventArgs e)
        {
            GetDataDetailTable(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["sro_code"].ToString());
            //wo_code = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["trans_id"].ToString();
        }

        protected void RadGrid3_EditCommand(object sender, GridCommandEventArgs e)
        {
            GridEditableItem item = (GridEditableItem)e.Item;

            Label lblChart;
            //RadComboBox cbChart;
            //cbChart = (RadComboBox)item.FindControl("cb_operation_editTemp");
            lblChart = (Label)item.FindControl("lbl_operation");

            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT OprCode FROM mtc00h25 WHERE OprName = '" + lblChart.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                chartCode_selected = dr["OprCode"].ToString();
            }
                
            dr.Close();
            con.Close();

        }

        protected void RadGrid3_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                con.Open();
                GridEditableItem item = (GridEditableItem)e.Item;
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "DELETE inv01d02 WHERE part_code = @part_code AND sro_code = @sro_code ";
                cmd.Parameters.AddWithValue("@sro_code", tr_code);
                cmd.Parameters.AddWithValue("@part_code", (item.FindControl("lbl_partCode") as Label).Text);

                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                con.Close();
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
                e.Canceled = true;
            }
            finally
            {
                con.Close();
            }
        }
        
    }
}