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

namespace TelerikWebApplication.Form.DataStore.MineControlProduction.Location
{
    public partial class pro00h03 : System.Web.UI.Page
    {
        public static string koneksi = ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString;
        SqlConnection con = new SqlConnection(koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();
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
            cmd.CommandText = "SELECT pro00h03.Loc_code, pro00h03.loc_name, pro00h03.remark, pro00h03.Stamp, pro00h03.Usr, pro00h03.Owner, " +
                              "pro00h03.stEdit, pro00h04.loc_cate_code, inv00h09.region_code, pro00h04.cat_name, inv00h09.region_name " +
                              "FROM pro00h03 INNER JOIN pro00h04 ON pro00h03.loc_cate_code = pro00h04.loc_cate_code INNER JOIN " +
                              "inv00h09 ON pro00h03.region_code = inv00h09.region_code WHERE pro00h03.stEdit != '4'";
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

        protected void RadGrid1_InsertCommand(object sender, GridCommandEventArgs e)
        {

        }

        protected void RadGrid1_UpdateCommand(object sender, GridCommandEventArgs e)
        {

        }

        protected void RadGrid1_DeleteCommand(object sender, GridCommandEventArgs e)
        {

        }

        protected void RadGrid1_ItemCreated(object sender, GridItemEventArgs e)
        {

        }

        protected void cb_category_PreRender(object sender, EventArgs e)
        {

        }

        protected void cb_category_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {

        }

        protected void cb_category_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

        protected void cb_area_PreRender(object sender, EventArgs e)
        {

        }

        protected void cb_area_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {

        }

        protected void cb_area_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }
    }
}