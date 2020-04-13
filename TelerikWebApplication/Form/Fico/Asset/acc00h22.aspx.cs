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
    public partial class acc00h22 : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();

        private const int ItemsPerRequest = 10;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {                
                cb_project_prm.SelectedValue = public_str.site;
                cb_project_prm.Text = public_str.sitename;
                                
                Session["action"] = "firstLoad";
                //btnSave.Enabled = false;
                //btnSave.ImageUrl = "~/Images/simpan-gray.png";
            }
        }

        protected void cb_status_prm_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Add("Registered");
            (sender as RadComboBox).Items.Add("Unregistered");
            (sender as RadComboBox).Items.Add("Scrap");
            (sender as RadComboBox).Items.Add("Sold");
            (sender as RadComboBox).Items.Add("Lost");
        }

        protected void cb_status_prm_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if ((sender as RadComboBox).Text == "Registered")
            {
                (sender as RadComboBox).SelectedValue = "B";
            }
            else if ((sender as RadComboBox).Text == "Unregistered")
            {
                (sender as RadComboBox).SelectedValue = "N";
            }
            else if ((sender as RadComboBox).Text == "Scrap")
            {
                (sender as RadComboBox).SelectedValue = "S";
            }
            else if ((sender as RadComboBox).Text == "Sold")
            {
                (sender as RadComboBox).SelectedValue = "L";
            }
            else if ((sender as RadComboBox).Text == "Lost")
            {
                (sender as RadComboBox).SelectedValue = "H";
            }
        }

        protected void cb_project_prm_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT region_code FROM inv00h09 WHERE region_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_project_prm_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
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
        private static DataTable GetProjectPrm(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT region_code, region_name FROM inv00h09 WHERE stEdit != 4 AND region_name LIKE @text + '%' UNION SELECT 'ALL','ALL'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);
            
            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            RadGrid1.DataSource = GetDataTable(cb_project_prm.SelectedValue, cb_status_prm.SelectedValue);
            RadGrid1.DataBind();
        }
        public DataTable GetDataTable(string project, string sts)
        {            
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            if(project != "ALL")
            {
                cmd.CommandText = "SELECT *, case mtd when 'S' then 'STRAIGHT LINE' WHEN 'D' THEN 'DOUBLE DECLINE' WHEN 'H' THEN 'HM' ELSE 'NONE' END AS Methode " +
                    "FROM acc00h22 WHERE region_code = @project AND Status = @reg_status";
            }
            else
            {
                cmd.CommandText = "SELECT *, case mtd when 'S' then 'STRAIGHT LINE' WHEN 'D' THEN 'DOUBLE DECLINE' WHEN 'H' THEN 'HM' ELSE 'NONE' END AS Methode " +
                    "FROM acc00h22 WHERE Status = @reg_status";
            }
            cmd.Parameters.AddWithValue("@project", project);
            cmd.Parameters.AddWithValue("@reg_status", sts);
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
            (sender as RadGrid).DataSource = GetDataTable(cb_project_prm.SelectedValue, cb_status_prm.SelectedValue);
        }
        protected void RadGrid1_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            var asset_code = ((GridDataItem)e.Item).GetDataKeyValue("asset_id");

            try
            {
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "UPDATE acc01h22 SET userid = @Usr, lastupdate = GETDATE(), stedit = '4' WHERE (asset_id = @asset_id)";
                cmd.Parameters.AddWithValue("@asset_id", asset_code);
                cmd.ExecuteNonQuery();
                con.Close();

                //Label lblOk = new Label();
                //lblOk.Text = "Data deleted successfully";
                //lblOk.ForeColor = System.Drawing.Color.Teal;
                //RadGrid1.Controls.Add(lblOk);
            }
            catch (Exception ex)
            {
                con.Close();
                //Label lblError = new Label();
                //lblError.Text = "Unable to delete data. Reason: " + ex.Message;
                //lblError.ForeColor = System.Drawing.Color.Red;
                //RadGrid1.Controls.Add(lblError);
                e.Canceled = true;
            }
        }
    }
    
}