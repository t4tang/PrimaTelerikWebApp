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

namespace TelerikWebApplication.Form.Fico.Ledger.GeneralJournal
{
    public partial class acc01h07 : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();

        private const int ItemsPerRequest = 10;
        public static string tr_code = null;
        public static string selected_currency = null;
        public static String selected_project = null;
        public static string selected_CostCenter = null;

        DataTable dtValues;
        RadNumericTextBox txt_kurs;
        RadComboBox cb_currency_d;

        public DataTable DetailDtbl()
        {
            dtValues = new DataTable();
            dtValues.Columns.Add("voucherno", typeof(string));
            dtValues.Columns.Add("accountno", typeof(string));
            dtValues.Columns.Add("remark", typeof(string));
            dtValues.Columns.Add("cur_code", typeof(string));
            dtValues.Columns.Add("debet", typeof(double));
            dtValues.Columns.Add("credit", typeof(double));
            dtValues.Columns.Add("debet_idr", typeof(double));
            dtValues.Columns.Add("credit_idr", typeof(double));
            dtValues.Columns.Add("dept_code", typeof(string));
            dtValues.Columns.Add("region_code", typeof(string));
            dtValues.Columns.Add("run", typeof(int));

            return dtValues;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lbl_form_name.Text = "General Journal";
                dtp_from.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
                dtp_to.SelectedDate = DateTime.Now;
                selected_project = public_str.site;

                //set_info();
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

        protected void btnNew_Click(object sender, ImageClickEventArgs e)
        {
            Session["TableDetail"] = null;
            Session["actionHeader"] = "headerNew";
            RadGrid1.MasterTableView.IsItemInserted = true;
            RadGrid1.MasterTableView.Rebind();
        }

        #region RadGrid1
        public DataTable GetDataTable(string fromDate, string toDate)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_gjH";
            cmd.Parameters.AddWithValue("@date", fromDate);
            cmd.Parameters.AddWithValue("@todate", toDate);
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
            (sender as RadGrid).DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate));
        }

        protected void RadGrid1_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            var juCode = ((GridDataItem)e.Item).GetDataKeyValue("ju_code");
            try
            {
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "UPDATE acc01h10 SET userid = @userid, lastupdate = GETDATE(), stEdit = '4' WHERE (ju_code = @ju_code)";
                cmd.Parameters.AddWithValue("@ju_code", juCode);
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
                printLink.Attributes["onclick"] = String.Format("return ShowPreview('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["ju_code"], e.Item.ItemIndex);
            }
        }

        protected void RadGrid1_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                tr_code = null;
                GridDataItem item = e.Item as GridDataItem;
                string kode = item["ju_code"].Text;
                tr_code = kode;

                Session["actionHeader"] = "headerEdit";
                Session["actionDetail"] = null;
            }
        }

        protected void RadGrid1_SelectedIndexChanged(object sender, EventArgs e)
        {
            foreach (GridDataItem item in RadGrid1.SelectedItems)
            {
                tr_code = item["ju_code"].Text;
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
                        tr_code = gItem["ju_code"].Text;
                    }
                }
            }
        }
        #endregion

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            RadGrid1.DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate));
            RadGrid1.DataBind();
        }

        //protected void btnOK_Click(object sender, EventArgs e)
        //{
        //    foreach (GridDataItem item in RadGrid1.SelectedItems)
        //    {
        //        con.Open();
        //        SqlDataReader sdr;
        //        SqlCommand cmd = new SqlCommand("SELECT * FROM acc01h10 WHERE ju_code = '" + item["ju_code"].Text + "'", con);
        //        sdr = cmd.ExecuteReader();
        //        if (sdr.Read())
        //        {
        //            txt_ju_code.Text = sdr["ju_code"].ToString();
        //            txt_ref.Text = sdr["ref_code"].ToString();
        //            txt_ctrl.Text = sdr["ctrl_no"].ToString();
        //            dtp_bm.SelectedDate = Convert.ToDateTime(sdr["ju_date"].ToString());
        //            cb_currency.Text = sdr["cur_code"].ToString();
        //            txt_kurs.Text = sdr["kurs"].ToString();
        //            txt_user.Text = sdr["userid"].ToString();
        //            txt_lastupdate.Text = string.Format("{0:dd/MM/yyyy}", sdr["lastupdate"].ToString());

        //        }

        //        con.Close();

        //        RadGrid2.DataSource = GetDataDetailTable(txt_ju_code.Text);
        //        RadGrid2.DataBind();
        //        Session["action"] = "edit";
        //        RadGrid2.Enabled = true;
        //        btnSave.Enabled = true;
        //        btnSave.ImageUrl = "~/Images/simpan.png";
        //        btnPrint.Enabled = true;
        //        btnPrint.ImageUrl = "~/Images/cetak.png";
        //        btnPrint.Attributes["OnClick"] = String.Format("return ShowPreview('{0}');", txt_ju_code.Text);
        //    }
        //}

        //protected void btnSave_Click(object sender, ImageClickEventArgs e)
        //{
            
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
        //        else if (ctrl is CheckBox)
        //            ((CheckBox)ctrl).Enabled = state;
        //        else if (ctrl is RadDatePicker)
        //            ((RadDatePicker)ctrl).Enabled = state;
        //        else if (ctrl is RadGrid)
        //            ((RadGrid)ctrl).Enabled = state;

        //        control_status(ctrl.Controls, state);
        //    }
        //}

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
        //    txt_user.Text = public_str.uid;
        //    txt_lastupdate.Text = string.Format("{0:dd/MM/yyyy hh:mm:ss}", DateTime.Now);

        //}

        protected void cb_currency_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Add("EURO");
            (sender as RadComboBox).Items.Add("RUPIAH");
            (sender as RadComboBox).Items.Add("USD");
            (sender as RadComboBox).Items.Add("YEN JEPANG");
        }

        protected void cb_currency_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            RadComboBox cb = (RadComboBox)sender;
            GridEditableItem item = (GridEditableItem)cb.NamingContainer;

            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT acc00h03.cur_code, acc00h03.cur_name, acc00h04.KursRun FROM acc00h03, acc00h04 " +
                                "WHERE acc00h04.tglKurs = (SELECT MAX(tglKurs) FROM acc00h04 WHERE cur_code = acc00h03.cur_code) AND cur_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["cur_code"].ToString();
                txt_kurs = (RadNumericTextBox)item.FindControl("txt_kurs");
                txt_kurs.Value = Convert.ToDouble(dr["KursRun"].ToString());
            }
            dr.Close();
            con.Close();
        }

        protected void cb_currency_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadComboBox).Text == "EURO")
            {
                (sender as RadComboBox).SelectedValue = "EURO";
            }
            else if ((sender as RadComboBox).Text == "RUPIAH")
            {
                (sender as RadComboBox).SelectedValue = "IDR";
            }
            if ((sender as RadComboBox).Text == "USD")
            {
                (sender as RadComboBox).SelectedValue = "USD";
            }
            else if ((sender as RadComboBox).Text == "YEN JEPANG")
            {
                (sender as RadComboBox).SelectedValue = "JPY";
            }
        }

        #region RadGrid2
        public DataTable GetDataDetailTable(string ju_code)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_gjD";
            cmd.Parameters.AddWithValue("@voucherno", ju_code);
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
            var accountno = ((GridDataItem)e.Item).GetDataKeyValue("accountno");

            try
            {
                GridEditableItem item = (GridEditableItem)e.Item;
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "delete from acc01h07 where accountno = @accountno and voucherno = @voucherno";
                cmd.Parameters.AddWithValue("@voucherno", accountno);
                cmd.Parameters.AddWithValue("@accountno", accountno);
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
                drValue["voucherno"] = tr_code;
                drValue["accountno"] = (item.FindControl("cb_account_Insert") as RadComboBox).Text;
                drValue["remark"] = (item.FindControl("txt_remark_Insert") as RadTextBox).Text;
                drValue["cur_code"] = (item.FindControl("cb_currency_d_Insert") as RadComboBox).Text;
                drValue["debet"] = (item.FindControl("txt_debet_Insert") as RadNumericTextBox).Text;
                drValue["credit"] = (item.FindControl("txt_credit_Insert") as RadNumericTextBox).Text;
                drValue["debet_idr"] = (item.FindControl("txt_debet_idr_Insert") as RadNumericTextBox).Text;
                drValue["credit_idr"] = (item.FindControl("txt_credit_idr_Insert") as RadNumericTextBox).Text;
                drValue["region_code"] = (item.FindControl("cb_Project_Insert") as RadComboBox).Text;
                drValue["dept_code"] = (item.FindControl("cb_Cost_Center_Insert") as RadComboBox).Text;
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
            drValue["voucherno"] = tr_code;
            drValue["accountno"] = (item.FindControl("cb_account") as RadComboBox).Text;
            drValue["remark"] = (item.FindControl("txt_remark") as RadTextBox).Text;
            drValue["cur_code"] = (item.FindControl("cb_currency_d") as RadComboBox).Text;
            drValue["debet"] = (item.FindControl("txt_debet") as RadNumericTextBox).Text;
            drValue["credit"] = (item.FindControl("txt_credit") as RadNumericTextBox).Text;
            drValue["debet_idr"] = (item.FindControl("txt_debet_idr") as RadNumericTextBox).Text;
            drValue["credit_idr"] = (item.FindControl("txt_credit_idr") as RadNumericTextBox).Text;
            drValue["region_code"] = (item.FindControl("cb_Project") as RadComboBox).Text;
            drValue["dept_code"] = (item.FindControl("cb_Cost_Center") as RadComboBox).Text;
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

        #region Project
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
                    if (Session["actionDetail"].ToString() == "detailNew")
                    {
                        RadComboBox cb_costCtr_Insert = (RadComboBox)item.FindControl("cb_Cost_Center_Insert");
                        LoadCostCtr(cb_costCtr_Insert.Text, (sender as RadComboBox).SelectedValue, cb_costCtr_Insert);
                    }
                    else if (Session["actionDetail"].ToString() == "detailEdit")
                    {
                        RadComboBox cb_costCtr = (RadComboBox)item.FindControl("cb_Cost_Center");
                        LoadCostCtr(cb_costCtr.Text, (sender as RadComboBox).SelectedValue, cb_costCtr);
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

        #region Account RadGrid2
        protected void cb_account_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
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

        protected void cb_account_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            Session["accountno"] = e.Value;

            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "SELECT accountname,cur_code FROM acc00h10 WHERE accountno = '" + (sender as RadComboBox).SelectedValue + "'";

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                foreach (DataRow dtr in dt.Rows)
                {
                    RadComboBox cb = (RadComboBox)sender;
                    GridEditableItem item = (GridEditableItem)cb.NamingContainer;
                    if (Session["actionDetail"].ToString() == "detailNew")
                    {
                        RadComboBox cb_CurCode = (RadComboBox)item.FindControl("cb_currency_d_Insert");
                        cb_CurCode.Text = dtr["cur_code"].ToString();
                    }
                    else if (Session["actionDetail"].ToString() == "detailEdit")
                    {
                        RadComboBox cb_CurCode = (RadComboBox)item.FindControl("cb_currency_d");
                        cb_CurCode.Text = dtr["cur_code"].ToString();
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

        protected void cb_account_PreRender(object sender, EventArgs e)
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
            GridEditableItem item = (GridEditableItem)cb.NamingContainer;
            RadComboBox cb_project = (RadComboBox)item.FindControl("cb_Project");

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
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
                selected_CostCenter = dr["CostCenter"].ToString();
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
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
                selected_CostCenter = dr["CostCenter"].ToString();
            }

            dr.Close();
            con.Close();
        }

        protected void cb_currency_d_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Add("EURO");
            (sender as RadComboBox).Items.Add("IDR");
            (sender as RadComboBox).Items.Add("USD");
            (sender as RadComboBox).Items.Add("YEN");
        }

        protected void cb_currency_d_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadComboBox).Text == "EURO")
            {
                (sender as RadComboBox).SelectedValue = "EURO";
            }
            else if ((sender as RadComboBox).Text == "RUPIAH")
            {
                (sender as RadComboBox).SelectedValue = "IDR";
            }
            if ((sender as RadComboBox).Text == "USD")
            {
                (sender as RadComboBox).SelectedValue = "USD";
            }
            else if ((sender as RadComboBox).Text == "YEN JEPANG")
            {
                (sender as RadComboBox).SelectedValue = "JPY";
            }
        }

        protected void cb_currency_d_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if ((sender as RadComboBox).Text == "EURO")
            {
                (sender as RadComboBox).SelectedValue = "EURO";
            }
            else if ((sender as RadComboBox).Text == "RUPIAH")
            {
                (sender as RadComboBox).SelectedValue = "IDR";
            }
            if ((sender as RadComboBox).Text == "USD")
            {
                (sender as RadComboBox).SelectedValue = "USD";
            }
            else if ((sender as RadComboBox).Text == "YEN JEPANG")
            {
                (sender as RadComboBox).SelectedValue = "JPY";
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridEditableItem item = (GridEditableItem)btn.NamingContainer;

            RadTextBox txt_ju_code = (RadTextBox)item.FindControl("txt_ju_code");
            RadTextBox txt_ref = (RadTextBox)item.FindControl("txt_ref");
            RadTextBox txt_ctrl = (RadTextBox)item.FindControl("txt_ctrl");
            RadDatePicker dtp_bm = (RadDatePicker)item.FindControl("dtp_bm");
            RadComboBox cb_currency = (RadComboBox)item.FindControl("cb_currency");
            RadNumericTextBox txt_kurs = (RadNumericTextBox)item.FindControl("txt_kurs");
            RadTextBox txt_user = (RadTextBox)item.FindControl("txt_user");
            RadTextBox txt_lastupdate = (RadTextBox)item.FindControl("txt_lastupdate");

            Button btnCancel = (Button)item.FindControl("btnCancel");
            RadGrid Grid2 = (RadGrid)item.FindControl("RadGrid2");

            long maxNo;
            string run = null;
            string trDate = string.Format("{0:dd/MM/yyyy}", dtp_bm.SelectedDate);

            try
            {

                if (Session["action"].ToString() == "edit")
                {
                    run = txt_ju_code.Text;
                }
                else
                {
                    con.Open();
                    SqlDataReader sdr;
                    cmd = new SqlCommand("SELECT ISNULL ( MAX ( RIGHT ( acc01h10.ju_code , 4 ) ) , 0 ) + 1 AS maxNo " +
                        "FROM acc01h10 WHERE LEFT(acc01h10.ju_code, 4) = 'JU03'" +
                        "AND SUBSTRING(acc01h10.ju_code, 5, 2) = SUBSTRING('" + trDate + "', 9, 2) " +
                        "AND SUBSTRING(acc01h10.ju_code, 7, 2) = SUBSTRING('" + trDate + "', 4, 2) ", con);
                    sdr = cmd.ExecuteReader();
                    if (sdr.HasRows == false)
                    {
                        //throw new Exception();
                        run = "JU03" + dtp_bm.SelectedDate.Value.Year + dtp_bm.SelectedDate.Value.Month + "0001";
                    }
                    else if (sdr.Read())
                    {
                        maxNo = Convert.ToInt32(sdr[0].ToString());
                        run = "JU03" + (dtp_bm.SelectedDate.Value.Year.ToString()).Substring(dtp_bm.SelectedDate.Value.Year.ToString().Length - 2) +
                            ("0000" + dtp_bm.SelectedDate.Value.Month).Substring(("0000" + dtp_bm.SelectedDate.Value.Month).Length - 2, 2) +
                            ("0000" + maxNo).Substring(("0000" + maxNo).Length - 4, 4);
                    }
                    con.Close();
                }
                //GridEditableItem item = (GridEditableItem)e.Item;
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_save_gjH";
                //cmd.Parameters.AddWithValue("@Kode", "JU");
                cmd.Parameters.AddWithValue("@ju_code", run);
                //cmd.Parameters.AddWithValue("@accountno", (item.FindControl("cb_account") as RadComboBox).Text);
                cmd.Parameters.AddWithValue("@ju_date", string.Format("{0:yyyy-MM-dd}", dtp_bm.SelectedDate.Value));
                cmd.Parameters.AddWithValue("@ctrl_no", txt_ctrl.Text);
                cmd.Parameters.AddWithValue("@ref_code", txt_ref.Text);
                cmd.Parameters.AddWithValue("@cur_code", cb_currency.SelectedValue);
                cmd.Parameters.AddWithValue("@kurs", Convert.ToDouble(txt_kurs.Value));
                cmd.Parameters.AddWithValue("@userid", public_str.user_id);
                cmd.Parameters.AddWithValue("@lastupdate", DateTime.Today);
                cmd.Parameters.AddWithValue("@stEdit", "1");
                cmd.ExecuteNonQuery();

                foreach (GridDataItem itemD in Grid2.MasterTableView.Items)
                {
                    Label lbl_nomor;
                    Label lbl_accountno;
                    Label lbl_remark;
                    Label lbl_currency;
                    Label lbl_debet;
                    Label lbl_credit;
                    Label lbl_debet_idr;
                    Label lbl_credit_idr;
                    Label lbl_region;
                    Label lbl_dept;

                    lbl_nomor = (Label)itemD.FindControl("lbl_nomor");
                    lbl_accountno = (Label)itemD.FindControl("lbl_accountno");
                    lbl_remark = (Label)itemD.FindControl("lbl_remark");
                    lbl_currency = (Label)itemD.FindControl("lbl_currency");
                    lbl_debet = (Label)itemD.FindControl("lbl_debet");
                    lbl_credit = (Label)itemD.FindControl("lbl_credit");
                    lbl_debet_idr = (Label)itemD.FindControl("lbl_debet_idr");
                    lbl_credit_idr = (Label)itemD.FindControl("lbl_credit_idr");
                    lbl_region = (Label)itemD.FindControl("lbl_region");
                    lbl_dept = (Label)itemD.FindControl("lbl_dept");

                    cmd = new SqlCommand();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Connection = con;
                    cmd.CommandText = "sp_save_gjD";
                    cmd.Parameters.AddWithValue("@voucherno", run);
                    cmd.Parameters.AddWithValue("@accountno", lbl_accountno.Text);
                    cmd.Parameters.AddWithValue("@remark", lbl_remark.Text);
                    cmd.Parameters.AddWithValue("@cur_code", lbl_currency.Text);
                    cmd.Parameters.AddWithValue("@debet", Convert.ToDouble(lbl_debet.Text));
                    cmd.Parameters.AddWithValue("@credit", Convert.ToDouble(lbl_credit.Text));
                    cmd.Parameters.AddWithValue("@debet_idr", Convert.ToDouble(lbl_debet_idr.Text));
                    cmd.Parameters.AddWithValue("@credit_idr", Convert.ToDouble(lbl_credit_idr.Text));
                    cmd.Parameters.AddWithValue("@region_code", lbl_region.Text);
                    cmd.Parameters.AddWithValue("@dept_code", lbl_dept.Text);
                    cmd.Parameters.AddWithValue("@userid", public_str.user_id);
                    cmd.Parameters.AddWithValue("@lastupdate", DateTime.Today);
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
                txt_ju_code.Text = run;
                notif.Text = "Data telah disimpan";
                notif.Show();

                if ((sender as Button).Text == "Update")
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind();", true);
                }
                else
                {
                    acc01h07.tr_code = run;
                    //acc01h07.selected_project = cb_project.SelectedValue;
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind('navigateToInserted');", true);
                    (sender as Button).Text = "Update";
                    btnCancel.Text = "Close";
                }

                RadGrid1.MasterTableView.IsItemInserted = false;
            }
        }

        
    }
}
