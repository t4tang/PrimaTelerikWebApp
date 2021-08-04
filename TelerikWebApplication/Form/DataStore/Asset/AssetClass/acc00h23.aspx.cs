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

namespace TelerikWebApplication.Form.DataStore.Asset.AssetClass
{
    public partial class acc00h23 : System.Web.UI.Page
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
            cmd.CommandText = "SELECT     AK_NO.AK_CODE, AK_NO.AK_NAME, AK_NO.AK_GROUP, AK_NO.lastupdate, AK_NO.userid, AK_NO.stEdit, AK_NO.exp_life_year, " + 
                                "AK_NO.exp_life_year_tax, CASE AK_NO.mtd WHEN 'S' THEN 'Straight Line' WHEN 'D' THEN 'Double Decline' WHEN 'T' THEN 'Declining Balance' WHEN 'N' THEN 'Non' WHEN 'H' THEN 'HM' ELSE 'KM' END AS mtd, " +  
                                "CASE AK_NO.mtdTax WHEN 'S' THEN 'Straight Line' WHEN 'D' THEN 'Double Decline' WHEN 'T' THEN 'Declining Balance' WHEN 'N' THEN 'Non' WHEN 'H' THEN 'HM' ELSE 'KM' END AS mtdTax, AK_NO.mtd_per, AK_NO.mtd_per_tax, " + 
                                "CASE AK_NO.IOCC WHEN 'CC' THEN 'Cost Center' WHEN 'IO' THEN 'Internal Order' ELSE 'Undefinition' end as IOCC, CASE AK_NO.cat_code WHEN '0' THEN 'Non Prod' ELSE 'Prod' END AS cat_code, " + 
                                "CASE AK_NO.status_class WHEN '0' THEN 'Under Construction' WHEN '1' THEN 'Depreciation' WHEN '2' THEN 'Non Depreciation' WHEN '3' THEN 'Used Equipment' ELSE 'Transfer' END AS status_class, " + 
                                "AK_NO.ak_cum_rek, AK_NO.ak_ex_rek + ' ' + gl_account.accountname AS ak_ex_rekname, AK_NO.ak_gain + ' ' + gl_account.accountname AS ak_gainname, AK_NO.ak_disposal + ' ' + gl_account.accountname AS ak_disposalname, " +
                               "AK_NO.auc_rek + ' ' + gl_account.accountname AS auc_rekname, AK_NO.asset_rek + ' ' + gl_account.accountname AS asset_rekname, " +
                                "AK_NO.ak_rek + ' ' + gl_account.accountname AS ak_rekname " +
                                "FROM AK_NO INNER JOIN " +
                                "gl_account ON AK_NO.ak_rek = gl_account.accountno WHERE AK_NO.stEdit !=4";
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

        protected void RadGrid1_ItemCreated(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
            if (e.Item is GridEditableItem & e.Item.IsInEditMode)
            {
                GridEditFormItem item = (GridEditFormItem)e.Item;
                RadTextBox txt = (item.FindControl("txt_AK_CODE") as RadTextBox);
                //RadNumericTextBox txtLife = (item.FindControl("txt_life") as RadNumericTextBox);
                if (e.Item.OwnerTableView.IsItemInserted)
                   {
                    txt.Enabled = true;
                    //txtLife.Text = string.Format("#,###0.00",0);
                }
                else
                    {
                        txt.Enabled = false;
                    }
                
            }
        }

