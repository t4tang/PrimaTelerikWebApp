using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using TelerikWebApplication.Class;

namespace TelerikWebApplication.Form.Fico.Ledger.OpeningBalance
{
    public partial class acc00h11 : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                RadGrid1.DataSource = "";
                RadGrid1.DataBind();

                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "SELECT ThnAwal - 1 FROM inv00h15";
                SqlDataReader dr;
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    cb_year.Text = dr[0].ToString();
                    cb_year.SelectedValue = dr[0].ToString();
                }

                dr.Close();
                con.Close();
            }
            
        }

        protected void RadGrid1_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            (sender as RadGrid).DataSource = GetDataTable(cb_year.Text);
            //(sender as RadGrid).DataSource = "";
        }
        public DataTable GetDataTable(String periode)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;

            cmd.CommandText = "SELECT acc00h11.account_no, acc00h11.month, acc00h11.year, acc00h12.balance, acc00h10.cur_code,  " +
                              "acc00h10.accountname,acc00h11.yearmonth, acc00h11.sl_credit_usd, acc00h11.sl_credit_idr, " +
                              "acc00h11.sl_debet_usd, acc00h11.sl_debet_idr, acc00h11.kurs " +
                              "FROM  acc00h11 INNER JOIN acc00h10 ON acc00h11.account_no = acc00h10.accountno INNER JOIN " +
                              "acc00h12 ON acc00h10.accountgroup = acc00h12.accountgroup " +
                              "WHERE  (acc00h11.month = 12)  " +
                              "AND (acc00h11.year = " + periode + ") " +
                              "ORDER BY acc00h11.account_no";
            //"WHERE  (acc00h11.month = MONTH(DATEADD(MONTH, DATEDIFF(MONTH, 0, '" + periode + "'), -1)))  " +
            //"AND (acc00h11.year = YEAR(DATEADD(MONTH, DATEDIFF(MONTH, 0, '" + periode + "'), -1))) " +
            //"ORDER BY acc00h11.account_no";

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

        protected void cb_year_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT DISTINCT(year) FROM acc00h11 WHERE YEAR != (SELECT ThnAwal FROM inv00h15)";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {                
                (sender as RadComboBox).Items.Add(dr[0].ToString());
            }

            dr.Close();
            con.Close();
        }
               
        protected void btnNew_Click(object sender, ImageClickEventArgs e)
        {
            RadGrid1.DataSource = GetDataTable(cb_year.Text);
            RadGrid1.DataBind();
            btnNew.Enabled = false;
            btnNew.ImageUrl = "~/Images/tambah-gray.png";
            btnCancel.Enabled = true;
            btnCancel.ImageUrl = "~/Images/Undo.png";
        }

        protected void btnCancel_Click(object sender, ImageClickEventArgs e)
        {
            RadGrid1.DataSource = "";
            RadGrid1.DataBind();
            btnNew.Enabled = true;
            btnNew.ImageUrl = "~/Images/tambah.png";
            btnCancel.Enabled = false;
            btnCancel.ImageUrl = "~/Images/undo-gray.png";
        }

        protected void txt_kurs_TextChanged(object sender, EventArgs e)
        {
            if (sender is RadTextBox)
            {
                RadTextBox tb = (RadTextBox)sender;
                GridEditableItem item = (GridEditableItem)tb.NamingContainer;
                RadTextBox tb_kurs = (RadTextBox)item.FindControl("txt_kurs");
                RadTextBox tb_dbt = (RadTextBox)item.FindControl("txt_debet");
                RadTextBox tb_cdt = (RadTextBox)item.FindControl("txt_credit");
                RadLabel lb_blc = (RadLabel)item.FindControl("lbl_balance");

                if (lb_blc.Text == "D")
                {
                    RadLabel tb_debet_valas = (RadLabel)item.FindControl("lbl_debet_valas");
                    tb_debet_valas.Text = (double.Parse(tb_dbt.Text) * double.Parse(tb_kurs.Text)).ToString();
                }
                else
                {
                    RadLabel tb_credit_valas = (RadLabel)item.FindControl("lbl_credit_valas");
                    tb_credit_valas.Text = (double.Parse(tb_cdt.Text) * double.Parse(tb_kurs.Text)).ToString();
                }
                                
            }
        }

        protected void txt_debet_TextChanged(object sender, EventArgs e)
        {
            if (sender is RadTextBox)
            {
                RadTextBox tb = (RadTextBox)sender;
                GridEditableItem item = (GridEditableItem)tb.NamingContainer;
                RadTextBox tb_kurs = (RadTextBox)item.FindControl("txt_kurs");
                RadLabel tb_debet_valas = (RadLabel)item.FindControl("lbl_debet_valas");
                tb_debet_valas.Text =(double.Parse(tb.Text) * double.Parse(tb_kurs.Text)).ToString();
            }
        }

        protected void txt_credit_TextChanged(object sender, EventArgs e)
        {
            if (sender is RadTextBox)
            {
                RadTextBox tb = (RadTextBox)sender;
                GridEditableItem item = (GridEditableItem)tb.NamingContainer;
                RadTextBox tb_kurs = (RadTextBox)item.FindControl("txt_kurs");
                RadLabel tb_credit_valas = (RadLabel)item.FindControl("lbl_credit_valas");
                tb_credit_valas.Text = (double.Parse(tb.Text) * double.Parse(tb_kurs.Text)).ToString();
            }
        }

        protected void RadGrid1_UpdateCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                GridEditableItem item = (GridEditableItem)e.Item;
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "UPDATE acc00h11 SET sl_debet_idr = @sa_debet_idr, sl_credit_idr = @sa_credit_idr, kurs = @kurs, " +
                "sl_debet_usd = @sa_debet_usd, sl_credit_usd = @sa_credit_usd WHERE(account_no = @account_no) AND(month = @month) AND(year = @year) ";
                cmd.Parameters.AddWithValue("@sa_debet_idr", Convert.ToDecimal((item.FindControl("txt_debet") as RadTextBox).Text));
                cmd.Parameters.AddWithValue("@sa_credit_idr", Convert.ToDecimal((item.FindControl("txt_credit") as RadTextBox).Text));
                cmd.Parameters.AddWithValue("@kurs", Convert.ToDecimal((item.FindControl("txt_kurs") as RadTextBox).Text));
                cmd.Parameters.AddWithValue("@sa_debet_usd", Convert.ToDecimal((item.FindControl("lbl_debet_valas") as RadLabel).Text));
                cmd.Parameters.AddWithValue("@sa_credit_usd", Convert.ToDecimal((item.FindControl("lbl_credit_valas") as RadLabel).Text));
                cmd.Parameters.AddWithValue("@account_no", (item.FindControl("lbl_account") as RadLabel).Text);
                cmd.Parameters.AddWithValue("@month", 12);
                cmd.Parameters.AddWithValue("@year", Convert.ToInt32(cb_year.SelectedValue));
                cmd.ExecuteNonQuery();
                con.Close();
                RadGrid1.DataBind();
                RadGrid1.Rebind();

                Label lblsuccess = new Label();
                lblsuccess.Text = "Data saved";
                lblsuccess.ForeColor = System.Drawing.Color.DarkGray;
                RadGrid1.Controls.Add(lblsuccess);
            }
            catch (Exception ex)
            {
                con.Close();
                Label lblError = new Label();
                lblError.Text = "Unable to update data. Reason: " + ex.Message;
                lblError.ForeColor = System.Drawing.Color.Red;
                RadGrid1.Controls.Add(lblError);
                e.Canceled = true;
            }
        }
    }
}