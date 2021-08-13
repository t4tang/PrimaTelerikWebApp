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

namespace TelerikWebApplication.Form.Fico.Bank.BankMutation
{
    public partial class acc01h01 : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();

        private const int ItemsPerRequest = 10;
        public static string tr_code = null;
        public static string mt_code = null;
        public static string selected_bank = null;
        public static string selected_project = null;
        public static string selected_cost_ctr = null;
        public static string selected_KoTrans = null;
        public static double kursRun = 0;

        DataTable dtValues;
        RadTextBox txt_cur_code;
        RadNumericTextBox txt_kurs;
        RadComboBox cb_KoTrans;
        RadNumericTextBox txt_Jumlah;
        RadNumericTextBox txt_total;

        public DataTable DetailDtbl()
        {
            dtValues = new DataTable();
            dtValues.Columns.Add("NoBuk", typeof(string));
            dtValues.Columns.Add("KoRek", typeof(string));
            //dtValues.Columns.Add("Nmr", typeof(string));
            dtValues.Columns.Add("kurs", typeof(double));
            dtValues.Columns.Add("Jumlah", typeof(double));
            dtValues.Columns.Add("mutasi", typeof(string));
            dtValues.Columns.Add("Ket", typeof(string));
            dtValues.Columns.Add("dept_code", typeof(string));
            dtValues.Columns.Add("region_code", typeof(string));
            dtValues.Columns.Add("Nomor", typeof(double));

            return dtValues;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lbl_form_name.Text = "Bank Mutation";
                dtp_from.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
                dtp_to.SelectedDate = DateTime.Now;
                cb_bank_prm.SelectedValue = public_str.site;
                selected_project = public_str.site;
                //selected_KoTrans = Items["KoTrans"].

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

        #region Param
        private static DataTable GetBank(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT KoBank, NamBank FROM KOBANK WHERE stEdit != 4 AND NamBank LIKE @text + '%'",
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
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["NamBank"].ToString(), data.Rows[i]["NamBank"].ToString()));
            }
        }

        protected void cb_bank_prm_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
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

        protected void btnNew_Click(object sender, ImageClickEventArgs e)
        {
            Session["TableDetail"] = null;
            Session["actionHeader"] = "headerNew";
            RadGrid1.MasterTableView.IsItemInserted = true;
            RadGrid1.MasterTableView.Rebind();
            //CalculateTotal();
        }

        protected void btnSearch1_Click(object sender, EventArgs e)
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
            cmd.CommandText = "sp_get_BankMutationH";
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

        #region Radrid1
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

        protected void RadGrid1_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            var NoBuk = ((GridDataItem)e.Item).GetDataKeyValue("NoBuk");

            try
            {
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "UPDATE glBank SET Usr = @Usr, LastUpdate = GETDATE(), Batal = '1' WHERE (NoBuk = @NoBuk)";
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

        protected void RadGrid1_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            (sender as RadGrid).DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), cb_bank_prm.SelectedValue);
        }
        #endregion

        #region Detail Grid
        public DataTable GetDataDetailTable(string NoBuk)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_BankMutationD";
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
            else if(e.CommandName == RadGrid.DeleteCommandName)
            {
                Session["actionDetail"] = "detailDelete";
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
                drValue["NoBuk"] = tr_code;
                drValue["KoRek"] = (item.FindControl("cb_korek_insert") as RadComboBox).Text;
                drValue["kurs"] = (item.FindControl("txt_kursD_insert") as RadNumericTextBox).Value;
                drValue["Jumlah"] = (item.FindControl("txt_Jumlah_insert") as RadNumericTextBox).Value;
                drValue["mutasi"] = (item.FindControl("cb_mutasi_insert") as RadComboBox).Text;
                drValue["Ket"] = (item.FindControl("txt_KetD_insert") as RadTextBox).Text;
                drValue["dept_code"] = (item.FindControl("cb_cost_center_insert") as RadComboBox).Text;
                drValue["region_code"] = (item.FindControl("cb_project_detail_insert") as RadComboBox).Text;
                drValue["Nomor"] = 0;

                dtValues.Rows.Add(drValue); //adding new row into datatable
                dtValues.AcceptChanges();
                Session["TableDetail"] = dtValues;
                (sender as RadGrid).Rebind();
                Session["actionDetail"] = "detailList";

                //CalculateTotal();
                //RadTextBox txt_total = (RadTextBox)item.FindControl("txt_total");
                //txt_total.Text = total.ToString();
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
            drValue["KoRek"] = (item.FindControl("cb_korek") as Label).Text;
            drValue["kurs"] = (item.FindControl("txt_kursD") as RadNumericTextBox).Value;
            drValue["Jumlah"] = (item.FindControl("txt_Jumlah") as RadNumericTextBox).Value;
            drValue["mutasi"] = (item.FindControl("cb_mutasi") as RadComboBox).Text;
            drValue["Ket"] = (item.FindControl("txt_KetD") as RadTextBox).Text;
            drValue["dept_code"] = (item.FindControl("cb_cost_center") as RadComboBox).Text;
            drValue["region_code"] = (item.FindControl("cb_project_detail") as RadComboBox).Text;
            //drValue["run"] = 0;

            drValue.EndEdit(); //editing row in datatable
            dtValues.AcceptChanges();
            Session["TableDetail"] = dtValues;
            (sender as RadGrid).Rebind();

            //CalculateTotal();
        }

        protected void RadGrid2_DeleteCommand(object sender, GridCommandEventArgs e)
        {            
            var Nomor = ((GridDataItem)e.Item).GetDataKeyValue("Nomor");

            try
            {
                GridEditableItem item = (GridEditableItem)e.Item;

                RadNumericTextBox txt_nomor = (RadNumericTextBox)item.FindControl("txt_nomor");

                dtValues = (DataTable)Session["TableDetail"];
                for (int i = dtValues.Rows.Count - 1; i >= 0; i--)
                {
                    DataRow dr = dtValues.Rows[i];
                    if (dr["Nomor"].ToString() == Nomor.ToString())
                    {
                        dr.Delete();
                    }
                        
                }

                tr_code = ((GridDataItem)e.Item).GetDataKeyValue("NoBuk").ToString();
                dtValues.AcceptChanges();
                Session["TableDetail"] = dtValues;
                (sender as RadGrid).Rebind();

                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_delete_bank_mutationD";
                cmd.Parameters.AddWithValue("@NoBuk", tr_code);
                cmd.Parameters.AddWithValue("@nomor", txt_nomor.Value);
                cmd.ExecuteNonQuery();
                con.Close();
                //(sender as RadGrid).DataBind();

                //Label lblsuccess = new Label();
                //lblsuccess.Text = "Data deleted";
                //lblsuccess.ForeColor = System.Drawing.Color.DarkGray;
                //(sender as RadGrid).Controls.Add(lblsuccess);
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

        #region KoTrans
        protected void cb_KoTrans_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Add("PENERIMAAN BANK");
            (sender as RadComboBox).Items.Add("PENGELUARAN BANK");
        }

        protected void cb_KoTrans_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadComboBox).Text == "PENERIMAAN BANK")
            {
                (sender as RadComboBox).SelectedValue = "D";
            }
            else if ((sender as RadComboBox).Text == "PENGELUARAN BANK")
            {
                (sender as RadComboBox).SelectedValue = "K";
            }
            selected_KoTrans = (sender as RadComboBox).SelectedValue;
        }

        protected void cb_KoTrans_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if ((sender as RadComboBox).Text == "PENERIMAAN BANK")
            {
                (sender as RadComboBox).SelectedValue = "D";
                cb_KoTrans.SelectedValue = "D";
            }
            else if ((sender as RadComboBox).Text == "PENGELUARAN BANK")
            {
                (sender as RadComboBox).SelectedValue = "K";
                cb_KoTrans.SelectedValue = "K";
            }
            selected_KoTrans = (sender as RadComboBox).SelectedValue;
        }
        #endregion

        #region Project
        private static DataTable GetProject(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select region_code,region_name from ms_jobsite where stEdit != 4 " +
                " AND region_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }

        protected void cb_project_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
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

        protected void cb_project_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select region_code from ms_jobsite WHERE region_name = '" + (sender as RadComboBox).Text + "'";
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

        protected void cb_project_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select region_code from ms_jobsite WHERE region_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["region_code"].ToString();
            dr.Close();
            con.Close();
        }
        #endregion

        #region Bank
        protected void LoadBank(string name, string projectID, RadComboBox cb)
        {
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);

            SqlDataAdapter adapter = new SqlDataAdapter("SELECT upper(KoBank) as code,upper(NamBank) as name FROM KOBANK " +
                "WHERE stEdit <> '4' AND region_code = @project AND NamBank LIKE @text + '%'", con);
            adapter.SelectCommand.Parameters.AddWithValue("@project", projectID);
            adapter.SelectCommand.Parameters.AddWithValue("@text", name);
            DataTable dt = new DataTable();
            adapter.Fill(dt);

            cb.DataTextField = "name";
            cb.DataValueField = "code";
            cb.DataSource = dt;
            cb.DataBind();
        }

        protected void cb_bank_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadBank(e.Text, selected_project, (sender as RadComboBox));
        }

        protected void cb_bank_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            RadComboBox cb = (RadComboBox)sender;
            GridEditableItem item = (GridEditableItem)cb.NamingContainer;

            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT KOBANK.*, ms_kurs.cur_code,ms_kurs.KursRun FROM KOBANK CROSS JOIN ms_kurs where " +
            " ms_kurs.tglKurs = (select MAX(ms_kurs.tglKurs) from ms_kurs) and NamBank = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["KoBank"].ToString();
                txt_cur_code = (RadTextBox)item.FindControl("txt_cur_code");
                txt_cur_code.Text = dr["cur_code"].ToString();

                txt_kurs = (RadNumericTextBox)item.FindControl("txt_kurs");
                txt_kurs.Text = dr["KursRun"].ToString();
                kursRun = Convert.ToDouble(dr["KursRun"].ToString());
            }
                
            dr.Close();
            con.Close();
        }

        protected void cb_bank_PreRender(object sender, EventArgs e)
        {
            RadComboBox cb = (RadComboBox)sender;
            GridEditableItem item = (GridEditableItem)cb.NamingContainer;

            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT KOBANK.*, ms_kurs.cur_code,ms_kurs.KursRun FROM KOBANK CROSS JOIN ms_kurs where " +
            " ms_kurs.tglKurs = (select MAX(ms_kurs.tglKurs) from ms_kurs) and NamBank = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["KoBank"].ToString();
                txt_cur_code = (RadTextBox)item.FindControl("txt_cur_code");
                txt_cur_code.Text = dr["cur_code"].ToString();

                txt_kurs = (RadNumericTextBox)item.FindControl("txt_kurs");
                txt_kurs.Text = dr["KursRun"].ToString();
                kursRun = Convert.ToDouble(dr["KursRun"].ToString());
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

            SqlDataAdapter adapter = new SqlDataAdapter("SELECT upper(name) as name, nik, upper(jabatan) as jabatan FROM ms_manpower " +
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

        protected void cb_prepared_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadManPower(e.Text, selected_project, (sender as RadComboBox));
        }

        protected void cb_prepared_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM ms_manpower WHERE name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_prepared_DataBound(object sender, EventArgs e)
        {
            ((Literal)(sender as RadComboBox).Footer.FindControl("RadComboItemsCount")).Text = Convert.ToString((sender as RadComboBox).Items.Count);
        }

        protected void cb_prepared_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM ms_manpower WHERE name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_checked_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadManPower(e.Text, selected_project, (sender as RadComboBox));
        }

        protected void cb_checked_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM ms_manpower WHERE name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_checked_DataBound(object sender, EventArgs e)
        {
            ((Literal)(sender as RadComboBox).Footer.FindControl("RadComboItemsCount")).Text = Convert.ToString((sender as RadComboBox).Items.Count);
        }

        protected void cb_checked_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM ms_manpower WHERE name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_approved_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadManPower(e.Text, selected_project, (sender as RadComboBox));
        }

        protected void cb_approved_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM ms_manpower WHERE name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_approved_DataBound(object sender, EventArgs e)
        {
            ((Literal)(sender as RadComboBox).Footer.FindControl("RadComboItemsCount")).Text = Convert.ToString((sender as RadComboBox).Items.Count);
        }

        protected void cb_approved_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM ms_manpower WHERE name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }
        #endregion

        #region KoRek
        protected void cb_korek_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            string sql = "SELECT [accountno], [accountname] FROM [gl_account]  WHERE stEdit != '4' AND accountname LIKE @accountname + '%'";
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

        protected void cb_korek_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            Session["accountno"] = e.Value;

            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "SELECT  gl_account.accountno,gl_account.accountname,gl_account.cur_code, glBank.kurs, glBank.KoTrans " + 
                                    "FROM gl_account INNER JOIN " + 
                                    "glBank ON gl_account.cur_code = glBank.cur_code WHERE accountno = '" + (sender as RadComboBox).SelectedValue + "'";
                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                foreach (DataRow dtr in dt.Rows)
                {
                    RadComboBox cb = (RadComboBox)sender;
                    GridEditableItem item = (GridEditableItem)cb.NamingContainer;
                    if (Session["actionDetail"].ToString() == "detailNew")
                    {
                        RadNumericTextBox t_kurs = (RadNumericTextBox)item.FindControl("txt_kursD_insert");
                        RadComboBox c_mutasi = (RadComboBox)item.FindControl("cb_mutasi_insert");
                        RadComboBox c_project = (RadComboBox)item.FindControl("cb_project_detail_insert");

                        t_kurs.Value = kursRun;
                        c_mutasi.Text = selected_KoTrans;
                        c_project.Text = selected_project;
                    }
                    else
                    {
                        RadNumericTextBox txt_kursD = (RadNumericTextBox)item.FindControl("txt_kursD");
                        Label lbl_MutasiD = (Label)item.FindControl("lbl_MutasiD");
                        RadComboBox c_project = (RadComboBox)item.FindControl("cb_project_detail");

                        txt_kursD.Text = dtr["kurs"].ToString();
                        lbl_MutasiD.Text = selected_KoTrans;
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

        protected void cb_korek_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT accountno FROM gl_account WHERE accountname = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }
        #endregion

        #region Mutasi
        protected void cb_mutasi_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Add("D");
            (sender as RadComboBox).Items.Add("K");
        }

        protected void cb_mutasi_PreRender(object sender, EventArgs e)
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

        protected void cb_mutasi_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
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
        protected void cb_project_detail_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            string sql = "SELECT [region_code], [region_name] FROM [ms_jobsite]  WHERE stEdit != '4' AND region_name LIKE @region_name + '%'";
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

        protected void cb_project_detail_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            Session["region_code"] = e.Value;

            try
            {
                //con.Open();
                //SqlCommand cmd = new SqlCommand();
                //cmd.Connection = con;
                //cmd.CommandType = CommandType.Text;
                //cmd.CommandText = "SELECT region_name FROM ms_jobsite WHERE region_code = '" + (sender as RadComboBox).SelectedValue + "'";

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

        protected void cb_project_detail_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT region_code FROM ms_jobsite WHERE region_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }
        #endregion

        #region Cost Center
        protected void LoadCostCtr(string name, string projectID, RadComboBox cb)
        {
            SqlConnection con = new SqlConnection(
          ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);

            SqlDataAdapter adapter = new SqlDataAdapter("SELECT upper(CostCenter) as code,upper(CostCenterName) as name FROM ms_cost_center " +
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

        protected void cb_cost_center_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            RadComboBox cb = (RadComboBox)sender;
            GridEditableItem item = (GridEditableItem)cb.NamingContainer;
            RadComboBox cb_project = (RadComboBox)item.FindControl("cb_project");

            (sender as RadComboBox).Text = "";
            LoadCostCtr(e.Text, selected_project, (sender as RadComboBox));
        }

        protected void cb_cost_center_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT CostCenter FROM ms_cost_center WHERE CostCenterName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
                selected_cost_ctr = dr["CostCenter"].ToString();
            }
            dr.Close();
            con.Close();
        }

        protected void cb_cost_center_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT CostCenter FROM ms_cost_center WHERE CostCenterName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
                selected_cost_ctr = dr["CostCenter"].ToString();
            }

            dr.Close();
            con.Close();

            //CalculateTotal();
        }

        #endregion

        protected void btnSave_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridEditableItem item = (GridEditableItem)btn.NamingContainer;

            RadTextBox txt_NoBuk = (RadTextBox)item.FindControl("txt_NoBuk");
            RadDatePicker dtp_bm = (RadDatePicker)item.FindControl("dtp_bm");
            RadTextBox txt_NoCtrl = (RadTextBox)item.FindControl("txt_NoCtrl");
            RadTextBox txt_NoRef = (RadTextBox)item.FindControl("txt_NoRef");
            RadComboBox cb_KoTrans = (RadComboBox)item.FindControl("cb_KoTrans");
            RadComboBox cb_project = (RadComboBox)item.FindControl("cb_project");
            RadComboBox cb_bank = (RadComboBox)item.FindControl("cb_bank");
            RadTextBox txt_cur_code = (RadTextBox)item.FindControl("txt_cur_code");
            RadNumericTextBox txt_kurs = (RadNumericTextBox)item.FindControl("txt_kurs");
            RadTextBox txt_Kontak = (RadTextBox)item.FindControl("txt_Kontak");
            RadTextBox txt_Ket = (RadTextBox)item.FindControl("txt_Ket");
            RadComboBox cb_prepared = (RadComboBox)item.FindControl("cb_prepared");
            RadComboBox cb_checked = (RadComboBox)item.FindControl("cb_checked");
            RadComboBox cb_approved = (RadComboBox)item.FindControl("cb_approved");

            Button btnCancel = (Button)item.FindControl("btnCancel");
            RadGrid Grid2 = (RadGrid)item.FindControl("RadGrid2");
            RadGrid RadGrid3 = (RadGrid)item.FindControl("RadGrid3");

            long maxNo;
            string run = null;
            string trDate = string.Format("{0:dd/MM/yyyy}", dtp_bm.SelectedDate);

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
                    cmd = new SqlCommand("SELECT ISNULL ( MAX ( RIGHT ( glBank.NoBuk , 4 ) ) , 0 ) + 1 AS maxNo " +
                        "FROM glBank WHERE LEFT(glBank.NoBuk, 4) ='" + cb_bank.SelectedValue + "' + '" + cb_KoTrans.SelectedValue + "' " +
                        "AND SUBSTRING(glBank.NoBuk, 5, 2) = SUBSTRING('" + trDate + "', 9, 2) " +
                        "AND SUBSTRING(glBank.NoBuk, 7, 2) = SUBSTRING('" + trDate + "', 4, 2) ", con);
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
                cmd.Parameters.AddWithValue("@region_code", public_str.site);
                cmd.Parameters.AddWithValue("@Owner", public_str.user_id);
                cmd.Parameters.AddWithValue("@Printed", 0);
                cmd.Parameters.AddWithValue("@Edited", 0);
                cmd.Parameters.AddWithValue("@Lvl", public_str.level);
                cmd.Parameters.AddWithValue("@Stamp", DateTime.Today);
                cmd.ExecuteNonQuery();

                foreach (GridDataItem itemD in Grid2.MasterTableView.Items)
                {
                    RadNumericTextBox txt_nomor;
                    RadComboBox cb_korek;
                    RadTextBox txt_KetD;
                    Label lbl_MutasiD;
                    RadNumericTextBox txt_kursD;
                    RadNumericTextBox txt_Jumlah;
                    RadComboBox cb_project_detail;
                    Label lbl_cost_center;

                    txt_nomor = (RadNumericTextBox)itemD.FindControl("txt_nomor");
                    cb_korek = (RadComboBox)itemD.FindControl("cb_korek");
                    txt_KetD = (RadTextBox)itemD.FindControl("txt_KetD");
                    lbl_MutasiD = (Label)itemD.FindControl("lbl_MutasiD");
                    txt_kursD = (RadNumericTextBox)itemD.FindControl("txt_kursD");
                    txt_Jumlah = (RadNumericTextBox)itemD.FindControl("txt_Jumlah");
                    cb_project_detail = (RadComboBox)itemD.FindControl("cb_project_detail");
                    lbl_cost_center = (Label)itemD.FindControl("lbl_cost_center");

                    cmd = new SqlCommand();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Connection = con;
                    cmd.CommandText = "sp_save_BankMutationD";
                    cmd.Parameters.AddWithValue("@NoBuk", run);
                    cmd.Parameters.AddWithValue("@KoRek", cb_korek.Text);
                    cmd.Parameters.AddWithValue("@Nmr", txt_nomor.Value);
                    cmd.Parameters.AddWithValue("@kurs", txt_kurs.Value);
                    cmd.Parameters.AddWithValue("@Jumlah", txt_Jumlah.Value);
                    cmd.Parameters.AddWithValue("@mutasi", lbl_MutasiD.Text);
                    cmd.Parameters.AddWithValue("@Ket", txt_KetD.Text);
                    cmd.Parameters.AddWithValue("@dept_code", lbl_cost_center.Text);
                    cmd.Parameters.AddWithValue("@region_code", cb_project_detail.Text);
                    cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
                    cmd.Parameters.AddWithValue("@Owner", public_str.user_id);
                    cmd.ExecuteNonQuery();

                }

                if ((sender as Button).Text == "Update")
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind();", true);
                }
                else
                {
                    txt_NoBuk.Text = run;
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind('navigateToInserted');", true);
                    (sender as Button).Text = "Update";
                    btnCancel.Text = "Close";
                }

                notif.Show("Data telah disimpan");
                tr_code = run;
                selected_project = cb_project.SelectedValue;

            }
            catch (Exception ex)
            {
                con.Close();
                Response.Write("<font color='red'>" + ex.Message + "</font>");
            }
            finally
            {
                con.Close();

                RadGrid3.DataSource = GetDataJournalTable(tr_code);
                RadGrid3.MasterTableView.DataBind();
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

        public DataTable GetDataJournalTable(string NoBuk)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_Bank_Mutation_journal";
            cmd.Parameters.AddWithValue("@doc_code", NoBuk);
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
            //double amount = 0;
            double sum = 0;

            sum = (Convert.ToDouble(txt_Jumlah));

            txt_total.Text = sum.ToString();

        }

        protected void RadGrid1_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridEditFormItem && e.Item.IsInEditMode)
            {
                //GridDataItem item = (GridDataItem)e.Item;
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

        protected void RadGrid2_ItemDataBound(object sender, GridItemEventArgs e)
        {

            if (e.Item is GridEditFormItem && e.Item.IsInEditMode)
            {
                var item = e.Item as GridEditFormItem;
                RadNumericTextBox txt_nomor_insert = item.FindControl("txt_nomor_insert") as RadNumericTextBox;
                RadComboBox cb_mutasi_insert = item.FindControl("cb_mutasi_insert") as RadComboBox;
                RadNumericTextBox txt_kursD_insert = item.FindControl("txt_kursD_insert") as RadNumericTextBox;
                RadNumericTextBox txt_Jumlah_insert = item.FindControl("txt_Jumlah_insert") as RadNumericTextBox;
                RadComboBox cb_project_detail_insert = item.FindControl("cb_project_detail_insert") as RadComboBox;

                if (e.Item.OwnerTableView.IsItemInserted)
                {
                    txt_nomor_insert.Value = 0;
                    cb_mutasi_insert.Text = selected_KoTrans;
                    txt_kursD_insert.Value = kursRun;
                    txt_Jumlah_insert.Value = 0;
                    cb_project_detail_insert.Text = selected_project;
                }

            }
        }

        //public static double total()
        //{
        //    double sum = 0;
        //    sum = (Convert.ToDouble(txt_Jumlah));            

        //    return sum;
        //}
    }

}