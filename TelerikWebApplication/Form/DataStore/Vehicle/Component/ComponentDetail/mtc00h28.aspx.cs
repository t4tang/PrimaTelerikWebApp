using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using TelerikWebApplication.Class;

namespace TelerikWebApplication.Form.DataStore.Vehicle.Component.ComponentDetail
{
    public partial class mtc00h28 : System.Web.UI.Page
    {
        public static string koneksi = ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString;
        SqlConnection con = new SqlConnection(koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();
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
            cmd.CommandText = "SELECT com_code, com_name, lastupdate, userid, stEdit from mtc00h28 WHERE stEdit !='4'";
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

        protected void RadGrid1_InsertCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            GridEditableItem item = (GridEditableItem)e.Item;
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "INSERT INTO mtc00h28 (com_code, com_name, lastupdate, userid, stEdit) VALUES " +
                              "(@com_code, @com_name, getdate(), @userid, '0')";
            cmd.Parameters.AddWithValue("@com_code", (item.FindControl("txt_code") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@com_name", (item.FindControl("txt_component") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@userid", public_str.user_id);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void RadGrid1_UpdateCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            GridEditableItem item = (GridEditableItem)e.Item;
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "UPDATE mtc00h28 SET com_name = @com_name, lastupdate = getdate(), userid = @userid WHERE com_code = @com_code";
            cmd.Parameters.AddWithValue("@com_code", (item.FindControl("txt_code") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@com_name", (item.FindControl("txt_component") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@userid", public_str.user_id);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void RadGrid1_DeleteCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            var com_code = ((GridDataItem)e.Item).GetDataKeyValue("com_code");

            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "UPDATE mtc00h28 SET stEdit = 4 where com_code = @com_code";
            cmd.Parameters.AddWithValue("@com_code", com_code);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void RadGrid1_ItemCreated(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
            if (e.Item is GridEditableItem & e.Item.IsInEditMode)
            {
                GridEditFormItem item = (GridEditFormItem)e.Item;
                RadTextBox txt = (item.FindControl("txt_code") as RadTextBox);
                if (e.Item.OwnerTableView.IsItemInserted)
                    txt.Enabled = true;
                else
                    txt.Enabled = false;
            }
        }

        protected void RadAjaxManager1_AjaxRequest(object sender, AjaxRequestEventArgs e)
        {

        }

        protected void btn_new_Click(object sender, EventArgs e)
        {
            RadGrid1.MasterTableView.IsItemInserted = true;
            RadGrid1.MasterTableView.Rebind();
        }
    }
}