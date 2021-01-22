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

namespace TelerikWebApplication.Form.DataStore.Material.Warehouse
{
    public partial class material : System.Web.UI.Page
    {
        public static string koneksi = ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString;
        SqlConnection con = new SqlConnection(koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();
        public static string prod_code;

        protected void Page_Load(object sender, EventArgs e)
        {
            prod_code = Request.QueryString["prod_code"].ToString();
        }

        public DataTable GetDataDetailTable(string wh_code)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT  ms_product_detail.prod_code, ms_product.spec, ms_product.unit, ms_product_detail.QACT, ms_product_detail.KoLok, ms_product_detail.qtyMax, " +
                              "ms_product_detail.qtyMin FROM ms_product_detail, ms_product WHERE (ms_product_detail.prod_code = ms_product.prod_code) = '" + prod_code + "'";
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
        private void populate_detail()
        {
            //if (selected_wh_code == null)
            //{
            //    RadGridGLAcc.DataSource = new string[] { };
            //}
            //else
            //{
            RadGridGLAcc.DataSource = GetDataDetailTable(prod_code);
            //}

            RadGridGLAcc.DataBind();
        }
        protected void RadGridGLAcc_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            (sender as RadGrid).DataSource = GetDataDetailTable(prod_code);
        }
    }
}