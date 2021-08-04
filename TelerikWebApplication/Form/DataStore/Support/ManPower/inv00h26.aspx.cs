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

namespace TelerikWebApplication.Form.DataStore.Support.ManPower
{
    public partial class inv00h26 : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();
        private const int ItemsPerRequest = 10;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        private static string GetStatusMessage(int offset, int total)
        {
            if (total <= 0)
                return "No matches";

            return String.Format("Items <b>1</b>-<b>{0}</b> out of <b>{1}</b>", offset, total);
        }

        public DataTable GetDataTable()
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT ms_manpower.Nik, ms_manpower.Name, ms_manpower.Jabatan, ms_manpower.EmpNo, ms_manpower.poh_code, ms_manpower.tgl_terima, " +
            "ms_manpower.pos_price, ms_manpower.region_code, ms_manpower.dept_code, ms_manpower.kpj_no, ms_manpower.npwp, " +
            "ms_manpower.stGender, (CASE ms_manpower.stGender WHEN 'M' THEN 'Male' WHEN 'F' THEN 'Female'END) AS stGenderDesc, " +
            "ms_manpower.stMarital, ms_manpower.stEmployee, (CASE ms_manpower.stEmployee WHEN '1' THEN 'Permanen' WHEN '2' THEN 'Percobaan' " +
            "WHEN '3' THEN 'Harian' WHEN '4' THEN 'Kontrak'END) AS stEmployeeDesc, ms_department.dept_name, ms_city.city_name," +
            "ms_manpower.status,(CASE ms_manpower.status WHEN '1' THEN 'Active' WHEN '2' THEN 'Resign' WHEN '3' THEN 'PHK' WHEN '4' THEN 'Mutasi' " +
            "END) AS statusDesc, (SELECT region_name FROM ms_jobsite WHERE region_code = ms_manpower.region_code) AS region_name, ms_manpower.remark " +
            "FROM ms_manpower, ms_department, ms_city WHERE ms_manpower.stEdit <> '4' AND ms_department.dept_code = ms_manpower.dept_code " +
            " AND ms_city.city_code = ms_manpower.poh_code";
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

