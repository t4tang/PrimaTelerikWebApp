﻿using System;
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

namespace TelerikWebApplication.Form.Inventory.UserRequest
{
    public partial class inv01h01new : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();

        private const int ItemsPerRequest = 10;
        public static string tr_code = null;
        //public static string wo_code = null;
        public static string selected_project = null;
        public static string selected_cost_ctr = null;
        public static string chartCode_selected;
        DataTable dtValues;

        public DataTable DetailDtbl()
        {
            dtValues = new DataTable();
            dtValues.Columns.Add("doc_code", typeof(string));
            dtValues.Columns.Add("part_code", typeof(string));
            dtValues.Columns.Add("spec", typeof(string));
            dtValues.Columns.Add("part_qty", typeof(double));
            dtValues.Columns.Add("part_unit", typeof(string));
            dtValues.Columns.Add("dept_code", typeof(string));
            dtValues.Columns.Add("remark", typeof(string));
            dtValues.Columns.Add("run", typeof(int));

            return dtValues;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lbl_form_name.Text = "User Request";
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
                Session["urType"] = "none";
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

                    Session["action"] = "list";
                }
            }
            catch (Exception ex)
            {
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            RadGrid1.DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), cb_proj_prm.SelectedValue);
            RadGrid1.DataBind();
        }

        protected void btnNew_Click(object sender, ImageClickEventArgs e)
        {
            Session["TableDetail"] = null;
            Session["actionHeader"] = "headerNew";
            RadGrid1.MasterTableView.IsItemInserted = true;
            RadGrid1.MasterTableView.Rebind();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridEditableItem item = (GridEditableItem)btn.NamingContainer;

            RadTextBox txt_ur_number = (RadTextBox)item.FindControl("txt_ur_number");
            RadDatePicker dtp_ur = (RadDatePicker)item.FindControl("dtp_ur");
            RadComboBox cb_ur_status = (RadComboBox)item.FindControl("cb_ur_status");
            RadDatePicker dtp_exe = (RadDatePicker)item.FindControl("dtp_exe");
            RadComboBox cb_request = (RadComboBox)item.FindControl("cb_request");
            RadComboBox cb_approved = (RadComboBox)item.FindControl("cb_approved");
            RadComboBox cb_cost_center = (RadComboBox)item.FindControl("cb_cost_center");
            RadComboBox cb_project = (RadComboBox)item.FindControl("cb_project");
            RadComboBox cb_priority = (RadComboBox)item.FindControl("cb_priority");
            RadComboBox cb_ur_type = (RadComboBox)item.FindControl("cb_ur_type");
            RadTextBox txt_remark = (RadTextBox)item.FindControl("txt_remark");

            Button btnCancel = (Button)item.FindControl("btnCancel");
            RadGrid Grid2 = (RadGrid)item.FindControl("RadGrid2");

            long maxNo;
            string run = null;
            string trDate = string.Format("{0:dd/MM/yyyy}", dtp_ur.SelectedDate);

            try
            {
                if ((sender as Button).Text == "Update")
                {
                    run = txt_ur_number.Text;
                }
                else
                {
                    con.Open();
                    SqlDataReader sdr;
                    cmd = new SqlCommand("SELECT ISNULL ( MAX ( RIGHT ( fleet_grh.doc_code , 4 ) ) , 0 ) + 1 AS maxNo " +
                        "FROM fleet_grh WHERE LEFT(fleet_grh.doc_code, 4) = 'UR01' " +
                        "AND SUBSTRING(fleet_grh.doc_code, 5, 2) = SUBSTRING('" + trDate + "', 9, 2) " +
                        "AND SUBSTRING(fleet_grh.doc_code, 7, 2) = SUBSTRING('" + trDate + "', 4, 2) ", con);
                    sdr = cmd.ExecuteReader();
                    if (sdr.HasRows == false)
                    {
                        //throw new Exception();
                        run = "UR01" + dtp_ur.SelectedDate.Value.Year + dtp_ur.SelectedDate.Value.Month + "0001";
                    }
                    else if (sdr.Read())
                    {
                        maxNo = Convert.ToInt32(sdr[0].ToString());
                        run = "UR01" + (dtp_ur.SelectedDate.Value.Year.ToString()).Substring(dtp_ur.SelectedDate.Value.Year.ToString().Length - 2) +
                            ("0000" + dtp_ur.SelectedDate.Value.Month).Substring(("0000" + dtp_ur.SelectedDate.Value.Month).Length - 2, 2) +
                            ("0000" + maxNo).Substring(("0000" + maxNo).Length - 4, 4);
                    }
                    con.Close();
                }


                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_save_urH";
                cmd.Parameters.AddWithValue("@doc_code", run);
                cmd.Parameters.AddWithValue("@doc_date", string.Format("{0:yyyy-MM-dd}", dtp_ur.SelectedDate.Value));
                cmd.Parameters.AddWithValue("@trans_status", cb_ur_status.SelectedValue);
                cmd.Parameters.AddWithValue("@date_exec", string.Format("{0:yyyy-MM-dd}", dtp_exe.SelectedDate.Value));
                cmd.Parameters.AddWithValue("@receive_by", cb_request.SelectedValue);
                cmd.Parameters.AddWithValue("@aprove_by", cb_approved.SelectedValue);
                cmd.Parameters.AddWithValue("@doc_remark", txt_remark.Text);
                cmd.Parameters.AddWithValue("@userid", public_str.user_id);
                cmd.Parameters.AddWithValue("@lastupdate", DateTime.Today);
                cmd.Parameters.AddWithValue("@region_code", cb_project.SelectedValue);
                cmd.Parameters.AddWithValue("@dept_code", cb_cost_center.SelectedValue);
                cmd.Parameters.AddWithValue("@priority_code", cb_priority.SelectedValue);
                cmd.Parameters.AddWithValue("@tAsset", cb_ur_type.SelectedValue);
                cmd.Parameters.AddWithValue("@Owner", public_str.user_id);
                cmd.Parameters.AddWithValue("@OwnStamp", DateTime.Today);
                cmd.Parameters.AddWithValue("@Lvl", public_str.level);
                cmd.ExecuteNonQuery();

                foreach (GridDataItem itemD in Grid2.MasterTableView.Items)
                {
                    RadComboBox cb_prod_code;
                    Label lbl_part_name;
                    RadNumericTextBox txt_qty;
                    RadComboBox cb_uom_d;
                    RadTextBox txt_remark_d;
                    RadComboBox cb_dept_d;

                    cb_prod_code = (RadComboBox)itemD.FindControl("cb_prod_code");
                    lbl_part_name = (Label)itemD.FindControl("lbl_part_name");
                    txt_qty = (RadNumericTextBox)itemD.FindControl("txt_qty");
                    cb_uom_d = (RadComboBox)itemD.FindControl("cb_uom_d");
                    txt_remark_d = (RadTextBox)itemD.FindControl("txt_remark_d");
                    cb_dept_d = (RadComboBox)itemD.FindControl("cb_dept_d");
                                  
                    cmd = new SqlCommand();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Connection = con;
                    cmd.CommandText = "sp_save_urD";
                    cmd.Parameters.AddWithValue("@doc_code", run);
                    cmd.Parameters.AddWithValue("@part_code", cb_prod_code.Text);
                    cmd.Parameters.AddWithValue("@part_desc", lbl_part_name.Text);
                    cmd.Parameters.AddWithValue("@part_qty", txt_qty.Value);
                    cmd.Parameters.AddWithValue("@part_unit", cb_uom_d.Text);
                    cmd.Parameters.AddWithValue("@remark", txt_remark_d.Text);
                    cmd.Parameters.AddWithValue("@dept_code", cb_dept_d.Text);
                    cmd.ExecuteNonQuery();
                   
                }

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

                notif.Show("Data saved");
            }
            catch (Exception ex)
            {
                con.Close();
                Response.Write("<font color='red'>" + ex.Message + "</font>");
            }
            finally
            {
                con.Close();
                txt_ur_number.Text = run;
                tr_code = run;
                RadGrid1.MasterTableView.IsItemInserted = false;
            }
        }

        #region Main Grid

        protected void RadGrid1_PreRender(object sender, EventArgs e)
        {
            if (Session["action"].ToString() == "firstLoad")
            {
                if ((sender as RadGrid).MasterTableView.Items.Count > 0)
                    (sender as RadGrid).MasterTableView.Items[0].Selected = true;
                foreach (GridDataItem item in RadGrid1.SelectedItems)
                {
                    foreach (GridDataItem gItem in (sender as RadGrid).SelectedItems)
                    {
                        tr_code = gItem["doc_code"].Text;
                    }
                }

            }
        }
        public DataTable GetDataTable(string fromDate, string toDate, string project)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_urH";
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
            var doc_code = ((GridDataItem)e.Item).GetDataKeyValue("doc_code");

            try
            {
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "UPDATE fleet_grh SET userid = @Usr, lastupdate = GETDATE(), stEdit = '4' WHERE (doc_code = @doc_code)";
                cmd.Parameters.AddWithValue("@doc_code", doc_code);
                cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
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
                ImageButton printLink = (ImageButton)e.Item.FindControl("PrintLink");
                printLink.Attributes["href"] = "javascript:void(0);";
                printLink.Attributes["onclick"] = String.Format("return ShowPreview('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["doc_code"], e.Item.ItemIndex);

            }
        }

        protected void RadGrid1_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                tr_code = null;
                GridDataItem item = e.Item as GridDataItem;
                string kode = item["doc_code"].Text;
                tr_code = kode;

                Session["actionHeader"] = "headerEdit";
                Session["actionDetail"] = null;
            }
        }

        protected void RadGrid1_SelectedIndexChanged(object sender, EventArgs e)
        {
            foreach (GridDataItem item in RadGrid1.SelectedItems)
            {
                tr_code = item["doc_code"].Text;
            }

            Session["actionEdit"] = "list";
        }

        protected void RadGrid1_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridEditFormItem && e.Item.IsInEditMode)
            {
                //GridDataItem item = (GridDataItem)e.Item;
                var item = e.Item as GridEditFormItem;
                RadComboBox cb_project = item.FindControl("cb_project") as RadComboBox;
                RadComboBox cb_ur_status = item.FindControl("cb_ur_status") as RadComboBox;
                RadComboBox cb_priority = item.FindControl("cb_priority") as RadComboBox; 
                RadComboBox cb_ur_type = item.FindControl("cb_ur_type") as RadComboBox; 
                RadDatePicker dtp_ur = item.FindControl("dtp_ur") as RadDatePicker;
                RadDatePicker dtp_exe = item.FindControl("dtp_exe") as RadDatePicker;

                RadTextBox txt_uid = item.FindControl("txt_uid") as RadTextBox;
                RadTextBox txt_lastUpdate = item.FindControl("txt_lastUpdate") as RadTextBox;
                RadTextBox txt_owner = item.FindControl("txt_owner") as RadTextBox;
                RadTextBox txt_printed = item.FindControl("txt_printed") as RadTextBox;
                RadTextBox txt_edited = item.FindControl("txt_edited") as RadTextBox;

                if (e.Item.OwnerTableView.IsItemInserted)
                {
                    cb_ur_status.Text = "Open";
                    cb_project.Text = public_str.sitename;
                    cb_priority.Text = "High/Urgent";
                    cb_ur_type.Text = "Non Asset";
                    dtp_ur.SelectedDate = DateTime.Now;
                    dtp_exe.SelectedDate = DateTime.Now;

                    txt_uid.Text = public_str.uid;
                    txt_lastUpdate.Text = DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss");
                    txt_owner.Text = public_str.uid;
                    txt_printed.Text = "0";
                    txt_edited.Text = "0";
                }

            }

        }
        #endregion

        #region Detail Grid

        protected void RadGrid2_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadGrid).MasterTableView.Items.Count < (sender as RadGrid).MasterTableView.PageSize)
            {
                (sender as RadGrid).ClientSettings.Scrolling.AllowScroll = false;
                (sender as RadGrid).ClientSettings.Scrolling.UseStaticHeaders = false;
            }
            else
            {
                (sender as RadGrid).ClientSettings.Scrolling.AllowScroll = true;
                (sender as RadGrid).ClientSettings.Scrolling.ScrollHeight = 195;
            }

            
        }
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
        protected void RadGrid2_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
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
            cmd.CommandText = "sp_get_urD";
            cmd.Parameters.AddWithValue("@doc_code", doc_code);
            cmd.CommandTimeout = 0;
            cmd.ExecuteNonQuery();
            sda = new SqlDataAdapter(cmd);

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
        protected void RadGrid2_InsertCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                GridEditableItem item = (GridEditableItem)e.Item;

                //if (Session["actionEdit"].ToString() == "new" && Session["TableDetail"] == null)
                if (Session["actionDetail"].ToString() == "detailNew" && Session["TableDetail"] == null)
                {
                    DetailDtbl();

                    (sender as RadGrid).DataSource = dtValues; //populate RadGrid with datatable
                    Session["TableDetail"] = dtValues;
                }

                dtValues = (DataTable)Session["TableDetail"];
                DataRow drValue = dtValues.NewRow();
                drValue["doc_code"] = tr_code;
                drValue["part_code"] = (item.FindControl("cb_prod_code_insert") as RadComboBox).Text;
                drValue["spec"] = (item.FindControl("txt_prod_name_insert") as RadTextBox).Text;
                drValue["part_qty"] = (item.FindControl("txt_qty_insert") as RadNumericTextBox).Value;
                drValue["part_unit"] = (item.FindControl("cb_uom_d_insert") as RadComboBox).Text;
                drValue["dept_code"] = (item.FindControl("cb_dept_d_insert") as RadComboBox).Text;
                drValue["remark"] = (item.FindControl("txt_remark_d_insert") as RadTextBox).Text;
                drValue["run"] = 0;
                
                dtValues.Rows.Add(drValue); //adding new row into datatable
                dtValues.AcceptChanges();
                Session["TableDetail"] = dtValues;
                (sender as RadGrid).Rebind();
                Session["actionDetail"] = "detailList";

            }
            catch (Exception ex)
            {
                con.Close();
                Label lblError = new Label();
                lblError.Text = "Unable to insert data. Reason: " + ex.Message;
                lblError.ForeColor = System.Drawing.Color.Red;
                (sender as RadGrid).Controls.Add(lblError);
                e.Canceled = true;
            }
        }

        protected void RadGrid2_UpdateCommand(object sender, GridCommandEventArgs e)
        {
            GridEditableItem item = (GridEditableItem)e.Item;

            dtValues = (DataTable)Session["TableDetail"];
            DataRow drValue = dtValues.Rows[0];
            drValue["doc_code"] = tr_code;
            drValue["part_code"] = (item.FindControl("cb_prod_code") as RadComboBox).Text;
            drValue["spec"] = (item.FindControl("txt_prod_name") as RadTextBox).Text;
            drValue["part_qty"] = (item.FindControl("txt_qty") as RadNumericTextBox).Value;
            drValue["part_unit"] = (item.FindControl("cb_uom_d") as RadComboBox).Text;
            drValue["dept_code"] = (item.FindControl("cb_dept_d") as RadComboBox).Text;
            drValue["remark"] = (item.FindControl("txt_remark_d") as RadTextBox).Text;
            drValue["run"] = 0;

            drValue.EndEdit(); //editing row in datatable
            dtValues.AcceptChanges();
            Session["TableDetail"] = dtValues;
            (sender as RadGrid).Rebind();
        }

        protected void RadGrid2_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            var partCode = ((GridDataItem)e.Item).GetDataKeyValue("part_code");

            try
            {
                GridEditableItem item = (GridEditableItem)e.Item;
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "delete from fleet_grd where part_code = @part_code and doc_code = @doc_code";
                cmd.Parameters.AddWithValue("@doc_code", partCode);
                cmd.Parameters.AddWithValue("@part_code", partCode);
                cmd.ExecuteNonQuery();
                con.Close();
                (sender as RadGrid).DataBind();

                Label lblsuccess = new Label();
                lblsuccess.Text = "Data deleted";
                lblsuccess.ForeColor = System.Drawing.Color.DarkGray;
                (sender as RadGrid).Controls.Add(lblsuccess);
            }
            catch (Exception ex)
            {
                con.Close();
                Label lblError = new Label();
                lblError.Text = "Unable to delete data. Reason: " + ex.Message;
                lblError.ForeColor = System.Drawing.Color.Red;
                (sender as RadGrid).Controls.Add(lblError);
                e.Canceled = true;
            }
        }


        #endregion

        #region project param
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
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();

        }
        #endregion

        #region Project
        private static DataTable GetProject(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT region_code, region_name FROM ms_jobsite WHERE stEdit != 4 AND region_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_project_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
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
        protected void cb_project_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
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
        protected void cb_project_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT region_code FROM ms_jobsite WHERE region_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }

        #endregion

        #region Product
        protected void cb_prod_code_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT prod_code FROM ms_product WHERE spec = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }
        protected void cb_prod_code_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            if(Session["urType"].ToString() != "asset")
            {
                string sql = "SELECT TOP (100)[prod_code], [spec] FROM [v_product_detail]  WHERE prod_code LIKE @text + '%' " +
                    "AND PlantCode = '" + selected_project + "'";
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

                    comboBox.Items.Add(item);

                    item.DataBind();
                }
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
                cmd.CommandText = "SELECT spec,unit FROM ms_product WHERE prod_code = '" + (sender as RadComboBox).SelectedValue + "'";

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                foreach (DataRow dtr in dt.Rows)
                {
                    RadComboBox cb = (RadComboBox)sender;
                    GridEditableItem item = (GridEditableItem)cb.NamingContainer;
                    if (Session["actionDetail"].ToString() == "detailNew")
                    {
                        RadTextBox t_spec = (RadTextBox)item.FindControl("txt_prod_name_insert");
                        RadNumericTextBox txt_qty = (RadNumericTextBox)item.FindControl("txt_qty_insert");
                        RadComboBox cb_uom = (RadComboBox)item.FindControl("cb_uom_d_insert");
                        RadComboBox cbDept_d = (RadComboBox)item.FindControl("cb_dept_d_insert");

                        t_spec.Text = dtr["spec"].ToString();
                        t_spec.ReadOnly = true;
                        cb_uom.Text = dtr["unit"].ToString();
                        txt_qty.Value = 0;
                        cbDept_d.Text = selected_cost_ctr;
                    }
                    else
                    {
                        Label lbl_part_name = (Label)item.FindControl("lbl_part_name");
                        RadNumericTextBox txt_qty = (RadNumericTextBox)item.FindControl("txt_qty");
                        RadComboBox cb_uom = (RadComboBox)item.FindControl("cb_uom_d");
                        RadComboBox cbDept_d = (RadComboBox)item.FindControl("cb_dept_d");

                        lbl_part_name.Text = dtr["spec"].ToString();
                        cb_uom.Text = dtr["unit"].ToString();
                        txt_qty.Value = 0;
                        cbDept_d.Text = selected_cost_ctr;
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
        #endregion

        #region UR Type
        protected void cb_ur_type_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadComboBox).Text == "Non Asset")
            {
                (sender as RadComboBox).SelectedValue = "0";
            }
            else if ((sender as RadComboBox).Text == "Asset")
            {
                (sender as RadComboBox).SelectedValue = "1";
            }
        }
        protected void cb_ur_type_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Add("Non Asset");
            (sender as RadComboBox).Items.Add("Asset");
        }
        protected void cb_ur_type_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if ((sender as RadComboBox).Text == "Non Asset")
            {
                (sender as RadComboBox).SelectedValue = "0";
                Session["urType"] = "nonAsset";
            }
            else if ((sender as RadComboBox).Text == "Asset")
            {
                (sender as RadComboBox).SelectedValue = "1";
                Session["urType"] = "asset";
            }
        }
        #endregion

        #region Cost Center
        protected void LoadCostCtr(string name, string projectID, RadComboBox cb)
        {
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);

            SqlDataAdapter adapter = new SqlDataAdapter("SELECT upper(CostCenter) as code,upper(CostCenterName) as name FROM ms_cost_center " +
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
        protected void cb_cost_center_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            RadComboBox cb = (RadComboBox)sender;
            GridEditableItem item = (GridEditableItem)cb.NamingContainer;
            RadComboBox cb_project = (RadComboBox)item.FindControl("cb_project");

            (sender as RadComboBox).Text = "";
            LoadCostCtr(e.Text, selected_project, (sender as RadComboBox));

        }
        protected void cb_cost_center_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT CostCenter FROM ms_cost_center WHERE CostCenterName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["CostCenter"].ToString();
                selected_cost_ctr= dr["CostCenter"].ToString();
            }
                
            dr.Close();
            con.Close();
        }
        protected void cb_cost_center_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT CostCenter FROM ms_cost_center WHERE CostCenterName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["CostCenter"].ToString();
                selected_cost_ctr = dr["CostCenter"].ToString();
            }
            dr.Close();
            con.Close();
        }
        #endregion

        #region Approval

        protected void LoadManPower(string name, string projectID, RadComboBox cb)
        {
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);

            SqlDataAdapter adapter = new SqlDataAdapter("SELECT upper(name) as name, nik, upper(jabatan) as jabatan FROM ms_manpower " +
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

        protected void cb_request_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadManPower(e.Text, selected_project, (sender as RadComboBox));

        }
        protected void cb_request_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM ms_manpower WHERE name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["nik"].ToString();
            }
            dr.Close();
            con.Close();
        }
        protected void cb_request_DataBound(object sender, EventArgs e)
        {
            ((Literal)(sender as RadComboBox).Footer.FindControl("RadComboItemsCount")).Text = Convert.ToString((sender as RadComboBox).Items.Count);
        }
        protected void cb_request_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM ms_manpower WHERE name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["nik"].ToString();
            }
            dr.Close();
            con.Close();
        }
        protected void cb_approved_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadManPower(e.Text, selected_project, (sender as RadComboBox));
        }
        protected void cb_approved_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM ms_manpower WHERE name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["nik"].ToString();
            }
            dr.Close();
            con.Close();
        }

        protected void cb_approved_DataBound(object sender, EventArgs e)
        {
            ((Literal)(sender as RadComboBox).Footer.FindControl("RadComboItemsCount")).Text = Convert.ToString((sender as RadComboBox).Items.Count);
        }


        protected void cb_approved_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM ms_manpower WHERE name = '" + (sender as RadComboBox).Text + "'";
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

        #region Priority
        protected void cb_priority_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Add("High/Urgent");
            (sender as RadComboBox).Items.Add("Medium");
            (sender as RadComboBox).Items.Add("Normal");
            (sender as RadComboBox).Items.Add("Low");
        }
        protected void cb_priority_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadComboBox).Text == "High/Urgent")
            {
                (sender as RadComboBox).SelectedValue = "1";
            }
            else if ((sender as RadComboBox).Text == "Medium")
            {
                (sender as RadComboBox).SelectedValue = "2";
            }
            else if ((sender as RadComboBox).Text == "Normal")
            {
                (sender as RadComboBox).SelectedValue = "3";
            }
            else if ((sender as RadComboBox).Text == "Low")
            {
                (sender as RadComboBox).SelectedValue = "4";
            }
        }
        protected void cb_priority_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if ((sender as RadComboBox).Text == "High/Urgent")
            {
                (sender as RadComboBox).SelectedValue = "1";
            }
            else if ((sender as RadComboBox).Text == "Medium")
            {
                (sender as RadComboBox).SelectedValue = "2";
            }
            else if ((sender as RadComboBox).Text == "Normal")
            {
                (sender as RadComboBox).SelectedValue = "3";
            }
            else if ((sender as RadComboBox).Text == "Low")
            {
                (sender as RadComboBox).SelectedValue = "4";
            }
        }

        #endregion

        #region UR Statas
        protected void cb_ur_status_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Add("Open");
            (sender as RadComboBox).Items.Add("Release");
            (sender as RadComboBox).Items.Add("Closed");
        }
        protected void cb_ur_status_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadComboBox).Text == "Open")
            {
                (sender as RadComboBox).SelectedValue = "00";
            }
            else if ((sender as RadComboBox).Text == "Release")
            {
                (sender as RadComboBox).SelectedValue = "01";
            }
            else if ((sender as RadComboBox).Text == "Closed")
            {
                (sender as RadComboBox).SelectedValue = "02";
            }
        }
        protected void cb_ur_status_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if ((sender as RadComboBox).Text == "Open")
            {
                (sender as RadComboBox).SelectedValue = "00";
            }
            else if ((sender as RadComboBox).Text == "Release")
            {
                (sender as RadComboBox).SelectedValue = "01";
            }
            else if ((sender as RadComboBox).Text == "Closed")
            {
                (sender as RadComboBox).SelectedValue = "02";
            }
        }




        #endregion

        #region UOM
        protected void LoadUom(string name,RadComboBox cb)
        {
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);

            SqlDataAdapter adapter = new SqlDataAdapter("SELECT upper(unit_code) as code,upper(unit_name) as name FROM ms_uom " +
                "WHERE stEdit <> '4' AND unit_name LIKE @text + '%'", con);
            adapter.SelectCommand.Parameters.AddWithValue("@text", name);
            DataTable dt = new DataTable();
            adapter.Fill(dt);

            cb.DataTextField = "code";
            cb.DataValueField = "code";
            cb.DataSource = dt;
            cb.DataBind();
        }
        protected void cb_uom_d_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            RadComboBox cb = (RadComboBox)sender;
            GridEditableItem item = (GridEditableItem)cb.NamingContainer;

            (sender as RadComboBox).Text = "";
            LoadUom(e.Text, (sender as RadComboBox));
        }

        #endregion

        protected void RadGrid1_InsertCommand(object sender, GridCommandEventArgs e)
        {

        }
    }
}