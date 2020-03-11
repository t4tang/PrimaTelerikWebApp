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

namespace TelerikWebApplication.Form.Fico.Cash.CashMutation
{
    public partial class acc01h02 : System.Web.UI.Page
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
                cb_cash.SelectedValue = public_str.site;

                Session["Proccess"] = "SesNew";
                dtp_exe.SelectedDate = DateTime.Now;
            }
        }

        private static DataTable GetCashCode(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT KoKas, NamKas FROM acc00h02 WHERE stEdit != 4 AND NamKas LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_cashmutation_prm_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetCashCode(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["NamKas"].ToString(), data.Rows[i]["NamKas"].ToString()));                
            }
        }

        protected void cb_cashmutation_prm_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT KoKas FROM acc00h02 WHERE NamKas = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }

        private static DataTable GetProject(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT region_code, region_name FROM inv00h09 WHERE stEdit != 4 AND region_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_cash_project_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT region_code FROM inv00h09 WHERE region_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_cash_project_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT region_code FROM inv00h09 WHERE region_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_cash_project_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetProject(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["region_name"].ToString(), data.Rows[i]["region_name"].ToString()));
            }
        }

        protected void RadAjaxManager1_AjaxRequest(object sender, Telerik.Web.UI.AjaxRequestEventArgs e)
        {
            if (e.Argument == "Rebind")
            {
                RadGrid1.MasterTableView.SortExpressions.Clear();
                RadGrid1.MasterTableView.GroupByExpressions.Clear();
                RadGrid1.Rebind();
            }
            else if (e.Argument == "RebindAndNavigate")
            {
                RadGrid1.MasterTableView.SortExpressions.Clear();
                RadGrid1.MasterTableView.GroupByExpressions.Clear();
                RadGrid1.MasterTableView.CurrentPageIndex = RadGrid1.MasterTableView.PageCount - 1;
                RadGrid1.Rebind();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            RadGrid1.DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), cb_cashmutation_prm.SelectedValue);
            RadGrid1.DataBind();
        }
        protected void RadGrid1_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            (sender as RadGrid).DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), cb_cashmutation_prm.SelectedValue);
        }
        public DataTable GetDataTable(string fromDate, string toDate, string Cash)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_cash_mutasiH";
            cmd.Parameters.AddWithValue("@date", fromDate);
            cmd.Parameters.AddWithValue("@todate", toDate);
            cmd.Parameters.AddWithValue("@Cash", Cash);
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

        protected void RadGrid1_DeleteCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            var NoBuk = ((GridDataItem)e.Item).GetDataKeyValue("NoBuk");
            try
            {
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "UPDATE acc01h02 SET Usr = @Usr, Stamp = GETDATE(), Batal = '1' WHERE (NoBuk = @NoBuk)";
                cmd.Parameters.AddWithValue("@KoKas", NoBuk);
                cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
                cmd.ExecuteNonQuery();
                con.Close();

                Label lblOk = new Label();
                lblOk.Text = "Data deleted successfully";
                lblOk.ForeColor = System.Drawing.Color.Teal;
                RadGrid1.Controls.Add(lblOk);
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

        protected void btnOk_Click(object sender, EventArgs e)
        {
            foreach (GridDataItem item in RadGrid1.SelectedItems)
            {
                con.Open();
                SqlDataReader sdr;
                SqlCommand cmd = new SqlCommand("SELECT * FROM v_cash_mutasi_list WHERE NoBuk = '" + item["NoBuk"].Text + "'", con);
                sdr = cmd.ExecuteReader();
                if (sdr.Read())
                {
                    txt_reg_no.Text = sdr["NoBuk"].ToString();
                    dtp_exe.SelectedDate = Convert.ToDateTime(sdr["Tgl"].ToString());
                    txt_NoCtrl.Text = sdr["NoCtrl"].ToString();
                    txt_NoRef.Text = sdr["NoRef"].ToString();
                    cb_trans.Text = sdr["KoTrans"].ToString();
                    cb_cash_project.Text = sdr["region_name"].ToString();
                    cb_cash.Text = sdr["KoKas"].ToString();
                    txt_cur_code.Text = sdr["cur_code"].ToString();
                    nu_kurs.Text = sdr["kurs"].ToString();
                    txt_remark.Text = sdr["Ket"].ToString();
                    txt_fromto.Text = sdr["Kontak"].ToString();
                    cb_prepare.Text = sdr["freby"].ToString();
                    cb_checked.Text = sdr["ordby"].ToString();
                    cb_aproval.Text = sdr["appby"].ToString();
                }
                con.Close();

                RadGrid2.DataSource = GetDataDetailTable(txt_reg_no.Text);
                RadGrid2.DataBind();
                Session["action"] = "edit";
                RadGrid2.Enabled = true;
            }
        }
        protected void RadGrid2_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            RadGrid2.DataSource = GetDataDetailTable("");
        }
        public DataTable GetDataDetailTable(string NoBuk)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_cashmutasiD";
            cmd.Parameters.AddWithValue("@NoBuk", NoBuk);
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

        protected void btnSave_Click(object sender, ImageClickEventArgs e)
        {
            long maxNo;
            string run = null;
            string trDate = string.Format("{0:dd/MM/yyyy}", dtp_exe.SelectedDate);

            try
            {
                if (Session["Proccess"].ToString() == "SesEdit")
                {
                    run = txt_reg_no.Text;
                }
                else
                {
                    con.Open();
                    SqlDataReader sdr;
                    cmd = new SqlCommand("SELECT ISNULL ( MAX ( RIGHT ( acc01h02.NoBuk , 4 ) ) , 0 ) + 1 AS maxNo " +
                        "FROM acc01h02 WHERE LEFT(acc01h02.NoBuk, 4) = 'UR01' " +
                        "AND SUBSTRING(acc01h02.NoBuk, 5, 2) = SUBSTRING('" + trDate + "', 9, 2) " +
                        "AND SUBSTRING(acc01h02.NoBuk, 7, 2) = SUBSTRING('" + trDate + "', 4, 2) ", con);
                    sdr = cmd.ExecuteReader();
                    if (sdr.HasRows == false)
                    {
                        //throw new Exception();
                        run = "UR01" + dtp_exe.SelectedDate.Value.Year + dtp_exe.SelectedDate.Value.Month + "0001";
                    }
                    else if (sdr.Read())
                    {
                        maxNo = Convert.ToInt32(sdr[0].ToString());
                        run = "UR01" + (dtp_exe.SelectedDate.Value.Year.ToString()).Substring(dtp_exe.SelectedDate.Value.Year.ToString().Length - 2) +
                            ("0000" + dtp_exe.SelectedDate.Value.Month).Substring(("0000" + dtp_exe.SelectedDate.Value.Month).Length - 2, 2) +
                            ("0000" + maxNo).Substring(("0000" + maxNo).Length - 4, 4);
                    }
                    con.Close();
                }

                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_save_cash_mutasiH";
                cmd.Parameters.AddWithValue("@NoBuk", run);
                cmd.Parameters.AddWithValue("@Tgl", string.Format("{0:yyyy-MM-dd}", dtp_exe.SelectedDate.Value));
                cmd.Parameters.AddWithValue("@NoCtrl", txt_NoCtrl.Text);
                cmd.Parameters.AddWithValue("@NoRef", txt_NoRef.Text);
                cmd.Parameters.AddWithValue("@KoTrans", cb_trans.SelectedValue);
                cmd.Parameters.AddWithValue("@KoKas", cb_cash.SelectedValue);
                cmd.Parameters.AddWithValue("@cur_code", txt_cur_code.Text);
                cmd.Parameters.AddWithValue("@kurs", nu_kurs.Text);
                cmd.Parameters.AddWithValue("@Kontak", txt_fromto.Text);
                cmd.Parameters.AddWithValue("@region_code", public_str.site);
                cmd.Parameters.AddWithValue("@dept_code", public_str.site);
                cmd.Parameters.AddWithValue("@Ket", txt_remark.Text);
                cmd.Parameters.AddWithValue("@freby", cb_prepare.SelectedValue);
                //cmd.Parameters.AddWithValue("@OwnStamp", DateTime.Today);
                cmd.Parameters.AddWithValue("@ordby", cb_checked.SelectedValue);
                cmd.Parameters.AddWithValue("@appby", cb_aproval.SelectedValue);
                cmd.Parameters.AddWithValue("@Lvl", public_str.level);
                cmd.ExecuteNonQuery();

                Label lblsuccess = new Label();
                lblsuccess.Text = "Data saved successfully";
                lblsuccess.ForeColor = System.Drawing.Color.Blue;
                //RadGrid1.Controls.Add(lblsuccess);
                con.Close();

                txt_reg_no.Text = run;
                RadGrid2.Enabled = true;
            }
            catch (Exception ex)
            {
                con.Close();
                Label lblError = new Label();
                lblError.Text = "Unable to save data. Reason: " + ex.Message;
                lblError.ForeColor = System.Drawing.Color.Red;
                //RadGrid1.Controls.Add(lblError);
                throw;
            }
        }

        protected void cb_trans_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadComboBox).Text == "Penerimaan Kas")
            {
                (sender as RadComboBox).SelectedValue = "D";
            }
            else if ((sender as RadComboBox).Text == "Pengeluaran Kas")
            {
                (sender as RadComboBox).SelectedValue = "K";
            }
        }

        protected void cb_trans_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Add("Penerimaan Kas");
            (sender as RadComboBox).Items.Add("Pengeluaran Kas");
        }

        protected void cb_trans_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if ((sender as RadComboBox).Text == "Penerimaan Kas")
            {
                (sender as RadComboBox).SelectedValue = "D";
            }
            else if ((sender as RadComboBox).Text == "Pengeluaran Kas")
            {
                (sender as RadComboBox).SelectedValue = "K";
            }
        }

        protected void RadGrid2_InsertCommand(object sender, GridCommandEventArgs e)
        {

        }

        
    }
}