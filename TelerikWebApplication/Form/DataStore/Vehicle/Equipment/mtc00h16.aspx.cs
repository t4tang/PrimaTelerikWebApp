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
            cmd.CommandText = "SELECT mtc00h16.unit_code, mtc00h16.unit_name, mtc00h16.equipment_code, mtc00h16.model_no, mtc00h16.class_name, mtc00h16.sup_code, " +
            "Convert(varchar,mtc00h16.pur_date,105) as pur_date, Convert(varchar,mtc00h16.arr_date,105) as arr_date, mtc00h16.con_status, mtc00h16.engine_no, " +
            "mtc00h16.engine_size, mtc00h16.key_no, mtc00h16.pur_cost, mtc00h16.order_number, inv00h13.manu_name, mtc00h04.equ_status, inv00h09.region_name, " +
            "mtc00h03.description as kind_name, mtc00h05.description as type_name, mtc00h16.reading_code, mtc00h16.hour_avai, mtc00h16.dept_code, pur00h01.supplier_name FROM  mtc00h16 " + 
            "INNER JOIN inv00h13 ON mtc00h16.manu_code = inv00h13.manu_code " +
            "INNER JOIN mtc00h04 ON mtc00h16.status_code = mtc00h04.status_code " +
            "INNER JOIN inv00h09 ON mtc00h16.region_code = inv00h09.region_code " + 
            "INNER JOIN mtc00h03 ON mtc00h03.equipment_code = mtc00h16.equip_kind " +
            "INNER JOIN mtc00h05 ON mtc00h05.equipment_code = mtc00h16.equipment_code "+
            "INNER JOIN pur00h01 ON pur00h01.supplier_code = mtc00h16.sup_code WHERE(mtc00h16.stEdit <> '4') ";
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
                RadTextBox txt = (item.FindControl("txt_equipment_code") as RadTextBox);
                if (e.Item.OwnerTableView.IsItemInserted)
                    txt.Enabled = true;
                else
                    txt.Enabled = false;
            }
        }
    }
}