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

namespace TelerikWebApplication.Form.Master_data.Material.Category
{
    public partial class category : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                RadGrid1.MasterTableView.EditMode = (GridEditMode)Enum.Parse(typeof(GridEditMode), "EditForms");
            }
        }

        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();
        public DataTable GetDataTable()
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT inv00h02.kind_code, inv00h02.kind_name, inv00h02.prod_type_code, inv00h02.stMain, inv00h02.stEdit, " +
                              "CASE stMain WHEN '0' THEN 'Stock and Value' WHEN '1' THEN 'Only Stock' WHEN '2' THEN 'Non Stock' END AS status_main, " +
                              "ms_product_type.prod_type_name " +
                              "FROM inv00h02 INNER JOIN " +
                              "ms_product_type ON inv00h02.prod_type_code = ms_product_type.prod_type_code " +
                              "WHERE(inv00h02.stEdit <> '4') "; 
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
             

        protected void RadGrid1_InsertCommand(object source, GridCommandEventArgs e)
        {
            UserControl userControl = (UserControl)e.Item.FindControl(GridEditFormItem.EditFormUserControlID);

            try
            {
                cmd = new SqlCommand("insert into inv00h02 (kind_code, kind_name, prod_type_code, StMain, stEdit) values " +
                        "(@kind_code, @kind_name,@prod_type_code, CASE @StMain WHEN 'Stock and value' THEN '0' WHEN 'Only Stock' THEN '1' " +
                        "ELSE '2' END, '0')", con);
                con.Open();
                cmd.Parameters.AddWithValue("@kind_code", (userControl.FindControl("txt_kind_code") as TextBox).Text);
                cmd.Parameters.AddWithValue("@kind_name", (userControl.FindControl("txt_kind_name") as TextBox).Text);
                cmd.Parameters.AddWithValue("@prod_type_code", (userControl.FindControl("cb_type") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@stMain", (userControl.FindControl("cb_st_main") as RadComboBox).Text);
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
            UserControl userControl = (UserControl)e.Item.FindControl(GridEditFormItem.EditFormUserControlID);
            try
            {
                cmd = new SqlCommand("update inv00h02 set kind_name = @kind_name, prod_type_code = @prod_type_code, " +
                    "StMain = CASE @StMain WHEN 'Stock and value' THEN '0' WHEN 'Only Stock' THEN '1' " +
                    "ELSE '2' END where kind_code = @kind_code", con);
                con.Open();
                cmd.Parameters.AddWithValue("@kind_code", (userControl.FindControl("txt_kind_code") as TextBox).Text);
                cmd.Parameters.AddWithValue("@kind_name", (userControl.FindControl("txt_kind_name") as TextBox).Text);
                cmd.Parameters.AddWithValue("@prod_type_code", (userControl.FindControl("cb_type") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@stMain", (userControl.FindControl("cb_st_main") as RadComboBox).Text);
                cmd.ExecuteNonQuery();
                con.Close();

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
            UserControl userControl = (UserControl)e.Item.FindControl(GridEditFormItem.EditFormUserControlID);

            try
            {
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "update inv00h02 set stEdit = '4' where kind_code = @kind_code";
                cmd.Parameters.AddWithValue("@kind_code", RadGrid1.MasterTableView.Items[0].GetDataKeyValue("kind_code").ToString());
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