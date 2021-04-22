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

namespace TelerikWebApplication.Form.Fico.Budget
{
    public partial class acc01h18 : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();
        public static string selected_project = null;
        public static string selected_year = null;
        public static string selected_type = null;
        private const int ItemsPerRequest = 10;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                RadGrid1.DataSource = new string[] { };
                lbl_form_name.Text = "Budget Entry";
            }
        }

        protected void RadGrid1_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            (sender as RadGrid).DataSource = GetDataTable(cb_bgt_type.Text, cb_tahun.Text, selected_project);
        }
        public DataTable GetDataTable(string type, string tahun, string project)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            if(type == "RKA")
            {
                cmd.CommandText = "SELECT * FROM v_budget_entry WHERE region_code = @project AND type = @type AND tahun = @tahun";
            }
            else
            {
                cmd.CommandText = "SELECT * FROM v_budget_entry WHERE region_code = @project AND tahun = @tahun";
            }
            cmd.Parameters.AddWithValue("@type", type);
            cmd.Parameters.AddWithValue("@tahun", tahun);
            cmd.Parameters.AddWithValue("@project", project);
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
        protected void RadGrid1_ItemCreated(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
           
        }

        #region parameter

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            RadGrid1.DataSource = GetDataTable(selected_type, selected_year, selected_project);
            RadGrid1.DataBind();
        }
        protected void btn_ok_Click(object sender, EventArgs e)
        {            
            RadGrid1.DataSource = GetDataTable(selected_type, selected_year, selected_project);
            RadGrid1.DataBind();
            if(RadGrid1.MasterTableView.Items.Count == 0)
            {
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_add_budget";
                cmd.Parameters.AddWithValue("@Tahun", selected_year);
                cmd.Parameters.AddWithValue("@region_code", selected_project);
                cmd.Parameters.AddWithValue("@type", selected_type);
                cmd.ExecuteNonQuery();
                con.Close();

                RadGrid1.DataSource = GetDataTable(selected_type, selected_year, selected_project);
                RadGrid1.DataBind();
            }
        }

        protected void cb_bgt_type_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Add("Project");
            (sender as RadComboBox).Items.Add("RKA");
        }
        protected void cb_bgt_type_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            selected_type = (sender as RadComboBox).Text;
        }
        private static DataTable GetYearBgtPrm(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT DISTINCT Tahun AS Tahun FROM acc01h18",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_tahun_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetYearBgtPrm((sender as RadComboBox).Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["Tahun"].ToString(), data.Rows[i]["Tahun"].ToString()));
            }
        }
        protected void cb_tahun_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            selected_year = (sender as RadComboBox).Text;
        }
        private static DataTable GetProjectPrm(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT region_code, region_name FROM inv00h09 WHERE stEdit != 4 AND region_name LIKE @text + '%' UNION SELECT 'ALL','ALL'",
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
            cmd.CommandText = "SELECT region_code FROM inv00h09 WHERE region_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                selected_project = dr[0].ToString();
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            }
            dr.Close();
            con.Close();
        }
        #endregion

        protected void RadAjaxManager1_AjaxRequest(object sender, AjaxRequestEventArgs e)
        {

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridEditableItem item = (GridEditableItem)btn.NamingContainer;

            RadLabel lbl_account = (RadLabel)item.FindControl("lbl_account");
            RadNumericTextBox txt_jan = (RadNumericTextBox)item.FindControl("txt_jan");
            RadNumericTextBox txt_feb = (RadNumericTextBox)item.FindControl("txt_feb");
            RadNumericTextBox txt_mar = (RadNumericTextBox)item.FindControl("txt_mar");
            RadNumericTextBox txt_apr = (RadNumericTextBox)item.FindControl("txt_apr");
            RadNumericTextBox txt_may = (RadNumericTextBox)item.FindControl("txt_may");
            RadNumericTextBox txt_jun = (RadNumericTextBox)item.FindControl("txt_jun");
            RadNumericTextBox txt_jul = (RadNumericTextBox)item.FindControl("txt_jul");
            RadNumericTextBox txt_aug = (RadNumericTextBox)item.FindControl("txt_aug");
            RadNumericTextBox txt_sep = (RadNumericTextBox)item.FindControl("txt_sep");
            RadNumericTextBox txt_oct = (RadNumericTextBox)item.FindControl("txt_oct");
            RadNumericTextBox txt_nov = (RadNumericTextBox)item.FindControl("txt_nov");
            RadNumericTextBox txt_dec = (RadNumericTextBox)item.FindControl("txt_dec");

            Button btnCancel = (Button)item.FindControl("btnCancel");

            try
            {
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "UPDATE acc01h18 SET plan01 = @plan01, plan02 = @plan02, plan03 = @plan03, plan04 = @plan04, plan05 = @plan05, plan06 = @plan06, plan07 = @plan07, plan08 = @plan08, " +
                "plan09 = @plan09, plan10 = @plan10, plan11 = @plan11, plan12 = @plan12 WHERE(Tahun = @Tahun) AND(Kd_Bget = @Kd_Bget) AND(region_code = @region_code) AND(type = @type)";
                cmd.Parameters.AddWithValue("@Tahun", selected_year);
                cmd.Parameters.AddWithValue("@Kd_Bget", lbl_account.Text);
                cmd.Parameters.AddWithValue("@region_code", selected_project);
                cmd.Parameters.AddWithValue("@type", selected_type);
                cmd.Parameters.AddWithValue("@plan01", txt_jan.Text);
                cmd.Parameters.AddWithValue("@plan02", txt_feb.Text);
                cmd.Parameters.AddWithValue("@plan03", txt_mar.Text);
                cmd.Parameters.AddWithValue("@plan04", txt_apr.Text);
                cmd.Parameters.AddWithValue("@plan05", txt_may.Text);
                cmd.Parameters.AddWithValue("@plan06", txt_jun.Text);
                cmd.Parameters.AddWithValue("@plan07", txt_jul.Text);
                cmd.Parameters.AddWithValue("@plan08", txt_aug.Text);
                cmd.Parameters.AddWithValue("@plan09", txt_sep.Text);
                cmd.Parameters.AddWithValue("@plan10", txt_oct.Text);
                cmd.Parameters.AddWithValue("@plan11", txt_nov.Text);
                cmd.Parameters.AddWithValue("@plan12", txt_dec.Text);
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                con.Close();
                Response.Write("<font color='red'>" + ex.Message + "</font>");
            }
            finally
            {
                con.Close();
                notif.Text = "Data telah disimpan";
                notif.Show();

                if ((sender as Button).Text == "Update")
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind();", true);
                }
                else
                {                   
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind('navigateToInserted');", true);
                    (sender as Button).Text = "Update";
                    btnCancel.Text = "Close";
                }

                RadGrid1.MasterTableView.IsItemInserted = false;
            }
        }

    }
}