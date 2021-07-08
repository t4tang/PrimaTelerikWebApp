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

namespace TelerikWebApplication.Form.DataStore.Vehicle.Equipment
{
    public partial class mtc00h16 : System.Web.UI.Page
    {
        public static string koneksi = ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString;
        SqlConnection con = new SqlConnection(koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();
        private const int ItemsPerRequest = 10;

        RadTextBox txt_equipment_Name;
        RadComboBox cb_kind;
        RadDatePicker dtp_purchase;
        RadDatePicker dtp_arrive_date;
        RadDatePicker dtp_machinery_inspect_done;
        RadDatePicker dtp_next_due;
        RadComboBox cb_project;
        RadTextBox txt_asset_code;
        RadComboBox cb_cost_center;
        RadComboBox cb_RepVeh;

        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void RadGrid1_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            (sender as RadGrid).DataSource = GetDataTable();
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
            cmd.CommandText = "SELECT * FROM v_equipment";
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
            if (e.Item is GridEditableItem & e.Item.IsInEditMode)
            {
                GridEditFormItem item = (GridEditFormItem)e.Item;
                RadComboBox cb_equipment_code = (item.FindControl("cb_equipment_code") as RadComboBox);
                if (e.Item.OwnerTableView.IsItemInserted)
                    cb_equipment_code.Enabled = true;
                else
                    cb_equipment_code.Enabled = false;
            }
        }

        protected void btn_new_Click(object sender, EventArgs e)
        {
            RadGrid1.MasterTableView.IsItemInserted = true;
            RadGrid1.MasterTableView.Rebind();
        }


        protected void LoadAssetRegistered(string name, RadComboBox cb)
        {
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);

            SqlDataAdapter adapter = new SqlDataAdapter("SELECT unit_code, AssetSpec, region_code FROM acc00h22 WHERE ak_code IN ('MET1','SET1','SET2','SET3')  " +
                "AND unit_code IN (SELECT unit_code FROM mtc00h16 WHERE stEdit != 4) AND unit_code LIKE @text + '%'", con);
            //adapter.SelectCommand.Parameters.AddWithValue("@project", projectID);
            adapter.SelectCommand.Parameters.AddWithValue("@text", name);
            DataTable dt = new DataTable();
            adapter.Fill(dt);

