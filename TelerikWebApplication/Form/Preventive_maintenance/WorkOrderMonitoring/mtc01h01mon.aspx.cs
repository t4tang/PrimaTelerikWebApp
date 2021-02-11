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

namespace TelerikWebApplication.Form.Preventive_maintenance.WorkOrderMonitoring
{
    public partial class mtc01h01mon : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();

        private const int ItemsPerRequest = 10;
        public static string selected_project = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            lbl_form_name.Text = "Wprl Order Monitoring";
            dtp_from.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
            dtp_to.SelectedDate = DateTime.Now;
            selected_project = public_str.site;
            cb_proj_prm.Text = public_str.sitename;

            Session["action"] = "firstLoad";
        }

        protected void RadAjaxManager1_AjaxRequest(object sender, Telerik.Web.UI.AjaxRequestEventArgs e)
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
                    RadGrid1.MasterTableView.CurrentPageIndex = (sender as RadGrid).MasterTableView.PageCount - 1;

                    RadGrid1.MasterTableView.Items[(sender as RadGrid).Items.Count - 1].Selected = true;
                    Session["action"] = "list";
                }
            }
            catch (Exception ex)
            {
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
            }
        }

        #region Project Prm
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

        //protected void LoadCostCtr(string name, string projectID, RadComboBox cb)
        //{
        //    SqlConnection con = new SqlConnection(
        //    ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);

        //    SqlDataAdapter adapter = new SqlDataAdapter("SELECT upper(CostCenter) as code,upper(CostCenterName) as name FROM inv00h11 " +
        //        "WHERE stEdit <> '4' AND region_code = @project AND CostCenterName LIKE @text + '%'", con);
        //    adapter.SelectCommand.Parameters.AddWithValue("@project", projectID);
        //    adapter.SelectCommand.Parameters.AddWithValue("@text", name);
        //    DataTable dt = new DataTable();
        //    adapter.Fill(dt);

        //    cb.DataTextField = "name";
        //    cb.DataValueField = "code";
        //    cb.DataSource = dt;
        //    cb.DataBind();
        //}

        //protected void cb_storage_prm_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        //{
        //    (sender as RadComboBox).Text = "";
        //    LoadCostCtr(e.Text, cb_proj_prm.SelectedValue, (sender as RadComboBox));
        //}

        //protected void cb_storage_prm_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        //{
        //    con.Open();
        //    SqlCommand cmd = new SqlCommand();
        //    cmd.Connection = con;
        //    cmd.CommandType = CommandType.Text;
        //    cmd.CommandText = "SELECT CostCenter FROM inv00h11 WHERE CostCenterName = '" + (sender as RadComboBox).Text + "'";
        //    SqlDataReader dr;
        //    dr = cmd.ExecuteReader();
        //    while (dr.Read())
        //    {
        //        (sender as RadComboBox).SelectedValue = dr["CostCenter"].ToString();
        //    }
        //    dr.Close();
        //    con.Close();
        //}

        //protected void cb_storage_prm_PreRender(object sender, EventArgs e)
        //{
        //    con.Open();
        //    SqlCommand cmd = new SqlCommand();
        //    cmd.Connection = con;
        //    cmd.CommandType = CommandType.Text;
        //    cmd.CommandText = "SELECT CostCenter FROM inv00h11 WHERE CostCenterName = '" + (sender as RadComboBox).Text + "'";
        //    SqlDataReader dr;
        //    dr = cmd.ExecuteReader();
        //    while (dr.Read())
        //        (sender as RadComboBox).SelectedValue = dr["CostCenter"].ToString();
        //    dr.Close();
        //    con.Close();
        //}

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            RadGrid1.DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), selected_project);
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
            cmd.CommandText = "sp_get_WOMonitoring";
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
            RadGrid1.DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), cb_proj_prm.SelectedValue);
        }

        protected void RadGrid1_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            var transId = ((GridDataItem)e.Item).GetDataKeyValue("trans_id");

            try
            {
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "UPDATE mtc01h01 SET userid = @userid, lastupdate = GETDATE(), void = '4' WHERE (PM_id = @PM_id)";
                cmd.Parameters.AddWithValue("@trans_id", transId);
                cmd.Parameters.AddWithValue("@userid", public_str.user_id);
                cmd.ExecuteNonQuery();
                con.Close();

                Label lblOk = new Label();
                lblOk.Text = "Data deleted successfully";
                lblOk.ForeColor = System.Drawing.Color.Teal;
                (sender as RadGrid).Controls.Add(lblOk);
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
    }
}