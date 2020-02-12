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

namespace TelerikWebApplication.Form.Master_data.Material.Category
{
    public partial class category_data_entry : System.Web.UI.UserControl
    {
        private object _dataItem = null;
        private const int ItemsPerRequest = 10;
        protected void Page_Load(object sender, EventArgs e)
        {
            cb_type_SelectedIndexChanged(cb_type, null);
            //get_category_value();

            
        }
        public object DataItem

        {
            get
            {
                return this._dataItem;
            }

            set
            {
                this._dataItem = value;
            }

        }
        private static string GetStatusMessage(int offset, int total)
        {
            if (total <= 0)
                return "No matches";

            return String.Format("Items <b>1</b>-<b>{0}</b> out of <b>{1}</b>", offset, total);
        }

        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();
        private static DataTable GetCategory(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT prod_type_code, prod_type_name FROM ms_product_type WHERE stEdit != '4' AND prod_type_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_type_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetCategory(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                cb_type.Items.Add(new RadComboBoxItem(data.Rows[i]["prod_type_name"].ToString(), data.Rows[i]["prod_type_name"].ToString()));
            }

            e.Message = GetStatusMessage(endOffset, data.Rows.Count);
        }


        protected void cb_type_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT prod_type_code from ms_product_type where prod_type_name = '" + cb_type.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_type.SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();            
        }

        protected void cb_st_main_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            // Load cb_st_main items
            cb_st_main.Items.Add("Stock and Value");
            cb_st_main.Items.Add("Only Stock");
            cb_st_main.Items.Add("Non Stock");
        }
    }
}