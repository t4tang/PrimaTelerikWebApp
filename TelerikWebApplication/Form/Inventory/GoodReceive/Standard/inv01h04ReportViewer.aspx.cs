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

namespace TelerikWebApplication.Form.Inventory.GoodReceive.Standard
{
    using ReportLibrary.slip;
    using System;
    using Telerik.ReportViewer.Html5.WebForms;
    public partial class inv01h04ReportViewer : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();

        public static string transaction = null;
        string tr_code = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            this.Title = Request.QueryString["lbm_code"];
            if (!IsPostBack)
            {
                this.Title = tr_code;
                this.reportViewer_inv01h04.ViewMode = ViewMode.PrintPreview;
                inv01h04_slip._tr_code = Request.QueryString["lbm_code"];
                initBtnOk(tr_code);
            }
        }
        private void initBtnOk(string tr_code)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT status_lbm, createby, Receiptby, approval FROM inv01h04 WHERE lbm_code = '" + tr_code + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                if (dr["status_lbm"].ToString() == "0" && dr["createby"].ToString() == public_str.uid)
                {
                    btnOk.Enabled = true;
                }
                else if (dr["status_lbm"].ToString() == "1" && dr["Receiptby"].ToString() == public_str.uid)
                {
                    btnOk.Enabled = true;
                }
                else if (dr["status_lbm"].ToString() == "2" && dr["approval"].ToString() == public_str.uid)
                {
                    btnOk.Enabled = true;
                }
                
            }
            con.Close();
        }
        protected void btnOk_Click(object sender, EventArgs e)
        {
            string status = null;
            string createby = null;
            string Receiptby = null;
            string ApproveBy = null;
            con.Open();
            cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT status_lbm, createby, Receiptby, approval FROM inv01h04 WHERE lbm_code = '" + tr_code + "'";
            SqlDataReader sdr;
            sdr = cmd.ExecuteReader();
            while (sdr.Read())
            {
                status = sdr[0].ToString();
                createby = sdr[1].ToString();
                Receiptby = sdr[2].ToString();
                ApproveBy = sdr[3].ToString();
            }
            sdr.Close();

            try
            {
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;

                if (status == "0" && createby == public_str.user_id)
                {
                    cmd.CommandText = "UPDATE inv01h04 SET status_lbm = '" + status + "' + 1 WHERE lbm_code ='" + tr_code + "'";
                }
                else if (status == "1" && Receiptby == public_str.user_id)
                {
                    cmd.CommandText = "UPDATE inv01h04 SET status_lbm = '" + status + "' + 1 WHERE lbm_code ='" + tr_code + "'";
                }
                else if (status == "2" && ApproveBy == public_str.user_id)
                {
                    cmd.CommandText = "UPDATE inv01h04 SET status_lbm = '" + status + "' + 1 WHERE lbm_code ='" + tr_code + "'";
                }
                
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