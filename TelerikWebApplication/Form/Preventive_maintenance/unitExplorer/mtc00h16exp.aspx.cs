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

namespace TelerikWebApplication.Form.Preventive_maintenance.unitExplorer
{
    public partial class mtc00h16exp : System.Web.UI.Page
    {
        public static string tr_code = null;
        public static string selected_unit = null;
        string selected_project = null;
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand(); 

        protected void Page_Load(object sender, EventArgs e)
        {
            if(!Page.IsPostBack)
            {
                selected_unit = null;
                populateTree(RadTreeView1);
                selected_project = public_str.site; 
            }
        }

        //private void populate_detail()
        //{
        //    if (tr_code == null)
        //    {
        //        RadGrid2.DataSource = new string[] { };
        //        RadGrid2.DataBind();
        //        //RadGrid4.DataSource = new string[] { };
        //        //RadGrid4.DataBind();
        //        //RadGrid6.DataSource = new string[] { };
        //        //RadGrid6.DataBind();
        //    }
        //    else
        //    {
        //        RadGrid2.DataSource = GetDataWOExplorerTable(tr_code);
        //        RadGrid2.DataBind();
        //        //RadGrid4.DataSource = GetDataHMRTable(tr_code);
        //        //RadGrid4.DataBind();
        //        //RadGrid6.DataSource = GetDataNotifTable(tr_code);
        //        //RadGrid6.DataBind();

        //    }

        //}

        internal class SiteDataItem
        {
            private string text;
            private int id;
            private int parentId;

            public string Text
            {
                get { return text; }
                set { text = value; }
            }


            public int ID
            {
                get { return id; }
                set { id = value; }
            }

            public int ParentID
            {
                get { return parentId; }
                set { parentId = value; }
            }

            public SiteDataItem(int id, int parentId, string text)
            {
                this.id = id;
                this.parentId = parentId;
                this.text = text;
            }
        }
        private static void populateTree(RadTreeView treeView)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT DISTINCT(mtc00h16.region_code) as ID, region_name as node, NULL as parent FROM inv00h09, mtc00h16 WHERE mtc00h16.region_code =  inv00h09.region_code " +
            "UNION SELECT unit_code, unit_code as node, region_code as parent FROM mtc00h16 WHERE active = 1", ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);

            DataSet links = new DataSet();

            adapter.Fill(links);
            treeView.DataTextField = "node";
            treeView.DataFieldID = "ID";
            treeView.DataFieldParentID = "parent";

