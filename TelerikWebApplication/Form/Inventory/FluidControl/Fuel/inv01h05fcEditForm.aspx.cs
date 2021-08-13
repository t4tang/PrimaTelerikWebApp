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

namespace TelerikWebApplication.Form.Inventory.FluidControl.Fuel
{
    public partial class inv01h05fcEditForm : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();

        private const int ItemsPerRequest = 10;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["do_code"] != null)
                {
                    fill_object(Request.QueryString["do_code"].ToString());
                    RadGrid2.DataSource = GetDataDetailTable(txt_gi_number.Text);
                    Session["actionEdit"] = "edit";
                }
                else
                {
                    cb_project.Text = public_str.sitename;
                    cb_project.SelectedValue = public_str.site;
                    dtp_transaction.SelectedDate = DateTime.Now;
                    cb_typeOut.Text = "Normal";
                    cb_typeOut.SelectedValue = "N";
                    Session["actionEdit"] = "new";
                }
            }
        }
        protected void fill_object(string id)
        {
            con.Open();
            SqlDataReader sdr;
            SqlCommand cmd = new SqlCommand("SELECT * FROM v_fuel_consumptionH WHERE do_code = '" + id + "'", con);
            sdr = cmd.ExecuteReader();
            if (sdr.Read())
            {
                txt_gi_number.Text = sdr["do_code"].ToString();
                cb_project.SelectedValue = sdr["region_code"].ToString();
                cb_project.Text = sdr["region_name"].ToString();
                cb_unit.SelectedValue = sdr["unit_code"].ToString(); ;
                cb_unit.Text = sdr["unit_code"].ToString();
                txt_tankCapacity.Value = Convert.ToDouble(sdr["FluitCap"].ToString());
                cb_costCenter.SelectedValue = sdr["dept_code"].ToString();
                cb_costCenter.Text = sdr["unit_code"].ToString();
                cb_operator.Text = sdr["driver_name"].ToString();
                cb_fuelMan.Text = sdr["fuelman"].ToString();
                cb_unitOperation.Text = sdr["unit_position"].ToString();
                cb_refueling.Text = sdr["count_out"].ToString();
                cb_LoadingType.SelectedValue = sdr["load_code"].ToString();
                cb_LoadingType.Text = sdr["load_name"].ToString();
                cb_typeOut.SelectedValue = sdr["type_out"].ToString();
                cb_typeOut.Text = sdr["type_out_name"].ToString();
                cb_infoCode.Text = sdr["info_code"].ToString();
                cb_tanki.SelectedValue = sdr["wh_code"].ToString();
                cb_tanki.Text = sdr["wh_name"].ToString();
                dtp_transaction.SelectedDate = Convert.ToDateTime(sdr["Tgl"].ToString());
                rtp_time.SelectedDate = Convert.ToDateTime(sdr["time"].ToString());
                txt_shift.Text = sdr["Shift_name"].ToString();
                txt_HM.Value = Convert.ToDouble(sdr["unit_reading"].ToString());
                txt_totHm.Value = Convert.ToDouble(sdr["hm_tot"].ToString());
                txt_lastHmKm.Value = Convert.ToDouble(sdr["unit_reading_b"].ToString());
                txt_literHmKm.Value = Convert.ToDouble(sdr["liter_km"].ToString());
                txt_hmCum.Value = Convert.ToDouble(sdr["unit_reading_com"].ToString());
                cb_approved.SelectedValue = sdr["AppBy"].ToString();
                cb_approved.Text = sdr["AppBy_name"].ToString();
                txt_remark.Text = sdr["remark"].ToString();
            }
            con.Close();

        }
        public DataTable GetDataDetailTable(string do_code)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_goods_issuedD";
            cmd.Parameters.AddWithValue("@doh_code", do_code);
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
        #region project
        private static DataTable GetProjectPrm(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT region_code, region_name FROM ms_jobsite WHERE stEdit != 4 AND region_name LIKE @text + '%'",
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
            cmd.CommandText = "SELECT region_code FROM ms_jobsite WHERE region_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
                //selected_project = dr[0].ToString();
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
            {
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            }
            dr.Close();
            con.Close();
        }
        #endregion

        #region Unit
        private static DataTable GetUnit(string text, string project)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT ms_unit.unit_code, ms_unit.model_no, ms_unit.unit_name, ms_unit.region_code, ms_unit.dept_code, ms_unit.cap_tanki " +
            "FROM ms_unit WHERE(ms_unit.active = '1') AND(ms_unit.tFuel = 1) AND(ms_unit.stedit <> '4') AND(ms_unit.region_code = @project)  ",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);
            adapter.SelectCommand.Parameters.AddWithValue("@project", project);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_unit_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetUnit(e.Text, cb_project.SelectedValue);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["unit_code"].ToString(), data.Rows[i]["unit_code"].ToString()));
            }
        }

        protected void cb_unit_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT ms_unit.unit_code, ms_unit.model_no, ms_unit.unit_name, ms_unit.region_code, ms_unit.dept_code, ms_unit.cap_tanki, " +
            "tr_doh.unit_reading , tr_doh.unit_reading_com FROM ms_unit, tr_doh WHERE ms_unit.unit_code = tr_doh.unit_code " +
            "AND tr_doh.cntrdoc = '2' AND tr_doh.unit_code = '" + (sender as RadComboBox).Text + "' AND tr_doh.type_do = '6' AND tr_doh.status_do <> '4' " +
            "AND tr_doh.tgl = (SELECT MAX(tgl) FROM tr_doh WHERE tr_doh.cntrdoc = '2' AND tr_doh.unit_code = '" + (sender as RadComboBox).Text + "' AND tr_doh.type_do = '6' AND tr_doh.status_do <> '4' )  " +
            "AND tr_doh.count_out = (SELECT MAX(count_out) FROM tr_doh WHERE tr_doh.cntrdoc = '2' AND tr_doh.unit_code = '" + (sender as RadComboBox).Text + "' AND tr_doh.type_do = '6' AND tr_doh.status_do <> '4' " +
            "AND tr_doh.tgl = (SELECT MAX(tgl) FROM tr_doh WHERE tr_doh.cntrdoc = '2' AND tr_doh.unit_code = '" + (sender as RadComboBox).Text + "' AND tr_doh.type_do = '6' AND tr_doh.status_do <> '4' ) )  ";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                cb_unit.SelectedValue = dr["unit_code"].ToString();
                txt_modelNo.Text = dr["model_no"].ToString();
                txt_tankCapacity.Text = dr["cap_tanki"].ToString();
                cb_costCenter.SelectedValue = dr["dept_code"].ToString();
                cb_costCenter.Text = dr["unit_code"].ToString();
                txt_lastHmKm.Value = Convert.ToDouble(dr["unit_reading"].ToString());
                txt_hmCum.Value = Convert.ToDouble(dr["unit_reading_com"].ToString());
                cb_refueling.Text = "First";
            }
            dr.Close();
            con.Close();

            get_refueling_count(e.Text);
        }

        protected void cb_unit_PreRender(object sender, EventArgs e)
        {

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
        protected void cb_cost_ctr_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadCostCtr(e.Text, cb_project.SelectedValue, (sender as RadComboBox));

        }
        protected void cb_cost_ctr_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
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
            cmd.CommandText = "SELECT CostCenter FROM ms_cost_center WHERE CostCenterName = '" + (sender as RadComboBox).Text + "'";
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

        protected void MP_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
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
        protected void MP_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadManPower(e.Text, cb_project.SelectedValue, (sender as RadComboBox));
        }
        protected void MP_PreRender(object sender, EventArgs e)
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

        #region Refueling
        protected void cb_refueling_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {

        }
        #endregion

        #region Unit Operation
        private static DataTable GetUnitOpr(string text, string project)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT loc_name FROM MCC_MS_LOC WHERE region_code = @project AND loc_cate_code = 'PIT' AND loc_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@project", project);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_unitOperation_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetUnitOpr(e.Text, cb_project.SelectedValue);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["loc_name"].ToString(), data.Rows[i]["loc_name"].ToString()));
            }
        }
        #endregion

        #region Loading Type
        private static DataTable GetTypeLoading(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT load_code, load_name FROM MCC_MS_TYPE_LOAD WHERE load_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_LoadingType_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetTypeLoading(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["load_name"].ToString(), data.Rows[i]["load_name"].ToString()));
            }
        }
        protected void cb_LoadingType_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT load_code FROM MCC_MS_TYPE_LOAD WHERE load_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            }
            dr.Close();
            con.Close();
        }
        protected void cb_LoadingType_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT load_code FROM MCC_MS_TYPE_LOAD WHERE load_name = '" + (sender as RadComboBox).Text + "'";
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

        #region Type Out
        protected void cb_typeOut_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Add("Normal");
            (sender as RadComboBox).Items.Add("Consignment");
        }

        protected void cb_typeOut_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if ((sender as RadComboBox).Text == "Normal")
            {
                (sender as RadComboBox).SelectedValue = "N";
            }
            else if ((sender as RadComboBox).Text == "Consignment")
            {
                (sender as RadComboBox).SelectedValue = "C";
            }
        }

        protected void cb_typeOut_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadComboBox).Text == "Normal")
            {
                (sender as RadComboBox).SelectedValue = "N";
            }
            else if ((sender as RadComboBox).Text == "Consignment")
            {
                (sender as RadComboBox).SelectedValue = "C";
            }
        }
        #endregion

        #region Tangki
        private static DataTable GetTangki(string text, string project)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT wh_code, wh_name FROM ms_warehouse WHERE tClass = 1 AND PlantCode = @project AND wh_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@project", project);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_tanki_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetTangki(e.Text, cb_project.SelectedValue);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["wh_name"].ToString(), data.Rows[i]["wh_name"].ToString()));
            }
        }

        protected void cb_tanki_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT wh_code FROM ms_warehouse WHERE wh_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            }
            dr.Close();
            con.Close();

            populate_reff_detail();
        }

        protected void cb_tanki_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT wh_code FROM ms_warehouse WHERE wh_name = '" + (sender as RadComboBox).Text + "'";
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
        protected void rtp_time_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
        {
            if (Convert.ToDouble(rtp_time.SelectedDate.Value.TimeOfDay.ToString().Substring(0, 2)) >= 06 && Convert.ToDouble(rtp_time.SelectedDate.Value.TimeOfDay.ToString().Substring(0, 2)) < 18)
            {
                txt_shift.Text = "Day";
            }
            else
            {
                txt_shift.Text = "Night";
            }
        }

        protected void RadGrid2_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            if (!IsPostBack)
            {
                (sender as RadGrid).DataSource = new string[] { };
            }

        }

        protected void btn_save_Click(object sender, EventArgs e)
        {
            long maxNo;
            string run = null;
            string trDate = string.Format("{0:dd/MM/yyyy}", dtp_transaction.SelectedDate);
            foreach (GridDataItem item in RadGrid2.MasterTableView.Items)
            {
                txt_literHmKm.Value = Convert.ToDouble((item.FindControl("txt_qty") as RadTextBox).Text) / txt_totHm.Value;
            }

            try
            {
                if (Session["actionEdit"].ToString() == "edit")
                {
                    run = txt_gi_number.Text;
                }
                else
                {
                    con.Open();
                    SqlDataReader sdr;
                    cmd = new SqlCommand("SELECT ISNULL ( MAX ( RIGHT ( tr_doh.do_code , 4 ) ) , 0 ) + 1 AS maxNo " +
                        "FROM tr_doh WHERE LEFT(tr_doh.do_code, 4) = 'FC01' " +
                        "AND SUBSTRING(tr_doh.do_code, 5, 2) = SUBSTRING('" + trDate + "', 9, 2) " +
                        "AND SUBSTRING(tr_doh.do_code, 7, 2) = SUBSTRING('" + trDate + "', 4, 2) ", con);
                    sdr = cmd.ExecuteReader();
                    if (sdr.HasRows == false)
                    {
                        //throw new Exception();
                        run = "FC01" + dtp_transaction.SelectedDate.Value.Year + dtp_transaction.SelectedDate.Value.Month + "0001";
                    }
                    else if (sdr.Read())
                    {
                        maxNo = Convert.ToInt32(sdr[0].ToString());
                        run = "FC01" + (dtp_transaction.SelectedDate.Value.Year.ToString()).Substring(dtp_transaction.SelectedDate.Value.Year.ToString().Length - 2) +
                            ("0000" + dtp_transaction.SelectedDate.Value.Month).Substring(("0000" + dtp_transaction.SelectedDate.Value.Month).Length - 2, 2) +
                            ("0000" + maxNo).Substring(("0000" + maxNo).Length - 4, 4);
                    }
                    con.Close();
                }


                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_save_fuel_consumptionH";
                cmd.Parameters.AddWithValue("@do_code", run);
                cmd.Parameters.AddWithValue("@cust_code", public_str.company_code);
                cmd.Parameters.AddWithValue("@unit_code", cb_unit.Text);
                cmd.Parameters.AddWithValue("@model_no", 0);
                cmd.Parameters.AddWithValue("@type_of_out", 0);
                cmd.Parameters.AddWithValue("@Tgl", string.Format("{0:yyyy-MM-dd}", dtp_transaction.SelectedDate.Value));
                cmd.Parameters.AddWithValue("@region_code", cb_project.SelectedValue);
                cmd.Parameters.AddWithValue("@wh_code", cb_tanki.SelectedValue);
                cmd.Parameters.AddWithValue("@dept_code", cb_costCenter.SelectedValue);
                cmd.Parameters.AddWithValue("@fuelman", cb_fuelMan.Text);
                cmd.Parameters.AddWithValue("@driver_name", cb_operator.Text);
                cmd.Parameters.AddWithValue("@unit_position", cb_unitOperation.Text);
                cmd.Parameters.AddWithValue("@load_code", cb_LoadingType.SelectedValue);
                cmd.Parameters.AddWithValue("@type_out", cb_typeOut.SelectedValue);
                cmd.Parameters.AddWithValue("@info_code", cb_infoCode.SelectedValue);
                if (txt_shift.Text == "Day")
                {
                    cmd.Parameters.AddWithValue("@shift_code", "D");
                }
                else
                {
                    cmd.Parameters.AddWithValue("@shift_code", "N");
                }
                //cmd.Parameters.AddWithValue("@count_out", DBNull.Value);
                cmd.Parameters.AddWithValue("@unit_time", Convert.ToDouble(rtp_time.SelectedDate.Value.TimeOfDay.Hours) +
                (Convert.ToDouble(rtp_time.SelectedDate.Value.TimeOfDay.Minutes) * 1 / 100));
                cmd.Parameters.AddWithValue("@broken_hours", 0);
                cmd.Parameters.AddWithValue("@unit_reading", txt_HM.Value);
                cmd.Parameters.AddWithValue("@unit_reading_b", txt_lastHmKm.Value);
                cmd.Parameters.AddWithValue("@unit_reading_com", txt_hmCum.Value);
                cmd.Parameters.AddWithValue("@time_tot", 0);
                cmd.Parameters.AddWithValue("@hm_tot", txt_totHm.Value);
                cmd.Parameters.AddWithValue("@unit_km", 0);
                cmd.Parameters.AddWithValue("@unit_km_b", 0);
                cmd.Parameters.AddWithValue("@km_tot", 0);
                cmd.Parameters.AddWithValue("@liter_km", txt_literHmKm.Value);
                cmd.Parameters.AddWithValue("@doc_type", 1);
                cmd.Parameters.AddWithValue("@OwnStamp", DateTime.Today);
                cmd.Parameters.AddWithValue("@AppBy", cb_approved.SelectedValue);
                cmd.Parameters.AddWithValue("@lastupdate", DateTime.Today);
                cmd.Parameters.AddWithValue("@userid", public_str.user_id);
                cmd.Parameters.AddWithValue("@Owner", public_str.user_id);
                cmd.Parameters.AddWithValue("@Lvl", public_str.level);
                cmd.Parameters.AddWithValue("@CntrDoc", "2");
                cmd.Parameters.AddWithValue("@remark", txt_remark.Text);
                cmd.ExecuteNonQuery();

                //Save Detail

                foreach (GridDataItem item in RadGrid2.MasterTableView.Items)
                {
                    cmd = new SqlCommand();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Connection = con;
                    cmd.CommandText = "sp_save_fuel_consumptionD";
                    cmd.Parameters.AddWithValue("@do_code", run);
                    cmd.Parameters.AddWithValue("@prod_code", (item.FindControl("lblProdCode") as Label).Text);
                    cmd.Parameters.AddWithValue("@wh_code", cb_tanki.SelectedValue);
                    cmd.Parameters.AddWithValue("@qty_out", Convert.ToDouble((item.FindControl("txt_qty") as RadTextBox).Text));
                    cmd.Parameters.AddWithValue("@prod_spec", (item.FindControl("lblSpec") as Label).Text);
                    cmd.Parameters.AddWithValue("@unit_code", (item.FindControl("lbl_uom") as Label).Text);
                    cmd.Parameters.AddWithValue("@type_out", cb_typeOut.SelectedValue);
                    cmd.Parameters.AddWithValue("@dept_code", cb_costCenter.SelectedValue);
                    cmd.Parameters.AddWithValue("@info_code", cb_infoCode.SelectedValue);
                    cmd.Parameters.AddWithValue("@Prod_code_ori", (item.FindControl("lblProdCode") as Label).Text);

                    cmd.ExecuteNonQuery();
                }

                notif.Show("Data berhasil disimpan");
                if (Session["actionEdit"].ToString() == "edit")
                {
                    ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind();", true);
                }
                else
                {
                    //inv01h05fc.tr_code = run;
                    inv01h05fc.selected_project = cb_project.SelectedValue;
                    ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind('navigateToInserted');", true);

                    if(chkContEntri.Checked == true)
                    {
                        txt_gi_number.Text = string.Empty;
                        txt_tankCapacity.Value = 0;
                        cb_LoadingType.Text = string.Empty;
                        cb_tanki.Text = string.Empty;
                        rtp_time.SelectedDate = DateTime.Today;
                        txt_shift.Text = string.Empty;
                        txt_HM.Value = 0;
                        txt_totHm.Value = 0;
                        txt_literHmKm.Value = 0;
                        cb_approved.Text = string.Empty;
                        txt_remark.Text = string.Empty;
                        RadGrid2.DataSource = new string[] { };
                        RadGrid2.DataBind();
                    }
                    else
                    {
                        txt_gi_number.Text = run;
                    }
                }

            }
            catch (Exception ex)
            {
                this.Page.ClientScript.RegisterStartupScript(this.GetType(), "ex", "alert('" + ex.Message + "');", true);

                if (Session["actionEdit"].ToString() == "new")
                {
                    cmd = new SqlCommand();
                    cmd.CommandType = CommandType.Text;
                    cmd.Connection = con;
                    cmd.CommandText = "Delete From tr_doh Where do_code = @do_code";
                    cmd.Parameters.AddWithValue("@do_code", run);
                    cmd.ExecuteNonQuery();
                }

                con.Close();
                //RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "");
            }
            finally
            {
                con.Close();
                
            }
        }

        public DataTable GetDataDetailReff(string wh_code)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT ms_warehouse.ref_prod_code as prod_code, ms_product.spec AS prod_spec, 0 AS qty_out, ms_product.unit AS uom FROM ms_warehouse " +
                "INNER JOIN ms_product ON ms_warehouse.ref_prod_code = ms_product.prod_code WHERE wh_code = @wh_code";
            cmd.Parameters.AddWithValue("@wh_code", wh_code);
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
        private void populate_reff_detail()
        {
            RadGrid2.DataSource = GetDataDetailReff(cb_tanki.SelectedValue);
            RadGrid2.DataBind();
        }

        protected void txt_HM_TextChanged(object sender, EventArgs e)
        {
            txt_totHm.Value = (sender as RadNumericTextBox).Value - txt_lastHmKm.Value;
        }

        protected void txt_qty_TextChanged(object sender, EventArgs e)
        {
            foreach (GridDataItem item in RadGrid2.MasterTableView.Items)
            {
                txt_literHmKm.Value = Convert.ToDouble((item.FindControl("txt_qty") as RadTextBox).Text) / txt_totHm.Value;
            }
        }

        protected void dtp_transaction_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
        {
            get_refueling_count(cb_unit.Text);
        }

        private void get_refueling_count(string unit_code)
        {
            double count = 0;

            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select count(*) as cnt from tr_doh where Tgl='" + string.Format("{0:yyyy-MM-dd}", dtp_transaction.SelectedDate) + "' and unit_code = '" + unit_code + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                count = Convert.ToDouble(dr["cnt"].ToString()) + 1;
            }
            dr.Close();
            con.Close();

            if (count == 1)
            {
                cb_refueling.Text = "First";
            }
            else if (count == 2)
            {
                cb_refueling.Text = "Second";
            }
            else if (count == 3)
            {
                cb_refueling.Text = "Third";
            }
            else if (count == 4)
            {
                cb_refueling.Text = "Fourth";
            }
            else if (count == 5)
            {
                cb_refueling.Text = "Fifth";
            }
            else if (count == 6)
            {
                cb_refueling.Text = "Sixth";
            }
            else if (count == 7)
            {
                cb_refueling.Text = "Seventh";
            }
            else if (count == 8)
            {
                cb_refueling.Text = "Eight";
            }
            else if (count == 9)
            {
                cb_refueling.Text = "Ninth";
            }
            else if (count == 10)
            {
                cb_refueling.Text = "Tenth";
            }
        }
    }
}