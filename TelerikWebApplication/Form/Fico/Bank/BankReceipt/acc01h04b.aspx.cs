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
                dtp_lm.SelectedDate = DateTime.Now;
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
                //txt_slip_no.Text = item["slip_no"].Text;
                //dtp_bm.SelectedDate = Convert.ToDateTime(item["doc_date"].Text);

                con.Open();
                SqlDataReader sdr;
                SqlCommand cmd = new SqlCommand("SELECT * FROM v_bankreceiptvoucher_list WHERE slip_no = '" + item["slip_no"].Text + "'", con);
                sdr = cmd.ExecuteReader();
                if (sdr.Read())
                {
                    txt_slip_no.Text = sdr["slip_no"].ToString();
                    dtp_bm.SelectedDate = Convert.ToDateTime(sdr["slip_date"].ToString());
                    dtp_lm.SelectedDate = Convert.ToDateTime(sdr["tgl_cair"].ToString());
                    txt_NoCtrl.Text = sdr["noctrl"].ToString();
                    cb_bank.Text = sdr["NamBank"].ToString();
                    cb_Cust.Text = sdr["cust_name"].ToString(); 
                    cb_prepared.Text = sdr["PreparedBy"].ToString();
                    cb_checked.Text = sdr["CheckedBy"].ToString();
                    cb_approved.Text = sdr["ApprovalBy"].ToString();
                    txt_cur_code.Text = sdr["cur_code"].ToString();
                    txt_kurs.Text = sdr["kurs"].ToString();
                    txt_cur_code_acc.Text = sdr["cur_code_acc"].ToString();
                    txt_kurs_acc.Text = sdr["kurs_acc"].ToString();
                    txt_inf_pay_no.Text = sdr["inf_pay_no"].ToString();
                    txt_Remark.Text = sdr["Remark"].ToString();
                    txt_uid.Text = sdr["Usr"].ToString();
                    txt_LastUpdate.Text = string.Format("{0:dd/MM/yyyy}", sdr["LastUpdate"].ToString());
                    txt_owner.Text = sdr["Owner"].ToString();
                    txt_printed.Text = sdr["Printed"].ToString();
                    txt_edited.Text = sdr["Edited"].ToString();
                }
                con.Close();

                RadGrid2.DataSource = GetDataDetailTable(txt_slip_no.Text);
                RadGrid2.DataBind();
                RadGrid2.Enabled = true;
                //Session["Proccess"] = "SesEdit";
                Session["action"] = "edit";
                btnSave.Enabled = true;
                btnSave.ImageUrl = "~/Images/simpan.png";
                btnPrint.Enabled = true;
                btnPrint.ImageUrl = "~/Images/cetak.png";
                btnPrint.Attributes["OnClick"] = String.Format("return ShowPreview('{0}');", txt_slip_no.Text);
            }
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
                cmd.CommandText = "UPDATE acc01h01 SET Usr = @Usr, LastUpdate = GETDATE(), Batal = '1' WHERE (slip_no = @slip_no)";
                cmd.Parameters.AddWithValue("@slip_no", slip_no);
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
                    run = txt_slip_no.Text;
                }
                else
                {
                    con.Open();
                    SqlDataReader sdr;
                    cmd = new SqlCommand("SELECT ISNULL ( MAX ( RIGHT ( acc01h01.slip_no , 4 ) ) , 0 ) + 1 AS maxNo " +
                        "FROM acc01h01 WHERE LEFT(acc01h01.slip_no, 4) ='" + cb_bank.SelectedValue + "' + '" + "M" + "' " +
                        "AND SUBSTRING(acc01h01.slip_no, 5, 2) = SUBSTRING('" + trDate + "', 9, 2) " +
                        "AND SUBSTRING(acc01h01.slip_no, 7, 2) = SUBSTRING('" + trDate + "', 4, 2) ", con);
                    sdr = cmd.ExecuteReader();
                    if (sdr.HasRows == false)
                    {
                        //throw new Exception();
                        run = cb_bank.SelectedValue + "M" + dtp_bm.SelectedDate.Value.Year + dtp_bm.SelectedDate.Value.Month + "0001";
                    }
                    else if (sdr.Read())
                    {
                        maxNo = Convert.ToInt32(sdr[0].ToString());
                        run = cb_bank.SelectedValue + "M" +
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
                cmd.CommandText = "sp_save_BankReceiptVoucherH";
                cmd.Parameters.AddWithValue("@slip_no", run);
                cmd.Parameters.AddWithValue("@slip_date", string.Format("{0:yyyy-MM-dd}", dtp_bm.SelectedDate.Value));
                cmd.Parameters.AddWithValue("@tgl_cair", string.Format("{0:yyyy-MM-dd}", dtp_lm.SelectedDate.Value));
                cmd.Parameters.AddWithValue("@cashbank", cb_bank.SelectedValue);
                cmd.Parameters.AddWithValue("@noctrl", txt_NoCtrl.Text);
                cmd.Parameters.AddWithValue("@cust_code", cb_Cust.SelectedValue);
                cmd.Parameters.AddWithValue("@remark1", cb_Cust.SelectedValue);
                cmd.Parameters.AddWithValue("@freby", cb_prepared.SelectedValue);
                cmd.Parameters.AddWithValue("@ordby", cb_checked.SelectedValue);
                cmd.Parameters.AddWithValue("@appby", cb_approved.SelectedValue);
                cmd.Parameters.AddWithValue("@Remark", txt_Remark.Text);
                cmd.Parameters.AddWithValue("@inf_pay_no", txt_inf_pay_no.Text);
                cmd.Parameters.AddWithValue("@status", 1);
                cmd.Parameters.AddWithValue("@cur_code", txt_cur_code.Text);
                cmd.Parameters.AddWithValue("@kurs", Convert.ToDouble(txt_kurs.Text));
                cmd.Parameters.AddWithValue("@cur_code_acc", txt_cur_code_acc.Text);
                cmd.Parameters.AddWithValue("@kurs_acc", Convert.ToDouble(txt_kurs_acc.Text));
                cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
                //cmd.Parameters.AddWithValue("@LastUpdate", DateTime.Today);
               
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
            //update status jadi 3
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

            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adapter.Fill(dt);
            foreach (DataRow dr1 in dt.Rows)
            {
                txt_cur_code.Text = dr1["cur_code"].ToString();
                txt_kurs.Text = dr1["kurs"].ToString();

            }
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
            DataTable data = GetBank(e.Text);

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
            cmd.CommandText = "SELECT acc00h01.*, acc00h04.cur_code,acc00h04.KursRun FROM acc00h01 CROSS JOIN acc00h04 where " +
            " acc00h04.slip_dateKurs = (select MAX(acc00h04.slip_dateKurs) from acc00h04) and NamBank = '" + cb_bank.Text + "'";
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
                txt_cur_code_acc.Text = dr1["cur_code_acc"].ToString();
                txt_kurs_acc.Text = dr1["kurs_acc"].ToString();

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

        private static DataTable GetManpower(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select nik,name from inv00h26 where stEdit != 4 " +
                " AND name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_prepared_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetManpower(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["name"].ToString(), data.Rows[i]["name"].ToString()));
            }
        }

        protected void cb_prepared_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + cb_prepared.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_prepared.SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_prepared_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + cb_prepared.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_prepared.SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_checked_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetManpower(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["name"].ToString(), data.Rows[i]["name"].ToString()));
            }
        }

        protected void cb_checked_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + cb_checked.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_checked.SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_checked_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + cb_checked.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_checked.SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_approved_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetManpower(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["name"].ToString(), data.Rows[i]["name"].ToString()));
            }
        }

        protected void cb_approved_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + cb_approved.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_approved.SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_approved_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + cb_approved.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_approved.SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }

        protected void RadGrid2_save_handler(object sender, GridCommandEventArgs e)
        {
            try
            {
                GridEditableItem item = (GridEditableItem)e.Item;
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_save_BankMutationD";
                cmd.Parameters.AddWithValue("@slip_no", txt_slip_no.Text);
                cmd.Parameters.AddWithValue("@KoRek", (item.FindControl("cb_korek") as RadComboBox).Text);
                cmd.Parameters.AddWithValue("@kurs", Convert.ToDouble((item.FindControl("txt_kurs") as RadTextBox).Text));
                cmd.Parameters.AddWithValue("@Jumlah", Convert.ToDouble((item.FindControl("txt_Jumlah") as RadTextBox).Text));
                cmd.Parameters.AddWithValue("@mutasi", (item.FindControl("cb_mutasi") as RadComboBox).Text);
                cmd.Parameters.AddWithValue("@Ket", (item.FindControl("txt_Ket") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@dept_code", (item.FindControl("cb_cost_center") as RadComboBox).Text);
                cmd.Parameters.AddWithValue("@region_code", (item.FindControl("cb_project_detail") as RadComboBox).Text);
                //cmd.Parameters.AddWithValue("@Valas", Convert.ToDouble((item.FindControl("txt_kurs") as RadTextBox).Text));
                cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
                cmd.Parameters.AddWithValue("@Owner", public_str.user_id);
                //cmd.Parameters.AddWithValue("@Stamp", DateTime.Today);
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
        protected void RadGrid2_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            RadGrid2.DataSource = GetDataDetailTable(txt_slip_no.Text);
        }

        public DataTable GetDataDetailTable(string slip_no)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_BankReceiptVoucherD";
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
        protected void RadGrid2_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            var KoRek = ((GridDataItem)e.Item).GetDataKeyValue("KoRek");

            try
            {
                GridEditableItem item = (GridEditableItem)e.Item;
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "delete from acc01d01 where KoRek = @KoRek and slip_no = @slip_no";
                cmd.Parameters.AddWithValue("@slip_no", txt_slip_no.Text);
                cmd.Parameters.AddWithValue("@KoRek", KoRek);
                cmd.ExecuteNonQuery();
                con.Close();
                RadGrid2.DataBind();

                Label lblsuccess = new Label();
                lblsuccess.Text = "Data deleted";
                lblsuccess.ForeColor = System.Drawing.Color.DarkGray;
                RadGrid2.Controls.Add(lblsuccess);
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

        private static DataTable GetInv(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select inv_code,date, cur_code, Net from sls01h01 where stEdit != 4 " +
                " AND name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_inv_code_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetInv(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["inv_code"].ToString(), data.Rows[i]["inv_code"].ToString()));
            }
        }

        protected void cb_inv_code_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            Session["inv_code"] = e.Value;

            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "SELECT date, Net, kurs, kurs_tax, region_code, dept_code, remark FROM sls01h01 WHERE inv_code = '" + (sender as RadComboBox).SelectedValue + "'";

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                foreach (DataRow dtr in dt.Rows)
                {
                    RadComboBox cb = (RadComboBox)sender;
                    GridEditableItem item = (GridEditableItem)cb.NamingContainer;
                    RadTextBox t_date = (RadTextBox)item.FindControl("txt_date");
                    RadTextBox t_Net = (RadTextBox)item.FindControl("txt_Net");
                    RadTextBox t_kurs_tax = (RadTextBox)item.FindControl("txt_kurs_tax");
                    RadTextBox t_kurs = (RadTextBox)item.FindControl("txt_kurs");
                    RadComboBox t_region_code = (RadComboBox)item.FindControl("region_code");
                    RadComboBox t_dept_code = (RadComboBox)item.FindControl("dept_code");
                    RadComboBox t_remark = (RadComboBox)item.FindControl("remark");

                    t_date.Text = txt_date.Text;
                    t_Net.Text = txt_Net.Text;
                    t_kurs_tax.Text = txt_kurs_tax.Text;
                    t_kurs.Text = txt_kurs.Text;
                    t_region_code.Text = txt_region_code.Text;
                    t_dept_code.Text = txt_dept_code.Text;
                    t_remark.Text = txt_remark.Text;
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

        protected void cb_inv_code_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT inv_code FROM sls01h01 WHERE inv_code = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }
    }
}