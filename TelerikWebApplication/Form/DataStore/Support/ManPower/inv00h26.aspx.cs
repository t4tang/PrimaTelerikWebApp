using System;
using System.Collections.Generic;
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
            cmd.CommandText = "SELECT inv00h26.Nik, inv00h26.Name, inv00h26.Jabatan, inv00h26.EmpNo, inv00h26.poh_code, inv00h26.tgl_terima, " +
            "inv00h26.pos_price, inv00h26.region_code, inv00h26.dept_code, inv00h26.kpj_no, inv00h26.npwp, " +
            "inv00h26.stGender, (CASE inv00h26.stGender WHEN 'M' THEN 'Male' WHEN 'F' THEN 'Female'END) AS stGenderDesc, " +
            "inv00h26.stMarital, inv00h26.stEmployee, (CASE inv00h26.stEmployee WHEN '1' THEN 'Permanen' WHEN '2' THEN 'Percobaan' " +
            "WHEN '3' THEN 'Harian' WHEN '4' THEN 'Kontrak'END) AS stEmployeeDesc, inv00h10.dept_name, inv00h25.city_name," +
            "inv00h26.status,(CASE inv00h26.status WHEN '1' THEN 'Active' WHEN '2' THEN 'Resign' WHEN '3' THEN 'PHK' WHEN '4' THEN 'Mutasi' " +
            "END) AS statusDesc, (SELECT region_name FROM inv00h09 WHERE region_code = inv00h26.region_code) AS region_name, inv00h26.remark " +
            "FROM inv00h26, inv00h10, inv00h25 WHERE inv00h26.stEdit <> '4' AND inv00h10.dept_code = inv00h26.dept_code " +
            " AND inv00h25.city_code = inv00h26.poh_code";
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
                TextBox txt = (item.FindControl("txt_Code") as TextBox);
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
                cmd.CommandText = "INSERT INTO inv00h26(Nik, Name, Jabatan, EmpNo, Stamp, Usr, Owner, stEdit, poh_code, " +
                    " dept_code, kpj_no, tgl_terima, region_code, NPWP, stGender, stEmployee, stMarital, remark, status)" +
                    " VALUES(@Nik, @Name, @Jabatan, @EmpNo, @Stamp, @Usr, @Owner, 0, @poh_code, " +
                    " @dept_code, @kpj_no, @tgl_terima, @region_code, @NPWP, @stGender, @stEmployee, @stMarital, @remark, @status)";
                cmd.Parameters.AddWithValue("@Nik", (item.FindControl("txt_Code") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@Name", (item.FindControl("txt_kind_name") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@Jabatan", (item.FindControl("cb_type") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@EmpNo", (item.FindControl("cb_st_main") as RadComboBox).Text);
                cmd.Parameters.AddWithValue("@Stamp", (item.FindControl("txt_kind_code") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
                cmd.Parameters.AddWithValue("@Owner", (item.FindControl("txt_kind_name") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@poh_code", (item.FindControl("txt_kind_code") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@dept_code", (item.FindControl("txt_kind_name") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@kpj_no", (item.FindControl("txt_kind_code") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@tgl_terima", (item.FindControl("txt_kind_name") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@region_code", (item.FindControl("txt_kind_name") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@NPWP", (item.FindControl("txt_kind_code") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@stGender", (item.FindControl("rb_gender") as RadioButtonList).SelectedValue);
                cmd.Parameters.AddWithValue("@stEmployee", (item.FindControl("rb_EmpSts") as RadioButtonList).SelectedValue);
                cmd.Parameters.AddWithValue("@stMarital", (item.FindControl("cb_maritalSts") as RadioButtonList).SelectedValue);
                cmd.Parameters.AddWithValue("@remark", (item.FindControl("txt_kind_code") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@status", (item.FindControl("txt_kind_name") as RadTextBox).Text);
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

        }

        protected void RadGrid1_DeleteCommand(object sender, GridCommandEventArgs e)
        {

        }
    }
}