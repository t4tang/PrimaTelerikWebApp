using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using TelerikWebApplication.Class;

namespace TelerikWebApplication.Form.DataStore.MineControlProduction.Location
{
    public partial class pro00h03 : System.Web.UI.Page
    {
        public static string koneksi = ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString;
        SqlConnection con = new SqlConnection(koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();
        private const int ItemsPerRequest = 10;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void RadAjaxManager1_AjaxRequest(object sender, Telerik.Web.UI.AjaxRequestEventArgs e)
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
            cmd.CommandText = "SELECT MCC_MS_LOC.Loc_code, MCC_MS_LOC.loc_name, MCC_MS_LOC.remark, MCC_MS_LOC.Stamp, MCC_MS_LOC.Usr, MCC_MS_LOC.Owner, " +
                              "MCC_MS_LOC.stEdit, MCC_MS_LOC_CAT.loc_cate_code, ms_jobsite.region_code +' - '+ ms_jobsite.region_name AS region_code, MCC_MS_LOC_CAT.cat_name, ms_jobsite.region_name " +
                              "FROM MCC_MS_LOC INNER JOIN MCC_MS_LOC_CAT ON MCC_MS_LOC.loc_cate_code = MCC_MS_LOC_CAT.loc_cate_code INNER JOIN " +
                              "ms_jobsite ON MCC_MS_LOC.region_code = ms_jobsite.region_code WHERE MCC_MS_LOC.stEdit != '4'";
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
            (sender as RadGrid).DataSource = GetDataTable();
        }

        protected void RadGrid1_InsertCommand(object sender, GridCommandEventArgs e)
        {
            GridEditableItem item = (GridEditableItem)e.Item;
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "INSERT INTO MCC_MS_LOC (Loc_code, loc_name, region_code, loc_cate_code, remark, Stamp, Usr, Owner, stEdit) " +
                              "VALUES (@Loc_code, @loc_name, @region_code, @loc_cate_code, @remark, getdate(), @Usr, @Owner, '0')";
            cmd.Parameters.AddWithValue("@Loc_code", (item.FindControl("txt_code") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@loc_name", (item.FindControl("txt_location") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@region_code", (item.FindControl("cb_area") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@loc_cate_code", (item.FindControl("cb_category") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@remark", (item.FindControl("txt_remark") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
            cmd.Parameters.AddWithValue("@Owner", public_str.user_id);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void RadGrid1_UpdateCommand(object sender, GridCommandEventArgs e)
        {
            GridEditableItem item = (GridEditableItem)e.Item;
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "UPDATE MCC_MS_LOC SET loc_name = @loc_name, region_code = @region_code, loc_cate_code = @loc_cate_code, remark = @remark, " +
                              "Stamp = getdate(), Usr = @Usr WHERE Loc_code = @Loc_code";
            cmd.Parameters.AddWithValue("@Loc_code", (item.FindControl("txt_code") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@loc_name", (item.FindControl("txt_location") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@region_code", (item.FindControl("cb_area") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@loc_cate_code", (item.FindControl("cb_category") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@remark", (item.FindControl("txt_remark") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void RadGrid1_DeleteCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            var Loc_code = ((GridDataItem)e.Item).GetDataKeyValue("Loc_code");

            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "UPDATE MCC_MS_LOC SET stEdit = 4 where Loc_code = @Loc_code";
            cmd.Parameters.AddWithValue("@Loc_code", Loc_code);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void RadGrid1_ItemCreated(object sender, GridItemEventArgs e)
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

        protected void cb_category_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT loc_cate_code FROM MCC_MS_LOC_CAT WHERE cat_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["loc_cate_code"].ToString();
            dr.Close();
            con.Close();
        }

        public DataTable GetCategory(string Text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select loc_cate_code, cat_name from MCC_MS_LOC_CAT where stEdit != 4 AND cat_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", Text);

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
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["cat_name"].ToString(), data.Rows[i]["cat_name"].ToString()));
            }

            e.Message = GetStatusMessage(endOffset, data.Rows.Count);
        }

        protected void cb_category_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT loc_cate_code FROM MCC_MS_LOC_CAT WHERE cat_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["loc_cate_code"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_area_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT region_code FROM ms_jobsite WHERE region_code +' - '+ region_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["region_code"].ToString();
            dr.Close();
            con.Close();
        }

        public DataTable GetArea(string Text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select region_code +' - '+ region_name as region_name from ms_jobsite where stEdit != '4' " +
                                                        "AND region_code +' - '+ region_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", Text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_area_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetArea(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["region_name"].ToString(), data.Rows[i]["region_name"].ToString()));
            }

            e.Message = GetStatusMessage(endOffset, data.Rows.Count);
        }

        protected void cb_area_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT region_code FROM ms_jobsite WHERE region_code +' - '+ region_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["region_code"].ToString();
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