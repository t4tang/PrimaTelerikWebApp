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

namespace TelerikWebApplication.Form.Preventive_maintenance.ReadingRecording
{
    public partial class mtc01h06 : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();

        private const int ItemsPerRequest = 10;

        public static string unit_code = null;
        public static string tr_name { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                lbl_form_name.Text = "Equipment Reading Recording";
                dtp_from.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
                dtp_to.SelectedDate = DateTime.Now;
            }
        }
        protected void RadGrid1_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            RadGrid1.DataSource = GetDataTable(public_str.site);
        }
        public DataTable GetDataTable(string project)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            if(project != "HOF")
                cmd.CommandText = "SELECT ms_unit.unit_code, ms_unit.model_no, ms_unit.key_no, ms_unit.region_code, ms_jobsite.region_name " +
                "FROM ms_unit INNER JOIN ms_jobsite ON ms_unit.region_code = ms_jobsite.region_code WHERE ms_unit.active = '1' AND ms_unit.region_code = @region_code";
            else
                cmd.CommandText = "SELECT ms_unit.unit_code, ms_unit.model_no, ms_unit.key_no, ms_unit.region_code, ms_jobsite.region_name " +
                "FROM ms_unit INNER JOIN ms_jobsite ON ms_unit.region_code = ms_jobsite.region_code WHERE ms_unit.active = '1'";
            
            cmd.Parameters.AddWithValue("@region_code", project);
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

        protected void RadGrid1_SelectedIndexChanged(object sender, EventArgs e)
        {
            foreach (GridDataItem item in RadGrid1.SelectedItems)
            {
                unit_code = item["unit_code"].Text;
            }

            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT tr_reading.unit_code, tr_reading.region_code, reading_date2, reading_amount1, reading_amount2, wh, reading_km1, reading_km2, " +
                               "reading_date, broken_hm, reading_amount3, tr_reading.lastupdate, ms_unit.reading_code, ms_jobsite.region_name " +
                               "FROM tr_reading, ms_unit, ms_jobsite WHERE tr_reading.unit_code = ms_unit.unit_code AND ms_jobsite.region_code = tr_reading.region_code " +
                               "AND(tr_reading.unit_code = '" + unit_code + "') AND (reading_date = (SELECT Max(tr_reading.reading_date) " +
                               "FROM tr_reading WHERE tr_reading.unit_code = '" + unit_code + "'))";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                cb_unit.Text = unit_code;
                cb_project.Text = dr["region_name"].ToString();
                cb_project.SelectedValue = dr["region_code"].ToString();
                txt_type.Text = dr["reading_code"].ToString();
                dtp_last_reading_date.SelectedDate = Convert.ToDateTime(dr["reading_date"].ToString());
                txt_last_HM_KM.Value = Convert.ToDouble(dr["reading_amount3"].ToString());
                txt_last_HM_KM_accum.Value = Convert.ToDouble(dr["reading_amount3"].ToString());
                dtp_current_date.SelectedDate = DateTime.Now;
            }
            dr.Close();
            con.Close();
            
        }
        protected void RadAjaxManager1_AjaxRequest(object sender, AjaxRequestEventArgs e)
        {
            //if (e.Argument == "Rebind")
            //{
            //    RadGrid1.MasterTableView.SortExpressions.Clear();
            //    RadGrid1.MasterTableView.GroupByExpressions.Clear();
            //    RadGrid1.Rebind(); /* Kemudian RadGrid1 akan sorting data by lastupdate (lihat sp_get_purchase_requestH*/

            //    RadGrid1.MasterTableView.Items[0].Selected = true;

            //    //RadGrid2.DataSource = GetDataDetailTable(tr_code);
            //    //RadGrid2.Rebind();
            //}
            //else if (e.Argument == "RebindAndNavigate")
            //{
            //    RadGrid1.MasterTableView.SortExpressions.Clear();
            //    RadGrid1.MasterTableView.GroupByExpressions.Clear();
            //    //RadGrid1.DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), selected_project);
            //    RadGrid1.DataBind();
            //    //RadGrid1.MasterTableView.CurrentPageIndex = RadGrid1.MasterTableView.PageCount - 1;
            //    //RadGrid1.MasterTableView.Items[RadGrid1.Items.Count - 1].Selected = true;
            //    RadGrid1.MasterTableView.Items[0].Selected = true;
            //    //RadGrid2.DataSource = GetDataDetailTable(tr_code);
            //    //RadGrid2.Rebind();
            //    Session["action"] = "list";
            //}


        }

        protected void RadGrid2_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            (sender as RadGrid).DataSource = new string[] { };
        }
        public DataTable GetDataReading(string unit)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT tr_reading.unit_code, tr_reading.reading_date, tr_reading.reading_amount3, tr_reading.reading_amount1, tr_reading.unit_code, tr_reading.wh, tr_reading.broken_hm, " +
            "tr_reading.region_code, tr_reading.reading_date2, tr_reading.reading_amount2, tr_reading.reading_km1, tr_reading.reading_km2 " +
            "FROM tr_reading WHERE tr_reading.unit_code = @unit_code AND tr_reading.reading_date between @start_date AND @end_date ORDER BY tr_reading.reading_date Desc";
            cmd.Parameters.AddWithValue("@unit_code", unit);
            cmd.Parameters.AddWithValue("@start_date", dtp_from.SelectedDate);
            cmd.Parameters.AddWithValue("@end_date", dtp_to.SelectedDate);
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

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            RadGrid2.DataSource = GetDataReading(unit_code);
            RadGrid2.DataBind();
        }

        protected void btnSave_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_save_reading_recording";
                cmd.Parameters.AddWithValue("@unit_code", cb_unit.Text);
                cmd.Parameters.AddWithValue("@region_code", cb_project.SelectedValue);
                cmd.Parameters.AddWithValue("@reading_amount1", txt_HM.Value);
                cmd.Parameters.AddWithValue("@last_reading", txt_last_HM_KM.Value);
                cmd.Parameters.AddWithValue("@reading_date", dtp_current_date.SelectedDate);
                cmd.Parameters.AddWithValue("@reading_amount3", txt_HM.Value);
                if (chk_breakdown.Checked == true)
                {
                    cmd.Parameters.AddWithValue("@broken_hm", "1");
                }
                else
                {
                    cmd.Parameters.AddWithValue("@broken_hm", "0");
                }
                cmd.ExecuteNonQuery();                             

                con.Close();

            }
            catch (Exception ex)
            {
                con.Close();
                Response.Write("<font color='red'>" + ex.Message + "</font>");
            }
            finally
            {
                get_last_reading(cb_unit.Text);
                txt_HM.Value = 0;
                RadGrid2.DataSource = GetDataReading(unit_code);
                RadGrid2.DataBind();
            }
        }
        
        void get_last_reading(string unit)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT tr_reading.unit_code, tr_reading.region_code, ms_jobsite.region_name, tr_reading.reading_date2, tr_reading.reading_amount1, tr_reading.reading_amount2, " +
            "tr_reading.wh, tr_reading.reading_km1, tr_reading.reading_km2, tr_reading.reading_date, tr_reading.broken_hm, tr_reading.reading_amount3, tr_reading.lastupdate " +
            "FROM tr_reading INNER JOIN ms_jobsite ON tr_reading.region_code = ms_jobsite.region_code WHERE(tr_reading.unit_code = '" + unit + "') " +
            "AND(tr_reading.reading_date = (SELECT MAX(reading_date) AS Expr1 FROM tr_reading AS tr_reading_1 WHERE(unit_code = '" + unit + "'))) ";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                cb_project.SelectedValue = dr[1].ToString();
                cb_project.Text = dr["region_name"].ToString();
                cb_unit.Text = unit;
                txt_type.Text = "Hours";
                dtp_last_reading_date.SelectedDate = Convert.ToDateTime(dr["reading_date"].ToString());
                txt_last_HM_KM.Value = Convert.ToDouble(dr["reading_amount3"].ToString());
                txt_last_HM_KM_accum.Value = Convert.ToDouble(dr["reading_amount3"].ToString());
                dtp_current_date.SelectedDate = DateTime.Now;
            }
            dr.Close();
            con.Close();
        }
        protected void btnNew_Click(object sender, ImageClickEventArgs e)
        {
            //GridDataItem item = e.Item as GridDataItem;
            string selected_unit = null;
            foreach (GridDataItem item in RadGrid1.SelectedItems)
            {
                selected_unit = item["unit_code"].Text;
            }

            if(selected_unit != null)
            {
                get_last_reading(selected_unit);

                //txt_HM.Value = 0;
                //btnSave.Enabled = true;
                //btnSave.ImageUrl = "~/Images/simpan.png";
            }
            else
            {
                cb_project.SelectedValue = null;
                cb_project.Text = string.Empty;
                cb_unit.Text = string.Empty;
                txt_type.Text = "Hours";
                dtp_last_reading_date.SelectedDate = null;
                txt_last_HM_KM.Value = 0;
                txt_last_HM_KM_accum.Value = 0;
                dtp_current_date.SelectedDate = DateTime.Now;

                btnSave.Enabled = false;
                btnSave.ImageUrl = "~/Images/simpan-gray.png";
            }
            
        }

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
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
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
            LoadUnit(e.Text, cb_project.SelectedValue, (sender as RadComboBox));
        }

        protected void cb_unit_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT tr_reading.unit_code, tr_reading.region_code, reading_date2, reading_amount1, reading_amount2, wh, reading_km1, reading_km2, " +
                               "reading_date, broken_hm, reading_amount3, tr_reading.lastupdate, ms_unit.reading_code, ms_jobsite.region_name " +
                               "FROM tr_reading, ms_unit, ms_jobsite WHERE tr_reading.unit_code = ms_unit.unit_code AND ms_jobsite.region_code = tr_reading.region_code " +
                               "AND(tr_reading.unit_code = '" + (sender as RadComboBox).SelectedValue + "') AND (reading_date = (SELECT Max(tr_reading.reading_date) " +
                               "FROM tr_reading WHERE tr_reading.unit_code = '" + (sender as RadComboBox).SelectedValue + "'))";
            //cmd.CommandText = "SELECT * FROM mtc00h16 WHERE unit_code = '" + (sender as RadComboBox).SelectedValue + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                cb_project.Text= dr["region_name"].ToString();
                cb_project.SelectedValue = dr["region_code"].ToString();
                txt_type.Text = dr["reading_code"].ToString();
                dtp_last_reading_date.SelectedDate= Convert.ToDateTime(dr["reading_date"].ToString());
                txt_last_HM_KM.Value = Convert.ToDouble(dr["reading_amount3"].ToString());
                txt_last_HM_KM_accum.Value = Convert.ToDouble(dr["reading_amount1"].ToString());
                dtp_current_date.SelectedDate = DateTime.Now;
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
    }
}