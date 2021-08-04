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

namespace TelerikWebApplication.Form.Fico.Asset
{
    public partial class acc00d22 : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();

        private const int ItemsPerRequest = 10;
        protected void Page_Load(object sender, EventArgs e)
        {
            cb_depre_by_prm.Text = "Monthly";
            cb_years_depre_prm.Text = (DateTime.Today.Year).ToString();
        }

        public DataTable GetDataDepre(string asset_code, string year)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_asset_depre_by_month";
            cmd.Parameters.AddWithValue("@asset_id", asset_code);
            cmd.Parameters.AddWithValue("@tahun", year);
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
        public DataTable GetDataDepreYearly(string asset_code)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_asset_depre_by_year";
            cmd.Parameters.AddWithValue("@asset_id", asset_code);
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
        protected void btn_retrive_depre_Click(object sender, EventArgs e)
        {
            if (cb_depre_by_prm.Text == "Monthly")
            {
                RadGrid2.DataSource = GetDataDepre(Request.QueryString["asset_id"], cb_years_depre_prm.Text);
            }
            else
            {
                RadGrid2.DataSource = GetDataDepreYearly(Request.QueryString["asset_id"]);

            }
            RadGrid2.DataBind();
        }

        protected void cb_depre_prm_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Add("Monthly");
            (sender as RadComboBox).Items.Add("Yearly");
        }
        protected void cb_depre_by_prm_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            GridColumn col_bulan = RadGrid2.MasterTableView.GetColumn("bulan_tahun");
            GridColumn col_status = RadGrid2.MasterTableView.GetColumn("status");

            if ((sender as RadComboBox).Text == "Monthly")
            {
                col_bulan.HeaderText = "Bulan";
                col_status.Visible = true;
                cb_years_depre_prm.Enabled = true;
            }
            else
            {
                col_bulan.HeaderText = "Year";
                col_status.Visible = false;
                cb_years_depre_prm.Enabled = false;
            }
        }
        private static DataTable GetYearDeprePrm(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT DISTINCT(Left(YearMonth,4)) AS tahun FROM tr_asset_depre WHERE asset_id = @text ",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_years_depre_prm_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetYearDeprePrm(Request.QueryString["asset_id"]);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["tahun"].ToString(), data.Rows[i]["tahun"].ToString()));
            }
        }

        protected void RadGrid2_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            (sender as RadGrid).DataSource = GetDataDepre(Request.QueryString["asset_id"], cb_years_depre_prm.Text);
            //(sender as RadGrid).DataBind();
        }
    }
}