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

namespace TelerikWebApplication.Form.Preventive_maintenance.MaterialRequest
{
    public partial class inv01h02EditForm : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();

        private const int ItemsPerRequest = 10;

        public static string tr_code = null;
        public static string chart_code = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                dtp_date.SelectedDate = DateTime.Now;
                dtp_deliv.SelectedDate = DateTime.Now;
                if (Request.QueryString["sro_code"] != null)
                {
                    DetailPage.Enabled = true;
                    fill_object(Request.QueryString["sro_code"].ToString());
                    //RadGrid2.DataSource = GetDataDetailTable(Request.QueryString["sro_code"].ToString());
                    tr_code = Request.QueryString["sro_code"].ToString();
                    Session["actionEdit"] = "edit";
                    RadTabStrip1.Tabs[1].Enabled = true;
                }
                else
                {
                    DetailPage.Enabled = false;
                    Session["actionEdit"] = "new";
                }
            }

        }

        private static string GetStatusMessage(int offset, int total)
        {
            if (total <= 0)
                return "No matches";

            return String.Format("Items <b>1</b>-<b>{0}</b> out of <b>{1}</b>", offset, total);
        }

        protected void RadGrid1_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            if (tr_code == null)
            {
                (sender as RadGrid).DataSource = new string[] { };
            }
            else
            {
                (sender as RadGrid).DataSource = GetDataOpertionTable(tr_code);
            }
        }

        #region Project
        private static DataTable GetProject(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT region_code, region_name FROM inv00h09 WHERE stEdit != 4 AND region_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }

        protected void cb_Project_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
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
            cmd.CommandText = "SELECT region_code FROM inv00h09 WHERE region_name = '" + cb_Project.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_Project.SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_Project_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT region_code FROM inv00h09 WHERE region_name = '" + cb_Project.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_Project.SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }
        #endregion


        #region WO

        public DataTable GetDataRefDetailTable(string projectID)  
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_material_request_refH";
            cmd.Parameters.AddWithValue("@project", projectID);
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

        protected void LoadWO(string trans_id, string projectID, RadComboBox cb)  
        {
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);


            SqlDataAdapter adapter = new SqlDataAdapter("SELECT trans_id, trans_date, unit_code, unitstatus, DBDate, BDTime, OrderName, remark FROM v_material_request_H_reff " +
                "WHERE region_code = @project AND trans_id LIKE @text + '%'", con);
            adapter.SelectCommand.Parameters.AddWithValue("@project", projectID);
            adapter.SelectCommand.Parameters.AddWithValue("@text", trans_id);
            DataTable dt = new DataTable();
            adapter.Fill(dt);

            cb.DataTextField = "trans_id";
            cb.DataValueField = "trans_id";
            cb.DataSource = dt;
            cb.DataBind();
        }

        protected void cb_wo_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadWO(e.Text, cb_Project.SelectedValue, (sender as RadComboBox));
        }

        protected void cb_wo_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT * FROM v_material_request_H_reff WHERE trans_id = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            }
            dr.Close();
            con.Close();
        }

        protected void cb_wo_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT * FROM v_material_request_H_reff WHERE trans_id = '" + (sender as RadComboBox).SelectedValue + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).Text = dr["trans_id"].ToString();
                txt_unit.Text = dr["unit_code"].ToString();
                cb_priority.Text = dr["prio_desc"].ToString();
                cb_Order.Text = dr["OrderName"].ToString();
                cb_job.Text = dr["PMAct_Name"].ToString();
                txt_remark.Text = dr["remark"].ToString();
            }

            dr.Close();
            con.Close();

            RadGrid1.DataSource = GetDataOpertionReff((sender as RadComboBox).Text);
            RadGrid1.DataBind();
            RadGrid2.DataSource = GetDataRefDetailTable((sender as RadComboBox).SelectedValue);
            RadGrid2.DataBind();
        }
        #endregion

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
        #endregion

        #region Order
        private static DataTable GetOrder(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT OrderType, OrderName FROM mtc00h23 WHERE stEdit != 4 AND OrderName LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_Order_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetOrder(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                cb_Order.Items.Add(new RadComboBoxItem(data.Rows[i]["OrderName"].ToString(), data.Rows[i]["OrderName"].ToString()));
            }
        }

        protected void cb_Order_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT OrderType FROM mtc00h23 WHERE OrderName = '" + cb_Order.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_Order.SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_Order_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT OrderType FROM mtc00h23 WHERE OrderName = '" + cb_Order.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_Order.SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }
        #endregion

        #region Job Type
        private static DataTable GetJob(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT PMact_type, PMAct_Name FROM mtc00h22 WHERE stEdit != 4 AND PMAct_Name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }

        protected void cb_job_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetJob(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                cb_job.Items.Add(new RadComboBoxItem(data.Rows[i]["PMAct_Name"].ToString(), data.Rows[i]["PMAct_Name"].ToString()));
            }
        }

        protected void cb_job_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT PMact_type FROM mtc00h22 WHERE PMAct_Name = '" + cb_job.Text + "' AND status_hist != 4";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_job.SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_job_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT PMact_type FROM mtc00h22 WHERE PMAct_Name = '" + cb_job.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_job.SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
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
        protected void cb_checked_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            cb_checked.Text = "";
            LoadManPower(e.Text, cb_Project.SelectedValue, cb_checked);
        }

        protected void cb_checked_DataBound(object sender, EventArgs e)
        {
            ((Literal)cb_checked.Footer.FindControl("RadComboItemsCount")).Text = Convert.ToString(cb_checked.Items.Count);
        }

        protected void cb_checked_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + cb_checked.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_checked.SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_checked_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + cb_checked.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_checked.SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_ack_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            cb_ack.Text = "";
            LoadManPower(e.Text, cb_Project.SelectedValue, cb_ack);
        }

        protected void cb_ack_DataBound(object sender, EventArgs e)
        {
            ((Literal)cb_ack.Footer.FindControl("RadComboItemsCount")).Text = Convert.ToString(cb_ack.Items.Count);
        }

        protected void cb_ack_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + cb_ack.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_ack.SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_ack_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + cb_ack.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_ack.SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_ordered_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            cb_ordered.Text = "";
            LoadManPower(e.Text, cb_Project.SelectedValue, cb_ordered);
        }

        protected void cb_ordered_DataBound(object sender, EventArgs e)
        {
            ((Literal)cb_ordered.Footer.FindControl("RadComboItemsCount")).Text = Convert.ToString(cb_ordered.Items.Count);
        }

        protected void cb_ordered_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + cb_ordered.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_ordered.SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_ordered_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + cb_ordered.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_ordered.SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }
        #endregion

        public DataTable GetDataDetailTable(string sro_code)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_material_requestD";
            cmd.Parameters.AddWithValue("@sro_code", sro_code);
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
        public DataTable GetDataOpertionTable(string sro_code)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT c.sro_code, a.trans_id, a.chart_code, b.OprName FROM mtc01h03 a, mtc00h25 b, inv01h02 c " +
                "WHERE a.chart_code = b.OprCode AND c.trans_id = a.trans_id AND c.sro_code = @sro_code";
            cmd.Parameters.AddWithValue("@sro_code", sro_code);
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
        public DataTable GetDataOpertionReff(string trans_id)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT a.chart_code, b.OprName FROM mtc01h03 AS a INNER JOIN mtc00h25 AS b ON a.chart_code = b.OprCode WHERE a.trans_id = @trans_id";
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
        public DataTable GetDataDetailTableD(string trans_id)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_material_request_refD";
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
        protected void RadGrid2_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            if (!IsPostBack)
            {
                (sender as RadGrid).DataSource = new string[] { };
            }
            else if (Session["actionEdit"].ToString() == "new")
            {
                (sender as RadGrid).DataSource = new string[] { };
                (sender as RadGrid).DataSource = GetDataDetailTableD(cb_wo.Text);
            }
            else if (Session["actionEdit"].ToString() == "edit")
            {
                (sender as RadGrid).DataSource = new string[] { };
                (sender as RadGrid).DataSource = GetDataDetailByChartCode(tr_code, chart_code);
            }
        }

        protected void RadGrid2_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            var part_code = ((GridDataItem)e.Item).GetDataKeyValue("part_code");

            try
            {
                GridEditableItem item = (GridEditableItem)e.Item;
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "delete from inv01d02 where part_code = @part_code and sro_code = @sro_code";
                cmd.Parameters.AddWithValue("@sro_code", txt_mr_number.Text);
                cmd.Parameters.AddWithValue("@part_code", part_code);
                cmd.ExecuteNonQuery();
                con.Close();
                //RadGrid2.DataBind();

                Label lblsuccess = new Label();
                lblsuccess.Text = "Data deleted";
                lblsuccess.ForeColor = System.Drawing.Color.DarkGray;
                //RadGrid2.Controls.Add(lblsuccess);
            }
            catch (Exception ex)
            {
                con.Close();
                Label lblError = new Label();
                lblError.Text = "Unable to delete data. Reason: " + ex.Message;
                lblError.ForeColor = System.Drawing.Color.Red;
                //RadGrid2.Controls.Add(lblError);
                e.Canceled = true;
            }
        }

        protected void fill_object(string id)
        {
            con.Open();
            SqlDataReader sdr;
            SqlCommand cmd = new SqlCommand("SELECT * FROM v_material_requestH WHERE sro_code = '" + id + "'", con);
            sdr = cmd.ExecuteReader();
            if (sdr.Read())
            {
                txt_mr_number.Text = sdr["sro_code"].ToString();
                dtp_date.SelectedDate = Convert.ToDateTime(sdr["sro_date"].ToString());
                cb_Project.Text = sdr["region_name"].ToString();
                cb_wo.Text = sdr["trans_id"].ToString();
                txt_unit.Text = sdr["unit_code"].ToString();
                dtp_deliv.SelectedDate = Convert.ToDateTime(sdr["deliv_date"].ToString());
                cb_priority.Text = sdr["prio_desc"].ToString();
                cb_Order.Text = sdr["OrderName"].ToString();
                cb_job.Text = sdr["PMAct_Name"].ToString();
                cb_ordered.Text = sdr["OrdByName"].ToString();
                cb_checked.Text = sdr["CheckedByName"].ToString();
                cb_ack.Text = sdr["AckByName"].ToString();
                txt_remark.Text = sdr["sro_remark"].ToString();
                //lbl_userId.Text = lbl_userId.Text + sdr["LASTUSER"].ToString();
                //lbl_lastUpdate.Text = lbl_lastUpdate.Text + String.Format("{0:dd-MM-yyyy}", sdr["lastupdate"].ToString());
                //lbl_Owner.Text = lbl_Owner.Text + sdr["Owner"].ToString();
                //lbl_Printed.Text = lbl_Printed.Text + sdr["Printed"].ToString();
                //lbl_edited.Text = lbl_edited.Text + sdr["Edited"].ToString();
            }
            con.Close();
        }

        protected void btn_save_Click(object sender, EventArgs e)
        {
            long maxNo;
            string run = null;
            string trDate = string.Format("{0:dd/MM/yyyy}", dtp_date.SelectedDate);

            try
            {
                if (Session["actionEdit"].ToString() == "edit")
                {
                    run = txt_mr_number.Text;
                }
                else
                {
                    con.Open();
                    SqlDataReader sdr;
                    cmd = new SqlCommand("SELECT ISNULL ( MAX ( RIGHT ( inv01h02.sro_code , 4 ) ) , 0 ) + 1 AS maxNo " +
                        "FROM inv01h02 WHERE LEFT(inv01h02.sro_code, 4) = 'MR03' " +
                        "AND SUBSTRING(inv01h02.sro_code, 5, 2) = SUBSTRING('" + trDate + "', 9, 2) " +
                        "AND SUBSTRING(inv01h02.sro_code, 7, 2) = SUBSTRING('" + trDate + "', 4, 2) ", con);
                    sdr = cmd.ExecuteReader();
                    if (sdr.HasRows == false)
                    {
                        //throw new Exception();
                        run = "MR03" + dtp_date.SelectedDate.Value.Year + dtp_date.SelectedDate.Value.Month + "0001";
                    }
                    else if (sdr.Read())
                    {
                        maxNo = Convert.ToInt32(sdr[0].ToString());
                        run = "MR03" + (dtp_date.SelectedDate.Value.Year.ToString()).Substring(dtp_date.SelectedDate.Value.Year.ToString().Length - 2) +
                            ("0000" + dtp_date.SelectedDate.Value.Month).Substring(("0000" + dtp_date.SelectedDate.Value.Month).Length - 2, 2) +
                            ("0000" + maxNo).Substring(("0000" + maxNo).Length - 4, 4);
                    }
                    con.Close();
                }

                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_save_material_requestH";
                cmd.Parameters.AddWithValue("@sro_code", run);
                cmd.Parameters.AddWithValue("@region_code", cb_Project.SelectedValue);
                cmd.Parameters.AddWithValue("@trans_id", cb_wo.SelectedValue);
                cmd.Parameters.AddWithValue("@sro_reason","01");
                cmd.Parameters.AddWithValue("@unit_code", txt_unit.Text);
                cmd.Parameters.AddWithValue("@sro_date", string.Format("{0:yyyy-MM-dd}", dtp_date.SelectedDate.Value));
                cmd.Parameters.AddWithValue("@deliv_date", string.Format("{0:yyyy-MM-dd}", dtp_deliv.SelectedDate.Value));
                cmd.Parameters.AddWithValue("@sro_kind", cb_priority.SelectedValue);
                cmd.Parameters.AddWithValue("@ordertype", cb_Order.SelectedValue);
                cmd.Parameters.AddWithValue("@job_status", cb_job.SelectedValue);
                cmd.Parameters.AddWithValue("@ord_by", cb_ordered.SelectedValue);
                cmd.Parameters.AddWithValue("@userid", cb_checked.SelectedValue);
                cmd.Parameters.AddWithValue("@ack_by", cb_ack.SelectedValue);
                cmd.Parameters.AddWithValue("@sro_remark", txt_remark.Text);
                cmd.Parameters.AddWithValue("@LASTUSER", public_str.user_id);
                cmd.Parameters.AddWithValue("@lastupdate", DateTime.Today);
                cmd.Parameters.AddWithValue("@status", 1);
                cmd.Parameters.AddWithValue("@Owner", public_str.user_id);
                cmd.Parameters.AddWithValue("@OwnStamp", DateTime.Today);
                cmd.Parameters.AddWithValue("@Printed", 1);
                cmd.Parameters.AddWithValue("@Edited", 0);
                cmd.Parameters.AddWithValue("@void", 3);
                cmd.ExecuteNonQuery();

                foreach (GridDataItem item in RadGrid1.MasterTableView.Items)
                {
                    cmd = new SqlCommand();
                    cmd.CommandType = CommandType.Text;
                    cmd.Connection = con;
                    if (Session["actionEdit"].ToString() == "edit")
                    {
                        cmd.CommandText = "UPDATE mtc01h03 SET chart_code= @chart_code WHERE trans_id=@trans_id";
                        cmd.Parameters.AddWithValue("@trans_id", run);
                        cmd.Parameters.AddWithValue("@chart_code", item["chart_code"].Text);
                        cmd.ExecuteNonQuery();
                    }
                    else
                    {
                        cmd.CommandText = "INSERT INTO mtc01h03(trans_id, chart_code, formula) VALUES (@trans_id, @chart_code, 0)";
                        cmd.Parameters.AddWithValue("@trans_id", run);
                        cmd.Parameters.AddWithValue("@chart_code", item["chart_code"].Text);
                        cmd.ExecuteNonQuery();
                    }
                    
                }
            }
            catch (Exception ex)
            {
                con.Close();
                //Response.Write("<font color='red'>" + ex.Message + "</font>");
                //RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "");
                //RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn","");
            }
            finally
            {
                con.Close();
                //notif.Text = "Data berhasil disimpan";
                //notif.Title = "Notification";
                //notif.Show();
                txt_mr_number.Text = run;

                RadTabStrip1.Tabs[1].Enabled = true;
                RadTabStrip1.SelectedIndex = 1;
                DetailPage.Enabled = true;
                DetailPage.Selected = true;

                if (Session["actionEdit"].ToString() == "edit")
                {
                    ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind();", true);
                }
                else
                {
                    inv01h02.tr_code = run;
                    inv01h02.selected_project = cb_Project.SelectedValue;
                    ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind('navigateToInserted');", true);
                }
            }


        }

        protected void cb_prod_code_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            string sql = "SELECT TOP (100)[prod_code], [spec], [unit] FROM [inv00h01]  WHERE stEdit != '4' AND spec LIKE @spec + '%'";
            SqlDataAdapter adapter = new SqlDataAdapter(sql,
                ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@spec", e.Text);

            DataTable dt = new DataTable();
            adapter.Fill(dt);

            RadComboBox comboBox = (RadComboBox)sender;
            // Clear the default Item that has been re-created from ViewState at this point.
            comboBox.Items.Clear();

            foreach (DataRow row in dt.Rows)
            {
                RadComboBoxItem item = new RadComboBoxItem();
                item.Text = row["prod_code"].ToString();
                item.Value = row["prod_code"].ToString();
                item.Attributes.Add("spec", row["spec"].ToString());
                item.Attributes.Add("unit", row["unit"].ToString());

                comboBox.Items.Add(item);

                item.DataBind();
            }
        }

        protected void cb_prod_code_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "SELECT spec,unit FROM inv00h01 WHERE prod_code = '" + (sender as RadComboBox).SelectedValue + "'";

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                foreach (DataRow dtr in dt.Rows)
                {
                    RadComboBox cb = (RadComboBox)sender;
                    GridEditableItem item = (GridEditableItem)cb.NamingContainer;
                    Label lbl_prodType = (Label)item.FindControl("lbl_prodType");
                    Label lblQtyRs = (Label)item.FindControl("lblQtyRs");
                    Label lbl_UoM = (Label)item.FindControl("lbl_UoM");
                    RadTextBox txtPartQty = (RadTextBox)item.FindControl("txtPartQty");

                    lbl_prodType.Text = "M1";
                    lblQtyRs.Text = "0";
                    lbl_UoM.Text= dtr["unit"].ToString();
                    txtPartQty.Text = "0";
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

        protected void RadGrid2_save_handler(object sender, GridCommandEventArgs e)
        {
            try
            {
                GridEditableItem item = (GridEditableItem)e.Item;
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_save_material_requestD";
                cmd.Parameters.AddWithValue("@prod_type", (item.FindControl("lbl_prodType") as Label).Text);
                cmd.Parameters.AddWithValue("@item", DBNull.Value);
                cmd.Parameters.AddWithValue("@part_qty", Convert.ToDouble((item.FindControl("txtPartQty") as RadTextBox).Text));
                cmd.Parameters.AddWithValue("@sro_code", txt_mr_number.Text);
                cmd.Parameters.AddWithValue("@part_code", (item.FindControl("cb_prod_code") as RadComboBox).Text);
                cmd.Parameters.AddWithValue("@part_unit", (item.FindControl("lbl_UoM") as Label).Text);
                cmd.Parameters.AddWithValue("@chart_code", chart_code);
                cmd.Parameters.AddWithValue("@trans_id", cb_wo.Text);
                cmd.Parameters.AddWithValue("@deliv_date", string.Format("{0:yyyy-MM-dd}", dtp_deliv.SelectedDate.Value));
                if ((item.FindControl("chk_warranty") as CheckBox).Checked == true)
                {
                    cmd.Parameters.AddWithValue("@tWarranty", 1);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@tWarranty", 0);
                }
                cmd.Parameters.AddWithValue("@remark", (item.FindControl("txtRemark_d") as RadTextBox).Text);
                cmd.ExecuteNonQuery();
                

                //notif.Show();

            }
            catch (Exception ex)
            {
                con.Close();
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
                e.Canceled = true;
            }
            finally
            {
                con.Close();
                RadGrid2.DataSource = GetDataDetailByChartCode(txt_mr_number.Text, chart_code);
                RadGrid2.DataBind();
            }
        }

        protected void RadGrid1_SelectedIndexChanged(object sender, EventArgs e)
        {
            foreach (GridDataItem item in RadGrid1.SelectedItems)
            {
                chart_code = item["chart_code"].Text;
                RadGrid2.DataSource = GetDataDetailByChartCode(txt_mr_number.Text, chart_code);
                RadGrid2.DataBind();
            }
        }
        public DataTable GetDataDetailByChartCode(string sro_code, string chart_code)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_material_requestD_by_chartCode";
            cmd.Parameters.AddWithValue("@sro_code", sro_code);
            cmd.Parameters.AddWithValue("@chart_code", chart_code);
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

        protected void RadGrid1_PreRender(object sender, EventArgs e)
        {
            if (Session["actionEdit"].ToString() == "firstLoad")
            {
                if ((sender as RadGrid).MasterTableView.Items.Count > 0)
                    (sender as RadGrid).MasterTableView.Items[0].Selected = true;

                foreach (GridDataItem item in (sender as RadGrid).SelectedItems)
                {
                    tr_code = item["chart_code"].Text;
                }

                RadGrid2.DataSource = GetDataDetailByChartCode(txt_mr_number.Text, chart_code);
                RadGrid2.DataBind();
            }
        }
    }
}