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
            cmd.CommandText = "SELECT ms_product_kind.kind_code, ms_product_kind.kind_name, ms_product_kind.prod_type_code, ms_product_kind.stMain, ms_product_kind.stEdit, " +
                              "CASE stMain WHEN '0' THEN 'Stock and Value' WHEN '1' THEN 'Only Stock' WHEN '2' THEN 'Non Stock' END AS status_main, " +
                              "ms_product_type.prod_type_name " +
                              "FROM ms_product_kind INNER JOIN " +
                              "ms_product_type ON ms_product_kind.prod_type_code = ms_product_type.prod_type_code " +
                              "WHERE(ms_product_kind.stEdit <> '4') "; 
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

        protected void RadGrid1_UpdateCommand(object source, GridCommandEventArgs e)
        {
            UserControl userControl = (UserControl)e.Item.FindControl(GridEditFormItem.EditFormUserControlID);
            try
            {
                cmd = new SqlCommand("update ms_product_kind set kind_name = @kind_name, prod_type_code = @prod_type_code, StMain = @StMain where kind_code = @kind_code", con);
                con.Open();
                cmd.Parameters.AddWithValue("@kind_code", (userControl.FindControl("txt_kind_code") as TextBox).Text);
                cmd.Parameters.AddWithValue("@kind_name", (userControl.FindControl("txt_kind_name") as TextBox).Text);
                cmd.Parameters.AddWithValue("@prod_type_code", (userControl.FindControl("cb_type") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@stMain", (userControl.FindControl("ddl_st_main") as DropDownList).Text);
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

        protected void RadGrid1_InsertCommand(object source, GridCommandEventArgs e)
        {
            UserControl userControl = (UserControl)e.Item.FindControl(GridEditFormItem.EditFormUserControlID);

            try
            {
                cmd = new SqlCommand("insert into ms_product_kind (kind_code, kind_name, prod_type_code, StMain, stEdit) values " +
                        "(@kind_code, @kind_name,@prod_type_code, CASE @StMain WHEN 'Stock and value' THEN '0' WHEN 'Only Stock' THEN '1' " +
                        "ELSE '2' END, '1')", con);
                con.Open();
                cmd.Parameters.AddWithValue("@kind_code", (userControl.FindControl("txt_kind_code") as TextBox).Text);
                cmd.Parameters.AddWithValue("@kind_name", (userControl.FindControl("txt_kind_name") as TextBox).Text);
                cmd.Parameters.AddWithValue("@prod_type_code", (userControl.FindControl("cb_type") as RadComboBox).DataValueField);
                cmd.Parameters.AddWithValue("@stMain", (userControl.FindControl("ddl_st_main") as DropDownList).Text);
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

        protected void RadGrid1_DeleteCommand(object source, GridCommandEventArgs e)
        {
            UserControl userControl = (UserControl)e.Item.FindControl(GridEditFormItem.EditFormUserControlID);

            try
            {
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "update ms_product_kind set stEdit = 4 where kind_code = @kind_code";
                cmd.Parameters.AddWithValue("@kind_code", (RadGrid1.SelectedItems[0] as GridDataItem).GetDataKeyValue("kind_code").ToString());
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