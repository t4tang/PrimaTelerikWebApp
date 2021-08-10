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

namespace TelerikWebApplication.Form.DataStore.Controlling.POCostControl
{
    public partial class pur00h05 : System.Web.UI.Page
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
            cmd.CommandText = "select ms_po_transaction.trans_code, ms_po_transaction.TransName, " +
                " Case ms_po_transaction.tType When '1' Then 'Maint Cost' When '2' Then 'Production Cost' else 'Other Cost' End as tTypeName " +
                " from ms_po_transaction where ms_po_transaction.stedit != 4";

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
            cmd.CommandText = "INSERT INTO ms_po_transaction(trans_code, TransName, tType, Stamp,Usr,Owner,stEdit) VALUES (@trans_code, @TransName, @tType, getdate(),@Usr, @Owner,0)";
            cmd.Parameters.AddWithValue("@trans_code", (item.FindControl("txt_trans_code") as RadTextBox).Text);
           
            cmd.Parameters.AddWithValue("@TransName", (item.FindControl("txt_TransName") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@tType", (item.FindControl("cb_type") as RadComboBox).SelectedValue);
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
            cmd.CommandText = "UPDATE ms_po_transaction set TransName = @TransName, tType = @tType,  LastUpdate = getdate(), Usr = @Usr where trans_code = @trans_code";
            cmd.Parameters.AddWithValue("@TransName", (item.FindControl("txt_TransName") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@trans_code", (item.FindControl("txt_trans_code") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@tType", (item.FindControl("cb_type") as RadComboBox).SelectedValue);
           
            cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void RadGrid1_DeleteCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            var productId = ((GridDataItem)e.Item).GetDataKeyValue("trans_code");

            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "update ms_po_transaction set stEdit = 4, LastUpdate = getdate(), Usr = @Usr where trans_code = @trans_code";
            cmd.Parameters.AddWithValue("@trans_code", productId);
            cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void RadGrid1_ItemCreated(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
            if (e.Item is GridEditableItem & e.Item.IsInEditMode)
            {
                GridEditFormItem item = (GridEditFormItem)e.Item;
                RadTextBox txt = (item.FindControl("txt_trans_code") as RadTextBox);
                if (e.Item.OwnerTableView.IsItemInserted)
                    txt.Enabled = true;
                else
                    txt.Enabled = false;
            }
        }

        protected void cb_type_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Clear();
            (sender as RadComboBox).Items.Add("Maint Cost");
            (sender as RadComboBox).Items.Add("Production Cost");
            (sender as RadComboBox).Items.Add("Other Cost");
        }

        protected void cb_type_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if ((sender as RadComboBox).Text == "Maint Cost")
            {
                (sender as RadComboBox).SelectedValue = "1";

            }
            else if ((sender as RadComboBox).Text == "Production Cost")
            {
                (sender as RadComboBox).SelectedValue = "2";
            }
            else
            {
                (sender as RadComboBox).SelectedValue = "3";
            }
        }

        protected void cb_type_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadComboBox).Text == "Maint Cost")
            {
                (sender as RadComboBox).SelectedValue = "1";
            }
            else if ((sender as RadComboBox).Text == "Production Cost")
            {
                (sender as RadComboBox).SelectedValue = "2";
            }
            else
            {
                (sender as RadComboBox).SelectedValue = "3";
            }
        }

        protected void btn_new_Click(object sender, EventArgs e)
        {
            RadGrid1.MasterTableView.IsItemInserted = true;
            RadGrid1.MasterTableView.Rebind();
        }
    }
}