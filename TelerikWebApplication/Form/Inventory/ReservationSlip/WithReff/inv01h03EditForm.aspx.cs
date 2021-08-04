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

namespace TelerikWebApplication.Form.Inventory.ReservationSlip.WithReff
{
    public partial class inv01h03EditForm : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();

        private const int ItemsPerRequest = 10;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                dtp_rs.SelectedDate = DateTime.Now;
                dtp_exe.SelectedDate = DateTime.Now;
                if (Request.QueryString["doc_code"] != null)
                {
                    fill_object(Request.QueryString["doc_code"].ToString());
                    RadGridDetail.DataSource = GetDataDetailTable(txt_doc_code.Text);
                    Session["actionEdit"] = "edit";
                }
                else
                {
                    Session["actionEdit"] = "new";
                    cb_type_ref.Text = "Work Order";
                    cb_type_ref.SelectedValue = "1";
                    cb_project.Text = public_str.sitename;
                    cb_project.SelectedValue = public_str.site;
                }
            }


        }
        protected void fill_object(string id)
        {
            con.Open();
            SqlDataReader sdr;
            SqlCommand cmd = new SqlCommand("SELECT * FROM v_rs_list WHERE doc_code = '" + id + "'", con);
            sdr = cmd.ExecuteReader();
            if (sdr.Read())
            {
                txt_doc_code.Text = sdr["doc_code"].ToString();
                dtp_rs.SelectedDate = Convert.ToDateTime(sdr["doc_date"].ToString());
                dtp_exe.SelectedDate = Convert.ToDateTime(sdr["date_exec"].ToString());
                //dtp_ref.Text = sdr["ref_date"].ToString();
                cb_type_ref.Text = sdr["tAsset"].ToString();
                cb_ref.Text = sdr["sro_code"].ToString();
                txt_unit_code.Text = sdr["unit_code"].ToString();
                txt_unit_name.Text = sdr["model_no"].ToString();
                cb_project.Text = sdr["region_name"].ToString();
                //txt_hm.Text = sdr["time_reading"].ToString();
                txt_hm1.Value = Convert.ToDouble(sdr["time_reading"].ToString());
                cb_cost_ctr.SelectedValue = sdr["CostCenter"].ToString();
                cb_cost_ctr.Text = sdr["CostCenterName"].ToString();
                cb_orderBy.Text = sdr["RequestBy"].ToString();
                cb_received.Text = sdr["ReceiveBy"].ToString();
                cb_approved.Text = sdr["ApproveBy"].ToString();
                txt_remark.Text = sdr["doc_remark"].ToString();
                //lbl_userId.Text = lbl_userId.Text + sdr["userid"].ToString();
                //lbl_lastUpdate.Text = lbl_lastUpdate.Text + string.Format("{0:dd-MM-yyyy}", sdr["lastupdate"].ToString());
                //lbl_Owner.Text = lbl_Owner.Text + sdr["Owner"].ToString();
                ////lbl_printed.Text = lbl_printed.Text + sdr["Printed"].ToString();
                //lbl_edited.Text = lbl_edited.Text + sdr["Edited"].ToString();
                //cb_warehouse.SelectedValue = sdr["wh_code"].ToString();
                //cb_warehouse.Text = sdr["wh_name"].ToString();
                Updatepanel12.ContentTemplateContainer.Controls.Add(new LiteralControl("Last Update : " + string.Format("{0:dd-MM-yyyy}", sdr["lastupdate"].ToString())));
                Updatepanel12.ContentTemplateContainer.Controls.Add(new LiteralControl("<p>Updated : " + sdr["Edited"].ToString()));
                Updatepanel12.ContentTemplateContainer.Controls.Add(new LiteralControl("<p>User Id : " + sdr["userid"].ToString()));
                Updatepanel12.ContentTemplateContainer.Controls.Add(new LiteralControl("<p>Owner : " + sdr["Owner"].ToString()));
                Updatepanel12.Update();
            }
            con.Close();

        }

        private static string GetStatusMessage(int offset, int total)
        {
            if (total <= 0)
                return "No matches";

            return String.Format("Items <b>1</b>-<b>{0}</b> out of <b>{1}</b>", offset, total);
        }

        #region Refferences

        private static DataTable GetReff(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select * from v_rs_reff where doc_code LIKE @text + '%'",
             ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void LoadReff(string doc_code, string projectID, string typeRef, RadComboBox cb)
        {
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            DataTable dt = new DataTable();

            if (typeRef == "Work Order")
            {
                SqlDataAdapter adapter = new SqlDataAdapter("SELECT doc_code, remark FROM v_rs_reff " +
                "WHERE void <> '4' AND region_code = @project AND doc_code LIKE @text + '%'", con);
                adapter.SelectCommand.Parameters.AddWithValue("@project", projectID);
                adapter.SelectCommand.Parameters.AddWithValue("@text", doc_code);
                //DataTable dt = new DataTable();
                adapter.Fill(dt);
            }
            else
            {
                SqlDataAdapter adapter = new SqlDataAdapter("SELECT doc_code, remark FROM v_rs_reff_general " +
                "WHERE region_code = @project AND doc_code LIKE @text + '%'", con);
                adapter.SelectCommand.Parameters.AddWithValue("@project", projectID);
                adapter.SelectCommand.Parameters.AddWithValue("@text", doc_code);
                //DataTable dt = new DataTable();
                adapter.Fill(dt);
            }


            cb.DataTextField = "doc_code";
            cb.DataValueField = "doc_code";
            cb.DataSource = dt;
            cb.DataBind();
        }
        protected void cb_ref_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadReff(e.Text, cb_project.SelectedValue, cb_type_ref.Text, (sender as RadComboBox));

        }

        protected void cb_ref_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            SqlDataReader dr;
            if (cb_type_ref.Text == "Work Order")
            {
                cmd.CommandText = "SELECT * FROM v_rs_reff WHERE doc_code = '" + (sender as RadComboBox).SelectedValue + "'";
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    (sender as RadComboBox).Text = dr["doc_code"].ToString();
                    txt_unit_code.Text = dr["unit_code"].ToString();
                    txt_unit_name.Text = dr["model_no"].ToString();
                    txt_hm1.Value = Convert.ToDouble(dr["time_reading"].ToString());
                    cb_cost_ctr.SelectedValue = dr["dept_code"].ToString();
                    cb_cost_ctr.Text = dr["CostCenterName"].ToString();
                    txt_remark.Text = dr["remark"].ToString();
                }
            }
            else
            {
                cmd.CommandText = "SELECT * FROM v_rs_reff_general WHERE doc_code = '" + (sender as RadComboBox).SelectedValue + "'";
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    (sender as RadComboBox).Text = dr["doc_code"].ToString();
                    cb_cost_ctr.SelectedValue = dr["dept_code"].ToString();
                    cb_cost_ctr.Text = dr["CostCenterName"].ToString();
                    txt_remark.Text = dr["remark"].ToString();
                }
            }


            dr.Close();
            con.Close();

            //if (Session["actionEdit"].ToString() == "edit")
            //{
            //    Session["actionEdit"] = "new";
            //}
            //else
            //{
                RadGridDetail.DataSource = GetDataRefDetailTable((sender as RadComboBox).SelectedValue);
                RadGridDetail.DataBind();
            //}
            
        }

        protected void cb_ref_PreRender(object sender, EventArgs e)
        {
            if (Session["actionEdit"].ToString() == "edit")
            {
                (sender as RadComboBox).Enabled = false;
            }
            else
            {
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "SELECT doc_code FROM v_rs_reff WHERE doc_code = '" + (sender as RadComboBox).Text + "'";
                SqlDataReader dr;
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    (sender as RadComboBox).SelectedValue = dr[0].ToString();
                }
                dr.Close();
                con.Close();
            }
            
        }

        public DataTable GetDataRefDetailTable(string doc_code)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_reservation_slip_reffD";
            cmd.Parameters.AddWithValue("@doc_code", doc_code);
            cmd.Parameters.AddWithValue("@type_reff", cb_type_ref.SelectedValue);
            cmd.Parameters.AddWithValue("@wh_code", cb_warehouse.SelectedValue);
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
        #endregion

        #region Priority 
        private static DataTable GetPriority(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT priority_code , prio_desc FROM ms_priority WHERE prio_desc LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }

        protected void cb_priority_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetPriority(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["prio_desc"].ToString(), data.Rows[i]["prio_desc"].ToString()));
            }

            e.Message = GetStatusMessage(endOffset, data.Rows.Count);
        }

        protected void cb_priority_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT priority_code FROM ms_priority WHERE prio_desc = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            }
            dr.Close();
            con.Close();
        }
        protected void cb_priority_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT priority_code FROM ms_priority WHERE prio_desc = '" + (sender as RadComboBox).Text + "'";
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

        #region Reff Type
        protected void cb_type_ref_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadComboBox).Text == "Work Order")
            {
                (sender as RadComboBox).SelectedValue = "1";
            }
            else if ((sender as RadComboBox).Text == "General Request")
            {
                (sender as RadComboBox).SelectedValue = "2";
            }
        }
        protected void cb_type_ref_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Add("Work Order");
            (sender as RadComboBox).Items.Add("General Request");
        }
        protected void cb_type_ref_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if ((sender as RadComboBox).Text == "Work Order")
            {
                (sender as RadComboBox).SelectedValue = "1";
            }
            else if ((sender as RadComboBox).Text == "General Request")
            {
                (sender as RadComboBox).SelectedValue = "2";
            }
        }
        #endregion

        #region Project
        private static DataTable GetProject(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT region_code, region_name FROM ms_jobsite WHERE stEdit != 4 AND region_name LIKE @text + '%' ",
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
            cmd.CommandText = "SELECT region_code FROM ms_jobsite WHERE region_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            }
            dr.Close();
            con.Close();

            //cb_warehouse.Text = string.Empty;
            cb_ref.Text = string.Empty;
            cb_cost_ctr.Text = string.Empty;
            //cb_warehouse.SelectedValue = null;
            cb_ref.SelectedValue = null;
            cb_cost_ctr.SelectedValue = null;
            txt_unit_code.Text = string.Empty;
            txt_unit_name.Text = string.Empty;
            txt_hm1.Value = 0;
            txt_remark.Text = string.Empty;
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

        #region Warehouse / Storage 
        private static DataTable GetWarehouse(string text, string project)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT wh_code, wh_name FROM ms_warehouse WHERE stEdit != 4 AND PlantCode = @PlantCode AND wh_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@PlantCode", project);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_warehouse_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetWarehouse(e.Text, cb_project.SelectedValue);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["wh_name"].ToString(), data.Rows[i]["wh_name"].ToString()));
            }
        }

        protected void cb_warehouse_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
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

        protected void cb_warehouse_PreRender(object sender, EventArgs e)
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
        protected void cb_prepare_by_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadManPower(e.Text, cb_project.SelectedValue, (sender as RadComboBox));
        }
        protected void cb_prepare_by_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
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
        protected void cb_prepare_by_PreRender(object sender, EventArgs e)
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
        protected void cb_orderBy_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadManPower(e.Text, cb_project.SelectedValue, (sender as RadComboBox));
        }
        protected void cb_orderBy_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
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
        protected void cb_orderBy_PreRender(object sender, EventArgs e)
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
        protected void cb_received_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
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
        protected void cb_received_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadManPower(e.Text, cb_project.SelectedValue, (sender as RadComboBox));
        }
        protected void cb_received_PreRender(object sender, EventArgs e)
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
        protected void cb_approved_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadManPower(e.Text, cb_project.SelectedValue, (sender as RadComboBox));
        }
        protected void cb_approved_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
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
                       
        protected void btnSave_Click(object sender, EventArgs e)
        {
            long maxNo;
            string run = null;
            string trDate = string.Format("{0:dd/MM/yyyy}", dtp_rs.SelectedDate);

            try
            {
                if (Session["actionEdit"].ToString() == "edit")
                {
                    run = txt_doc_code.Text;
                }
                else
                {
                    con.Open();
                    SqlDataReader sdr;
                    cmd = new SqlCommand("SELECT ISNULL ( MAX ( RIGHT ( fleet_doch.doc_code , 4 ) ) , 0 ) + 1 AS maxNo " +
                        "FROM fleet_doch WHERE LEFT(fleet_doch.doc_code, 4) = 'RS01' " +
                        "AND SUBSTRING(fleet_doch.doc_code, 5, 2) = SUBSTRING('" + trDate + "', 9, 2) " +
                        "AND SUBSTRING(fleet_doch.doc_code, 7, 2) = SUBSTRING('" + trDate + "', 4, 2) ", con);
                    sdr = cmd.ExecuteReader();
                    if (sdr.HasRows == false)
                    {
                        //throw new Exception();
                        run = "RS01" + dtp_rs.SelectedDate.Value.Year + dtp_rs.SelectedDate.Value.Month + "0001";
                    }
                    else if (sdr.Read())
                    {
                        maxNo = Convert.ToInt32(sdr[0].ToString());
                        run = "RS01" + (dtp_rs.SelectedDate.Value.Year.ToString()).Substring(dtp_rs.SelectedDate.Value.Year.ToString().Length - 2) +
                            ("0000" + dtp_rs.SelectedDate.Value.Month).Substring(("0000" + dtp_rs.SelectedDate.Value.Month).Length - 2, 2) +
                            ("0000" + maxNo).Substring(("0000" + maxNo).Length - 4, 4);
                    }
                    con.Close();
                }


                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_save_reservation_slipH";
                cmd.Parameters.AddWithValue("@doc_code", run);
                cmd.Parameters.AddWithValue("@doc_date", string.Format("{0:yyyy-MM-dd}", dtp_rs.SelectedDate.Value));
                //cmd.Parameters.AddWithValue("@ref_date", dtp_ref.Text);
                cmd.Parameters.AddWithValue("@type_ref", cb_type_ref.SelectedValue);
                cmd.Parameters.AddWithValue("@date_exec", string.Format("{0:yyyy-MM-dd}", dtp_exe.SelectedDate.Value));
                cmd.Parameters.AddWithValue("@order_by", cb_orderBy.SelectedValue);
                cmd.Parameters.AddWithValue("@receive_by", cb_received.SelectedValue);
                cmd.Parameters.AddWithValue("@approval_by", cb_approved.SelectedValue);
                cmd.Parameters.AddWithValue("@doc_remark", txt_remark.Text);
                cmd.Parameters.AddWithValue("@unit_code", txt_unit_code.Text);
                cmd.Parameters.AddWithValue("@model_no", txt_unit_name.Text);
                //if (txt_hm.Text != "")
                //{
                //    cmd.Parameters.AddWithValue("@time_reading", Convert.ToDouble(txt_hm.Text));
                //}
                //else
                //{
                //    cmd.Parameters.AddWithValue("@time_reading", 0);
                //}
                cmd.Parameters.AddWithValue("@time_reading", txt_hm1.Value);
                cmd.Parameters.AddWithValue("@userid", public_str.user_id);
                cmd.Parameters.AddWithValue("@type_source", "1");
                cmd.Parameters.AddWithValue("@tFullSupply", "0");
                cmd.Parameters.AddWithValue("@LastUpdate", DateTime.Today);
                cmd.Parameters.AddWithValue("@region_code", cb_project.SelectedValue);
                cmd.Parameters.AddWithValue("@dept_code", cb_cost_ctr.SelectedValue);
                cmd.Parameters.AddWithValue("@sro_code", cb_ref.Text);
                cmd.Parameters.AddWithValue("@Owner", public_str.user_id);
                cmd.Parameters.AddWithValue("@Stamp", DateTime.Today);
                //cmd.Parameters.AddWithValue("@Printed", txt_printed.Text);
                //cmd.Parameters.AddWithValue("@Edited", txt_edited.Text);
                cmd.Parameters.AddWithValue("@Lvl", public_str.level);
                //cmd.Parameters.AddWithValue("@wh_code", DBNull.Value);
                cmd.Parameters.AddWithValue("@wh_code", cb_warehouse.SelectedValue);
                cmd.ExecuteNonQuery();


                //Save Detail

                foreach (GridDataItem item in RadGridDetail.MasterTableView.Items)
                {
                    cmd = new SqlCommand();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Connection = con;
                    cmd.CommandText = "sp_save_reservation_slipD";
                    cmd.Parameters.AddWithValue("@doc_code", run);
                    cmd.Parameters.AddWithValue("@part_code", (item.FindControl("lblProdCode") as Label).Text);
                    cmd.Parameters.AddWithValue("@oh_qty", Convert.ToDouble((item.FindControl("lblSoh") as Label).Text));
                    cmd.Parameters.AddWithValue("@part_qty", Convert.ToDouble((item.FindControl("txtPartQty") as RadTextBox).Text));
                    cmd.Parameters.AddWithValue("@part_unit", (item.FindControl("lblUom") as Label).Text);
                    cmd.Parameters.AddWithValue("@remark", (item.FindControl("txtRemark_d") as RadTextBox).Text);
                    cmd.Parameters.AddWithValue("@dept_code", (item.FindControl("lblCostCtr") as Label).Text);
                    cmd.Parameters.AddWithValue("@tWarranty", "0");
                    cmd.Parameters.AddWithValue("@deliv_date", string.Format("{0:yyyy-MM-dd}", (item.FindControl("dtpDelivDate") as RadDatePicker).SelectedDate));
                    cmd.Parameters.AddWithValue("@prod_type", (item.FindControl("lblProdType") as Label).Text);
                    cmd.ExecuteNonQuery();
                }

                                
                //RadGrid2.Enabled = true;
                //btnSave.Enabled = false;
                //btnPrint.Enabled = true;
                //btnPrint.ImageUrl = "~/Images/cetak.png";
                //btnPrint.Attributes["OnClick"] = String.Format("return ShowPreview('{0}');", txt_doc_code.Text);
                //if (Session["action"].ToString() == "new" && chk_to_pr.Checked == true)
                //{
                //    if (cb_type_ref.SelectedValue == "1")
                //    {
                //        Response.Redirect("~/Form/Purchase/PurchaseReq/pur01h01.aspx?pr_code=" + System.Web.HttpUtility.UrlEncode(run) +
                //        "&reff_date=" + System.Web.HttpUtility.UrlEncode(string.Format("{0:dd-MM-yyyy}", dtp_rs.SelectedDate.Value)) +
                //        "&project=" + System.Web.HttpUtility.UrlEncode(cb_project.Text) +
                //        "&costCtr=" + System.Web.HttpUtility.UrlEncode(txt_cost_center.Text) +
                //        "&unit=" + System.Web.HttpUtility.UrlEncode(txt_unit_code.Text) +
                //        "&hm=" + System.Web.HttpUtility.UrlEncode(txt_hm.Text) +
                //        "&model=" + System.Web.HttpUtility.UrlEncode(txt_unit_name.Text) +
                //        "&wo=" + System.Web.HttpUtility.UrlEncode(cb_ref.SelectedValue) +
                //        "&remark=" + System.Web.HttpUtility.UrlEncode(txt_remark.Text));
                //    }
                //    else if (cb_type_ref.SelectedValue == "2")
                //    {
                //        Response.Redirect("~/Form/Purchase/PurchaseReq/pur01h01a.aspx?pr_code=" + System.Web.HttpUtility.UrlEncode(run) +
                //        "&reff_date=" + System.Web.HttpUtility.UrlEncode(string.Format("{0:dd-MM-yyyy}", dtp_rs.SelectedDate.Value)) +
                //        "&project=" + System.Web.HttpUtility.UrlEncode(cb_project.Text) +
                //        "&costCtr=" + System.Web.HttpUtility.UrlEncode(txt_cost_center.Text) +
                //        "&unit=" + System.Web.HttpUtility.UrlEncode(txt_unit_code.Text) +
                //        "&remark=" + System.Web.HttpUtility.UrlEncode(txt_remark.Text));
                //    }
                //}
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
                txt_doc_code.Text = run;

                if (Session["actionEdit"].ToString() == "edit")
                {
                    ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind();", true);
                }
                else
                {
                    inv01h03.tr_code = run;
                    inv01h03.selected_project = cb_project.SelectedValue;
                    //inv01h03.selected_cost_ctr = cb_cost_ctr.SelectedValue;
                    //inv01h03.selected_wh_code = cb_warehouse.SelectedValue;
                    //inv01h03.selected_type_reff = cb_type_ref.SelectedValue;
                    //inv01h03.selected_reff_no = cb_ref.Text;
                    ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind('navigateToInserted');", true);
                }
            }
        }
               
        protected void RadGridDetail_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            if (!IsPostBack)
            {
                RadGridDetail.DataSource = new string[] { };
            }
            else if(Session["actionEdit"].ToString() =="new")
            {
                RadGridDetail.DataSource = new string[] { };
                RadGridDetail.DataSource = GetDataRefDetailTable(cb_ref.Text);
            }
            else if (Session["actionEdit"].ToString() == "edit")
            {
                RadGridDetail.DataSource = new string[] { };
                RadGridDetail.DataSource = GetDataRefDetailTable(txt_doc_code.Text);
            }
        }
        public DataTable GetDataDetailTable(string doc_code)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_reservation_slipD";
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

        protected void RadGridDetail_PreRender(object sender, EventArgs e)
        {
            if((sender as RadGrid).MasterTableView.Items.Count < (sender as RadGrid).MasterTableView.PageSize)
            {
                (sender as RadGrid).ClientSettings.Scrolling.AllowScroll = false;
                (sender as RadGrid).ClientSettings.Scrolling.UseStaticHeaders = false;
            }
            else
            {
                (sender as RadGrid).ClientSettings.Scrolling.AllowScroll = true;
                (sender as RadGrid).ClientSettings.Scrolling.UseStaticHeaders = true;
                (sender as RadGrid).ClientSettings.Scrolling.ScrollHeight = 200;
            }
        }
    }

}