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
    public partial class mtc01h36EditForm : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();

        private const int ItemsPerRequest = 10;
        public static string tr_code = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                dtp_req.SelectedDate = DateTime.Now;
                if (Request.QueryString["PM_id"] != null)
                {

                    fill_object(Request.QueryString["PM_id"].ToString());

                    tr_code = Request.QueryString["PM_id"].ToString();
                    Session["actionEdit"] = "edit";
                }
                else
                {

                    Session["actionEdit"] = "new";
                    cb_status.Text = "Open";
                    cb_status.SelectedValue = "00";
                }
            }
        }

        private static string GetStatusMessage(int offset, int total)
        {
            if (total <= 0)
                return "No matches";

            return String.Format("Items <b>1</b>-<b>{0}</b> out of <b>{1}</b>", offset, total);
        }

        #region notif
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
                cb_notif.Items.Add(new RadComboBoxItem(data.Rows[i]["Notif_type_name"].ToString(), data.Rows[i]["Notif_type_name"].ToString()));
            }
        }

        protected void cb_notif_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT Notif_type FROM PMMSNOTIF_TYPE WHERE Notif_type_name = '" + cb_notif.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_notif.SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_notif_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT Notif_type FROM PMMSNOTIF_TYPE WHERE Notif_type_name = '" + cb_notif.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_notif.SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }
        #endregion

        #region project
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
                cb_Project.Items.Add(new RadComboBoxItem(data.Rows[i]["region_name"].ToString(), data.Rows[i]["region_name"].ToString()));
            }
        }

        protected void cb_Project_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT region_code FROM ms_jobsite WHERE region_name = '" + cb_Project.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_Project.SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_Project_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT region_code FROM ms_jobsite WHERE region_name = '" + cb_Project.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_Project.SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }
        #endregion

        #region unit
        protected void LoadUnit(string unit_code, string projectID, RadComboBox cb)
        {
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);


            SqlDataAdapter adapter = new SqlDataAdapter("SELECT unit_code, unit_name, model_no, region_code, CostCenterName FROM v_notification_H_reff " +
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
            LoadUnit(e.Text, cb_Project.SelectedValue, (sender as RadComboBox));
        }

        protected void cb_unit_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
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
                txt_model.Text = dr["model_no"].ToString();
            }
            dr.Close();
            con.Close();
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
        #endregion

        #region group
        protected void LoadGroup(string name, RadComboBox cb)
        {
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);


            SqlDataAdapter adapter = new SqlDataAdapter("SELECT com_group, com_group_name FROM mtc00h26 " +
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
            cb_group.Text = "";
            LoadGroup(e.Text, cb_group);
        }

        protected void cb_group_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT com_group FROM mtc00h26 WHERE com_group_name = '" + cb_group.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_group.SelectedValue = dr["com_group"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_group_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT com_group FROM mtc00h26 WHERE com_group_name = '" + cb_group.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_group.SelectedValue = dr["com_group"].ToString();
            dr.Close();
            con.Close();
        }
        #endregion

        #region component
        protected void LoadComponent(string name, RadComboBox cb)
        {
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);


            SqlDataAdapter adapter = new SqlDataAdapter("SELECT com_code, com_name FROM mtc00h28 " +
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
            cb_component.Text = "";
            LoadComponent(e.Text, cb_component);
        }

        protected void cb_component_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT com_code FROM mtc00h28 WHERE com_name = '" + cb_component.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_component.SelectedValue = dr["com_code"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_component_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT com_code FROM mtc00h28 WHERE com_name = '" + cb_component.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_component.SelectedValue = dr["com_code"].ToString();
            dr.Close();
            con.Close();
        }
        #endregion

        protected void fill_object(string id)
        {
            try
            {
                con.Open();
                SqlDataReader sdr;
                SqlCommand cmd = new SqlCommand("SELECT * FROM v_notification WHERE PM_id = '" + id + "'", con);
                sdr = cmd.ExecuteReader();
                if (sdr.Read())
                {
                    txt_notif.Text = sdr["PM_id"].ToString();
                    //txt_WO.Text = sdr["trans_id"].ToString();
                    dtp_req.SelectedDate = Convert.ToDateTime(sdr["Req_date"].ToString());
                    cb_notif.Text = sdr["Notif_type_name"].ToString();
                    cb_notif.SelectedValue = sdr["Notif_type"].ToString();
                    cb_status.Text = sdr["trans_status"].ToString();
                    cb_status.SelectedValue = sdr["trans_status"].ToString();
                    txt_report.Text = sdr["reportby"].ToString();
                    txt_problem.Text = sdr["remark"].ToString();
                    cb_Project.Text = sdr["region_name"].ToString();
                    cb_unit.Text = sdr["unit_code"].ToString();
                    txt_model.Text = sdr["model_no"].ToString();
                    txt_reading.Text = sdr["time_reading"].ToString();
                    if (sdr["trans_date"].ToString() != null) { dtp_time.SelectedDate = (DateTime?)(sdr.IsDBNull(5) ? null : sdr["trans_date"]);}
                    if (sdr["status_time"].ToString() != null) { Convert.ToDateTime(sdr["status_time"].ToString()); }
                    cb_group.Text = sdr["com_group_name"].ToString();
                    cb_group.SelectedValue = sdr["com_group"].ToString();
                    cb_component.Text = sdr["com_name"].ToString();
                    cb_component.Text = sdr["com_code"].ToString();
                }
                con.Close();

            }
            catch (Exception ex)
            {
                con.Close();
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
            }
            
        }

        protected void btn_save_Click(object sender, EventArgs e)
        {
            long maxNo;
            string run = null;
            string trDate = string.Format("{0:dd/MM/yyyy}", dtp_req.SelectedDate);

            try
            {
                if (Session["action"].ToString() == "edit")
                {
                    run = txt_notif.Text;
                }
                else
                {
                    con.Open();
                    SqlDataReader sdr;
                    cmd = new SqlCommand("SELECT ISNULL ( MAX ( RIGHT ( mtc01h36.PM_id , 4 ) ) , 0 ) + 1 AS maxNo " +
                        "FROM mtc01h36 WHERE LEFT(mtc01h36.PM_id, 4) = 'RO01' " +
                        "AND SUBSTRING(mtc01h36.PM_id, 5, 2) = SUBSTRING('" + trDate + "', 9, 2) " +
                        "AND SUBSTRING(mtc01h36.PM_id, 7, 2) = SUBSTRING('" + trDate + "', 4, 2) ", con);
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
                cmd.ExecuteNonQuery();

                con.Close();
                notif.Text = "Data berhasil disimpan";
                notif.Title = "Notification";
                notif.Show();
                txt_notif.Text = run;

            }
            catch (Exception ex)
            {
                con.Close();
                //Response.Write("<font color='red'>" + ex.Message + "</font>");
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "");
                //RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn","");
            }
        }
        #region status
        private static DataTable GetStatus(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT wo_status, wo_desc FROM mtc00h19 WHERE  wo_desc LIKE @text + '%'",
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
                cb_notif.Items.Add(new RadComboBoxItem(data.Rows[i]["wo_desc"].ToString(), data.Rows[i]["wo_desc"].ToString()));
            }
        }

        protected void cb_status_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT wo_status FROM mtc00h19 WHERE wo_desc = '" + cb_status.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_status.SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_status_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT wo_status FROM mtc00h19 WHERE wo_desc = '" + cb_status.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_status.SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }
        #endregion

        
    }
}