        protected void RadGrid1_DeleteCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            var productId = ((GridDataItem)e.Item).GetDataKeyValue("AK_CODE");

            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "Update AK_NO SET stEdit = 4 where AK_CODE = @AK_CODE";
            cmd.Parameters.AddWithValue("@AK_CODE", productId);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void RadGrid1_UpdateCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.Item is GridEditFormItem)
            {
                GridEditFormItem item = (GridEditFormItem)e.Item;

                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "UPDATE AK_NO SET AK_NAME = @AK_NAME, lastupdate = GETDATE(), userid = @userid, stEdit = '0', exp_life_year = @exp_life_year, " +
                                        "exp_life_year_tax = @exp_life_year_tax, mtd = @mtd, mtdTax = @mtdTax, mtd_per = @mtd_per, mtd_per_tax = @mtd_per_Tax, ak_rek = @ak_rek,  " +
                                        "ak_ex_rek = @ak_ex_rek, ak_gain = @ak_gain, ak_disposal = @ak_disposal, auc_rek = @auc_rek, asset_rek = @asset_rek, IOCC = @IOCC, cat_code = @cat_code, status_class = @status_class " +
                                        "WHERE AK_CODE = @AK_CODE";
                cmd.Parameters.AddWithValue("@AK_CODE", (item.FindControl("txt_AK_CODE") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@AK_NAME", (item.FindControl("txt_AK_NAME") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@userid", public_str.user_id);
                cmd.Parameters.AddWithValue("@exp_life_year", Convert.ToDouble((item.FindControl("txt_life") as RadNumericTextBox).Text));
                cmd.Parameters.AddWithValue("@exp_life_year_tax", Convert.ToDouble((item.FindControl("txt_lifeTax") as RadNumericTextBox).Text));
                cmd.Parameters.AddWithValue("@mtd", (item.FindControl("cb_mtd") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@mtdTax", (item.FindControl("cb_mtdTax") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@mtd_per", Convert.ToDouble((item.FindControl("txt_apre") as RadNumericTextBox).Text));
                cmd.Parameters.AddWithValue("@mtd_per_tax", Convert.ToDouble((item.FindControl("txt_apreTax") as RadNumericTextBox).Text));
                cmd.Parameters.AddWithValue("@ak_rek", (item.FindControl("cb_ak_rek") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@ak_ex_rek", (item.FindControl("cb_ak_ex_rek") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@ak_gain", (item.FindControl("cb_ak_gain") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@ak_disposal", (item.FindControl("cb_ak_disposal") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@auc_rek", (item.FindControl("cb_cost") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@asset_rek", (item.FindControl("cb_asset") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@IOCC", (item.FindControl("cb_IOCC") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@cat_code", (item.FindControl("cb_cat_code") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@status_class", (item.FindControl("cb_status") as RadComboBox).SelectedValue);
                cmd.ExecuteNonQuery();
                con.Close();
            }
            
        }

        protected void RadGrid1_InsertCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            GridEditableItem item = (GridEditableItem)e.Item;
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "INSERT INTO AK_NO(AK_CODE, AK_NAME, lastupdate, userid, stEdit, " + 
                                "exp_life_year, exp_life_year_tax, mtd, mtdTax, mtd_per, mtd_per_tax, ak_rek, ak_cum_rek, ak_ex_rek, ak_gain, ak_disposal,  " +
                                " auc_rek, asset_rek, IOCC, cat_code, status_class) " +
                                "VALUES (@AK_CODE, @AK_NAME, getdate(), @userid, '0', @exp_life_year, @exp_life_year_tax, @mtd, @mtdTax, @mtd_per, @mtd_per_tax, " +
                                        "@ak_rek,@ak_rek_name, @ak_cum_rek, @ak_ex_rek, @ak_gain, @ak_disposal, @auc_rek, @asset_rek, @IOCC, @cat_code, @status_class)";
            cmd.Parameters.AddWithValue("@AK_CODE", (item.FindControl("txt_AK_CODE") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@AK_NAME", (item.FindControl("txt_AK_NAME") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@userid", public_str.user_id);
            cmd.Parameters.AddWithValue("@exp_life_year", Convert.ToDouble((item.FindControl("txt_life") as RadNumericTextBox).Text));
            cmd.Parameters.AddWithValue("@exp_life_year_tax", Convert.ToDouble((item.FindControl("txt_lifeTax") as RadNumericTextBox).Text));
            cmd.Parameters.AddWithValue("@mtd", (item.FindControl("cb_mtd") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@mtdTax", (item.FindControl("cb_mtdTax") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@mtd_per", Convert.ToDouble((item.FindControl("txt_apre") as RadNumericTextBox).Text));
            cmd.Parameters.AddWithValue("@mtd_per_tax", Convert.ToDouble((item.FindControl("txt_apreTax") as RadNumericTextBox).Text));
            cmd.Parameters.AddWithValue("@ak_rek", (item.FindControl("cb_ak_rek") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@ak_rek_name", (item.FindControl("accountname") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@ak_cum_rek", (item.FindControl("txt_ak_cum_rek") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@ak_ex_rek", (item.FindControl("cb_ak_ex_rek") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@ak_gain", (item.FindControl("cb_ak_gain") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@ak_disposal", (item.FindControl("cb_ak_disposal") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@auc_rek", (item.FindControl("cb_cost") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@asset_rek", (item.FindControl("cb_asset") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@IOCC", (item.FindControl("cb_IOCC") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@cat_code", (item.FindControl("cb_cat_code") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@status_class", (item.FindControl("cb_status") as RadComboBox).SelectedValue); 
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void cb_status_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadComboBox).Text == "Under Construction")
            {
                (sender as RadComboBox).SelectedValue = "0";
            }
            else if ((sender as RadComboBox).Text == "Depreciation")
            {
                (sender as RadComboBox).SelectedValue = "1";
            }
            else if ((sender as RadComboBox).Text == "Non Depreciation")
            {
                (sender as RadComboBox).SelectedValue = "2";
            }
            else if ((sender as RadComboBox).Text == "Used Equipment")
            {
                (sender as RadComboBox).SelectedValue = "3";
            }
            else
            {
                (sender as RadComboBox).SelectedValue = "4";
            }
        }

        protected void cb_status_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Clear();
            (sender as RadComboBox).Items.Add("Under Construction");
            (sender as RadComboBox).Items.Add("Depreciation");
            (sender as RadComboBox).Items.Add("Non Depreciation");
            (sender as RadComboBox).Items.Add("Used Equipment");
            (sender as RadComboBox).Items.Add("Transfer");
        }

        protected void cb_status_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if ((sender as RadComboBox).Text == "Under Construction")
            {
                (sender as RadComboBox).SelectedValue = "0";
            }
            else if ((sender as RadComboBox).Text == "Depreciation")
            {
                (sender as RadComboBox).SelectedValue = "1";
            }
            else if ((sender as RadComboBox).Text == "Non Depreciation")
            {
                (sender as RadComboBox).SelectedValue = "2";
            }
            else if ((sender as RadComboBox).Text == "Used Equipment")
            {
                (sender as RadComboBox).SelectedValue = "3";
            }
            else
            {
                (sender as RadComboBox).SelectedValue = "4";
            }
        }

        private static DataTable Getgl_account(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select accountno +' '+accountname from gl_account where stEdit != 4 " +
                            "AND accountno + ' ' + accountname like @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;

        }

        private static DataTable Getasset_rek(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select accountno +' '+ accountname as accountname from gl_account where stEdit != 4 " +
                " AND accountno +' '+ accountname LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;

        }

        protected void cb_asset_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT * FROM gl_account WHERE accountno +' '+ accountname = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["accountno"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_asset_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = Getasset_rek(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["accountname"].ToString(), data.Rows[i]["accountname"].ToString()));
            }

        }


        protected void cb_asset_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT accountno FROM gl_account WHERE accountno +' '+ accountname = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["accountno"].ToString();
            dr.Close();
            con.Close();
        }

        private static DataTable Getak_disposal(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select accountno +' '+ accountname as accountname from gl_account where stEdit != 4 " +
                " AND accountno +' '+ accountname LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }

        protected void cb_ak_disposal_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT * FROM gl_account WHERE accountno +' '+ accountname = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["accountno"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_ak_disposal_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = Getak_disposal(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["accountname"].ToString(), data.Rows[i]["accountname"].ToString()));
            }
        }

        protected void cb_ak_disposal_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT accountno FROM gl_account WHERE accountno +' '+ accountname = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["accountno"].ToString();
            dr.Close();
            con.Close();
        }

        private static DataTable Getak_gain(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select accountno +' '+ accountname as accountname from gl_account where stEdit != 4 " +
                " AND accountno +' '+ accountname LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }

        protected void cb_ak_gain_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT * FROM gl_account WHERE accountno +' '+ accountname = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["accountno"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_ak_gain_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = Getak_gain(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["accountname"].ToString(), data.Rows[i]["accountname"].ToString()));
            }
        }

        protected void cb_ak_gain_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT accountno FROM gl_account WHERE accountno +' '+ accountname = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["accountno"].ToString();
            dr.Close();
            con.Close();
        }

        private static DataTable Getak_ex_rek(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select accountno +' '+ accountname as accountname from gl_account where stEdit != 4 " +
                " AND accountno +' '+ accountname LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }

        protected void cb_ak_ex_rek_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT accountno FROM gl_account WHERE accountno +' '+ accountname = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["accountno"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_ak_ex_rek_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT * FROM gl_account WHERE accountno +' '+ accountname = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["accountno"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_ak_ex_rek_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = Getak_ex_rek(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["accountname"].ToString(), data.Rows[i]["accountname"].ToString()));
            }
        }

        private static DataTable Getak_rek(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select accountno +' '+ accountname as accountname from gl_account where stEdit != 4 " +
                " AND accountno +' '+ accountname LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }

        String ak_rek_name = null;

        protected void cb_ak_rek_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT accountno,accountname FROM gl_account WHERE accountno +' '+ accountname = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["accountno"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_ak_rek_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;

            cmd.Connection = con;
            cmd.CommandText = "SELECT * FROM gl_account WHERE accountno +' '+ accountname = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["accountno"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_ak_rek_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = Getak_rek(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["accountname"].ToString(), data.Rows[i]["accountname"].ToString()));
            }
        }

        protected void cb_cat_code_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if ((sender as RadComboBox).Text == "Non Prod")
            {
                (sender as RadComboBox).SelectedValue = "0";
            }
            else
            {
                (sender as RadComboBox).SelectedValue = "1";
            }
            
        }

        protected void cb_cat_code_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Clear();
            (sender as RadComboBox).Items.Add("Non Prod.");
            (sender as RadComboBox).Items.Add("Prod.");
        }

        protected void cb_cat_code_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadComboBox).Text == "Non Prod")
            {
                (sender as RadComboBox).SelectedValue = "0";
            }
            else
            {
                (sender as RadComboBox).SelectedValue = "1";
            }
        }

        protected void cb_IOCC_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if ((sender as RadComboBox).Text == "Cost Center")
            {
                (sender as RadComboBox).SelectedValue = "CC";
            }
            else if ((sender as RadComboBox).Text == "Internal Order")
            {
                (sender as RadComboBox).SelectedValue = "IO";
            }
            else
            {
                (sender as RadComboBox).SelectedValue = "NA";
            }
        }

        protected void cb_IOCC_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Clear();
            (sender as RadComboBox).Items.Add("Cost Center");
            (sender as RadComboBox).Items.Add("Internal Order");
            (sender as RadComboBox).Items.Add("Undefinition");
        }

        protected void cb_IOCC_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadComboBox).Text == "Cost Center")
            {
                (sender as RadComboBox).SelectedValue = "CC";
            }
            else if ((sender as RadComboBox).Text == "Internal Order")
            {
                (sender as RadComboBox).SelectedValue = "IO";
            }
            else
            {
                (sender as RadComboBox).SelectedValue = "NA";
            }
        }

        protected void cb_mtdTax_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadComboBox).Text == "Straight Line")
            {
                (sender as RadComboBox).SelectedValue = "S";
            }
            else if ((sender as RadComboBox).Text == "Double Decline")
            {
                (sender as RadComboBox).SelectedValue = "D";
            }
            if ((sender as RadComboBox).Text == "Declining Balance")
            {
                (sender as RadComboBox).SelectedValue = "T";
            }
            else if ((sender as RadComboBox).Text == "Non")
            {
                (sender as RadComboBox).SelectedValue = "N";
            }
            else if ((sender as RadComboBox).Text == "HM")
            {
                (sender as RadComboBox).SelectedValue = "H";
            }
            else
            {
                (sender as RadComboBox).SelectedValue = "K";
            }
        }

        protected void cb_mtdTax_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
           
            if ((sender as RadComboBox).Text == "Straight Line")
            {
                (sender as RadComboBox).SelectedValue = "S";
            }
            else if ((sender as RadComboBox).Text == "Double Decline")
            {
                (sender as RadComboBox).SelectedValue = "D";
            }
            if ((sender as RadComboBox).Text == "Declining Balance")
            {
                (sender as RadComboBox).SelectedValue = "T";
            }
            else if ((sender as RadComboBox).Text == "KM")
            {
                (sender as RadComboBox).SelectedValue = "K";
            }
            else if ((sender as RadComboBox).Text == "HM")
            {
                (sender as RadComboBox).SelectedValue = "H";
            }
            else
            {
                (sender as RadComboBox).SelectedValue = "N";
                
            }
        }

        protected void cb_mtdTax_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
                (sender as RadComboBox).Items.Clear();
                (sender as RadComboBox).Items.Add("Straight Line");
                (sender as RadComboBox).Items.Add("Double Decline");
                (sender as RadComboBox).Items.Add("Declining Balance");
                (sender as RadComboBox).Items.Add("Non");
                (sender as RadComboBox).Items.Add("HM");
                (sender as RadComboBox).Items.Add("KM");            
        }

        protected void cb_mtd_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadComboBox).Text == "Straight Line")
            {
                (sender as RadComboBox).SelectedValue = "S";
            }
            else if ((sender as RadComboBox).Text == "Double Decline")
            {
                (sender as RadComboBox).SelectedValue = "D";
            }
            if ((sender as RadComboBox).Text == "Declining Balance")
            {
                (sender as RadComboBox).SelectedValue = "T";
            }
            else if ((sender as RadComboBox).Text == "Non")
            {
                (sender as RadComboBox).SelectedValue = "N";
            }
            else if ((sender as RadComboBox).Text == "HM")
            {
                (sender as RadComboBox).SelectedValue = "H";
            }
            else
            {
                (sender as RadComboBox).SelectedValue = "K";
            }
        }

        protected void cb_mtd_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
             if ((sender as RadComboBox).Text == "Straight Line")
            {
                (sender as RadComboBox).SelectedValue = "S";
            }
            else if ((sender as RadComboBox).Text == "Double Decline")
            {
                (sender as RadComboBox).SelectedValue = "D";
            }
            if ((sender as RadComboBox).Text == "Declining Balance")
            {
                (sender as RadComboBox).SelectedValue = "T";
            }
            else if ((sender as RadComboBox).Text == "Non")
            {
                (sender as RadComboBox).SelectedValue = "N";
            }
            else if ((sender as RadComboBox).Text == "HM")
            {
                (sender as RadComboBox).SelectedValue = "H";
            }
            else
            {
                (sender as RadComboBox).SelectedValue = "K";
            }
        }

        protected void cb_mtd_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Clear();
            (sender as RadComboBox).Items.Add("Straight Line");
            (sender as RadComboBox).Items.Add("Double Decline");
            (sender as RadComboBox).Items.Add("Declining Balance");
            (sender as RadComboBox).Items.Add("Non");
            (sender as RadComboBox).Items.Add("HM");
            (sender as RadComboBox).Items.Add("KM");
        }

        private static DataTable Getauc_rek(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select accountno +' '+ accountname as accountname from gl_account where stEdit != 4 " +
                " AND accountno +' '+ accountname LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;

        }

        protected void cb_cost_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT accountno FROM gl_account WHERE accountno +' '+ accountname = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["accountno"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_cost_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT * FROM gl_account WHERE accountno +' '+ accountname = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["accountno"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_cost_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = Getauc_rek(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["accountname"].ToString(), data.Rows[i]["accountname"].ToString()));
            }
        }

        protected void btn_new_Click(object sender, EventArgs e)
        {
            RadGrid1.MasterTableView.IsItemInserted = true;
            RadGrid1.MasterTableView.Rebind();
        }
    }
}