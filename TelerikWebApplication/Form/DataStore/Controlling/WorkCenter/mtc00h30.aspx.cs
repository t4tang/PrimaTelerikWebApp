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

namespace TelerikWebApplication.Form.DataStore.Controlling.WorkCenter
{
    public partial class mtc00h30 : System.Web.UI.Page
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
            cmd.CommandText = "SELECT        mtc00h30.wkcencode, mtc00h30.wkcenname, mtc00h34.wkcencat, " +
                              "mtc00h34.wkcencat + ' - ' + mtc00h34.wkcencatName AS wkcencatComb, mtc00h34.wkcencatName, " +
                              "mtc00h33.PersonRespon, mtc00h33.PersonRespon + ' - ' + mtc00h33.PersonResponname AS PersonResponComb, mtc00h33.PersonResponname, " +
                              "mtc00h32.kdusage, mtc00h32.kdusage + ' - ' + mtc00h32.NmUsage AS UsageComb, mtc00h32.NmUsage, " +
                              "mtc00h35.controlkey, mtc00h35.controlkey + ' - ' + mtc00h35.controlName AS controlComb, mtc00h35.controlName, " +
                              "mtc00h31.CapCat, mtc00h31.CapCat + ' - ' + mtc00h31.CapCatName AS CapCatComb, mtc00h31.CapCatName, " +
                              "inv00h11.CostCenter, inv00h11.CostCenter + ' - ' + inv00h11.CostCenterName AS CostCenterComb, inv00h11.CostCenterName, " +
                              "mtc00h30.DateValidStart, mtc00h30.DateValidEnd, " +
                              "mtc00h24.Act_type, mtc00h24.Act_type + ' - ' + mtc00h24.Act_typeName AS Act_typeComb, mtc00h24.Act_typeName, " +
                              "inv00h09.region_code, inv00h09.region_name, mtc00h30.lastupdate, mtc00h30.userid, mtc00h30.stEdit " +
                              "FROM mtc00h30 INNER JOIN " +
                              "inv00h09 ON mtc00h30.Region_Code = inv00h09.region_code INNER JOIN " +
                              "mtc00h24 ON mtc00h30.Act_type = mtc00h24.Act_type INNER JOIN " +
                              "mtc00h31 ON mtc00h30.CapCat = mtc00h31.CapCat INNER JOIN " +
                              "mtc00h32 ON mtc00h30.kdusage = mtc00h32.kdusage INNER JOIN " +
                              "mtc00h33 ON mtc00h30.PersonRespon = mtc00h33.PersonRespon INNER JOIN " +
                              "mtc00h34 ON mtc00h30.wkcencat = mtc00h34.wkcencat INNER JOIN " +
                              "mtc00h35 ON mtc00h30.controlkey = mtc00h35.controlkey INNER JOIN " +
                              "inv00h11 ON mtc00h30.CostCenCode = inv00h11.CostCenter " +
                              "WHERE(mtc00h30.stEdit <> '4')";
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
            cmd.CommandText = "INSERT INTO mtc00h30 (wkcencode, wkcenname, wkcencat, PersonRespon, kdusage, controlkey, CapCat, CostCenCode, " +
                              "DateValidStart, DateValidEnd, Act_type, Region_Code, lastupdate, userid, stEdit) VALUES " +
                              "(@wkcencode, @wkcenname, @wkcencat, @PersonRespon, @kdusage, @controlkey, @CapCat, @CostCenCode, @DateValidStart, " +
                              "@DateValidEnd, @Act_type, @Region_Code, getdate(), @userid, '0')";
            cmd.Parameters.AddWithValue("@wkcencode", (item.FindControl("txt_code") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@wkcenname", (item.FindControl("txt_work_center") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@wkcencat", (item.FindControl("cb_category") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@PersonRespon", (item.FindControl("cb_respon") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@kdusage", (item.FindControl("cb_usage") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@controlkey", (item.FindControl("txt_control_key") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@CapCat", (item.FindControl("cb_capacity") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@CostCenCode", (item.FindControl("cb_cost_center") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@DateValidStart", (item.FindControl("dtp_start") as RadDatePicker).SelectedDate);
            cmd.Parameters.AddWithValue("@DateValidEnd", (item.FindControl("dtp_end") as RadDatePicker).SelectedDate);
            cmd.Parameters.AddWithValue("@Act_type", (item.FindControl("cb_act_type") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@Region_Code", (item.FindControl("cb_project") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@Userid", public_str.user_id);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void RadGrid1_UpdateCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            GridEditableItem item = (GridEditableItem)e.Item;
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "UPDATE mtc00h30 SET wkcenname = @wkcenname, wkcencat = @wkcencat, PersonRespon = @PersonRespon, kdusage = @kdusage, " +
                              "controlkey = @controlkey, CapCat = @CapCat, CostCenCode = @CostCenCode, DateValidStart = @DateValidStart, " +
                              "DateValidEnd = @DateValidEnd, Act_type = @Act_type, Region_Code = @Region_Code, lastupdate = getdate(), userid = @userid " +
                              "WHERE wkcencode = @wkcencode";
            cmd.Parameters.AddWithValue("@wkcencode", (item.FindControl("txt_code") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@wkcenname", (item.FindControl("txt_work_center") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@wkcencat", (item.FindControl("cb_category") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@PersonRespon", (item.FindControl("cb_respon") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@kdusage", (item.FindControl("cb_usage") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@controlkey", (item.FindControl("txt_control_key") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@CapCat", (item.FindControl("cb_capacity") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@CostCenCode", (item.FindControl("cb_cost_center") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@DateValidStart", (item.FindControl("dtp_start") as RadDatePicker).SelectedDate);
            cmd.Parameters.AddWithValue("@DateValidEnd", (item.FindControl("dtp_end") as RadDatePicker).SelectedDate);
            cmd.Parameters.AddWithValue("@Act_type", (item.FindControl("cb_act_type") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@Region_Code", (item.FindControl("cb_project") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@Userid", public_str.user_id);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void RadGrid1_DeleteCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            var wkcencode = ((GridDataItem)e.Item).GetDataKeyValue("wkcencode");

            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "update mtc00h30 set stEdit = '4', lastupdate = getdate(), userid = @userid where wkcencode = @wkcencode";
            cmd.Parameters.AddWithValue("@wkcencode", wkcencode);
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

        public DataTable Get_Project(string Text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT region_code, region_name FROM inv00h09 where stEdit != '4' AND region_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", Text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_project_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = Get_Project(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["region_name"].ToString(), data.Rows[i]["region_name"].ToString()));
            }

            e.Message = GetStatusMessage(endOffset, data.Rows.Count);
        }

        protected void cb_project_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT region_code, region_name FROM inv00h09 WHERE region_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["region_code"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_project_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT region_code, region_name FROM inv00h09 WHERE region_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["region_code"].ToString();
            dr.Close();
            con.Close();
        }

        public DataTable Get_Control(string Text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT controlkey, controlName FROM mtc00h35 where stEdit != '4' AND controlName LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", Text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void txt_control_key_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = Get_Control(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["controlName"].ToString(), data.Rows[i]["controlName"].ToString()));
            }

            e.Message = GetStatusMessage(endOffset, data.Rows.Count);
        }

        protected void txt_control_key_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT * FROM mtc00h35 WHERE controlName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["controlkey"].ToString();
            dr.Close();
            con.Close();
        }

        protected void txt_control_key_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT * FROM mtc00h35 WHERE controlName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["controlkey"].ToString();
            dr.Close();
            con.Close();
        }

        public DataTable Get_Capacity(string Text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT CapCat, CapCatName from mtc00h31 where stEdit != '4' AND CapCatName LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", Text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_capacity_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = Get_Capacity(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["CapCatName"].ToString(), data.Rows[i]["CapCatName"].ToString()));
            }

            e.Message = GetStatusMessage(endOffset, data.Rows.Count);
        }

        protected void cb_capacity_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT * FROM mtc00h31 WHERE CapCatName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["CapCat"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_capacity_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT * FROM mtc00h31 WHERE CapCatName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["CapCat"].ToString();
            dr.Close();
            con.Close();
        }

        public DataTable Get_Category(string Text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT wkcencat, wkcencatName from mtc00h34 where stEdit != '4' AND wkcencatName LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", Text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_category_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = Get_Category(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["wkcencatName"].ToString(), data.Rows[i]["wkcencatName"].ToString()));
            }

            e.Message = GetStatusMessage(endOffset, data.Rows.Count);
        }

        protected void cb_category_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT * FROM mtc00h34 WHERE wkcencatName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["wkcencat"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_category_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT * FROM mtc00h34 WHERE wkcencatName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["wkcencat"].ToString();
            dr.Close();
            con.Close();
        }

        public DataTable Get_Respon(string Text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT PersonRespon,PersonResponname from mtc00h33 where stEdit != '4' AND PersonResponname LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", Text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_respon_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = Get_Respon(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["PersonResponname"].ToString(), data.Rows[i]["PersonResponname"].ToString()));
            }

            e.Message = GetStatusMessage(endOffset, data.Rows.Count);
        }

        protected void cb_respon_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT * FROM mtc00h33 WHERE PersonResponname = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["PersonRespon"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_respon_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT * FROM mtc00h33 WHERE PersonResponname = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["PersonRespon"].ToString();
            dr.Close();
            con.Close();
        }

        public DataTable Get_Usage(string Text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT kdusage, NmUsage from mtc00h32 where stEdit != '4' AND NmUsage LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", Text);
            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_usage_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = Get_Usage(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["NmUsage"].ToString(), data.Rows[i]["NmUsage"].ToString()));
            }

            e.Message = GetStatusMessage(endOffset, data.Rows.Count);
        }

        protected void cb_usage_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT * FROM mtc00h32 WHERE NmUsage = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["kdusage"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_usage_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT * FROM mtc00h32 WHERE NmUsage = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["kdusage"].ToString();
            dr.Close();
            con.Close();
        }

        public DataTable Get_Cost_Center(string Text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT CostCenter, CostCenterName FROM inv00h11 where stEdit != '4' AND CostCenterName LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", Text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_cost_center_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = Get_Cost_Center(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["CostCenterName"].ToString(), data.Rows[i]["CostCenterName"].ToString()));
            }

            e.Message = GetStatusMessage(endOffset, data.Rows.Count);
        }

        protected void cb_cost_center_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT * FROM inv00h11 WHERE CostCenterName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["CostCenter"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_cost_center_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT * FROM inv00h11 WHERE CostCenterName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["CostCenter"].ToString();
            dr.Close();
            con.Close();
        }

        public DataTable Get_Act_Type(string Text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT Act_type, Act_typeName from mtc00h24 where stEdit != '4' AND Act_typeName LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", Text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_act_type_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = Get_Act_Type(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["Act_typeName"].ToString(), data.Rows[i]["Act_typeName"].ToString()));
            }

            e.Message = GetStatusMessage(endOffset, data.Rows.Count);
        }

        protected void cb_act_type_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT * FROM mtc00h24 WHERE Act_typeName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["Act_type"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_act_type_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT * FROM mtc00h24 WHERE Act_typeName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["Act_type"].ToString();
            dr.Close();
            con.Close();
        }
    }
}