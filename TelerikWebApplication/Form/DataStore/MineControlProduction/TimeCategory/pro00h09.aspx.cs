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

namespace TelerikWebApplication.Form.DataStore.MineControlProduction.TimeCategory
{
    public partial class pro00h09 : System.Web.UI.Page
    {
        public static string koneksi = ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString;
        SqlConnection con = new SqlConnection(koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();
        private const int ItemsPerRequest = 10;
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void RadGrid1_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            (sender as RadGrid).DataSource = GetDataTable();
        }

        public DataTable GetDataTable()
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select pro00h09.time_code, pro00h09.time_name, Case cat_code When '01' Then 'Working' When '02' Then 'Standby' When '03' Then 'Breakdown' else 'Idle/Delay' End " +
                " as cat_code, pro00h09.remark from pro00h09 where pro00h09.stedit != 4";
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
        protected void RadGrid1_InsertCommand(object sender, GridCommandEventArgs e)
        {
            GridEditableItem item = (GridEditableItem)e.Item;
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "INSERT INTO pro00h09(time_code,time_name,cat_code,remark,Stamp,Usr,Owner,stEdit) VALUES (@time_code, @time_name,@cat_code,@remark, getdate(),@Usr, @Owner,0)";
            cmd.Parameters.AddWithValue("@time_code", (item.FindControl("txt_time_code") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@time_name", (item.FindControl("txt_time_name") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@cat_code", (item.FindControl("cb_type") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@remark", (item.FindControl("txt_remark") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
            cmd.Parameters.AddWithValue("@Owner", public_str.user_id);
            cmd.Parameters.AddWithValue("@status", "0");
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void RadGrid1_UpdateCommand(object sender, GridCommandEventArgs e)
        {
            if (e.Item is GridEditFormItem)
            {
                GridEditFormItem item = (GridEditFormItem)e.Item;
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "UPDATE pro00h09 set time_name = @time_name, cat_code = @cat_code, remark = @remark, LastUpdate = getdate(), Usr = @Usr where time_code = @time_code";
                cmd.Parameters.AddWithValue("@time_name", (item.FindControl("txt_time_name") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@time_code", (item.FindControl("txt_time_code") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@cat_code", (item.FindControl("cb_type") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@remark", (item.FindControl("txt_remark") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }

        protected void RadGrid1_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            var productId = ((GridDataItem)e.Item).GetDataKeyValue("time_code");

            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "update pro00h09 set stEdit = 4, LastUpdate = getdate(), Usr = @Usr where time_code = @time_code";
            cmd.Parameters.AddWithValue("@time_code", productId);
            cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void RadGrid1_ItemCreated(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridEditableItem & e.Item.IsInEditMode)
            {
                GridEditFormItem item = (GridEditFormItem)e.Item;
                RadTextBox txt = (item.FindControl("txt_time_code") as RadTextBox);
                if (e.Item.OwnerTableView.IsItemInserted)
                    txt.Enabled = true;
                else
                    txt.Enabled = false;
            }
        }

        protected void cb_type_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Clear();
            (sender as RadComboBox).Items.Add("Working");
            (sender as RadComboBox).Items.Add("Standby");
            (sender as RadComboBox).Items.Add("Breakdown");
            (sender as RadComboBox).Items.Add("Idle/Delay");
        }

        protected void cb_type_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if ((sender as RadComboBox).Text == "Working")
            {
                (sender as RadComboBox).SelectedValue = "01";

            }
            else if ((sender as RadComboBox).Text == "Standby")
            {
                (sender as RadComboBox).SelectedValue = "02";
            }
            else if ((sender as RadComboBox).Text == "Breakdown")
            {
                (sender as RadComboBox).SelectedValue = "03";
            }
            else
            {
                (sender as RadComboBox).SelectedValue = "04";
            }
        }

        protected void cb_type_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadComboBox).Text == "Working")
            {
                (sender as RadComboBox).SelectedValue = "01";

            }
            else if ((sender as RadComboBox).Text == "Standby")
            {
                (sender as RadComboBox).SelectedValue = "02";
            }
            else if ((sender as RadComboBox).Text == "Breakdown")
            {
                (sender as RadComboBox).SelectedValue = "03";
            }
            else
            {
                (sender as RadComboBox).SelectedValue = "04";
            }
        }

        protected void btn_new_Click(object sender, EventArgs e)
        {
            RadGrid1.MasterTableView.IsItemInserted = true;
            RadGrid1.MasterTableView.Rebind();
        }
    }
}