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

namespace TelerikWebApplication.Form.DataStore.Material.ServiceMaster
{
    public partial class inv00h06 : System.Web.UI.Page
    {
        public static string koneksi = ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString;
        SqlConnection con = new SqlConnection(koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();
        private const int ItemsPerRequest = 10;
        int active;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void RadAjaxManager1_AjaxRequest(object sender, Telerik.Web.UI.AjaxRequestEventArgs e)
        {

        }
        private static string GetStatusMessage(int offset, int total)
        {
            if (total <= 0)
                return "No matches";

            return String.Format("Items <b>1</b>-<b>{0}</b> out of <b>{1}</b>", offset, total);
        }
        public DataTable GetDataTable()
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT ms_product.prod_code, ms_product.spec, ms_product.koref, ms_product.NmRef, ms_product.kind_code, ms_product.unit, ms_product.tcogs, " +
                              "ms_product.tSN, ms_product.tConsig, ms_product.tActive, ms_product.AccCOGS, ms_product.AccSales, ms_product.AccReturn, ms_product.AccInventory, " +
                              "ms_product.tMonitor, ms_product.AccReturnBeli, ms_product.Cogs, ms_product.AccSalesDisc, ms_product.AccDiscBeli, ms_product.AccAssem, " +
                              "ms_product.map, ms_product_kind.kind_name FROM ms_product, ms_product_kind WHERE (ms_product.kind_code = ms_product_kind.kind_code) and((ms_product.stEdit <> '4') " +
                              "and (ms_product_kind.prod_type_code = 'SERV'))";
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
        protected void RadGrid1_DeleteCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            var prod_code = ((GridDataItem)e.Item).GetDataKeyValue("prod_code");

            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "UPDATE ms_product SET stEdit = 4 where prod_code = @prod_code";
            cmd.Parameters.AddWithValue("@prod_code", prod_code);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void RadGrid1_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            (sender as RadGrid).DataSource = GetDataTable();
        }

        protected void RadGrid1_UpdateCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            GridEditableItem item = (GridEditableItem)e.Item;
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "UPDATE ms_product set spec = @spec, koref = @koref, NmRef = @NmRef, kind_code = @kind_code, unit = @unit, tActive = @tActive, " +
                              "lastupdate = getdate(), userid = @userid where prod_code = @prod_code";
            cmd.Parameters.AddWithValue("@prod_code", (item.FindControl("txt_activity") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@spec", (item.FindControl("txt_activity_name") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@koref", (item.FindControl("txt_alias_code") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@NmRef", (item.FindControl("txt_alias_name") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@kind_code", (item.FindControl("cb_service") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@unit", (item.FindControl("cb_uom") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@tActive", (item.FindControl("cb_active") as CheckBox).Checked ? 1 : 0);
            cmd.Parameters.AddWithValue("@userid", public_str.user_id);
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
            cmd.CommandText = "INSERT INTO ms_product (prod_code, spec, koref, NmRef, kind_code, unit, tActive, lastupdate, userid, stEdit) VALUES " +
                              "(@prod_code, @spec, @koref, @NmRef, @kind_code, @unit, @tActive, getdate(), @userid, '0')";
            cmd.Parameters.AddWithValue("@prod_code", (item.FindControl("txt_activity") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@spec", (item.FindControl("txt_activity_name") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@koref", (item.FindControl("txt_alias_code") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@NmRef", (item.FindControl("txt_alias_name") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@kind_code", (item.FindControl("cb_service") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@unit", (item.FindControl("cb_uom") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@tActive", (item.FindControl("cb_active") as CheckBox).Checked ? 1 : 0);
            cmd.Parameters.AddWithValue("@userid", public_str.user_id);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        public static DataTable GetUom(string Text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select unit_name, unit_code from ms_uom where stEdit != 4 AND unit_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", Text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_uom_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT unit_code FROM ms_uom WHERE unit_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["unit_code"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_uom_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetUom(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["unit_name"].ToString(), data.Rows[i]["unit_name"].ToString()));

            }
            e.Message = GetStatusMessage(endOffset, data.Rows.Count);
        }

        protected void cb_uom_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT unit_code FROM ms_uom WHERE unit_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["unit_code"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_service_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT DISTINCT kind_code FROM ms_product_kind WHERE kind_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["kind_code"].ToString();
            dr.Close();
            con.Close();
        }
        public static DataTable GetService(string Text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select kind_name, kind_code from ms_product_kind where prod_type_code = 'SERV' AND kind_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", Text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_service_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetService(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["kind_name"].ToString(), data.Rows[i]["kind_name"].ToString()));

            }
            e.Message = GetStatusMessage(endOffset, data.Rows.Count);
        }

        protected void cb_service_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT kind_code FROM ms_product_kind WHERE kind_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["kind_code"].ToString();
            dr.Close();
            con.Close();
        }

        protected void RadGrid1_ItemCreated(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridEditableItem & e.Item.IsInEditMode)
            {
                GridEditFormItem item = (GridEditFormItem)e.Item;
                RadTextBox txt = (item.FindControl("txt_activity") as RadTextBox);
                if (e.Item.OwnerTableView.IsItemInserted)
                    txt.Enabled = true;
                else
                    txt.Enabled = false;
            }
        }

        protected void btn_new_Click(object sender, EventArgs e)
        {
            RadGrid1.MasterTableView.IsItemInserted = true;
            RadGrid1.MasterTableView.Rebind();
        }
    }
}