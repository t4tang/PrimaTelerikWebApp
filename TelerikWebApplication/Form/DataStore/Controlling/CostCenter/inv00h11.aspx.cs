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

namespace TelerikWebApplication.Form.DataStore.Controlling.CostCenter
{
    public partial class inv00h11 : System.Web.UI.Page
    {

        public static string koneksi = ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString;
        SqlConnection con = new SqlConnection(koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();
        private const int ItemsPerRequest = 10;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void RadGrid1_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            (sender as RadGrid).DataSource = GetDataTable();
        }

        public DataTable GetDataTable()
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select inv00h11.CostCenter, inv00h11.CostCenterName, inv00h15.company_name, inv00h19.ProfitCtrName, inv00h09.region_name, " +
                "inv00h11.PersonIC, inv00h14.DivName, inv00h11.Heirarchy from inv00h11 INNER JOIN inv00h15 ON inv00h11.company_code = inv00h15.company_code " +
                "INNER JOIN inv00h09 ON inv00h09.region_code = inv00h11.region_code INNER JOIN inv00h14 ON  inv00h14.DivCode = inv00h11.Divisi INNER JOIN inv00h19 " +
                " ON inv00h11.ProfitCtr = inv00h19.ProfitCtr where inv00h11.stedit != 4";

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

        private static DataTable Getinv00h15(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select company_code, company_name from inv00h15 where company_name like @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;

        }

        private static DataTable Getinv00h19(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select ProfitCtr, ProfitCtrName from inv00h19 where ProfitCtrName like @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;

        }

        private static DataTable Getinv00h09(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select region_code, region_name from inv00h09 where region_name like @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;

        }

        private static DataTable Getinv00h14(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select DivCode, DivName from inv00h14 where DivName like @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;

        }

        protected void RadGrid1_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            var productId = ((GridDataItem)e.Item).GetDataKeyValue("CostCenter");

            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "update inv00h11 set stEdit = 4, LastUpdate = getdate(), Usr = @Usr where CostCenter = @CostCenter";
            cmd.Parameters.AddWithValue("@CostCenter", productId);
            cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void RadGrid1_InsertCommand(object sender, GridCommandEventArgs e)
        {
            GridEditableItem item = (GridEditableItem)e.Item;
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "INSERT INTO inv00h11(CostCenter, CostCenterName, company_code, ProfitCtr, region_code, PersonIC, Divisi, Heirarchy, Stamp,Usr,Owner,stEdit) VALUES (@CostCenter, @CostCenterName, @company_code, @ProfitCtr, @region_code, @PersonIC, @Divisi, @Heirarchy, getdate(),@Usr, @Owner,0)";
            cmd.Parameters.AddWithValue("@CostCenter", (item.FindControl("txt_CostCenter") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@CostCenterName", (item.FindControl("txt_CostCenterName") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@company_code", (item.FindControl("cb_company") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@ProfitCtr", (item.FindControl("cb_profitCtr") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@region_code", (item.FindControl("cb_region") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@PersonIC", (item.FindControl("txt_PersonIC") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@Divisi", (item.FindControl("cb_category") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@Heirarchy", (item.FindControl("txt_Heirarchy") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
            cmd.Parameters.AddWithValue("@Owner", public_str.user_id);
            cmd.Parameters.AddWithValue("@status", "0");
            cmd.ExecuteNonQuery();
            con.Close();
        }
        protected void RadGrid1_UpdateCommand(object sender, GridCommandEventArgs e)
        {
            if (e.Item is GridEditFormItem)
            {
                GridEditFormItem item = (GridEditFormItem)e.Item;
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "UPDATE inv00h11 set CostCenterName = @CostCenterName, company_code = @company_code, ProfitCtr = @ProfitCtr, region_code = @region_code, PersonIC = @PersonIC, Divisi = @Divisi, Heirarchy =@Heirarchy, LastUpdate = getdate(), Usr = @Usr where CostCenter = @CostCenter";
                cmd.Parameters.AddWithValue("@CostCenterName", (item.FindControl("txt_CostCenterName") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@CostCenter", (item.FindControl("txt_CostCenter") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@company_code", (item.FindControl("cb_company") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@ProfitCtr", (item.FindControl("cb_profitCtr") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@region_code", (item.FindControl("cb_region") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@PersonIC", (item.FindControl("txt_PersonIC") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@Divisi", (item.FindControl("cb_category") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@Heirarchy", (item.FindControl("txt_Heirarchy") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }

        protected void cb_company_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetCompany(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["company_name"].ToString(), data.Rows[i]["company_name"].ToString()));
            }

        }

        private static DataTable GetCompany(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select company_code, company_name from inv00h15 where company_name like @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;

        }

        protected void cb_company_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select company_code from inv00h15 where company_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["company_code"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_company_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select company_code from inv00h15 where company_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["company_code"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_region_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetRegion(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["region_name"].ToString(), data.Rows[i]["region_name"].ToString()));
            }
        }

        private static DataTable GetRegion(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select region_code, region_name from inv00h09 where region_name like @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;

        }

        protected void cb_region_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select region_code from inv00h09 where region_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["region_code"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_region_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select region_code from inv00h09 where region_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["region_code"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_category_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetCategory(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["DivName"].ToString(), data.Rows[i]["DivName"].ToString()));
            }
        }

        private static DataTable GetCategory(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select DivCode, DivName from inv00h14 where DivName like @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;

        }
        protected void cb_category_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select DivCode from inv00h14 where DivName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["DivCode"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_category_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select DivCode from inv00h14 where DivName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["DivCode"].ToString();
            dr.Close();
            con.Close();
        }



        protected void RadGrid1_ItemCreated(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridEditableItem & e.Item.IsInEditMode)
            {
                GridEditFormItem item = (GridEditFormItem)e.Item;
                RadTextBox txt = (item.FindControl("txt_CostCenter") as RadTextBox);
                if (e.Item.OwnerTableView.IsItemInserted)
                    txt.Enabled = true;
                else
                    txt.Enabled = false;
            }
        }

        protected void cb_profitCtr_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetProfitCtr(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["ProfitCtrName"].ToString(), data.Rows[i]["ProfitCtrName"].ToString()));
            }
        }

        private static DataTable GetProfitCtr(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select ProfitCtr, ProfitCtrName from inv00h19 where ProfitCtrName like @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;

        }
        protected void cb_profitCtr_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select ProfitCtr from inv00h19 where ProfitCtrName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["ProfitCtr"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_profitCtr_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select ProfitCtr from inv00h19 where ProfitCtrName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["ProfitCtr"].ToString();
            dr.Close();
            con.Close();
        }
    }
}