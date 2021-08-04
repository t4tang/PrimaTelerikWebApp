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

namespace TelerikWebApplication.Form.Preventive_maintenance.Notification
{
    public partial class mtc01h36 : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();

        private const int ItemsPerRequest = 10;
        public static string tr_code = null;
        public static string selected_project = null;
        RadTextBox txt_model;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lbl_form_name.Text = "Notification Entry";
                dtp_from.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
                dtp_to.SelectedDate = DateTime.Now;
                selected_project = public_str.site;
                cb_proj_prm.SelectedValue = public_str.site;
                cb_proj_prm.Text = public_str.sitename;

                tr_code = null;
                Session["action"] = "firstLoad";
                //Session["TableDetail"] = null;
                //Session["actionDetail"] = null;
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

                    Session["action"] = "list";
                }
            }
            catch (Exception ex)
            {
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
            }
        }

        #region Param
        private static DataTable GetProjectPrm(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT region_code, region_name FROM ms_jobsite WHERE stEdit != 4 AND region_name LIKE @text + '%' UNION SELECT 'ALL','ALL'",
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

        protected void cb_proj_prm_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
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

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            RadGrid1.DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), cb_proj_prm.SelectedValue);
            RadGrid1.DataBind();
        }

        protected void btnNew_Click(object sender, ImageClickEventArgs e)
        {
            Session["actionHeader"] = "headerNew";
            RadGrid1.MasterTableView.IsItemInserted = true;
            RadGrid1.MasterTableView.Rebind();
        }

        #region Main Grid
        public DataTable GetDataTable(string fromDate, string toDate, string project)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_notificationH";
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
            var PM_id = ((GridDataItem)e.Item).GetDataKeyValue("PM_id");

            try
            {
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "delete tr_PMH SET userid = @userid, lastupdate = GETDATE(), void = '4' WHERE (PM_id = @PM_id)";
                cmd.Parameters.AddWithValue("@PM_id", PM_id);
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
                ImageButton printLink = (ImageButton)e.Item.FindControl("PrintLink");
                printLink.Attributes["href"] = "javascript:void(0);";
                printLink.Attributes["onclick"] = String.Format("return ShowPreview('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["PM_id"], e.Item.ItemIndex);

            }
        }

        protected void RadGrid1_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                tr_code = null;
                GridDataItem item = e.Item as GridDataItem;
                string kode = item["PM_id"].Text;
                tr_code = kode;

                Session["actionHeader"] = "headerEdit";
                //Session["actionDetail"] = null;
            }
        }

        protected void RadGrid1_SelectedIndexChanged(object sender, EventArgs e)
        {
            foreach (GridDataItem item in RadGrid1.SelectedItems)
            {
                tr_code = item["PM_id"].Text;
            }

            Session["actionEdit"] = "list";
        }

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
                        tr_code = gItem["PM_id"].Text;
                    }
                }
            }
        }
        #endregion

        #region Notification
        private static DataTable GetNotif(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT Notif_type, Notif_type_name FROM PMMSNOTIF_TYPE WHERE stEdit != 4 AND Notif_type_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }

        protected void cb_notif_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetNotif(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["Notif_type_name"].ToString(), data.Rows[i]["Notif_type_name"].ToString()));
            }
        }

        protected void cb_notif_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT Notif_type FROM PMMSNOTIF_TYPE WHERE Notif_type_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_notif_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT Notif_type FROM PMMSNOTIF_TYPE WHERE Notif_type_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }
        #endregion

        #region Status
        private static DataTable GetStatus(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT wo_status, wo_desc FROM ms_wo_status WHERE  wo_desc LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }

        protected void cb_status_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetStatus(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["wo_desc"].ToString(), data.Rows[i]["wo_desc"].ToString()));
            }
        }

        protected void cb_status_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT wo_status FROM ms_wo_status WHERE wo_desc = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_status_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT wo_status FROM ms_wo_status WHERE wo_desc = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }
        #endregion

        #region Group
        protected void LoadGroup(string name, RadComboBox cb)
        {
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);


            SqlDataAdapter adapter = new SqlDataAdapter("SELECT com_group, com_group_name FROM ms_componenh " +
                "WHERE stedit <> '4' AND com_group_name LIKE @text + '%'", con);
            adapter.SelectCommand.Parameters.AddWithValue("@text", name);
            DataTable dt = new DataTable();
            adapter.Fill(dt);

            cb.DataTextField = "com_group_name";
            cb.DataValueField = "com_group";
            cb.DataSource = dt;
            cb.DataBind();
        }

        protected void cb_group_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadGroup(e.Text, (sender as RadComboBox));
        }

        protected void cb_group_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT com_group FROM ms_componenh WHERE com_group_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["com_group"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_group_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT com_group FROM ms_componenh WHERE com_group_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["com_group"].ToString();
            dr.Close();
            con.Close();
        }
        #endregion

        #region Component
        protected void LoadComponent(string name, RadComboBox cb)
        {
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);


            SqlDataAdapter adapter = new SqlDataAdapter("SELECT com_code, com_name FROM ms_componend " +
                "WHERE stedit <> '4' AND com_name LIKE @text + '%'", con);
            adapter.SelectCommand.Parameters.AddWithValue("@text", name);
            DataTable dt = new DataTable();
            adapter.Fill(dt);

            cb.DataTextField = "com_name";
            cb.DataValueField = "com_code";
            cb.DataSource = dt;
            cb.DataBind();
        }

        protected void cb_component_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadComponent(e.Text, (sender as RadComboBox));
        }

        protected void cb_component_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT com_code FROM ms_componend WHERE com_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["com_code"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_component_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT com_code FROM ms_componend WHERE com_name  = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["com_code"].ToString();
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

        protected void cb_Project_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
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
            cmd.CommandText = "SELECT region_code FROM ms_jobsite WHERE region_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_Project_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
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
                selected_project= dr[0].ToString();
            }   
            dr.Close();
            con.Close();
        }
        #endregion

        #region Unit
        protected void LoadUnit(string unit_code, string projectID, RadComboBox cb)
        {

            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);


            SqlDataAdapter adapter = new SqlDataAdapter("SELECT TOP(20)unit_code, unit_name, model_no, region_code, CostCenterName FROM v_notification_H_reff " +
               "WHERE region_code = @project AND unit_code LIKE @text + '%'", con);
            adapter.SelectCommand.Parameters.AddWithValue("@project", projectID);
            adapter.SelectCommand.Parameters.AddWithValue("@text", unit_code);
            DataTable dt = new DataTable();
            adapter.Fill(dt);

            cb.DataTextField = "unit_code";
            cb.DataValueField = "unit_code";
            cb.DataSource = dt;
            cb.DataBind();
        }

        protected void cb_unit_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadUnit(e.Text, selected_project, (sender as RadComboBox));
        }

        protected void cb_unit_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT * FROM v_notification_H_reff WHERE unit_code = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            }
            dr.Close();
            con.Close();
        }

        protected void cb_unit_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            RadComboBox cb = (RadComboBox)sender;
            GridEditableItem item = (GridEditableItem)cb.NamingContainer;

            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT * FROM v_notification_H_reff WHERE unit_code = '" + (sender as RadComboBox).SelectedValue + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).Text = dr["unit_code"].ToString();
                txt_model = (RadTextBox)item.FindControl("txt_model"); 
                txt_model.Text = dr["model_no"].ToString();
            }
            dr.Close();
            con.Close();
        }
        #endregion

        protected void btnSave_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridEditableItem item = (GridEditableItem)btn.NamingContainer;

            RadTextBox txt_notif = (RadTextBox)item.FindControl("txt_notif");
            RadTextBox txt_WO = (RadTextBox)item.FindControl("txt_WO");
            RadDatePicker dtp_req = (RadDatePicker)item.FindControl("dtp_req");
            RadComboBox cb_notif = (RadComboBox)item.FindControl("cb_notif");
            RadComboBox cb_status = (RadComboBox)item.FindControl("cb_status");
            RadTextBox txt_report = (RadTextBox)item.FindControl("txt_report");
            RadTextBox txt_problem = (RadTextBox)item.FindControl("txt_problem");
            RadComboBox cb_group = (RadComboBox)item.FindControl("cb_group");
            RadComboBox cb_component = (RadComboBox)item.FindControl("cb_component");
            RadComboBox cb_Project = (RadComboBox)item.FindControl("cb_Project");
            RadComboBox cb_unit = (RadComboBox)item.FindControl("cb_unit");
            RadTextBox txt_model = (RadTextBox)item.FindControl("txt_model");
            RadNumericTextBox txt_reading = (RadNumericTextBox)item.FindControl("txt_reading");
            CheckBox chk_breakdown = (CheckBox)item.FindControl("chk_breakdown");
            RadDatePicker dtp_time = (RadDatePicker)item.FindControl("dtp_time");
            RadNumericTextBox txt_breakdown = (RadNumericTextBox)item.FindControl("txt_breakdown");

            Button btnCancel = (Button)item.FindControl("btnCancel");

            long maxNo;
            string run = null;
            string trDate = string.Format("{0:dd/MM/yyyy}", dtp_req.SelectedDate);

            try
            {
                if ((sender as Button).Text == "Update")
                {
                    run = txt_notif.Text;
                }
                else
                {
                    con.Open();
                    SqlDataReader sdr;
                    cmd = new SqlCommand("SELECT ISNULL ( MAX ( RIGHT ( tr_PMH.PM_id , 4 ) ) , 0 ) + 1 AS maxNo " +
                        "FROM tr_PMH WHERE LEFT(tr_PMH.PM_id, 4) = 'RO01' " +
                        "AND SUBSTRING(tr_PMH.PM_id, 5, 2) = SUBSTRING('" + trDate + "', 9, 2) " +
                        "AND SUBSTRING(tr_PMH.PM_id, 7, 2) = SUBSTRING('" + trDate + "', 4, 2) ", con);
                    sdr = cmd.ExecuteReader();
                    if (sdr.HasRows == false)
                    {
                        //throw new Exception();
                        run = "RO01" + dtp_req.SelectedDate.Value.Year + dtp_req.SelectedDate.Value.Month + "0001";
                    }
                    else if (sdr.Read())
                    {
                        maxNo = Convert.ToInt32(sdr[0].ToString());
                        run = "RO01" + (dtp_req.SelectedDate.Value.Year.ToString()).Substring(dtp_req.SelectedDate.Value.Year.ToString().Length - 2) +
                            ("0000" + dtp_req.SelectedDate.Value.Month).Substring(("0000" + dtp_req.SelectedDate.Value.Month).Length - 2, 2) +
                            ("0000" + maxNo).Substring(("0000" + maxNo).Length - 4, 4);
                    }
                    con.Close();
                }

                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_save_notification_entryH";
                cmd.Parameters.AddWithValue("@Pm_id", run);
                cmd.Parameters.AddWithValue("@Req_date", string.Format("{0:yyyy-MM-dd}", dtp_req.SelectedDate.Value));
                cmd.Parameters.AddWithValue("@Notif_type", cb_notif.SelectedValue);
                cmd.Parameters.AddWithValue("@trans_status", cb_status.SelectedValue);
                cmd.Parameters.AddWithValue("@reportby", txt_report.Text);
                cmd.Parameters.AddWithValue("@remark", txt_problem.Text);
                cmd.Parameters.AddWithValue("@region_code", cb_Project.SelectedValue);
                cmd.Parameters.AddWithValue("@unit_code", cb_unit.SelectedValue);
                cmd.Parameters.AddWithValue("@time_reading", txt_reading.Text);
                cmd.Parameters.AddWithValue("tdown", chk_breakdown.Checked ? 1 : 0);
                cmd.Parameters.AddWithValue("@trans_date", string.Format("{0:yyyy-MM-dd}", dtp_time.SelectedDate.Value));
                cmd.Parameters.AddWithValue("@status_time", txt_breakdown.Text);
                cmd.Parameters.AddWithValue("@com_group", cb_group.SelectedValue);
                cmd.Parameters.AddWithValue("@com_code", cb_component.SelectedValue);
                cmd.Parameters.AddWithValue("@ReleaseDate", DateTime.Now);
                cmd.Parameters.AddWithValue("@userid", public_str.user_id);
                cmd.Parameters.AddWithValue("@lastupdate", DateTime.Today);
                cmd.Parameters.AddWithValue("@void", 1);
                cmd.ExecuteNonQuery();

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

                if ((sender as Button).Text == "Update")
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind();", true);
                }
                else
                {
                    mtc01h36.tr_code = run;
                    mtc01h36.selected_project = cb_Project.SelectedValue;
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind('navigateToInserted');", true);
                    (sender as Button).Text = "Update";
                    btnCancel.Text = "Close";
                }

                RadGrid1.MasterTableView.IsItemInserted = false;
            }
        }
    }
}