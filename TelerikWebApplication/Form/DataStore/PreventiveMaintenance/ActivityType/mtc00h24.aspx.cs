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

namespace TelerikWebApplication.Form.DataStore.PreventiveMaintenance.ActivityType
{
    public partial class mtc00h24 : System.Web.UI.Page
    {
        public static string koneksi = ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString;
        SqlConnection con = new SqlConnection(koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();
        private const int ItemsPerRequest = 10;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void RadGrid1_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            (sender as RadGrid).DataSource = GetDataTable();
        }

        public DataTable GetDataTable()
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select mtc00h24.Act_type, mtc00h24.Act_typeName from mtc00h24 where mtc00h24.stEdit != 4";

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
        protected void RadGrid1_InsertCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            GridEditableItem item = (GridEditableItem)e.Item;
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "INSERT INTO mtc00h24(Act_type, Act_typeName, Stamp,Usr,Owner,stEdit) VALUES (@Act_type, @Act_typeName, getdate(),@Usr, @Owner,0)";
            cmd.Parameters.AddWithValue("@Act_type", (item.FindControl("txt_Act_type") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@Act_typeName", (item.FindControl("txt_Act_typeName") as RadTextBox).Text);
            
            cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
            cmd.Parameters.AddWithValue("@Owner", public_str.user_id);
            cmd.Parameters.AddWithValue("@status", "0");
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void RadGrid1_UpdateCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            GridEditFormItem item = (GridEditFormItem)e.Item;
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "UPDATE mtc00h24 set Act_typeName = @Act_typeName, LastUpdate = getdate(), Usr = @Usr where Act_type = @Act_type";
            cmd.Parameters.AddWithValue("@Act_typeName", (item.FindControl("txt_Act_typeName") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@Act_type", (item.FindControl("txt_Act_type") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void RadGrid1_DeleteCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            var productId = ((GridDataItem)e.Item).GetDataKeyValue("Act_type");

            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "update mtc00h24 set stEdit = 4, LastUpdate = getdate(), Usr = @Usr where Act_type = @Act_type";
            cmd.Parameters.AddWithValue("@Act_type", productId);
            cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void RadGrid1_ItemCreated(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
            if (e.Item is GridEditableItem & e.Item.IsInEditMode)
            {
                GridEditFormItem item = (GridEditFormItem)e.Item;
                RadTextBox txt = (item.FindControl("txt_Act_type") as RadTextBox);
                if (e.Item.OwnerTableView.IsItemInserted)
                    txt.Enabled = true;
                else
                    txt.Enabled = false;
            }
        }
    }
}