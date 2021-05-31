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

namespace TelerikWebApplication.Form.Fico.Cash.PaymentVoucher
{
    public partial class acc01h03c : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();

        private const int ItemsPerRequest = 10;
        public static string tr_code = null;
        public static string selected_supplier = null;
        public static string selected_currency = null;
        public static string selected_amount = null;
        public static string selected_TotAmount = null;

        DataTable dtValues;
        RadNumericTextBox txt_kurs;
        RadNumericTextBox txt_kurs2;
        RadTextBox txt_CurCode;
        RadTextBox txt_CurCode2;
        RadNumericTextBox txt_total;
        RadNumericTextBox txt_amount;

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
                lbl_form_name.Text = "Cash Payment Voucher";
                dtp_from.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
                dtp_to.SelectedDate = DateTime.Now;
                cb_Cash_prm.SelectedValue = public_str.site;

                //set_info();
                tr_code = null;
                Session["action"] = "firstLoad";
                Session["TableDetail"] = null;
                Session["actionDetail"] = null;
                Session["actionHeader"] = null;

                //txt_amount.Value = 0;
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

        //protected void btnOK_Click(object sender, EventArgs e)
        //{
        //    foreach (GridDataItem item in RadGrid1.SelectedItems)
        //    {
        //        con.Open();
        //        SqlDataReader sdr;
        //        SqlCommand cmd = new SqlCommand("SELECT * FROM v_cash_paymentH WHERE slip_no = '" + item["slip_no"].Text + "'", con);
        //        sdr = cmd.ExecuteReader();
        //        if (sdr.Read())
        //        {
        //            txt_slip_no.Text = sdr["slip_no"].ToString();
        //            dtp_bm.SelectedDate = Convert.ToDateTime(sdr["slip_date"].ToString());
        //            cb_supplier.Text = sdr["supplier_name"].ToString();
        //            txt_NoCtrl.Text = sdr["noctrl"].ToString();
        //            txt_CurCode.Text = sdr["cur_code"].ToString();
        //            txt_kurs.Text = sdr["kurs"].ToString();
        //            //cb_ref.Text = sdr["accountname"].ToString();
        //            cb_cash.Text = sdr["NamKas"].ToString();
        //            txt_CurCode2.Text = sdr["cur_code_acc"].ToString();
        //            txt_kurs2.Text = sdr["kurs_acc"].ToString();
        //            txt_remark.Text = sdr["Remark"].ToString(); ;
        //            cb_Prepared.Text = sdr["FreByName"].ToString(); // Jangan dihapus lagi
        //            cb_Checked.Text = sdr["OrdByName"].ToString(); // Jangan dihapus lagi
        //            cb_Approval.Text = sdr["AppByName"].ToString(); // Jangan dihapus lagi
        //            cb_Prepared.SelectedValue = sdr["freby"].ToString();
        //            cb_Checked.SelectedValue = sdr["ordby"].ToString();
        //            cb_Approval.SelectedValue = sdr["appby"].ToString();
        //            txt_UId.Text = sdr["userid"].ToString();
        //            txt_lastupdate.Text = string.Format("{0:dd-MM-yyyy}", sdr["lastupdate"].ToString());
        //        }
        //        con.Close();

        //        RadGrid2.DataSource = GetDataDetailTable(txt_slip_no.Text);
        //        RadGrid2.DataBind();
        //        Session["action"] = "edit";
        //        RadGrid2.Enabled = true;
        //        btnSave.Enabled = true;
        //        btnSave.ImageUrl = "~/Images/simpan.png";
        //        btnPrint.Enabled = true;
        //        btnPrint.ImageUrl = "~/Images/cetak.png";
        //        btnPrint.Attributes["OnClick"] = String.Format("return ShowPreview('{0}');", txt_slip_no.Text);

        //    }
        //}

