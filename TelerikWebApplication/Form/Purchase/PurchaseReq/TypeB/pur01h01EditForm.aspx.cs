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

namespace TelerikWebApplication.Form.Purchase.PurchaseReq
{
    public partial class pur01h01EditForm : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();

        private const int ItemsPerRequest = 10;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                dtp_pr.SelectedDate = DateTime.Now;
                if (Request.QueryString["pr_code"] != null)
                {
                    fill_object(Request.QueryString["pr_code"].ToString());
                    RadGrid2.DataSource = GetDataDetailTable(txt_doc_code.Text);
                    Session["actionEdit"] = "edit";
                }
                else
                {
                    Session["actionEdit"] = "new";
                    cb_type_ref.SelectedValue = "1";
                    cb_type_ref.Text = "Reservation";

                    cb_priority.SelectedValue = "1";
                    cb_priority.Text = "High/Urgent";

                    cb_project.SelectedValue = public_str.site;
                    cb_project.Text = public_str.sitename;                    
                }
            }

            
        }
        #region Detail
        public DataTable GetDataDetailTable(string doc_code)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_purchase_requestD";
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
        protected void RadGrid2_PreRender(object sender, EventArgs e)
        {
            //if ((sender as RadGrid).MasterTableView.Items.Count < (sender as RadGrid).MasterTableView.PageSize)
            //{
            //    (sender as RadGrid).ClientSettings.Scrolling.AllowScroll = false;
            //    (sender as RadGrid).ClientSettings.Scrolling.UseStaticHeaders = false;
            //}
            //else
            //{
            //    (sender as RadGrid).ClientSettings.Scrolling.AllowScroll = true;
            //    (sender as RadGrid).ClientSettings.Scrolling.UseStaticHeaders = true;
            //    (sender as RadGrid).ClientSettings.Scrolling.ScrollHeight = 200;
            //}

            if ((sender as RadGrid).MasterTableView.Items.Count < (sender as RadGrid).MasterTableView.PageSize)
            {
                (sender as RadGrid).ClientSettings.Scrolling.AllowScroll = false;
                (sender as RadGrid).ClientSettings.Scrolling.UseStaticHeaders = false;
            }
            else
            {
                (sender as RadGrid).ClientSettings.Scrolling.AllowScroll = true;
                (sender as RadGrid).ClientSettings.Scrolling.UseStaticHeaders = true;
                (sender as RadGrid).ClientSettings.Scrolling.ScrollHeight = 230;
            }
        }

        #endregion

        #region Refferences
                
        protected void LoadRef(string sro_code, string projectID, string type_reff, RadComboBox cb)
        {
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);

            SqlDataAdapter adapter = new SqlDataAdapter("SELECT doc_code, doc_date, doc_remark FROM v_purcahse_request_reff " +
                "WHERE region_code = @project AND type_ref = @type_ref AND doc_code LIKE @text + '%'", con);
            adapter.SelectCommand.Parameters.AddWithValue("@project", projectID);
            adapter.SelectCommand.Parameters.AddWithValue("@type_ref", type_reff);
            adapter.SelectCommand.Parameters.AddWithValue("@text", sro_code);
            DataTable dt = new DataTable();
            adapter.Fill(dt);

            cb.DataTextField = "doc_code";
            cb.DataValueField = "doc_code";
            cb.DataSource = dt;
            cb.DataBind();
        }
        protected void cb_ref_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadRef(e.Text, cb_project.SelectedValue, cb_type_ref.SelectedValue, (sender as RadComboBox));
        }

        protected void cb_ref_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            //fillReffH((sender as RadComboBox).SelectedValue);
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT * FROM v_purcahse_request_reff WHERE doc_code = '" + (sender as RadComboBox).SelectedValue + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).Text = dr["doc_code"].ToString();
                txt_unit_code.Text = dr["unit_code"].ToString();
                txt_unit_name.Text = dr["model_no"].ToString();
                txt_work_order.Text = dr["wo_code"].ToString();
                txt_hm.Text = string.Format("{0:#,###,###.0}", dr["hm"].ToString());
                cb_cost_ctr.SelectedValue = dr["dept_code"].ToString();
                cb_cost_ctr.Text = dr["CostCenterName"].ToString();
                txt_remark.Text = dr["doc_remark"].ToString();
                txt_reff_date.Text = dr["doc_date"].ToString();
            }

            //dr.Close();
            con.Close();

            RadGrid2.DataSource = GetDataRefDetailTable((sender as RadComboBox).SelectedValue);
            RadGrid2.DataBind();
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
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT * FROM v_purcahse_requestD_reff WHERE no_ref = '" + doc_code + "'";
            cmd.Parameters.AddWithValue("@doc_code", doc_code);
            //cmd.Parameters.AddWithValue("@type_reff", cb_type_ref.SelectedValue);
            //cmd.Parameters.AddWithValue("@wh_code", cb_warehouse.SelectedValue);
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

        protected void fill_object(string id)
        {
            con.Open();
            SqlDataReader sdr;
            SqlCommand cmd = new SqlCommand("SELECT * FROM v_purchase_request_list WHERE pr_code = '" + id + "'", con);
            sdr = cmd.ExecuteReader();
            if (sdr.Read())
            {
                txt_doc_code.Text = sdr["pr_code"].ToString();
                dtp_pr.SelectedDate = Convert.ToDateTime(sdr["Pr_date"].ToString());
                txt_reff_date.Text = String.Format("{0:dd-MM-yyyy}", sdr["reff_date"]);
                //dtp_ref.Text = sdr["ref_date"].ToString();
                cb_type_ref.Text = sdr["type_source"].ToString();
                cb_ref.Text = sdr["reff_no"].ToString();
                txt_unit_code.Text = sdr["unit_code"].ToString();
                txt_unit_name.Text = sdr["model_no"].ToString();
                cb_project.Text = sdr["region_name"].ToString();
                cb_priority.Text = sdr["prio_desc"].ToString();
                cb_warehouse.Text = sdr["wh_name"].ToString();
                txt_work_order.Text = sdr["reff_no"].ToString();
                txt_hm.Text = String.Format("{0:#,###,###.00}", sdr["time_reading"]);
                cb_cost_ctr.SelectedValue = sdr["dept_code"].ToString();
                cb_cost_ctr.Text = sdr["CostCenterName"].ToString();
                cb_prepare_by.Text = sdr["NamePrepareBy"].ToString();
                cb_orderBy.Text = sdr["NameOrderBy"].ToString();
                cb_checked.Text = sdr["NameCekBy"].ToString();
                cb_approved.Text = sdr["NameAppBy"].ToString();
                txt_remark.Text = sdr["remark"].ToString();
                lbl_userId.Text = lbl_userId.Text + sdr["userid"].ToString();
                lbl_lastUpdate.Text = lbl_lastUpdate.Text + String.Format("{0:dd-MM-yyyy}", sdr["lastupdate"].ToString());
                lbl_Owner.Text = lbl_Owner.Text + sdr["Owner"].ToString();
                //lbl_printed.Text = lbl_printed.Text + sdr["Printed"].ToString();
                lbl_edited.Text = lbl_edited.Text + sdr["Edited"].ToString();
            }
            con.Close();
        }

        private static string GetStatusMessage(int offset, int total)
        {
            if (total <= 0)
                return "No matches";

            return String.Format("Items <b>1</b>-<b>{0}</b> out of <b>{1}</b>", offset, total);
        }

        private void label_teks_default()
        {
            lbl_userId.Text = "User: ";
            lbl_lastUpdate.Text = "Last Update: ";
            lbl_Owner.Text = "Owner:";
            //lbl_printed.Text = "Printed: ";
            lbl_edited.Text = "Edited: ";

        }
        
        private void text_clear(ControlCollection ctrls)
        {
            foreach (Control ctrl in ctrls)
            {
                if (ctrl is RadTextBox)
                {
                    ((RadTextBox)ctrl).Text = "";
                }

                if (ctrl is RadComboBox)
                {
                    ((RadComboBox)ctrl).Text = "";
                }

                text_clear(ctrl.Controls);
                label_teks_default();
            }
        }

        #region Priority 
        private static DataTable GetPriority(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT priority_code , prio_desc FROM pur00h06 WHERE prio_desc LIKE @text + '%'",
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
            cmd.CommandText = "SELECT priority_code FROM pur00h06 WHERE prio_desc = '" + (sender as RadComboBox).Text + "'";
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
            cmd.CommandText = "SELECT priority_code FROM pur00h06 WHERE prio_desc = '" + (sender as RadComboBox).Text + "'";
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
            if ((sender as RadComboBox).Text == "Reservation")
            {
                (sender as RadComboBox).SelectedValue = "1";
            }
            else if ((sender as RadComboBox).Text == "Manual")
            {
                (sender as RadComboBox).SelectedValue = "2";
            }
        }
        protected void cb_type_ref_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Add("Reservation");
            (sender as RadComboBox).Items.Add("Manual");
        }
        protected void cb_type_ref_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if ((sender as RadComboBox).Text == "Reservation")
            {
                (sender as RadComboBox).SelectedValue = "1";
            }
            else if ((sender as RadComboBox).Text == "Manual")
            {
                (sender as RadComboBox).SelectedValue = "2";
            }
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

        #region Warehouse / Storage 
        private static DataTable GetWarehouse(string text, string project)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT wh_code, wh_name FROM inv00h05 WHERE stEdit != 4 AND PlantCode = @PlantCode AND wh_name LIKE @text + '%'",
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
            cmd.CommandText = "SELECT wh_code FROM inv00h05 WHERE wh_name = '" + (sender as RadComboBox).Text + "'";
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
            cmd.CommandText = "SELECT wh_code FROM inv00h05 WHERE wh_name = '" + (sender as RadComboBox).Text + "'";
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

            SqlDataAdapter adapter = new SqlDataAdapter("SELECT upper(CostCenter) as code,upper(CostCenterName) as name FROM inv00h11 " +
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
            cmd.CommandText = "SELECT CostCenter FROM inv00h11 WHERE CostCenterName = '" + (sender as RadComboBox).Text + "'";
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
            cmd.CommandText = "SELECT CostCenter FROM inv00h11 WHERE CostCenterName = '" + (sender as RadComboBox).Text + "'";
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
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + (sender as RadComboBox).Text + "'";
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
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + (sender as RadComboBox).Text + "'";
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
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + (sender as RadComboBox).Text + "'";
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
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + (sender as RadComboBox).Text + "'";
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
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + (sender as RadComboBox).Text + "'";
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
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + (sender as RadComboBox).Text + "'";
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
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + (sender as RadComboBox).Text + "'";
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
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + (sender as RadComboBox).Text + "'";
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

        protected void btn_save_Click(object sender, EventArgs e)
        {
            long maxNo;
            string run = null;
            string trDate = string.Format("{0:dd/MM/yyyy}", dtp_pr.SelectedDate);

            try
            {
                if (txt_doc_code.Text != string.Empty)
                {
                    run = txt_doc_code.Text;
                }
                else
                {
                    con.Open();
                    SqlDataReader sdr;
                    cmd = new SqlCommand("SELECT ISNULL ( MAX ( RIGHT ( pur01h01.pr_code , 4 ) ) , 0 ) + 1 AS maxNo " +
                        "FROM pur01h01 WHERE LEFT(pur01h01.pr_code, 4) = 'PR01' " +
                        "AND SUBSTRING(pur01h01.pr_code, 5, 2) = SUBSTRING('" + trDate + "', 9, 2) " +
                        "AND SUBSTRING(pur01h01.pr_code, 7, 2) = SUBSTRING('" + trDate + "', 4, 2) ", con);
                    sdr = cmd.ExecuteReader();
                    if (sdr.HasRows == false)
                    {
                        //throw new Exception();
                        run = "PR01" + dtp_pr.SelectedDate.Value.Year + dtp_pr.SelectedDate.Value.Month + "0001";
                    }
                    else if (sdr.Read())
                    {
                        maxNo = Convert.ToInt32(sdr[0].ToString());
                        run = "PR01" + (dtp_pr.SelectedDate.Value.Year.ToString()).Substring(dtp_pr.SelectedDate.Value.Year.ToString().Length - 2) +
                            ("0000" + dtp_pr.SelectedDate.Value.Month).Substring(("0000" + dtp_pr.SelectedDate.Value.Month).Length - 2, 2) +
                            ("0000" + maxNo).Substring(("0000" + maxNo).Length - 4, 4);
                    }
                    con.Close();
                }


                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_save_purchase_requestH";
                cmd.Parameters.AddWithValue("@pr_code", run);
                cmd.Parameters.AddWithValue("@Pr_date", string.Format("{0:yyyy-MM-dd}", dtp_pr.SelectedDate.Value));
                cmd.Parameters.AddWithValue("@type_source", cb_type_ref.SelectedValue);
                cmd.Parameters.AddWithValue("@ctrl_no", cb_ref.Text);
                cmd.Parameters.AddWithValue("@priority", cb_priority.SelectedValue);
                cmd.Parameters.AddWithValue("@wh_code", cb_warehouse.SelectedValue);
                cmd.Parameters.AddWithValue("@remark", txt_remark.Text);
                cmd.Parameters.AddWithValue("@FreBy", cb_prepare_by.SelectedValue);
                cmd.Parameters.AddWithValue("@OrdBy", cb_orderBy.SelectedValue);
                cmd.Parameters.AddWithValue("@CekBy", cb_checked.SelectedValue);
                cmd.Parameters.AddWithValue("@AppBy", cb_approved.SelectedValue);
                cmd.Parameters.AddWithValue("@region_code", cb_project.SelectedValue);
                cmd.Parameters.AddWithValue("@userid", public_str.user_id);
                cmd.Parameters.AddWithValue("@dept_code", cb_cost_ctr.SelectedValue);
                cmd.Parameters.AddWithValue("@unit_code", txt_unit_code.Text);
                cmd.Parameters.AddWithValue("@model_no", txt_unit_name.Text);
                cmd.Parameters.AddWithValue("@time_reading", Convert.ToDouble(txt_hm.Text));               
                cmd.Parameters.AddWithValue("@type_pr", "B");
                cmd.Parameters.AddWithValue("@Lvl", public_str.level);
                cmd.Parameters.AddWithValue("@doc_type", 1);
                cmd.Parameters.AddWithValue("@asset_id", "NON");
                cmd.ExecuteNonQuery();  


                //Save Detail

                foreach (GridDataItem item in RadGrid2.MasterTableView.Items)
                {
                    cmd = new SqlCommand();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Connection = con;
                    cmd.CommandText = "sp_save_purchase_requestD";
                    cmd.Parameters.AddWithValue("@prod_type", (item.FindControl("lblProdType") as Label).Text);
                    cmd.Parameters.AddWithValue("@Prod_code", (item.FindControl("lblProdCode") as Label).Text);
                    cmd.Parameters.AddWithValue("@no_ref", (item.FindControl("lblRS") as Label).Text);
                    cmd.Parameters.AddWithValue("@qty", Convert.ToDouble((item.FindControl("txtPartQty") as RadTextBox).Text));
                    cmd.Parameters.AddWithValue("@SatQty", (item.FindControl("lblUom") as Label).Text);
                    cmd.Parameters.AddWithValue("@DeliDate", string.Format("{0:yyyy-MM-dd}", (item.FindControl("dtpDelivDate") as RadDatePicker).SelectedDate));
                    cmd.Parameters.AddWithValue("@Remark", (item.FindControl("txtRemark_d") as RadTextBox).Text);
                    cmd.Parameters.AddWithValue("@pr_code", run);
                    cmd.Parameters.AddWithValue("@stock_hand", Convert.ToDouble((item.FindControl("lblSoh") as Label).Text));
                    cmd.Parameters.AddWithValue("@Prod_code_ori", (item.FindControl("lblProdCode") as Label).Text);
                    cmd.Parameters.AddWithValue("@dept_code", (item.FindControl("lblCostCtr") as Label).Text);

                    cmd.ExecuteNonQuery();
                }

            }
            catch (System.Exception ex)
            {
                con.Close();
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
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
                    ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind('navigateToInserted');", true);
                }
                pur01h01.tr_code = run;
                pur01h01.selected_project = cb_project.SelectedValue;
            }
        }

        protected void RadGrid2_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            if (!IsPostBack)
            {
                (sender as RadGrid).DataSource = new string[] { };
            }
            else if (Session["actionEdit"].ToString() == "new")
            {
                (sender as RadGrid).DataSource = new string[] { };
                (sender as RadGrid).DataSource = GetDataRefDetailTable(cb_ref.Text);
            }
            else if (Session["actionEdit"].ToString() == "edit")
            {
                (sender as RadGrid).DataSource = new string[] { };
                (sender as RadGrid).DataSource = GetDataRefDetailTable(txt_doc_code.Text);
            }
        }
    }
}