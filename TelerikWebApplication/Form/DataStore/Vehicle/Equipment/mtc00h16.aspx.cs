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
        RadComboBox cb_project;
        RadTextBox txt_asset_code;
        RadComboBox cb_cost_center;

        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void RadGrid1_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            (sender as RadGrid).DataSource = GetDataTable();
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
    }
}