        #region Cash Param
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

            
        }
        #endregion

        #region RadGrid1
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

        protected void RadGrid1_SelectedIndexChanged(object sender, EventArgs e)
        {
            foreach (GridDataItem item in RadGrid1.SelectedItems)
            {
                tr_code = item["slip_no"].Text;
                //selected_KoTrans = item["Kotrans"].Text;
            }

            Session["actionEdit"] = "list";
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
                        CalculateTotal(); 
                    }
                }
            }
        }
        #endregion

        protected void btnNew_Click(object sender, ImageClickEventArgs e)
        {
            Session["TableDetail"] = null;
            Session["actionHeader"] = "headerNew";
            RadGrid1.MasterTableView.IsItemInserted = true;
            RadGrid1.MasterTableView.Rebind();
        }

        //private void clear_text(ControlCollection ctrls)
        //{
        //    foreach (Control ctrl in ctrls)
        //    {
        //        if (ctrl is RadTextBox)
        //        {
        //            ((RadTextBox)ctrl).Text = "";
        //        }
        //        else if (ctrl is RadComboBox)
        //            ((RadComboBox)ctrl).Text = "";

        //        clear_text(ctrl.Controls);

        //    }
        //}

        //private void set_info()
        //{
        //    txt_UId.Text = public_str.uid;
        //    txt_lastupdate.Text = string.Format("{0:dd/MM/yyyy}", DateTime.Now);
        //}

        //public void control_status(ControlCollection ctrls, bool state)
        //{
        //    foreach (Control ctrl in ctrls)
        //    {
        //        if (ctrl is RadTextBox)
        //            ((RadTextBox)ctrl).Enabled = state;
        //        if (ctrl is RadComboBox)
        //            ((RadComboBox)ctrl).Enabled = state;
        //        else if (ctrl is DropDownList)
        //            ((DropDownList)ctrl).Enabled = state;
        //        else if (ctrl is RadDatePicker)
        //            ((RadDatePicker)ctrl).Enabled = state;
        //        else if (ctrl is RadGrid)
        //            ((RadGrid)ctrl).Enabled = state;

        //        control_status(ctrl.Controls, state);
        //    }
        //}

        #region Supplier
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
            RadComboBox cb = (RadComboBox)sender;
            GridEditableItem item = (GridEditableItem)cb.NamingContainer;

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
            {
                (sender as RadComboBox).SelectedValue = dr["cust_code"].ToString();
                txt_CurCode = (RadTextBox)item.FindControl("txt_CurCode");
                txt_CurCode.Text = dr["cur_code"].ToString();

                txt_kurs = (RadNumericTextBox)item.FindControl("txt_kurs");  
                txt_kurs.Value = Convert.ToDouble(dr["kurs"].ToString());

                selected_currency = dr["cur_code"].ToString();
            }
            dr.Close();
            con.Close();

            selected_supplier = (sender as RadComboBox).SelectedValue;
        }

        protected void cb_supplier_PreRender(object sender, EventArgs e)
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
            con.Close();
        }
        #endregion

        #region Cash
        private static DataTable GetCash2(string text) 
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT KoKas, NamKas FROM acc00h02 WHERE stEdit != 4 AND NamKas LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }

        protected void cb_cash_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetCash2(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["NamKas"].ToString(), data.Rows[i]["NamKas"].ToString()));
            }
        }

        protected void cb_cash_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            RadComboBox cb = (RadComboBox)sender;
            GridEditableItem item = (GridEditableItem)cb.NamingContainer;

            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT KoKas, NamKas, acc00h10.cur_code, acc00h04.KursRun, acc00h02.KoRek FROM acc00h02, acc00h04, acc00h10 " +
                                "WHERE acc00h04.tglKurs = (SELECT MAX(tglKurs) FROM acc00h04 WHERE cur_code = acc00h10.cur_code) AND acc00h10.accountno = acc00h02.KoRek " +
                                "AND NamKas = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["KoKas"].ToString();
                txt_CurCode2 = (RadTextBox)item.FindControl("txt_CurCode2");
                txt_CurCode2.Text = dr["cur_code"].ToString();

                txt_kurs2 = (RadNumericTextBox)item.FindControl("txt_kurs2");
                txt_kurs2.Value = Convert.ToDouble(dr["KursRun"].ToString());
            }
            dr.Close();
            con.Close();

        }

        protected void cb_cash_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT KoKas, NamKas, acc00h10.cur_code, acc00h04.KursRun, acc00h02.KoRek FROM acc00h02, acc00h04, acc00h10 " +
                                "WHERE acc00h04.tglKurs = (SELECT MAX(tglKurs) FROM acc00h04 WHERE cur_code = acc00h10.cur_code) AND acc00h10.accountno = acc00h02.KoRek " +
                                "AND NamKas = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["KoKas"].ToString();
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

        protected void cb_Prepared_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadManPower(e.Text, (sender as RadComboBox));
        }

        protected void cb_Prepared_DataBound(object sender, EventArgs e)
        {
            ((Literal)(sender as RadComboBox).Footer.FindControl("RadComboItemsCount")).Text = Convert.ToString((sender as RadComboBox).Items.Count);
        }

        protected void cb_Prepared_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
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

        protected void cb_Prepared_PreRender(object sender, EventArgs e)
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

        protected void cb_Checked_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadManPower(e.Text, (sender as RadComboBox));
        }

        protected void cb_Checked_DataBound(object sender, EventArgs e)
        {
            ((Literal)(sender as RadComboBox).Footer.FindControl("RadComboItemsCount")).Text = Convert.ToString((sender as RadComboBox).Items.Count);
        }

        protected void cb_Checked_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
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

        protected void cb_Checked_PreRender(object sender, EventArgs e)
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

        protected void cb_Approval_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadManPower(e.Text, (sender as RadComboBox));
        }

        protected void cb_Approval_DataBound(object sender, EventArgs e)
        {
            ((Literal)(sender as RadComboBox).Footer.FindControl("RadComboItemsCount")).Text = Convert.ToString((sender as RadComboBox).Items.Count);
        }

        protected void cb_Approval_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
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

        protected void cb_Approval_PreRender(object sender, EventArgs e)
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

        #region Reff
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
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["accountname"].ToString(), data.Rows[i]["accountname"].ToString()));
            }
        }

        protected void cb_ref_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT accountno FROM acc00h10  WHERE accountname = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_ref_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT accountno FROM acc00h10 WHERE accountname = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }
        #endregion

        #region RadGrid Detail
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
                drValue["inv_code"] = (item.FindControl("cb_inv_code_insert") as RadComboBox).Text;
                drValue["fkno"] = (item.FindControl("txt_invCode_insert") as RadTextBox).Text;
                drValue["slip_date"] = (item.FindControl("txt_InvDate_insert") as RadTextBox).Text;
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
            drValue["inv_code"] = (item.FindControl("cb_inv_code") as RadComboBox).Text;
            drValue["fkno"] = (item.FindControl("txt_invCode") as RadTextBox).Text;
            drValue["slip_date"] = (item.FindControl("txt_InvDate") as RadTextBox).Text;
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

        #region InvCode
        protected void cb_inv_code_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            //string sql = "SELECT [NoBuk], [NoFP] FROM [acc01h13] where Batal !=4 AND NoFP LIKE @NoFP + '%'";
            string sql = "sp_get_cash_paymentD_reff";
            SqlDataAdapter adapter = new SqlDataAdapter(sql, ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.CommandType = CommandType.StoredProcedure;
            adapter.SelectCommand.Parameters.AddWithValue("@kosup", selected_supplier);
            adapter.SelectCommand.Parameters.AddWithValue("@komat", selected_currency);
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
                item.Attributes.Add("NoPO", row["NoPO"].ToString());
                item.Attributes.Add("Tgl", row["Tgl"].ToString());
                item.Attributes.Add("debt_rema", row["debt_rema"].ToString());
                item.Attributes.Add("ket", row["ket"].ToString());

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
                cmd.CommandText = "SELECT	v_Cash_Payment_refD.NoFP, v_Cash_Payment_refD.NoPO, v_Cash_Payment_refD.Tgl, v_Cash_Payment_refD.Ket, " +
                                    "v_Cash_Payment_refD.debt_rema, v_Cash_Payment_refD.region_code, v_Cash_Payment_refD.dept_code, v_Cash_Payment_refD.NoBuk " +
                                    "FROM    v_Cash_Payment_refD   where v_Cash_Payment_refD.NoBuk = '" + (sender as RadComboBox).SelectedValue + "'";
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
                        RadTextBox slip_date = (RadTextBox)item.FindControl("txt_InvDate_insert");
                        RadTextBox remark = (RadTextBox)item.FindControl("txt_remark_insert");
                        RadNumericTextBox amount = (RadNumericTextBox)item.FindControl("txt_amount_insert");
                        RadTextBox project = (RadTextBox)item.FindControl("txt_projectDetail_insert");
                        RadTextBox cost_ctr = (RadTextBox)item.FindControl("txt_CostCenter_insert");

                        inv_code.Text = dtr["NoFP"].ToString();
                        slip_date.Text = dtr["Tgl"].ToString();
                        remark.Text = dtr["Ket"].ToString();
                        amount.Text = dtr["debt_rema"].ToString();
                        project.Text = dtr["region_code"].ToString();
                        cost_ctr.Text = dtr["dept_code"].ToString();
                    }
                    else if (Session["actionDetail"].ToString() == "detailEdit")
                    {
                        RadTextBox inv_code = (RadTextBox)item.FindControl("txt_invCode");
                        RadTextBox slip_date = (RadTextBox)item.FindControl("txt_InvDate");
                        RadTextBox remark = (RadTextBox)item.FindControl("txt_remark");
                        RadNumericTextBox amount = (RadNumericTextBox)item.FindControl("txt_amount");
                        RadTextBox project = (RadTextBox)item.FindControl("txt_projectDetail");
                        RadTextBox cost_ctr = (RadTextBox)item.FindControl("txt_CostCenter");

                        inv_code.Text = dtr["NoFP"].ToString();
                        slip_date.Text = dtr["Tgl"].ToString();
                        remark.Text = dtr["Ket"].ToString();
                        amount.Text = dtr["debt_rema"].ToString();
                        project.Text = dtr["region_code"].ToString();
                        cost_ctr.Text = dtr["dept_code"].ToString();
                    }

                    selected_amount = dtr["debt_rema"].ToString();
                }

                CalculateTotal();
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
        #endregion

        //protected void LoadCostCtr(string name, string projectID, RadComboBox cb)
        //{
        //    SqlConnection con = new SqlConnection(
        //   ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);

        //    SqlDataAdapter adapter = new SqlDataAdapter("SELECT upper(CostCenter) as code,upper(CostCenterName) as name FROM inv00h11 " +
        //        "WHERE stEdit <> '4' AND region_code = @project AND CostCenterName LIKE @text + '%'", con);
        //    adapter.SelectCommand.Parameters.AddWithValue("@project", projectID);
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

        //protected void cb_Cost_Center_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        //{
        //    RadComboBox cb = (RadComboBox)sender;
        //    GridEditableItem itm = (GridEditableItem)cb.NamingContainer;
        //    RadComboBox C_Project = (RadComboBox)itm.FindControl("cb_Project");

        //    string sql = "SELECT upper(CostCenter) as code,upper(CostCenterName) as name FROM [inv00h11]  WHERE stEdit != '4' AND CostCenterName LIKE @CostCenterName + '%' AND region_code = @project";
        //    SqlDataAdapter adapter = new SqlDataAdapter(sql,
        //        ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
        //    adapter.SelectCommand.Parameters.AddWithValue("@CostCenterName", e.Text);
        //    adapter.SelectCommand.Parameters.AddWithValue("@project", C_Project.Text);

        //    DataTable dt = new DataTable();
        //    adapter.Fill(dt);

        //    RadComboBox comboBox = (RadComboBox)sender;
        //    // Clear the default Item that has been re-created from ViewState at this point.
        //    comboBox.Items.Clear();

        //    foreach (DataRow row in dt.Rows)
        //    {
        //        RadComboBoxItem item = new RadComboBoxItem();
        //        item.Text = row["code"].ToString();
        //        item.Value = row["code"].ToString();
        //        item.Attributes.Add("name", row["name"].ToString());

        //        comboBox.Items.Add(item);

        //        item.DataBind();
        //    }
        //}

        //protected void cb_Cost_Center_PreRender(object sender, EventArgs e)
        //{
        //    con.Open();
        //    SqlCommand cmd = new SqlCommand();
        //    cmd.Connection = con;
        //    cmd.CommandType = CommandType.Text;
        //    cmd.CommandText = "SELECT CostCenter FROM inv00h11 WHERE CostCenterName = '" + (sender as RadComboBox).Text + "'";
        //    SqlDataReader dr;
        //    dr = cmd.ExecuteReader();
        //    while (dr.Read())
        //        (sender as RadComboBox).SelectedValue = dr[0].ToString();
        //    dr.Close();
        //    con.Close();
        //}

        //protected void cb_Project_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        //{
        //    string sql = "SELECT [region_code], [region_name] FROM [inv00h09]  WHERE stEdit != '4' AND region_name LIKE @region_name + '%'";
        //    SqlDataAdapter adapter = new SqlDataAdapter(sql,
        //        ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
        //    adapter.SelectCommand.Parameters.AddWithValue("@region_name", e.Text);

        //    DataTable dt = new DataTable();
        //    adapter.Fill(dt);

        //    RadComboBox comboBox = (RadComboBox)sender;
        //    // Clear the default Item that has been re-created from ViewState at this point.
        //    comboBox.Items.Clear();

        //    foreach (DataRow row in dt.Rows)
        //    {
        //        RadComboBoxItem item = new RadComboBoxItem();
        //        item.Text = row["region_code"].ToString();
        //        item.Value = row["region_code"].ToString();
        //        item.Attributes.Add("region_name", row["region_name"].ToString());

        //        comboBox.Items.Add(item);

        //        item.DataBind();
        //    }
        //}

        //protected void cb_Project_PreRender(object sender, EventArgs e)
        //{
        //    con.Open();
        //    SqlCommand cmd = new SqlCommand();
        //    cmd.Connection = con;
        //    cmd.CommandType = CommandType.Text;
        //    cmd.CommandText = "SELECT region_code FROM inv00h09 WHERE region_name = '" + (sender as RadComboBox).Text + "'";
        //    SqlDataReader dr;
        //    dr = cmd.ExecuteReader();
        //    while (dr.Read())
        //        (sender as RadComboBox).SelectedValue = dr[0].ToString();
        //    dr.Close();
        //    con.Close();
        //}

        //protected void cb_Project_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        //{
        //    Session["region_code"] = e.Value;

        //    try
        //    {

        //        RadComboBox cb = (RadComboBox)sender;
        //        GridEditableItem item = (GridEditableItem)cb.NamingContainer;

        //        RadComboBox cb_CostCtr = (RadComboBox)item.FindControl("cb_Cost_Center");
        //        LoadCostCtr(cb_CostCtr.Text, (sender as RadComboBox).SelectedValue, cb_CostCtr);

        //        //}

        //    }
        //    catch (Exception ex)
        //    {
        //        Response.Write("<script language='javascript'>alert('" + ex.Message + "')</script>");
        //    }
        //    finally
        //    {
        //        con.Close();
        //    }
        //}

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridEditableItem item = (GridEditableItem)btn.NamingContainer;

            RadTextBox txt_slip_no = (RadTextBox)item.FindControl("txt_slip_no");
            RadDatePicker dtp_bm = (RadDatePicker)item.FindControl("dtp_bm");
            RadTextBox txt_NoCtrl = (RadTextBox)item.FindControl("txt_NoCtrl");
            RadComboBox cb_supplier = (RadComboBox)item.FindControl("cb_supplier");
            RadTextBox txt_CurCode = (RadTextBox)item.FindControl("txt_CurCode");
            RadNumericTextBox txt_kurs = (RadNumericTextBox)item.FindControl("txt_kurs");
            RadComboBox cb_ref = (RadComboBox)item.FindControl("cb_ref");
            RadComboBox cb_cash = (RadComboBox)item.FindControl("cb_cash");
            RadTextBox txt_CurCode2 = (RadTextBox)item.FindControl("txt_CurCode2");
            RadNumericTextBox txt_kurs2 = (RadNumericTextBox)item.FindControl("txt_kurs2");
            RadTextBox txt_remark = (RadTextBox)item.FindControl("txt_remark");
            RadComboBox cb_Prepared = (RadComboBox)item.FindControl("cb_Prepared");
            RadComboBox cb_Checked = (RadComboBox)item.FindControl("cb_Checked");
            RadComboBox cb_Approval = (RadComboBox)item.FindControl("cb_Approval");
            //RadComboBox cb_check = (RadComboBox)item.FindControl("cb_check");
            //RadComboBox cb_approve = (RadComboBox)item.FindControl("cb_approve");
            //RadTextBox txt_remark = (RadTextBox)item.FindControl("txt_remark");

            Button btnCancel = (Button)item.FindControl("btnCancel");
            RadGrid Grid2 = (RadGrid)item.FindControl("RadGrid2");

            long maxNo;
            string run = null;
            string trDate = string.Format("{0:dd/MM/yyyy}", dtp_bm.SelectedDate);

            try
            {
                if ((sender as Button).Text == "Update")
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
                        run = cb_cash.SelectedValue + "K" + 
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
                cmd.CommandText = "sp_save_Cash_PaymentH";
                cmd.Parameters.AddWithValue("@slip_no", run);
                cmd.Parameters.AddWithValue("@slip_date", string.Format("{0:yyyy-MM-dd}", dtp_bm.SelectedDate.Value));
                cmd.Parameters.AddWithValue("@noctrl", txt_NoCtrl.Text);
                cmd.Parameters.AddWithValue("@cust_code", cb_supplier.SelectedValue);
                cmd.Parameters.AddWithValue("@cur_code", txt_CurCode.Text);
                cmd.Parameters.AddWithValue("@kurs", Convert.ToDouble(txt_kurs.Text));
                cmd.Parameters.AddWithValue("@accountno", cb_ref.SelectedValue);
                cmd.Parameters.AddWithValue("@cashbank", cb_cash.SelectedValue);
                cmd.Parameters.AddWithValue("@cur_code_acc", txt_CurCode2.Text);
                cmd.Parameters.AddWithValue("@kurs_acc", Convert.ToDouble(txt_kurs2.Text));
                cmd.Parameters.AddWithValue("@Remark", txt_remark.Text);
                cmd.Parameters.AddWithValue("@freby", cb_Prepared.SelectedValue);
                cmd.Parameters.AddWithValue("@ordby", cb_Checked.SelectedValue);
                cmd.Parameters.AddWithValue("@appby", cb_Approval.SelectedValue);
                cmd.Parameters.AddWithValue("@lvl", 1);
                cmd.Parameters.AddWithValue("@userid", public_str.user_id);
                cmd.Parameters.AddWithValue("@lastupdate", DateTime.Today);
                cmd.Parameters.AddWithValue("@pay_way", 1);
                cmd.Parameters.AddWithValue("@tot_pay", txt_total.Text);
                cmd.Parameters.AddWithValue("@status_post", 0);
                cmd.Parameters.AddWithValue("@trans_kind", 1);
                cmd.Parameters.AddWithValue("@tot_pay_idr", 0);
                cmd.Parameters.AddWithValue("@tot_pay_acc", 0);
                cmd.Parameters.AddWithValue("@kursBeli", 0);
                cmd.ExecuteNonQuery();

                foreach (GridDataItem itemD in Grid2.MasterTableView.Items)
                {
                    Label lbl_InvCode;
                    Label lbl_inv_code;
                    Label lbl_slip_date;
                    Label lbl_remark;
                    Label lbl_pay_amount;
                    Label lbl_project_detail;
                    Label lbl_cost_ctr;
                    //Label lbl_cost_center;

                    lbl_InvCode = (Label)itemD.FindControl("lbl_InvCode");
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
                    cmd.CommandText = "sp_save_Cash_PaymentD";
                    cmd.Parameters.AddWithValue("@slip_no", run);
                    cmd.Parameters.AddWithValue("@inv_code", lbl_InvCode.Text);
                    cmd.Parameters.AddWithValue("@fkno", lbl_inv_code.Text);
                    //cmd.Parameters.AddWithValue("@slip_date", string.Format("{0:yyyy-MM-dd}", lbl_slip_date.Text));
                    cmd.Parameters.AddWithValue("@remark", lbl_remark.Text);
                    cmd.Parameters.AddWithValue("@pay_amount", Convert.ToDouble(lbl_pay_amount.Text));
                    cmd.Parameters.AddWithValue("@pay_amount_acc", selected_amount);
                    //cmd.Parameters.AddWithValue("@pay_amount_idr", selected_amount);
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
                txt_slip_no.Text = run;
                notif.Text = "Data telah disimpan";
                notif.Show();

                if ((sender as Button).Text == "Update")
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind();", true);
                }
                else
                {
                    acc01h03c.tr_code = run;
                    //acc01h03.selected_project = cb_project.SelectedValue;
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind('navigateToInserted');", true);
                    (sender as Button).Text = "Update";
                    btnCancel.Text = "Close";
                }

                RadGrid1.MasterTableView.IsItemInserted = false;
            }
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

        private void CalculateTotal()
        {
            //double sumValue;
            double sum = 0;
            //double sumTot = 0;
            
            sum = (Convert.ToDouble(selected_amount));
            selected_TotAmount = sum.ToString();

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