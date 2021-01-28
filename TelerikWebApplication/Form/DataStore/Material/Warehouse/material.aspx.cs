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
        public static string wh_code;

        protected void Page_Load(object sender, EventArgs e)
        {
            wh_code = Request.QueryString["wh_code"].ToString();
        }
        public DataTable GetDataDetailTable(string wh_code)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT inv00d01.wh_code, inv00d01.prod_code, inv00h01.spec, inv00h01.unit, inv00d01.QACT, inv00d01.KoLok, " +
                              "inv00d01.qtyMax, inv00d01.qtyMin FROM inv00d01 INNER JOIN inv00h01 ON inv00d01.prod_code = inv00h01.prod_code " +
                              "Where inv00d01.wh_code = '" + wh_code + "'";
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
            RadGridMaterial.DataSource = GetDataDetailTable(wh_code);
            //}

            RadGridMaterial.DataBind();
        }

        protected void RadGridMaterial_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            (sender as RadGrid).DataSource = GetDataDetailTable(wh_code);
        }
    }
}