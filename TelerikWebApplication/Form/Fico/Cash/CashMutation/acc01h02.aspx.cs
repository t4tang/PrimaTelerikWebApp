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
        public static string tr_code = null;
        public static string selected_project = null;
        public static string selected_KoTrans = null;
        public static string selected_cost_ctr = null;

        RadTextBox txt_cur_code;
        RadTextBox txt_kurs;
        RadComboBox cb_KoTrans;
        //RadDatePicker dtp_date;
        DataTable dtValues;

        public DataTable DetailDtbl()
        {
            dtValues = new DataTable();
            dtValues.Columns.Add("NoBuk", typeof(string));
            dtValues.Columns.Add("KoRek", typeof(string));
            dtValues.Columns.Add("Ket", typeof(string));
            dtValues.Columns.Add("Mutasi", typeof(double));
            dtValues.Columns.Add("kurs", typeof(string));
            dtValues.Columns.Add("Jumlah", typeof(string));
            dtValues.Columns.Add("region_code", typeof(string));
            dtValues.Columns.Add("dept_code", typeof(string));
            dtValues.Columns.Add("run", typeof(int));

            return dtValues;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lbl_form_name.Text = "Cash Mutation";
                dtp_from.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
                dtp_to.SelectedDate = DateTime.Now;
                //dtp_date.SelectedDate = DateTime.Now;
                cb_CashMutation_prm.SelectedValue = public_str.site;
                selected_project = public_str.site;

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
        private static DataTable GetCashCode(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT KoKas, NamKas FROM acc00h02 WHERE stEdit != 4 AND NamKas LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }

        protected void cb_CashMutation_prm_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetCashCode(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                cb_CashMutation_prm.Items.Add(new RadComboBoxItem(data.Rows[i]["NamKas"].ToString(), data.Rows[i]["NamKas"].ToString()));
            }
        }

        protected void cb_CashMutation_prm_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT KoKas FROM acc00h02 WHERE NamKas = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_CashMutation_prm.SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }
        #endregion
        protected void btnSearch1_Click(object sender, EventArgs e)
        {
            RadGrid1.DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), cb_CashMutation_prm.SelectedValue);
            RadGrid1.DataBind();
        }

        public DataTable GetDataTable(string fromDate, string toDate, string Cash)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_cashmutasiH";
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

        protected void btnNew_Click(object sender, ImageClickEventArgs e)
        {
            Session["TableDetail"] = null;
            Session["actionHeader"] = "headerNew";
            RadGrid1.MasterTableView.IsItemInserted = true;
            RadGrid1.MasterTableView.Rebind();
        }

        #region MainGrid
        protected void RadGrid1_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            (sender as RadGrid).DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), cb_CashMutation_prm.SelectedValue);
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
                cmd.CommandText = "UPDATE acc01h02 SET Usr = @Usr, LastUpdate = GETDATE(), Batal = '1' WHERE (NoBuk = @NoBuk)";
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

        protected void RadGrid1_ItemCreated(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                ImageButton printLink = (ImageButton)e.Item.FindControl("PrintLink");
                printLink.Attributes["href"] = "javascript:void(0);";
                printLink.Attributes["onclick"] = String.Format("return ShowPreview('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["NoBuk"], e.Item.ItemIndex);
            }
        }

        protected void RadGrid1_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                tr_code = null;
                GridDataItem item = e.Item as GridDataItem;
                string kode = item["NoBuk"].Text;

                tr_code = kode;

                Session["actionHeader"] = "headerEdit";
                Session["actionDetail"] = null;
            }
        }

        protected void RadGrid1_SelectedIndexChanged(object sender, EventArgs e)
        {
            foreach (GridDataItem item in RadGrid1.SelectedItems)
            {
                tr_code = item["NoBuk"].Text;
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
                        tr_code = gItem["NoBuk"].Text;
                    }
                }
            }
        }
        #endregion

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridEditableItem item = (GridEditableItem)btn.NamingContainer;

            RadTextBox txt_NoBuk = (RadTextBox)item.FindControl("txt_NoBuk");
            RadDatePicker dtp_date = (RadDatePicker)item.FindControl("dtp_date");
            RadTextBox txt_NoCtrl = (RadTextBox)item.FindControl("txt_NoCtrl");
            RadTextBox txt_NoRef = (RadTextBox)item.FindControl("txt_NoRef");
            RadComboBox cb_KoTrans = (RadComboBox)item.FindControl("cb_KoTrans");
            RadComboBox cb_Project = (RadComboBox)item.FindControl("cb_Project");
            RadComboBox cb_Cash = (RadComboBox)item.FindControl("cb_Cash");
            RadTextBox txt_cur_code = (RadTextBox)item.FindControl("txt_cur_code");
            RadTextBox txt_kurs = (RadTextBox)item.FindControl("txt_kurs");
            RadTextBox txt_fromto = (RadTextBox)item.FindControl("txt_fromto");
            RadTextBox txt_remark = (RadTextBox)item.FindControl("txt_remark");
            RadComboBox cb_Prepared = (RadComboBox)item.FindControl("cb_Prepared");
            RadComboBox cb_Checked = (RadComboBox)item.FindControl("cb_Checked");
            RadComboBox cb_Approval = (RadComboBox)item.FindControl("cb_Approval");

            Button btnCancel = (Button)item.FindControl("btnCancel");
            RadGrid Grid2 = (RadGrid)item.FindControl("RadGrid2");

            long maxNo;
            string run = null;
            string trDate = string.Format("{0:dd/MM/yyyy}", dtp_date.SelectedDate);

            try
            {
                if ((sender as Button).Text == "Update")
                {
                    run = txt_NoBuk.Text;
                }
                else
                {
                    con.Open();
                    SqlDataReader sdr;
                    cmd = new SqlCommand("SELECT ISNULL ( MAX ( RIGHT ( acc01h02.NoBuk , 4 ) ) , 0 ) + 1 AS maxNo " +
                        "FROM acc01h02 WHERE LEFT(acc01h02.NoBuk, 4) = '" + cb_Cash.SelectedValue + "' + '" + cb_KoTrans.SelectedValue + "' " +
                        "AND SUBSTRING(acc01h02.NoBuk, 5, 2) = SUBSTRING('" + trDate + "', 9, 2) " +
                        "AND SUBSTRING(acc01h02.NoBuk, 7, 2) = SUBSTRING('" + trDate + "', 4, 2) ", con);
                    sdr = cmd.ExecuteReader();
                    if (sdr.HasRows == false)
                    {
                        //throw new Exception();
                        run = cb_Cash.SelectedValue + cb_KoTrans.SelectedValue + dtp_date.SelectedDate.Value.Year + dtp_date.SelectedDate.Value.Month + "0001";
                    }
                    else if (sdr.Read())
                    {
                        maxNo = Convert.ToInt32(sdr[0].ToString());
                        run = cb_Cash.SelectedValue + cb_KoTrans.SelectedValue + (dtp_date.SelectedDate.Value.Year.ToString()).Substring(dtp_date.SelectedDate.Value.Year.ToString().Length - 2) +
                            ("0000" + dtp_date.SelectedDate.Value.Month).Substring(("0000" + dtp_date.SelectedDate.Value.Month).Length - 2, 2) +
                            ("0000" + maxNo).Substring(("0000" + maxNo).Length - 4, 4);
                    }
                    con.Close();
                }


                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_save_cashmutasiH";
                cmd.Parameters.AddWithValue("@Kode", "DB");
                cmd.Parameters.AddWithValue("@NoBuk", run);
                cmd.Parameters.AddWithValue("@Tgl", string.Format("{0:yyyy-MM-dd}", dtp_date.SelectedDate.Value));
                cmd.Parameters.AddWithValue("@NoCtrl", txt_NoCtrl.Text);
                cmd.Parameters.AddWithValue("@NoRef", txt_NoRef.Text);
                cmd.Parameters.AddWithValue("@KoTrans", cb_KoTrans.SelectedValue);
                cmd.Parameters.AddWithValue("@KoKas", cb_Cash.SelectedValue);
                cmd.Parameters.AddWithValue("@cur_code", txt_cur_code.Text);
                decimal kurs = decimal.Parse(txt_kurs.Text);
                cmd.Parameters.AddWithValue("@kurs", kurs);
                cmd.Parameters.AddWithValue("@Kontak", txt_fromto.Text);
                cmd.Parameters.AddWithValue("@region_code", cb_Project.SelectedValue);
                cmd.Parameters.AddWithValue("@Ket", txt_remark.Text);
                cmd.Parameters.AddWithValue("@freby", cb_Prepared.SelectedValue);
                cmd.Parameters.AddWithValue("@ordby", cb_Checked.SelectedValue);
                cmd.Parameters.AddWithValue("@appby", cb_Approval.SelectedValue);
                cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
                cmd.Parameters.AddWithValue("@Owner", public_str.user_id);
                cmd.Parameters.AddWithValue("@Total", 0.0000);
                cmd.Parameters.AddWithValue("@Printed", 0.0000);
                cmd.Parameters.AddWithValue("@Batal", 0);
                cmd.Parameters.AddWithValue("@Edited", 0);
                cmd.Parameters.AddWithValue("@Lvl", public_str.level);
                cmd.Parameters.AddWithValue("@Stamp", DateTime.Today);
                cmd.ExecuteNonQuery();

                foreach (GridDataItem itemD in Grid2.MasterTableView.Items)
                {
                    //Label lbl_nomor;
                    Label lbl_korek;
                    Label lbl_KetD;
                    Label lbl_mutasiD;
                    Label lbl_kursD;
                    Label lbl_amount;
                    Label lbl_ProjectD;
                    Label lbl_CostCntrD;

                    //lbl_nomor = (Label)itemD.FindControl("lbl_nomor");
                    lbl_korek = (Label)itemD.FindControl("lbl_korek");
                    lbl_KetD = (Label)itemD.FindControl("lbl_KetD");
                    lbl_mutasiD = (Label)itemD.FindControl("lbl_mutasiD");
                    lbl_kursD = (Label)itemD.FindControl("lbl_kursD");
                    lbl_amount = (Label)itemD.FindControl("lbl_amount");
                    lbl_ProjectD = (Label)itemD.FindControl("lbl_ProjectD");
                    lbl_CostCntrD = (Label)itemD.FindControl("lbl_CostCntrD");

                    cmd = new SqlCommand();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Connection = con;
                    cmd.CommandText = "sp_save_cashmutasiD";
                    cmd.Parameters.AddWithValue("@NoBuk", run);
                    cmd.Parameters.AddWithValue("@KoRek", lbl_korek.Text);
                    //cmd.Parameters.AddWithValue("@Nmr", lbl_nomor.Text);
                    cmd.Parameters.AddWithValue("@Ket", lbl_KetD.Text);
                    cmd.Parameters.AddWithValue("@Mutasi", lbl_mutasiD.Text);
                    cmd.Parameters.AddWithValue("@kurs", Convert.ToDouble(lbl_kursD.Text));
                    cmd.Parameters.AddWithValue("@Jumlah", Convert.ToDouble(lbl_amount.Text));
                    cmd.Parameters.AddWithValue("@region_code", lbl_ProjectD.Text);
                    cmd.Parameters.AddWithValue("@dept_code", lbl_CostCntrD.Text);
                    cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
                    cmd.Parameters.AddWithValue("@Owner", public_str.user_id);
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
                txt_NoBuk.Text = run;
                notif.Text = "Data telah disimpan";
                notif.Show();

                if ((sender as Button).Text == "Update")
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind();", true);
                }
                else
                {
                    acc01h02.tr_code = run;
                    acc01h02.selected_project = cb_Project.SelectedValue;
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind('navigateToInserted');", true);
                    (sender as Button).Text = "Update";
                    btnCancel.Text = "Close";
                }

                RadGrid1.MasterTableView.IsItemInserted = false;
            }
        }
    

        #region KoTrans
        protected void cb_KoTrans_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Add("PENERIMAAN KAS");
            (sender as RadComboBox).Items.Add("PENGELUARAN KAS");
        }

        protected void cb_KoTrans_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadComboBox).Text == "PENERIMAAN KAS")
            {
                (sender as RadComboBox).SelectedValue = "D";
            }
            else if ((sender as RadComboBox).Text == "PENGELUARAN KAS")
            {
                (sender as RadComboBox).SelectedValue = "K";
            }
        }

        protected void cb_KoTrans_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if ((sender as RadComboBox).Text == "PENERIMAAN KAS")
            {
                (sender as RadComboBox).SelectedValue = "D";
            }
            else if ((sender as RadComboBox).Text == "PENGELUARAN KAS")
            {
                (sender as RadComboBox).SelectedValue = "K";
            }

            selected_KoTrans = (sender as RadComboBox).SelectedValue;
        }
        #endregion

        #region Project
        private static DataTable GetProject(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select region_code,region_name from inv00h09 where stEdit != 4 " +
                " AND region_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }

        protected void cb_Project_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
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

        protected void cb_Project_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select region_code from inv00h09 WHERE region_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["region_code"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_Project_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select region_code from inv00h09 WHERE region_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["region_code"].ToString();
                selected_project = dr[0].ToString();
            }
            dr.Close();
            con.Close();
        }
        #endregion

        #region Cash
        protected void Loadcash(string name, string projectID, RadComboBox cb)
        {
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);

            SqlDataAdapter adapter = new SqlDataAdapter("SELECT upper(KoKas) as code,upper(NamKas) as name FROM acc00h02 " +
                "WHERE stEdit <> '4' AND region_code = @project AND NamKas LIKE @text + '%'", con);
            adapter.SelectCommand.Parameters.AddWithValue("@project", projectID);
            adapter.SelectCommand.Parameters.AddWithValue("@text", name);
            DataTable dt = new DataTable();
            adapter.Fill(dt);

            cb.DataTextField = "name";
            cb.DataValueField = "code";
            cb.DataSource = dt;
            cb.DataBind();
        }

        protected void cb_Cash_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            Loadcash(e.Text, selected_project, (sender as RadComboBox));
        }

        protected void cb_Cash_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT KoKas FROM acc00h02 WHERE NamKas = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["KoKas"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_Cash_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            RadComboBox cb = (RadComboBox)sender;
            GridEditableItem item = (GridEditableItem)cb.NamingContainer;

            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT acc00h02.*, acc00h04.KursRun, acc00h04.cur_code FROM acc00h02 CROSS JOIN " +
                                " acc00h04 where acc00h04.tglKurs = (select MAX(acc00h04.tglKurs) from acc00h04) AND NamKas = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["KoKas"].ToString();
                txt_cur_code = (RadTextBox)item.FindControl("txt_cur_code");
                txt_cur_code.Text = dr["cur_code"].ToString();

                txt_kurs = (RadTextBox)item.FindControl("txt_kurs");
                txt_kurs.Text = dr["KursRun"].ToString();
            }

            dr.Close();
            con.Close();
        }
        #endregion

        #region Approval
        protected void LoadManPower(string name, string projectID, RadComboBox cb)
        {
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);

            SqlDataAdapter adapter = new SqlDataAdapter("SELECT upper(name) as name, nik, upper(jabatan) as jabatan FROM inv00h26 " +
                "WHERE stedit <> '4' AND region_code = @project AND name LIKE @text + '%'", con);
            adapter.SelectCommand.Parameters.AddWithValue("@project", projectID);
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
            LoadManPower(e.Text, selected_project, (sender as RadComboBox));
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
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
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

        protected void cb_Checked_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadManPower(e.Text, selected_project, (sender as RadComboBox));
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
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
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

        protected void cb_Approval_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadManPower(e.Text, selected_project, (sender as RadComboBox));
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
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
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
        #endregion

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

        #region Grid Detail
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
            var KoRek = ((GridDataItem)e.Item).GetDataKeyValue("KoRek");

            try
            {
                GridEditableItem item = (GridEditableItem)e.Item;
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "delete from acc01d02 where KoRek = @KoRek and NoBuk = @NoBuk";
                cmd.Parameters.AddWithValue("@NoBuk", KoRek);
                cmd.Parameters.AddWithValue("@KoRek", KoRek);
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
                drValue["NoBuk"] = tr_code;
                drValue["KoRek"] = (item.FindControl("cb_KoRek_insert") as RadComboBox).Text;
                drValue["Ket"] = (item.FindControl("txt_KetD_insert") as RadTextBox).Text;
                drValue["Mutasi"] = (item.FindControl("cb_Mutasi_insert") as RadComboBox).Text;
                drValue["kurs"] = (item.FindControl("txt_kursD_insert") as RadTextBox).Text;
                drValue["Jumlah"] = (item.FindControl("txt_amount_insert") as RadTextBox).Text;
                drValue["region_code"] = (item.FindControl("cb_Project_Detail_insert") as RadComboBox).Text;
                drValue["dept_code"] = (item.FindControl("cb_Cost_Center_insert") as RadComboBox).Text;
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
            drValue["NoBuk"] = tr_code;
            drValue["KoRek"] = (item.FindControl("cb_KoRek") as RadComboBox).Text;
            drValue["Ket"] = (item.FindControl("txt_KetD") as RadTextBox).Text;
            drValue["Mutasi"] = (item.FindControl("cb_Mutasi") as RadComboBox).Text;
            drValue["kurs"] = (item.FindControl("txt_kursD") as RadTextBox).Text;
            drValue["Jumlah"] = (item.FindControl("txt_amount") as RadTextBox).Text;
            drValue["region_code"] = (item.FindControl("cb_Project_Detail") as RadComboBox).Text;
            drValue["dept_code"] = (item.FindControl("cb_Cost_Center") as RadComboBox).Text;
            //drValue["run"] = 0;

            drValue.EndEdit(); //editing row in datatable
            dtValues.AcceptChanges();
            Session["TableDetail"] = dtValues;
            (sender as RadGrid).Rebind();
        }
        #endregion

        #region KoRek
        protected void cb_KoRek_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            string sql = "SELECT [accountno], [accountname] FROM [acc00h10]  WHERE stEdit != '4' AND accountname LIKE @accountname + '%'";
            SqlDataAdapter adapter = new SqlDataAdapter(sql,
                ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@accountname", e.Text);

            DataTable dt = new DataTable();
            adapter.Fill(dt);

            RadComboBox comboBox = (RadComboBox)sender;
            // Clear the default Item that has been re-created from ViewState at this point.
            comboBox.Items.Clear();

            foreach (DataRow row in dt.Rows)
            {
                RadComboBoxItem item = new RadComboBoxItem();
                item.Text = row["accountno"].ToString();
                item.Value = row["accountno"].ToString();
                item.Attributes.Add("accountname", row["accountname"].ToString());

                comboBox.Items.Add(item);

                item.DataBind();
            }
        }

        protected void cb_KoRek_PreRender(object sender, EventArgs e)
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

        protected void cb_KoRek_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            Session["accountno"] = e.Value;

            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "SELECT  acc00h10.accountno,acc00h10.accountname,acc00h10.cur_code, acc01h01.kurs, acc01h01.KoTrans " +
                                    "FROM acc00h10 INNER JOIN " +
                                    "acc01h01 ON acc00h10.cur_code = acc01h01.cur_code WHERE accountno = '" + (sender as RadComboBox).SelectedValue + "'";
                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                foreach (DataRow dtr in dt.Rows)
                {
                    RadComboBox cb = (RadComboBox)sender;
                    GridEditableItem item = (GridEditableItem)cb.NamingContainer;
                    if (Session["actionDetail"].ToString() == "detailNew")
                    {
                        RadTextBox t_kurs = (RadTextBox)item.FindControl("txt_kursD_insert");
                        RadComboBox c_mutasi = (RadComboBox)item.FindControl("cb_mutasi_insert");
                        RadComboBox c_project = (RadComboBox)item.FindControl("cb_project_detail_insert");

                        t_kurs.Text = dtr["kurs"].ToString();
                        c_mutasi.Text = selected_KoTrans;
                        c_project.Text = selected_project;
                    }
                    else if (Session["actionDetail"].ToString() == "detailEdit")
                    {
                        RadTextBox t_kurs = (RadTextBox)item.FindControl("txt_kursD");
                        RadComboBox c_mutasi = (RadComboBox)item.FindControl("cb_mutasi");
                        RadComboBox c_project = (RadComboBox)item.FindControl("cb_project_detail");

                        t_kurs.Text = dtr["kurs"].ToString();
                        c_mutasi.Text = selected_KoTrans;
                        c_project.Text = selected_project;
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
        #endregion

        #region Mutasi
        protected void cb_Mutasi_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Add("D");
            (sender as RadComboBox).Items.Add("K");
        }

        protected void cb_Mutasi_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadComboBox).Text == "D")
            {
                (sender as RadComboBox).SelectedValue = "D";
            }
            else if ((sender as RadComboBox).Text == "K")
            {
                (sender as RadComboBox).SelectedValue = "K";
            }
        }

        protected void cb_Mutasi_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if ((sender as RadComboBox).Text == "D")
            {
                (sender as RadComboBox).SelectedValue = "D";
            }
            else if ((sender as RadComboBox).Text == "K")
            {
                (sender as RadComboBox).SelectedValue = "K";
            }
        }
        #endregion

        #region Project Detail
        protected void cb_Project_Detail_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
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

        protected void cb_Project_Detail_PreRender(object sender, EventArgs e)
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

        protected void cb_Project_Detail_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            Session["region_code"] = e.Value;

            try
            {
                //con.Open();
                //SqlCommand cmd = new SqlCommand();
                //cmd.Connection = con;
                //cmd.CommandType = CommandType.Text;
                //cmd.CommandText = "SELECT region_name FROM inv00h09 WHERE region_code = '" + (sender as RadComboBox).SelectedValue + "'";

                //SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                //DataTable dt = new DataTable();
                //adapter.Fill(dt);
                //foreach (DataRow dtr in dt.Rows)
                //{
                RadComboBox cb = (RadComboBox)sender;
                GridEditableItem item = (GridEditableItem)cb.NamingContainer;

                //    //RadTextBox t_regionname = (RadTextBox)item.FindControl("txt_region_name");

                //    //t_regionname.Text = dtr["region_name"].ToString();

                RadComboBox cb_costCtr = (RadComboBox)item.FindControl("cb_cost_center");
                LoadCostCtr(cb_costCtr.Text, (sender as RadComboBox).SelectedValue, cb_costCtr);

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
        #endregion

        #region Cost Center
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

            cb.DataTextField = "name";
            cb.DataValueField = "code";
            cb.DataSource = dt;
            cb.DataBind();
        }
        protected void cb_Cost_Center_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            RadComboBox cb = (RadComboBox)sender;
            GridEditableItem item = (GridEditableItem)cb.NamingContainer;
            RadComboBox cb_Project = (RadComboBox)item.FindControl("cb_Project"); 

            (sender as RadComboBox).Text = "";
            LoadCostCtr(e.Text, selected_project, (sender as RadComboBox));
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
            {
                (sender as RadComboBox).SelectedValue = dr["CostCenter"].ToString();
                selected_cost_ctr = dr["CostCenter"].ToString();
            }
            dr.Close();
            con.Close();
        }

        protected void cb_Cost_Center_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT CostCenter FROM inv00h11 WHERE CostCenterName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["CostCenter"].ToString();
                selected_cost_ctr = dr["CostCenter"].ToString();
            }

            dr.Close();
            con.Close();
        }
        #endregion
    }
}