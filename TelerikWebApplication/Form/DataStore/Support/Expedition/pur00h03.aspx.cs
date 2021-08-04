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
            cmd.CommandText = "SELECT MS_EXPEDISI.EXP_CODE, MS_EXPEDISI.EXP_NAME, MS_EXPEDISI.LVL, MS_EXPEDISI.ADDR, MS_EXPEDISI.TLP, MS_EXPEDISI.FAX, MS_EXPEDISI.EMAIL, " +
                              "MS_EXPEDISI.WEBSITE, MS_EXPEDISI.CONT1, MS_EXPEDISI.HP1, MS_EXPEDISI.EMAIL1, MS_EXPEDISI.CONT2, MS_EXPEDISI.HP2, MS_EXPEDISI.EMAIL2, " +
                              "MS_EXPEDISI.lastupdate, MS_EXPEDISI.userid, MS_EXPEDISI.stEdit, ms_city.city_code, ms_city.city_name FROM MS_EXPEDISI INNER JOIN " +
                              "ms_city ON MS_EXPEDISI.city_code = ms_city.city_code WHERE MS_EXPEDISI.stEdit != '4'";
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
            GridEditableItem item = (GridEditableItem)e.Item;
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "INSERT INTO MS_EXPEDISI (EXP_CODE, EXP_NAME, LVL, ADDR, city_code, TLP, FAX, EMAIL, WEBSITE, CONT1, HP1, EMAIL1, " +
                              "CONT2, HP2, EMAIL2, lastupdate, userid, stEdit) VALUES (@EXP_CODE, @EXP_NAME, @LVL, @ADDR, @city_code, @TLP, @FAX, " +
                              "@EMAIL, @WEBSITE, @CONT1, @HP1, @EMAIL1, @CONT2, @HP2, @EMAIL2, getdate(), @userid, '0')";
            cmd.Parameters.AddWithValue("@EXP_CODE", (item.FindControl("txt_code") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@EXP_NAME", (item.FindControl("txt_expedition") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@lvl", public_str.level);
            cmd.Parameters.AddWithValue("@ADDR", (item.FindControl("txt_address") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@city_code", (item.FindControl("cb_city") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@TLP", (item.FindControl("txt_phone") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@FAX", (item.FindControl("txt_fax") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@EMAIL", (item.FindControl("txt_email") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@WEBSITE", (item.FindControl("txt_website") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@CONT1", (item.FindControl("txt_name1") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@HP1", (item.FindControl("txt_hp1") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@EMAIL1", (item.FindControl("txt_email1") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@CONT2", (item.FindControl("txt_name2") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@HP2", (item.FindControl("txt_hp2") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@EMAIL2", (item.FindControl("txt_email2") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@userid", public_str.user_id);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void RadGrid1_UpdateCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            GridEditFormItem item = (GridEditFormItem)e.Item;
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "UPDATE MS_EXPEDISI set EXP_NAME = @EXP_NAME, LVL = @LVL, ADDR = @ADDR, city_code = @city_code, TLP = @TLP, FAX = @FAX, " +
                              "EMAIL = @EMAIL, WEBSITE = @WEBSITE, CONT1 = @CONT1, HP1 = @HP1, EMAIL1 = @EMAIL1, CONT2 = @CONT2, HP2 = @HP2, " +
                              "EMAIL2 = @EMAIL2, lastupdate = getdate(), userid = @userid WHERE EXP_CODE = @EXP_CODE";
            cmd.Parameters.AddWithValue("@EXP_CODE", (item.FindControl("txt_code") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@EXP_NAME", (item.FindControl("txt_expedition") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@lvl", public_str.level);
            cmd.Parameters.AddWithValue("@ADDR", (item.FindControl("txt_address") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@city_code", (item.FindControl("cb_city") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@TLP", (item.FindControl("txt_phone") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@FAX", (item.FindControl("txt_fax") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@EMAIL", (item.FindControl("txt_email") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@WEBSITE", (item.FindControl("txt_website") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@CONT1", (item.FindControl("txt_name1") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@HP1", (item.FindControl("txt_hp1") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@EMAIL1", (item.FindControl("txt_email1") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@CONT2", (item.FindControl("txt_name2") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@HP2", (item.FindControl("txt_hp2") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@EMAIL2", (item.FindControl("txt_email2") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@userid", public_str.user_id);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void RadGrid1_DeleteCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            var EXP_CODE = ((GridDataItem)e.Item).GetDataKeyValue("EXP_CODE");

            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "update MS_EXPEDISI set stEdit = 4, LastUpdate = getdate(), userid = @userid where EXP_CODE = @EXP_CODE";
            cmd.Parameters.AddWithValue("@EXP_CODE", EXP_CODE);
            cmd.Parameters.AddWithValue("@userid", public_str.user_id);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void RadGrid1_ItemCreated(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
            if (e.Item is GridEditableItem & e.Item.IsInEditMode)
            {
                GridEditFormItem item = (GridEditFormItem)e.Item;
                RadTextBox txt = (item.FindControl("txt_code") as RadTextBox);
                if (e.Item.OwnerTableView.IsItemInserted)
                    txt.Enabled = true;
                else
                    txt.Enabled = false;
            }
        }

        private static DataTable Getcity_code(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT city_name, city_code FROM ms_city WHERE stEdit !='4' AND city_name like @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);
            DataTable data = new DataTable();
            adapter.Fill(data);
            return data;
        }

        protected void cb_city_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = Getcity_code(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["city_name"].ToString(), data.Rows[i]["city_name"].ToString()));
            }

            e.Message = GetStatusMessage(endOffset, data.Rows.Count);
        }

        protected void cb_city_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select city_code from ms_city where city_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["city_code"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_city_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select city_code from ms_city where city_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["city_code"].ToString();
            dr.Close();
            con.Close();
        }

        protected void btn_new_Click(object sender, EventArgs e)
        {
            RadGrid1.MasterTableView.IsItemInserted = true;
            RadGrid1.MasterTableView.Rebind();
        }
    }
}