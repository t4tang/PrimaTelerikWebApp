﻿using System;
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

namespace TelerikWebApplication.Form.DataStore.Ledger.AccountNumber
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
            cmd.CommandText = "select acc00h10.accountgroup, acc00h10.accountno, acc00h10.accountname, acc00h03.cur_name, acc00h10.Budged, case acc00h12.balance when 'D' Then 'Debet' else 'Kredit' End as balance from acc00h10 INNER JOIN acc00h12 ON acc00h12.accountgroup = acc00h10.accountgroup " +
               " INNER JOIN acc00h03 ON acc00h03.cur_code = acc00h10.cur_code where acc00h10.stedit != 4";

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

        private static DataTable Getacc00h12(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select accountgroup, groupname from acc00h12 where accountgroup like @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;

        }

        private static DataTable Getacc00h03(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select cur_code, cur_name from acc00h03 where cur_code like @text + '%'",
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
            cmd.CommandText = "INSERT INTO acc00h10(accountno, accountname, Budged, accountgroup, cur_code, Stamp,Usr,Owner,stEdit) VALUES (@accountno, @accountname, @Budged, @accountgroup, @cur_code, getdate(),UPPER(@Usr),UPPER (@Owner),0)";
            cmd.Parameters.AddWithValue("@accountno", (item.FindControl("txt_accountno") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@accountname", (item.FindControl("txt_accountname") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@Budged", (item.FindControl("txt_Budged") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@accountgroup", (item.FindControl("cb_group") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@cur_code", (item.FindControl("cb_currency") as RadComboBox).SelectedValue);
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
            cmd.CommandText = "UPDATE acc00h10 set accountname = @accountname, Budged = @Budged, accountgroup = @accountgroup, cur_code = @cur_code, LastUpdate = getdate(), Usr = UPPER(@Usr) where accountno = @accountno";
            cmd.Parameters.AddWithValue("@accountname", (item.FindControl("txt_accountname") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@accountno", (item.FindControl("txt_accountno") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@Budged", Convert.ToDouble((item.FindControl("txt_Budged") as RadTextBox).Text));
            cmd.Parameters.AddWithValue("@accountgroup", (item.FindControl("cb_group") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@cur_code", (item.FindControl("cb_currency") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void RadGrid1_DeleteCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            var productId = ((GridDataItem)e.Item).GetDataKeyValue("accountno");

            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "update acc00h10 set stEdit = 4, LastUpdate = getdate(), Usr = @Usr where accountno = @accountno";
            cmd.Parameters.AddWithValue("@accountno", productId);
            cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void RadGrid1_ItemCreated(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
            if (e.Item is GridEditableItem & e.Item.IsInEditMode)
            {
                GridEditFormItem item = (GridEditFormItem)e.Item;
                RadTextBox txt_Budged = (item.FindControl("txt_Budged") as RadTextBox);
                txt_Budged.Text = "0";

                RadTextBox txt = (item.FindControl("txt_accountno") as RadTextBox);
                if (e.Item.OwnerTableView.IsItemInserted)
                    txt.Enabled = true;
                else
                    txt.Enabled = false;
            }
        }

        protected void cb_group_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = Getaccountgroup(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["accountgroup"].ToString(), data.Rows[i]["accountgroup"].ToString()));
            }
        }

        private static DataTable Getaccountgroup(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select accountgroup, groupname from acc00h12 where accountgroup like @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;

        }
        protected void cb_group_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select accountgroup from acc00h12 where accountgroup = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["accountgroup"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_group_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select accountgroup from acc00h12 where accountgroup = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["accountgroup"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_currency_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = Getaccountcurrency(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["cur_name"].ToString(), data.Rows[i]["cur_name"].ToString()));
            }
        }

        private static DataTable Getaccountcurrency(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select cur_code, cur_name from acc00h03 where cur_code like @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;

        }
        protected void cb_currency_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select cur_code from acc00h03 where cur_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["cur_code"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_currency_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select cur_code from acc00h03 where cur_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["cur_code"].ToString();
            dr.Close();
            con.Close();
        }
    }
}