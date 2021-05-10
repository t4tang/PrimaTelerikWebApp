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

namespace TelerikWebApplication.Form.Fico.Bank.BankPayment
{
    public partial class acc01h03 : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();

        private const int ItemsPerRequest = 10;
        public static string KoRek = null;
        public static string tr_code = null;
        public static string selected_supplier = null;
        public static string selected_currency = null;
        public static string selected_amount = null;
        public static string selected_TotAmount = null;

        DataTable dtValues;
        RadTextBox txt_currency;
        RadNumericTextBox txt_kurs;
        RadTextBox txt_curr2;
        RadNumericTextBox txt_kurs2;
        RadComboBox cb_supplier;
        RadDatePicker dtp_created;
        RadDatePicker dtp_cashed;

        //double kurs = 0;

        public DataTable DetailDtbl()
        {
            dtValues = new DataTable();
            dtValues.Columns.Add("slip_no", typeof(string));
            dtValues.Columns.Add("inv_code", typeof(string));
            dtValues.Columns.Add("fkno", typeof(string));
            dtValues.Columns.Add("pay_amount", typeof(double));
            dtValues.Columns.Add("slip_date", typeof(string));
            dtValues.Columns.Add("remark", typeof(string));
            //dtValues.Columns.Add("Ket", typeof(string));
            dtValues.Columns.Add("dept_code", typeof(string));
            dtValues.Columns.Add("region_code", typeof(string));
            dtValues.Columns.Add("run", typeof(int));

            return dtValues;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lbl_form_name.Text = "Bank Payment Voucher";
                dtp_from.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
                dtp_to.SelectedDate = DateTime.Now;
                cb_bank_prm.SelectedValue = public_str.site;

                tr_code = null;
                Session["action"] = "firstLoad";
                Session["TableDetail"] = null;
                Session["actionDetail"] = null;
                Session["actionHeader"] = null;
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

        #region Param
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
            }
        }

        protected void cb_bank_prm_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
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
        #endregion

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            RadGrid1.DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), cb_bank_prm.SelectedValue);
            RadGrid1.DataBind();
        }

        public DataTable GetDataTable(string fromDate, string toDate, string Bank)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_bank_paymentH";
            cmd.Parameters.AddWithValue("@date", fromDate);
            cmd.Parameters.AddWithValue("@todate", toDate);
            cmd.Parameters.AddWithValue("@KoBank", Bank);
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

        #region Main Grid
        protected void RadGrid1_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            (sender as RadGrid).DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), cb_bank_prm.SelectedValue);
        }

        protected void RadGrid1_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            var SlipNo = ((GridDataItem)e.Item).GetDataKeyValue("slip_no");

            try
            {
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "UPDATE acc01h03 SET userid = @userid, lastupdate = GETDATE(), status = '4' WHERE (slip_no = @slip_no)";
                cmd.Parameters.AddWithValue("@slip_no", SlipNo);
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

        protected void RadGrid1_ItemCreated(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                ImageButton printLink = (ImageButton)e.Item.FindControl("PrintLink");
                printLink.Attributes["href"] = "javascript:void(0);";
                printLink.Attributes["onclick"] = String.Format("return ShowPreview('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["slip_no"], e.Item.ItemIndex);

                //ImageButton journalLink = (ImageButton)e.Item.FindControl("JournalLink");
                //printLink.Attributes["href"] = "javascript:void(0);";
                //printLink.Attributes["onclick"] = String.Format("return ShowPreview('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["slip_no"], e.Item.ItemIndex);
            }
        }

        protected void RadGrid1_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                tr_code = null;
                GridDataItem item = e.Item as GridDataItem;
                string kode = item["slip_no"].Text;

                selected_supplier = item["cust_code"].Text;
                selected_currency = item["cur_code"].Text;
                selected_TotAmount = item["tot_pay"].Text;

                tr_code = kode;

                Session["actionHeader"] = "headerEdit";
                Session["actionDetail"] = null;
            }
        }

        protected void RadGrid1_PreRender(object sender, EventArgs e)
        {
            if (Session["action"].ToString() == "firstLoad")
            {
                if ((sender as RadGrid).MasterTableView.Items.Count > 0)
                    (sender as RadGrid).MasterTableView.Items[0].Selected = true;
                foreach (GridDataItem item in RadGrid1.SelectedItems)
                {
                    foreach (GridDataItem gItem in (sender as RadGrid).SelectedItems)
                    {
                        tr_code = gItem["slip_no"].Text;
                        //selected_KoTrans = gItem["KoTrans"].Text;
                    }
                }
            }
        }

        protected void RadGrid1_SelectedIndexChanged(object sender, EventArgs e)
        {
            foreach (GridDataItem item in RadGrid1.SelectedItems)
            {
                tr_code = item["slip_no"].Text;
                //selected_KoTrans = item["Kotrans"].Text;
            }

            Session["actionEdit"] = "list";
        }
        #endregion

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridEditableItem item = (GridEditableItem)btn.NamingContainer;

            RadTextBox txt_slip_number = (RadTextBox)item.FindControl("txt_slip_number");
            CheckBox chk_posting = (CheckBox)item.FindControl("chk_posting");
            RadComboBox cb_supplier = (RadComboBox)item.FindControl("cb_supplier");
            RadTextBox txt_currency = (RadTextBox)item.FindControl("txt_currency");
            RadNumericTextBox txt_kurs = (RadNumericTextBox)item.FindControl("txt_kurs");
            RadComboBox cb_ref = (RadComboBox)item.FindControl("cb_ref");
            RadComboBox cb_bank = (RadComboBox)item.FindControl("cb_bank");
            RadTextBox txt_curr2 = (RadTextBox)item.FindControl("txt_curr2");
            RadNumericTextBox txt_kurs2 = (RadNumericTextBox)item.FindControl("txt_kurs2");
            RadDatePicker dtp_created = (RadDatePicker)item.FindControl("dtp_created");
            RadTextBox txt_ctrl = (RadTextBox)item.FindControl("txt_ctrl");
            RadDatePicker dtp_cashed = (RadDatePicker)item.FindControl("dtp_cashed");
            RadTextBox txt_giro = (RadTextBox)item.FindControl("txt_giro");
            RadComboBox cb_pre = (RadComboBox)item.FindControl("cb_pre");
            RadComboBox cb_check = (RadComboBox)item.FindControl("cb_check");
            RadComboBox cb_approve = (RadComboBox)item.FindControl("cb_approve");
            RadTextBox txt_remark = (RadTextBox)item.FindControl("txt_remark");

            Button btnCancel = (Button)item.FindControl("btnCancel");
            RadGrid Grid2 = (RadGrid)item.FindControl("RadGrid2");

            long maxNo;
            string run = null;
            string trDate = string.Format("{0:dd/MM/yyyy}", dtp_created.SelectedDate);

            try
            {
                if ((sender as Button).Text == "Update")
                {
                    run = txt_slip_number.Text;
                }
                else
                {
                    con.Open();
                    SqlDataReader sdr;
                    cmd = new SqlCommand("SELECT ISNULL ( MAX ( RIGHT ( acc01h03.slip_no , 4 ) ) , 0 ) + 1 AS maxNo " +
                       "FROM acc01h03 WHERE LEFT(acc01h03.slip_no, 4) ='" + cb_bank.SelectedValue + "' + 'K' " +
                       "AND SUBSTRING(acc01h03.slip_no, 5, 2) = SUBSTRING('" + trDate + "', 9, 2) " +
                       "AND SUBSTRING(acc01h03.slip_no, 7, 2) = SUBSTRING('" + trDate + "', 4, 2) ", con);
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
                cmd.CommandText = "sp_save_bank_paymentH";
                cmd.Parameters.AddWithValue("@slip_no", run);
                cmd.Parameters.AddWithValue("@slip_date", string.Format("{0:yyyy-MM-dd}", dtp_created.SelectedDate.Value));
                cmd.Parameters.AddWithValue("@pay_way", "2");
                //cmd.Parameters.AddWithValue("@accountno", KoRek);
                cmd.Parameters.AddWithValue("@cashbank", cb_bank.SelectedValue);
                cmd.Parameters.AddWithValue("@tgl_cair", string.Format("{0:yyyy-MM-dd}", dtp_cashed.SelectedDate.Value));
                cmd.Parameters.AddWithValue("@cur_code", txt_currency.Text);
                cmd.Parameters.AddWithValue("@kurs", Convert.ToDouble(txt_kurs.Text));
                cmd.Parameters.AddWithValue("@cust_code", cb_supplier.SelectedValue);
                cmd.Parameters.AddWithValue("@userid", public_str.user_id);
                cmd.Parameters.AddWithValue("@lastupdate", DateTime.Today);
                cmd.Parameters.AddWithValue("@Remark", txt_remark.Text);
                cmd.Parameters.AddWithValue("@tot_pay", 0);
                cmd.Parameters.AddWithValue("@status_post", 0);
                cmd.Parameters.AddWithValue("@trans_kind", 1);
                cmd.Parameters.AddWithValue("@tot_pay_idr", 0);
                cmd.Parameters.AddWithValue("@tot_pay_acc", 0);
                cmd.Parameters.AddWithValue("@kurs_acc", Convert.ToDouble(txt_kurs2.Text));
                cmd.Parameters.AddWithValue("@cur_code_acc", txt_curr2.Text);
                cmd.Parameters.AddWithValue("@noctrl", txt_ctrl.Text);
                cmd.Parameters.AddWithValue("@kursBeli", 0);
                cmd.Parameters.AddWithValue("@lvl", public_str.level);
                cmd.Parameters.AddWithValue("@freby", cb_pre.SelectedValue);
                cmd.Parameters.AddWithValue("@ordby", cb_check.SelectedValue);
                cmd.Parameters.AddWithValue("@appby", cb_approve.SelectedValue);
                //cmd.Parameters.AddWithValue("@inf_pay_no", txt_giro.Text);
                //cmd.Parameters.AddWithValue("@remark1", txt.SelectedValue);
                //cmd.Parameters.AddWithValue("@remark2", cb_approved.SelectedValue);
                //cmd.Parameters.AddWithValue("@status", txt_kurs.Text);
                //cmd.Parameters.AddWithValue("@PlantCode", txt_NoCtrl.Text);
                //cmd.Parameters.AddWithValue("@dept_code", txt_NoCtrl.Text);
                //cmd.Parameters.AddWithValue("@NoRef", txt_NoCtrl.Text);
                cmd.ExecuteNonQuery();

                foreach (GridDataItem itemD in Grid2.MasterTableView.Items)
                {
                    Label lbl_NoBuk;
                    Label lbl_inv_code;
                    Label lbl_slip_date;
                    Label lbl_remark;
                    Label lbl_pay_amount;
                    Label lbl_project_detail;
                    Label lbl_cost_ctr;
                    //Label lbl_cost_center;

                    lbl_NoBuk = (Label)itemD.FindControl("lbl_NoBuk");
                    lbl_inv_code = (Label)itemD.FindControl("lbl_inv_code");
                    lbl_slip_date = (Label)itemD.FindControl("lbl_slip_date");
                    lbl_remark = (Label)itemD.FindControl("lbl_remark");
                    lbl_pay_amount = (Label)itemD.FindControl("lbl_pay_amount");
                    lbl_project_detail = (Label)itemD.FindControl("lbl_project_detail");
                    lbl_cost_ctr = (Label)itemD.FindControl("lbl_cost_ctr");
                    //lbl_cost_center = (Label)itemD.FindControl("lbl_cost_center");

                    cmd = new SqlCommand();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Connection = con;
                    cmd.CommandText = "sp_save_Bank_PaymentD";
                    cmd.Parameters.AddWithValue("@slip_no", run);
                    cmd.Parameters.AddWithValue("@inv_code", lbl_NoBuk.Text);
                    cmd.Parameters.AddWithValue("@fkno", lbl_inv_code.Text);
                    //cmd.Parameters.AddWithValue("@slip_date", string.Format("{0:yyyy-MM-dd}", lbl_slip_date.Text));
                    cmd.Parameters.AddWithValue("@remark", lbl_remark.Text);
                    cmd.Parameters.AddWithValue("@pay_amount", Convert.ToDouble(lbl_pay_amount.Text));
                    //cmd.Parameters.AddWithValue("@Ket", lbl_KetD.Text);
                    cmd.Parameters.AddWithValue("@dept_code", lbl_cost_ctr.Text);
                    cmd.Parameters.AddWithValue("@region_code", lbl_project_detail.Text);
                    //cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
                    //cmd.Parameters.AddWithValue("@Owner", public_str.user_id);
                    cmd.ExecuteNonQuery();

                }


            }
            catch (Exception ex)
            {
                con.Close();
                Response.Write("<font color='red'>" + ex.Message + "</font>");
            }
            finally
            {
                con.Close();
                txt_slip_number.Text = run;
                notif.Text = "Data telah disimpan";
                notif.Show();

                if ((sender as Button).Text == "Update")
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind();", true);
                }
                else
                {
                    acc01h03.tr_code = run;
                    //acc01h03.selected_project = cb_project.SelectedValue;
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind('navigateToInserted');", true);
                    (sender as Button).Text = "Update";
                    btnCancel.Text = "Close";
                }

                RadGrid1.MasterTableView.IsItemInserted = false;
            }
        }
    

        #region Supplier
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
            {
                (sender as RadComboBox).SelectedValue = dr["supplier_code"].ToString();
            }
            dr.Close();
            con.Close();
        }

        protected void cb_supplier_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            RadComboBox cb = (RadComboBox)sender;
            GridEditableItem item = (GridEditableItem)cb.NamingContainer;

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
                txt_currency = (RadTextBox)item.FindControl("txt_currency");
                txt_currency.Text = dr["cur_code"].ToString();

                txt_kurs = (RadNumericTextBox)item.FindControl("txt_kurs");
                txt_kurs.Value= Convert.ToDouble(dr["KursRun"].ToString());

                selected_currency = dr["cur_code"].ToString(); 
            }
            dr.Close();
            con.Close();

            selected_supplier = (sender as RadComboBox).SelectedValue;
        }
        #endregion

        #region Bank
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

        protected void cb_bank_PreRender(object sender, EventArgs e)
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
            con.Close();
        }

        protected void cb_bank_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            RadComboBox cb = (RadComboBox)sender;
            GridEditableItem item = (GridEditableItem)cb.NamingContainer;

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
                txt_curr2 = (RadTextBox)item.FindControl("txt_curr2");
                txt_curr2.Text = dr["cur_code"].ToString();

                txt_kurs2 = (RadNumericTextBox)item.FindControl("txt_kurs2");
                txt_kurs2.Value = Convert.ToDouble(dr["KursRun"].ToString());
            }
            dr.Close();
            con.Close();
        }
        #endregion

        #region Approval
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

        protected void cb_pre_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadManPower(e.Text, (sender as RadComboBox));
        }

        protected void cb_pre_DataBound(object sender, EventArgs e) 
        {
            ((Literal)(sender as RadComboBox).Footer.FindControl("RadComboItemsCount")).Text = Convert.ToString((sender as RadComboBox).Items.Count);
        }

        protected void cb_pre_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_pre_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_check_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadManPower(e.Text, (sender as RadComboBox));
        }

        protected void cb_check_DataBound(object sender, EventArgs e)
        {
            ((Literal)(sender as RadComboBox).Footer.FindControl("RadComboItemsCount")).Text = Convert.ToString((sender as RadComboBox).Items.Count);
        }

        protected void cb_check_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_check_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_approve_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadManPower(e.Text, (sender as RadComboBox));
        }

        protected void cb_approve_DataBound(object sender, EventArgs e)
        {
            ((Literal)(sender as RadComboBox).Footer.FindControl("RadComboItemsCount")).Text = Convert.ToString((sender as RadComboBox).Items.Count);
        }

        protected void cb_approve_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_approve_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }
        #endregion

        protected void btnNew_Click(object sender, ImageClickEventArgs e)
        {
            Session["TableDetail"] = null;
            Session["actionHeader"] = "headerNew";
            RadGrid1.MasterTableView.IsItemInserted = true;
            RadGrid1.MasterTableView.Rebind();
        }

        #region Inv Code
        protected void cb_NoBuk_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            string sql = "sp_get_bank_payment_refD";
            SqlDataAdapter adapter = new SqlDataAdapter(sql, ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.CommandType = CommandType.StoredProcedure;
            adapter.SelectCommand.Parameters.AddWithValue("@kosup", selected_supplier);
            adapter.SelectCommand.Parameters.AddWithValue("@komat", selected_currency);
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
                item.Attributes.Add("debt_rema", row["debt_rema"].ToString());

                comboBox.Items.Add(item);

                item.DataBind();
            }
        }

        protected void cb_NoBuk_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            Session["NoBuk"] = e.Value;

            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "SELECT	v_bank_payment_refD.NoFP, v_bank_payment_refD.NoPO, v_bank_payment_refD.Tgl, v_bank_payment_refD.Ket, " +
                                    "v_bank_payment_refD.debt_rema, v_bank_payment_refD.region_code, v_bank_payment_refD.dept_code, v_bank_payment_refD.NoBuk " +
                                    "FROM    v_bank_payment_refD   where v_bank_payment_refD.NoBuk = '" + (sender as RadComboBox).SelectedValue + "'";
                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                foreach (DataRow dtr in dt.Rows)
                {
                    RadComboBox cb = (RadComboBox)sender;
                    GridEditableItem item = (GridEditableItem)cb.NamingContainer;
                    if (Session["actionDetail"].ToString() == "detailNew")
                    {
                        RadTextBox inv_code = (RadTextBox)item.FindControl("txt_invCode_insert");
                        RadTextBox slip_date = (RadTextBox)item.FindControl("dtp_InvDate_insert");
                        RadTextBox remark = (RadTextBox)item.FindControl("txt_remark_insert");
                        RadNumericTextBox amount = (RadNumericTextBox)item.FindControl("txt_amount_insert");
                        RadTextBox project = (RadTextBox)item.FindControl("txt_projectDetail_insert");
                        RadTextBox cost_ctr = (RadTextBox)item.FindControl("txt_CostCenter_insert");

                        inv_code.Text = dtr["NoFP"].ToString();
                        slip_date.Text = dtr["Tgl"].ToString();
                        remark.Text = dtr["ket"].ToString();
                        amount.Text = dtr["debt_rema"].ToString();
                        project.Text = dtr["region_code"].ToString();
                        cost_ctr.Text = dtr["dept_code"].ToString();
                    }
                    else if (Session["actionDetail"].ToString() == "detailEdit")
                    {
                        RadTextBox inv_code = (RadTextBox)item.FindControl("txt_invCode");
                        RadTextBox slip_date = (RadTextBox)item.FindControl("dtp_InvDate");
                        RadTextBox remark = (RadTextBox)item.FindControl("txt_remark");
                        RadNumericTextBox amount = (RadNumericTextBox)item.FindControl("txt_amount");
                        RadTextBox project = (RadTextBox)item.FindControl("txt_projectDetail");
                        RadTextBox cost_ctr = (RadTextBox)item.FindControl("txt_CostCenter");

                        inv_code.Text = dtr["NoFP"].ToString();
                        slip_date.Text = dtr["Tgl"].ToString();
                        remark.Text = dtr["ket"].ToString();
                        amount.Text = dtr["debt_rema"].ToString();
                        project.Text = dtr["region_code"].ToString();
                        cost_ctr.Text = dtr["dept_code"].ToString();
                    }

                    selected_amount = dtr["debt_rema"].ToString();

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

        protected void cb_NoBuk_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT NoBuk FROM v_bank_payment_refD WHERE NoFP = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }
        #endregion

        public DataTable GetDataDetailTable(string SlipNo) 
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT * FROM v_bank_paymentD where slip_no = @slipno";
            cmd.Parameters.AddWithValue("@slipno", SlipNo);
            cmd.CommandTimeout = 0;
            cmd.ExecuteNonQuery();
            sda = new SqlDataAdapter(cmd);

            dtValues = new DataTable();

            try
            {
                sda.Fill(dtValues);
            }
            finally
            {
                con.Close();
            }

            return dtValues;
        }

        #region Ragrid Detail
        protected void RadGrid2_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            if (Session["TableDetail"] == null && Session["actionHeader"].ToString() != "headerEdit") // Insert Session
            {
                (sender as RadGrid).DataSource = new string[] { };
            }
            else
            {
                if (Session["actionHeader"].ToString() == "headerEdit" && Session["actionDetail"] == null)
                {
                    Session["TableDetail"] = null;
                    (sender as RadGrid).DataSource = GetDataDetailTable(tr_code);
                }
                else if (Session["TableDetail"] == null)
                {
                    DetailDtbl();
                }
                else
                {
                    dtValues = (DataTable)Session["TableDetail"];
                }
                (sender as RadGrid).DataSource = dtValues; //populate RadGrid with datatable
                Session["TableDetail"] = dtValues;
            }
        }

        protected void RadGrid2_InsertCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                GridEditableItem item = (GridEditableItem)e.Item;

                //if (Session["actionEdit"].ToString() == "new" && Session["TableDetail"] == null)
                if (Session["actionDetail"].ToString() == "detailNew" && Session["TableDetail"] == null)
                {
                    DetailDtbl();

                    (sender as RadGrid).DataSource = dtValues; //populate RadGrid with datatable
                    Session["TableDetail"] = dtValues;
                }

                dtValues = (DataTable)Session["TableDetail"];
                DataRow drValue = dtValues.NewRow();
                drValue["slip_no"] = tr_code;
                drValue["inv_code"] = (item.FindControl("cb_NoBuk_insert") as RadComboBox).Text;
                drValue["fkno"] = (item.FindControl("txt_invCode_insert") as RadTextBox).Text;
                drValue["slip_date"] = (item.FindControl("dtp_InvDate_insert") as RadTextBox).Text;
                drValue["remark"] = (item.FindControl("txt_remark_insert") as RadTextBox).Text;
                drValue["pay_amount"] = (item.FindControl("txt_amount_insert") as RadNumericTextBox).Text;
                drValue["region_code"] = (item.FindControl("txt_projectDetail_insert") as RadTextBox).Text;
                drValue["dept_code"] = (item.FindControl("txt_CostCenter_insert") as RadTextBox).Text;
                //drValue["run"] = 0;

                dtValues.Rows.Add(drValue); //adding new row into datatable
                dtValues.AcceptChanges();
                Session["TableDetail"] = dtValues;
                (sender as RadGrid).Rebind();
                Session["actionDetail"] = "detailList";

            }
            catch (Exception ex)
            {
                con.Close();
                Label lblError = new Label();
                lblError.Text = "Unable to insert data. Reason: " + ex.Message;
                lblError.ForeColor = System.Drawing.Color.Red;
                (sender as RadGrid).Controls.Add(lblError);
                e.Canceled = true;
            }
        }

        protected void RadGrid2_UpdateCommand(object sender, GridCommandEventArgs e)
        {
            GridEditableItem item = (GridEditableItem)e.Item;

            dtValues = (DataTable)Session["TableDetail"];
            DataRow drValue = dtValues.NewRow();
            drValue["slip_no"] = tr_code;
            drValue["inv_code"] = (item.FindControl("cb_NoBuk") as RadComboBox).Text;
            drValue["fkno"] = (item.FindControl("txt_invCode") as RadTextBox).Text;
            drValue["slip_date"] = (item.FindControl("dtp_InvDate") as RadTextBox).Text;
            drValue["remark"] = (item.FindControl("txt_remark") as RadTextBox).Text;
            drValue["pay_amount"] = (item.FindControl("txt_amount") as RadNumericTextBox).Text;
            drValue["region_code"] = (item.FindControl("txt_projectDetail") as RadTextBox).Text;
            drValue["dept_code"] = (item.FindControl("txt_CostCenter") as RadTextBox).Text;
            //drValue["run"] = 0;

            drValue.EndEdit(); //editing row in datatable
            dtValues.AcceptChanges();
            Session["TableDetail"] = dtValues;
            (sender as RadGrid).Rebind();
        }

        protected void RadGrid2_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            var InvCode = ((GridDataItem)e.Item).GetDataKeyValue("inv_code");

            try
            {
                GridEditableItem item = (GridEditableItem)e.Item;
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "delete from acc01d03 where inv_code = @inv_code and slip_no = @slip_no";
                cmd.Parameters.AddWithValue("@slip_no", InvCode);
                cmd.Parameters.AddWithValue("@inv_code", InvCode);
                cmd.ExecuteNonQuery();
                con.Close();
                (sender as RadGrid).DataBind();

                Label lblsuccess = new Label();
                lblsuccess.Text = "Data deleted";
                lblsuccess.ForeColor = System.Drawing.Color.DarkGray;
                (sender as RadGrid).Controls.Add(lblsuccess);
            }
            catch (Exception ex)
            {
                con.Close();
                Label lblError = new Label();
                lblError.Text = "Unable to delete data. Reason: " + ex.Message;
                lblError.ForeColor = System.Drawing.Color.Red;
                (sender as RadGrid).Controls.Add(lblError);
                e.Canceled = true;
            }
        }

        protected void RadGrid2_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == RadGrid.InitInsertCommandName)
            {
                Session["actionDetail"] = "detailNew";
            }
            else if (e.CommandName == RadGrid.EditCommandName)
            {
                Session["actionDetail"] = "detailEdit";
            }
        }

        protected void RadGrid2_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadGrid).MasterTableView.Items.Count < (sender as RadGrid).MasterTableView.PageSize)
            {
                (sender as RadGrid).ClientSettings.Scrolling.AllowScroll = false;
                (sender as RadGrid).ClientSettings.Scrolling.UseStaticHeaders = false;
            }
            else
            {
                (sender as RadGrid).ClientSettings.Scrolling.AllowScroll = true;
                (sender as RadGrid).ClientSettings.Scrolling.ScrollHeight = 195;
            }
        }

        #endregion

        private void CalculateTotal()
        {
            //double sumValue;
            double sum = 0;
            //double sumTot = 0;

            sum = (Convert.ToDouble(selected_amount));
            selected_TotAmount = sum.ToString();

        }

        protected void RadGrid3_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            if (Session["actionHeader"].ToString() == "headerEdit")
            {
                (sender as RadGrid).DataSource = GetDataJournalTable(tr_code);
            }
            else
            {
                (sender as RadGrid).DataSource = new string[] { };
            }
        }

        public DataTable GetDataJournalTable(string slip_no)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_goods_issued_journal";
            cmd.Parameters.AddWithValue("@doc_code", slip_no);
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

        protected void RadGrid3_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadGrid).MasterTableView.Items.Count < (sender as RadGrid).MasterTableView.PageSize)
            {
                (sender as RadGrid).ClientSettings.Scrolling.AllowScroll = false;
                (sender as RadGrid).ClientSettings.Scrolling.UseStaticHeaders = false;
            }
        }
    }
}