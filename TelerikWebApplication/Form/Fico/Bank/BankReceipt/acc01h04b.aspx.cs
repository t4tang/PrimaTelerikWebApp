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
        public static string KoRek = null;
        public static string tr_code = null;
        public static string selected_customer = null; 
        public static string selected_currency = null;
        public static string selected_amount = null;
        public static string selected_TotAmount = null;
        public static string selected_bank = null;

        DataTable dtValues;
        RadNumericTextBox txt_kurs;
        RadComboBox cb_Cust;
        RadDatePicker dtp_bm;
        RadTextBox txt_cur_code;
        RadTextBox txt_cur_code_acc;
        RadNumericTextBox txt_kurs_acc;

        public DataTable DetailDtbl()
        {
            dtValues = new DataTable();
            dtValues.Columns.Add("slip_no", typeof(string));
            dtValues.Columns.Add("inv_code", typeof(string));
            dtValues.Columns.Add("date", typeof(string));
            dtValues.Columns.Add("pay_amount", typeof(double));
            dtValues.Columns.Add("kurs", typeof(string));
            dtValues.Columns.Add("kurs_tax", typeof(string));
            //dtValues.Columns.Add("Ket", typeof(string));
            dtValues.Columns.Add("dept_code", typeof(string));
            dtValues.Columns.Add("region_code", typeof(string));
            dtValues.Columns.Add("remark", typeof(string));
            dtValues.Columns.Add("POTax", typeof(string));
            dtValues.Columns.Add("OTax", typeof(string));
            dtValues.Columns.Add("JOTax", typeof(string));
            dtValues.Columns.Add("NoPPH23", typeof(double));
            dtValues.Columns.Add("PPHAmount", typeof(double));
            dtValues.Columns.Add("run", typeof(int));

            return dtValues;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lbl_form_name.Text = "Bank Receipt Voucher";
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
            try
            {
                if (e.Argument == "Rebind")
                {
                    RadGrid1.MasterTableView.SortExpressions.Clear();
                    RadGrid1.MasterTableView.GroupByExpressions.Clear();
                    RadGrid1.Rebind();
                    RadGrid1.MasterTableView.Items[0].Selected = true;

                }
                else if (e.Argument == "RebindAndNavigate")
                {
                    RadGrid1.MasterTableView.SortExpressions.Clear();
                    RadGrid1.MasterTableView.GroupByExpressions.Clear();
                    RadGrid1.DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), selected_bank);
                    RadGrid1.DataBind();
                    RadGrid1.MasterTableView.CurrentPageIndex = RadGrid1.MasterTableView.PageCount - 1;

                    RadGrid1.MasterTableView.Items[RadGrid1.Items.Count - 1].Selected = true;

                    Session["action"] = "list";
                }
            }
            catch (Exception ex)
            {
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
            }
        }

        protected void btnNew_Click(object sender, ImageClickEventArgs e)
        {
            Session["TableDetail"] = null;
            Session["actionHeader"] = "headerNew";
            RadGrid1.MasterTableView.IsItemInserted = true;
            RadGrid1.MasterTableView.Rebind();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            RadGrid1.DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), cb_bank_prm.SelectedValue);
            RadGrid1.DataBind();
        }

        #region RadGrid1
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

        protected void RadGrid1_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
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
                cmd.CommandText = "UPDATE tr_paymentHH SET Usr = @Usr, LastUpdate = GETDATE(), status = 4 WHERE (slip_no = @slip_no)";
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

                selected_customer = item["cust_code"].Text;
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
                        //selected_KoTrans = gItem["KoTrans"].Text;
                    }
                }
            }
        }
        #endregion

        //protected void LoadBank(string name, string projectID, RadComboBox cb)
        //{
        //    SqlConnection con = new SqlConnection(
        //    ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);

        //    SqlDataAdapter adapter = new SqlDataAdapter("SELECT upper(KoBank) as code, upper(NamBank) as name FROM KOBANK " +
        //        "WHERE stEdit <> '4' AND region_code = @project AND NamBank LIKE @text + '%'", con);
        //    adapter.SelectCommand.Parameters.AddWithValue("@project", projectID);
        //    adapter.SelectCommand.Parameters.AddWithValue("@text", name);
        //    DataTable dt = new DataTable();
        //    adapter.Fill(dt);

        //    cb.DataTextField = "name";
        //    cb.DataValueField = "code";
        //    cb.DataSource = dt;
        //    cb.DataBind();
        //} 

        #region Param
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
            cmd.CommandText = "SELECT KoBank FROM KOBANK WHERE NamBank = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
                selected_bank = dr[0].ToString();
            }
            dr.Close();
            con.Close();
        }
        #endregion

        //protected void btnOk_Click(object sender, EventArgs e)
        //{
        //    foreach (GridDataItem item in RadGrid1.SelectedItems)
        //    {
        //        //txt_slip_no.Text = item["slip_no"].Text;
        //        //dtp_bm.SelectedDate = Convert.ToDateTime(item["doc_date"].Text);

        //        con.Open();
        //        SqlDataReader sdr;
        //        SqlCommand cmd = new SqlCommand("SELECT * FROM v_bankreceiptvoucher_list WHERE slip_no = '" + item["slip_no"].Text + "'", con);
        //        sdr = cmd.ExecuteReader();
        //        if (sdr.Read())
        //        {
        //            txt_slip_no.Text = sdr["slip_no"].ToString();
        //            dtp_bm.SelectedDate = Convert.ToDateTime(sdr["slip_date"].ToString());
        //            dtp_lm.SelectedDate = Convert.ToDateTime(sdr["tgl_cair"].ToString());
        //            txt_NoCtrl.Text = sdr["noctrl"].ToString();
        //            cb_bank.Text = sdr["NamBank"].ToString();
        //            cb_Cust.Text = sdr["cust_name"].ToString(); 
        //            cb_Prepared.Text = sdr["PreparedBy"].ToString();
        //            cb_Checked.Text = sdr["CheckedBy"].ToString();
        //            cb_Approval.Text = sdr["ApprovalBy"].ToString();
        //            txt_cur_code.Text = sdr["cur_code"].ToString();
        //            txt_kurs.Text = sdr["kurs"].ToString();
        //            txt_cur_code_acc.Text = sdr["cur_code_acc"].ToString();
        //            txt_kurs_acc.Text = sdr["kurs_acc"].ToString();
        //            txt_inf_pay_no.Text = sdr["inf_pay_no"].ToString();
        //            txt_Remark.Text = sdr["Remark"].ToString();
        //            txt_uid.Text = sdr["Usr"].ToString();
        //            txt_LastUpdate.Text = string.Format("{0:dd/MM/yyyy}", sdr["LastUpdate"].ToString());
        //            txt_owner.Text = sdr["Owner"].ToString();
        //            txt_printed.Text = sdr["Printed"].ToString();
        //            txt_edited.Text = sdr["Edited"].ToString();
        //        }
        //        con.Close();

        //        RadGrid2.DataSource = GetDataDetailTable(txt_slip_no.Text);
        //        RadGrid2.DataBind();
        //        RadGrid2.Enabled = true;
        //        //Session["Proccess"] = "SesEdit";
        //        Session["action"] = "edit";
        //        btnSave.Enabled = true;
        //        btnSave.ImageUrl = "~/Images/simpan.png";
        //        btnPrint.Enabled = true;
        //        btnPrint.ImageUrl = "~/Images/cetak.png";
        //        btnPrint.Attributes["OnClick"] = String.Format("return ShowPreview('{0}');", txt_slip_no.Text);
        //    }
        //}

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
                else if (ctrl is RadGrid)
                    ((RadGrid)ctrl).Enabled = state;

                control_status(ctrl.Controls, state);
            }
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

        //protected void btnPrint_Click(object sender, ImageClickEventArgs e)
        //{
        //    btnPrint.Attributes["OnClick"] = String.Format("return ShowPreview('{0}');", txt_slip_no.Text);
        //    //update status jadi 3
        //}

        #region Customer
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
            cmd.CommandText = "select cust_code from ms_customer WHERE cust_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["cust_code"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_Cust_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            RadComboBox cb = (RadComboBox)sender;
            GridEditableItem item = (GridEditableItem)cb.NamingContainer;

            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT TOP(1) ms_customer.cust_code, ms_customer.cust_name, ms_customer.cur_code, ms_kurs.KursRun " + 
                                "FROM ms_customer, ms_kurs " +
                                "WHERE ms_kurs.tglKurs = (SELECT MAX(tglKurs) FROM ms_kurs WHERE ms_kurs.cur_code = ms_customer.cur_code) AND cust_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["cust_code"].ToString();
                txt_cur_code = (RadTextBox)item.FindControl("txt_cur_code");
                txt_cur_code.Text = dr["cur_code"].ToString();

                txt_kurs = (RadNumericTextBox)item.FindControl("txt_kurs");
                txt_kurs.Value = Convert.ToDouble(dr["KursRun"].ToString());
            }
            dr.Close();

            //SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            //DataTable dt = new DataTable();
            //adapter.Fill(dt);
            //foreach (DataRow dr1 in dt.Rows)
            //{
            //    txt_cur_code.Text = dr1["cur_code"].ToString();
            //    txt_kurs.Text = dr1["kurs"].ToString();

            //}

            con.Close();

            selected_customer = (sender as RadComboBox).SelectedValue;

        }

        private static DataTable GetCust(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select cust_code,cust_name from ms_customer where stEdit != 4 " +
                " AND cust_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        #endregion

        #region Bank
        private static DataTable GetBank(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT KoBank, NamBank FROM KOBANK WHERE stEdit != 4 AND NamBank LIKE @text + '%'",
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
            RadComboBox cb = (RadComboBox)sender;
            GridEditableItem item = (GridEditableItem)cb.NamingContainer;

            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT KOBANK.*, ms_kurs.cur_code, ms_kurs.KursRun FROM KOBANK CROSS JOIN ms_kurs where ms_kurs.tglKurs = (select MAX(ms_kurs.tglKurs) from ms_kurs) AND NamBank = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["KoBank"].ToString();
                txt_cur_code_acc = (RadTextBox)item.FindControl("txt_cur_code_acc");
                txt_cur_code_acc.Text = dr["cur_code"].ToString();

                txt_kurs_acc = (RadNumericTextBox)item.FindControl("txt_kurs_acc");
                txt_kurs_acc.Value = Convert.ToDouble(dr["KursRun"].ToString());
            }
                
            dr.Close();


            //SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            //DataTable dt = new DataTable();
            //adapter.Fill(dt);
            //foreach (DataRow dr1 in dt.Rows)
            //{
               
            //}

            con.Close();
        }

        protected void cb_bank_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT KoBank FROM KOBANK WHERE NamBank = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["KoBank"].ToString();
            dr.Close();
            con.Close();
        }
        #endregion

        #region Approval
        protected void LoadManPower(string jabatan, RadComboBox cb)
        {
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);

            SqlDataAdapter adapter = new SqlDataAdapter("SELECT upper(name) as name, nik, upper(jabatan) as jabatan FROM ms_manpower " +
                "WHERE stedit <> '4' AND jabatan LIKE @text + '%'", con);           
            adapter.SelectCommand.Parameters.AddWithValue("@text", jabatan); 
            DataTable dt = new DataTable();
            adapter.Fill(dt);

            cb.DataTextField = "name";
            cb.DataValueField = "name";
            cb.DataSource = dt;
            cb.DataBind();
        }

        protected void cb_Prepared_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadManPower(e.Text, (sender as RadComboBox));
        }

        protected void cb_Prepared_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT * FROM ms_manpower WHERE name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["name"].ToString();
            }
               
            dr.Close();
            con.Close();
        }

        protected void cb_Prepared_DataBound(object sender, EventArgs e)
        {
            ((Literal)(sender as RadComboBox).Footer.FindControl("RadComboItemsCount")).Text = Convert.ToString((sender as RadComboBox).Items.Count);
        }

        protected void cb_Prepared_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT * FROM ms_manpower WHERE name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["name"].ToString();
            }
            dr.Close();
            con.Close();
        }

        protected void cb_Checked_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadManPower(e.Text, (sender as RadComboBox));
        }

        protected void cb_Checked_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT * FROM ms_manpower WHERE name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["name"].ToString();
            }
            dr.Close();
            con.Close();
        }

        protected void cb_Checked_DataBound(object sender, EventArgs e) 
        {
            ((Literal)(sender as RadComboBox).Footer.FindControl("RadComboItemsCount")).Text = Convert.ToString((sender as RadComboBox).Items.Count);
        }

        protected void cb_Checked_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT * FROM ms_manpower WHERE name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["name"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_Approval_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadManPower(e.Text, (sender as RadComboBox));
        }

        protected void cb_Approval_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT * FROM ms_manpower WHERE name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["name"].ToString();
            }
                
            dr.Close();
            con.Close();
        }

        protected void cb_Approval_DataBound(object sender, EventArgs e) 
        {
            ((Literal)(sender as RadComboBox).Footer.FindControl("RadComboItemsCount")).Text = Convert.ToString((sender as RadComboBox).Items.Count);
        }

        protected void cb_Approval_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT * FROM ms_manpower WHERE name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["name"].ToString();
            }
                
            dr.Close();
            con.Close();
        }
        #endregion

        #region RadGrid2
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

        protected void RadGrid2_UpdateCommand(object sender, GridCommandEventArgs e)
        {

            GridEditableItem item = (GridEditableItem)e.Item;

            dtValues = (DataTable)Session["TableDetail"];
            DataRow drValue = dtValues.NewRow();
            drValue["slip_no"] = tr_code;
            drValue["inv_code"] = (item.FindControl("cb_inv_code") as RadComboBox).Text;
            drValue["pay_amount"] = (Convert.ToDouble((item.FindControl("txt_payment") as RadNumericTextBox).Value));
            //drValue["pay_amount_acc"] = (Convert.ToDouble((item.FindControl("txt_payment") as RadTextBox).Text));
            drValue["region_code"] = (item.FindControl("txt_project") as RadTextBox).Text;
            drValue["dept_code"] = (item.FindControl("txt_cost_ctr") as RadTextBox).Text;
            //drValue["pay_amount_idr"] = (Convert.ToDouble((item.FindControl("txt_payment") as RadTextBox).Text));
            drValue["kurs"] = (Convert.ToDouble((item.FindControl("txt_kurs_detail") as RadNumericTextBox).Value));
            drValue["kurs_tax"] = (Convert.ToDouble((item.FindControl("txt_kurs_tax_detail") as RadNumericTextBox).Value));
            drValue["remark"] = (item.FindControl("txt_Ket") as RadTextBox).Text;
            drValue["POTax"] = potax;
            drValue["OTax"] = OTax;
            drValue["JOTax"] = JOTax;
            drValue["PPHAmount"] = DBNull.Value;
            drValue["NoPPH23"] = DBNull.Value;


            drValue.EndEdit(); //editing row in datatable
            dtValues.AcceptChanges();
            Session["TableDetail"] = dtValues;
            (sender as RadGrid).Rebind();
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
                drValue["pay_amount"] = (Convert.ToDouble((item.FindControl("txt_payment_insert") as RadNumericTextBox).Value));
                //drValue["pay_amount_acc"] = (Convert.ToDouble((item.FindControl("txt_payment_insert") as RadTextBox).Text));
                drValue["region_code"] = (item.FindControl("txt_project_insert") as RadTextBox).Text;
                drValue["dept_code"] = (item.FindControl("txt_cost_ctr_insert") as RadTextBox).Text;
                //drValue["pay_amount_idr"] = (Convert.ToDouble((item.FindControl("txt_payment_insert") as RadTextBox).Text));
                drValue["kurs"] = (Convert.ToDouble((item.FindControl("txt_kurs_detail_insert") as RadNumericTextBox).Value));
                drValue["kurs_tax"] = (Convert.ToDouble((item.FindControl("txt_kurs_tax_detail_insert") as RadNumericTextBox).Value));
                drValue["remark"] = (item.FindControl("txt_Ket_insert") as RadTextBox).Text;
                drValue["POTax"] = potax;
                drValue["OTax"] = OTax;
                drValue["JOTax"] = JOTax;
                drValue["PPHAmount"] = DBNull.Value;
                drValue["NoPPH23"] = DBNull.Value;

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

        protected void RadGrid2_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            var inv_code = ((GridDataItem)e.Item).GetDataKeyValue("inv_code");

            try
            {
                GridEditableItem item = (GridEditableItem)e.Item;
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "delete from tr_paymentd where inv_code = @inv_code and slip_no = @slip_no";
                cmd.Parameters.AddWithValue("@slip_no", inv_code);
                cmd.Parameters.AddWithValue("@inv_code", inv_code);
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
        #endregion

        #region INV_Code
        private static DataTable GetInv(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select * from v_bank_receive_voucher_reff where inv_code LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_inv_code_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            string sql = "select * from v_bank_receive_voucher_reff where inv_code LIKE @text + '%'";

            SqlDataAdapter adapter = new SqlDataAdapter(sql,
                ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", e.Text);

            DataTable dt = new DataTable();
            adapter.Fill(dt);

            RadComboBox comboBox = (RadComboBox)sender;
            // Clear the default Item that has been re-created from ViewState at this point.
            comboBox.Items.Clear();

            foreach (DataRow row in dt.Rows)
            {
                RadComboBoxItem item = new RadComboBoxItem();
                item.Text = row["inv_code"].ToString();
                item.Value = row["inv_code"].ToString();
                item.Attributes.Add("JmlSisa", string.Format("{0:#,###,###0.00}", row["JmlSisa"].ToString()));

                comboBox.Items.Add(item);

                item.DataBind();
            }

            //DataTable data = GetInv(e.Text);

            //int itemOffset = e.NumberOfItems;
            //int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            //e.EndOfItems = endOffset == data.Rows.Count;

            //for (int i = itemOffset; i < endOffset; i++)
            //{
            //    (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["inv_code"].ToString(), data.Rows[i]["inv_code"].ToString()));
            //}
        }

        private static double potax = 0;
        private static double JOTax = 0;
        private static string OTax = null;
        protected void cb_inv_code_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            Session["inv_code"] = e.Value;

            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "SELECT date, JmlSisa, kurs, kurs_tax, region_code, dept_code, remark, POTax, JOTax, OTax FROM v_bank_receive_voucher_reff WHERE inv_code = '" + (sender as RadComboBox).SelectedValue + "'";

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                foreach (DataRow dtr in dt.Rows)
                {
                    RadComboBox cb = (RadComboBox)sender;
                    GridEditableItem item = (GridEditableItem)cb.NamingContainer;
                    if (Session["actionDetail"].ToString() == "detailNew")
                    {
                        RadTextBox t_date = (RadTextBox)item.FindControl("txt_date_insert");
                        RadNumericTextBox t_Net = (RadNumericTextBox)item.FindControl("txt_payment_insert");
                        RadNumericTextBox t_kurs_tax = (RadNumericTextBox)item.FindControl("txt_kurs_tax_detail_insert");
                        RadNumericTextBox t_kurs = (RadNumericTextBox)item.FindControl("txt_kurs_detail_insert");
                        RadTextBox t_region_code = (RadTextBox)item.FindControl("txt_project_insert");
                        RadTextBox t_dept_code = (RadTextBox)item.FindControl("txt_cost_ctr_insert");
                        RadTextBox t_remark = (RadTextBox)item.FindControl("txt_Ket_insert");

                        t_date.Text = dtr["date"].ToString();
                        t_Net.Text = dtr["JmlSisa"].ToString();
                        t_kurs_tax.Text = dtr["kurs_tax"].ToString();
                        t_kurs.Text = dtr["kurs"].ToString();
                        t_region_code.Text = dtr["region_code"].ToString();
                        t_dept_code.Text = dtr["dept_code"].ToString();
                        t_remark.Text = dtr["remark"].ToString();
                        JOTax = Convert.ToDouble(dtr["JOTax"].ToString());
                        potax = Convert.ToDouble(dtr["POTax"].ToString());
                        OTax = dtr["OTax"].ToString();
                    }
                    else
                    {
                        Label lbl_date = (Label)item.FindControl("lbl_date");
                        RadNumericTextBox t_Net = (RadNumericTextBox)item.FindControl("txt_payment");
                        RadNumericTextBox t_kurs_tax = (RadNumericTextBox)item.FindControl("txt_kurs_tax_detail");
                        RadNumericTextBox t_kurs = (RadNumericTextBox)item.FindControl("txt_kurs_detail");
                        Label lbl_project = (Label)item.FindControl("lbl_project");
                        Label lbl_cost_ctr = (Label)item.FindControl("lbl_cost_ctr");
                        RadTextBox t_remark = (RadTextBox)item.FindControl("txt_Ket");

                        lbl_date.Text = dtr["date"].ToString();
                        t_Net.Text = dtr["JmlSisa"].ToString();
                        t_kurs_tax.Text = dtr["kurs_tax"].ToString();
                        t_kurs.Text = dtr["kurs"].ToString();
                        lbl_project.Text = dtr["region_code"].ToString();
                        lbl_cost_ctr.Text = dtr["dept_code"].ToString();
                        t_remark.Text = dtr["remark"].ToString();
                        JOTax = Convert.ToDouble(dtr["JOTax"].ToString());
                        potax = Convert.ToDouble(dtr["POTax"].ToString());
                        OTax = dtr["OTax"].ToString();
                    } 
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
            cmd.CommandText = "SELECT inv_code FROM tr_invsA WHERE inv_code = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }
        #endregion

        protected void btnJournal_Click(object sender, ImageClickEventArgs e)
        {

        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridEditableItem item = (GridEditableItem)btn.NamingContainer;

            RadTextBox txt_slip_no = (RadTextBox)item.FindControl("txt_slip_no");
            RadDatePicker dtp_bm = (RadDatePicker)item.FindControl("dtp_bm");
            RadTextBox txt_NoCtrl = (RadTextBox)item.FindControl("txt_NoCtrl");
            RadComboBox cb_Cust = (RadComboBox)item.FindControl("cb_Cust");
            RadTextBox txt_cur_code = (RadTextBox)item.FindControl("txt_cur_code");
            RadNumericTextBox txt_kurs = (RadNumericTextBox)item.FindControl("txt_kurs");
            RadComboBox cb_bank = (RadComboBox)item.FindControl("cb_bank");
            RadTextBox txt_cur_code_acc = (RadTextBox)item.FindControl("txt_cur_code_acc");
            RadNumericTextBox txt_kurs_acc = (RadNumericTextBox)item.FindControl("txt_kurs_acc");
            RadTextBox txt_inf_pay_no = (RadTextBox)item.FindControl("txt_inf_pay_no");
            RadDatePicker dtp_lm = (RadDatePicker)item.FindControl("dtp_lm");
            RadTextBox txt_Remark = (RadTextBox)item.FindControl("txt_Remark");
            RadComboBox cb_Prepared = (RadComboBox)item.FindControl("cb_Prepared");
            RadComboBox cb_Checked = (RadComboBox)item.FindControl("cb_Checked");
            RadComboBox cb_Approval = (RadComboBox)item.FindControl("cb_Approval");

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
                    cmd = new SqlCommand("SELECT ISNULL ( MAX ( RIGHT ( tr_paymentHH.slip_no , 4 ) ) , 0 ) + 1 AS maxNo " +
                        "FROM tr_paymentHH WHERE LEFT(tr_paymentHH.slip_no, 4) ='" + cb_bank.SelectedValue + "' + '" + "M" + "' " +
                        "AND SUBSTRING(tr_paymentHH.slip_no, 5, 2) = SUBSTRING('" + trDate + "', 9, 2) " +
                        "AND SUBSTRING(tr_paymentHH.slip_no, 7, 2) = SUBSTRING('" + trDate + "', 4, 2) ", con);
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
                cmd.Parameters.AddWithValue("@noctrl", txt_NoCtrl.Text);
                cmd.Parameters.AddWithValue("@cust_code", cb_Cust.SelectedValue);
                cmd.Parameters.AddWithValue("@remark1", cb_Cust.Text);
                cmd.Parameters.AddWithValue("@cur_code", txt_cur_code.Text);
                cmd.Parameters.AddWithValue("@kurs", (txt_kurs.Value));
                cmd.Parameters.AddWithValue("@cashbank", cb_bank.SelectedValue);
                cmd.Parameters.AddWithValue("@cur_code_acc", txt_cur_code_acc.Text);
                cmd.Parameters.AddWithValue("@kurs_acc", (txt_kurs_acc.Value));
                cmd.Parameters.AddWithValue("@inf_pay_no", txt_inf_pay_no.Text);
                cmd.Parameters.AddWithValue("@tgl_cair", string.Format("{0:yyyy-MM-dd}", dtp_lm.SelectedDate.Value));
                cmd.Parameters.AddWithValue("@Remark", txt_Remark.Text);
                cmd.Parameters.AddWithValue("@freby", cb_Prepared.SelectedValue);
                cmd.Parameters.AddWithValue("@ordby", cb_Checked.SelectedValue);
                cmd.Parameters.AddWithValue("@appby", cb_Approval.SelectedValue);
                cmd.Parameters.AddWithValue("@tot_pay", 0);
                cmd.Parameters.AddWithValue("@status", 1);
                cmd.Parameters.AddWithValue("@tot_pay_acc", 0);
                cmd.Parameters.AddWithValue("@tot_pay_idr", 0);
                cmd.Parameters.AddWithValue("@Owner", public_str.user_id);
                cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
                cmd.Parameters.AddWithValue("@Stamp", DateTime.Today);
                cmd.Parameters.AddWithValue("@Printed", 0);
                cmd.Parameters.AddWithValue("@Edited", 0);
                cmd.Parameters.AddWithValue("@Lvl", public_str.level);
                cmd.ExecuteNonQuery();

                foreach (GridDataItem itemD in Grid2.MasterTableView.Items)
                {
                    Label lbl_inv_code;
                    //Label lbl_date;
                    RadNumericTextBox txt_payment;
                    RadNumericTextBox txt_kurs_detail;
                    RadNumericTextBox txt_kurs_tax_detail;
                    Label lbl_project;
                    Label lbl_cost_ctr;
                    RadTextBox txt_Ket;

                    lbl_inv_code = (Label)itemD.FindControl("lbl_inv_code");
                    //lbl_date = (Label)itemD.FindControl("lbl_date");
                    txt_payment = (RadNumericTextBox)itemD.FindControl("txt_payment");
                    txt_kurs_detail = (RadNumericTextBox)itemD.FindControl("txt_kurs_detail");
                    txt_kurs_tax_detail = (RadNumericTextBox)itemD.FindControl("txt_kurs_tax_detail");
                    lbl_project = (Label)itemD.FindControl("lbl_project");
                    lbl_cost_ctr = (Label)itemD.FindControl("lbl_cost_ctr");
                    txt_Ket = (RadTextBox)itemD.FindControl("txt_Ket");

                    cmd = new SqlCommand();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Connection = con;
                    cmd.CommandText = "sp_save_BankReceiptVoucherD";
                    cmd.Parameters.AddWithValue("@slip_no", run);
                    cmd.Parameters.AddWithValue("@inv_code", lbl_inv_code.Text);
                    //cmd.Parameters.AddWithValue("@date", lbl_date.Text);
                    cmd.Parameters.AddWithValue("@pay_amount", txt_payment.Value);
                    cmd.Parameters.AddWithValue("@kurs", txt_kurs_detail.Value);
                    cmd.Parameters.AddWithValue("@kurs_tax", txt_kurs_tax_detail.Value);
                    cmd.Parameters.AddWithValue("@dept_code", lbl_cost_ctr.Text);
                    cmd.Parameters.AddWithValue("@region_code", lbl_project.Text);
                    cmd.Parameters.AddWithValue("@remark", txt_Ket.Text);
                    cmd.Parameters.AddWithValue("@pay_amount_acc", 0);
                    cmd.Parameters.AddWithValue("@pay_amount_idr", 0);
                    cmd.Parameters.AddWithValue("@POTax", 0);
                    cmd.Parameters.AddWithValue("@OTax", "NON");
                    cmd.Parameters.AddWithValue("@JOTax", 0);
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
                    acc01h04b.tr_code = run;
                    //acc01h04b.selected_project = cb_project.SelectedValue;
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind('navigateToInserted');", true);
                    (sender as Button).Text = "Update";
                    btnCancel.Text = "Close";
                }

                RadGrid1.MasterTableView.IsItemInserted = false;
            }
        }

        #region RadGrid3
        public DataTable GetDataJournalTable(string slip_no)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_Bank_Receipt_Journal";
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

        protected void RadGrid3_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadGrid).MasterTableView.Items.Count < (sender as RadGrid).MasterTableView.PageSize)
            {
                (sender as RadGrid).ClientSettings.Scrolling.AllowScroll = false;
                (sender as RadGrid).ClientSettings.Scrolling.UseStaticHeaders = false;
            }
        }
        #endregion

        protected void RadGrid1_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridEditFormItem && e.Item.IsInEditMode)
            {
                var item = e.Item as GridEditFormItem;
                RadDatePicker dtp_bm = item.FindControl("dtp_bm") as RadDatePicker;

                RadTextBox txt_uid = item.FindControl("txt_uid") as RadTextBox;
                RadTextBox txt_LastUpdate = item.FindControl("txt_LastUpdate") as RadTextBox;
                RadTextBox txt_owner = item.FindControl("txt_owner") as RadTextBox;
                RadTextBox txt_printed = item.FindControl("txt_printed") as RadTextBox;
                RadTextBox txt_edited = item.FindControl("txt_edited") as RadTextBox;

                if (e.Item.OwnerTableView.IsItemInserted)
                {
                    dtp_bm.SelectedDate = DateTime.Now;

                    txt_uid.Text = public_str.uid;
                    txt_LastUpdate.Text = DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss");
                    txt_owner.Text = public_str.uid;
                    txt_printed.Text = "0";
                    txt_edited.Text = "0";
                }

            }
        }
    }
}