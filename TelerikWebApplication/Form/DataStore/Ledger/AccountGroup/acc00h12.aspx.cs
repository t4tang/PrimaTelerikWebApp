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
    public partial class acc00h10 : System.Web.UI.Page
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
            cmd.CommandText = "SELECT     acc00h12.accountgroup, acc00h12.groupname, acc00h18.name, CASE acc00h12.balance WHEN 'D' THEN 'DEBET' ELSE 'KREDIT' END AS balance " +
                               " FROM acc00h12 INNER JOIN " +
                                " acc00h18 ON acc00h12.sub_acc_cat = acc00h18.code WHERE acc00h12.stEdit !=4";
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
            cmd.CommandText = "Update acc00h12 SET stEdit = 4 where accountgroup = @accountgroup";
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
            cmd.CommandText = "INSERT INTO acc00h12 (accountgroup,groupname,balance,sub_acc_cat,lastupdate,userid,stEdit) " +
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
            cmd.CommandText = "UPDATE acc00h12 SET groupname = @groupname, balance = @balance, sub_acc_cat = @sub_acc_cat, LastUpdate = getdate(), userid = @userid " + 
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

        private static DataTable Getacc00h18(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT code, name FROM acc00h18 where name LIKE @text + '%'",
             ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_sub_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = Getacc00h18(e.Text);

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
            cmd.CommandText = "select code from acc00h18 where name = '" + (sender as RadComboBox).Text + "'";
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
            cmd.CommandText = "select code from acc00h18 where name = '" + (sender as RadComboBox).Text + "'";
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
            cmd.CommandText = "SELECT code FROM acc00h18 WHERE name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["code"].ToString();
            dr.Close();
            con.Close();
        }
    }
}