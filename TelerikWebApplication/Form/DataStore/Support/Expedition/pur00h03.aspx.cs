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

namespace TelerikWebApplication.Form.DataStore.Support.Expedition
{
    public partial class pur00h03 : System.Web.UI.Page
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
            cmd.CommandText = "SELECT pur00h03.EXP_CODE, pur00h03.EXP_NAME, pur00h03.LVL, pur00h03.ADDR, pur00h03.TLP, pur00h03.FAX, pur00h03.EMAIL, " +
                              "pur00h03.WEBSITE, pur00h03.CONT1, pur00h03.HP1, pur00h03.EMAIL1, pur00h03.CONT2, pur00h03.HP2, pur00h03.EMAIL2, " +
                              "pur00h03.lastupdate, pur00h03.userid, pur00h03.stEdit, inv00h25.city_code, inv00h25.city_name FROM pur00h03 INNER JOIN " +
                              "inv00h25 ON pur00h03.city_code = inv00h25.city_code WHERE pur00h03.stEdit != '4'";
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

        protected void RadGrid1_InsertCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {

        }

        protected void RadGrid1_UpdateCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {

        }

        protected void RadGrid1_DeleteCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {

        }

        protected void RadGrid1_ItemCreated(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {

        }

        private static DataTable Getcity_code(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT city_code, city_name FROM inv00h25 WHERE stEdit !='4' AND prov_name like @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);
            DataTable data = new DataTable();
            adapter.Fill(data);
            return data;

        }
        protected void cb_city_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {

        }

        protected void cb_city_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

        protected void cb_city_PreRender(object sender, EventArgs e)
        {

        }
    }
}