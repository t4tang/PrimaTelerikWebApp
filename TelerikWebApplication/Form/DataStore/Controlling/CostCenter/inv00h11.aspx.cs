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
            cmd.CommandText = "select ms_cost_center.CostCenter, ms_cost_center.CostCenterName, ms_company.company_name, ms_ProfitCtr.ProfitCtrName, ms_jobsite.region_name, " +
                "ms_cost_center.PersonIC, ms_cost_Cntr_Cat.DivName, ms_cost_center.Heirarchy from ms_cost_center INNER JOIN ms_company ON ms_cost_center.company_code = ms_company.company_code " +
                "INNER JOIN ms_jobsite ON ms_jobsite.region_code = ms_cost_center.region_code INNER JOIN ms_cost_Cntr_Cat ON  ms_cost_Cntr_Cat.DivCode = ms_cost_center.Divisi INNER JOIN ms_ProfitCtr " +
                " ON ms_cost_center.ProfitCtr = ms_ProfitCtr.ProfitCtr where ms_cost_center.stedit != 4";

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

        private static DataTable Getms_company(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select company_code, company_name from ms_company where company_name like @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;

        }

        private static DataTable Getms_ProfitCtr(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select ProfitCtr, ProfitCtrName from ms_ProfitCtr where ProfitCtrName like @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;

        }

        private static DataTable Getms_jobsite(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select region_code, region_name from ms_jobsite where region_name like @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;

        }

        private static DataTable Getms_cost_Cntr_Cat(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select DivCode, DivName from ms_cost_Cntr_Cat where DivName like @text + '%'",
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
            cmd.CommandText = "update ms_cost_center set stEdit = 4, LastUpdate = getdate(), Usr = @Usr where CostCenter = @CostCenter";
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
            cmd.CommandText = "INSERT INTO ms_cost_center(CostCenter, CostCenterName, company_code, ProfitCtr, region_code, PersonIC, Divisi, Heirarchy, Stamp,Usr,Owner,stEdit) VALUES (@CostCenter, @CostCenterName, @company_code, @ProfitCtr, @region_code, @PersonIC, @Divisi, @Heirarchy, getdate(),@Usr, @Owner,0)";
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
                cmd.CommandText = "UPDATE ms_cost_center set CostCenterName = @CostCenterName, company_code = @company_code, ProfitCtr = @ProfitCtr, region_code = @region_code, PersonIC = @PersonIC, Divisi = @Divisi, Heirarchy =@Heirarchy, LastUpdate = getdate(), Usr = @Usr where CostCenter = @CostCenter";
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
            SqlDataAdapter adapter = new SqlDataAdapter("select company_code, company_name from ms_company where company_name like @text + '%'",
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
            cmd.CommandText = "select company_code from ms_company where company_name = '" + (sender as RadComboBox).Text + "'";
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
            cmd.CommandText = "select company_code from ms_company where company_name = '" + (sender as RadComboBox).Text + "'";
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
            SqlDataAdapter adapter = new SqlDataAdapter("select region_code, region_name from ms_jobsite where region_name like @text + '%'",
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
            cmd.CommandText = "select region_code from ms_jobsite where region_name = '" + (sender as RadComboBox).Text + "'";
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
            cmd.CommandText = "select region_code from ms_jobsite where region_name = '" + (sender as RadComboBox).Text + "'";
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
            SqlDataAdapter adapter = new SqlDataAdapter("select DivCode, DivName from ms_cost_Cntr_Cat where DivName like @text + '%'",
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
            cmd.CommandText = "select DivCode from ms_cost_Cntr_Cat where DivName = '" + (sender as RadComboBox).Text + "'";
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
            cmd.CommandText = "select DivCode from ms_cost_Cntr_Cat where DivName = '" + (sender as RadComboBox).Text + "'";
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
            SqlDataAdapter adapter = new SqlDataAdapter("select ProfitCtr, ProfitCtrName from ms_ProfitCtr where ProfitCtrName like @text + '%'",
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
            cmd.CommandText = "select ProfitCtr from ms_ProfitCtr where ProfitCtrName = '" + (sender as RadComboBox).Text + "'";
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
            cmd.CommandText = "select ProfitCtr from ms_ProfitCtr where ProfitCtrName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["ProfitCtr"].ToString();
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