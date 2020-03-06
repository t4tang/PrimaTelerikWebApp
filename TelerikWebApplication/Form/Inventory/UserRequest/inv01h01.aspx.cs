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

namespace TelerikWebApplication.Form.Inventory.UserRequest
{
    public partial class inv01h01 : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();

        private const int ItemsPerRequest = 10;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                dtp_from.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
                dtp_to.SelectedDate = DateTime.Now;
                cb_project_prm.SelectedValue = public_str.site;

                Session["Proccess"] = "SesNew";
                dtp_ur.SelectedDate = DateTime.Now;
            }
        }
        protected void RadAjaxManager1_AjaxRequest(object sender, AjaxRequestEventArgs e)
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
                RadGrid1.MasterTableView.CurrentPageIndex = RadGrid1.MasterTableView.PageCount - 1;
                RadGrid1.Rebind();
            }
        }
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
                cb_project_prm.Items.Add(new RadComboBoxItem(data.Rows[i]["region_name"].ToString(), data.Rows[i]["region_name"].ToString()));
            }
        }
        protected void cb_project_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT region_code FROM ms_jobsite WHERE region_name = '" + cb_project_prm.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_project_prm.SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();

            
            cb_request.Text = "";
            LoadManPower(e.Value, cb_request);
            cb_approved.Text = "";
            LoadManPower(e.Value, cb_approved);

        }
        protected void cb_project_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT region_code FROM ms_jobsite WHERE region_name = '" + cb_project_prm.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_project_prm.SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            RadGrid1.DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), cb_project_prm.SelectedValue);
            RadGrid1.DataBind();
        }
        protected void RadGrid1_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            (sender as RadGrid).DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), cb_project_prm.SelectedValue);
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

        protected void RadGrid1_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            var doc_code = ((GridDataItem)e.Item).GetDataKeyValue("doc_code");

            try
            {
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "UPDATE inv01h01 SET userid = @Usr, lastupdate = GETDATE(), stEdit = '4' WHERE (doc_code = @doc_code)";
                cmd.Parameters.AddWithValue("@KoBank", doc_code);
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



        protected void btnOk_Click(object sender, EventArgs e)
        {
            foreach (GridDataItem item in RadGrid1.SelectedItems)
            {
                //txt_ur_number.Text = item["doc_code"].Text;
                //dtp_ur.SelectedDate = Convert.ToDateTime(item["doc_date"].Text);

                con.Open();
                SqlDataReader sdr;
                SqlCommand cmd = new SqlCommand("SELECT * FROM v_ur_list WHERE doc_code = '" + item["doc_code"].Text + "'", con);
                sdr = cmd.ExecuteReader();
                if (sdr.Read())
                {
                    txt_ur_number.Text = sdr["doc_code"].ToString();
                    dtp_ur.SelectedDate = Convert.ToDateTime(sdr["doc_date"].ToString());
                    dtp_exe.SelectedDate = Convert.ToDateTime(sdr["date_exec"].ToString());
                    cb_ur_status.Text = sdr["wo_desc"].ToString();
                    cb_priority.Text = sdr["prio_desc"].ToString();
                    cb_ur_type.Text = sdr["tAsset"].ToString();
                    cb_project.Text = sdr["region_name"].ToString();
                    cb_cost_center.Text = sdr["CostCenterName"].ToString();
                    cb_request.Text = sdr["RequestBy"].ToString();
                    cb_approved.Text = sdr["ApproveBy"].ToString();
                    txt_remark.Text = sdr["doc_remark"].ToString();
                    txt_uid.Text = sdr["userid"].ToString();
                    txt_lastUpdate.Text = string.Format("{0:dd/MM/yyyy}", sdr["lastupdate"].ToString());
                    txt_owner.Text = sdr["Owner"].ToString();
                    txt_printed.Text = sdr["Printed"].ToString();
                    txt_edited.Text = sdr["Edited"].ToString();
                }
                con.Close();

                RadGrid2.DataSource = GetDataDetailTable(txt_ur_number.Text);
                RadGrid2.DataBind();
                Session["Proccess"] = "SesEdit";
            }

        }
        protected void RadGrid2_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            RadGrid2.DataSource = GetDataDetailTable("");
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

        protected void btnSave_Click(object sender, ImageClickEventArgs e)
        {
            long maxNo;
            string run = null;
            string trDate = string.Format("{0:dd/MM/yyyy}", dtp_ur.SelectedDate);

            try
            {
                if(Session["Proccess"].ToString() == "SesEdit")
                {
                    run = txt_ur_number.Text;                   
                }
                else
                {
                    con.Open();
                    SqlDataReader sdr;
                    cmd = new SqlCommand("SELECT ISNULL ( MAX ( RIGHT ( inv01h01.doc_code , 4 ) ) , 0 ) + 1 AS maxNo " +
                        "FROM inv01h01 WHERE LEFT(inv01h01.doc_code, 4) = 'UR01' " +
                        "AND SUBSTRING(inv01h01.doc_code, 5, 2) = SUBSTRING('" + trDate + "', 9, 2) " +
                        "AND SUBSTRING(inv01h01.doc_code, 7, 2) = SUBSTRING('" + trDate + "', 4, 2) ", con);
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
                cmd.Parameters.AddWithValue("@userid", txt_uid.Text);
                cmd.Parameters.AddWithValue("@lastupdate", DateTime.Today);
                cmd.Parameters.AddWithValue("@region_code", public_str.site);
                cmd.Parameters.AddWithValue("@dept_code", cb_cost_center.SelectedValue);
                cmd.Parameters.AddWithValue("@priority_code", cb_priority.SelectedValue);
                cmd.Parameters.AddWithValue("@Owner", public_str.user_id);
                cmd.Parameters.AddWithValue("@OwnStamp", DateTime.Today);
                cmd.Parameters.AddWithValue("@Printed", txt_printed.Text);
                cmd.Parameters.AddWithValue("@Edited", txt_edited.Text);
                cmd.Parameters.AddWithValue("@Lvl", public_str.level);
                cmd.ExecuteNonQuery();

                Label lblsuccess = new Label();
                lblsuccess.Text = "Data saved successfully";
                lblsuccess.ForeColor = System.Drawing.Color.Blue;
                //RadGrid1.Controls.Add(lblsuccess);
                con.Close();
            }
            catch (Exception ex)
            {
                con.Close();
                Label lblError = new Label();
                lblError.Text = "Unable to save data. Reason: " + ex.Message;
                lblError.ForeColor = System.Drawing.Color.Red;
                //RadGrid1.Controls.Add(lblError);
                throw;
            }
        }

        protected void cb_ur_status_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Add("Open");
            (sender as RadComboBox).Items.Add("Realease");
            (sender as RadComboBox).Items.Add("Closed");
        }

        protected void cb_ur_status_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadComboBox).Text == "Open")
            {
                (sender as RadComboBox).SelectedValue = "0";
            }
            else if ((sender as RadComboBox).Text == "Realease")
            {
                (sender as RadComboBox).SelectedValue = "1";
            }
            else if ((sender as RadComboBox).Text == "Closed")
            {
                (sender as RadComboBox).SelectedValue = "2";
            }
        }

        protected void cb_ur_status_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if ((sender as RadComboBox).Text == "Open")
            {
                (sender as RadComboBox).SelectedValue = "0";
            }
            else if ((sender as RadComboBox).Text == "Realease")
            {
                (sender as RadComboBox).SelectedValue = "1";
            }
            else if ((sender as RadComboBox).Text == "Closed")
            {
                (sender as RadComboBox).SelectedValue = "2";
            }
        }

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

        #region Approval Man Power

        protected void LoadManPower(string projectID, RadComboBox cb)
        {
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);

            SqlDataAdapter adapter = new SqlDataAdapter("SELECT upper(name) as name, nik, upper(jabatan) as jabatan FROM inv00h26 " +
                "WHERE stedit <> '4' AND region_code = @project", con);
            adapter.SelectCommand.Parameters.AddWithValue("@project", projectID);

            DataTable dt = new DataTable();
            adapter.Fill(dt);

            cb.DataTextField = "name";
            cb.DataValueField = "nik";
            cb.DataSource = dt;
            cb.DataBind();
        }
        private static DataTable GetManPower(string name, string project)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT upper(name) as name, nik, upper(jabatan) as jabatan " +
                "FROM inv00h26 WHERE stedit <> '4' AND region_code = @project AND name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", name);
            adapter.SelectCommand.Parameters.AddWithValue("@project", project);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_request_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetManPower(e.Text, cb_project.SelectedValue);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                cb_request.Items.Add(new RadComboBoxItem(data.Rows[i]["Name"].ToString(), data.Rows[i]["Name"].ToString()));
            }
        }
        protected void cb_request_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_request.SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }
        protected void cb_request_DataBound(object sender, EventArgs e)
        {
            ((Literal)cb_request.Footer.FindControl("RadComboItemsCount")).Text = Convert.ToString((sender as RadComboBox).Items.Count);
        }

        protected void cb_approved_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetManPower(e.Text, cb_project.SelectedValue);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                cb_approved.Items.Add(new RadComboBoxItem(data.Rows[i]["Name"].ToString(), data.Rows[i]["jabatan"].ToString()));
            }
        }
        protected void cb_approved_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + cb_approved.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_approved.SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }

        #endregion

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
            }
            else if ((sender as RadComboBox).Text == "Asset")
            {
                (sender as RadComboBox).SelectedValue = "1";
            }
        }
    }
}