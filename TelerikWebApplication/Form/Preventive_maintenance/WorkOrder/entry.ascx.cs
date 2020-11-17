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

namespace TelerikWebApplication.Form.Preventive_maintenance.WorkOrder
{
    public partial class entry : System.Web.UI.UserControl
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();
        private const int ItemsPerRequest = 10;
        public static string tr_code = null;

        private object _dataItem = null;
        public object DataItem
        {
            get
            {
                return this._dataItem;
            }
            set
            {
                this._dataItem = value;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                dtp_doc_date.SelectedDate = DateTime.Now;
                dtp_estExct.SelectedDate = DateTime.Now;
                if (Request.QueryString["trans_id"] != null)
                {
                    //fill_object(Request.QueryString["trans_id"].ToString());
                    //RadGrid2.DataSource = GetDataDetailTable(Request.QueryString["sro_code"].ToString());
                    tr_code = Request.QueryString["trans_id"].ToString();
                    Session["actionEdit"] = "edit";

                }
                else
                {
                    cb_status.Text = "Open";
                    cb_status.SelectedValue = "00";
                    cb_priority.Text = "High/Urgent";
                    Session["actionEdit"] = "new";

                }
            }
        }

        protected void btn_save_Click(object sender, EventArgs e)
        {
            long maxNo;
            string run = null;
            string trDate = string.Format("{0:dd/MM/yyyy}", dtp_doc_date.SelectedDate);

            try
            {
                if (btnUpdate.Text== "Update")
                {
                    run = txt_reg_number.Text;
                }
                else
                {
                    con.Open();
                    SqlDataReader sdr;
                    cmd = new SqlCommand("SELECT ISNULL ( MAX ( RIGHT ( mtc01h01.trans_id , 4 ) ) , 0 ) + 1 AS maxNo " +
                        "FROM mtc01h01 WHERE LEFT( mtc01h01.trans_id, 4) = 'WO01' " +
                        "AND SUBSTRING(mtc01h01.trans_id, 5, 2) = SUBSTRING('" + trDate + "', 9, 2) " +
                        "AND SUBSTRING(mtc01h01.trans_id, 7, 2) = SUBSTRING('" + trDate + "', 4, 2) ", con);
                    sdr = cmd.ExecuteReader();
                    if (sdr.HasRows == false)
                    {
                        //throw new Exception();
                        run = "WO01" + dtp_doc_date.SelectedDate.Value.Year + dtp_doc_date.SelectedDate.Value.Month + "0001";
                    }
                    else if (sdr.Read())
                    {
                        maxNo = Convert.ToInt32(sdr[0].ToString());
                        run = "WO01" + (dtp_doc_date.SelectedDate.Value.Year.ToString()).Substring(dtp_doc_date.SelectedDate.Value.Year.ToString().Length - 2) +
                            ("0000" + dtp_doc_date.SelectedDate.Value.Month).Substring(("0000" + dtp_doc_date.SelectedDate.Value.Month).Length - 2, 2) +
                            ("0000" + maxNo).Substring(("0000" + maxNo).Length - 4, 4);
                    }
                    con.Close();
                }

                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_save_work_orderH";
                cmd.Parameters.AddWithValue("@trans_id", run);
                cmd.Parameters.AddWithValue("@trans_date", string.Format("{0:yyyy-MM-dd}", dtp_doc_date.SelectedDate.Value));
                cmd.Parameters.AddWithValue("@trans_down", Convert.ToDouble(rtp_excStartTime.SelectedDate.Value.TimeOfDay.Hours) +
                (Convert.ToDouble(rtp_excStartTime.SelectedDate.Value.TimeOfDay.Minutes) * 1 / 100));
                cmd.Parameters.AddWithValue("@down_type", cb_mainType.SelectedValue);
                cmd.Parameters.AddWithValue("@OrderType", cb_orderType.SelectedValue);
                cmd.Parameters.AddWithValue("@job_status", cb_jobType.SelectedValue);
                if (chk_breakdown.Checked == true)
                {
                    cmd.Parameters.AddWithValue("@tDown", 1);
                    cmd.Parameters.AddWithValue("@DBDate", string.Format("{0:yyyy-MM-dd}", dtp_breakdownDate.SelectedDate.Value));
                    cmd.Parameters.AddWithValue("@comp_down_time", Convert.ToDouble(rtp_breakdownTime.SelectedDate.Value.TimeOfDay.Hours) +
                    (Convert.ToDouble(rtp_breakdownTime.SelectedDate.Value.TimeOfDay.Minutes) * 1 / 100));
                    cmd.Parameters.AddWithValue("@BDTime", Convert.ToDouble(rtp_breakdownTime.SelectedDate.Value.TimeOfDay.Hours) +
                    (Convert.ToDouble(rtp_breakdownTime.SelectedDate.Value.TimeOfDay.Minutes) * 1 / 100));
                }
                else
                {
                    cmd.Parameters.AddWithValue("@tDown", 0);
                    cmd.Parameters.AddWithValue("@DBDate", DBNull.Value);
                    cmd.Parameters.AddWithValue("@comp_down_time", DBNull.Value);
                    cmd.Parameters.AddWithValue("@BDTime", DBNull.Value);
                }
                cmd.Parameters.AddWithValue("@jsa_code", cb_jsa.SelectedValue);
                cmd.Parameters.AddWithValue("@trans_status", "00");
                cmd.Parameters.AddWithValue("@priority_code", cb_priority.SelectedValue);

                cmd.Parameters.AddWithValue("@time_reading", Convert.ToDouble(txt_hm.Value));
                cmd.Parameters.AddWithValue("@compstdate", string.Format("{0:yyyy-MM-dd}", dtp_excStartDate.SelectedDate.Value));
                cmd.Parameters.AddWithValue("@compfndate", string.Format("{0:yyyy-MM-dd}", dtp_excFinishDate.SelectedDate.Value));

                cmd.Parameters.AddWithValue("@remark", txt_jobDesc.Text);
                cmd.Parameters.AddWithValue("@unit_code", cb_unit.Text);
                cmd.Parameters.AddWithValue("@status_code", cb_status.SelectedValue);
                cmd.Parameters.AddWithValue("@region_code", cb_project.SelectedValue);
                cmd.Parameters.AddWithValue("@userid", public_str.user_id);
                cmd.Parameters.AddWithValue("@sro", "0");

                cmd.Parameters.AddWithValue("@void", "1");
                cmd.Parameters.AddWithValue("@sym_code", cb_symptom.SelectedValue);
                cmd.Parameters.AddWithValue("@com_code", cb_comp.SelectedValue);
                cmd.Parameters.AddWithValue("@pm_id", cb_reff.Text);
                cmd.Parameters.AddWithValue("@com_group", cb_compGroup.SelectedValue);
                cmd.Parameters.AddWithValue("@EstExcDate", string.Format("{0:yyyy-MM-dd}", dtp_estExct.SelectedDate.Value));

                cmd.Parameters.AddWithValue("@DIAG_CODE", cb_diagnosis.SelectedValue);
                cmd.Parameters.AddWithValue("@Lvl", public_str.level);
                cmd.ExecuteNonQuery();

            }
            catch (System.Exception ex)
            {
                con.Close();
                //RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
            }
            finally
            {
                con.Close();
                //notif.Text = "Data berhasil disimpan";
                //notif.Title = "Notification";
                //notif.Show();
                txt_reg_number.Text = run;
                
            }
        }

