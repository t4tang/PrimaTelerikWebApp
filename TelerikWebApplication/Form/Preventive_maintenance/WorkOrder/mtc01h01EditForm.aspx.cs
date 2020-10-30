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
    public partial class mtc01h01EditForm : System.Web.UI.Page
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
                dtp_doc_date.SelectedDate = DateTime.Now;
                dtp_estExct.SelectedDate = DateTime.Now;
                if (Request.QueryString["trans_id"] != null)
                {
                    fill_object(Request.QueryString["trans_id"].ToString());
                    //RadGrid2.DataSource = GetDataDetailTable(Request.QueryString["sro_code"].ToString());
                    tr_code = Request.QueryString["trans_id"].ToString();
                    Session["actionEdit"] = "edit";
                    //RadTabStrip1.Tabs[1].Enabled = true;
                }
                else
                {
                    Session["actionEdit"] = "new";
                }
            }
        }
        protected void fill_object(string id)
        {
            try
            {
                con.Open();
                SqlDataReader sdr;
                SqlCommand cmd = new SqlCommand("SELECT * FROM v_work_orderH WHERE trans_id = '" + id + "'", con);
                sdr = cmd.ExecuteReader();
                if (sdr.Read())
                {
                    txt_reg_number.Text = sdr["trans_id"].ToString();
                    dtp_doc_date.SelectedDate = Convert.ToDateTime(sdr["trans_date"].ToString());
                    dtp_estExct.SelectedDate = Convert.ToDateTime(sdr["EstExcDate"].ToString());
                    cb_status.Text = sdr["statusName"].ToString();
                    cb_status.SelectedValue = sdr["trans_status"].ToString();
                    cb_project.Text = sdr["region_name"].ToString();
                    cb_project.SelectedValue = sdr["region_code"].ToString();
                    cb_reff.Text = sdr["pm_id"].ToString();
                    if (sdr["Req_date"].ToString() != null)
                    {
                        txt_reqDate.Text = null;
                    }
                    else
                    {
                        DateTime ref_date = Convert.ToDateTime(sdr["Req_date"].ToString());
                        txt_reqDate.Text = ref_date.ToString("dd/MM/yyyy");
                    }
                    cb_priority.Text = sdr["prio_desc"].ToString();
                    cb_unit.Text = sdr["unit_code"].ToString();
                    txt_unit_name.Text = sdr["model_no"].ToString();
                    txt_hm.Value = Convert.ToDouble(sdr["time_reading"].ToString());
                    txt_hmEstAccum.Value = Convert.ToDouble(sdr["hmEstAccum"].ToString());
                    cb_orderType.SelectedValue = sdr["OrderType"].ToString();
                    cb_orderType.Text = sdr["OrderName"].ToString();
                    cb_jobType.SelectedValue = sdr["job_status"].ToString();
                    cb_jobType.Text = sdr["PMAct_Name"].ToString();
                    cb_jsa.SelectedValue = sdr["jsa_code"].ToString();
                    cb_jsa.Text = sdr["jsa_name"].ToString();
                    if (sdr["tDown"].ToString() == "1")
                    {
                        chk_breakdown.Checked = true;
                        dtp_breakdownDate.SelectedDate = Convert.ToDateTime(sdr["DBDate"].ToString());
                        rtp_breakdownTime.SelectedDate = Convert.ToDateTime(sdr["breakdown_time"].ToString());
                    }
                    else
                    {
                        chk_breakdown.Checked = false;
                    }
                    DateTime? excStartDate = new DateTime();
                    excStartDate = Convert.ToDateTime(sdr["compstdate"].ToString());
                    dtp_excStartDate.SelectedDate = excStartDate;

                    DateTime? excStartTime = new DateTime();
                    excStartTime = Convert.ToDateTime(sdr["ext_start_time"].ToString());
                    rtp_excStartTime.SelectedDate = excStartTime;

                    DateTime? excFinishDate = new DateTime();
                    excFinishDate = Convert.ToDateTime(sdr["compfndate"].ToString());
                    dtp_excFinishDate.SelectedDate = excFinishDate;

                    DateTime? excFinishTime = new DateTime();
                    excFinishTime = Convert.ToDateTime(sdr["ext_fnish_time"].ToString());
                    rtp_excFinishTime.SelectedDate = excFinishTime;
                    
                    cb_mainType.Text = sdr["maintType"].ToString();
                    cb_mainType.SelectedValue = sdr["down_type"].ToString();
                    cb_compGroup.Text = sdr["com_group"].ToString();
                    cb_compGroup.SelectedValue = sdr["com_group_name"].ToString();
                    cb_comp.Text = sdr["com_code"].ToString();
                    cb_comp.SelectedValue = sdr["com_name"].ToString();
                    cb_diagnosis.Text = sdr["diag_remark"].ToString();
                    cb_diagnosis.SelectedValue = sdr["DIAG_CODE"].ToString();
                    cb_symptom.Text = sdr["sym_name"].ToString();
                    cb_symptom.SelectedValue = sdr["sym_code"].ToString();
                    txt_jobDesc.Text = sdr["remark"].ToString();
                }
                ;
            }
            catch (Exception ex)
            {
                con.Close();
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
            }
            finally
            {
                con.Close();
            }
        
        }
        #region Reff - Notif

        protected void LoadRef(string PM_id, string project, RadComboBox cb)
        {
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);

            SqlDataAdapter adapter = new SqlDataAdapter("SELECT PM_id, Req_date, unit_code, unitstatus, Notif_type_name, remark FROM v_work_order_reff WHERE region_code = @region_code " +
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
                dtp_doc_date.SelectedDate = Convert.ToDateTime(dr["Req_date"].ToString());
                cb_unit.Text = dr["unit_code"].ToString();
                txt_unit_name.Text = dr["model_no"].ToString();
                txt_hm.Value = Convert.ToDouble(dr["time_reading"].ToString());
                txt_hmEstAccum.Value = Convert.ToDouble(dr["hmEstAccum"].ToString());
                dtp_breakdownDate.SelectedDate= Convert.ToDateTime(dr["Req_date"].ToString());
                rtp_breakdownTime.SelectedDate = Convert.ToDateTime(dr["breakdown_time"].ToString());
                if (dr["tdown"].ToString() == "1")
                {
                    chk_breakdown.Checked = true;
                }
                else
                {
                    chk_breakdown.Checked = false;
                }
                cb_compGroup.Text = dr["com_group_name"].ToString();
                cb_comp.Text = dr["com_name"].ToString();
                txt_jobDesc.Text = dr["remark"].ToString();
            }

            //dr.Close();
            con.Close();

            //RadGrid2.DataSource = GetDataRefDetailTable((sender as RadComboBox).SelectedValue, cb_project.SelectedValue, cb_supplier.SelectedValue);
            //RadGrid2.DataBind();

            //txt_sub_total.Value = 0;
            //txt_tax1_value.Value = 0;
            //txt_tax2_value.Value = 0;
            //txt_tax3_value.Value = 0;
            //txt_total.Value = 0;

        }
       

        protected void cb_reff_ItemDataBound(object sender, RadComboBoxItemEventArgs e)
        {
            e.Item.Text = ((DataRowView)e.Item.DataItem)["PM_id"].ToString();
            e.Item.Value = ((DataRowView)e.Item.DataItem)["PM_id"].ToString();
        }

        protected void cb_reff_DataBound(object sender, EventArgs e)
        {
            //set the initial footer label
            ((Literal)cb_reff.Footer.FindControl("RadComboItemsCount")).Text = Convert.ToString(cb_reff.Items.Count);
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
        protected void cb_orderType_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {

        }

        protected void cb_orderType_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

        protected void cb_orderType_PreRender(object sender, EventArgs e)
        {

        }

        protected void cb_jobType_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {

        }

        protected void cb_jobType_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

        protected void cb_jobType_PreRender(object sender, EventArgs e)
        {

        }

        protected void cb_jsa_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {

        }

        protected void cb_jsa_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

        protected void cb_jsa_PreRender(object sender, EventArgs e)
        {

        }

        protected void cb_mainType_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

        protected void cb_mainType_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {

        }

        protected void cb_status_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {

        }
        
        protected void cb_priority_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {

        }

        protected void cb_priority_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

        protected void cb_priority_PreRender(object sender, EventArgs e)
        {

        }

        protected void cb_orderBy_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

        protected void cb_orderBy_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {

        }

        protected void cb_orderBy_PreRender(object sender, EventArgs e)
        {

        }

        protected void cb_recordBy_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

        protected void cb_recordBy_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {

        }

        protected void cb_recordBy_PreRender(object sender, EventArgs e)
        {

        }

        protected void cb_acknowledgedBy_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

        protected void cb_acknowledgedBy_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {

        }

        protected void cb_acknowledgedBy_PreRender(object sender, EventArgs e)
        {

        }

        protected void RadGrid2_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {

        }

        protected void RadGrid3_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {

        }

        protected void RadGrid4_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {

        }

        protected void btn_save_Click(object sender, EventArgs e)
        {

        }
    }
}