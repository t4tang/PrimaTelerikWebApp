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

namespace TelerikWebApplication.Form.Fico.Bank.Bank_Receipt
{
    public partial class acc01h04b : System.Web.UI.Page
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
                cb_bank_prm.SelectedValue = public_str.site;

                set_info();
                Session["action"] = "Firstload";
                RadGrid2.Enabled = false;
                btnSave.Enabled = false;
                btnSave.ImageUrl = "~/Images/simpan-gray.png";
                btnPrint.Enabled = false;
                btnPrint.ImageUrl = "~/Images/cetak-gray.png";
                dtp_bm.SelectedDate = DateTime.Now;
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            RadGrid1.DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), cb_bank_prm.SelectedValue);
            RadGrid1.DataBind();
        }
        protected void RadGrid1_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            (sender as RadGrid).DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), cb_bank_prm.SelectedValue);
        }

        private static DataTable GetBank(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT KoBank, NamBank FROM acc00h01 WHERE stEdit != 4 AND NamBank LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }

        public DataTable GetDataTable(string fromDate, string toDate, string Bank)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_BankReceiptVoucherH";
            cmd.Parameters.AddWithValue("@date", fromDate);
            cmd.Parameters.AddWithValue("@todate", toDate);
            cmd.Parameters.AddWithValue("@Bank", Bank);
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

        protected void RadAjaxManager1_AjaxRequest(object sender, AjaxRequestEventArgs e)
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

        protected void cb_bank_prm_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetBank(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                cb_bank_prm.Items.Add(new RadComboBoxItem(data.Rows[i]["NamBank"].ToString(), data.Rows[i]["NamBank"].ToString()));
                //cb_bank.Items.Add(new RadComboBoxItem(data.Rows[i]["NamBank"].ToString(), data.Rows[i]["NamBank"].ToString()));
            }
        }

        protected void cb_bank_prm_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT KoBank FROM acc00h01 WHERE NamBank = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }

        protected void btnOk_Click(object sender, EventArgs e)
        {
            foreach (GridDataItem item in RadGrid1.SelectedItems)
            {
                //txt_NoBuk.Text = item["NoBuk"].Text;
                //dtp_bm.SelectedDate = Convert.ToDateTime(item["doc_date"].Text);

                con.Open();
                SqlDataReader sdr;
                SqlCommand cmd = new SqlCommand("SELECT * FROM v_bankmutation_list WHERE NoBuk = '" + item["NoBuk"].Text + "'", con);
                sdr = cmd.ExecuteReader();
                if (sdr.Read())
                {
                    txt_NoBuk.Text = sdr["NoBuk"].ToString();
                    dtp_bm.SelectedDate = Convert.ToDateTime(sdr["Tgl"].ToString());
                    txt_NoCtrl.Text = sdr["NoCtrl"].ToString();
                    txt_NoRef.Text = sdr["NoRef"].ToString();
                    cb_bank.Text = sdr["NamBank"].ToString();
                    cb_project.Text = sdr["cust_name"].ToString();
                    if (sdr["KoTransName"].ToString() == "PENERIMAAN BANK")
                    {
                        cb_KoTrans.Text = "PENERIMAAN BANK";
                    }
                    else
                    {
                        cb_KoTrans.Text = "PENGELUARAN BANK";
                    }

                    cb_prepared.Text = sdr["PreparedBy"].ToString();
                    cb_checked.Text = sdr["CheckedBy"].ToString();
                    cb_approved.Text = sdr["ApprovalBy"].ToString();
                    txt_Ket.Text = sdr["Ket"].ToString();
                    txt_Kontak.Text = sdr["Kontak"].ToString();
                    txt_cur_code.Text = sdr["cur_code"].ToString();
                    txt_kurs.Text = sdr["kurs"].ToString();
                    txt_uid.Text = sdr["Usr"].ToString();
                    txt_LastUpdate.Text = string.Format("{0:dd/MM/yyyy}", sdr["LastUpdate"].ToString());
                    txt_owner.Text = sdr["Owner"].ToString();
                    txt_printed.Text = sdr["Printed"].ToString();
                    txt_edited.Text = sdr["Edited"].ToString();
                }
                con.Close();

                RadGrid2.DataSource = GetDataDetailTable(txt_NoBuk.Text);
                RadGrid2.DataBind();
                RadGrid2.Enabled = true;
                //Session["Proccess"] = "SesEdit";
                Session["action"] = "edit";
                btnSave.Enabled = true;
                btnSave.ImageUrl = "~/Images/simpan.png";
                btnPrint.Enabled = true;
                btnPrint.ImageUrl = "~/Images/cetak.png";
                btnPrint.Attributes["OnClick"] = String.Format("return ShowPreview('{0}');", txt_NoBuk.Text);
            }
        }

        protected void RadGrid1_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            var NoBuk = ((GridDataItem)e.Item).GetDataKeyValue("NoBuk");

            try
            {
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "UPDATE acc01h01 SET Usr = @Usr, LastUpdate = GETDATE(), Batal = '1' WHERE (NoBuk = @NoBuk)";
                cmd.Parameters.AddWithValue("@NoBuk", NoBuk);
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

        protected void btnNew_Click(object sender, ImageClickEventArgs e)
        {
            Session["action"] = "new";
            btnSave.Enabled = true;
            btnSave.ImageUrl = "~/Images/simpan.png";

            RadGrid2.DataSource = new string[] { };
            RadGrid2.DataBind();
            RadGrid2.Enabled = false;
            btnPrint.ImageUrl = "~/Images/cetak-gray.png";
            if (Session["action"].ToString() != "FirstLoad")
            {
                clear_text(Page.Controls);
            }
            set_info();
        }

        private void set_info()
        {
            txt_uid.Text = public_str.uid;
            txt_LastUpdate.Text = string.Format("{0:dd/MM/yyyy}", DateTime.Now);
            txt_owner.Text = public_str.uid;
            txt_printed.Text = "0";
            txt_edited.Text = "0";
        }

        private void clear_text(ControlCollection ctrls)
        {
            foreach (Control ctrl in ctrls)
            {
                if (ctrl is RadTextBox)
                {
                    ((RadTextBox)ctrl).Text = "";
                }
                else if (ctrl is RadComboBox)
                    ((RadComboBox)ctrl).Text = "";

                clear_text(ctrl.Controls);

            }
        }

        protected void btnSave_Click(object sender, ImageClickEventArgs e)
        {
            long maxNo;
            string run = null;
            string trDate = string.Format("{0:dd/MM/yyyy}", dtp_bm.SelectedDate);

            try
            {
                if (Session["action"].ToString() == "edit")
                {
                    run = txt_NoBuk.Text;
                }
                else
                {
                    con.Open();
                    SqlDataReader sdr;
                    cmd = new SqlCommand("SELECT ISNULL ( MAX ( RIGHT ( acc01h01.NoBuk , 4 ) ) , 0 ) + 1 AS maxNo " +
                        "FROM acc01h01 WHERE LEFT(acc01h01.NoBuk, 4) ='" + cb_bank.SelectedValue + "' + '" + cb_KoTrans.SelectedValue + "' " +
                        "AND SUBSTRING(acc01h01.NoBuk, 5, 2) = SUBSTRING('" + trDate + "', 9, 2) " +
                        "AND SUBSTRING(acc01h01.NoBuk, 7, 2) = SUBSTRING('" + trDate + "', 4, 2) ", con);
                    sdr = cmd.ExecuteReader();
                    if (sdr.HasRows == false)
                    {
                        //throw new Exception();
                        run = cb_bank.SelectedValue + cb_KoTrans.SelectedValue + dtp_bm.SelectedDate.Value.Year + dtp_bm.SelectedDate.Value.Month + "0001";
                    }
                    else if (sdr.Read())
                    {
                        maxNo = Convert.ToInt32(sdr[0].ToString());
                        run = cb_bank.SelectedValue + cb_KoTrans.SelectedValue +
                            (dtp_bm.SelectedDate.Value.Year.ToString()).Substring(dtp_bm.SelectedDate.Value.Year.ToString().Length - 2) +
                            ("0000" + dtp_bm.SelectedDate.Value.Month).Substring(("0000" + dtp_bm.SelectedDate.Value.Month).Length - 2, 2) +
                            ("0000" + maxNo).Substring(("0000" + maxNo).Length - 4, 4);
                    }
                    con.Close();
                }

                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_save_BankMutationH";
                cmd.Parameters.AddWithValue("@NoBuk", run);
                cmd.Parameters.AddWithValue("@Tgl", string.Format("{0:yyyy-MM-dd}", dtp_bm.SelectedDate.Value));
                cmd.Parameters.AddWithValue("@KoBank", cb_bank.SelectedValue);
                cmd.Parameters.AddWithValue("@NoCtrl", txt_NoCtrl.Text);
                cmd.Parameters.AddWithValue("@NoRef", txt_NoRef.Text);
                cmd.Parameters.AddWithValue("@KoTrans", cb_KoTrans.SelectedValue);
                cmd.Parameters.AddWithValue("@freby", cb_prepared.SelectedValue);
                cmd.Parameters.AddWithValue("@ordby", cb_checked.SelectedValue);
                cmd.Parameters.AddWithValue("@appby", cb_approved.SelectedValue);
                cmd.Parameters.AddWithValue("@Ket", txt_Ket.Text);
                cmd.Parameters.AddWithValue("@Kontak", txt_Kontak.Text);
                cmd.Parameters.AddWithValue("@Kode", "DB");
                cmd.Parameters.AddWithValue("@Batal", 0);
                cmd.Parameters.AddWithValue("@TValas", 0);
                cmd.Parameters.AddWithValue("@Total", 0);
                cmd.Parameters.AddWithValue("@TSub", 0);
                cmd.Parameters.AddWithValue("@cur_code", txt_cur_code.Text);
                cmd.Parameters.AddWithValue("@kurs", Convert.ToDouble(txt_kurs.Text));
                cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
                //cmd.Parameters.AddWithValue("@LastUpdate", DateTime.Today);
                cmd.Parameters.AddWithValue("@cust_code", public_str.site);
                cmd.Parameters.AddWithValue("@Owner", public_str.user_id);
                cmd.Parameters.AddWithValue("@Printed", 0);
                cmd.Parameters.AddWithValue("@Edited", 0);
                cmd.Parameters.AddWithValue("@Lvl", public_str.level);
                cmd.Parameters.AddWithValue("@Stamp", DateTime.Today);
                cmd.ExecuteNonQuery();

                //Label lblsuccess = new Label();
                //lblsuccess.Text = "Data saved successfully";
                //lblsuccess.ForeColor = System.Drawing.Color.Blue;
                ////RadGrid1.Controls.Add(lblsuccess);
                con.Close();
                txt_NoBuk.Text = run;
                RadGrid2.Enabled = true;
                btnSave.Enabled = false;
                btnPrint.Enabled = true;
                btnPrint.ImageUrl = "~/Images/cetak.png";
                btnPrint.Attributes["OnClick"] = String.Format("return ShowPreview('{0}');", txt_NoBuk.Text);

            }
            catch (Exception ex)
            {
                con.Close();
                Label lblError = new Label();
                lblError.Text = "Unable to save data. Reason: " + ex.Message;
                lblError.ForeColor = System.Drawing.Color.Red;
                //RadGrid1.Controls.Add(lblError);
                //throw;
            }
        }

        protected void btnPrint_Click(object sender, ImageClickEventArgs e)
        {
            btnPrint.Attributes["OnClick"] = String.Format("return ShowPreview('{0}');", txt_NoBuk.Text);
        }

        protected void cb_Cust_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetCust(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["cust_name"].ToString(), data.Rows[i]["cust_name"].ToString()));
            }
        }
            protected void cb_Cust_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select cust_code from acc00h07 WHERE cust_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["cust_code"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_Cust_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select cust_code from acc00h07 WHERE cust_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["cust_code"].ToString();
            dr.Close();
            con.Close();
        }

        private static DataTable GetCust(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select cust_code,cust_name from acc00h07 where stEdit != 4 " +
                " AND cust_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }

        protected void cb_bank_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadBank(e.Text, cb_cust.SelectedValue, (sender as RadComboBox));
        }

        protected void cb_bank_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT acc00h01.*, acc00h04.cur_code,acc00h04.KursRun FROM acc00h01 CROSS JOIN acc00h04 where " +
            " acc00h04.tglKurs = (select MAX(acc00h04.tglKurs) from acc00h04) and NamBank = '" + cb_bank.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["KoBank"].ToString();
            dr.Close();

            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adapter.Fill(dt);
            foreach (DataRow dr1 in dt.Rows)
            {


                txt_cur_code.Text = dr1["cur_code"].ToString();
                txt_kurs.Text = dr1["KursRun"].ToString();

            }
            con.Close();
        }

        protected void cb_bank_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT KoBank FROM acc00h01 WHERE NamBank = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["KoBank"].ToString();
            dr.Close();
            con.Close();
        }
    }
}