        #region Reff - Notif

        protected void LoadRef(string PM_id, string project, RadComboBox cb)
        {
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);

            SqlDataAdapter adapter = new SqlDataAdapter("SELECT TOP(20) PM_id, Req_date, unit_code, unitstatus, Notif_type_name, remark FROM v_work_order_reff WHERE region_code = @region_code " +
                "AND PM_id LIKE @text + '%' ORDER BY PM_id",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", PM_id);
            adapter.SelectCommand.Parameters.AddWithValue("@region_code", project);
            DataTable dt = new DataTable();
            adapter.Fill(dt);

            cb.DataTextField = "PM_id";
            cb.DataValueField = "PM_id";
            cb.DataSource = dt;
            cb.DataBind();
        }
        protected void cb_reff_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadRef(e.Text, cb_project.SelectedValue, (sender as RadComboBox));
        }
        protected void cb_reff_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select * from v_work_order_reff where PM_id = '" + (sender as RadComboBox).SelectedValue + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).Text = dr["PM_id"].ToString();
                //txt_reqDate.Text = dr["Req_date"].ToString();
                cb_unit.Text = dr["unit_code"].ToString();
                txt_unit_name.Text = dr["model_no"].ToString();
                txt_hm.Value = Convert.ToDouble(dr["time_reading"].ToString());
                txt_hmEstAccum.Value = Convert.ToDouble(dr["hmEstAccum"].ToString());
                if (dr["tdown"].ToString() == "1")
                {
                    chk_breakdown.Checked = true;
                    rtp_breakdownTime.SelectedDate = Convert.ToDateTime(dr["breakdown_time"].ToString());
                    dtp_breakdownDate.SelectedDate = Convert.ToDateTime(dr["trans_date"].ToString());
                }
                else
                {
                    chk_breakdown.Checked = false;
                }
                cb_compGroup.Text = dr["com_group_name"].ToString();
                cb_comp.Text = dr["com_name"].ToString();
                txt_jobDesc.Text = dr["remark"].ToString();
            }

            con.Close();

        }


        protected void cb_reff_ItemDataBound(object sender, RadComboBoxItemEventArgs e)
        {
            e.Item.Text = ((DataRowView)e.Item.DataItem)["PM_id"].ToString();
            e.Item.Value = ((DataRowView)e.Item.DataItem)["PM_id"].ToString();
        }

        protected void cb_reff_DataBound(object sender, EventArgs e)
        {
            //set the initial footer label
            ((Literal)(sender as RadComboBox).Footer.FindControl("RadComboItemsCount")).Text = Convert.ToString((sender as RadComboBox).Items.Count);
        }
        #endregion

        #region unit
        protected void GetUnit(string text, string project, RadComboBox cb)
        {
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);

            SqlDataAdapter adapter = new SqlDataAdapter("SELECT mtc00h16.unit_code, mtc00h16.model_no, mtc00h16.unit_name, mtc00h16.region_code, mtc00h16.dept_code, inv00h11.CostCenterName " +
                "FROM mtc00h16 INNER JOIN inv00h11 ON mtc00h16.dept_code = inv00h11.CostCenter WHERE mtc00h16.active = '1' AND mtc00h16.region_code = @project AND unit_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@project", project);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

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
            GetUnit(e.Text, cb_project.SelectedValue, (sender as RadComboBox));
        }
        protected void cb_unit_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT model_no, mtc00h16.dept_code, inv00h11.CostCenterName FROM mtc00h16 INNER JOIN " +
                "inv00h11 ON mtc00h16.dept_code = inv00h11.CostCenter WHERE unit_code = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                //(sender as RadComboBox).SelectedValue = dr[0].ToString();
                txt_unit_name.Text = dr["model_no"].ToString();
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
            cmd.CommandText = "SELECT unit_code FROM mtc00h16 WHERE unit_name = '" + (sender as RadComboBox).Text + "'";
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

        #region ItemRequest
        protected void cb_orderType_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetOrderType(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["OrderName"].ToString(), data.Rows[i]["OrderName"].ToString()));
            }
        }
        private static DataTable GetOrderType(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT OrderType, OrderName FROM mtc00h23 WHERE stEdit != 4 AND OrderName LIKE @text + '%' ",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }

        protected void cb_orderType_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT OrderType FROM mtc00h23 WHERE OrderName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["OrderType"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_orderType_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT OrderType FROM mtc00h23 WHERE OrderName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["OrderType"].ToString();
            dr.Close();
            con.Close();
        }

        #endregion

        #region Job Type
        protected void cb_jobType_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetJobType(e.Text, cb_orderType.SelectedValue);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["PMAct_Name"].ToString(), data.Rows[i]["PMAct_Name"].ToString()));
            }
        }
        private static DataTable GetJobType(string text, string OrderType)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT mtc00d23.OrderType, mtc00h22.PMAct_Name " +
            "FROM mtc00d23 INNER JOIN  mtc00h22 ON mtc00d23.PMact_type = mtc00h22.PMact_type INNER JOIN " +
            "mtc00h23 ON mtc00d23.OrderType = mtc00h23.OrderType WHERE mtc00h23.OrderType = @OrderType AND PMAct_Name LIKE @text + '%' ",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);
            adapter.SelectCommand.Parameters.AddWithValue("@OrderType", OrderType);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_jobType_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT PMAct_type FROM mtc00h22 WHERE PMAct_Name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["PMAct_type"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_jobType_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT PMAct_type FROM mtc00h22 WHERE PMAct_Name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["PMAct_type"].ToString();
            dr.Close();
            con.Close();
        }

        #endregion

        #region JSA
        private static DataTable GetJSA(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT jsa_code, jsa_name FROM mtc00h09 WHERE jsa_name LIKE @text + '%' ",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_jsa_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetJSA(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["jsa_name"].ToString(), data.Rows[i]["jsa_name"].ToString()));
            }
        }

        protected void cb_jsa_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT jsa_code FROM mtc00h09 WHERE jsa_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["jsa_code"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_jsa_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT jsa_code FROM mtc00h09 WHERE jsa_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["jsa_code"].ToString();
            dr.Close();
            con.Close();
        }

        #endregion

        #region Main. Type
        protected void cb_mainType_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if ((sender as RadComboBox).Text == "Schedule Maintenance")
            {
                (sender as RadComboBox).SelectedValue = "SM";
            }
            else if ((sender as RadComboBox).Text == "Unschedule Maintenance")
            {
                (sender as RadComboBox).SelectedValue = "UM";
            }
            else if ((sender as RadComboBox).Text == "Accident")
            {
                (sender as RadComboBox).SelectedValue = "AC";
            }
        }

        protected void cb_mainType_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Add("Schedule Maintenance");
            (sender as RadComboBox).Items.Add("Unschedule Maintenance");
            (sender as RadComboBox).Items.Add("Accident");
        }
        protected void cb_mainType_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadComboBox).Text == "Schedule Maintenance")
            {
                (sender as RadComboBox).SelectedValue = "SM";
            }
            else if ((sender as RadComboBox).Text == "Unschedule Maintenance")
            {
                (sender as RadComboBox).SelectedValue = "UM";
            }
            else if ((sender as RadComboBox).Text == "Accident")
            {
                (sender as RadComboBox).SelectedValue = "AC";
            }
        }
        #endregion

        #region status
        protected void cb_status_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Add("Open");
            (sender as RadComboBox).Items.Add("Realease");
            (sender as RadComboBox).Items.Add("Closed");
        }
        protected void cb_status_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
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

        protected void cb_status_PreRender(object sender, EventArgs e)
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
        #endregion

        #region Priority
        protected void cb_priority_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Add("High/Urgent");
            (sender as RadComboBox).Items.Add("Medium");
            (sender as RadComboBox).Items.Add("Normal");
            (sender as RadComboBox).Items.Add("Low");
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


        #endregion

        #region Comp Group
        private static DataTable GetCompGroup(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT com_group, com_group_name FROM mtc00h26 WHERE com_group_name LIKE @text + '%' ",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_compGroup_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetCompGroup(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["com_group_name"].ToString(), data.Rows[i]["com_group_name"].ToString()));
            }
        }

        protected void cb_compGroup_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT com_group FROM mtc00h26 WHERE com_group_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["com_group"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_compGroup_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT com_group FROM mtc00h26 WHERE com_group_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["com_group"].ToString();
            dr.Close();
            con.Close();
        }
        #endregion

        #region comp
        private static DataTable GetComp(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT com_code, com_name FROM mtc00h28 WHERE com_name LIKE @text + '%' ",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_comp_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetComp(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["com_name"].ToString(), data.Rows[i]["com_name"].ToString()));
            }
        }

        protected void cb_comp_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT com_code FROM mtc00h28 WHERE com_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["com_code"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_comp_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT com_code FROM mtc00h28 WHERE com_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["com_code"].ToString();
            dr.Close();
            con.Close();
        }
        #endregion

        #region Diagnosis
        private static DataTable GetDiagnosis(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT diag_code, diag_remark FROM mtc00h01 WHERE diag_remark LIKE @text + '%' ",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_diagnosis_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetDiagnosis(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["diag_remark"].ToString(), data.Rows[i]["diag_remark"].ToString()));
            }
        }

        protected void cb_diagnosis_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT diag_code FROM mtc00h01 WHERE diag_remark = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["diag_code"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_diagnosis_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT diag_code FROM mtc00h01 WHERE diag_remark = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["diag_code"].ToString();
            dr.Close();
            con.Close();
        }
        #endregion

        #region symptom
        private static DataTable GetSympton(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT sym_code, sym_name FROM mtc00h14 WHERE sym_name LIKE @text + '%' ",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_symptom_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetSympton(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["sym_name"].ToString(), data.Rows[i]["sym_name"].ToString()));
            }
        }

        protected void cb_symptom_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT sym_code FROM mtc00h14 WHERE sym_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["sym_code"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_symptom_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT sym_code FROM mtc00h14 WHERE sym_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["sym_code"].ToString();
            dr.Close();
            con.Close();
        }
        #endregion

        #region Operation
        public DataTable GetOperation(string trans_id)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT  chart_code AS OprCode, trans_id, formula, mtc00h25.OprName FROM mtc01h03, mtc00h25 WHERE mtc00h25.OprCode = mtc01h03.chart_code AND trans_id = @trans_id";
            cmd.Parameters.AddWithValue("@trans_id", trans_id);
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

        protected void RadGrid4_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            if (tr_code == null)
            {
                (sender as RadGrid).DataSource = new string[] { };
            }
            else
            {
                (sender as RadGrid).DataSource = GetOperation(tr_code);
            }
        }

        
        protected void cb_operation_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            string sql = "SELECT OprCode, OprName  FROM mtc00h25 WHERE stEdit != 4 AND OprName LIKE @text + '%'";
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
                item.Text = row["OprName"].ToString();
                item.Value = row["OprCode"].ToString();
                item.Attributes.Add("OprName", row["OprName"].ToString());

                comboBox.Items.Add(item);

                item.DataBind();
            }
        }
        protected void cb_operation_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "SELECT OprCode FROM mtc00h25 WHERE OprName = '" + (sender as RadComboBox).Text + "'";

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                foreach (DataRow dtr in dt.Rows)
                {
                    RadComboBox cb = (RadComboBox)sender;
                    GridEditableItem item = (GridEditableItem)cb.NamingContainer;
                    Label lbl_chart_code = (Label)item.FindControl("lbl_chart_code_edt");

                    lbl_chart_code.Text = dtr["OprCode"].ToString();
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

        #region BD Status
        protected void cb_bd_status_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            string sql = "SELECT wo_status, wo_desc, mType, remark FROM mtc00h19 WHERE  (mType NOT IN ('0', '4')) AND wo_desc LIKE @text + '%'";
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
                item.Text = row["wo_desc"].ToString();
                item.Value = row["wo_status"].ToString();
                item.Attributes.Add("wo_desc", row["wo_desc"].ToString());
                item.Attributes.Add("remark", row["remark"].ToString());

                comboBox.Items.Add(item);

                item.DataBind();
            }
        }
        #endregion

        #region Eksternal Service
        protected void cb_supplier_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            string sql = "SELECT supplier_code, supplier_name FROM pur00h01 WHERE stEdit != 4 AND supplier_name LIKE @text + '%'";
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
                item.Text = row["supplier_name"].ToString();
                item.Value = row["supplier_code"].ToString();
                item.Attributes.Add("supplier_name", row["supplier_name"].ToString());

                comboBox.Items.Add(item);

                item.DataBind();
            }
        }
        #endregion

        #region Material Request
        public DataTable GetMatrialRequest(string trans_id)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT prod_type, part_code, part_desc, part_qty, part_unit, deliv_date, CAST(tWarranty AS Bit) AS tWarranty, remark, sro_code, trans_id " +
                "FROM inv01d02  WHERE trans_id = @trans_id";
            cmd.Parameters.AddWithValue("@trans_id", trans_id);
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
        protected void RadGrid5_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            if (tr_code == null)
            {
                (sender as RadGrid).DataSource = new string[] { };
                //(sender as RadGrid).DataSource = GetMatrialRequest(tr_code);
            }
            else
            {
                (sender as RadGrid).DataSource = GetMatrialRequest(tr_code);
            }
        }

        protected void cb_prod_code_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {

        }

        protected void cb_prod_code_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {

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
        protected void cb_approval_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadManPower(e.Text, cb_project.SelectedValue, (sender as RadComboBox));
        }

        protected void cb_approval_DataBound(object sender, EventArgs e)
        {
            ((Literal)(sender as RadComboBox).Footer.FindControl("RadComboItemsCount")).Text = Convert.ToString((sender as RadComboBox).Items.Count);
        }

        protected void cb_approval_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_approval_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }        

        #endregion

       
    }
}