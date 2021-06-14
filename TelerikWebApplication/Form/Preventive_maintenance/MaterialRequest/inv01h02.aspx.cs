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
        DataTable dtValues;

        public DataTable DetailDtbl()
        {
            dtValues = new DataTable();
            dtValues.Columns.Add("sro_code", typeof(string));
            dtValues.Columns.Add("chart_code", typeof(string));
            dtValues.Columns.Add("OprName", typeof(string));
            dtValues.Columns.Add("prod_type", typeof(string));
            dtValues.Columns.Add("part_code", typeof(string));
            dtValues.Columns.Add("part_qty", typeof(double));
            dtValues.Columns.Add("qty_pr", typeof(double));
            dtValues.Columns.Add("part_unit", typeof(string));
            dtValues.Columns.Add("tWarranty", typeof(bool));
            dtValues.Columns.Add("remark", typeof(string));
            dtValues.Columns.Add("run", typeof(int));

            return dtValues;
        }
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
                    //RadGrid3.DataSource = new string[] { };
                    //RadGrid3.Rebind();
                    
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
                    if(tr_code == null)
                    {
                        tr_code = item["sro_code"].Text;
                        wo_code = item["trans_id"].Text;
                    }
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
            
            Session["actionEdit"] = "list";
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
            //dtValues = new DataTable();

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
        //protected void RadGrid2_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        //{
        //    //if (tr_code == null && Session["TableDetail"] == null)
        //    //{
        //    //    (sender as RadGrid).DataSource = new string[] { };
        //    //}
        //    //else
        //    //{
        //    //    if (Session["TableDetail"] != null)
        //    //    {
        //    //        dtValues = new DataTable();
        //    //        dtValues.Columns.Add("trans_id", typeof(string));
        //    //        dtValues.Columns.Add("down_date", typeof(DateTime));
        //    //        dtValues.Columns.Add("down_time", typeof(DateTime));
        //    //        dtValues.Columns.Add("down_act", typeof(DateTime));
        //    //        dtValues.Columns.Add("down_up", typeof(DateTime));
        //    //        dtValues.Columns.Add("remark_activity", typeof(string));
        //    //        dtValues.Columns.Add("status", typeof(string));
        //    //        dtValues.Columns.Add("run", typeof(int));

        //            if (tr_code == null)
        //            {
        //                (sender as RadGrid).DataSource = new string[] { };
        //            }
        //            else
        //            {
        //                (sender as RadGrid).DataSource = GetDataOpertionTable(tr_code);
        //            }

        //    //    }
        //    //}
        //}

        //protected void RadGrid2_DeleteCommand(object sender, GridCommandEventArgs e)
        //{
        //    var part_code = ((GridDataItem)e.Item).GetDataKeyValue("part_code");

        //    try
        //    {
        //        GridEditableItem item = (GridEditableItem)e.Item;
        //        con.Open();
        //        cmd = new SqlCommand();
        //        cmd.CommandType = CommandType.Text;
        //        cmd.Connection = con;
        //        cmd.CommandText = "delete from inv01d02 where part_code = @part_code and sro_code = @sro_code";
        //        cmd.Parameters.AddWithValue("@sro_code", tr_code);
        //        cmd.Parameters.AddWithValue("@part_code", part_code);
        //        cmd.ExecuteNonQuery();
        //        con.Close();
        //        //RadGrid2.DataBind();

        //        Label lblsuccess = new Label();
        //        lblsuccess.Text = "Data deleted";
        //        lblsuccess.ForeColor = System.Drawing.Color.DarkGray;
        //        //RadGrid2.Controls.Add(lblsuccess);
        //    }
        //    catch (Exception ex)
        //    {
        //        con.Close();
        //        Label lblError = new Label();
        //        lblError.Text = "Unable to delete data. Reason: " + ex.Message;
        //        lblError.ForeColor = System.Drawing.Color.Red;
        //        //RadGrid2.Controls.Add(lblError);
        //        e.Canceled = true;
        //    }
        //}

        
        protected void RadGrid3_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            //if (tr_code == null && Session["TableDetail"] == null)
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
                else if(Session["TableDetail"] == null)
                {                   

                    DetailDtbl();
                    //dtValues = (DataTable)Session["TableDetail"];

                }
                else
                {
                    dtValues = (DataTable)Session["TableDetail"];
                }
                (sender as RadGrid).DataSource = dtValues; //populate RadGrid with datatable
                Session["TableDetail"] = dtValues;
            }
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
        protected void RadGrid3_InsertCommand(object sender, GridCommandEventArgs e)
        {
            GridEditableItem item = (GridEditableItem)e.Item;

            //if (Session["actionEdit"].ToString() == "new" && Session["TableDetail"] == null)
            if (Session["actionDetail"].ToString() == "detailNew" && Session["TableDetail"] == null )
            {
                DetailDtbl();

                (sender as RadGrid).DataSource = dtValues; //populate RadGrid with datatable
                Session["TableDetail"] = dtValues;
            }

            dtValues = (DataTable)Session["TableDetail"];
            DataRow drValue = dtValues.NewRow();
            drValue["sro_code"] = tr_code;
            drValue["OprName"] = (item.FindControl("cb_operation_insertTemp") as RadComboBox).Text;
            drValue["chart_code"] = (item.FindControl("lbl_operation_code_insertTemp") as Label).Text;
            drValue["prod_type"] = (item.FindControl("lbl_prodType_insertTemp") as Label).Text;
            drValue["part_code"] = (item.FindControl("cb_prod_code_insertTemp") as RadComboBox).Text;
            drValue["part_qty"] = (item.FindControl("txt_qty_insertTemp") as RadNumericTextBox).Value;
            drValue["qty_pr"] = (item.FindControl("txt_qtyRs_insertTemp") as RadNumericTextBox).Value;
            drValue["part_unit"] = (item.FindControl("lbl_UoM_insertTemp") as Label).Text;
            drValue["tWarranty"] = (item.FindControl("chk_waranty_insertTemp") as CheckBox).Checked;
            drValue["remark"] = (item.FindControl("txt_remark_insertTemp") as RadTextBox).Text;
            drValue["run"] = 0;

            dtValues.Rows.Add(drValue); //adding new row into datatable
            dtValues.AcceptChanges();
            Session["TableDetail"] = dtValues;
            (sender as RadGrid).Rebind();
            Session["actionDetail"] = "detailList";           

        }
        protected void RadGrid3_UpdateCommand(object sender, GridCommandEventArgs e)
        {
            GridEditableItem item = (GridEditableItem)e.Item;

            dtValues = (DataTable)Session["TableDetail"];
            DataRow drValue = dtValues.Rows[0];
            drValue["sro_code"] = tr_code;
            drValue["OprName"] = (item.FindControl("cb_operation_editTemp") as RadComboBox).Text;
            drValue["chart_code"] = (item.FindControl("lbl_operation_code_editTemp") as Label).Text;
            drValue["prod_type"] = (item.FindControl("lbl_prodType_editTemp") as Label).Text;
            drValue["part_code"] = (item.FindControl("cb_prod_code_editTemp") as RadComboBox).Text;
            drValue["part_qty"] = (item.FindControl("txt_qty_editTemp") as RadNumericTextBox).Text;
            drValue["qty_pr"] = (item.FindControl("txt_qtyRs_editTemp") as RadNumericTextBox).Text;
            drValue["part_unit"] = (item.FindControl("lbl_UoM_editTemp") as Label).Text;
            drValue["tWarranty"] = (item.FindControl("chk_waranty_editTemp") as CheckBox).Checked;
            drValue["remark"] = (item.FindControl("txt_remark_editTemp") as RadTextBox).Text;
            drValue["run"] = 0;

            drValue.EndEdit(); //editing row in datatable
            dtValues.AcceptChanges();
            Session["TableDetail"] = dtValues;
            (sender as RadGrid).Rebind();
        }
        protected void btnNew_Click(object sender, ImageClickEventArgs e)
        {
            Session["TableDetail"] = null;
            Session["actionHeader"] = "headerNew";
            RadGrid1.MasterTableView.IsItemInserted = true;
            RadGrid1.MasterTableView.Rebind();
            //Session["actionDetail"] = "new";
            //RadGrid3.DataSource = new string[] { };
            //RadGrid3.DataBind();

        }

        protected void cb_prod_code_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "SELECT unit FROM inv00h01 WHERE prod_code = '" + (sender as RadComboBox).SelectedValue + "'";

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                foreach (DataRow dtr in dt.Rows)
                {
                    RadComboBox cb = (RadComboBox)sender;
                    GridEditableItem item = (GridEditableItem)cb.NamingContainer;
                    
                    if (Session["actionDetail"].ToString() == "detailNew")
                    {
                        Label lbl_UoM = (Label)item.FindControl("lbl_UoM_insertTemp");
                        Label lbl_prodType = (Label)item.FindControl("lbl_prodType_insertTemp");
                        RadNumericTextBox txt_qtyRs_insertTemp = (RadNumericTextBox)item.FindControl("txt_qtyRs_insertTemp");
                        RadNumericTextBox txt_qty_insertTemp = (RadNumericTextBox)item.FindControl("txt_qty_insertTemp");

                        lbl_prodType.Text = "M1";
                        lbl_UoM.Text = dtr["unit"].ToString();
                        txt_qtyRs_insertTemp.Value = 0;
                        txt_qty_insertTemp.Value = 0;

                    }
                    else if (Session["actionDetail"].ToString() == "detailEdit")
                    {
                        Label lbl_UoM = (Label)item.FindControl("lbl_UoM_editTemp");
                        Label lbl_prodType = (Label)item.FindControl("lbl_prodType_editTemp");
                        RadNumericTextBox txt_qtyRs_editTemp = (RadNumericTextBox)item.FindControl("txt_qtyRs_editTemp");

                        lbl_prodType.Text = "M1";
                        lbl_UoM.Text = dtr["unit"].ToString();
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

        protected void cb_prod_code_PreRender(object sender, EventArgs e)
        {

        }

        protected void cb_prod_code_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            string sql = "SELECT TOP (100)[prod_code], [spec], [unit] FROM [inv00h01]  WHERE stEdit != '4' AND (spec LIKE @text + '%' OR prod_code LIKE @text + '%') ";
            SqlDataAdapter adapter = new SqlDataAdapter(sql,
                ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", e.Text);

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
                //RadGrid3.MasterTableView.IsItemInserted = true;
                //RadGrid3.MasterTableView.Rebind();
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
                item.Attributes.Add("OprName", row["OprName"].ToString());

                comboBox.Items.Add(item);

                item.DataBind();
            }
        }
        protected void cb_operation_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            RadComboBox cb = (RadComboBox)sender;
            GridEditableItem item = (GridEditableItem)cb.NamingContainer;

            Label lbl_opr_insert = (item.FindControl("lbl_operation_code_insertTemp") as Label);
            Label lbl_opr_edit = (item.FindControl("lbl_operation_code_editTemp") as Label);

            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT OprCode FROM mtc00h25 WHERE OprName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                if (Session["actionDetail"].ToString() == "detailNew")
                {
                    lbl_opr_insert.Text = dr[0].ToString();
                }
                else if (Session["actionDetail"].ToString() == "detailEdit")
                {
                    lbl_opr_edit.Text = dr[0].ToString();
                }
            //chartCode_selected = dr[0].ToString();
            dr.Close();
            con.Close();
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

        protected void btn_save_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridEditableItem item = (GridEditableItem)btn.NamingContainer;

            RadTextBox txt_mr_number = (RadTextBox)item.FindControl("txt_mr_number");
            RadDatePicker dtp_date = (RadDatePicker)item.FindControl("dtp_date");
            RadComboBox cb_Project = (RadComboBox)item.FindControl("cb_Project");
            RadComboBox cb_wo = (RadComboBox)item.FindControl("cb_wo");
            RadTextBox txt_unit = (RadTextBox)item.FindControl("txt_unit");
            RadDatePicker dtp_deliv = (RadDatePicker)item.FindControl("dtp_deliv");
            RadComboBox cb_priority = (RadComboBox)item.FindControl("cb_priority");
            RadComboBox cb_Order = (RadComboBox)item.FindControl("cb_Order");
            RadComboBox cb_job = (RadComboBox)item.FindControl("cb_job");
            RadTextBox txt_remark = (RadTextBox)item.FindControl("txt_remark");
            RadComboBox cb_ordered = (RadComboBox)item.FindControl("cb_ordered");
            RadComboBox cb_checked = (RadComboBox)item.FindControl("cb_checked");
            RadComboBox cb_ack = (RadComboBox)item.FindControl("cb_ack");
            Button btnCancel = (Button)item.FindControl("btnCancel");
            RadGrid Grid3 = (RadGrid)item.FindControl("RadGrid3");

            long maxNo;
            string run = null;
            string trDate = string.Format("{0:dd/MM/yyyy}", dtp_date.SelectedDate);

            try
            {
                if ((sender as Button).Text == "Update")
                {
                    run = txt_mr_number.Text;
                }
                else
                {
                    con.Open();
                    SqlDataReader sdr;
                    cmd = new SqlCommand("SELECT ISNULL ( MAX ( RIGHT ( inv01h02.sro_code , 4 ) ) , 0 ) + 1 AS maxNo " +
                        "FROM inv01h02 WHERE LEFT(inv01h02.sro_code, 4) = 'MR01' " +
                        "AND SUBSTRING(inv01h02.sro_code, 5, 2) = SUBSTRING('" + trDate + "', 9, 2) " +
                        "AND SUBSTRING(inv01h02.sro_code, 7, 2) = SUBSTRING('" + trDate + "', 4, 2) ", con);
                    sdr = cmd.ExecuteReader();
                    if (sdr.HasRows == false)
                    {
                        //throw new Exception();
                        run = "MR01" + dtp_date.SelectedDate.Value.Year + dtp_date.SelectedDate.Value.Month + "0001";
                    }
                    else if (sdr.Read())
                    {
                        maxNo = Convert.ToInt32(sdr[0].ToString());
                        run = "MR01" + (dtp_date.SelectedDate.Value.Year.ToString()).Substring(dtp_date.SelectedDate.Value.Year.ToString().Length - 2) +
                            ("0000" + dtp_date.SelectedDate.Value.Month).Substring(("0000" + dtp_date.SelectedDate.Value.Month).Length - 2, 2) +
                            ("0000" + maxNo).Substring(("0000" + maxNo).Length - 4, 4);
                    }
                    con.Close();
                }

                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_save_material_requestH";
                cmd.Parameters.AddWithValue("@sro_code", run);
                cmd.Parameters.AddWithValue("@region_code", cb_Project.SelectedValue);
                cmd.Parameters.AddWithValue("@trans_id", cb_wo.SelectedValue);
                cmd.Parameters.AddWithValue("@sro_reason", "01");
                cmd.Parameters.AddWithValue("@unit_code", txt_unit.Text);
                cmd.Parameters.AddWithValue("@sro_date", string.Format("{0:yyyy-MM-dd}", dtp_date.SelectedDate.Value));
                cmd.Parameters.AddWithValue("@deliv_date", string.Format("{0:yyyy-MM-dd}", dtp_deliv.SelectedDate.Value));
                cmd.Parameters.AddWithValue("@sro_kind", cb_priority.SelectedValue);
                cmd.Parameters.AddWithValue("@ordertype", cb_Order.SelectedValue);
                cmd.Parameters.AddWithValue("@job_status", cb_job.SelectedValue);
                cmd.Parameters.AddWithValue("@ord_by", cb_ordered.SelectedValue);
                cmd.Parameters.AddWithValue("@userid", cb_checked.SelectedValue);
                cmd.Parameters.AddWithValue("@ack_by", cb_ack.SelectedValue);
                cmd.Parameters.AddWithValue("@sro_remark", txt_remark.Text);
                cmd.Parameters.AddWithValue("@LASTUSER", public_str.user_id);
                cmd.Parameters.AddWithValue("@lastupdate", DateTime.Today);
                cmd.Parameters.AddWithValue("@status", 1);
                cmd.Parameters.AddWithValue("@Owner", public_str.user_id);
                cmd.Parameters.AddWithValue("@OwnStamp", DateTime.Today);
                cmd.Parameters.AddWithValue("@Printed", 1);
                cmd.Parameters.AddWithValue("@Edited", 0);
                cmd.Parameters.AddWithValue("@void", 3);
                cmd.ExecuteNonQuery();

                foreach (GridDataItem itemD in Grid3.MasterTableView.Items)
                {
                    //GridEditableItem item = (GridEditableItem)e.Item;
                    //RadNumericTextBox lblQtyRs;
                    Label lbl_UoM;
                    Label lbl_prodType;
                    Label lbl_qty;
                    Label lbl_partCode;
                    Label lbl_operation_code;
                    CheckBox chkWaranty;
                    Label lbl_remark;

                    lbl_prodType = (Label)itemD.FindControl("lbl_prodType");
                    lbl_qty = (Label)itemD.FindControl("lbl_qty");
                    //lblQtyRs = (RadNumericTextBox)itemD.FindControl("txt_qtyRs_editTemp");
                    lbl_UoM = (Label)itemD.FindControl("lbl_UoM");
                    lbl_partCode = (Label)itemD.FindControl("lbl_partCode");
                    lbl_operation_code = (Label)itemD.FindControl("lbl_operation_code");
                    chkWaranty = (CheckBox)itemD.FindControl("chk_waranty");
                    lbl_remark = (Label)itemD.FindControl("lbl_remark");
                    

                    //con.Open();
                    cmd = new SqlCommand();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Connection = con;
                    cmd.CommandText = "sp_save_material_requestD";
                    cmd.Parameters.AddWithValue("@sro_code", run);
                    cmd.Parameters.AddWithValue("@prod_type", lbl_prodType.Text);
                    cmd.Parameters.AddWithValue("@item", DBNull.Value);
                    cmd.Parameters.AddWithValue("@part_qty", Convert.ToDouble(lbl_qty.Text));
                    cmd.Parameters.AddWithValue("@part_code", lbl_partCode.Text);
                    cmd.Parameters.AddWithValue("@part_unit", lbl_UoM.Text);
                    cmd.Parameters.AddWithValue("@chart_code", lbl_operation_code.Text);
                    cmd.Parameters.AddWithValue("@trans_id", wo_code);
                    cmd.Parameters.AddWithValue("@deliv_date", string.Format("{0:yyyy-MM-dd}", dtp_deliv.SelectedDate.Value));
                    if (chkWaranty.Checked == true)
                    {
                        cmd.Parameters.AddWithValue("@tWarranty", 1);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@tWarranty", 0);
                    }
                    cmd.Parameters.AddWithValue("@remark", lbl_remark.Text);
                    cmd.ExecuteNonQuery();

                    //con.Close();


                    //cmd = new SqlCommand();
                    //cmd.CommandType = CommandType.Text;
                    //cmd.Connection = con;
                    //if (Session["actionDetail"].ToString() == "detailEdit")
                    //{
                    //    cmd.CommandText = "UPDATE mtc01h03 SET chart_code= @chart_code WHERE trans_id=@trans_id";
                    //    cmd.Parameters.AddWithValue("@trans_id", run);
                    //    cmd.Parameters.AddWithValue("@chart_code", itemD["chart_code"].Text);
                    //    cmd.ExecuteNonQuery();
                    //}
                    //else
                    //{
                    //    cmd.CommandText = "INSERT INTO mtc01h03(trans_id, chart_code, formula) VALUES (@trans_id, @chart_code, 0)";
                    //    cmd.Parameters.AddWithValue("@trans_id", run);
                    //    cmd.Parameters.AddWithValue("@chart_code", itemD["chart_code"].Text);
                    //    cmd.ExecuteNonQuery();
                    //}

                }
            }
            catch (Exception ex)
            {
                con.Close();
                Response.Write("<font color='red'>" + ex.Message + "</font>");
                //RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "");
                //RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn","");
            }
            finally
            {
                con.Close();
                txt_mr_number.Text = run;
                notif.Text = "Data telah disimpan";
                notif.Show();

                if ((sender as Button).Text == "Update")
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind();", true);
                }
                else
                {
                    inv01h02.tr_code = run;
                    inv01h02.selected_project = cb_Project.SelectedValue;
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind('navigateToInserted');", true);
                    (sender as Button).Text = "Update";
                    btnCancel.Text = "Close";
                }

                RadGrid1.MasterTableView.IsItemInserted = false;

            }


            //try
            //{
            //    GridEditableItem item = (GridEditableItem)e.Item;
            //    RadNumericTextBox lblQtyRs;
            //    Label lbl_UoM;
            //    Label lbl_prodType;
            //    RadNumericTextBox txtPartQty;
            //    RadComboBox cbProdCode;
            //    //RadComboBox cbChart;
            //    CheckBox chkWaranty;
            //    RadTextBox txtRemark;
            //    Label lblChart;

            //    if (RadGrid3.MasterTableView.IsItemInserted)
            //    {
            //        lbl_prodType = (Label)item.FindControl("lbl_prodType_insertTemp");
            //        txtPartQty = (RadNumericTextBox)item.FindControl("txt_qty_insertTemp");
            //        lblQtyRs = (RadNumericTextBox)item.FindControl("txt_qtyRs_insertTemp");
            //        lbl_UoM = (Label)item.FindControl("lbl_UoM_insertTemp");
            //        cbProdCode = (RadComboBox)item.FindControl("cb_prod_code_insertTemp");
            //        //cbChart = (RadComboBox)item.FindControl("cb_operation_insertTemp");
            //        chkWaranty = (CheckBox)item.FindControl("chk_waranty_insertTemp");
            //        txtRemark = (RadTextBox)item.FindControl("txt_remark_insertTemp");
            //    }
            //    else
            //    {
            //        lbl_prodType = (Label)item.FindControl("lbl_prodType_editTemp");
            //        txtPartQty = (RadNumericTextBox)item.FindControl("txt_qty_editTemp");
            //        lblQtyRs = (RadNumericTextBox)item.FindControl("txt_qtyRs_editTemp");
            //        lbl_UoM = (Label)item.FindControl("lbl_UoM_editTemp");
            //        cbProdCode = (RadComboBox)item.FindControl("cb_prod_code_editTemp");
            //        //cbChart = (RadComboBox)item.FindControl("cb_operation_editTemp");
            //        chkWaranty = (CheckBox)item.FindControl("chk_waranty_editTemp");
            //        txtRemark = (RadTextBox)item.FindControl("txt_remark_editTemp");
            //        lblChart = (Label)item.FindControl("lbl_operation");
            //    }

            //    con.Open();
            //    cmd = new SqlCommand();
            //    cmd.CommandType = CommandType.StoredProcedure;
            //    cmd.Connection = con;
            //    cmd.CommandText = "sp_save_material_requestD";
            //    cmd.Parameters.AddWithValue("@prod_type", lbl_prodType.Text);
            //    cmd.Parameters.AddWithValue("@item", DBNull.Value);
            //    cmd.Parameters.AddWithValue("@part_qty", Convert.ToDouble(txtPartQty.Text));
            //    cmd.Parameters.AddWithValue("@sro_code", tr_code);
            //    cmd.Parameters.AddWithValue("@part_code", cbProdCode.Text);
            //    cmd.Parameters.AddWithValue("@part_unit", lbl_UoM.Text);
            //    cmd.Parameters.AddWithValue("@chart_code", chartCode_selected);
            //    cmd.Parameters.AddWithValue("@trans_id", wo_code);
            //    cmd.Parameters.AddWithValue("@deliv_date", DBNull.Value);
            //    if (chkWaranty.Checked == true)
            //    {
            //        cmd.Parameters.AddWithValue("@tWarranty", 1);
            //    }
            //    else
            //    {
            //        cmd.Parameters.AddWithValue("@tWarranty", 0);
            //    }
            //    cmd.Parameters.AddWithValue("@remark", txtRemark.Text);
            //    cmd.ExecuteNonQuery();

            //    con.Close();
            //    //notif.Show();

            //}
            //catch (Exception ex)
            //{
            //    con.Close();
            //    RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
            //    e.Canceled = true;
            //}

        }

        #region Project
        private static DataTable GetProject(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT region_code, region_name FROM inv00h09 WHERE stEdit != 4 AND region_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }

        protected void cb_Project_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
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

        protected void cb_Project_PreRender(object sender, EventArgs e)
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

        protected void cb_Project_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
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
                selected_project = dr[0].ToString();
            }
            dr.Close();
            con.Close();
        }
        #endregion

        #region WO

        public DataTable GetDataRefDetailTable(string projectID)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_material_request_refH";
            cmd.Parameters.AddWithValue("@project", projectID);
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

        protected void LoadWO(string trans_id, string projectID, RadComboBox cb)
        {
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);

            SqlDataAdapter adapter = new SqlDataAdapter("SELECT TOP(20) trans_id, trans_date, unit_code, unitstatus, DBDate, BDTime, OrderName, remark FROM v_material_request_H_reff " +
                "WHERE region_code = @project AND trans_id LIKE @text + '%'", con);
            adapter.SelectCommand.Parameters.AddWithValue("@project", projectID);
            adapter.SelectCommand.Parameters.AddWithValue("@text", trans_id);
            DataTable dt = new DataTable();
            adapter.Fill(dt);

            cb.DataTextField = "trans_id";
            cb.DataValueField = "trans_id";
            cb.DataSource = dt;
            cb.DataBind();
        }

        protected void cb_wo_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadWO(e.Text, selected_project, (sender as RadComboBox));
        }

        protected void cb_wo_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT * FROM v_material_request_H_reff WHERE trans_id = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            }
            dr.Close();
            con.Close();
        }

        protected void cb_wo_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            RadComboBox cb = (RadComboBox)sender;
            GridEditableItem item = (GridEditableItem)cb.NamingContainer;
            RadComboBox cb_priority = (RadComboBox)item.FindControl("cb_priority");
            RadComboBox cb_Order = (RadComboBox)item.FindControl("cb_Order");
            RadComboBox cb_job = (RadComboBox)item.FindControl("cb_job");
            RadTextBox txt_unit = (RadTextBox)item.FindControl("txt_unit");
            RadTextBox txt_remark = (RadTextBox)item.FindControl("txt_remark");

            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT * FROM v_material_request_H_reff WHERE trans_id = '" + (sender as RadComboBox).SelectedValue + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).Text = dr["trans_id"].ToString();
                txt_unit.Text = dr["unit_code"].ToString();
                cb_priority.Text = dr["prio_desc"].ToString();
                cb_Order.Text = dr["OrderName"].ToString();
                cb_job.Text = dr["PMAct_Name"].ToString();
                txt_remark.Text = dr["remark"].ToString();
                wo_code= dr["trans_id"].ToString();
            }

            dr.Close();
            con.Close();

        }
        #endregion

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
        #endregion

        #region Order
        private static DataTable GetOrder(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT OrderType, OrderName FROM mtc00h23 WHERE stEdit != 4 AND OrderName LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_Order_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetOrder(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["OrderName"].ToString(), data.Rows[i]["OrderName"].ToString()));
            }
        }

        protected void cb_Order_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT OrderType FROM mtc00h23 WHERE OrderName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            }
            dr.Close();
            con.Close();
        }

        protected void cb_Order_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT OrderType FROM mtc00h23 WHERE OrderName = '" + (sender as RadComboBox).Text + "'";
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

        #region Job Type
        private static DataTable GetJob(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT PMact_type, PMAct_Name FROM mtc00h22 WHERE stEdit != 4 AND PMAct_Name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }

        protected void cb_job_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetJob(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["PMAct_Name"].ToString(), data.Rows[i]["PMAct_Name"].ToString()));
            }
        }

        protected void cb_job_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT PMact_type FROM mtc00h22 WHERE PMAct_Name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            }

            dr.Close();
            con.Close();
        }

        protected void cb_job_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT PMact_type FROM mtc00h22 WHERE PMAct_Name = '" + (sender as RadComboBox).Text + "'";
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

        #region approval

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
        protected void cb_checked_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadManPower(e.Text, selected_project , (sender as RadComboBox));
        }

        protected void cb_checked_DataBound(object sender, EventArgs e)
        {
            ((Literal)(sender as RadComboBox).Footer.FindControl("RadComboItemsCount")).Text = Convert.ToString((sender as RadComboBox).Items.Count);
        }

        protected void cb_checked_PreRender(object sender, EventArgs e)
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

        protected void cb_checked_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
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

        protected void cb_ack_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadManPower(e.Text, selected_project, (sender as RadComboBox));
        }

        protected void cb_ack_DataBound(object sender, EventArgs e)
        {
            ((Literal)(sender as RadComboBox).Footer.FindControl("RadComboItemsCount")).Text = Convert.ToString((sender as RadComboBox).Items.Count);
        }

        protected void cb_ack_PreRender(object sender, EventArgs e)
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

        protected void cb_ack_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
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

        protected void cb_ordered_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadManPower(e.Text, selected_project, (sender as RadComboBox));
        }

        protected void cb_ordered_DataBound(object sender, EventArgs e)
        {
            ((Literal)(sender as RadComboBox).Footer.FindControl("RadComboItemsCount")).Text = Convert.ToString((sender as RadComboBox).Items.Count);
        }

        protected void cb_ordered_PreRender(object sender, EventArgs e)
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

        protected void cb_ordered_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
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

        protected void RadGrid1_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                GridDataItem item = e.Item as GridDataItem;
                string kode = item["sro_code"].Text;
                tr_code = kode;

                Session["actionHeader"] = "headerEdit";
                Session["actionDetail"] = null;
            }
        }

        protected void RadGrid3_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadGrid).MasterTableView.Items.Count < (sender as RadGrid).MasterTableView.PageSize)
            {
                (sender as RadGrid).ClientSettings.Scrolling.AllowScroll = false;
                (sender as RadGrid).ClientSettings.Scrolling.UseStaticHeaders = false;
            }
        }

        protected void RadGrid3_ItemCommand(object sender, GridCommandEventArgs e)
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