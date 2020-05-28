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

namespace TelerikWebApplication.Form.Inventory.GoodReceive
{
    public partial class inv01h04 : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();
        private const int ItemsPerRequest = 10;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                dtp_from.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
                dtp_to.SelectedDate = DateTime.Now;
                //cb_bank_prm.SelectedValue = public_str.site;

                set_info();
                Session["action"] = "Firstload";
                RadGrid2.Enabled = false;
                btnSave.Enabled = false;
                btnSave.ImageUrl = "~/Images/simpan-gray.png";
                btnPrint.Enabled = false;
                btnPrint.ImageUrl = "~/Images/cetak-gray.png";
                //dtp_created.SelectedDate = DateTime.Now;
            }
        }

        protected void btnOk_Click(object sender, EventArgs e)
        {
            foreach (GridDataItem item in RadGrid1.SelectedItems)
            {
                //txt_ur_number.Text = item["doc_code"].Text;
                //dtp_ur.SelectedDate = Convert.ToDateTime(item["doc_date"].Text);

                con.Open();
                SqlDataReader sdr;
                SqlCommand cmd = new SqlCommand("SELECT * FROM v_bank_paymentH WHERE slip_no = '" + item["slip_no"].Text + "'", con);
                sdr = cmd.ExecuteReader();
                if (sdr.Read())
                {
                    txt_slip_number.Text = sdr["slip_no"].ToString();
                    cb_supplier.Text = sdr["supplier_name"].ToString();
                    txt_currency.Text = sdr["cur_code"].ToString();
                    txt_kurs.Text = sdr["kurs"].ToString();
                    cb_bank.Text = sdr["NamBank"].ToString();
                    txt_curr2.Text = sdr["cur_code_acc"].ToString();
                    txt_kurs2.Text = sdr["kurs_acc"].ToString();
                    txt_ctrl.Text = sdr["noctrl"].ToString();
                    dtp_created.SelectedDate = Convert.ToDateTime(sdr["slip_date"].ToString());
                    dtp_cashed.SelectedDate = Convert.ToDateTime(sdr["tgl_cair"].ToString());
                    //txt_giro.Text = sdr["doc_remark"].ToString();
                    txt_remark.Text = sdr["Remark"].ToString();
                    txt_user.Text = sdr["userid"].ToString();
                    txt_lastupdate.Text = string.Format("{0:dd-MM-yyyy}", sdr["lastupdate"].ToString());
                    cb_pre.Text = sdr["RequestBy"].ToString();
                    cb_check.Text = sdr["Checkby"].ToString();
                    cb_approve.Text = sdr["Approveby"].ToString();
                }
                con.Close();

                RadGrid2.DataSource = GetDataDetailTable(txt_slip_number.Text);
                RadGrid2.DataBind();
                Session["action"] = "edit";
                btnSave.Enabled = true;
                btnSave.ImageUrl = "~/Images/simpan.png";
                btnPrint.Enabled = true;
                btnPrint.ImageUrl = "~/Images/cetak.png";
                btnPrint.Attributes["OnClick"] = String.Format("return ShowPreview('{0}');", txt_slip_number.Text);

            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {

        }

        protected void btnNew_Click(object sender, ImageClickEventArgs e)
        {

        }

        protected void rb_from_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {

        }

        protected void rb_from_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

        protected void rb_from_PreRender(object sender, EventArgs e)
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

        protected void cb_supplier_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {

        }

        protected void cb_supplier_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

        protected void cb_supplier_PreRender(object sender, EventArgs e)
        {

        }

        protected void cb_costcenter_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {

        }

        protected void cb_costcenter_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

        protected void cb_costcenter_PreRender(object sender, EventArgs e)
        {

        }

        protected void cb_storage_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {

        }

        protected void cb_storage_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

        protected void cb_storage_PreRender(object sender, EventArgs e)
        {

        }

        protected void cb_created_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {

        }

        protected void cb_created_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

        protected void cb_created_PreRender(object sender, EventArgs e)
        {

        }

        protected void cb_received_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {

        }

        protected void cb_received_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

        protected void cb_received_PreRender(object sender, EventArgs e)
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

        protected void btnSave_Click(object sender, ImageClickEventArgs e)
        {

        }

        protected void RadGrid1_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {

        }
        public DataTable GetDataTable(string fromDate, string toDate, string kobank)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_goods_receiveH";
            cmd.Parameters.AddWithValue("@date", fromDate);
            cmd.Parameters.AddWithValue("@todate", toDate);
            cmd.Parameters.AddWithValue("@KoBank", kobank);
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
        protected void RadGrid1_DeleteCommand(object sender, GridCommandEventArgs e)
        {

        }

        protected void RadGrid2_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {

        }

        protected void RadGrid2_DeleteCommand(object sender, GridCommandEventArgs e)
        {

        }
    }
}