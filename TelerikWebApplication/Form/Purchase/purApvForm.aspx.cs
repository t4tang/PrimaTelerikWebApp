using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.ReportViewer.Html5.WebForms;
using Telerik.Web.UI;
using TelerikWebApplication.Class;
using TelerikWebApplication.Form.Purchase.Purchase_order;

namespace TelerikWebApplication.Form.Purchase
{
    public partial class purApvForm : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();

        public static string transaction = null;
        string tr_code = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            tr_code = Request.QueryString["po_code"];

            if (!IsPostBack)
            {
                this.Title = tr_code;
                this.reportViewer1.ViewMode = ViewMode.PrintPreview;
                initBtnOk(tr_code);
                pur01h02_slip._tr_code = tr_code;
            }
        }

        private void initBtnOk(string tr_code)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT status_pur, FreBy, OrdBy, OrdBy2, AppBy, CONVERT(char(1),overhaul) as overhaul FROM pur01h02 WHERE po_code = '" + tr_code + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                if(dr["status_pur"].ToString() == "0" && dr["FreBy"].ToString() == public_str.uid)
                {
                    btnOk.Enabled = true;
                    //btnOk.ImageUrl = "~/Images/ok-hand.png";
                }
                else if (dr["status_pur"].ToString() == "1" && dr["OrdBy"].ToString() == public_str.uid)
                {
                    btnOk.Enabled = true;
                    //btnOk.ImageUrl = "~/Images/ok-hand.png";
                }
                else if (dr["status_pur"].ToString() == "2" && dr["OrdBy2"].ToString() == public_str.uid)
                {
                    btnOk.Enabled = true;
                    //btnOk.ImageUrl = "~/Images/ok-hand.png";
                }
                else if (dr["status_pur"].ToString() == "2" && dr["AppBy"].ToString() == public_str.uid)
                {
                    btnOk.Enabled = true;
                    //btnOk.ImageUrl = "~/Images/ok-hand.png";
                }

                if (dr["overhaul"].ToString() == "1")
                {
                    chk_overhaul.Checked = true;
                }
                else
                {
                    chk_overhaul.Checked = false;
                }
            }
            con.Close();
        }
        protected void RadGrid1_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            (sender as RadGrid).DataSource = GetDataTable(transaction);
        }

        public DataTable GetDataTable(string transaction_name)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_need_approval_list";
            cmd.Parameters.AddWithValue("@transaction", transaction_name);
            cmd.Parameters.AddWithValue("@uid", public_str.uid);
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

        protected void btnOk_Click(object sender, ImageClickEventArgs e)
        {
            double nominal = 0;
            string status_pur = null;
            con.Open();
            cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT Net, status_pur FROM pur01h02 WHERE po_code = '" + tr_code + "'";
            SqlDataReader sdr;
            sdr = cmd.ExecuteReader();
            while (sdr.Read())
            {
                nominal = Convert.ToDouble(sdr[0]);
                status_pur = sdr[1].ToString();
            }
            sdr.Close();

            try
            {
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
              
                if (nominal >= 50000000 && status_pur == "2")
                {
                    cmd.CommandText = "UPDATE pur01h02 SET status_pur = '" + status_pur + "' WHERE po_code ='"+ tr_code + "'";                    
                }
                else
                {
                    cmd.CommandText = "UPDATE pur01h02 SET status_pur = '" + status_pur + "' + 1 WHERE po_code ='" + tr_code + "'";
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

        protected void btnOk_Click1(object sender, EventArgs e)
        {
            double nominal = 0;
            string status_pur = null;
            string FreBy = null;
            string OrdBy = null;
            string OrdBy2 = null;
            string AppBy = null;
            con.Open();
            cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT Net, status_pur, FreBy, OrdBy, OrdBy2, AppBy FROM pur01h02 WHERE po_code = '" + tr_code + "'";
            SqlDataReader sdr;
            sdr = cmd.ExecuteReader();
            while (sdr.Read())
            {
                nominal = Convert.ToDouble(sdr[0]);
                status_pur = sdr[1].ToString();
                FreBy = sdr[2].ToString();
                OrdBy = sdr[3].ToString();
                OrdBy2 = sdr[4].ToString();
                AppBy = sdr[5].ToString();
            }
            sdr.Close();

            try
            {
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                if (nominal >= 50000000)
                {
                    if (status_pur == "0" && FreBy == public_str.user_id)
                    {
                        cmd.CommandText = "UPDATE pur01h02 SET status_pur = '" + status_pur + "' + 1 WHERE po_code ='" + tr_code + "'";
                    }
                    else if ( status_pur == "1" && OrdBy == public_str.user_id)
                    {
                        cmd.CommandText = "UPDATE pur01h02 SET status_pur = '" + status_pur + "' + 1, OrdBy_chk = 0 WHERE po_code ='" + tr_code + "'";
                    }
                    else if(status_pur == "2" && OrdBy2 == public_str.user_id)
                    {
                        cmd.CommandText = "UPDATE pur01h02 SET status_pur = '" + status_pur + "', OrdBy_chk = 1 WHERE po_code ='" + tr_code + "'";
                    }
                    else if (status_pur == "2" && AppBy == public_str.user_id)
                    {
                        cmd.CommandText = "UPDATE pur01h02 SET status_pur = '" + status_pur + "' + 1 WHERE po_code ='" + tr_code + "'";
                    }
                }
                else
                {
                    cmd.CommandText = "UPDATE pur01h02 SET status_pur = '" + status_pur + "' + 1 WHERE po_code ='" + tr_code + "'";
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

        protected void chk_overhaul_CheckedChanged(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "UPDATE pur01h02 SET overhaul = '" + (sender as CheckBox).Checked + "', userid='" + public_str.user_id + "', lastupdate=GETDATE() WHERE po_code ='" + tr_code + "'";
            cmd.ExecuteNonQuery();
            con.Close();
        }
    }
}