            cb.DataTextField = "unit_code";
            cb.DataValueField = "unit_code";
            cb.DataSource = dt;
            cb.DataBind();
        }
        protected void cb_equipment_code_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadAssetRegistered(e.Text, (sender as RadComboBox));
        }

        protected void cb_equipment_code_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            RadComboBox btn = (RadComboBox)sender;
            GridEditableItem item = (GridEditableItem)btn.NamingContainer;

            txt_equipment_Name = (RadTextBox)item.FindControl("txt_equipment_Name");
            cb_kind = (RadComboBox)item.FindControl("cb_kind");
            dtp_purchase = (RadDatePicker)item.FindControl("dtp_purchase");
            cb_project = (RadComboBox)item.FindControl("cb_project");
            txt_asset_code = (RadTextBox)item.FindControl("txt_asset_code");
            cb_cost_center = (RadComboBox)item.FindControl("cb_cost_center");

            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT acc00h22.*,inv00h09.region_name, CASE AK_CODE_ORI WHEN 'SET' THEN 'Support Equipment' WHEN 'MET' THEN 'Main Equipment' END As Kind " +
                "FROM acc00h22, inv00h09 WHERE inv00h09.region_code = acc00h22.region_code AND unit_code = '" + (sender as RadComboBox).SelectedValue + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).Text = dr["unit_code"].ToString();
                txt_equipment_Name.Text = dr["AssetSpec"].ToString();
                cb_kind.Text = dr["Kind"].ToString();
                dtp_purchase.SelectedDate = Convert.ToDateTime(dr["tgl_beli"].ToString());
                cb_project.Text = dr["region_name"].ToString();
                txt_asset_code.Text = dr["asset_id"].ToString();
                cb_cost_center.Text = dr["dept_code"].ToString();
            }

            //dr.Close();
            con.Close();
        }

        protected void cb_color_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Add("Blue");
            (sender as RadComboBox).Items.Add("Red");
            (sender as RadComboBox).Items.Add("White");
            (sender as RadComboBox).Items.Add("Yellow");
        }

        protected void cb_color_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if((sender as RadComboBox).Text == "Blue")
            {
                (sender as RadComboBox).SelectedValue = "01";
            }
            else if ((sender as RadComboBox).Text == "Red")
            {
                (sender as RadComboBox).SelectedValue = "02";
            }
            else if ((sender as RadComboBox).Text == "White")
            {
                (sender as RadComboBox).SelectedValue = "03";
            }
            else 
            {
                (sender as RadComboBox).SelectedValue = "04";
            }
        }
        protected void cb_color_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadComboBox).Text == "Blue")
            {
                (sender as RadComboBox).SelectedValue = "01";
            }
            else if ((sender as RadComboBox).Text == "Red")
            {
                (sender as RadComboBox).SelectedValue = "02";
            }
            else if ((sender as RadComboBox).Text == "White")
            {
                (sender as RadComboBox).SelectedValue = "03";
            }
            else
            {
                (sender as RadComboBox).SelectedValue = "04";
            }
        }

        protected void btn_current_Click(object sender, EventArgs e)
        {
            
        }

        private static DataTable GetUnit(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT distinct equipment_type_name from v_equipment WHERE stEdit != '4'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }

        protected void cb_type_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetUnit(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["equipment_type_name"].ToString(), data.Rows[i]["equipment_type_name"].ToString()));
            }

            e.Message = GetStatusMessage(endOffset, data.Rows.Count);
        }
        protected void cb_type_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT distinct equipment_type_name FROM v_equipment where stEdit != '4'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_type_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT distinct equipment_type_name FROM v_equipment where stEdit != '4'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }
         
        protected void cb_kind_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Add("Main Equipment");
            (sender as RadComboBox).Items.Add("Support Equipment");
        }

        protected void cb_kind_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if ((sender as RadComboBox).Text == "Main Equipment")
            {
                (sender as RadComboBox).SelectedValue = "1";
            }
            else
            {
                (sender as RadComboBox).SelectedValue = "2";
            }
        }
        
        protected void cb_kind_PreRender(object sender, EventArgs e)
        {
            if((sender as RadComboBox).Text == "Main Equipment")
            {
                (sender as RadComboBox).SelectedValue = "1";
            }
            else
            {
                (sender as RadComboBox).SelectedValue = "2";
            }
        }
        private static DataTable GetManufacture(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT manu_name FROM inv00h13 WHERE stEdit != '4' AND manu_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }

        protected void cb_manufacture_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetManufacture(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["manu_name"].ToString(), data.Rows[i]["manu_name"].ToString()));
            }

            e.Message = GetStatusMessage(endOffset, data.Rows.Count);
        }

        protected void cb_manufacture_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT manu_name FROM inv00h13 where stEdit != '4'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_manufacture_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT manu_name FROM inv00h13 where stEdit != '4'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }
        private static DataTable GetModel(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT distinct model_no FROM mtc00h16 WHERE stEdit != '4'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }

        protected void cb_model_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetModel(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["model_no"].ToString(), data.Rows[i]["model_no"].ToString()));
            }

            e.Message = GetStatusMessage(endOffset, data.Rows.Count);
        }

        protected void cb_model_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT distinct model_no FROM mtc00h16 where stEdit != '4'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_model_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT distinct model_no FROM mtc00h16 where stEdit != '4'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }
        private static DataTable GetStatus(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT equ_status FROM mtc00h04",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }

        protected void cb_status_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetStatus(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["equ_status"].ToString(), data.Rows[i]["equ_status"].ToString()));
            }

            e.Message = GetStatusMessage(endOffset, data.Rows.Count);
        }

        protected void cb_status_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT distinct model_no FROM mtc00h16 where stEdit != '4'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_status_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadComboBox).Text == "Operation")
            {
                (sender as RadComboBox).SelectedValue = "01";
            }
            else if ((sender as RadComboBox).Text == "Scrapped Down")
            {
                (sender as RadComboBox).SelectedValue = "02";
            }
            else if ((sender as RadComboBox).Text == "Break Down")
            {
                (sender as RadComboBox).SelectedValue = "03";
            }
            else if ((sender as RadComboBox).Text == "Standby")
            {
                (sender as RadComboBox).SelectedValue = "04";
            }
            else if ((sender as RadComboBox).Text == "Sold")
            {
                (sender as RadComboBox).SelectedValue = "05";
            }
            else if ((sender as RadComboBox).Text == "Screpped Opr")
            {
                (sender as RadComboBox).SelectedValue = "06";
            }
            else if ((sender as RadComboBox).Text == "Mutasi")
            {
                (sender as RadComboBox).SelectedValue = "07";
            }
            else
            {
                (sender as RadComboBox).SelectedValue = "08";
            }
        }
        private static DataTable GetCategory(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT body_code FROM mtc00h16",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }

        protected void cb_category_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Add("Mine Production Equipment");
            (sender as RadComboBox).Items.Add("Mine Support Equipment");
            (sender as RadComboBox).Items.Add("General Support");
            (sender as RadComboBox).Items.Add("Tools");
            (sender as RadComboBox).Items.Add("Tyre");
            (sender as RadComboBox).Items.Add("CeX");
            (sender as RadComboBox).Items.Add("GA");
        }

        protected void cb_category_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if ((sender as RadComboBox).Text == "Mine Production Equipment")
            {
                (sender as RadComboBox).SelectedValue = "01";
            }
            else if ((sender as RadComboBox).Text == "Mine Support Equipment")
            {
                (sender as RadComboBox).SelectedValue = "02";
            }
            else if ((sender as RadComboBox).Text == "General Support")
            {
                (sender as RadComboBox).SelectedValue = "03";
            }
            else if ((sender as RadComboBox).Text == "Tools")
            {
                (sender as RadComboBox).SelectedValue = "04";
            }
            else if ((sender as RadComboBox).Text == "Tyre")
            {
                (sender as RadComboBox).SelectedValue = "05";
            }
            else if ((sender as RadComboBox).Text == "CeX")
            {
                (sender as RadComboBox).SelectedValue = "06";
            }
            else
            {
                (sender as RadComboBox).SelectedValue = "07";
            }
        }

        protected void cb_category_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadComboBox).Text == "Mine Production Equipment")
            {
                (sender as RadComboBox).SelectedValue = "01";
            }
            else if ((sender as RadComboBox).Text == "Mine Support Equipment")
            {
                (sender as RadComboBox).SelectedValue = "02";
            }
            else if ((sender as RadComboBox).Text == "General Support")
            {
                (sender as RadComboBox).SelectedValue = "03";
            }
            else if ((sender as RadComboBox).Text == "Tools")
            {
                (sender as RadComboBox).SelectedValue = "04";
            }
            else if ((sender as RadComboBox).Text == "Tyre")
            {
                (sender as RadComboBox).SelectedValue = "05";
            }
            else if ((sender as RadComboBox).Text == "CeX")
            {
                (sender as RadComboBox).SelectedValue = "06";
            }
            else
            {
                (sender as RadComboBox).SelectedValue = "07";
            }
        }
        private static DataTable GetReadingType(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT distinct reading_code FROM mtc00h16 WHERE stEdit != '4'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_reading_type_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetReadingType(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["reading_code"].ToString(), data.Rows[i]["reading_code"].ToString()));
            }

            e.Message = GetStatusMessage(endOffset, data.Rows.Count);
        }

        protected void cb_reading_type_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT distinct reading_code FROM mtc00h16 where stEdit != '4'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_reading_type_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT distinct reading_code FROM mtc00h16 where stEdit != '4'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }
        private static DataTable GetClass(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT distinct class_name FROM mtc00h16 where stEdit != '4'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }

        protected void cb_class_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetClass(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["class_name"].ToString(), data.Rows[i]["class_name"].ToString()));
            }

            e.Message = GetStatusMessage(endOffset, data.Rows.Count);
        }

        protected void cb_class_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT distinct class_name FROM mtc00h16 where stEdit != '4'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_class_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT distinct class_name FROM mtc00h16 where stEdit != '4'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }
        private static DataTable GetProject(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT region_name FROM inv00h09 where stEdit != '4'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }

        protected void cb_project_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetProject(e.Text);

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
            cmd.CommandText = "SELECT region_code FROM inv00h09 where region_name = '" + (sender as RadComboBox).Text +"'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            }
                
            dr.Close();
            con.Close();
        }

        protected void cb_project_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT region_code FROM inv00h09 where region_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            }

            dr.Close();
            con.Close();
        }
        private static DataTable GetCostCenter(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT CostCenter, CostCenterName FROM inv00h11 where stEdit != '4'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void LoadCostCtr(string name, string projectID, RadComboBox cb)
        {
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);

            SqlDataAdapter adapter = new SqlDataAdapter("SELECT CostCenter, CostCenterName FROM inv00h11 " +
                "WHERE stEdit <> '4' AND region_code = @project AND CostCenterName LIKE @text + '%'", con);
            adapter.SelectCommand.Parameters.AddWithValue("@project", projectID);
            adapter.SelectCommand.Parameters.AddWithValue("@text", name);
            DataTable dt = new DataTable();
            adapter.Fill(dt);

            cb.DataTextField = "CostCenter";
            cb.DataValueField = "CostCenter";
            cb.DataSource = dt;
            cb.DataBind();
        }
        protected void cb_cost_center_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            RadComboBox cb = (RadComboBox)sender;
            GridEditableItem item = (GridEditableItem)cb.NamingContainer;

            cb_project = (RadComboBox)item.FindControl("cb_project");

            (sender as RadComboBox).Text = "";
            LoadCostCtr(e.Text, cb_project.SelectedValue, (sender as RadComboBox));
        }

        protected void cb_cost_center_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT * FROM inv00h11 WHERE CostCenter = '" + (sender as RadComboBox).SelectedValue + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["CostCenter"].ToString();
                cb_cost_center.Text = dr["CostCenterName"].ToString();
            }

            con.Close();
        }

        protected void cb_cost_center_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT CostCenter FROM inv00h11 WHERE CostCenter = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }
        private static DataTable GetSupplier(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT supplier_name FROM pur00h01 where stEdit != '4' AND supplier_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }

        protected void cb_supplier_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetSupplier(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["supplier_name"].ToString(), data.Rows[i]["supplier_name"].ToString()));
            }

            e.Message = GetStatusMessage(endOffset, data.Rows.Count);
        }

        protected void cb_supplier_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT supplier_name FROM pur00h01 where stEdit != '4'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_supplier_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT Name FROM inv00h26 where stEdit != '4'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }
        private static DataTable GetManpower(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT Name FROM inv00h26 where stEdit != '4' AND Name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_pic_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetManpower(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["Name"].ToString(), data.Rows[i]["Name"].ToString()));
            }

            e.Message = GetStatusMessage(endOffset, data.Rows.Count);
        }

        protected void cb_pic_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT Name FROM inv00h26 where stEdit != '4'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_pic_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT Name FROM inv00h26 where stEdit != '4'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }
        private static DataTable GetCompany(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT supplier_name from pur00h01 where stEdit != '4' AND supplier_name LIKE @text + '%'",
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
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["supplier_name"].ToString(), data.Rows[i]["supplier_name"].ToString()));
            }

            e.Message = GetStatusMessage(endOffset, data.Rows.Count);
        }

        protected void cb_company_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT supplier_name from pur00h01 where stEdit != '4'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_company_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT supplier_name from pur00h01 where stEdit != '4'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_primary_fuel_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Add("Diesel");
            (sender as RadComboBox).Items.Add("Gas");
            (sender as RadComboBox).Items.Add("Solar");
            (sender as RadComboBox).Items.Add("Super");
            (sender as RadComboBox).Items.Add("ULP");
        }

        protected void cb_primary_fuel_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if ((sender as RadComboBox).Text == "Diesel")
            {
                (sender as RadComboBox).SelectedValue = "Diesel";
            }
            else if ((sender as RadComboBox).Text == "Gas")
            {
                (sender as RadComboBox).SelectedValue = "Gas";
            }
            else if ((sender as RadComboBox).Text == "Solar")
            {
                (sender as RadComboBox).SelectedValue = "Solar";
            }
            else if ((sender as RadComboBox).Text == "Super")
            {
                (sender as RadComboBox).SelectedValue = "Super";
            }
            else
            {
                (sender as RadComboBox).SelectedValue = "ULP";
            }
        }

        protected void cb_primary_fuel_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadComboBox).Text == "Diesel")
            {
                (sender as RadComboBox).SelectedValue = "Diesel";
            }
            else if ((sender as RadComboBox).Text == "Gas")
            {
                (sender as RadComboBox).SelectedValue = "Gas";
            }
            else if ((sender as RadComboBox).Text == "Solar")
            {
                (sender as RadComboBox).SelectedValue = "Solar";
            }
            else if ((sender as RadComboBox).Text == "Super")
            {
                (sender as RadComboBox).SelectedValue = "Super";
            }
            else
            {
                (sender as RadComboBox).SelectedValue = "ULP";
            }
        }

        protected void cb_secondary_fuel_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Add("Diesel");
            (sender as RadComboBox).Items.Add("Gas");
            (sender as RadComboBox).Items.Add("Solar");
            (sender as RadComboBox).Items.Add("Super");
            (sender as RadComboBox).Items.Add("ULP");
        }

        protected void cb_secondary_fuel_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if ((sender as RadComboBox).Text == "Diesel")
            {
                (sender as RadComboBox).SelectedValue = "Diesel";
            }
            else if ((sender as RadComboBox).Text == "Gas")
            {
                (sender as RadComboBox).SelectedValue = "Gas";
            }
            else if ((sender as RadComboBox).Text == "Solar")
            {
                (sender as RadComboBox).SelectedValue = "Solar";
            }
            else if ((sender as RadComboBox).Text == "Super")
            {
                (sender as RadComboBox).SelectedValue = "Super";
            }
            else
            {
                (sender as RadComboBox).SelectedValue = "ULP";
            }
        }

        protected void cb_secondary_fuel_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadComboBox).Text == "Diesel")
            {
                (sender as RadComboBox).SelectedValue = "Diesel";
            }
            else if ((sender as RadComboBox).Text == "Gas")
            {
                (sender as RadComboBox).SelectedValue = "Gas";
            }
            else if ((sender as RadComboBox).Text == "Solar")
            {
                (sender as RadComboBox).SelectedValue = "Solar";
            }
            else if ((sender as RadComboBox).Text == "Super")
            {
                (sender as RadComboBox).SelectedValue = "Super";
            }
            else
            {
                (sender as RadComboBox).SelectedValue = "ULP";
            }
        }

        protected void cb_tank_unit_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Add("Gallons");
            (sender as RadComboBox).Items.Add("Liters");
            (sender as RadComboBox).Items.Add("Kg");
        }

        protected void cb_tank_unit_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if ((sender as RadComboBox).Text == "Gallons")
            {
                (sender as RadComboBox).SelectedValue = "01";
            }
            else if ((sender as RadComboBox).Text == "Liters")
            {
                (sender as RadComboBox).SelectedValue = "02";
            }
            else
            {
                (sender as RadComboBox).SelectedValue = "Kg";
            }
        }

        protected void cb_tank_unit_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadComboBox).Text == "Gallons")
            {
                (sender as RadComboBox).SelectedValue = "01";
            }
            else if ((sender as RadComboBox).Text == "Liters")
            {
                (sender as RadComboBox).SelectedValue = "02";
            }
            else
            {
                (sender as RadComboBox).SelectedValue = "Kg";
            }
        }

        protected void cb_depretype_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Add("Straight-Line");
            (sender as RadComboBox).Items.Add("Double Declining Balance");
        }

        protected void cb_depretype_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if ((sender as RadComboBox).Text == "Straight-Line")
            {
                (sender as RadComboBox).SelectedValue = "L";
            }
            else
            {
                (sender as RadComboBox).SelectedValue = "D";
            }
        }

        protected void cb_depretype_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadComboBox).Text == "Straight-Line")
            {
                (sender as RadComboBox).SelectedValue = "L";
            }
            else
            {
                (sender as RadComboBox).SelectedValue = "D";
            }
        }
        private static DataTable GetRepVeh(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select unit_code +' '+ unit_name as unit_name from v_equipment where stEdit != 4 " +
                " AND unit_code +' '+ unit_name LIKE @text + '%' order by unit_code",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_RepVeh_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetRepVeh(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["unit_name"].ToString(), data.Rows[i]["unit_name"].ToString()));
            }

            e.Message = GetStatusMessage(endOffset, data.Rows.Count);
        }

        protected void cb_RepVeh_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;

            cmd.Connection = con;
            cmd.CommandText = "SELECT * FROM v_equipment WHERE unit_code +' '+ unit_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["unit_code"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_RepVeh_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;

            cmd.Connection = con;
            cmd.CommandText = "SELECT * FROM v_equipment WHERE unit_code +' '+ unit_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["unit_code"].ToString();
            dr.Close();
            con.Close();
        }
        protected void cb_condition_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Add("New");
            (sender as RadComboBox).Items.Add("Second");
        }

        protected void cb_condition_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if ((sender as RadComboBox).Text == "New")
            {
                (sender as RadComboBox).SelectedValue = "New";
            }
            else
            {
                (sender as RadComboBox).SelectedValue = "Second";
            }
        }

        protected void cb_condition_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadComboBox).Text == "New")
            {
                (sender as RadComboBox).SelectedValue = "New";
            }
            else
            {
                (sender as RadComboBox).SelectedValue = "Second";
            }
        }

        protected void RadGrid1_UpdateCommand(object sender, GridCommandEventArgs e)
        {
            GridEditableItem item = (GridEditableItem)e.Item;
            try
            {
                cmd = new SqlCommand("insert into mtc00h16 (unit_code, status_code, equip_kind, color, equipment_code, reading_code, " + 
                                     "manu_code, model_no, class_name, sup_code, tank_unit, body_code, fuel_code, region_code, " + 
                                     "unit_name, hour_avai, active, pur_date, arr_date, pur_cost, order_number, con_status, " + 
                                     "market_value, reple_value, cov, exp_life_year, exp_life_hour, depre_type, salvage_value, " + 
                                     "appreciation, current_value, ac_resale_value, lease_amount_per_unit, fin_company, residual_value, " + 
                                     "pay_day_month, no_repay, repay_amount, total_list_pay, v_year, seat_capa, chasis, engine_no, " + 
                                     "engine_size, no_of_cylin, transmission, key_no, radio_no, s_fuel, tank_capa1, tank_capa2, " + 
                                     "tyre_no_steer, tyre_size_drive, tyre_no_drive, no_of_axles, tare_weight, tare_height, gross_weight, " + 
                                     "gross_width, length, mechin_inspect_done, certi_no, cost, war_hour, war_month, war_sup, " + 
                                     "insu_value, premium, privat_use, fbt_rate, sn_sarana, value_of_ibo, no_axle, no_pos, unladen, " + 
                                     "maxladen, payload, us_percent, sch_percent, exp_life, cap_tanki, ak_id, dept_code, tMain, " + 
                                     "tFuel, stEdit, userid, lastupdate, pic) " + 
                                     "VALUES (@unit_code, @status_code, @equip_kind, @color, @equipment_code, @reading_code, @manu_code, " +
                                     "@model_no, @class_name, @sup_code, @tank_unit, @body_code, @fuel_code, @region_code, @unit_name, " +
                                     "@hour_avai, @active, @pur_date, @arr_date, @pur_cost, @order_number, @con_status, @market_value, " +
                                     "@reple_value, @cov, @exp_life_year, @exp_life_hour, @depre_type, @salvage_value, @appreciation, " +
                                     "@current_value, @ac_resale_value, @lease_amount_per_unit, @fin_company, @residual_value, " +
                                     "@pay_day_month, @no_repay, @repay_amount, @total_list_pay, @v_year, @seat_capa, @chasis, " +
                                     "@engine_no, @engine_size, @no_of_cylin, @transmission, @key_no, @radio_no, @s_fuel, @tank_capa1, " +
                                     "@tank_capa2, @tyre_no_steer, @tyre_size_drive, @tyre_no_drive, @no_of_axles, @tare_weight, " +
                                     "@tare_height, @gross_weight, @gross_width, @length, @mechin_inspect_done, @certi_no, @cost, " +
                                     "@licen_code, @war_start, @war_finish, @war_hour, @war_month, @war_sup, @insu_value, @renewal, " +
                                     "@premium, @fbt_rate, @sn_sarana, @value_of_ibo, @no_pos, @unladen, @maxladen, @payload, @us_percent, " +
                                     "@sch_percent, @exp_life, @cap_tanki, @ak_id, @dept_code, @tMain, @tFuel, '1', @userid, GETDATE(), @pic)", con);
                con.Open();
                cmd.Parameters.AddWithValue("@unit_code", (item.FindControl("cb_equipment_code") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@status_code", (item.FindControl("cb_status") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@equip_kind", (item.FindControl("cb_kind") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@color", (item.FindControl("cb_color") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@equipment_code", (item.FindControl("cb_equipment_code") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@reading_code", (item.FindControl("cb_reading_type") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@manu_code", (item.FindControl("cb_manufacture") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@model_no", (item.FindControl("cb_model") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@class_name", (item.FindControl("cb_class") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@sup_code", (item.FindControl("cb_supplier") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@tank_unit", (item.FindControl("cb_tank_unit") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@body_code", (item.FindControl("cb_category") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@fuel_code", (item.FindControl("cb_primary_fuel") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@region_code", (item.FindControl("cb_project") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@unit_name", (item.FindControl("txt_equipment_Name") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@hour_avai", (item.FindControl("txt_std_opr") as RadTextBox).Text);
                if ((item.FindControl("chk_active") as CheckBox).Checked == true)
                {
                    cmd.Parameters.AddWithValue("@privat_use", 1);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@privat_use", 0);
                }
                cmd.Parameters.AddWithValue("@pur_date", string.Format("{0:yyyy-MM-dd}", dtp_purchase.SelectedDate.Value));
                cmd.Parameters.AddWithValue("@arr_date", string.Format("{0:yyyy-MM-dd}", dtp_arrive_date.SelectedDate.Value));
                cmd.Parameters.AddWithValue("@pur_cost", (item.FindControl("txt_pur_cost") as RadNumericTextBox).Text);
                cmd.Parameters.AddWithValue("@order_number", (item.FindControl("txt_order_num") as RadNumericTextBox).Text);
                cmd.Parameters.AddWithValue("@con_status", (item.FindControl("cb_condition") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@market_value", (item.FindControl("txt_MarVal") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@reple_value", (item.FindControl("txt_replacement_value") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@cov", (item.FindControl("txt_change_over_value") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@exp_life_year", (item.FindControl("txt_life_year") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@exp_life_hour", (item.FindControl("txt_life_hour") as RadTextBox).Text);
                //cmd.Parameters.AddWithValue("@depre_type", (item.FindControl("cb_equipment_code") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@salvage_value", (item.FindControl("txt_salvage_value") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@appreciation", (item.FindControl("txt_hours_appreciation") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@current_value", (item.FindControl("txt_current_value") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@ac_resale_value", (item.FindControl("txt_ARValue") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@lease_amount_per_unit", (item.FindControl("cb_equipment_code") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@fin_company", (item.FindControl("cb_equipment_code") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@residual_value", (item.FindControl("cb_equipment_code") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@pay_day_month", (item.FindControl("cb_equipment_code") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@no_repay", (item.FindControl("cb_equipment_code") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@repay_amount", (item.FindControl("cb_equipment_code") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@total_list_pay", (item.FindControl("cb_equipment_code") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@v_year", (item.FindControl("cb_equipment_code") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@seat_capa", (item.FindControl("cb_equipment_code") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@chasis", (item.FindControl("cb_equipment_code") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@engine_no", (item.FindControl("cb_equipment_code") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@engine_size", (item.FindControl("cb_equipment_code") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@no_of_cylin", (item.FindControl("cb_equipment_code") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@transmission", (item.FindControl("cb_equipment_code") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@key_no", (item.FindControl("cb_equipment_code") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@radio_no", (item.FindControl("cb_equipment_code") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@s_fuel", (item.FindControl("cb_equipment_code") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@tank_capa1", (item.FindControl("cb_equipment_code") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@tank_capa2", (item.FindControl("cb_equipment_code") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@tyre_no_steer", (item.FindControl("cb_equipment_code") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@tyre_size_drive", (item.FindControl("cb_equipment_code") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@tyre_no_drive", (item.FindControl("cb_equipment_code") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@no_of_axles", (item.FindControl("cb_equipment_code") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@tare_weight", (item.FindControl("cb_equipment_code") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@tare_height", (item.FindControl("cb_equipment_code") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@gross_weight", (item.FindControl("cb_equipment_code") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@gross_width", (item.FindControl("cb_equipment_code") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@length", (item.FindControl("cb_equipment_code") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@mechin_inspect_done", (item.FindControl("cb_equipment_code") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@certi_no", (item.FindControl("cb_equipment_code") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@cost", (item.FindControl("cb_equipment_code") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@war_hour", (item.FindControl("cb_equipment_code") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@war_month", (item.FindControl("cb_equipment_code") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@war_sup", (item.FindControl("cb_equipment_code") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@insu_value", (item.FindControl("cb_equipment_code") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@premium", (item.FindControl("cb_equipment_code") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@privat_use", (item.FindControl("cb_equipment_code") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@fbt_rate", (item.FindControl("cb_equipment_code") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@sn_sarana", (item.FindControl("cb_equipment_code") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@value_of_ibo", (item.FindControl("cb_equipment_code") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@no_axle", (item.FindControl("cb_equipment_code") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@no_pos", (item.FindControl("cb_equipment_code") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@unladen", (item.FindControl("cb_equipment_code") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@maxladen", (item.FindControl("cb_equipment_code") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@payload", (item.FindControl("cb_equipment_code") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@us_percent", (item.FindControl("cb_equipment_code") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@sch_percent", (item.FindControl("cb_equipment_code") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@exp_life", (item.FindControl("cb_equipment_code") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@cap_tanki", (item.FindControl("cb_equipment_code") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@ak_id", (item.FindControl("cb_equipment_code") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@dept_code", (item.FindControl("cb_equipment_code") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@tMain", (item.FindControl("cb_equipment_code") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@tFuel", (item.FindControl("cb_equipment_code") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@userid", (item.FindControl("cb_equipment_code") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@pic", (item.FindControl("cb_equipment_code") as RadComboBox).SelectedValue);
                cmd.ExecuteNonQuery();
                con.Close();

                RadGrid1.DataBind();

                Label lblsuccess = new Label();
                lblsuccess.Text = "Data inserted successfully";
                lblsuccess.ForeColor = System.Drawing.Color.Blue;
                RadGrid1.Controls.Add(lblsuccess);

            }
            catch (Exception ex)
            {
                con.Close();
                Label lblError = new Label();
                lblError.Text = "Unable to delete data. Reason: " + ex.Message;
                lblError.ForeColor = System.Drawing.Color.Red;
                RadGrid1.Controls.Add(lblError);

                e.Canceled = true;
            }
        }
    }
}