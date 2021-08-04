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
    public partial class acc01h15 : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();
        string currentYear = DateTime.Now.Year.ToString();
        private const int ItemsPerRequest = 10;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //cb_year_prm.Text = currentYear;
                cb_year.Text = currentYear;
            }
        }

        protected void RadPivotGrid1_NeedDataSource(object sender, Telerik.Web.UI.PivotGridNeedDataSourceEventArgs e)
        {
            (sender as RadPivotGrid).DataSource = GetDataTable(currentYear);
        }
        public DataTable GetDataTable(string year)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_budget";
            cmd.Parameters.AddWithValue("@year", year);
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

        protected void cb_year_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            int year = Int32.Parse(currentYear);         
            for (int i = 2018; i <= year; i++)
            {
                (sender as RadComboBox).Items.Add(i.ToString());
            }
            
        }

        protected void cb_year_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            (sender as RadComboBox).SelectedValue = (sender as RadComboBox).Text;
            RadPivotGrid1.DataSource = GetDataTable((sender as RadComboBox).SelectedValue);
            RadPivotGrid1.DataBind();
        }

        protected void cb_year_PreRender(object sender, EventArgs e)
        {
            (sender as RadComboBox).SelectedValue = (sender as RadComboBox).Text;
        }

        //protected void cb_month_prm_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        //{
        //    SqlDataAdapter adapter = new SqlDataAdapter("dbo.sp_get_month",
        //    ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
        //    adapter.SelectCommand.CommandType = CommandType.StoredProcedure;

        //    DataTable data = new DataTable();
        //    adapter.Fill(data);

        //    int itemOffset = e.NumberOfItems;
        //    int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
        //    e.EndOfItems = endOffset == data.Rows.Count;

        //    for (int i = itemOffset; i < endOffset; i++)
        //    {
        //        (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["Bulan"].ToString(), data.Rows[i]["Bulan"].ToString()));
        //    }
        //}
        //protected void cb_month_prm_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        //{
        //    if ((sender as RadComboBox).Text == "January")
        //    {
        //        (sender as RadComboBox).SelectedValue = "1";
        //    }
        //    else if ((sender as RadComboBox).Text == "February")
        //    {
        //        (sender as RadComboBox).SelectedValue = "2";
        //    }
        //    else if ((sender as RadComboBox).Text == "March")
        //    {
        //        (sender as RadComboBox).SelectedValue = "3";
        //    }
        //    else if ((sender as RadComboBox).Text == "April")
        //    {
        //        (sender as RadComboBox).SelectedValue = "4";
        //    }
        //    else if ((sender as RadComboBox).Text == "May")
        //    {
        //        (sender as RadComboBox).SelectedValue = "5";
        //    }
        //    else if ((sender as RadComboBox).Text == "June")
        //    {
        //        (sender as RadComboBox).SelectedValue = "6";
        //    }
        //    else if ((sender as RadComboBox).Text == "July")
        //    {
        //        (sender as RadComboBox).SelectedValue = "7";
        //    }
        //    else if ((sender as RadComboBox).Text == "August")
        //    {
        //        (sender as RadComboBox).SelectedValue = "8";
        //    }
        //    else if ((sender as RadComboBox).Text == "September")
        //    {
        //        (sender as RadComboBox).SelectedValue = "9";
        //    }
        //    else if ((sender as RadComboBox).Text == "October")
        //    {
        //        (sender as RadComboBox).SelectedValue = "10";
        //    }
        //    else if ((sender as RadComboBox).Text == "November")
        //    {
        //        (sender as RadComboBox).SelectedValue = "11";
        //    }
        //    else if ((sender as RadComboBox).Text == "December")
        //    {
        //        (sender as RadComboBox).SelectedValue = "12";
        //    }
        //}
        //protected void cb_project_prm_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        //{
        //    con.Open();
        //    SqlCommand cmd = new SqlCommand();
        //    cmd.Connection = con;
        //    cmd.CommandType = CommandType.Text;
        //    cmd.CommandText = "SELECT region_code FROM ms_jobsite WHERE region_name = '" + (sender as RadComboBox).Text + "'";
        //    SqlDataReader dr;
        //    dr = cmd.ExecuteReader();
        //    while (dr.Read())
        //        (sender as RadComboBox).SelectedValue = dr[0].ToString();
        //    dr.Close();
        //    con.Close();
        //}
        //protected void cb_project_prm_PreRender(object sender, EventArgs e)
        //{
        //    con.Open();
        //    SqlCommand cmd = new SqlCommand();
        //    cmd.Connection = con;
        //    cmd.CommandType = CommandType.Text;
        //    cmd.CommandText = "SELECT region_code FROM ms_jobsite WHERE region_name = '" + (sender as RadComboBox).Text + "'";
        //    SqlDataReader dr;
        //    dr = cmd.ExecuteReader();
        //    while (dr.Read())
        //        (sender as RadComboBox).SelectedValue = dr[0].ToString();
        //    dr.Close();
        //    con.Close();
        //}

        //protected void cb_project_prm_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        //{
        //    DataTable data = GetProjectPrm(e.Text);

        //    int itemOffset = e.NumberOfItems;
        //    int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
        //    e.EndOfItems = endOffset == data.Rows.Count;

        //    for (int i = itemOffset; i < endOffset; i++)
        //    {
        //        (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["region_name"].ToString(), data.Rows[i]["region_name"].ToString()));
        //    }
        //}
        //private static DataTable GetProjectPrm(string text)
        //{
        //    SqlDataAdapter adapter = new SqlDataAdapter("SELECT region_code, region_name FROM ms_jobsite WHERE stEdit != 4 AND region_name LIKE @text + '%' UNION SELECT 'ALL','ALL'",
        //    ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
        //    adapter.SelectCommand.Parameters.AddWithValue("@text", text);

        //    DataTable data = new DataTable();
        //    adapter.Fill(data);

        //    return data;
        //}

    }
}