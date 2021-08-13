﻿using System;
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

namespace TelerikWebApplication.Form.DataStore.Controlling.ProfitCenter
{
    public partial class inv00h19 : System.Web.UI.Page
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
            cmd.CommandText = "SELECT ms_ProfitCtr.ProfitCtr, ms_ProfitCtr.ProfitCtrName, ms_ProfitCtr.Heirarchy, ms_ProfitCtr.Stamp, ms_ProfitCtr.Usr, ms_ProfitCtr.Owner, " + 
                                "ms_company.company_name, ms_jobsite.region_name, ms_ProfitCtr.PersonIC, ms_cost_Cntr_Cat.DivName, ms_ProfitCtr.lastupdate, " + 
                                "ms_ProfitCtr.stEdit " +
                                "FROM ms_ProfitCtr INNER JOIN " +
                                "ms_jobsite ON ms_ProfitCtr.region_code = ms_jobsite.region_code INNER JOIN " +
                                "ms_company ON ms_ProfitCtr.company_code = ms_company.company_code INNER JOIN " +
                                "ms_cost_Cntr_Cat ON ms_ProfitCtr.Divisi = ms_cost_Cntr_Cat.DivCode where ms_ProfitCtr.stedit != 4" ;
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
                RadTextBox txt = (item.FindControl("txt_profit_ctr") as RadTextBox);
                if (e.Item.OwnerTableView.IsItemInserted)
                    txt.Enabled = true;
                else
                    txt.Enabled = false;
            }
        }

        protected void RadGrid1_DeleteCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            var productId = ((GridDataItem)e.Item).GetDataKeyValue("ProfitCtr");

            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "Update ms_ProfitCtr SET stEdit = 4 where ProfitCtr = @ProfitCtr";
            cmd.Parameters.AddWithValue("@ProfitCtr", productId);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void RadGrid1_InsertCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            GridEditableItem item = (GridEditableItem)e.Item;
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "INSERT INTO ms_ProfitCtr(ProfitCtr,ProfitCtrName,Heirarchy,Stamp,Usr,Owner,stEdit,company_code,region_code,PersonIC,Divisi) " +
                                "VALUES (@ProfitCtr,@ProfitCtrName,@Heirarchy,getdate(),@Usr,@Owner,@stEdit,@company_code,@region_code,@PersonIC,@Divisi)";
            cmd.Parameters.AddWithValue("@ProfitCtr", (item.FindControl("txt_profit_ctr") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@ProfitCtrName", (item.FindControl("txt_profit_center_name") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@Heirarchy", (item.FindControl("txt_Heirarchy") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
            cmd.Parameters.AddWithValue("@Owner", public_str.user_id);
            cmd.Parameters.AddWithValue("@stEdit", "0");
            cmd.Parameters.AddWithValue("@company_code", (item.FindControl("cb_company") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@region_code", (item.FindControl("cb_region") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@PersonIC", (item.FindControl("txt_PersonIC") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@Divisi", (item.FindControl("cb_category") as RadComboBox).SelectedValue);
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
                cmd.CommandText = "UPDATE ms_ProfitCtr SET ProfitCtrName = @ProfitCtrName, company_code = @company_code, region_code = @region_code, " +
                                    "PersonIC = @PersonIC, Divisi = @Divisi, Heirarchy = @Heirarchy, Usr = @Usr, Owner = @Owner, lastupdate = getdate() " + 
                                    "WHERE ProfitCtr = @ProfitCtr";
                cmd.Parameters.AddWithValue("@ProfitCtr", (item.FindControl("txt_profit_ctr") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@ProfitCtrName", (item.FindControl("txt_profit_center_name") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@company_code", (item.FindControl("cb_company") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@region_code", (item.FindControl("cb_region") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@PersonIC", (item.FindControl("txt_PersonIC") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@Divisi", (item.FindControl("cb_category") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@Heirarchy", (item.FindControl("txt_Heirarchy") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
                cmd.Parameters.AddWithValue("@Owner", public_str.user_id);
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }

        private static DataTable Getms_company(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select company_code, company_name from ms_company where company_code like @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;

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
            SqlDataAdapter adapter = new SqlDataAdapter("select company_code, company_name from ms_company where company_code like @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;

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

        private static DataTable Getms_jobsite(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select region_code, region_name from ms_jobsite where region_name like @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;

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

        private static DataTable Getms_cost_Cntr_Cat(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select DivCode, DivName from ms_cost_Cntr_Cat where DivName like @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;

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

        protected void btn_new_Click(object sender, EventArgs e)
        {
            RadGrid1.MasterTableView.IsItemInserted = true;
            RadGrid1.MasterTableView.Rebind();
        }
    }
}