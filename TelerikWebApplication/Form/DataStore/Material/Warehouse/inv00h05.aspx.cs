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

namespace TelerikWebApplication.Form.DataStore.Material.Warehouse
{
    public partial class inv00h05 : System.Web.UI.Page
    {
        public static string koneksi = ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString;
        SqlConnection con = new SqlConnection(koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();
        private const int ItemsPerRequest = 10;
        int type_out;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void RadAjaxManager1_AjaxRequest(object sender, Telerik.Web.UI.AjaxRequestEventArgs e)
        {

        }

        protected void RadGrid1_DeleteCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            var productID = ((GridDataItem)e.Item).GetDataKeyValue("wh_code");

            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "UPDATE inv00h05 SET stEdit = 4 where wh_code = @wh_code";
            cmd.Parameters.AddWithValue("@wh_code", productID);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        private static string GetStatusMessage(int offset, int total)
        {
            if (total <= 0)
                return "No matches";

            return String.Format("Items <b>1</b>-<b>{0}</b> out of <b>{1}</b>", offset, total);
        }

        protected void cb_type_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Add("General");
            (sender as RadComboBox).Items.Add("Fuel");
            (sender as RadComboBox).Items.Add("Oil");
        }

        protected void cb_type_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if ((sender as RadComboBox).Text == "General")
            {
                (sender as RadComboBox).SelectedValue = "0";
            }
            else if ((sender as RadComboBox).Text == "Fuel")
            {
                (sender as RadComboBox).SelectedValue = "1";
            }
            else
            {
                (sender as RadComboBox).SelectedValue = "2";
            }
        }

        protected void cb_type_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadComboBox).Text == "General")
            {
                (sender as RadComboBox).SelectedValue = "0";
            }
            else if ((sender as RadComboBox).Text == "Fuel")
            {
                (sender as RadComboBox).SelectedValue = "1";
            }
            else
            {
                (sender as RadComboBox).SelectedValue = "2";
            }
        }
        public static DataTable GetProject(string Text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select region_name, region_code from ms_jobsite where stEdit != 4 AND region_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", Text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_project_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT region_code FROM ms_jobsite WHERE region_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["region_code"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_project_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetProject(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["region_name"].ToString(), data.Rows[i]["region_name"].ToString()));

            }
            e.Message = GetStatusMessage(endOffset, data.Rows.Count);
        }

        protected void cb_project_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT region_code FROM ms_jobsite WHERE region_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["region_code"].ToString();
            dr.Close();
            con.Close();
        }
        public DataTable GetDataTable()
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT inv00h05.address, inv00h05.tClass, inv00h05.ref_prod_code, Case(inv00h05.type_out) when '0' then 'General' when '1' then 'Fuel' else 'Oil' End as type_out, inv00h05.FluitCap, ms_warehouse.wh_code, " +
                              "ms_jobsite.region_code, ms_warehouse.wh_name, ms_jobsite.region_name FROM inv00h05 INNER JOIN ms_warehouse ON " +
                              "inv00h05.wh_code = ms_warehouse.wh_code AND inv00h05.wh_name = ms_warehouse.wh_name INNER JOIN ms_jobsite ON " +
                              "inv00h05.PlantCode = ms_jobsite.region_code where inv00h05.stEdit != 4";
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
        protected void RadGrid1_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            (sender as RadGrid).DataSource = GetDataTable();
        }

        protected void RadGrid1_UpdateCommand(object sender, GridCommandEventArgs e)
        {

        }

        protected void RadGrid1_InsertCommand(object sender, GridCommandEventArgs e)
        {
            UserControl userControl = (UserControl)e.Item.FindControl(GridEditFormItem.EditFormUserControlID);
            GridEditableItem item = (GridEditableItem)e.Item;
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "INSERT INTO inv00h05 (@wh_code, @wh_name, @address, @accountno, @lastupdate, @userid, @stEdit, @PlantCode, @tClass, @ref_prod_code, " +
                              "@type_out, @FluitCap) VALUES(@wh_code, @wh_name, @address, @accountno, getdate(), @userid, '0', @PlantCode, CASE @StMain " +
                              "WHEN 'General' THEN '0' WHEN 'Fuel' THEN '1' ELSE '2' END, @ref_prod_code, @type_out, @FluitCap)";
            cmd.Parameters.AddWithValue("@wh_code", (item.FindControl("txt_code") as TextBox).Text);
            cmd.Parameters.AddWithValue("@wh_name", (item.FindControl("txt_storage") as TextBox).Text);
            cmd.Parameters.AddWithValue("@address", (item.FindControl("txt_address") as TextBox).Text);
            cmd.Parameters.AddWithValue("@PlantCode", (item.FindControl("cb_project") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@tClass", (item.FindControl("cb_type") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@ref_prod_code", (item.FindControl("cb_material_ref") as RadComboBox).SelectedValue);
            if ((userControl.FindControl("cb_consig") as CheckBox).Checked == true)
            {
                type_out = 1;
            }
            else
            {
                type_out = 0;
            }
            cmd.Parameters.AddWithValue("@FluitCap", (item.FindControl("txt_cap_tanki") as TextBox).Text);
            cmd.Parameters.AddWithValue("@userid", public_str.user_id);
        }
        
        protected void cb_material_ref_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT DISTINCT prod_code FROM ms_product WHERE spec = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["prod_code"].ToString();
            dr.Close();
            con.Close();
        }

        public static DataTable GetMaterial(string Text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select prod_code, spec from ms_product where stEdit != 4 AND spec LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", Text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_material_ref_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetMaterial(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["spec"].ToString(), data.Rows[i]["spec"].ToString()));
            }

            e.Message = GetStatusMessage(endOffset, data.Rows.Count);
        }

        protected void cb_material_ref_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT prod_code FROM ms_product WHERE prod_code = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["prod_code"].ToString();
            dr.Close();
            con.Close();
        }
    }
}