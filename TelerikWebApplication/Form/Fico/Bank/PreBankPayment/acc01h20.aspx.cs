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

namespace TelerikWebApplication.Form.Fico.Bank.PreBankPayment
{
    public partial class acc01h20 : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();
        private const int ItemsPerRequest = 10;
        public static string KoRek = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                dtp_from.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
                dtp_to.SelectedDate = DateTime.Now;
                cb_bank_prm.SelectedValue = public_str.site;

                set_info();
                Session["action"] = "firstLoad";
                RadGrid2.Enabled = false;
                btnSave.Enabled = false;
                btnSave.ImageUrl = "~/Images/simpan-gray.png";
                btnPrint.Enabled = false;
                btnPrint.ImageUrl = "~/Images/cetak-gray.png";
                btnJournal.Enabled = false;
                btnJournal.ImageUrl = "~/Images/ledger-gray.png";
                dtp_created.SelectedDate = DateTime.Now;
            }
        }

        private void set_info()
        {
            txt_user.Text = public_str.uid;
            txt_lastupdate.Text = string.Format("{0:dd/MM/yyyy}", DateTime.Now);
            //txt.Text = public_str.uid;
            //txt_printed.Text = "0";
            //txt_edited.Text = "0";
        }
        protected void RadAjaxManager1_AjaxRequest(object sender, Telerik.Web.UI.AjaxRequestEventArgs e)
        {
            if (e.Argument == "Rebind")
            {
                RadGrid2.MasterTableView.SortExpressions.Clear();
                RadGrid2.MasterTableView.GroupByExpressions.Clear();
                RadGrid2.Rebind();
            }
            else if (e.Argument == "RebindAndNavigate")
            {
                RadGrid2.MasterTableView.SortExpressions.Clear();
                RadGrid2.MasterTableView.GroupByExpressions.Clear();
                RadGrid2.MasterTableView.CurrentPageIndex = RadGrid1.MasterTableView.PageCount - 1;
                RadGrid2.Rebind();
            }
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
        protected void cb_bank_prm_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetBank(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                cb_bank_prm.Items.Add(new RadComboBoxItem(data.Rows[i]["NamBank"].ToString(), data.Rows[i]["NamBank"].ToString()));
                cb_bank.Items.Add(new RadComboBoxItem(data.Rows[i]["NamBank"].ToString(), data.Rows[i]["NamBank"].ToString()));
            }
        }

        protected void cb_bank_prm_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT KoBank FROM acc00h01 WHERE NamBank = '" + cb_bank_prm.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_bank_prm.SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }

         public DataTable GetDataTable(string fromDate, string toDate, string kobank)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_prebank_paymentH";
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
        protected void RadGrid1_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            (sender as RadGrid).DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), cb_bank_prm.SelectedValue);
        }

        protected void RadGrid1_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            var slip_no = ((GridDataItem)e.Item).GetDataKeyValue("slip_no");
            try
            {
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "UPDATE acc01h20 SET userid = @userid, lastupdate = GETDATE(), stEdit = '4' WHERE (slip_no = @slip_no)";
                cmd.Parameters.AddWithValue("@KoBank", slip_no);
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

        public void control_status(ControlCollection ctrls, bool state)
        {
            foreach (Control ctrl in ctrls)
            {
                if (ctrl is RadTextBox)
                    ((RadTextBox)ctrl).Enabled = state;
                if (ctrl is RadComboBox)
                    ((RadComboBox)ctrl).Enabled = state;
                else if (ctrl is DropDownList)
                    ((DropDownList)ctrl).Enabled = state;
                else if (ctrl is CheckBox)
                    ((CheckBox)ctrl).Enabled = state;
                else if (ctrl is RadDatePicker)
                    ((RadDatePicker)ctrl).Enabled = state;

                control_status(ctrl.Controls, state);
            }
        }

        private void clear_text(ControlCollection ctrls)
        {
            foreach (Control ctrl in ctrls)
            {
                if (ctrl is RadTextBox)
                {
                    ((RadTextBox)ctrl).Text = string.Empty;

                }
                if (ctrl is RadComboBox)
                    ((RadComboBox)ctrl).Text = string.Empty;
            }
        }
        protected void btnNew_Click(object sender, ImageClickEventArgs e)
        {
            btnSave.Enabled = true;
            btnSave.ImageUrl = "~/Images/simpan.png";

            RadGrid2.DataSource = new string[] { };
            RadGrid2.DataBind();
            RadGrid2.Enabled = false;
            btnPrint.Enabled = false;
            btnPrint.ImageUrl = "~/Images/cetak-gray.png";
            btnJournal.Enabled = false;
            btnJournal.ImageUrl = "~/Images/ledger-gray.png";
            if (Session["action"].ToString() != "firstLoad")
            {
                clear_text(Page.Controls);
            }
            set_info();
            Session["action"] = "new";
        }

        protected void btnSave_Click(object sender, ImageClickEventArgs e)
        {
            long maxNo;
            string run = null;
            string trDate = string.Format("{0:dd/MM/yyyy}", dtp_created.SelectedDate);

            try
            {
                if (Session["action"].ToString() == "edit")
                {
                    run = txt_slip_number.Text;
                }
                else
                {
                    con.Open();
                    SqlDataReader sdr;
                    cmd = new SqlCommand("SELECT ISNULL ( MAX ( RIGHT ( acc01h01.NoBuk , 4 ) ) , 0 ) + 1 AS maxNo " +
                       "FROM acc01h01 WHERE LEFT(acc01h01.NoBuk, 4) ='" + cb_bank.SelectedValue + "' + 'K' " +
                       "AND SUBSTRING(acc01h01.NoBuk, 5, 2) = SUBSTRING('" + trDate + "', 9, 2) " +
                       "AND SUBSTRING(acc01h01.NoBuk, 7, 2) = SUBSTRING('" + trDate + "', 4, 2) ", con);
                    sdr = cmd.ExecuteReader();
                    if (sdr.HasRows == false)
                    {
                        //throw new Exception();
                        run = cb_bank.SelectedValue + "K" + dtp_created.SelectedDate.Value.Year + dtp_created.SelectedDate.Value.Month + "0001";
                    }
                    else if (sdr.Read())
                    {
                        maxNo = Convert.ToInt32(sdr[0].ToString());
                        run = cb_bank.SelectedValue + "K" +
                            (dtp_created.SelectedDate.Value.Year.ToString()).Substring(dtp_created.SelectedDate.Value.Year.ToString().Length - 2) +
                            ("0000" + dtp_created.SelectedDate.Value.Month).Substring(("0000" + dtp_created.SelectedDate.Value.Month).Length - 2, 2) +
                            ("0000" + maxNo).Substring(("0000" + maxNo).Length - 4, 4);
                    }
                    con.Close();
                }

                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_save_prebank_paymentH";
                cmd.Parameters.AddWithValue("@slip_no", run);
                cmd.Parameters.AddWithValue("@slip_date", string.Format("{0:yyyy-MM-dd}", dtp_created.SelectedDate.Value));
                cmd.Parameters.AddWithValue("@pay_way", "2");
                cmd.Parameters.AddWithValue("@inf_pay_no", txt_giro.Text);
                cmd.Parameters.AddWithValue("@accountno", KoRek);
                cmd.Parameters.AddWithValue("@cashbank", cb_bank.SelectedValue);
                cmd.Parameters.AddWithValue("@tgl_cair", string.Format("{0:yyyy-MM-dd}", dtp_cashed.SelectedDate.Value));
                //cmd.Parameters.AddWithValue("@remark1", txt.SelectedValue);
                //cmd.Parameters.AddWithValue("@remark2", cb_approved.SelectedValue);
                cmd.Parameters.AddWithValue("@cur_code", txt_currency.Text);
                cmd.Parameters.AddWithValue("@kurs", Convert.ToDecimal(txt_kurs.Text));
                cmd.Parameters.AddWithValue("@cust_code", cb_supplier.SelectedValue);
                //cmd.Parameters.AddWithValue("@status", txt_kurs.Text);
                cmd.Parameters.AddWithValue("@userid", txt_user.Text);
                cmd.Parameters.AddWithValue("@lastupdate", DateTime.Today);
                cmd.Parameters.AddWithValue("@Remark", txt_remark.Text);
                cmd.Parameters.AddWithValue("@tot_pay", 0);
                cmd.Parameters.AddWithValue("@status_post", 0);
                cmd.Parameters.AddWithValue("@trans_kind", 1);
                cmd.Parameters.AddWithValue("@tot_pay_idr", 0);
                cmd.Parameters.AddWithValue("@tot_pay_acc", 0);
                cmd.Parameters.AddWithValue("@kurs_acc", Convert.ToDecimal(txt_kurs2.Text));
                cmd.Parameters.AddWithValue("@cur_code_acc", txt_curr2.Text);
                //cmd.Parameters.AddWithValue("@PlantCode", txt_NoCtrl.Text);
                cmd.Parameters.AddWithValue("@noctrl", txt_ctrl.Text);
                cmd.Parameters.AddWithValue("@kursBeli", 0);
                //cmd.Parameters.AddWithValue("@dept_code", txt_NoCtrl.Text);
                cmd.Parameters.AddWithValue("@lvl", public_str.level);
                cmd.Parameters.AddWithValue("@freby", cb_pre.SelectedValue);
                cmd.Parameters.AddWithValue("@ordby", cb_check.SelectedValue);
                cmd.Parameters.AddWithValue("@appby", cb_approve.SelectedValue);
                //cmd.Parameters.AddWithValue("@NoRef", txt_NoCtrl.Text);
                cmd.ExecuteNonQuery();

                //Label lblsuccess = new Label();
                //lblsuccess.Text = "Data saved successfully";
                //lblsuccess.ForeColor = System.Drawing.Color.Blue;
                //RadGrid1.Controls.Add(lblsuccess);
                txt_slip_number.Text = run;
                RadGrid2.Enabled = true;
                btnSave.Enabled = false;
                btnPrint.Enabled = true;
                btnPrint.ImageUrl = "~/Images/cetak.png";
                btnJournal.Enabled = true;
                btnJournal.ImageUrl = "~/Images/ledger.png";
                btnPrint.Attributes["OnClick"] = String.Format("return ShowPreview('{0}');", txt_slip_number.Text);
                btnJournal.Attributes["OnClick"] = String.Format("return ShowJournal('{0}');", txt_slip_number.Text);
                con.Close();
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
            btnPrint.Attributes["OnClick"] = String.Format("return ShowPreview('{0}');", txt_slip_number.Text);
        }

        protected void btnJournal_Click(object sender, ImageClickEventArgs e)
        {
            btnJournal.Attributes["OnClick"] = String.Format("return ShowJournal('{0}');", txt_slip_number.Text);
        }

        private static DataTable GetSupplier(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT supplier_code, supplier_name FROM pur00h01 WHERE supplier_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_supplier_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetSupplier(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["supplier_name"].ToString(), data.Rows[i]["supplier_name"].ToString()));
            }
        }

        protected void cb_supplier_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT supplier_code, supplier_name, pur00h01.cur_code, acc00h04.KursRun FROM pur00h01, acc00h04 " +
            "WHERE acc00h04.tglKurs = (SELECT MAX(tglKurs) FROM acc00h04 WHERE cur_code = pur00h01.cur_code) AND supplier_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["supplier_code"].ToString();
            }
            dr.Close();

            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adapter.Fill(dt);
            foreach (DataRow dr1 in dt.Rows)
            {
                txt_currency.Text = dr1["cur_code"].ToString();
                txt_kurs.Text = dr1["KursRun"].ToString();
            }
            con.Close();
        }

        protected void cb_supplier_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT supplier_code, supplier_name, pur00h01.cur_code, acc00h04.KursRun FROM pur00h01, acc00h04 " +
            "WHERE acc00h04.tglKurs = (SELECT MAX(tglKurs) FROM acc00h04 WHERE cur_code = pur00h01.cur_code) AND supplier_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["supplier_code"].ToString();
            dr.Close();

            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adapter.Fill(dt);
            foreach (DataRow dr1 in dt.Rows)
            {
                txt_currency.Text = dr1["cur_code"].ToString();
                txt_kurs.Text = dr1["KursRun"].ToString();
            }
            con.Close();
        }

        private static DataTable GetBank2(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT KoBank, NamBank FROM acc00h01 WHERE stEdit != 4 AND NamBank LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_bank_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetBank2(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["NamBank"].ToString(), data.Rows[i]["NamBank"].ToString()));
            }
        }

        protected void cb_bank_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            //cmd.CommandText = "select KoBank from acc00h01 WHERE NamBank = '" + (sender as RadComboBox).Text + "'";
            cmd.CommandText = "SELECT KoBank, NamBank, acc00h10.cur_code, acc00h04.KursRun, acc00h01.KoRek FROM acc00h01, acc00h04, acc00h10 " +
           "WHERE acc00h04.tglKurs = (SELECT MAX(tglKurs) FROM acc00h04 WHERE cur_code = acc00h10.cur_code) AND acc00h10.accountno = acc00h01.KoRek " +
           "AND NamBank = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["KoBank"].ToString();
            }
            dr.Close();

            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adapter.Fill(dt);
            foreach (DataRow dr1 in dt.Rows)
            {
                txt_curr2.Text = dr1["cur_code"].ToString();
                txt_kurs2.Text = dr1["KursRun"].ToString();
                KoRek = dr1["KoRek"].ToString();
            }
            con.Close();
        }

        protected void cb_bank_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT KoBank, NamBank, acc00h10.cur_code, acc00h04.KursRun, acc00h01.KoRek FROM acc00h01, acc00h04, acc00h10 " +
            "WHERE acc00h04.tglKurs = (SELECT MAX(tglKurs) FROM acc00h04 WHERE cur_code = acc00h10.cur_code) AND acc00h10.accountno = acc00h01.KoRek " +
            "AND NamBank = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["KoBank"].ToString();
            }

            dr.Close();

            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adapter.Fill(dt);
            foreach (DataRow dr1 in dt.Rows)
            {
                txt_curr2.Text = dr1["cur_code"].ToString();
                txt_kurs2.Text = dr1["KursRun"].ToString();
                KoRek = dr1["KoRek"].ToString();
            }
            con.Close();
        }

        private static DataTable GetUsers(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT Nik, Name from inv00h26 WHERE stEdit != 4 AND Name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void txt_pre_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetUsers(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["Name"].ToString(), data.Rows[i]["Name"].ToString()));
            }
        }

        protected void txt_pre_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT Nik FROM inv00h26 WHERE Name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["Nik"].ToString();
            dr.Close();
            con.Close();
        }

        protected void txt_pre_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT Nik FROM inv00h26 WHERE Name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["Nik"].ToString();
            dr.Close();
            con.Close();
        }

        protected void btnFind_Click(object sender, EventArgs e)
        {
            RadGrid1.DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), cb_bank_prm.SelectedValue);
            RadGrid1.DataBind();
        }

        protected void btnOk_Click(object sender, EventArgs e)
        {
            foreach (GridDataItem item in RadGrid1.SelectedItems)
            {
                //txt_ur_number.Text = item["doc_code"].Text;
                //dtp_ur.SelectedDate = Convert.ToDateTime(item["doc_date"].Text);

                con.Open();
                SqlDataReader sdr;
                SqlCommand cmd = new SqlCommand("SELECT * FROM v_prebank_paymentH WHERE slip_no = '" + item["slip_no"].Text + "'", con);
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
                    txt_giro.Text = sdr["inf_pay_no"].ToString();
                }
                con.Close();

                RadGrid2.DataSource = GetDataDetailTable(txt_slip_number.Text);
                RadGrid2.DataBind();
                //RadGrid2.DataSourceID = "SqlDataSource1";
                //SqlDataSource1.DataBind();
                RadGrid2.Enabled = true;
                Session["action"] = "edit";
                btnSave.Enabled = true;
                btnSave.ImageUrl = "~/Images/simpan.png";
                btnPrint.Enabled = true;
                btnPrint.ImageUrl = "~/Images/cetak.png";
                btnJournal.Enabled = true;
                btnJournal.ImageUrl = "~/Images/ledger.png";
                btnPrint.Attributes["OnClick"] = String.Format("return ShowPreview('{0}');", txt_slip_number.Text);
                btnJournal.Attributes["OnClick"] = String.Format("return ShowJournal('{0}');", txt_slip_number.Text);
            }

        }
        public DataTable GetDataDetailTable(string slip_no)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT * FROM v_prebank_paymentD where slip_no = @slipno";
            cmd.Parameters.AddWithValue("@slipno", slip_no);
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

        protected void RadGrid2_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            (sender as RadGrid).DataSource = GetDataDetailTable(txt_slip_number.Text);
        }
        protected void cb_NoBuk_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_bank_payment_refD";
            cmd.Parameters.AddWithValue("@kosup", cb_supplier.SelectedValue);
            cmd.Parameters.AddWithValue("@komat", txt_currency.Text);
            cmd.CommandTimeout = 0;
            cmd.ExecuteNonQuery();
            sda = new SqlDataAdapter(cmd);

            DataTable dt = new DataTable();
            sda.Fill(dt);

            RadComboBox comboBox = (RadComboBox)sender;
            comboBox.Items.Clear();

            foreach (DataRow row in dt.Rows)
            {
                RadComboBoxItem item = new RadComboBoxItem();
                item.Text = row["NoBuk"].ToString();
                item.Value = row["NoBuk"].ToString();
                item.Attributes.Add("NoFP", row["NoFP"].ToString());
                item.Attributes.Add("debt_rema", row["debt_rema"].ToString());
                item.Attributes.Add("ket", row["ket"].ToString());

                comboBox.Items.Add(item);

                item.DataBind();
            }
            con.Close();
        }

        protected void cb_NoBuk_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT NoFP, Tgl, ket, debt_rema, dept_code, region_code FROM v_bank_payment_refD WHERE NoBuk = '" + (sender as RadComboBox).SelectedValue + "'";

            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adapter.Fill(dt);
            foreach (DataRow dtr in dt.Rows)
            {
                RadComboBox cb = (RadComboBox)sender;
                GridEditableItem item = (GridEditableItem)cb.NamingContainer;
                Label inv_code = (Label)item.FindControl("lbl_inv_code");
                Label slip_date = (Label)item.FindControl("lbl_slip_date");
                RadTextBox remark = (RadTextBox)item.FindControl("txt_remark");
                RadTextBox amount = (RadTextBox)item.FindControl("txt_amount");
                Label project = (Label)item.FindControl("lbl_project_detail");
                Label cost_ctr = (Label)item.FindControl("lbl_cost_ctr");

                inv_code.Text = dtr["NoFP"].ToString();
                slip_date.Text = dtr["Tgl"].ToString();
                remark.Text = dtr["ket"].ToString();
                amount.Text = dtr["debt_rema"].ToString();
                project.Text = dtr["region_code"].ToString();
                cost_ctr.Text = dtr["dept_code"].ToString();
            }
        }

       
    }
}