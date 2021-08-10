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

namespace TelerikWebApplication.Form.DataStore.Support.Tax
{
    public partial class acc00h05 : System.Web.UI.Page
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
            cmd.CommandText = "select acc00h05.TAX_CODE, acc00h05.TAX_NAME, acc00h05.TAX_PERC, "+
                " (select accountno +' '+ accountname from gl_account where gl_account.accountno = acc00h05.REK_LEDG) as REK_LEDGname, " +
                " (select accountno +' '+ accountname from gl_account where gl_account.accountno = acc00h05.REK_OUT) as REK_OUTname, acc00h05.tPPH " + 
                " from acc00h05 INNER JOIN gl_account ON acc00h05.REK_LEDG = gl_account.accountno " +
               " where acc00h05.stedit != 4";

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

        private static DataTable Getgl_account(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("accountno, accountno + ' ' + accountname as accountname from gl_account where accountno like @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;

        }
        protected void RadGrid1_InsertCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            GridEditableItem item = (GridEditableItem)e.Item;
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "INSERT INTO acc00h05(TAX_CODE, tPPH, TAX_NAME, TAX_PERC, REK_LEDG, REK_OUT, Stamp,Usr,Owner,stEdit) VALUES (@TAX_CODE,@tPPH, @TAX_NAME, @TAX_PERC, @REK_LEDG, @REK_OUT, getdate(),@Usr, @Owner,0)";
            cmd.Parameters.AddWithValue("@TAX_CODE", (item.FindControl("txt_TAX_CODE") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@tPPH", (item.FindControl("chk_PPH") as CheckBox).Checked ? 1 : 0);
            cmd.Parameters.AddWithValue("@TAX_NAME", (item.FindControl("txt_TAX_NAME") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@TAX_PERC", (item.FindControl("txt_TAX_PERC") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@REK_LEDG", (item.FindControl("cb_prepaid") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@REK_OUT", (item.FindControl("cb_payable") as RadComboBox).SelectedValue);
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
            cmd.CommandText = "UPDATE acc00h05 set TAX_NAME = @TAX_NAME, TAX_PERC = @TAX_PERC, REK_LEDG = @REK_LEDG, REK_OUT = @REK_OUT, tPPH= @tPPH, LastUpdate = getdate(), Usr = @Usr where TAX_CODE = @TAX_CODE";
            cmd.Parameters.AddWithValue("@TAX_NAME", (item.FindControl("txt_TAX_NAME") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@TAX_CODE", (item.FindControl("txt_TAX_CODE") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@TAX_PERC", (item.FindControl("txt_TAX_PERC") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@REK_LEDG", (item.FindControl("cb_prepaid") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@REK_OUT", (item.FindControl("cb_payable") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@tPPH", (item.FindControl("chk_PPH") as CheckBox).Checked ? 1 : 0);
            cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void RadGrid1_DeleteCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            var productId = ((GridDataItem)e.Item).GetDataKeyValue("TAX_CODE");

            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "update acc00h05 set stEdit = 4, LastUpdate = getdate(), Usr = @Usr where TAX_CODE = @TAX_CODE";
            cmd.Parameters.AddWithValue("@TAX_CODE", productId);
            cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void RadGrid1_ItemCreated(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
            if (e.Item is GridEditableItem & e.Item.IsInEditMode)
            {
                GridEditFormItem item = (GridEditFormItem)e.Item;
                RadTextBox txt = (item.FindControl("txt_TAX_CODE") as RadTextBox);
                if (e.Item.OwnerTableView.IsItemInserted)
                    txt.Enabled = true;
                else
                    txt.Enabled = false;
            }
        }

        protected void cb_prepaid_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetREK_LEDG(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["accountname"].ToString(), data.Rows[i]["accountname"].ToString()));
            }
        }

        private static DataTable GetREK_LEDG(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select accountno +' '+ accountname as accountname from gl_account where stEdit != 4 " +
                " AND accountno +' '+ accountname LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;

        }
        protected void cb_prepaid_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select accountno FROM gl_account WHERE accountno +' '+ accountname = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["accountno"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_prepaid_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select accountno FROM gl_account WHERE accountno +' '+ accountname = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["accountno"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_payable_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetREK_OUT(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["accountname"].ToString(), data.Rows[i]["accountname"].ToString()));
            }
        }

        private static DataTable GetREK_OUT(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select accountno +' '+ accountname as accountname from gl_account where stEdit != 4 " +
                " AND accountno +' '+ accountname LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;

        }
        protected void cb_payable_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select accountno FROM gl_account WHERE accountno +' '+ accountname = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["accountno"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_payable_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select accountno FROM gl_account WHERE accountno +' '+ accountname = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["accountno"].ToString();
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