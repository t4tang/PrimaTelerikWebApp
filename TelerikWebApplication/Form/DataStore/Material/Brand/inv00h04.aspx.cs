using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using TelerikWebApplication.Class;

namespace TelerikWebApplication.Form.Master_data.Material.Brand
{
    public partial class material_brand : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
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
            cmd.CommandText = "select * from inv00h04 where stEdit != 4";
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
                cmd = new SqlCommand("update inv00h04 set brand_name = @brand_name, userid = @uid, lastupdate = @lastupdate " +
                    "where brand_code = @brand_code", con);
                con.Open();
                cmd.Parameters.AddWithValue("@brand_code", (userControl.FindControl("txt_brand_code") as TextBox).Text);
                cmd.Parameters.AddWithValue("@brand_name", (userControl.FindControl("txt_brand_name") as TextBox).Text);
                cmd.Parameters.AddWithValue("@uid", public_str.uid);
                cmd.Parameters.AddWithValue("@lastupdate", string.Format("{0:yyyy-MM-dd}", DateTime.Now));
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

        protected void RadGrid1_InsertCommand(object source, GridCommandEventArgs e)
        {
            UserControl userControl = (UserControl)e.Item.FindControl(GridEditFormItem.EditFormUserControlID);

            try
            {
                cmd = new SqlCommand("insert into inv00h04 (brand_code, brand_name, lastupdate, userid, stEdit) values " +
                    "(@brand_code, @brand_name, @lastupdate, @uid, '0')", con);
                con.Open();
                cmd.Parameters.AddWithValue("@brand_code", (userControl.FindControl("txt_brand_code") as TextBox).Text);
                cmd.Parameters.AddWithValue("@brand_name", (userControl.FindControl("txt_brand_name") as TextBox).Text);
                cmd.Parameters.AddWithValue("@uid", public_str.uid);
                cmd.Parameters.AddWithValue("@lastupdate", string.Format("{0:yyyy-MM-dd}", DateTime.Now));
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
                cmd.CommandText = "update inv00h04 set stEdit = 4 where brand_code = @brand_code";
                cmd.Parameters.AddWithValue("@brand_code", RadGrid1.MasterTableView.Items[0].GetDataKeyValue("brand_code").ToString());
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