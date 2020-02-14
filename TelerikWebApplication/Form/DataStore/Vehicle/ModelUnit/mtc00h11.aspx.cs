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

namespace TelerikWebApplication.Form.DataStore.Vehicle.ModelUnit
{
    public partial class mtc00h11 : System.Web.UI.Page
    {
        public static string koneksi = ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString;
        SqlConnection con = new SqlConnection(koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();
        private const int ItemsPerRequest = 10;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void RadGrid1_DeleteCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            var productId = ((GridDataItem)e.Item).GetDataKeyValue("model_no");

            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "Update mtc00h11 SET stEdit = 4 where model_no = @model_no";
            cmd.Parameters.AddWithValue("@model_no", productId);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void RadGrid1_ItemCreated(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
            if (e.Item is GridEditableItem & e.Item.IsInEditMode)
            {
                GridEditFormItem item = (GridEditFormItem)e.Item;
                RadTextBox txt = (item.FindControl("txt_model_number") as RadTextBox);
                if (e.Item.OwnerTableView.IsItemInserted)
                    txt.Enabled = true;
                else
                    txt.Enabled = false;
            }
        }

        protected void RadGrid1_UpdateCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.Item is GridEditFormItem)
            {
                GridEditFormItem item = (GridEditFormItem)e.Item;
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "UPDATE mtc00h11 SET model_remark = @model_remark, Stamp = getdate(), Usr = @Usr, manu_code = @manu_code " +
                                    "WHERE model_no = @model_no";
                cmd.Parameters.AddWithValue("@model_no", (item.FindControl("txt_model_number") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@model_remark", (item.FindControl("txt_model_remark") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
                cmd.Parameters.AddWithValue("@manu_code", (item.FindControl("dd_manu") as RadComboBox).SelectedValue);
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }

        protected void RadGrid1_InsertCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            GridEditableItem item = (GridEditableItem)e.Item;
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "INSERT INTO mtc00h11 (model_no, manu_code, model_remark, Stamp, Usr, Owner, stEdit) " + 
                                "VALUES (@model_no, @manu_code, @model_remark, getdate(), @Usr, @Owner, @stEdit)";
            cmd.Parameters.AddWithValue("@model_no", (item.FindControl("txt_model_number") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@manu_code", (item.FindControl("dd_manu") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@model_remark", (item.FindControl("txt_model_remark") as RadTextBox).Text);
            //cmd.Parameters.AddWithValue("getdate()", public_str.user_id);
            cmd.Parameters.AddWithValue("@Usr", public_str.user_id); 
            cmd.Parameters.AddWithValue("@Owner", public_str.user_id);
            cmd.Parameters.AddWithValue("@stEdit", "0");
            cmd.ExecuteNonQuery();
            con.Close();
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
            cmd.CommandText = "SELECT     mtc00h11.model_no, mtc00h11.model_remark, inv00h13.manu_name " +
                                "FROM mtc00h11 INNER JOIN " +
                                "inv00h13 ON mtc00h11.manu_code = inv00h13.manu_code " + 
                                "WHERE mtc00h11.stEdit !=4";
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
        private static DataTable Getinv00h13(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT manu_code, manu_name FROM inv00h13 where manu_name LIKE @text + '%'",
             ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }

        protected void dd_manu_PreRender(object sender, EventArgs e)
        {

        }
        protected void dd_manu_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = Getinv00h13(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["manu_name"].ToString(), data.Rows[i]["manu_name"].ToString()));
            }
        }

        protected void dd_manu_SelectedIndexChanged1(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT manu_code FROM inv00h13 WHERE manu_name = '" + (sender as RadComboBox).SelectedValue + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["manu_code"].ToString();
            dr.Close();
            con.Close();
        }
    }
}
