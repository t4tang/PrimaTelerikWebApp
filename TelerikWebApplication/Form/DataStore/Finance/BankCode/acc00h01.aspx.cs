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

namespace TelerikWebApplication.Form.DataStore.Finance.BankCode
{
    public partial class acc00h01 : System.Web.UI.Page
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
            cmd.CommandText = "SELECT acc00h01.KoBank, acc00h01.NamBank, acc00h01.NamaRek, acc00h01.NoRek, acc00h01.status, acc00h01.KoRek, acc00h01.SAwal,acc00h01.SAValas, " +
            "acc00h01.Lvl, acc00h01.Stamp,acc00h01.Usr,acc00h01.Owner,acc00h01.LastUpdate ,acc00h01.stEdit, acc00h10.accountname, acc00h10.cur_code, " +
            "(select region_name from inv00h09 where region_code = acc00h01.region_code ) as project_name " +
            "FROM acc00h01, acc00h10  WHERE(acc00h01.KoRek = acc00h10.accountno) and((acc00h01.stEdit = '0'))  ";
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

        protected void RadGrid1_UpdateCommand(object source, GridCommandEventArgs e)
        {
            try
            {
                if (e.CommandName == RadGrid.UpdateCommandName)
                {
                    if (e.Item is GridEditFormItem)
                    {
                        GridEditFormItem item = (GridEditFormItem)e.Item;

                        cmd = new SqlCommand("update inv00h02 set kind_name = @kind_name, prod_type_code = @prod_type_code, " +
                                "StMain = CASE @StMain WHEN 'Stock and value' THEN '0' WHEN 'Only Stock' THEN '1' " +
                                "ELSE '2' END, LastUpdate = getdate(), Userid = @Usr where kind_code = @kind_code", con);
                        con.Open();
                        cmd.Parameters.AddWithValue("@kind_code", (item.FindControl("txt_kind_code") as TextBox).Text);
                        cmd.Parameters.AddWithValue("@kind_name", (item.FindControl("txt_kind_name") as TextBox).Text);
                        cmd.Parameters.AddWithValue("@prod_type_code", (item.FindControl("cb_type") as RadComboBox).SelectedValue);
                        cmd.Parameters.AddWithValue("@stMain", (item.FindControl("cb_st_main") as RadComboBox).Text);
                        cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
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

        protected void RadGrid1_DeleteCommand(object source, GridCommandEventArgs e)
        {
            var kind_code = ((GridDataItem)e.Item).GetDataKeyValue("kind_code");

            try
            {
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "update inv00h02 set stEdit = '4', LastUpdate = getdate(), Userid = @Usr where kind_code = @kind_code";
                cmd.Parameters.AddWithValue("@kind_code", kind_code);
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

    }
}