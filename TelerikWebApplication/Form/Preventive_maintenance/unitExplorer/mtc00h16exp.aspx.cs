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

namespace TelerikWebApplication.Form.Preventive_maintenance.unitExplorer
{
    public partial class mtc00h16exp : System.Web.UI.Page
    {
        string selected_unit = null;
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();

        protected void Page_Load(object sender, EventArgs e)
        {
            if(!Page.IsPostBack)
            {
                populateTree(RadTreeView1);
            }
        }
        internal class SiteDataItem
        {
            private string text;
            private int id;
            private int parentId;

            public string Text
            {
                get { return text; }
                set { text = value; }
            }


            public int ID
            {
                get { return id; }
                set { id = value; }
            }

            public int ParentID
            {
                get { return parentId; }
                set { parentId = value; }
            }

            public SiteDataItem(int id, int parentId, string text)
            {
                this.id = id;
                this.parentId = parentId;
                this.text = text;
            }
        }
        private static void populateTree(RadTreeView treeView)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT DISTINCT(mtc00h16.region_code) as ID, region_name as node, NULL as parent FROM inv00h09, mtc00h16 WHERE mtc00h16.region_code =  inv00h09.region_code " +
            "UNION SELECT unit_code, unit_code as node, region_code as parent FROM mtc00h16 WHERE active = 1", ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);

            DataSet links = new DataSet();

            adapter.Fill(links);
            treeView.DataTextField = "node";
            treeView.DataFieldID = "ID";
            treeView.DataFieldParentID = "parent";

            treeView.DataSource = links;
            treeView.DataBind();
        }

        protected void RadTreeView1_NodeClick(object sender, RadTreeNodeEventArgs e)
        {
            selected_unit = RadTreeView1.SelectedNode.Text;
            lbl_unit_description.Text = selected_unit;
            general_info(selected_unit);
        }

        private void general_info(string unit_code)
        {
            try
            {
                con.Open();
                SqlDataReader sdr;
                SqlCommand cmd = new SqlCommand("SELECT * FROM v_equipment_info WHERE unit_code = '" + unit_code + "'", con);
                sdr = cmd.ExecuteReader();
                if (sdr.Read())
                {
                    txt_eqp_type.Text = sdr["unit_name"].ToString();
                    txt_eqp_kind.Text = sdr["equip_kind"].ToString();
                    txt_manufacture.Text = sdr["manu_name"].ToString();
                    txt_model.Text = sdr["model_no"].ToString();
                    txt_status.Text = sdr["equ_status"].ToString();
                    txt_reading_type.Text = sdr["reading_code"].ToString();
                    txt_readType2.Text = sdr["reading_code2"].ToString();
                    txt_opr_hours.Text = sdr["hour_avai"].ToString();
                    txt_category.Text = sdr["category"].ToString();
                    txt_class.Text = sdr["class_name"].ToString();
                    txt_supplier.Text = sdr["supplier_name"].ToString();
                    //DateTime? purc_date = Convert.ToDateTime(sdr["pur_date"].ToString());
                    //txt_purc_date.Text = purc_date?.ToString("dd/MM/yyyy");
                    //DateTime? arr_date = Convert.ToDateTime(sdr["arr_date"].ToString());
                    //txt_purc_date.Text = arr_date?.ToString("dd/MM/yyyy");
                    //txt_engine_no.Text = sdr["createby_name"].ToString();
                    //txt_engine_model.Text = sdr["createby_name"].ToString();
                    //txt_sn.Text = sdr["createby_name"].ToString();
                    //txt_condition.Text = sdr["createby_name"].ToString();
                    //txt_project.Text = sdr["status_post"].ToString();
                    //txt_year.Text = sdr["createby_name"].ToString();
                    //txt_seat_cap.Text = sdr["createby_name"].ToString();
                    //txt_chasis.Text = sdr["createby_name"].ToString();
                    //txt_no_cylinder.Text = sdr["createby_name"].ToString();
                    //txt_transmission.Text = sdr["status_post"].ToString();
                    //txt_radio_no.Text = sdr["createby_name"].ToString();
                    //txt_sn_sarana.Text = sdr["createby_name"].ToString();
                    //txt_exp_lifetime.Text = sdr["createby_name"].ToString();
                    //txt_unschedule_bd.Text = sdr["createby_name"].ToString();
                    //txt_schedule_bd.Text = sdr["status_post"].ToString();
                    //txt_steer_size.Text = sdr["createby_name"].ToString();
                    //txt_noOf_steer_size.Text = sdr["createby_name"].ToString();
                    //txt_tyre_size_drive.Text = sdr["createby_name"].ToString();
                    //txt_noOf_tyre_size_drive.Text = sdr["createby_name"].ToString();
                    //txt_wheel_base.Text = sdr["status_post"].ToString();
                    //txt_wheel_drive.Text = sdr["createby_name"].ToString();
                    //txt_no_of_axles.Text = sdr["createby_name"].ToString();
                    //txt_tare_weight.Text = sdr["createby_name"].ToString();
                    //txt_height.Text = sdr["createby_name"].ToString();
                    //txt_gross_weight.Text = sdr["status_post"].ToString();
                    //txt_width.Text = sdr["createby_name"].ToString();
                    //txt_color.Text = sdr["createby_name"].ToString();
                    //txt_lenght.Text = sdr["createby_name"].ToString();
                    //txt_primary_fuel.Text = sdr["createby_name"].ToString();
                    //txt_primary_tank_capacity.Text = sdr["status_post"].ToString();
                    //txt_secondary_fuel.Text = sdr["createby_name"].ToString();
                    //txt_secondary_fuel_capacity.Text = sdr["createby_name"].ToString();
                    //txt_tank_unit.Text = sdr["createby_name"].ToString();
                    //txt_inspect_done.Text = sdr["createby_name"].ToString();
                    //txt_certificate_no.Text = sdr["status_post"].ToString();
                    //txt_next_due.Text = sdr["createby_name"].ToString();
                }
                con.Close();
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}