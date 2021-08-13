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

namespace TelerikWebApplication.Form.DataStore.PreventiveMaintenance.JobType
{
    public partial class mtc00h22 : System.Web.UI.Page
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
            cmd.CommandText = "SELECT PMWOActType.PMact_type, PMWOActType.PMact_name, CASE status_hist WHEN '1' THEN 'Major Repair/OVH' WHEN '2' THEN 'Replace Component' " +
                                "WHEN '3' THEN 'Fabrication Job' ELSE 'Other' End AS status_hist FROM PMWOActType WHERE PMWOActType.stEdit !=4";
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
                RadTextBox txt = (item.FindControl("txt_code") as RadTextBox);
                if (e.Item.OwnerTableView.IsItemInserted)
                    txt.Enabled = true;
                else
                    txt.Enabled = false;
            }
        }

        protected void RadGrid1_UpdateCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            GridEditFormItem item = (GridEditFormItem)e.Item;
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "UPDATE PMWOActType SET PMact_name = @PMact_name, status_hist = CASE @status_hist " +
                                " WHEN 'Major Repair/OVH' THEN '1' WHEN 'Replace Component' THEN '2' WHEN 'Fabrication Job' THEN '3' "+
                                "ELSE 'Other' END, LastUpdate = getdate(), userid = @userid WHERE PMact_type = @PMact_type";
            cmd.Parameters.AddWithValue("@PMact_type", (item.FindControl("txt_code") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@PMact_name", (item.FindControl("txt_job") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@status_hist", (item.FindControl("cb_hist") as RadComboBox).Text);
            cmd.Parameters.AddWithValue("@userid", public_str.user_id);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void RadGrid1_InsertCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            GridEditableItem item = (GridEditableItem)e.Item;
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "INSERT INTO PMWOActType(PMact_type,PMact_name,status_hist,lastupdate,userid,stEdit) " +
                                "VALUES (@PMact_type,@PMact_name, CASE @status_hist WHEN 'Major Repair/OVH' THEN '1' " +
                                "WHEN 'Replace Component' THEN '2' WHEN 'Fabrication Job' THEN '3' ELSE 'Other' END, getdate(),@userid,'0')";
            cmd.Parameters.AddWithValue("@PMact_type", (item.FindControl("txt_code") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@PMact_name", (item.FindControl("txt_job") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@status_hist", (item.FindControl("cb_hist") as RadComboBox).Text);
            cmd.Parameters.AddWithValue("@userid", public_str.user_id);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void RadGrid1_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            var productId = ((GridDataItem)e.Item).GetDataKeyValue("PMact_type");

            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "Update PMWOActType SET stEdit = 4 where PMact_type = @PMact_type";
            cmd.Parameters.AddWithValue("@PMact_type", productId);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void cb_hist_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadComboBox).Text == "Major Repair/OVH")
            {
                (sender as RadComboBox).SelectedValue = "1";
            }
            else if ((sender as RadComboBox).Text == "Replace Component")
            {
                (sender as RadComboBox).SelectedValue = "2";
            }
            else if ((sender as RadComboBox).Text == "Fabrication Job")
            {
                (sender as RadComboBox).SelectedValue = "3";
            }
            else
            {
                (sender as RadComboBox).SelectedValue = "4";
            }
        }

        protected void cb_hist_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Add("MAjor Repair/OVH");
            (sender as RadComboBox).Items.Add("Replace Component");
            (sender as RadComboBox).Items.Add("Fabrication Job");
            (sender as RadComboBox).Items.Add("Other");
        }

        protected void cb_hist_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if ((sender as RadComboBox).Text == "Major Repair/OVH")
            {
                (sender as RadComboBox).SelectedValue = "1";
            }
            else if ((sender as RadComboBox).Text == "Replace Component")
            {
                (sender as RadComboBox).SelectedValue = "2";
            }
            else if ((sender as RadComboBox).Text == "Fabrication Job")
            {
                (sender as RadComboBox).SelectedValue = "3";
            }
            else
            {
                (sender as RadComboBox).SelectedValue = "4";
            }
        }

        protected void btn_new_Click(object sender, EventArgs e)
        {
            RadGrid1.MasterTableView.IsItemInserted = true;
            RadGrid1.MasterTableView.Rebind();
        }
    }
}