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

namespace TelerikWebApplication.Form.Inventory.StockCard
{
    public partial class stockCard : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();
        private const int ItemsPerRequest = 10;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lbl_form_name.Text = "Stock Card";
                dtp_from.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
                dtp_to.SelectedDate = DateTime.Now;
                RadGrid1.DataSource = new string[] { };
            }
        }

        protected void RadGrid1_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            RadGrid1.DataSource = GetDataTable(dtp_from.SelectedDate.Value, dtp_to.SelectedDate.Value, cb_prd_code.SelectedValue, cb_warehouse.SelectedValue);
        }
        protected void RadAjaxManager1_AjaxRequest(object sender, Telerik.Web.UI.AjaxRequestEventArgs e)
        {
            //try
            //{
            if (e.Argument == "Rebind")
            {
                RadGrid1.MasterTableView.SortExpressions.Clear();
                RadGrid1.MasterTableView.GroupByExpressions.Clear();
                RadGrid1.Rebind();
                RadGrid1.MasterTableView.Items[0].Selected = true;

            }
            else if (e.Argument == "RebindAndNavigate")
            {
                RadGrid1.MasterTableView.SortExpressions.Clear();
                RadGrid1.MasterTableView.GroupByExpressions.Clear();
                RadGrid1.DataSource = GetDataTable(dtp_from.SelectedDate.Value, dtp_to.SelectedDate.Value, cb_prd_code.SelectedValue, cb_warehouse.SelectedValue);
                RadGrid1.DataBind();
                RadGrid1.MasterTableView.CurrentPageIndex = (sender as RadGrid).MasterTableView.PageCount - 1;

                RadGrid1.MasterTableView.Items[(sender as RadGrid).Items.Count - 1].Selected = true;
                Session["action"] = "list";
            }
            //}
            //catch (Exception ex)
            //{
            //    RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
            //}
        }
        public DataTable GetDataTable(DateTime fromDate, DateTime toDate, string prod_code, string warehouse)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "spr_stock_card";
            cmd.Parameters.AddWithValue("@date", fromDate);
            cmd.Parameters.AddWithValue("@to_date", toDate);
            cmd.Parameters.AddWithValue("@prod_code", prod_code);
            cmd.Parameters.AddWithValue("@warehouse", warehouse);
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
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            RadGrid1.DataSource = GetDataTable(dtp_from.SelectedDate.Value,  dtp_to.SelectedDate.Value, cb_prd_code.SelectedValue, cb_warehouse.SelectedValue);
            RadGrid1.DataBind();
        }
        #region Material
        protected void GetProductPrm(string text, RadComboBox cb)
        {
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            DataTable dt = new DataTable();
                        
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT top(50)	prod_code, spec, unit FROM ms_product WHERE(stEdit <> '4') AND(stMain <> '4') AND " +
                "(prod_code LIKE @text + '%' OR spec LIKE @text + '%')", con);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);
            //DataTable dt = new DataTable();
            adapter.Fill(dt);

            cb.DataTextField = "prod_code";
            cb.DataValueField = "prod_code";
            cb.DataSource = dt;
            cb.DataBind();
        }
        protected void cb_prd_code_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            GetProductPrm(e.Text, (sender as RadComboBox));
        }
        protected void cb_prd_code_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT prod_code FROM ms_product WHERE spec = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            }
            dr.Close();
            con.Close();
        }
        #endregion

        #region project param
        private static DataTable GetProjectPrm(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT region_code, region_name FROM ms_jobsite WHERE stEdit != 4 AND region_name LIKE @text + '%' UNION SELECT 'ALL','ALL'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_Project_prm_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetProjectPrm(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["region_name"].ToString(), data.Rows[i]["region_name"].ToString()));
            }
        }
        protected void cb_Project_prm_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT region_code FROM ms_jobsite WHERE region_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                //selected_project = dr[0].ToString();
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            }
            dr.Close();
            con.Close();
        }
        #endregion
        #region storage loc

        protected void GetLoc(string name, string projectID, RadComboBox cb)
        {
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);

            SqlDataAdapter adapter = new SqlDataAdapter("SELECT upper(wh_code) as code,upper(wh_name) as name FROM ms_warehouse " +
                "WHERE stEdit <> '4' AND PlantCode = @project AND wh_name LIKE @text + '%'", con);
            adapter.SelectCommand.Parameters.AddWithValue("@project", projectID);
            adapter.SelectCommand.Parameters.AddWithValue("@text", name);
            DataTable dt = new DataTable();
            adapter.Fill(dt);

            cb.DataTextField = "name";
            cb.DataValueField = "code";
            cb.DataSource = dt;
            cb.DataBind();
        }
        protected void cb_loc_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            GetLoc(e.Text, cb_proj_prm.SelectedValue, (sender as RadComboBox));
        }

        protected void cb_loc_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT wh_code FROM ms_warehouse WHERE wh_name = '" + cb_warehouse.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_warehouse.SelectedValue = dr["wh_code"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_loc_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT wh_code FROM ms_warehouse WHERE wh_name = '" + cb_warehouse.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_warehouse.SelectedValue = dr["wh_code"].ToString();
            dr.Close();
            con.Close();
        }
        #endregion

       
    }
}