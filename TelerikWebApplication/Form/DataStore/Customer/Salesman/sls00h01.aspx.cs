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

namespace TelerikWebApplication.Form.DataStore.Customer.Salesman
{
    public partial class sls00h01 : System.Web.UI.Page
    {
        public static string koneksi = ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString;
        SqlConnection con = new SqlConnection(koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();
        private const int ItemsPerRequest = 10;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void RadAjaxManager1_AjaxRequest(object sender, Telerik.Web.UI.AjaxRequestEventArgs e)
        {

        }

        public DataTable GetDataTable()
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT sls00h01.sales_code, sls00h01.sales_name, sls00h01.status, sls00h01.address, sls00h01.phone, " +
                              "sls00h01.email, sls00h01.tJual, sls00h01.lastupdate, sls00h01.userid, sls00h01.stEdit, sls00h03.sar_code, " +
                              "inv00h25.city_code, sls00h03.sar_name, inv00h25.city_name FROM sls00h01 INNER JOIN " +
                              "inv00h25 ON sls00h01.city_code = inv00h25.city_code INNER JOIN " +
                              "sls00h03 ON sls00h01.sar_code = sls00h03.sar_code " +
                              "WHERE(sls00h01.stEdit <> '4')";
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
        public DataTable GetSubArea(string Text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select sar_code, sar_name from sls00h03 where stEdit != 4 AND sar_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", Text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        public static DataTable GetCity(string Text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select city_code, city_name from inv00h25 where stEdit != 4 AND city_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", Text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void RadGrid1_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            (sender as RadGrid).DataSource = GetDataTable();
        }

        private static string GetStatusMessage(int offset, int total)
        {
            if (total <= 0)
                return "No matches";

            return String.Format("Items <b>1</b>-<b>{0}</b> out of <b>{1}</b>", offset, total);
        }
        protected void RadGrid1_InsertCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            GridEditableItem item = (GridEditableItem)e.Item;
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "INSERT INTO sls00h01 (sales_code, sales_name, sar_code, status, address, city_code, phone, email, tJual, lastupdate, userid, stEdit) " +
                              "VALUES (@sales_code, @sales_name, @sar_code, @status, @address, @city_code, @phone, @email, @tJual, getdate(), @userid, '0')";
            cmd.Parameters.AddWithValue("@sales_code", (item.FindControl("txt_code") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@sales_name", (item.FindControl("txt_salesman") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@sar_code", (item.FindControl("cb_sub_area") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@status", (item.FindControl("chk_active") as CheckBox).Checked ? 1 : 0);
            cmd.Parameters.AddWithValue("@address", (item.FindControl("txt_address") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@city_code", (item.FindControl("txt_city") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@phone", (item.FindControl("txt_phone") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@email", (item.FindControl("txt_email") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@tJual", (item.FindControl("txt_target") as RadTextBox).Text);
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
            cmd.CommandText = "UPDATE sls00h01 SET sales_name = @sales_name, sar_code = @sar_code, status = @status, address = @address, " +
                              "city_code = @city_code, phone = @phone, email = @email, tJual = @tJual, lastupdate = getdate(), userid = @userid " +
                              "WHERE sales_code = @sales_code";
            cmd.Parameters.AddWithValue("@sales_code", (item.FindControl("txt_code") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@sales_name", (item.FindControl("txt_salesman") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@sar_code", (item.FindControl("cb_sub_area") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@status", (item.FindControl("chk_active") as CheckBox).Checked ? 1 : 0);
            cmd.Parameters.AddWithValue("@address", (item.FindControl("txt_address") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@city_code", (item.FindControl("txt_city") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@phone", (item.FindControl("txt_phone") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@email", (item.FindControl("txt_email") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@tJual", (item.FindControl("txt_target") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@userid", public_str.user_id);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void RadGrid1_DeleteCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            var sales_code = ((GridDataItem)e.Item).GetDataKeyValue("sales_code");

            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "UPDATE sls00h01 SET stEdit = 4 where sales_code = @sales_code";
            cmd.Parameters.AddWithValue("@sales_code", sales_code);
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

        protected void cb_sub_area_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetSubArea(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["sar_name"].ToString(), data.Rows[i]["sar_name"].ToString()));
            }

            e.Message = GetStatusMessage(endOffset, data.Rows.Count);
        }

        protected void cb_sub_area_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT sar_code FROM sls00h03 WHERE sar_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["sar_code"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_sub_area_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT sar_code FROM sls00h03 WHERE sar_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["sar_code"].ToString();
            dr.Close();
            con.Close();
        }

        protected void txt_city_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetCity(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["city_name"].ToString(), data.Rows[i]["city_name"].ToString()));
            }

            e.Message = GetStatusMessage(endOffset, data.Rows.Count);
        }

        protected void txt_city_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT city_code FROM inv00h25 WHERE city_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["city_code"].ToString();
            dr.Close();
            con.Close();
        }

        protected void txt_city_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT city_code FROM inv00h25 WHERE city_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["city_code"].ToString();
            dr.Close();
            con.Close();
        }
    }
}