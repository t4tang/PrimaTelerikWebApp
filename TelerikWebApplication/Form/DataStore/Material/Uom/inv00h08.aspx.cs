using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data;
using System.Data.SqlClient;
using TelerikWebApplication.Class;

namespace TelerikWebApplication.Form.DataStore.Material.Uom
{
    public partial class inv00h08 : System.Web.UI.Page
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
            cmd.CommandText = "SELECT ms_uom.unit_code, ms_uom.unit_name " +
                                "FROM ms_uom WHERE ms_uom.stEdit !=4";
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

        protected void RadGrid1_EditCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName == RadGrid.UpdateCommandName)
            {
                if (e.Item is GridEditFormItem)
                {
                    GridEditFormItem item = (GridEditFormItem)e.Item;
                    con.Open();
                    cmd = new SqlCommand();
                    cmd.CommandType = CommandType.Text;
                    cmd.Connection = con;
                    cmd.CommandText = "UPDATE ms_uom SET unit_name = @unit_name WHERE unit_code = @unit_code";
                    cmd.Parameters.AddWithValue("@unit_code", (item.FindControl("txt_unit_code") as RadTextBox).Text);
                    cmd.Parameters.AddWithValue("@unit_name", (item.FindControl("txt_unit_name") as RadTextBox).Text);
                    //cmd.Parameters.AddWithValue("@lastupdate", (item.FindControl("lastupdate") as RadDateTimePicker).SelectedDate);
                    //cmd.Parameters.AddWithValue("@userid", (item.FindControl("txt_userid") as RadTextBox).Text);
                    cmd.ExecuteNonQuery();
                    con.Close();
                }

            }
        }

        protected void RadGrid1_InsertCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            GridEditableItem item = (GridEditableItem)e.Item;
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "INSERT INTO ms_uom VALUES (@unit_code,@unit_name)";
            cmd.Parameters.AddWithValue("@unit_code", (item.FindControl("txt_unit_code") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@unit_name", (item.FindControl("txt_unit_name") as RadTextBox).Text);
            //cmd.Parameters.AddWithValue("@lastupdate", (item.FindControl("lastupdate") as RadDateTimePicker).SelectedDate);
            //cmd.Parameters.AddWithValue("@userid", (item.FindControl("txt_userid") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@stEdit", "0");
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void RadGrid1_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            var productId = ((GridDataItem)e.Item).GetDataKeyValue("unit_code");

            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "Update ms_uom SET stEdit = 4 where unit_code = @unit_code";
            cmd.Parameters.AddWithValue("@unit_code", productId);
            cmd.ExecuteNonQuery();
            con.Close();

        }

        protected void btn_new_Click(object sender, EventArgs e)
        {
            RadGrid1.MasterTableView.IsItemInserted = true;
            RadGrid1.MasterTableView.Rebind();
        }
    }
}