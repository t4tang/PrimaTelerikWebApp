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

namespace TelerikWebApplication.Form.DataStore.PreventiveMaintenance.OrderType
{
    public partial class mtc00h23 : System.Web.UI.Page
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
            cmd.CommandText = "select PMMSOrderType.OrderType, PMMSOrderType.OrderName, PMMSOrderType.OrderName,PMMSOrderType.IsPlan, "+
                " Case PMMSOrderType.Dtype_code When 'SM' Then 'Schedule Maintenance' When 'UM' Then 'Unschedule Maintenance' else 'Accident' End as DTypename " +
                " from PMMSOrderType where PMMSOrderType.stedit != 4";

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
            cmd.CommandText = "INSERT INTO PMMSOrderType(OrderType, IsPlan, OrderName, Dtype_code, Stamp,Usr,Owner,stEdit) VALUES (@OrderType,@IsPlan, @OrderName, @Dtype_code, getdate(),@Usr, @Owner,0)";
            cmd.Parameters.AddWithValue("@OrderType", (item.FindControl("txt_OrderType") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@IsPlan", (item.FindControl("chk_Plan") as CheckBox).Checked ? 1 : 0);
            cmd.Parameters.AddWithValue("@OrderName", (item.FindControl("txt_OrderName") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@Dtype_code", (item.FindControl("cb_maint") as RadComboBox).SelectedValue);
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
            cmd.CommandText = "UPDATE PMMSOrderType set OrderName = @OrderName, Dtype_code = @Dtype_code, IsPlan= @IsPlan, LastUpdate = getdate(), Usr = @Usr where OrderType = @OrderType";
            cmd.Parameters.AddWithValue("@OrderName", (item.FindControl("txt_OrderName") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@OrderType", (item.FindControl("txt_OrderType") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@Dtype_code", (item.FindControl("cb_maint") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@IsPlan", (item.FindControl("chk_Plan") as CheckBox).Checked ? 1 : 0);
            cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void RadGrid1_DeleteCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            var productId = ((GridDataItem)e.Item).GetDataKeyValue("OrderType");

            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "update PMMSOrderType set stEdit = 4, LastUpdate = getdate(), Usr = @Usr where OrderType = @OrderType";
            cmd.Parameters.AddWithValue("@OrderType", productId);
            cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void RadGrid1_ItemCreated(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
            if (e.Item is GridEditableItem & e.Item.IsInEditMode)
            {
                GridEditFormItem item = (GridEditFormItem)e.Item;
                RadTextBox txt = (item.FindControl("txt_OrderType") as RadTextBox);
                if (e.Item.OwnerTableView.IsItemInserted)
                    txt.Enabled = true;
                else
                    txt.Enabled = false;
            }
        }

        protected void cb_maint_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Clear();
            (sender as RadComboBox).Items.Add("Schedule Maintenance");
            (sender as RadComboBox).Items.Add("Unschedule Maintenance");
            (sender as RadComboBox).Items.Add("Accident");
        }

        protected void cb_maint_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if ((sender as RadComboBox).Text == "Schedule Maintenance")
            {
                (sender as RadComboBox).SelectedValue = "01";

            }
            else if ((sender as RadComboBox).Text == "Unschedule Maintenance")
            {
                (sender as RadComboBox).SelectedValue = "02";
            }
            else
            {
                (sender as RadComboBox).SelectedValue = "03";
            }
        }

        protected void cb_maint_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadComboBox).Text == "Schedule Maintenance")
            {
                (sender as RadComboBox).SelectedValue = "01";
            }
            else if ((sender as RadComboBox).Text == "Unschedule Maintenance")
            {
                (sender as RadComboBox).SelectedValue = "02";
            }
            else
            {
                (sender as RadComboBox).SelectedValue = "03";
            }
        }

        protected void btn_new_Click(object sender, EventArgs e)
        {
            RadGrid1.MasterTableView.IsItemInserted = true;
            RadGrid1.MasterTableView.Rebind();
        }
    }
}