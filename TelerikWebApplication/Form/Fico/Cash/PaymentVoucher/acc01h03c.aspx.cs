﻿using System;
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

namespace TelerikWebApplication.Form.Fico.Cash.PaymentVoucher
{
    public partial class acc01h03c : System.Web.UI.Page
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
                cb_Cash_prm.SelectedValue = public_str.site;

                set_info();
                Session["action"] = "FirstLoad";
                RadGrid2.Enabled = false;
                btnSave.Enabled = false;
                btnSave.ImageUrl = "~/Images/simpan-gray.png";
                btnPrint.Enabled = false;
                btnPrint.ImageUrl = "~/Images/cetak-gray.png";
                dtp_bm.SelectedDate = DateTime.Now;
            }
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

        public DataTable GetDataTable(string fromDate, string toDate, string Cash)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_CashPaymentH";
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

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            RadGrid1.DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), cb_Cash_prm.SelectedValue);
            RadGrid1.DataBind();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            foreach (GridDataItem item in RadGrid1.SelectedItems)
            {
                con.Open();
                SqlDataReader sdr;
                SqlCommand cmd = new SqlCommand("SELECT * FROM v_cash_paymentH WHERE slip_no = '" + item["slip_no"].Text + "'", con);
                sdr = cmd.ExecuteReader();
                if (sdr.Read())
                {
                    txt_slip_no.Text = sdr["slip_no"].ToString();
                    dtp_bm.SelectedDate = Convert.ToDateTime(sdr["slip_date"].ToString());
                    cb_supplier.Text = sdr["supplier_name"].ToString();
                    txt_NoCtrl.Text = sdr["noctrl"].ToString();
                    txt_CurCode.Text = sdr["cur_code"].ToString();
                    txt_kurs.Text = sdr["kurs"].ToString();
                    //cb_ref.Text = sdr["accountname"].ToString();
                    cb_cash.Text = sdr["NamKas"].ToString();
                    txt_CurCode2.Text = sdr["cur_code_acc"].ToString();
                    txt_kurs2.Text = sdr["kurs_acc"].ToString();
                    txt_remark.Text = sdr["Remark"].ToString(); ;
                    cb_Prepared.Text = sdr["FreByName"].ToString(); // Jangan dihapus lagi
                    cb_Checked.Text = sdr["OrdByName"].ToString(); // Jangan dihapus lagi
                    cb_Approval.Text = sdr["AppByName"].ToString(); // Jangan dihapus lagi
                    cb_Prepared.SelectedValue = sdr["freby"].ToString();
                    cb_Checked.SelectedValue = sdr["ordby"].ToString();
                    cb_Approval.SelectedValue = sdr["appby"].ToString();
                    txt_UId.Text = sdr["userid"].ToString();
                    txt_lastupdate.Text = string.Format("{0:dd-MM-yyyy}", sdr["lastupdate"].ToString());
                }
                con.Close();

                RadGrid2.DataSource = GetDataDetailTable(txt_slip_no.Text);
                RadGrid2.DataBind();
                Session["action"] = "edit";
                RadGrid2.Enabled = true;
                btnSave.Enabled = true;
                btnSave.ImageUrl = "~/Images/simpan.png";
                btnPrint.Enabled = true;
                btnPrint.ImageUrl = "~/Images/cetak.png";
                btnPrint.Attributes["OnClick"] = String.Format("return ShowPreview('{0}');", txt_slip_no.Text);

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

        protected void cb_Cash_prm_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetCashCode(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                cb_Cash_prm.Items.Add(new RadComboBoxItem(data.Rows[i]["NamKas"].ToString(), data.Rows[i]["NamKas"].ToString()));
            }
        }

        protected void cb_Cash_prm_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT KoKas FROM acc00h02 WHERE NamKas = '" + cb_Cash_prm.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_Cash_prm.SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();

            //con.Open();
            //SqlCommand cmd = new SqlCommand();
            //cmd.Connection = con;
            //cmd.CommandType = CommandType.Text;
            //cmd.CommandText = "SELECT acc00h02.KoKas, 'IDR'as cur_code, acc00h04.KursRun FROM acc00h02 cross join acc00h04 " +
            //"WHERE acc00h04.tglKurs = (SELECT MAX(tglKurs) FROM acc00h04 WHERE acc00h04.cur_code = 'IDR') AND NamKas = '" + cb_Cash_prm.Text + "'";
            //SqlDataReader dr;
            //dr = cmd.ExecuteReader();
            //while (dr.Read())
            //    cb_Cash_prm.SelectedValue = dr["KoKas"].ToString();
            //dr.Close();

            //SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            //DataTable dt = new DataTable();
            //adapter.Fill(dt);
            //foreach (DataRow dr1 in dt.Rows)
            //{
            //    txt_CurCode2.Text = dr1["cur_code"].ToString();
            //    txt_kurs2.Text = dr1["KursRun"].ToString();
            //}
            //con.Close();
        }

        protected void RadGrid1_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            (sender as RadGrid).DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), cb_Cash_prm.SelectedValue);
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
                cmd.CommandText = "UPDATE acc01h03 SET userid = @userid, lastupdate = GETDATE(), status = '4' WHERE (slip_no = @slip_no)";
                cmd.Parameters.AddWithValue("@slip_no", slip_no);
                cmd.Parameters.AddWithValue("@userid", public_str.user_id);
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
            btnPrint.Enabled = false;
            btnPrint.ImageUrl = "~/Images/cetak-gray.png";
            if (Session["action"].ToString() != "FirstLoad")
            {
                clear_text(Page.Controls);
            }
            set_info();
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

        private void set_info()
        {
            txt_UId.Text = public_str.uid;
            txt_lastupdate.Text = string.Format("{0:dd/MM/yyyy}", DateTime.Now);
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
                else if (ctrl is RadDatePicker)
                    ((RadDatePicker)ctrl).Enabled = state;
                else if (ctrl is RadGrid)
                    ((RadGrid)ctrl).Enabled = state;

                control_status(ctrl.Controls, state);
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
                    run = txt_slip_no.Text;
                }
                else
                {
                    con.Open();
                    SqlDataReader sdr;
                    cmd = new SqlCommand("SELECT ISNULL ( MAX ( RIGHT ( acc01h03.slip_no , 4 ) ) , 0 ) + 1 AS maxNo " +
                        "FROM acc01h03 WHERE LEFT(acc01h03.slip_no, 4) = '" + cb_cash.SelectedValue + "' + 'K' " +
                        "AND SUBSTRING(acc01h03.slip_no, 5, 2) = SUBSTRING('" + trDate + "', 9, 2) " +
                        "AND SUBSTRING(acc01h03.slip_no, 7, 2) = SUBSTRING('" + trDate + "', 4, 2) ", con);
                    sdr = cmd.ExecuteReader();
                    if (sdr.HasRows == false)
                    {
                        //throw new Exception();
                        run = cb_cash.SelectedValue + "K" + dtp_bm.SelectedDate.Value.Year + dtp_bm.SelectedDate.Value.Month + "0001";
                    }
                    else if (sdr.Read())
                    {
                        maxNo = Convert.ToInt32(sdr[0].ToString());
                        run = cb_cash.SelectedValue + "K" + (dtp_bm.SelectedDate.Value.Year.ToString()).Substring(dtp_bm.SelectedDate.Value.Year.ToString().Length - 2) +
                            ("0000" + dtp_bm.SelectedDate.Value.Month).Substring(("0000" + dtp_bm.SelectedDate.Value.Month).Length - 2, 2) +
                            ("0000" + maxNo).Substring(("0000" + maxNo).Length - 4, 4);
                    }
                    con.Close();
                }


                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_save_Cash_PaymentH";
                cmd.Parameters.AddWithValue("@slip_no", run);
                cmd.Parameters.AddWithValue("@slip_date", string.Format("{0:yyyy-MM-dd}", dtp_bm.SelectedDate.Value));
                cmd.Parameters.AddWithValue("@noctrl", txt_NoCtrl.Text);
                cmd.Parameters.AddWithValue("@cust_code", cb_supplier.SelectedValue);
                cmd.Parameters.AddWithValue("@cur_code", txt_CurCode.Text);
                cmd.Parameters.AddWithValue("@kurs", Convert.ToDecimal(txt_kurs.Text));
                cmd.Parameters.AddWithValue("@accountno", cb_ref.SelectedValue);
                cmd.Parameters.AddWithValue("@cashbank", cb_cash.SelectedValue);
                cmd.Parameters.AddWithValue("@cur_code_acc", txt_CurCode2.Text);
                cmd.Parameters.AddWithValue("@kurs_acc", Convert.ToDecimal(txt_kurs2.Text));
                cmd.Parameters.AddWithValue("@Remark", txt_remark.Text);
                cmd.Parameters.AddWithValue("@freby", cb_Prepared.SelectedValue);
                cmd.Parameters.AddWithValue("@ordby", cb_Checked.SelectedValue);
                cmd.Parameters.AddWithValue("@appby", cb_Approval.SelectedValue);
                cmd.Parameters.AddWithValue("@lvl", 1);
                cmd.Parameters.AddWithValue("@userid", txt_UId.Text);
                cmd.Parameters.AddWithValue("@lastupdate", DateTime.Today);
                cmd.Parameters.AddWithValue("@pay_way", 1);
                cmd.Parameters.AddWithValue("@tot_pay", 0);
                cmd.Parameters.AddWithValue("@status_post", 0);
                cmd.Parameters.AddWithValue("@trans_kind", 1);
                cmd.Parameters.AddWithValue("@tot_pay_idr", 0);
                cmd.Parameters.AddWithValue("@tot_pay_acc", 0);
                cmd.Parameters.AddWithValue("@kursBeli", 0);
                cmd.ExecuteNonQuery();

                Label lblsuccess = new Label();
                lblsuccess.Text = "Data saved successfully";
                lblsuccess.ForeColor = System.Drawing.Color.Blue;

                con.Close();

                txt_slip_no.Text = run;
                RadGrid2.Enabled = true;
                btnSave.Enabled = false;
                btnPrint.Enabled = true;
                btnPrint.ImageUrl = "~/Images/cetak.png";
                btnPrint.Attributes["OnClick"] = String.Format("return ShowPreview('{0}');", txt_slip_no.Text);

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
            btnPrint.Attributes["OnClick"] = String.Format("return ShowPreview('{0}');", txt_slip_no.Text);
        }

        private static DataTable GetSupplier(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select cust_code, cust_name from v_customer where cust_name LIKE @text + '%'",
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
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["cust_name"].ToString(), data.Rows[i]["cust_name"].ToString()));
            }
        }

        protected void cb_supplier_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT v_customer.cust_code, v_customer.cust_name, v_customer.cur_code, acc00h04.KursRun AS kurs FROM v_customer cross join acc00h04 " +
                "WHERE acc00h04.tglKurs = (SELECT MAX(tglKurs) FROM acc00h04 WHERE acc00h04.cur_code = v_customer.cur_code) " +
                "AND cust_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["cust_code"].ToString();
            dr.Close();

            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adapter.Fill(dt);
            foreach (DataRow dr1 in dt.Rows)
            {
                txt_CurCode.Text = dr1["cur_code"].ToString();
                txt_kurs.Text = dr1["kurs"].ToString();
            }
            con.Close();
        }

        protected void cb_supplier_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT * FROM v_customer WHERE cust_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["cust_code"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_cash_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetCashCode(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                cb_cash.Items.Add(new RadComboBoxItem(data.Rows[i]["NamKas"].ToString(), data.Rows[i]["NamKas"].ToString()));
            }
        }

        protected void cb_cash_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT * FROM v_cash_paymentH WHERE NamKas = '" + cb_cash.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_cash.SelectedValue = dr["cashbank"].ToString();
            dr.Close();

            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adapter.Fill(dt);
            foreach (DataRow dr1 in dt.Rows)
            {
                txt_CurCode2.Text = dr1["cur_code_acc"].ToString();
                txt_kurs2.Text = dr1["kurs_acc"].ToString();
            }
            con.Close();

        }

        protected void cb_cash_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT * FROM v_cash_paymentH WHERE NamKas = '" + cb_cash.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_cash.SelectedValue = dr["cashbank"].ToString();
            dr.Close();
            con.Close();
        }

        protected void LoadManPower(string name, RadComboBox cb)
        {
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);

            SqlDataAdapter adapter = new SqlDataAdapter("SELECT upper(name) as name, nik, upper(jabatan) as jabatan FROM inv00h26 " +
                "WHERE stedit <> '4' AND name LIKE @text + '%'", con);
            adapter.SelectCommand.Parameters.AddWithValue("@text", name);
            DataTable dt = new DataTable();
            adapter.Fill(dt);

            cb.DataTextField = "name";
            cb.DataValueField = "nik";
            cb.DataSource = dt;
            cb.DataBind();
        }

        protected void cb_Prepared_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            cb_Prepared.Text = "";
            LoadManPower(e.Text, cb_Prepared);
        }

        protected void cb_Prepared_DataBound(object sender, EventArgs e)
        {
            ((Literal)cb_Prepared.Footer.FindControl("RadComboItemsCount")).Text = Convert.ToString((sender as RadComboBox).Items.Count);
        }

        protected void cb_Prepared_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT * FROM inv00h26 WHERE name = '" + cb_Prepared.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_Prepared.SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_Prepared_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT * FROM inv00h26 WHERE name = '" + cb_Prepared.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_Prepared.SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_Checked_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            cb_Checked.Text = "";
            LoadManPower(e.Text, cb_Checked);
        }

        protected void cb_Checked_DataBound(object sender, EventArgs e)
        {
            ((Literal)cb_Checked.Footer.FindControl("RadComboItemsCount")).Text = Convert.ToString((sender as RadComboBox).Items.Count);
        }

        protected void cb_Checked_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT * FROM inv00h26 WHERE name = '" + cb_Checked.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_Checked.SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_Checked_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT * FROM inv00h26 WHERE name = '" + cb_Checked.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_Checked.SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_Approval_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            cb_Approval.Text = "";
            LoadManPower(e.Text, cb_Approval);
        }

        protected void cb_Approval_DataBound(object sender, EventArgs e)
        {
            ((Literal)cb_Approval.Footer.FindControl("RadComboItemsCount")).Text = Convert.ToString((sender as RadComboBox).Items.Count);
        }

        protected void cb_Approval_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT * FROM inv00h26 WHERE name = '" + cb_Approval.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_Approval.SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_Approval_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT * FROM inv00h26 WHERE name = '" + cb_Approval.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_Approval.SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }

        private static DataTable GetAccount(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT accountno, accountname FROM acc00h10 WHERE stEdit != 4 AND accountname LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }

        protected void cb_ref_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetAccount(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                cb_ref.Items.Add(new RadComboBoxItem(data.Rows[i]["accountname"].ToString(), data.Rows[i]["accountname"].ToString()));
            }
        }

        protected void cb_ref_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT accountno FROM acc00h10  WHERE accountname = '" + cb_ref.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_ref.SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_ref_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT accountno FROM acc00h10 WHERE accountname = '" + cb_ref.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_ref.SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }

        public DataTable GetDataDetailTable(string slip_no)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_cashpaymentD";
            cmd.Parameters.AddWithValue("@slip_no", slip_no);
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
            RadGrid2.DataSource = GetDataDetailTable(txt_slip_no.Text);
        }

        protected void RadGrid2_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            var inv_code = ((GridDataItem)e.Item).GetDataKeyValue("inv_code");
            try
            {
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "delete from acc01d03 where inv_code = @inv_code and slip_no = @slip_no";
                cmd.Parameters.AddWithValue("@slip_no", txt_slip_no.Text);
                cmd.Parameters.AddWithValue("@inv_code", inv_code);
                cmd.ExecuteNonQuery();

                con.Close();

                
            }
            catch (Exception ex)
            {
                con.Close();
                Label lblError = new Label();
                lblError.Text = "Unable to delete data. Reason: " + ex.Message;
                lblError.ForeColor = System.Drawing.Color.Red;
                RadGrid2.Controls.Add(lblError);
                e.Canceled = true;
            }
        }

        protected void RadGrid2_SaveHandler(object sender, GridCommandEventArgs e) 
        {
            try
            {
                GridEditableItem item = (GridEditableItem)e.Item;
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_save_Cash_PaymentD";
                cmd.Parameters.AddWithValue("@slip_no", txt_slip_no.Text);
                cmd.Parameters.AddWithValue("@inv_code", (item.FindControl("cb_inv_code") as RadComboBox).Text);
                cmd.Parameters.AddWithValue("@remark", (item.FindControl("txt_remark") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@pay_amount_idr", Convert.ToDouble((item.FindControl("txt_pay_amount") as RadTextBox).Text));
                cmd.Parameters.AddWithValue("@pay_amount_acc", Convert.ToDouble((item.FindControl("txt_pay_amount") as RadTextBox).Text));
                cmd.Parameters.AddWithValue("@pay_amount", Convert.ToDouble((item.FindControl("txt_pay_amount") as RadTextBox).Text));
                cmd.Parameters.AddWithValue("selisih_kurs", 0.00);
                cmd.Parameters.AddWithValue("@region_code", (item.FindControl("cb_Project") as RadComboBox).Text);
                cmd.Parameters.AddWithValue("@dept_code", (item.FindControl("cb_Cost_Center") as RadComboBox).Text);
                cmd.ExecuteNonQuery();
                con.Close();
                RadGrid2.DataBind();
                RadGrid2.Rebind();

                Label lblsuccess = new Label();
                lblsuccess.Text = "Data saved";
                lblsuccess.ForeColor = System.Drawing.Color.DarkGray;
                RadGrid2.Controls.Add(lblsuccess);                             
            }
            catch (Exception ex)
            {
                con.Close();
                Label lblError = new Label();
                lblError.Text = "Unable to insert data. Reason: " + ex.Message;
                lblError.ForeColor = System.Drawing.Color.Red;
                RadGrid2.Controls.Add(lblError);
                e.Canceled = true;
            }
        }

        protected void cb_inv_code_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            //string sql = "SELECT [NoBuk], [NoFP] FROM [acc01h13] where Batal !=4 AND NoFP LIKE @NoFP + '%'";
            string sql = "sp_get_cash_paymentD_reff";
            SqlDataAdapter adapter = new SqlDataAdapter(sql, ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.CommandType = CommandType.StoredProcedure;
            adapter.SelectCommand.Parameters.AddWithValue("@kosup", cb_supplier.SelectedValue);
            adapter.SelectCommand.Parameters.AddWithValue("@komat", txt_CurCode.Text);
            adapter.SelectCommand.Parameters.AddWithValue("@NoFP", e.Text);
            DataTable dt = new DataTable();
            adapter.Fill(dt);

            RadComboBox comboBox = (RadComboBox)sender;
            // Clear the default Item that has been re-created from ViewState at this point.
            comboBox.Items.Clear();

            foreach (DataRow row in dt.Rows)
            {
                RadComboBoxItem item = new RadComboBoxItem();
                item.Text = row["NoBuk"].ToString();
                item.Value = row["NoBuk"].ToString();
                item.Attributes.Add("NoFP", row["NoFP"].ToString());

                comboBox.Items.Add(item);

                item.DataBind();
            }
        }

        protected void cb_inv_code_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT NoBuk FROM acc01h13 WHERE NoFP = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_inv_code_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            Session["NoBuk"] = e.Value;

            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "select acc01h13.NoFP, acc01d03.remark, acc01d03.pay_amount from acc01h13 inner join " +
                                   "acc01d03 ON acc01h13.NoBuk = acc01d03.inv_code where acc01h13.NoBuk = '" + (sender as RadComboBox).SelectedValue + "'";
                SqlDataReader dr;
                dr = cmd.ExecuteReader();
                while (dr.Read())
                    cb_cash.SelectedValue = dr["NoBuk"].ToString();
                dr.Close();

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                foreach (DataRow dr1 in dt.Rows)
                {
                    RadComboBox cb = (RadComboBox)sender;
                    GridEditableItem item = (GridEditableItem)cb.NamingContainer;
                    RadTextBox T_remark = (RadTextBox)item.FindControl("txt_remark");
                    RadTextBox T_Amount = (RadTextBox)item.FindControl("txt_pay_amount");

                    T_remark.Text = dr1["remark"].ToString();
                    T_Amount.Text = dr1["pay_amount"].ToString();
                }
            }

            catch (Exception ex)
            {
                Response.Write("<script language='javascript'>alert('" + ex.Message + "')</script>");
            }
            finally
            {
                con.Close();
            }
        }

        protected void LoadCostCtr(string name, string projectID, RadComboBox cb)
        {
            SqlConnection con = new SqlConnection(
           ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);

            SqlDataAdapter adapter = new SqlDataAdapter("SELECT upper(CostCenter) as code,upper(CostCenterName) as name FROM inv00h11 " +
                "WHERE stEdit <> '4' AND region_code = @project AND CostCenterName LIKE @text + '%'", con);
            adapter.SelectCommand.Parameters.AddWithValue("@project", projectID);
            adapter.SelectCommand.Parameters.AddWithValue("@text", name);
            DataTable dt = new DataTable();
            adapter.Fill(dt);

            // Clear the default Item that has been re-created from ViewState at this point.
            cb.Items.Clear();

            foreach (DataRow row in dt.Rows)
            {
                RadComboBoxItem item = new RadComboBoxItem();
                item.Text = row["code"].ToString();
                item.Value = row["code"].ToString();
                item.Attributes.Add("name", row["name"].ToString());

                cb.Items.Add(item);

                item.DataBind();
            }
        }

        protected void cb_Cost_Center_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            RadComboBox cb = (RadComboBox)sender;
            GridEditableItem itm = (GridEditableItem)cb.NamingContainer;
            RadComboBox C_Project = (RadComboBox)itm.FindControl("cb_Project");

            string sql = "SELECT upper(CostCenter) as code,upper(CostCenterName) as name FROM [inv00h11]  WHERE stEdit != '4' AND CostCenterName LIKE @CostCenterName + '%' AND region_code = @project";
            SqlDataAdapter adapter = new SqlDataAdapter(sql,
                ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@CostCenterName", e.Text);
            adapter.SelectCommand.Parameters.AddWithValue("@project", C_Project.Text);

            DataTable dt = new DataTable();
            adapter.Fill(dt);

            RadComboBox comboBox = (RadComboBox)sender;
            // Clear the default Item that has been re-created from ViewState at this point.
            comboBox.Items.Clear();

            foreach (DataRow row in dt.Rows)
            {
                RadComboBoxItem item = new RadComboBoxItem();
                item.Text = row["code"].ToString();
                item.Value = row["code"].ToString();
                item.Attributes.Add("name", row["name"].ToString());

                comboBox.Items.Add(item);

                item.DataBind();
            }
        }

        protected void cb_Cost_Center_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT CostCenter FROM inv00h11 WHERE CostCenterName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_Project_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            string sql = "SELECT [region_code], [region_name] FROM [inv00h09]  WHERE stEdit != '4' AND region_name LIKE @region_name + '%'";
            SqlDataAdapter adapter = new SqlDataAdapter(sql,
                ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@region_name", e.Text);

            DataTable dt = new DataTable();
            adapter.Fill(dt);

            RadComboBox comboBox = (RadComboBox)sender;
            // Clear the default Item that has been re-created from ViewState at this point.
            comboBox.Items.Clear();

            foreach (DataRow row in dt.Rows)
            {
                RadComboBoxItem item = new RadComboBoxItem();
                item.Text = row["region_code"].ToString();
                item.Value = row["region_code"].ToString();
                item.Attributes.Add("region_name", row["region_name"].ToString());

                comboBox.Items.Add(item);

                item.DataBind();
            }
        }

        protected void cb_Project_PreRender(object sender, EventArgs e)
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

        protected void cb_Project_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            Session["region_code"] = e.Value;

            try
            {

                RadComboBox cb = (RadComboBox)sender;
                GridEditableItem item = (GridEditableItem)cb.NamingContainer;

                RadComboBox cb_CostCtr = (RadComboBox)item.FindControl("cb_Cost_Center");
                LoadCostCtr(cb_CostCtr.Text, (sender as RadComboBox).SelectedValue, cb_CostCtr);

                //}

            }
            catch (Exception ex)
            {
                Response.Write("<script language='javascript'>alert('" + ex.Message + "')</script>");
            }
            finally
            {
                con.Close();
            }
        }

        //protected void INV_Code(string name, RadComboBox cb)
        //{
        //    SqlConnection con = new SqlConnection(
        //   ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);

        //    SqlDataAdapter adapter = new SqlDataAdapter("SELECT upper(NoBuk) as code,upper(NoPO) as name FROM acc01h13 " +
        //        "WHERE Batal <> '4' AND NoPO LIKE @text + '%'", con);
        //    adapter.SelectCommand.Parameters.AddWithValue("@text", name);
        //    DataTable dt = new DataTable();
        //    adapter.Fill(dt);

        //    // Clear the default Item that has been re-created from ViewState at this point.
        //    cb.Items.Clear();

        //    foreach (DataRow row in dt.Rows)
        //    {
        //        RadComboBoxItem item = new RadComboBoxItem();
        //        item.Text = row["code"].ToString();
        //        item.Value = row["code"].ToString();
        //        item.Attributes.Add("name", row["name"].ToString());

        //        cb.Items.Add(item);

        //        item.DataBind();
        //    }
        //}
    }
}