            treeView.DataSource = links;
            treeView.DataBind();
        }

        protected void RadTreeView1_NodeClick(object sender, RadTreeNodeEventArgs e)
        {
            selected_unit = RadTreeView1.SelectedNode.Text;
            lbl_unit_description.Text = selected_unit;
            general_info(selected_unit);
        }

        #region General Information
        private void general_info(string unit_code)
        {
            try
            {
                con.Open();
                SqlDataReader sdr;
                SqlCommand cmd = new SqlCommand("SELECT * FROM v_equipment_info WHERE unit_code = '" + unit_code + "'", con);
                sdr = cmd.ExecuteReader();
                if (sdr.Read())
                {
                    txt_eqp_type.Text = sdr["unit_name"].ToString();
                    txt_eqp_kind.Text = sdr["equip_kind"].ToString();
                    txt_manufacture.Text = sdr["manu_name"].ToString();
                    txt_model.Text = sdr["model_no"].ToString();
                    txt_status.Text = sdr["equ_status"].ToString();
                    txt_reading_type.Text = sdr["reading_code"].ToString();
                    txt_readType2.Text = sdr["reading_code2"].ToString();
                    txt_opr_hours.Text = sdr["hour_avai"].ToString();
                    txt_category.Text = sdr["category"].ToString();
                    txt_class.Text = sdr["class_name"].ToString();
                    txt_supplier.Text = sdr["supplier_name"].ToString();

                    DateTime? purc_date = Convert.ToDateTime(sdr["pur_date"].ToString());
                    if (purc_date?.ToString("dd/MM/yyyy") != "01/01/1900")
                    {                        
                        txt_purc_date.Text = purc_date?.ToString("dd/MM/yyyy");
                    }
                    else
                    {
                        txt_purc_date.Text = "";
                    }

                    DateTime? arr_date = Convert.ToDateTime(sdr["arr_date"].ToString());
                    if (arr_date?.ToString("dd/MM/yyyy") != "01/01/1900")
                    {                       
                        txt_arrived_date.Text = arr_date?.ToString("dd/MM/yyyy");
                    }
                    else
                    {
                        txt_arrived_date.Text = "";
                    }

                    txt_engine_no.Text = sdr["engine_no"].ToString();
                    txt_engine_model.Text = sdr["engine_size"].ToString();
                    txt_sn.Text = sdr["key_no"].ToString();
                    txt_condition.Text = sdr["con_status"].ToString();
                    txt_project.Text = sdr["region_code"].ToString();
                    txt_year.Text = sdr["v_year"].ToString();
                    txt_seat_cap.Text = sdr["seat_capa"].ToString();
                    txt_chasis.Text = sdr["chasis"].ToString();
                    txt_no_cylinder.Text = sdr["no_of_cylin"].ToString();
                    txt_transmission.Text = sdr["transmission"].ToString();
                    txt_radio_no.Text = sdr["radio_no"].ToString();
                    txt_sn_sarana.Text = sdr["sn_sarana"].ToString();
                    txt_exp_lifetime.Text = sdr["exp_life_hour"].ToString();
                    //txt_unschedule_bd.Text = sdr[""].ToString();
                    //txt_schedule_bd.Text = sdr[""].ToString();
                    txt_steer_size.Text = sdr["tyre_size_steer"].ToString();
                    txt_noOf_steer_size.Text = sdr["tyre_no_steer"].ToString();
                    txt_tyre_size_drive.Text = sdr["tyre_size_drive"].ToString();
                    txt_noOf_tyre_size_drive.Text = sdr["tyre_no_drive"].ToString();
                    txt_wheel_base.Text = sdr["wheel_base"].ToString();
                    txt_wheel_drive.Text = sdr["wheel_drive"].ToString();
                    txt_no_of_axles.Text = sdr["no_of_axles"].ToString();
                    txt_tare_weight.Text = sdr["tare_weight"].ToString();
                    txt_height.Text = sdr["tare_height"].ToString();
                    txt_gross_weight.Text = sdr["gross_weight"].ToString();
                    txt_width.Text = sdr["gross_width"].ToString();
                    txt_color.Text = sdr["color"].ToString();
                    txt_lenght.Text = sdr["length"].ToString();
                    //txt_primary_fuel.Text = sdr[""].ToString();
                    txt_primary_tank_capacity.Text = sdr["tank_capa1"].ToString();
                    //txt_secondary_fuel.Text = sdr[""].ToString();
                    txt_secondary_fuel_capacity.Text = sdr["tank_capa2"].ToString();
                    //txt_tank_unit.Text = sdr[""].ToString();
                    txt_inspect_done.Text = sdr["mechin_inspect_done"].ToString();
                    txt_certificate_no.Text = sdr["certi_no"].ToString();
                    txt_next_due.Text = sdr["next_due"].ToString();
                }
                con.Close();
            }
            catch (Exception)
            {

                throw;
            }
        }

        #endregion

        #region WO Explorer
        public DataTable GetDataWOExplorerTable(string fromDate, string toDate, string unit) 
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_work_orderH";
            cmd.Parameters.AddWithValue("@date", fromDate);
            cmd.Parameters.AddWithValue("@todate", toDate);
            cmd.Parameters.AddWithValue("@unit", unit);
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
        protected void btnSearch2_Click(object sender, EventArgs e)
        {            
            RadGrid2.DataSource = GetDataWOExplorerTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), selected_unit);
            RadGrid2.DataBind();           
        }

        protected void Radgrid2_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            if (selected_unit == null)
            {
                (sender as RadGrid).DataSource = new string[] { };
            }
            else
            {
                (sender as RadGrid).DataSource = GetDataWOExplorerTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), selected_unit);
            }
            
        }
        protected void RadGrid2_InsertCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                con.Open();
                GridEditableItem item = (GridEditableItem)e.Item;
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_get_work_orderH";
                cmd.Parameters.AddWithValue("@unit", selected_unit);
                cmd.Parameters.AddWithValue("@trans_id", (item.FindControl("lblTransID") as Label).Text);
                cmd.Parameters.AddWithValue("@trans_date", string.Format("{0:yyyy-MM-dd}", (item.FindControl("dtptransDate") as RadDatePicker).SelectedDate));
                cmd.Parameters.AddWithValue("@orderName", (item.FindControl("lblOrderName") as Label).Text);
                cmd.Parameters.AddWithValue("@wo_desc", (item.FindControl("lblWODesc") as Label).Text);
                cmd.Parameters.AddWithValue("@time_reading", Convert.ToDouble((item.FindControl("lblUnitReading") as Label).Text));
                cmd.Parameters.AddWithValue("@statusName", (item.FindControl("lblStatusName") as Label).Text);
                cmd.Parameters.AddWithValue("@DBDate", string.Format("{0:yyyy-MM-dd}", (item.FindControl("dtpbdDate") as RadDatePicker).SelectedDate));
                cmd.Parameters.AddWithValue("@remark", (item.FindControl("lblSroRemark") as Label).Text);
                cmd.ExecuteNonQuery();
                con.Close();
            }
            catch (Exception ex)
            {
                con.Close();
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
                e.Canceled = true;
            }
        }
        #endregion

        #region Material Request
        public DataTable GetDataMRTable(string unit) 
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_UnitExplorer_MR";
            cmd.Parameters.AddWithValue("@unit", unit);
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

        protected void btnSearch3_Click(object sender, EventArgs e)
        {
            RadGrid3.DataSource = GetDataMRTable(selected_unit);
            RadGrid3.DataBind();
        }

        protected void RadGrid3_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            if (selected_unit == null)
            {
                (sender as RadGrid).DataSource = new string[] { };
            }
            else
            {
                (sender as RadGrid).DataSource = GetDataMRTable(selected_unit);
            }
        }

        protected void RadGrid3_InsertCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                con.Open();
                GridEditableItem item = (GridEditableItem)e.Item;
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_get_UnitExplorer_MR";
                cmd.Parameters.AddWithValue("@unit", selected_unit);
                cmd.Parameters.AddWithValue("@sro_code", (item.FindControl("lblMrNo") as Label).Text);
                cmd.Parameters.AddWithValue("@sro_date", string.Format("{0:yyyy-MM-dd}", (item.FindControl("dtpSroDate") as RadDatePicker).SelectedDate));
                cmd.Parameters.AddWithValue("@trans_id", (item.FindControl("lblWorkOrder") as Label).Text);
                cmd.Parameters.AddWithValue("@sro_remark", (item.FindControl("lblSroRemark") as Label).Text);
                cmd.ExecuteNonQuery();
                con.Close();
            }
            catch (Exception ex)
            {
                con.Close();
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
                e.Canceled = true;
            }

            
        }
        #endregion

        #region Historical Mayor Repair
        public DataTable GetDataHMRTable(string unit)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_UnitExplorer_HMR";
            cmd.Parameters.AddWithValue("@unit", unit);
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
        protected void btnSearch4_Click(object sender, EventArgs e)
        {
            RadGrid4.DataSource = GetDataHMRTable(selected_unit);
            RadGrid4.DataBind();
        }
        protected void RadGrid4_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            if (selected_unit == null)
            {
                (sender as RadGrid).DataSource = new string[] { };
            }
            else
            {
                (sender as RadGrid).DataSource = GetDataHMRTable(selected_unit);
            }
        }

        protected void RadGrid4_InsertCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                con.Open();
                GridEditableItem item = (GridEditableItem)e.Item;
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_get_UnitExplorer_HMR";
                cmd.Parameters.AddWithValue("@unit", selected_unit);
                cmd.Parameters.AddWithValue("@region_code", (item.FindControl("lblSite") as Label).Text);
                cmd.Parameters.AddWithValue("@trans_date", string.Format("{0:yyyy-MM-dd}", (item.FindControl("dtpHMRdate") as RadDatePicker).SelectedDate));
                cmd.Parameters.AddWithValue("@com_code", (item.FindControl("lblCompCode") as Label).Text);
                cmd.Parameters.AddWithValue("@com_name", (item.FindControl("lblCompName") as Label).Text);
                cmd.Parameters.AddWithValue("@time_reading", Convert.ToDouble((item.FindControl("lblTimeReading") as Label).Text));
                cmd.Parameters.AddWithValue("@down_type", Convert.ToDouble((item.FindControl("lblDownType") as Label).Text));
                cmd.Parameters.AddWithValue("@job_status", (item.FindControl("lblJobStatus") as Label).Text);
                cmd.Parameters.AddWithValue("@remark", (item.FindControl("lblRemark") as Label).Text);
                cmd.ExecuteNonQuery();
                con.Close();
            }
            catch (Exception ex)
            {
                con.Close();
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
                e.Canceled = true;
            }
        }
        #endregion

        #region Reading Recording
        public DataTable GetDataReadRecordTable(string fromDate, string toDate, string unit) 
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_UnitExplorer_ReadRecord";
            cmd.Parameters.AddWithValue("@date", fromDate);
            cmd.Parameters.AddWithValue("@todate", toDate);
            cmd.Parameters.AddWithValue("@unit", unit);
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

        protected void btnSearch5_Click(object sender, EventArgs e)
        {
            RadGrid5.DataSource = GetDataReadRecordTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), selected_unit);
            RadGrid5.DataBind();
        }

        protected void RadGrid5_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            if (selected_unit == null)
            {
                (sender as RadGrid).DataSource = new string[] { };
            }
            else
            {
                (sender as RadGrid).DataSource = GetDataReadRecordTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), selected_unit);
            }
        }
        protected void RadGrid5_InsertCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                con.Open();
                GridEditableItem item = (GridEditableItem)e.Item;
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_get_work_orderH";
                cmd.Parameters.AddWithValue("@unit", selected_unit);
                cmd.Parameters.AddWithValue("@reading_code", (item.FindControl("lblFreqType") as Label).Text);
                cmd.Parameters.AddWithValue("@reading_date", string.Format("{0:yyyy-MM-dd}", (item.FindControl("dtpReadRecordDate") as RadDatePicker).SelectedDate));
                cmd.Parameters.AddWithValue("@reading_amount3", Convert.ToDouble((item.FindControl("lblReadingAmount3") as Label).Text));
                cmd.Parameters.AddWithValue("@reading_amount1", Convert.ToDouble((item.FindControl("lblReadingAmount1") as Label).Text));
                cmd.Parameters.AddWithValue("@broken_hm", (item.FindControl("lblWODesc") as Label).Text);
                cmd.Parameters.AddWithValue("@wh", Convert.ToDouble((item.FindControl("lblWH") as Label).Text));
                cmd.ExecuteNonQuery();
                con.Close();
            }
            catch (Exception ex)
            {
                con.Close();
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
                e.Canceled = true;
            }
        }
        #endregion

        #region Notification
        public DataTable GetDataNotifTable(string unit)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_UnitExplorer_Notif";
            cmd.Parameters.AddWithValue("@unit", unit);
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
        protected void btnSearch6_Click(object sender, EventArgs e)
        {
            RadGrid6.DataSource = GetDataNotifTable(selected_unit);
            RadGrid6.DataBind();
        }

        protected void RadGrid6_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            if (selected_unit == null)
            {
                (sender as RadGrid).DataSource = new string[] { };
            }
            else
            {
                (sender as RadGrid).DataSource = GetDataHMRTable(selected_unit);
            }
        }

        protected void RadGrid6_InsertCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                con.Open();
                GridEditableItem item = (GridEditableItem)e.Item;
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_get_UnitExplorer_Notif";
                cmd.Parameters.AddWithValue("@unit", selected_unit);
                cmd.Parameters.AddWithValue("@PM_id", (item.FindControl("lblNotifNo") as Label).Text);
                cmd.Parameters.AddWithValue("@Req_date", string.Format("{0:yyyy-MM-dd}", (item.FindControl("dtpReqDate") as RadDatePicker).SelectedDate));
                cmd.Parameters.AddWithValue("@Notif_type_name", (item.FindControl("lblNotifType") as Label).Text);
                cmd.Parameters.AddWithValue("@reportby", (item.FindControl("lblNotifReportBy") as Label).Text);
                cmd.Parameters.AddWithValue("@time_reading", Convert.ToDouble((item.FindControl("lblNotifTime") as Label).Text));
                cmd.Parameters.AddWithValue("@unitstatus", (item.FindControl("lblNotifUnitStatus") as Label).Text);
                cmd.Parameters.AddWithValue("@tdown", string.Format("{0:yyyy-MM-dd}", (item.FindControl("dtpUnitDate") as RadDatePicker).SelectedDate));
                cmd.Parameters.AddWithValue("@wo_desc", (item.FindControl("lblNotifStatus") as Label).Text);
                cmd.Parameters.AddWithValue("@remark", (item.FindControl("lblNotifRemark") as Label).Text);
                cmd.ExecuteNonQuery();
                con.Close();
            }
            catch (Exception ex)
            {
                con.Close();
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
                e.Canceled = true;
            }
        }
        #endregion

        #region WO Backlog
        public DataTable GetDataWOBacklogTable(string fromDate, string toDate, string unit) 
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_UnitExplorer_WO_Backlog";
            cmd.Parameters.AddWithValue("@date", fromDate);
            cmd.Parameters.AddWithValue("@todate", toDate);
            cmd.Parameters.AddWithValue("@unit", unit);
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
        protected void btnSearch7_Click(object sender, EventArgs e)
        {
            RadGrid7.DataSource = GetDataWOBacklogTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), selected_unit);
            RadGrid7.DataBind();
        }

        protected void RadGrid7_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            if (selected_unit == null)
            {
                (sender as RadGrid).DataSource = new string[] { };
            }
            else
            {
                (sender as RadGrid).DataSource = GetDataWOBacklogTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), selected_unit);
            }
        }


        #endregion

        protected void RadGrid7_InsertCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                con.Open();
                GridEditableItem item = (GridEditableItem)e.Item;
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_get_work_orderH";
                cmd.Parameters.AddWithValue("@unit", selected_unit);
                cmd.Parameters.AddWithValue("@trans_id", (item.FindControl("lblTransID") as Label).Text);
                cmd.Parameters.AddWithValue("@trans_date", string.Format("{0:yyyy-MM-dd}", (item.FindControl("dtptransDate") as RadDatePicker).SelectedDate));
                cmd.Parameters.AddWithValue("@orderName", (item.FindControl("lblOrderName") as Label).Text);
                cmd.Parameters.AddWithValue("@wo_desc", (item.FindControl("lblWODesc") as Label).Text);
                cmd.Parameters.AddWithValue("@time_reading", Convert.ToDouble((item.FindControl("lblUnitReading") as Label).Text));
                cmd.Parameters.AddWithValue("@statusName", (item.FindControl("lblStatusName") as Label).Text);
                cmd.Parameters.AddWithValue("@DBDate", string.Format("{0:yyyy-MM-dd}", (item.FindControl("dtpbdDate") as RadDatePicker).SelectedDate));
                cmd.Parameters.AddWithValue("@remark", (item.FindControl("lblSroRemark") as Label).Text);
                cmd.ExecuteNonQuery();
                con.Close();
            }
            catch (Exception ex)
            {
                con.Close();
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
                e.Canceled = true;
            }
        }
    }
}