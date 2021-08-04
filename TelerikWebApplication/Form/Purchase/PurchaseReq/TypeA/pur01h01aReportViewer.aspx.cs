using ReportLibrary.slip;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.ReportViewer.Html5.WebForms;
using Telerik.Web.UI;
using TelerikWebApplication.Class;


namespace TelerikWebApplication.Form.Purchase.PurchaseReq
{
    public partial class pur01h01aReportViewer : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();

        public static string transaction = null;
        string tr_code = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Title = Request.QueryString["pr_code"];

            this.reportViewer1.ViewMode = ViewMode.PrintPreview;
            if (!IsPostBack)
            {
                this.Title = tr_code;
                this.reportViewer1.ViewMode = ViewMode.PrintPreview;
                pur01h01typeA_slip._tr_code = Request.QueryString["pr_code"];
                initBtnOk(tr_code);
            }
        }
        private void initBtnOk(string tr_code)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT status_pur, FreBy, OrdBy, AppBy FROM tr_purchase_reqH WHERE pr_code = '" + tr_code + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                if (dr["status_pur"].ToString() == "0" && dr["FreBy"].ToString() == public_str.uid)
                {
                    btnOk.Enabled = true;
                }
                else if (dr["status_pur"].ToString() == "1" && dr["OrdBy"].ToString() == public_str.uid)
                {
                    btnOk.Enabled = true;
                }
                
                else if (dr["status_pur"].ToString() == "2" && dr["AppBy"].ToString() == public_str.uid)
                {
                    btnOk.Enabled = true;
                }

            }
            con.Close();
        }
        protected void btnOk_Click(object sender, EventArgs e)
        {
            string status_pur = null;
            string FreBy = null;
            string OrdBy = null;
            string AppBy = null;
            con.Open();
            cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT status_pur, FreBy, OrdBy, AppBy FROM tr_purchase_reqH WHERE pr_code = '" + tr_code + "'";
            SqlDataReader sdr;
            sdr = cmd.ExecuteReader();
            while (sdr.Read())
            {
                
                status_pur = sdr[0].ToString();
                FreBy = sdr[1].ToString();
                OrdBy = sdr[2].ToString();
                AppBy = sdr[3].ToString();
            }
            sdr.Close();

            try
            {
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
               
                cmd.CommandText = "UPDATE tr_purchase_reqH SET status_pur = '" + status_pur + "' + 1 WHERE pr_code ='" + tr_code + "'";
               
            }
            catch (Exception)
            {
                con.Close();
            }
            finally
            {
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }
    }
}