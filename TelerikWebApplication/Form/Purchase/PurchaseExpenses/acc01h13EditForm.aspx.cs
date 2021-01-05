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

namespace TelerikWebApplication.Form.Purchase.PurchaseExpenses
{
    public partial class acc01h13EditForm : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();
        private const int ItemsPerRequest = 10;


        public static string tax_check = null;
        public static string oTax_check = null;
        public static string pph_check = null;
        public static string tax1 = null;
        public static string tax2 = null;
        public static string tax3 = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["po_code"] != null)
            {
                fill_object(Request.QueryString["po_code"].ToString());
                RadGrid2.DataSource = GetDataDetailTable(txt_doc_code.Text);
                RadGrid2.DataBind();
                Session["actionEdit"] = "edit";
            }
            else
            {
                Session["actionEdit"] = "new";

                dtp_purex.SelectedDate = DateTime.Now;
                
                cb_project.SelectedValue = public_str.site;
                cb_project.Text = public_str.sitename;
                cb_tax1.Text = "NON";
                cb_tax2.Text = "NON";
                cb_tax3.Text = "NON";

                txt_uid.Text = public_str.user_id;
                txt_owner.Text = public_str.user_id;
                txt_lastUpdate.Text = string.Format("{0:dd/MM/yyyy}", DateTime.Now);
                txt_printed.Text = "0";
                txt_edited.Text = "0";
                txt_sub_total.Value = 0;
                txt_tax1_value.Value = 0;
                txt_tax2_value.Value = 0;
                txt_tax3_value.Value = 0;
                txt_DP.Value = 0;
                txt_total.Value = 0;
            }
        }
        protected void fill_object(string NoBuk)
        {
            con.Open();
            SqlDataReader sdr;
            SqlCommand cmd = new SqlCommand("SELECT * FROM v_purchase_expensesH WHERE NoBuk =  '" + NoBuk + "'", con);
            sdr = cmd.ExecuteReader();
            if (sdr.Read())
            {
                txt_doc_code.Text = sdr["NoBuk"].ToString();
                dtp_purex.SelectedDate = Convert.ToDateTime(sdr["Tgl"].ToString());
                txt_ctrl_no.Text= sdr["NoPO"].ToString();
                txt_invoice_no.Text = sdr["NoFP"].ToString();
                txt_tax_invoice.Text = sdr["invCode"].ToString();
                dtp_invoice_date.SelectedDate = Convert.ToDateTime(sdr["TglFP"].ToString());
                cb_supplier.Text = sdr["NamSup"].ToString();
                txt_curr.Text = sdr["KoMat"].ToString();
                txt_kurs.Value = Convert.ToDouble(sdr["Kurs"].ToString());
                txt_tax_kurs.Value = Convert.ToDouble(sdr["Kurs"].ToString());
                cb_tax1.Text = sdr["tax1_name"].ToString();
                cb_tax2.Text = sdr["tax2_name"].ToString();
                cb_tax3.Text = sdr["tax3_name"].ToString();
                cb_project.Text = sdr["region_name"].ToString();
                cb_cost_center.Text = sdr["CostCenterName"].ToString();
                txt_remark.Text = sdr["Ket"].ToString();
                txt_term_days.Value = Convert.ToDouble(sdr["JTempo"].ToString());
                cb_prepare_by.Text = sdr["prepare_by_name"].ToString();
                cb_checked.Text = sdr["ack_by_name"].ToString();
                cb_approved.Text = sdr["app_by_name"].ToString();
                txt_owner.Text = sdr["Owner"].ToString();
                txt_printed.Text = sdr["Printed"].ToString();
                txt_edited.Text = sdr["Edited"].ToString();
                txt_uid.Text = sdr["Usr"].ToString();
                txt_lastUpdate.Text = string.Format("{0:dd/MM/yyyy}", sdr["Stamp"].ToString());
                cb_term.Text = sdr["payTerm"].ToString();
                txt_pppn.Value = Convert.ToDouble(sdr["PPPN"]);
                txt_ppph.Value = Convert.ToDouble(sdr["PPPH"]);
                txt_po_tax.Value = Convert.ToDouble(sdr["POTax"]);
                txt_sub_total.Value = Convert.ToDouble(sdr["Jumlah"]);
                txt_tax1_value.Value = Convert.ToDouble(sdr["JPPN"]);
                txt_tax2_value.Value = Convert.ToDouble(sdr["JOTax"]);
                txt_tax3_value.Value = Convert.ToDouble(sdr["Jpph"]);
                txt_total.Value = Convert.ToDouble(sdr["Net"]);
                txt_DP.Value = Convert.ToDouble(sdr["DP"]);
            }
            con.Close();
        }
        private DataTable GetDataDetailTable(string nobuk)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_purchase_expensesD";
            cmd.Parameters.AddWithValue("@nobuk", nobuk);
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
        protected void btn_save_Click(object sender, EventArgs e)
        {

        }

        protected void cb_type_ref_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {

        }

        protected void cb_type_ref_PreRender(object sender, EventArgs e)
        {

        }

        protected void cb_type_ref_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

        protected void cb_term_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {

        }

        protected void cb_term_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

        protected void cb_term_PreRender(object sender, EventArgs e)
        {

        }

        protected void cb_supplier_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {

        }

        protected void cb_supplier_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

        protected void cb_tax1_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {

        }

        protected void cb_tax1_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

        protected void cb_tax1_PreRender(object sender, EventArgs e)
        {

        }

        protected void cb_tax2_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {

        }

        protected void cb_tax2_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

        protected void cb_tax2_PreRender(object sender, EventArgs e)
        {

        }

        protected void cb_tax3_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {

        }

        protected void cb_tax3_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

        protected void cb_tax3_PreRender(object sender, EventArgs e)
        {

        }

        protected void cb_project_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {

        }

        protected void cb_project_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

        protected void cb_project_PreRender(object sender, EventArgs e)
        {

        }        

        protected void cb_cost_center_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {

        }

        protected void cb_cost_center_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

        protected void cb_cost_center_PreRender(object sender, EventArgs e)
        {

        }

        protected void cb_prepare_by_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {

        }

        protected void cb_prepare_by_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

        protected void cb_prepare_by_PreRender(object sender, EventArgs e)
        {

        }        

        protected void cb_checked_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {

        }

        protected void cb_checked_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

        protected void cb_checked_PreRender(object sender, EventArgs e)
        {

        }

        protected void cb_approved_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {

        }

        protected void cb_approved_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

        protected void cb_approved_PreRender(object sender, EventArgs e)
        {

        }

        protected void RadGrid2_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {

        }

        protected void RadGrid2_UpdateCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {

        }

        protected void RadGrid2_DeleteCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {

        }
    }
}