        protected void RadGrid1_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            (sender as RadGrid).DataSource = GetDataTable();
        }

        protected void RadGrid1_ItemCreated(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridEditableItem & e.Item.IsInEditMode)
            {
                GridEditFormItem item = (GridEditFormItem)e.Item;
                RadTextBox txt = (item.FindControl("txt_Code") as RadTextBox);
                if (e.Item.OwnerTableView.IsItemInserted)
                    txt.Enabled = true;
                else
                    txt.Enabled = false;
            }
        }

        protected void RadGrid1_InsertCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                GridEditableItem item = (GridEditableItem)e.Item;
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "INSERT INTO ms_manpower(Nik, Name, Jabatan, EmpNo, Stamp, Usr,lastupdate, Owner, stEdit, poh_code, " +
                    " dept_code, kpj_no, tgl_terima, region_code, NPWP, stGender, stEmployee, stMarital, remark, status)" +
                    " VALUES(@Nik, @Name, @Jabatan, @EmpNo, GETDATE(), @Usr, GETDATE(), @Owner, 0, @poh_code, " +
                    " @dept_code, @kpj_no, @tgl_terima, @region_code, @NPWP, @stGender, @stEmployee, @stMarital, @remark, @status)";
                cmd.Parameters.AddWithValue("@Nik", (item.FindControl("txt_Code") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@Name", (item.FindControl("txt_EmpName") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@Jabatan", (item.FindControl("cb_position") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@EmpNo", (item.FindControl("txt_EmpNo") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
                cmd.Parameters.AddWithValue("@Owner", public_str.user_id);
                cmd.Parameters.AddWithValue("@poh_code", (item.FindControl("cb_poh") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@dept_code", (item.FindControl("cb_dept") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@kpj_no", (item.FindControl("txt_kpj_no") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@tgl_terima", (item.FindControl("dtp_hire") as RadDatePicker).SelectedDate);
                cmd.Parameters.AddWithValue("@region_code", (item.FindControl("cb_region") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@NPWP", (item.FindControl("txt_npwp") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@stGender", (item.FindControl("rb_gender") as RadioButtonList).SelectedValue);
                cmd.Parameters.AddWithValue("@stEmployee", (item.FindControl("rb_EmpSts") as RadioButtonList).SelectedValue);
                cmd.Parameters.AddWithValue("@stMarital", (item.FindControl("cb_maritalSts") as RadComboBox).Text);
                cmd.Parameters.AddWithValue("@remark", (item.FindControl("txt_remark") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@status", (item.FindControl("rb_status") as RadioButtonList).SelectedValue);
                cmd.ExecuteNonQuery();
                con.Close();

                Label lblsuccess = new Label();
                lblsuccess.Text = "Data inserted successfully";
                lblsuccess.ForeColor = System.Drawing.Color.Blue;
                RadGrid1.Controls.Add(lblsuccess);
            }
            catch (Exception ex)
            {
                con.Close();
                Label lblError = new Label();
                lblError.Text = "Unable to insert data. Reason: " + ex.Message;
                lblError.ForeColor = System.Drawing.Color.Red;
                RadGrid1.Controls.Add(lblError);
                e.Canceled = true;
            }

        }

        protected void RadGrid1_UpdateCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                if (e.CommandName == RadGrid.UpdateCommandName)
                {
                    if (e.Item is GridEditFormItem)
                    {
                        GridEditFormItem item = (GridEditFormItem)e.Item;

                        cmd = new SqlCommand("UPDATE ms_manpower SET Name = @Name, Jabatan = @Jabatan, EmpNo = @EmpNo, Usr = @Usr, lastupdate = GETDATE(), poh_code = @poh_code, dept_code = @dept_code, kpj_no = @kpj_no, " +
                        "tgl_terima = @tgl_terima, region_code = @region_code, NPWP = @NPWP, stGender = @stGender, stEmployee = @stEmployee, stMarital = @stMarital, " +
                        "remark = @remark, [status] = @status WHERE(Nik = @Nik)", con);
                        con.Open();
                        cmd.Parameters.AddWithValue("@Nik", (item.FindControl("txt_Code") as RadTextBox).Text);
                        cmd.Parameters.AddWithValue("@Name", (item.FindControl("txt_EmpName") as RadTextBox).Text);
                        cmd.Parameters.AddWithValue("@Jabatan", (item.FindControl("cb_position") as RadComboBox).SelectedValue);
                        cmd.Parameters.AddWithValue("@EmpNo", (item.FindControl("txt_EmpNo") as RadTextBox).Text);
                        cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
                        cmd.Parameters.AddWithValue("@poh_code", (item.FindControl("cb_poh") as RadComboBox).SelectedValue);
                        cmd.Parameters.AddWithValue("@dept_code", (item.FindControl("cb_dept") as RadComboBox).SelectedValue);
                        cmd.Parameters.AddWithValue("@kpj_no", (item.FindControl("txt_kpj_no") as RadTextBox).Text);
                        cmd.Parameters.AddWithValue("@tgl_terima", (item.FindControl("dtp_hire") as RadDatePicker).SelectedDate);
                        cmd.Parameters.AddWithValue("@region_code", (item.FindControl("cb_region") as RadComboBox).SelectedValue);
                        cmd.Parameters.AddWithValue("@NPWP", (item.FindControl("txt_npwp") as RadTextBox).Text);
                        cmd.Parameters.AddWithValue("@stGender", (item.FindControl("rb_gender") as RadioButtonList).SelectedValue);
                        cmd.Parameters.AddWithValue("@stEmployee", (item.FindControl("rb_EmpSts") as RadioButtonList).SelectedValue);
                        cmd.Parameters.AddWithValue("@stMarital", (item.FindControl("cb_maritalSts") as RadComboBox).Text);
                        cmd.Parameters.AddWithValue("@remark", (item.FindControl("txt_remark") as RadTextBox).Text);
                        cmd.Parameters.AddWithValue("@status", (item.FindControl("rb_status") as RadioButtonList).SelectedValue);
                        cmd.ExecuteNonQuery();
                        con.Close();
                    }
                }
                Label lblsuccess = new Label();
                lblsuccess.Text = "Data updated successfully";
                lblsuccess.ForeColor = System.Drawing.Color.Blue;
                RadGrid1.Controls.Add(lblsuccess);
            }

            catch (Exception ex)
            {
                con.Close();
                Label lblError = new Label();
                lblError.Text = "Unable to update data. Reason: " + ex.Message;
                lblError.ForeColor = System.Drawing.Color.Red;
                RadGrid1.Controls.Add(lblError);
                e.Canceled = true;
            }
        }

        protected void RadGrid1_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            var Nik = ((GridDataItem)e.Item).GetDataKeyValue("Nik");

            try
            {
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "update ms_manpower set stEdit = '4', LastUpdate = getdate(), Usr = @Usr where Nik = @Nik";
                cmd.Parameters.AddWithValue("@Nik", Nik);
                cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
                cmd.ExecuteNonQuery();
                con.Close();

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

        protected void cb_maritalSts_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Clear();
            (sender as RadComboBox).Items.Add("S");
            (sender as RadComboBox).Items.Add("S0");
            (sender as RadComboBox).Items.Add("S1");
            (sender as RadComboBox).Items.Add("S2");
            (sender as RadComboBox).Items.Add("S3");
            (sender as RadComboBox).Items.Add("M0");
            (sender as RadComboBox).Items.Add("M1");
            (sender as RadComboBox).Items.Add("M2");
            (sender as RadComboBox).Items.Add("M3");
        }
        private static DataTable GetPosition(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT position_code, position FROM ms_position WHERE stEdit != '4' AND position LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_position_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetPosition(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["position"].ToString(), data.Rows[i]["position"].ToString()));
            }

            e.Message = GetStatusMessage(endOffset, data.Rows.Count);
        }

        protected void cb_position_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT ms_position.position_code from ms_position where position = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["position_code"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_position_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT ms_position.position_code from ms_position where position = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["position_code"].ToString();
            dr.Close();
            con.Close();
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
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
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
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_dept_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT dept_code FROM ms_department WHERE dept_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }
        private static DataTable GetDept(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT dept_code, dept_name FROM ms_department WHERE stEdit != 4 AND dept_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_dept_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetDept(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["dept_name"].ToString(), data.Rows[i]["dept_name"].ToString()));
            }
        }

        protected void cb_dept_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT dept_code FROM ms_department WHERE dept_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }
        private static DataTable GetPoh(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT city_code, city_name FROM ms_city WHERE stEdit != 4 AND city_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_poh_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetPoh(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["city_name"].ToString(), data.Rows[i]["city_name"].ToString()));
            }
        }

        protected void cb_poh_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT city_code FROM ms_city WHERE city_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }
        protected void cb_poh_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT city_code FROM ms_city WHERE city_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }
        protected void MyRadioButtonList_DataBound(object sender, EventArgs e)
        {
            RadioButtonList list = (RadioButtonList)sender;
            ListItem blank = list.Items.FindByValue("");
            if (blank != null)
                list.Items.Remove(blank);
        }

        protected void btn_new_Click(object sender, EventArgs e)
        {
            RadGrid1.MasterTableView.IsItemInserted = true;
            RadGrid1.MasterTableView.Rebind();
        }
    }
}