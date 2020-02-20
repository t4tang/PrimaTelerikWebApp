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

namespace TelerikWebApplication.Form.DataStore.Customer.MasterArea
{
    public partial class inv00h24 : System.Web.UI.Page
    {
        public static string koneksi = ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString;
        SqlConnection con = new SqlConnection(koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();
        private const int ItemsPerRequest = 10;

        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public DataTable GetDataTable()
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT inv00h24.area_code, inv00h24.area_name " +
                                "FROM inv00h24 " +
                                " WHERE inv00h24.stEdit !=4";
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

        protected void RadGrid1_ItemCreated(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
            if (e.Item is GridEditableItem & e.Item.IsInEditMode)
            {
                GridEditFormItem item = (GridEditFormItem)e.Item;
                RadTextBox txt = (item.FindControl("txt_code_area") as RadTextBox);
                if (e.Item.OwnerTableView.IsItemInserted)
                    txt.Enabled = true;
                else
                    txt.Enabled = false;
            }
        }

        protected void RadGrid1_DeleteCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            var productId = ((GridDataItem)e.Item).GetDataKeyValue("area_code");

            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "Update inv00h24 SET stEdit = 4 where area_code = @area_code";
            cmd.Parameters.AddWithValue("@area_code", productId);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void RadGrid1_UpdateCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.Item is GridEditFormItem)
            {
                GridEditFormItem item = (GridEditFormItem)e.Item;
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "UPDATE inv00h24 SET area_name = @area_name, lastupdate = getdate(), userid = @userid, stEdit = @stEdit " +
                                    "WHERE area_code = @area_code";
                cmd.Parameters.AddWithValue("@area_code", (item.FindControl("txt_code_area") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@area_name", (item.FindControl("txt_name_area") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@userid", public_str.user_id);
                cmd.Parameters.AddWithValue("stEdit", "0");
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }

        protected void RadGrid1_InsertCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            GridEditableItem item = (GridEditableItem)e.Item;
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "INSERT INTO inv00h24 (area_code, area_name, lastupdate, userid, stEdit) " +
                                "VALUES (@area_code, @area_name, getdate(), @userid, @stEdit)";
            cmd.Parameters.AddWithValue("@area_code", (item.FindControl("txt_code_area") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@area_name", (item.FindControl("txt_name_area") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@userid", public_str.user_id);
            cmd.Parameters.AddWithValue("@stEdit", "0");
            cmd.ExecuteNonQuery();
            con.Close();
        }
    }
}