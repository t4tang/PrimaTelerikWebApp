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

namespace TelerikWebApplication.Form.DataStore.Ledger.AccountGroup
{
    public partial class acc00h12 : System.Web.UI.Page
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
            cmd.CommandText = "SELECT     gl_account_group.accountgroup, gl_account_group.groupname, gl_neraca_saldoh.name, CASE gl_account_group.balance WHEN 'D' THEN 'DEBET' ELSE 'KREDIT' END AS balance " +
                               " FROM gl_account_group INNER JOIN " +
                                " gl_neraca_saldoh ON gl_account_group.sub_acc_cat = gl_neraca_saldoh.code WHERE gl_account_group.stEdit !=4";
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

        protected void RadGrid1_DeleteCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            var productId = ((GridDataItem)e.Item).GetDataKeyValue("accountgroup");

            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "Update gl_account_group SET stEdit = 4 where accountgroup = @accountgroup";
            cmd.Parameters.AddWithValue("@accountgroup", productId);
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
            cmd.CommandText = "INSERT INTO gl_account_group (accountgroup,groupname,balance,sub_acc_cat,lastupdate,userid,stEdit) " +
                                "VALUES (@accountgroup,@groupname,  @balance, @sub_acc_cat, getdate(),@userid,'0')";
            cmd.Parameters.AddWithValue("@accountgroup", (item.FindControl("txt_account") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@groupname", (item.FindControl("txt_gp_name") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@balance", (item.FindControl("cb_balance") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@sub_acc_cat", (item.FindControl("cb_sub") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@userid", public_str.user_id);
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
            cmd.CommandText = "UPDATE gl_account_group SET groupname = @groupname, balance = @balance, sub_acc_cat = @sub_acc_cat, LastUpdate = getdate(), userid = @userid " + 
                                "WHERE accountgroup = @accountgroup";
            cmd.Parameters.AddWithValue("@accountgroup", (item.FindControl("txt_account") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@groupname", (item.FindControl("txt_gp_name") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@balance", (item.FindControl("cb_balance") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@sub_acc_cat", (item.FindControl("cb_sub") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@userid", public_str.user_id);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void RadGrid1_ItemCreated(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
            if (e.Item is GridEditableItem & e.Item.IsInEditMode)
            {
                GridEditFormItem item = (GridEditFormItem)e.Item;
                RadTextBox txt = (item.FindControl("txt_account") as RadTextBox);
                if (e.Item.OwnerTableView.IsItemInserted)
                    txt.Enabled = true;
                else
                    txt.Enabled = false;
            }
        }

        private static DataTable Getgl_neraca_saldoh(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT code, name FROM gl_neraca_saldoh where name LIKE @text + '%'",
             ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_sub_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = Getgl_neraca_saldoh(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["name"].ToString(), data.Rows[i]["name"].ToString()));
            }
        }

        protected void cb_sub_SelectedIndexChanged1(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select code from gl_neraca_saldoh where name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["code"].ToString();
            dr.Close();
            con.Close();

        }

        protected void cb_sub_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select code from gl_neraca_saldoh where name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["code"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_balance_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Clear();
            (sender as RadComboBox).Items.Add("Debet");
            (sender as RadComboBox).Items.Add("Kredit");
        }

        protected void cb_balance_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if ((sender as RadComboBox).Text == "Debet")
            {
                (sender as RadComboBox).SelectedValue = "D";
            }
            else
            {
                (sender as RadComboBox).SelectedValue = "K";
            }
        }

        protected void cb_balance_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadComboBox).Text == "Debet")
            {
                (sender as RadComboBox).SelectedValue = "D";
            }
            else
            {
                (sender as RadComboBox).SelectedValue = "K";
            }
        }

        protected void cb_sub_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT code FROM gl_neraca_saldoh WHERE name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["code"].ToString();
            dr.Close();
            con.Close();
        }

        protected void btn_new_Click(object sender, EventArgs e)
        {
            RadGrid1.MasterTableView.IsItemInserted = true;
            RadGrid1.MasterTableView.Rebind();
        }
    }
}