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

namespace TelerikWebApplication.Form.Inventory.GoodsIssued.Standard
{
    public partial class inv01h05 : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();

        private const int ItemsPerRequest = 10;
        public static string prod_code = null;

        public static string tr_code = null;
        public static string selected_project = null;
        public static string selected_wh_code = null;
        public static string selected_reff_code = null;
        public static string tWarannty_check = null;
        public static string selected_cost_ctr = null;
        public static string selected_info_code = null;
        public static string selected_supplier = null;
        public static string selected_type_reff = null;
        DataTable dtValues;

        RadComboBox cb_Project;
        RadComboBox cb_CostCenter;
        RadComboBox cb_ref;
        RadComboBox cb_type_ref;
        RadComboBox cb_warehouse;
        RadTextBox txt_CostCenterName;
        RadTextBox txt_unit;
        RadTextBox txt_remark;
        RadLabel lbl_reff_no;
        RadDatePicker dtp_date;
        CheckBox chk_posting;
        RadTextBox txt_gi_number;
        RadComboBox cb_CustSupp;
        RadComboBox cb_receipt;
        RadComboBox cb_issued;
        RadComboBox cb_approval;
        RadComboBox cb_costcenter;
        RadComboBox cb_project;
        RadGrid RadGrid2;
        Button btnCancel;

        public DataTable DetailDtbl()
        {
            dtValues = new DataTable();
            dtValues.Columns.Add("do_code", typeof(string));
            dtValues.Columns.Add("Prod_code", typeof(string));
            dtValues.Columns.Add("prod_code_ori", typeof(string));
            dtValues.Columns.Add("SOH", typeof(double));
            dtValues.Columns.Add("qty_out", typeof(double));
            dtValues.Columns.Add("uom", typeof(string));
            dtValues.Columns.Add("dept_code", typeof(string));
            dtValues.Columns.Add("wh_code", typeof(string));
            dtValues.Columns.Add("tWarranty", typeof(Boolean));
            dtValues.Columns.Add("remark", typeof(string));

            return dtValues;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lbl_form_name.Text = "Goods Issued";
                dtp_from.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
                dtp_to.SelectedDate = DateTime.Now;
                cb_proj_prm.SelectedValue = public_str.site;
                cb_proj_prm.Text = public_str.sitename;

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
                    RadGrid1.Rebind(); /* Kemudian RadGrid1 akan sorting data by lastupdate (lihat sp_get_purchase_requestH*/
                    RadGrid1.MasterTableView.Items[0].Selected = true;

                }
                else if (e.Argument == "RebindAndNavigate")
                {
                    RadGrid1.MasterTableView.SortExpressions.Clear();
                    RadGrid1.MasterTableView.GroupByExpressions.Clear();
                    RadGrid1.DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), cb_proj_prm.SelectedValue);
                    RadGrid1.DataBind();
                    RadGrid1.MasterTableView.CurrentPageIndex = RadGrid1.MasterTableView.PageCount - 1;
                    RadGrid1.MasterTableView.Items[RadGrid1.Items.Count - 1].Selected = true;
                    //RadGrid1.MasterTableView.Items[0].Selected = true;
                    //RadGrid2.DataSource = GetDataDetailTable(tr_code);
                    //RadGrid2.Rebind();
                    Session["action"] = "list";
                }
            }
            catch (Exception ex)
            {
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            RadGrid1.DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), cb_proj_prm.SelectedValue);
            RadGrid1.DataBind();
        }

        protected void RadGrid1_SelectedIndexChanged(object sender, EventArgs e)
        {
            foreach (GridDataItem item in RadGrid1.SelectedItems)
            {
                tr_code = item["do_code"].Text;
            }

            //populate_detail();
            Session["action"] = "list";
        }

        protected void RadGrid1_PreRender(object sender, EventArgs e)
        {
            if (Session["action"].ToString() == "firstLoad")
            {
                if (RadGrid1.MasterTableView.Items.Count > 0)
                    RadGrid1.MasterTableView.Items[0].Selected = true;

                foreach (GridDataItem gItem in RadGrid1.SelectedItems)
                {
                    tr_code = gItem["do_code"].Text;
                }
            }


            if ((sender as RadGrid).MasterTableView.Items.Count < (sender as RadGrid).MasterTableView.PageSize)
            {
                (sender as RadGrid).ClientSettings.Scrolling.AllowScroll = false;
                (sender as RadGrid).ClientSettings.Scrolling.UseStaticHeaders = false;
            }
        }

        private static string GetStatusMessage(int offset, int total)
        {
            if (total <= 0)
                return "No matches";

            return String.Format("Items <b>1</b>-<b>{0}</b> out of <b>{1}</b>", offset, total);
        }


        #region project param
        private static DataTable GetProjectPrm(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT region_code, region_name FROM ms_jobsite WHERE stEdit != 4 AND region_name LIKE @text + '%' UNION SELECT 'ALL','ALL'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_Project_prm_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetProjectPrm(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["region_name"].ToString(), data.Rows[i]["region_name"].ToString()));
            }
        }
        protected void cb_Project_prm_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
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

        #region storage loc

        protected void GetLoc(string name, string projectID, RadComboBox cb)
        {
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);

            SqlDataAdapter adapter = new SqlDataAdapter("SELECT upper(wh_code) as code,upper(wh_name) as name FROM ms_warehouse " +
                "WHERE stEdit <> '4' AND PlantCode = @project AND wh_name LIKE @text + '%'", con);
            adapter.SelectCommand.Parameters.AddWithValue("@project", projectID);
            adapter.SelectCommand.Parameters.AddWithValue("@text", name);
            DataTable dt = new DataTable();
            adapter.Fill(dt);

            cb.DataTextField = "name";
            cb.DataValueField = "code";
            cb.DataSource = dt;
            cb.DataBind();
        }
        protected void cb_loc_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            GetLoc(e.Text, cb_proj_prm.SelectedValue, (sender as RadComboBox));
        }

        //protected void cb_loc_PreRender(object sender, EventArgs e)
        //{
        //    con.Open();
        //    SqlCommand cmd = new SqlCommand();
        //    cmd.Connection = con;
        //    cmd.CommandType = CommandType.Text;
        //    cmd.CommandText = "SELECT wh_code FROM ms_warehouse WHERE wh_name = '" + cb_warehouse.Text + "'";
        //    SqlDataReader dr;
        //    dr = cmd.ExecuteReader();
        //    while (dr.Read())
        //        cb_warehouse.SelectedValue = dr["wh_code"].ToString();
        //    dr.Close();
        //    con.Close();
        //}

        //protected void cb_loc_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        //{
        //    con.Open();
        //    SqlCommand cmd = new SqlCommand();
        //    cmd.Connection = con;
        //    cmd.CommandType = CommandType.Text;
        //    cmd.CommandText = "SELECT wh_code FROM ms_warehouse WHERE wh_name = '" + cb_warehouse.Text + "'";
        //    SqlDataReader dr;
        //    dr = cmd.ExecuteReader();
        //    while (dr.Read())
        //        cb_warehouse.SelectedValue = dr["wh_code"].ToString();
        //    dr.Close();
        //    con.Close();
        //}
        #endregion

        #region Header
        public DataTable GetDataTable(string fromDate, string toDate, string project)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_goods_issuedH";
            cmd.Parameters.AddWithValue("@date", fromDate);
            cmd.Parameters.AddWithValue("@todate", toDate);
            cmd.Parameters.AddWithValue("@project", project);
            cmd.Parameters.AddWithValue("@type_do", "6");
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
            (sender as RadGrid).DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), cb_proj_prm.SelectedValue);
        }

        protected void RadGrid1_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            var do_code = ((GridDataItem)e.Item).GetDataKeyValue("do_code");

            try
            {
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "UPDATE tr_doh SET userid = @userid, lastupdate = GETDATE(), status_do = '4' WHERE (do_code = @do_code)";
                cmd.Parameters.AddWithValue("@do_code", do_code);
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
                //ImageButton editLink = (ImageButton)e.Item.FindControl("EditLink");
                //editLink.Attributes["href"] = "javascript:void(0);";
                //editLink.Attributes["onclick"] = String.Format("return ShowEditForm('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["do_code"], e.Item.ItemIndex);

                ImageButton printLink = (ImageButton)e.Item.FindControl("PrintLink");
                printLink.Attributes["href"] = "javascript:void(0);";
                printLink.Attributes["onclick"] = String.Format("return ShowPreview('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["do_code"], e.Item.ItemIndex);

            }
        }

        #endregion

        #region Detail

        //private void populate_detail()
        //{
        //    if (tr_code == null)
        //    {
        //        RadGrid2.DataSource = new string[] { };
        //    }
        //    else
        //    {
        //        RadGrid2.DataSource = GetDataDetailTable(tr_code);
        //    }

        //    RadGrid2.DataBind();
        //}
        public DataTable GetDataDetailTable(string do_code)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_goods_issuedD";
            cmd.Parameters.AddWithValue("@doh_code", do_code);
            cmd.CommandTimeout = 0;
            cmd.ExecuteNonQuery();
            sda = new SqlDataAdapter(cmd);

            //DataTable DT = new DataTable();
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

            //con.Open();
            //cmd = new SqlCommand();
            //cmd.CommandType = CommandType.Text;
            //cmd.Connection = con;
            //cmd.CommandText = "SELECT prod_code, prod_code_rsv, qty_out, wh_code, remark, do_code, nomor, prod_spec, unit_code, 0 AS Cek, hpokok, info_code, type_out, stmain, " +
            //"supplier_code, validdate, disc, price, stock_hand, tFullLink, Prod_code_ori, dept_code, tWarranty, remark " +
            //"FROM tr_dod WHERE  (do_code = @doh_code)";
            //cmd.Parameters.AddWithValue("@doh_code", do_code);
            //cmd.CommandTimeout = 0;
            //cmd.ExecuteNonQuery();
            //sda = new SqlDataAdapter(cmd);

            ////DataTable DT = new DataTable();
            //dtValues = new DataTable();

            //try
            //{
            //    sda.Fill(dtValues);
            //}
            //finally
            //{
            //    con.Close();
            //}

            //return dtValues;
        }
        
        protected void RadGrid2_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            if (Session["TableDetail"] == null && Session["actionHeader"].ToString() != "headerEdit") // Insert Session
            {
                if (Session["actionDetail"] != null)
                {
                    if(Session["actionDetail"].ToString() == "detailNew")
                    {
                        (sender as RadGrid).DataSource = new string[] { };
                    }
                    else
                    {
                        dtValues = (DataTable)Session["TableDetail"];
                        (sender as RadGrid).DataSource = dtValues;
                        Session["TableDetail"] = dtValues;
                    }

                }
                else
                {
                    (sender as RadGrid).DataSource = new string[] { };
                }

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
            var prod_code = ((GridDataItem)e.Item).GetDataKeyValue("prod_code");

            try
            {
                GridEditableItem item = (GridEditableItem)e.Item;
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "delete from tr_dod where prod_code = @prod_code and do_code = @do_code";
                cmd.Parameters.AddWithValue("@do_code", tr_code);
                cmd.Parameters.AddWithValue("@prod_code", prod_code);
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

        #region Type Reff
        //protected void cb_type_ref_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        //{
        //    (sender as RadComboBox).Items.Add("Consumption");
        //    (sender as RadComboBox).Items.Add("Assembly");
        //}

        //protected void cb_type_ref_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        //{
        //    if ((sender as RadComboBox).Text == "Consumption")
        //    {
        //        (sender as RadComboBox).SelectedValue = "6";
        //    }
        //    else if ((sender as RadComboBox).Text == "Assembly")
        //    {
        //        (sender as RadComboBox).SelectedValue = "7";
        //    }
        //}

        //protected void cb_type_ref_PreRender(object sender, EventArgs e)
        //{
        //    if ((sender as RadComboBox).Text == "Consumption")
        //    {
        //        (sender as RadComboBox).SelectedValue = "6";
        //    }
        //    else if ((sender as RadComboBox).Text == "Assembly")
        //    {
        //        (sender as RadComboBox).SelectedValue = "7";
        //    }
        //}

        #endregion 

        #region Type Project

        private static DataTable GetProject(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT region_code, region_name FROM ms_jobsite WHERE stEdit != 4 AND region_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }

        protected void cb_Project_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
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

        protected void cb_Project_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT region_code FROM ms_jobsite WHERE region_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
                selected_project = (sender as RadComboBox).SelectedValue;
            }
                
            dr.Close();
            con.Close();
        }
        protected void cb_Project_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT region_code FROM ms_jobsite WHERE region_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
                selected_project = (sender as RadComboBox).SelectedValue;
            }
                
            dr.Close();
            con.Close();
        }
        #endregion

        #region supplier

        private static DataTable GetCustSupp(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT cust_code, cust_name FROM ms_customer WHERE stEdit != 4 AND cust_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_CustSupp_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetCustSupp(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["cust_name"].ToString(), data.Rows[i]["cust_name"].ToString()));
            }
        }

        protected void cb_CustSupp_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT cust_code FROM ms_customer WHERE cust_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
                selected_supplier = dr[0].ToString();
            }                
            dr.Close();
            con.Close();
        }

        protected void cb_CustSupp_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {

            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT cust_code FROM ms_customer WHERE cust_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
                selected_supplier = dr[0].ToString();
            }
            dr.Close();
            con.Close();
        }
        #endregion

        //#region Cust/Sup
        //private static DataTable GetCustSupp(string text, string project)
        //{
        //    SqlDataAdapter adapter = new SqlDataAdapter("SELECT  info_code, supplier_code , region_code , cur_code , type_info , supplier_name  " +
        //    "FROM inv01h06 WHERE (inv01h06.type_info = '2') and (inv01h06.region_code = @project) AND supplier_name LIKE @text + '%'",
        //    ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
        //    adapter.SelectCommand.Parameters.AddWithValue("@text", text);
        //    adapter.SelectCommand.Parameters.AddWithValue("@project", project);

        //    DataTable data = new DataTable();
        //    adapter.Fill(data);

        //    return data;
        //}
        //protected void cb_CustSupp_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        //{
        //    DataTable data = GetCustSupp(e.Text,selected_project);

        //    int itemOffset = e.NumberOfItems;
        //    int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
        //    e.EndOfItems = endOffset == data.Rows.Count;

        //    for (int i = itemOffset; i < endOffset; i++)
        //    {
        //        (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["supplier_name"].ToString(), data.Rows[i]["supplier_name"].ToString()));
        //    }
        //}

        //protected void cb_CustSupp_PreRender(object sender, EventArgs e)
        //{
        //    con.Open();
        //    SqlCommand cmd = new SqlCommand();
        //    cmd.Connection = con;
        //    cmd.CommandType = CommandType.Text;
        //    cmd.CommandText = "SELECT supplier_code FROM inv01h06 WHERE supplier_name = '" + (sender as RadComboBox).Text + "'";
        //    SqlDataReader dr;
        //    dr = cmd.ExecuteReader();
        //    while (dr.Read())
        //    {
        //        (sender as RadComboBox).SelectedValue = dr["supplier_code"].ToString();
        //    }
        //    dr.Close();
        //    con.Close();
        //}

        //protected void cb_CustSupp_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        //{
        //    con.Open();
        //    SqlCommand cmd = new SqlCommand();
        //    cmd.Connection = con;
        //    cmd.CommandType = CommandType.Text;
        //    cmd.CommandText = "SELECT supplier_code FROM inv01h06 WHERE supplier_name = '" + (sender as RadComboBox).Text + "'";
        //    SqlDataReader dr;
        //    dr = cmd.ExecuteReader();
        //    while (dr.Read())
        //    {
        //        (sender as RadComboBox).SelectedValue = dr["supplier_code"].ToString();
        //    }
        //    dr.Close();
        //    con.Close();
        //}

        //#endregion

        //#region Referrence

        //private static DataTable GetReff(string text)
        //{
        //    SqlDataAdapter adapter = new SqlDataAdapter("select * from v_gi_reff WHERE doc_code LIKE @text + '%'",
        //     ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
        //    adapter.SelectCommand.Parameters.AddWithValue("@text", text);

        //    DataTable data = new DataTable();
        //    adapter.Fill(data);

        //    return data;
        //}

        //protected void LoadRef(string lbm_code, string projectID, RadComboBox cb)
        //{
        //    SqlConnection con = new SqlConnection(
        //    ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
        //    DataTable dt = new DataTable();

        //    SqlDataAdapter adapter = new SqlDataAdapter("SELECT lbm_code AS reff_code, ref_code AS rs_code, lbm_date, region_code, remark " +
        //    "FROM  inv01h04 WHERE trans_code = '3' AND(lbm_code LIKE @text + '%') AND(status_lbm = '3') AND(region_code = @project)", con);
        //    adapter.SelectCommand.Parameters.AddWithValue("@project", projectID);
        //    adapter.SelectCommand.Parameters.AddWithValue("@text", lbm_code);
        //    adapter.Fill(dt);

        //    //if (typeRef == "Consumption")
        //    //{
        //    //SqlDataAdapter adapter = new SqlDataAdapter("SELECT doc_code, doc_remark FROM v_gi_reffConsigment " +
        //        //"WHERE status_doc <> '4' AND region_code = @project AND doc_code LIKE @text + '%'", con);
        //        //adapter.SelectCommand.Parameters.AddWithValue("@project", projectID);
        //        //adapter.SelectCommand.Parameters.AddWithValue("@text", doc_code);
        //        ////DataTable dt = new DataTable();
        //        //adapter.Fill(dt);
        //    //}
        //    //else
        //    //{
        //    //    SqlDataAdapter adapter = new SqlDataAdapter("SELECT doc_code, doc_remark FROM v_gi_reffStock " +
        //    //    "WHERE status_doc <> '4' AND region_code = @project AND doc_code LIKE @text + '%'", con);
        //    //    adapter.SelectCommand.Parameters.AddWithValue("@project", projectID);
        //    //    adapter.SelectCommand.Parameters.AddWithValue("@text", doc_code);
        //    //    //DataTable dt = new DataTable();
        //    //    adapter.Fill(dt);
        //    //}


        //    cb.DataTextField = "reff_code";
        //    cb.DataValueField = "reff_code";
        //    cb.DataSource = dt;
        //    cb.DataBind();
        //}

        //protected void cb_ref_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        //{
        //    //RadComboBox cb = (RadComboBox)sender;
        //    //GridEditableItem item = (GridEditableItem)cb.NamingContainer;

        //    //RadComboBox cb_type_ref = (RadComboBox)item.FindControl("cb_type_ref");

        //    (sender as RadComboBox).Text = "";
        //    LoadRef(e.Text, selected_project, (sender as RadComboBox));
        //}

        //protected void cb_ref_PreRender(object sender, EventArgs e)
        //{
        //    RadComboBox cb = (RadComboBox)sender;
        //    GridEditableItem item = (GridEditableItem)cb.NamingContainer;
            
        //    RadTextBox txt_unit = (RadTextBox)item.FindControl("txt_unit");
        //    RadComboBox cb_CostCenter = (RadComboBox)item.FindControl("cb_CostCenter");
        //    RadComboBox cb_warehouse = (RadComboBox)item.FindControl("cb_warehouse");
        //    RadTextBox txt_CostCenterName = (RadTextBox)item.FindControl("txt_CostCenterName");
        //    RadTextBox txt_remark = (RadTextBox)item.FindControl("txt_remark");
        //    RadGrid RadGrid2 = (RadGrid)item.FindControl("RadGrid2");

        //    con.Open();
        //    SqlCommand cmd = new SqlCommand();
        //    cmd.Connection = con;
        //    cmd.CommandType = CommandType.Text;
        //    SqlDataReader dr;

        //    cmd.CommandText = "SELECT inv01h04.lbm_code, inv01h03.unit_code, inv01h04.dept_code, ms_cost_center.CostCenterName, inv01h04.remark, inv01h04.wh_code, " +
        //        "ms_warehouse.wh_name, inv01h04.po_code FROM inv01h04 INNER JOIN inv01h03 ON inv01h04.ref_code = inv01h03.doc_code LEFT OUTER JOIN " +
        //    "ms_cost_center ON inv01h04.dept_code = ms_cost_center.CostCenter LEFT OUTER JOIN ms_warehouse ON inv01h04.wh_code = ms_warehouse.wh_code " +
        //    "WHERE (lbm_code = '" + (sender as RadComboBox).SelectedValue + "')";
        //    dr = cmd.ExecuteReader();
        //    while (dr.Read())
        //    {               
        //        selected_wh_code = dr["wh_name"].ToString();
        //        selected_cost_ctr = dr["dept_code"].ToString();                
        //        selected_reff_code = (sender as RadComboBox).Text;
        //        selected_info_code = dr["po_code"].ToString();
        //    }

        //    dr.Close();
        //    con.Close();
        //}

        //protected void cb_ref_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        //{
        //    RadComboBox cb = (RadComboBox)sender;
        //    GridEditableItem item = (GridEditableItem)cb.NamingContainer;

        //    //RadComboBox cb_type_ref = (RadComboBox)item.FindControl("cb_type_ref");
        //    RadTextBox txt_unit = (RadTextBox)item.FindControl("txt_unit");
        //    RadComboBox cb_CostCenter = (RadComboBox)item.FindControl("cb_CostCenter");
        //    RadComboBox cb_warehouse = (RadComboBox)item.FindControl("cb_warehouse");
        //    RadTextBox txt_CostCenterName = (RadTextBox)item.FindControl("txt_CostCenterName");
        //    RadTextBox txt_remark = (RadTextBox)item.FindControl("txt_remark");
        //    RadGrid RadGrid2 = (RadGrid)item.FindControl("RadGrid2");

        //    con.Open();
        //    SqlCommand cmd = new SqlCommand();
        //    cmd.Connection = con;
        //    cmd.CommandType = CommandType.Text;
        //    SqlDataReader dr;

        //    cmd.CommandText = "SELECT inv01h04.lbm_code, inv01h03.unit_code, inv01h04.dept_code, ms_cost_center.CostCenterName, inv01h04.remark, inv01h04.wh_code, " +
        //        "ms_warehouse.wh_name, inv01h04.po_code FROM inv01h04 INNER JOIN inv01h03 ON inv01h04.ref_code = inv01h03.doc_code LEFT OUTER JOIN " +
        //    "ms_cost_center ON inv01h04.dept_code = ms_cost_center.CostCenter LEFT OUTER JOIN ms_warehouse ON inv01h04.wh_code = ms_warehouse.wh_code " +
        //    "WHERE (lbm_code = '" + (sender as RadComboBox).SelectedValue + "')";
        //    dr = cmd.ExecuteReader();
        //    while (dr.Read())
        //    {
        //        (sender as RadComboBox).Text = dr["lbm_code"].ToString();
        //        txt_unit.Text = dr["unit_code"].ToString();
        //        cb_warehouse.Text = dr["wh_name"].ToString(); 
        //        cb_CostCenter.Text = dr["dept_code"].ToString();
        //        txt_CostCenterName.Text = dr["CostCenterName"].ToString();
        //        txt_remark.Text = dr["remark"].ToString();
        //        selected_reff_code = (sender as RadComboBox).Text;
        //        selected_info_code = dr["po_code"].ToString();
        //    }
           
        //    dr.Close();
        //    con.Close();

        //    RadGrid2.DataSource = GetDataRefDetailTable((sender as RadComboBox).Text);
        //    RadGrid2.DataBind();
        //}
        //public DataTable GetDataRefDetailTable(string lbm_code)
        //{
        //    con.Open();
        //    cmd = new SqlCommand();
        //    cmd.CommandType = CommandType.StoredProcedure;
        //    cmd.Connection = con;
        //    cmd.CommandText = "sp_get_goods_issued_consignment_reffD";
        //    cmd.Parameters.AddWithValue("@reff_code", lbm_code);
        //    cmd.CommandTimeout = 0;
        //    cmd.ExecuteNonQuery();
        //    sda = new SqlDataAdapter(cmd);

        //    //DataTable DT = new DataTable();
        //    dtValues = new DataTable();

        //    try
        //    {
        //        sda.Fill(dtValues);
        //        Session["TableDetail"] = dtValues;
        //    }
        //    finally
        //    {
        //        con.Close();
        //    }

        //    return dtValues;

        //    //SqlDataAdapter sda = new SqlDataAdapter("SELECT prod_code, wh_code, remark, lbm_code, nomor, Spec, qty_receive AS qty_out, " +
        //    //    "hpokok, nocontr AS info_code, SatQty as unit_code, stmain, Prod_code_ori, dept_code, tWarranty " +
        //    //    "FROM inv01d04 WHERE  (lbm_code = '@reff_code')", ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
        //    //sda.SelectCommand.Parameters.AddWithValue("@reff_code", lbm_code);

        //    //dtValues = new DataTable();
        //    //sda.Fill(dtValues);
        //    //return dtValues;

        //}
        //#endregion


        #region Storage Loc
        private static DataTable GetStorage(string text, string project)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT wh_code, wh_name FROM ms_warehouse WHERE stEdit != 4 AND PlantCode = @PlantCode AND wh_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@PlantCode", project);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }

        protected void cb_warehouse_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetStorage(e.Text, selected_project);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["wh_name"].ToString(), data.Rows[i]["wh_name"].ToString()));
            }
        }

        protected void cb_warehouse_PreRender(object sender, EventArgs e)
        {
            RadComboBox cb = (RadComboBox)sender;
            GridEditableItem item = (GridEditableItem)cb.NamingContainer;

            RadComboBox cb_Project = (RadComboBox)item.FindControl("cb_Project");

            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT wh_code FROM ms_warehouse WHERE wh_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
                selected_wh_code = (sender as RadComboBox).SelectedValue;
            }
                
            dr.Close();
            con.Close();
        }

        protected void cb_warehouse_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT wh_code FROM ms_warehouse WHERE wh_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
                selected_wh_code = (sender as RadComboBox).SelectedValue;
            }
                
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

            cb.DataTextField = "name";
            cb.DataValueField = "code";
            cb.DataSource = dt;
            cb.DataBind();
        }
        protected void cb_CostCenter_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            RadComboBox cb = (RadComboBox)sender;
            GridEditableItem item = (GridEditableItem)cb.NamingContainer;

            RadComboBox cb_Project = (RadComboBox)item.FindControl("cb_Project");

            (sender as RadComboBox).Text = "";
            LoadCostCtr(e.Text, cb_Project.SelectedValue, (sender as RadComboBox));
        }

        protected void cb_CostCenter_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT CostCenter FROM ms_cost_center WHERE CostCenter = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
                selected_cost_ctr = (sender as RadComboBox).SelectedValue;
            }
                
            dr.Close();
            con.Close();
        }

        protected void cb_CostCenter_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT CostCenter FROM ms_cost_center WHERE CostCenter = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
                selected_cost_ctr = (sender as RadComboBox).SelectedValue;
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
        protected void cb_receipt_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            RadComboBox cb = (RadComboBox)sender;
            GridEditableItem item = (GridEditableItem)cb.NamingContainer;

            RadComboBox cb_Project = (RadComboBox)item.FindControl("cb_Project");

            (sender as RadComboBox).Text = "";
            LoadManPower(e.Text, cb_Project.SelectedValue, (sender as RadComboBox));
        }
        protected void cb_receipt_DataBound(object sender, EventArgs e)
        {
            ((Literal)(sender as RadComboBox).Footer.FindControl("RadComboItemsCount")).Text = Convert.ToString((sender as RadComboBox).Items.Count);
        }

        protected void cb_receipt_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM ms_manpower WHERE name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["nik"].ToString();
            }
                
            dr.Close();
            con.Close();
        }

        protected void cb_receipt_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM ms_manpower WHERE name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["nik"].ToString();
            }
                
            dr.Close();
            con.Close();
        }

        protected void cb_issued_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            RadComboBox cb = (RadComboBox)sender;
            GridEditableItem item = (GridEditableItem)cb.NamingContainer;

            RadComboBox cb_Project = (RadComboBox)item.FindControl("cb_Project");

            (sender as RadComboBox).Text = "";
            LoadManPower(e.Text, cb_Project.SelectedValue, (sender as RadComboBox));
        }
        protected void cb_issued_DataBound(object sender, EventArgs e)
        {
            ((Literal)(sender as RadComboBox).Footer.FindControl("RadComboItemsCount")).Text = Convert.ToString((sender as RadComboBox).Items.Count);
        }

        protected void cb_issued_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM ms_manpower WHERE name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["nik"].ToString();
            }
                
            dr.Close();
            con.Close();
        }

        protected void cb_issued_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM ms_manpower WHERE name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["nik"].ToString();
            }
                
            dr.Close();
            con.Close();
        }

        protected void cb_approval_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            RadComboBox cb = (RadComboBox)sender;
            GridEditableItem item = (GridEditableItem)cb.NamingContainer;

            RadComboBox cb_Project = (RadComboBox)item.FindControl("cb_Project");

            (sender as RadComboBox).Text = "";
            LoadManPower(e.Text, cb_Project.SelectedValue, (sender as RadComboBox));
        }

        protected void cb_approval_DataBound(object sender, EventArgs e)
        {
            ((Literal)(sender as RadComboBox).Footer.FindControl("RadComboItemsCount")).Text = Convert.ToString((sender as RadComboBox).Items.Count);
        }

        protected void cb_approval_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM ms_manpower WHERE name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["nik"].ToString();
            }
                
            dr.Close();
            con.Close();
        }

        protected void cb_approval_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM ms_manpower WHERE name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["nik"].ToString();
            }
                
            dr.Close();
            con.Close();
        }

        #endregion

        #region Journal
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

        public DataTable GetDataJournalTable(string doc_code)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_goods_issued_journal";
            cmd.Parameters.AddWithValue("@doc_code", doc_code);
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
        #endregion

        #region Product
        protected void cb_prod_code_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT prod_code FROM ms_product WHERE spec = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }
        protected void cb_prod_code_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            //string sql = "select part_code, part_desc, " +
            //"part_qty - ISNULL((select inv01d04.qty_receive from inv01h04, inv01d04 where inv01d04.prod_code = inv01d03.part_code AND inv01h04.lbm_code = inv01d04.lbm_code and inv01h04.ref_code = inv01d03.doc_code),0) as qty_Sisa " +
            //"from inv01d03 where doc_code = @doc_code AND (part_qty - ISNULL((select inv01d04.qty_receive from inv01h04, inv01d04 where inv01d04.prod_code = inv01d03.part_code AND inv01h04.lbm_code = inv01d04.lbm_code and inv01h04.ref_code = inv01d03.doc_code),0) > 0) AND part_desc LIKE @part_desc + '%'";
            string sql = "SELECT prod_code, Spec, qty_Sisa, SatQty FROM v_gi_consignment_reffD WHERE qty_sisa > 0 AND lbm_code = @lbm_code " +
                " AND Spec LIKE @spec + '%'";
            SqlDataAdapter adapter = new SqlDataAdapter(sql,
                ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@lbm_code", selected_reff_code);
            adapter.SelectCommand.Parameters.AddWithValue("@spec", e.Text);

            DataTable dt = new DataTable();
            adapter.Fill(dt);

            RadComboBox comboBox = (RadComboBox)sender;
            // Clear the default Item that has been re-created from ViewState at this point.
            comboBox.Items.Clear();

            foreach (DataRow row in dt.Rows)
            {
                RadComboBoxItem item = new RadComboBoxItem();
                item.Text = row["prod_code"].ToString();
                item.Value = row["prod_code"].ToString();
                item.Attributes.Add("Spec", row["Spec"].ToString());
                item.Attributes.Add("qty_Sisa", row["qty_Sisa"].ToString());
                item.Attributes.Add("SatQty", row["SatQty"].ToString());

                comboBox.Items.Add(item);

                item.DataBind();
            }
        }
        protected void cb_prod_code_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            Session["prod_code"] = e.Value;

            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "SELECT prod_type, part_code, SatQty AS part_unit, qty_Sisa FROM v_consignment_reffD " +
                    "WHERE qty_Sisa > 0 AND doc_code = '" + selected_reff_code + "' AND part_code = '" + (sender as RadComboBox).SelectedValue + "'";

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                foreach (DataRow dtr in dt.Rows)
                {
                    RadComboBox cb = (RadComboBox)sender;
                    GridEditableItem item = (GridEditableItem)cb.NamingContainer;
                    if (Session["actionDetail"].ToString() == "detailNew")
                    {
                        Label lblProdType = (Label)item.FindControl("lblProdTypeInsert");
                        RadNumericTextBox txt_qty = (RadNumericTextBox)item.FindControl("txtPartQtyInsert");
                        RadComboBox cb_uom = (RadComboBox)item.FindControl("cb_uom_d_insert");
                        Label lbl_info_code_insert = (Label)item.FindControl("lbl_info_code_insert");

                        lblProdType.Text = dtr["prod_type"].ToString();
                        cb_uom.Text = dtr["part_unit"].ToString();
                        txt_qty.Value = Convert.ToDouble(dtr["qty_Sisa"].ToString());
                        lbl_info_code_insert.Text = selected_info_code;
                    }
                    else if (Session["actionDetail"].ToString() == "detailEdit")
                    {
                        Label lblProdType = (Label)item.FindControl("lblProdTypEdit");
                        RadNumericTextBox txt_qty = (RadNumericTextBox)item.FindControl("txt_qty");
                        RadComboBox cb_uom = (RadComboBox)item.FindControl("cb_uom_d");
                        Label lbl_info_code = (Label)item.FindControl("lbl_info_code");

                        lblProdType.Text = dtr["prod_type"].ToString();
                        cb_uom.Text = dtr["part_unit"].ToString();
                        txt_qty.Value = Convert.ToDouble(dtr["qty_Sisa"].ToString());
                        lbl_info_code.Text = selected_info_code;
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

        protected void RadGrid2_InsertCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                GridEditableItem item = (GridEditableItem)e.Item;

                if (Session["actionDetail"].ToString() == "detailNew" && Session["TableDetail"] == null)
                {
                    DetailDtbl();

                    (sender as RadGrid).DataSource = dtValues; //populate RadGrid with datatable
                    Session["TableDetail"] = dtValues;
                }

                dtValues = (DataTable)Session["TableDetail"];
                DataRow drValue = dtValues.NewRow();
                //drValue["do_code"] = tr_code;
                drValue["Prod_code"] = (item.FindControl("lbl_ProdCode_insert") as Label).Text;
                drValue["prod_code_ori"] = (item.FindControl("lblProdCodeOri_insert") as Label).Text;
                drValue["SOH"] = (item.FindControl("lblSOH_insert") as Label).Text;
                drValue["qty_out"] = (item.FindControl("txt_Part_Qty_insert") as RadNumericTextBox).Value;
                drValue["uom"] = (item.FindControl("lblUominsert") as Label).Text;
                drValue["dept_code"] = (item.FindControl("lblCostCntrinsert") as Label).Text;
                drValue["wh_code"] = (item.FindControl("lblstorageinsert") as Label).Text;
                drValue["twarranty"] = (item.FindControl("chkWarrantyinsert") as CheckBox).Checked;
                drValue["remark"] = (item.FindControl("txtRemarkinsert") as RadTextBox).Text;
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
            DataRow drValue = dtValues.Rows[0];
            //drValue["do_code"] = tr_code;
            drValue["Prod_code"] = (item.FindControl("lbl_ProdCode_edit") as Label).Text;
            drValue["prod_code_ori"] = (item.FindControl("lblProdCodeOri_edit") as Label).Text;
            drValue["SOH"] = (item.FindControl("lblSOH_edit") as Label).Text;
            drValue["qty_out"] = (item.FindControl("txt_Part_Qty_edit") as RadNumericTextBox).Value;
            drValue["uom"] = (item.FindControl("lblUom_edit") as Label).Text;
            drValue["dept_code"] = (item.FindControl("lblCostCntr_edit") as Label).Text;
            drValue["wh_code"] = (item.FindControl("lblstorage_edit") as Label).Text;
            drValue["twarranty"] = (item.FindControl("chkWarranty_edit") as CheckBox).Checked;
            drValue["remark"] = (item.FindControl("txtRemark_edit") as RadTextBox).Text;

            drValue.EndEdit(); //editing row in datatable
            dtValues.AcceptChanges();
            Session["TableDetail"] = dtValues;
            (sender as RadGrid).Rebind();
        }

        protected void btnNew_Click(object sender, ImageClickEventArgs e)
        {
            Session["TableDetail"] = null;
            Session["actionHeader"] = "headerNew";
            RadGrid1.MasterTableView.IsItemInserted = true;
            RadGrid1.MasterTableView.Rebind();
        }

        protected void RadGrid1_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                tr_code = null;
                GridDataItem item = e.Item as GridDataItem;
                string kode = item["do_code"].Text;
                tr_code = kode;

                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "SELECT do_code,ref_code, dept_code,wh_code, region_code, info_code FROM tr_doh  WHERE do_code = '" + kode + "'";
                SqlDataReader dr;
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    selected_wh_code = dr["wh_code"].ToString();
                    selected_cost_ctr = dr["dept_code"].ToString();
                    selected_reff_code = dr["ref_code"].ToString();
                    selected_project = dr["region_code"].ToString();
                    selected_info_code = dr["info_code"].ToString();
                }

                dr.Close();
                con.Close();


                Session["actionHeader"] = "headerEdit";
                Session["actionDetail"] = null;

            }
        }

        protected void RadGrid1_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridEditFormItem && e.Item.IsInEditMode)
            {
                //GridDataItem item = (GridDataItem)e.Item;
                var item = e.Item as GridEditFormItem;
                RadComboBox cb_project = item.FindControl("cb_project") as RadComboBox;
                RadComboBox cb_type_ref = item.FindControl("cb_type_ref") as RadComboBox;
                RadComboBox cb_CustSupp = item.FindControl("cb_CustSupp") as RadComboBox;
                RadDatePicker dtp_date = item.FindControl("dtp_date") as RadDatePicker;

                RadTextBox txt_uid = item.FindControl("txt_uid") as RadTextBox;
                RadTextBox txt_lastUpdate = item.FindControl("txt_lastUpdate") as RadTextBox;
                RadTextBox txt_owner = item.FindControl("txt_owner") as RadTextBox;
                RadTextBox txt_printed = item.FindControl("txt_printed") as RadTextBox;
                RadTextBox txt_edited = item.FindControl("txt_edited") as RadTextBox;

                if (e.Item.OwnerTableView.IsItemInserted)
                {
                    cb_type_ref.Text = "Consumption";
                    cb_CustSupp.Text = "PRIMA SARANA GEMILANG, PT";
                    cb_project.Text = public_str.sitename;
                    dtp_date.SelectedDate = DateTime.Now;

                    txt_uid.Text = public_str.uid;
                    txt_lastUpdate.Text = string.Format("{0:dd-MM-yyyy}", DateTime.Today);
                    txt_owner.Text = public_str.uid;
                    txt_printed.Text = "0";
                    txt_edited.Text = "0";
                }

            }

        }

        protected void RadGrid2_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadGrid).MasterTableView.Items.Count < (sender as RadGrid).MasterTableView.PageSize)
            {
                (sender as RadGrid).ClientSettings.Scrolling.AllowScroll = false;
                (sender as RadGrid).ClientSettings.Scrolling.UseStaticHeaders = false;
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

        protected void btnSave_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridEditableItem item = (GridEditableItem)btn.NamingContainer;

            dtp_date = (RadDatePicker)item.FindControl("dtp_date");
            chk_posting = (CheckBox)item.FindControl("chk_posting");
            txt_gi_number = (RadTextBox)item.FindControl("txt_gi_number");
            cb_CustSupp = (RadComboBox)item.FindControl("cb_CustSupp");
            cb_warehouse = (RadComboBox)item.FindControl("cb_warehouse");
            txt_remark = (RadTextBox)item.FindControl("txt_remark");
            txt_unit = (RadTextBox)item.FindControl("txt_unit");
            cb_ref = (RadComboBox)item.FindControl("cb_ref");
            cb_receipt = (RadComboBox)item.FindControl("cb_receipt");
            cb_issued = (RadComboBox)item.FindControl("cb_issued");
            cb_approval = (RadComboBox)item.FindControl("cb_approval");
            cb_costcenter = (RadComboBox)item.FindControl("cb_costcenter");
            cb_project = (RadComboBox)item.FindControl("cb_project");
            RadGrid2 = (RadGrid)item.FindControl("RadGrid2");
            btnCancel = (Button)item.FindControl("btnCancel");
            cb_type_ref = (RadComboBox)item.FindControl("RadComboBox");

            RadGrid RadGrid3 = (RadGrid)item.FindControl("RadGrid3");

            long maxNo;
            string run = null;
            string trDate = string.Format("{0:dd/MM/yyyy}", dtp_date.SelectedDate);

            try
            {
                string x = dtp_date.SelectedDate.Value.ToString("MM");
                string y = public_str.perend.Substring(3, 2);

                if (chk_posting.Checked == true)
                {
                    RadWindowManager1.RadAlert("This transaction has been posted", 500, 200, "Error", null, "~/Images/error.png");
                    return;
                }
                else if (x != y)
                {
                    RadWindowManager1.RadAlert("Transaction date outside the transaction period", 500, 200, "Error", null, "~/Images/error.png");
                    return;
                }

                foreach (GridDataItem gdi in RadGrid2.MasterTableView.Items)
                {
                    Label lblSOH;
                    RadNumericTextBox txt_Part_Qty_edit;
                    lblSOH = (gdi.FindControl("lblSOH") as Label);
                    txt_Part_Qty_edit = (gdi.FindControl("txt_Part_Qty_edit") as RadNumericTextBox);

                    if ((Convert.ToDouble(lblSOH.Text) - Convert.ToDouble(txt_Part_Qty_edit.Text) < 0) && selected_type_reff != "8")
                    {
                        txt_Part_Qty_edit.Style.Add("color", "Red");
                        return;
                    }

                }


                if (Session["actionHeader"].ToString() == "headerEdit")
                {
                    run = txt_gi_number.Text;
                }
                else
                {
                    con.Open();
                    SqlDataReader sdr;
                    cmd = new SqlCommand("SELECT ISNULL ( MAX ( RIGHT ( tr_doh.do_code , 4 ) ) , 0 ) + 1 AS maxNo " +
                        "FROM tr_doh WHERE LEFT(tr_doh.do_code, 4) = 'GI01' " +
                        "AND SUBSTRING(tr_doh.do_code, 5, 2) = SUBSTRING('" + trDate + "', 9, 2) " +
                        "AND SUBSTRING(tr_doh.do_code, 7, 2) = SUBSTRING('" + trDate + "', 4, 2) ", con);
                    sdr = cmd.ExecuteReader();
                    if (sdr.HasRows == false)
                    {
                        //throw new Exception();
                        run = "GI01" + dtp_date.SelectedDate.Value.Year + dtp_date.SelectedDate.Value.Month + "0001";
                    }
                    else if (sdr.Read())
                    {
                        maxNo = Convert.ToInt32(sdr[0].ToString());
                        run = "GI01" + (dtp_date.SelectedDate.Value.Year.ToString()).Substring(dtp_date.SelectedDate.Value.Year.ToString().Length - 2) +
                            ("0000" + dtp_date.SelectedDate.Value.Month).Substring(("0000" + dtp_date.SelectedDate.Value.Month).Length - 2, 2) +
                            ("0000" + maxNo).Substring(("0000" + maxNo).Length - 4, 4);
                    }
                    sdr.Close();
                    con.Close();
                }

                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_save_goods_issuedH";
                cmd.Parameters.AddWithValue("@do_code", run);
                cmd.Parameters.AddWithValue("@type_do", selected_type_reff);
                cmd.Parameters.AddWithValue("@cust_code", selected_supplier);
                cmd.Parameters.AddWithValue("@region_code", selected_project);
                cmd.Parameters.AddWithValue("@dept_code", selected_cost_ctr);
                cmd.Parameters.AddWithValue("@wh_code", selected_wh_code);
                cmd.Parameters.AddWithValue("@ref_code", cb_ref.Text);
                cmd.Parameters.AddWithValue("@unit_code", txt_unit.Text);
                cmd.Parameters.AddWithValue("@Tgl", string.Format("{0:yyyy-MM-dd HH:mm:ss}",  dtp_date.SelectedDate.Value));
                cmd.Parameters.AddWithValue("@FreBy", cb_receipt.SelectedValue);
                cmd.Parameters.AddWithValue("@OrdBy", cb_issued.SelectedValue);
                cmd.Parameters.AddWithValue("@AppBy", cb_approval.SelectedValue);
                cmd.Parameters.AddWithValue("@remark", txt_remark.Text);
                cmd.Parameters.AddWithValue("@type_out", "N");
                cmd.Parameters.AddWithValue("@CntrDoc", 1);
                cmd.Parameters.AddWithValue("@status_post", 0);
                cmd.Parameters.AddWithValue("@sales_code", "NON");
                cmd.Parameters.AddWithValue("@to_wh_code", "NONE");
                cmd.Parameters.AddWithValue("@userid", public_str.user_id);
                cmd.Parameters.AddWithValue("@Owner", public_str.user_id);
                cmd.Parameters.AddWithValue("@lastupdate", DateTime.Today);
                cmd.Parameters.AddWithValue("@Printed", 0);
                cmd.Parameters.AddWithValue("@Edited", 0);
                cmd.Parameters.AddWithValue("@Lvl", public_str.level);
                cmd.Parameters.AddWithValue("@doc_type", 1);
                cmd.ExecuteNonQuery();

                foreach (GridDataItem gdi2 in RadGrid2.MasterTableView.Items)
                {
                    cmd = new SqlCommand();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Connection = con;
                    cmd.CommandText = "sp_save_goods_issuedD";
                    cmd.Parameters.AddWithValue("@do_code", run);
                    cmd.Parameters.AddWithValue("@prod_code", (gdi2.FindControl("lbl_ProdCode") as Label).Text);
                    prod_code = "Part Code " + (gdi2.FindControl("lbl_ProdCode") as Label).Text;
                    cmd.Parameters.AddWithValue("@prod_code_ori", (gdi2.FindControl("lblProdCodeOri") as Label).Text);
                    cmd.Parameters.AddWithValue("@qty_out", (gdi2.FindControl("txt_Part_Qty_edit") as RadNumericTextBox).Value);
                    cmd.Parameters.AddWithValue("@unit_code", (gdi2.FindControl("lblUom") as Label).Text);
                    cmd.Parameters.AddWithValue("@dept_code", (gdi2.FindControl("lblCostCntr") as Label).Text);
                    //cmd.Parameters.AddWithValue("@wh_code", (item.FindControl("lblstorage") as Label).Text);
                    cmd.Parameters.AddWithValue("@wh_code", selected_wh_code);
                    if ((gdi2.FindControl("chkWarranty") as CheckBox).Checked == true)
                    {
                        cmd.Parameters.AddWithValue("@twarranty", 1);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@twarranty", 0);
                    }
                    cmd.Parameters.AddWithValue("@remark", (gdi2.FindControl("txtRemark") as RadTextBox).Text);
                    cmd.Parameters.AddWithValue("@type_out", "N");
                    cmd.Parameters.AddWithValue("@date", string.Format("{0:yyyy-MM-dd}", dtp_date.SelectedDate.Value));
                    cmd.ExecuteNonQuery();
                }

                
                notif.Show("Data saved");
                txt_gi_number.Text = run;

                if ((sender as Button).Text == "Update")
                {
                    ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind();", true);
                }
                else
                {
                    tr_code = run;
                    selected_project = cb_project.SelectedValue;
                    ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind('navigateToInserted');", true);
                    (sender as Button).Text = "Update";
                    btnCancel.Text = "Close";
                }
            }
            catch (Exception ex)
            {
                RadWindowManager1.RadAlert("Error : " + ex, 500, 200, "Error", null, "~/Images/error.png");

                if (Session["actionHeader"].ToString() != "headerEdit")
                {
                    cmd = new SqlCommand();
                    cmd.CommandType = CommandType.Text;
                    cmd.Connection = con;
                    cmd.CommandText = "DELETE tr_doh WHERE do_code = '" + run + "'";
                    cmd.ExecuteNonQuery();
                }
                con.Close();
            }
            finally
            {                
                con.Close();
                tr_code = run;
                RadGrid3.DataSource = GetDataJournalTable(tr_code);
                RadGrid3.MasterTableView.DataBind();
            }


            //long maxNo;
            //string run = null;
            //string trDate = string.Format("{0:dd/MM/yyyy}", dtp_date.SelectedDate);

            //try
            //{
            //    string x = dtp_date.SelectedDate.Value.ToString("MM");
            //    string y = public_str.perend.Substring(3, 2);

            //    if (chk_posting.Checked == true)
            //    {
            //        RadWindowManager2.RadAlert("This transaction has been posted", 500, 200, "Error", null, "~/Images/error.png");
            //        return;
            //    }
            //    else if (x != y)
            //    {
            //        RadWindowManager2.RadAlert("Transaction date outside the transaction period", 500, 200, "Error", null, "~/Images/error.png");
            //        return;
            //    }

            //    if (Session["actionHeader"].ToString() == "headerEdit")
            //    {
            //        run = txt_gi_number.Text;

            //    }
            //    else
            //    {
            //        con.Open();
            //        SqlDataReader sdr;
            //        cmd = new SqlCommand("SELECT ISNULL ( MAX ( RIGHT ( tr_doh.do_code , 4 ) ) , 0 ) + 1 AS maxNo " +
            //           "FROM tr_doh WHERE LEFT(tr_doh.do_code, 4) ='GI01' " +
            //           "AND SUBSTRING(tr_doh.do_code, 5, 2) = SUBSTRING('" + trDate + "', 9, 2) " +
            //           "AND SUBSTRING(tr_doh.do_code, 7, 2) = SUBSTRING('" + trDate + "', 4, 2) ", con);
            //        sdr = cmd.ExecuteReader();
            //        if (sdr.HasRows == false)
            //        {
            //            //throw new Exception();
            //            run = "GI01" + dtp_date.SelectedDate.Value.Year + dtp_date.SelectedDate.Value.Month + "0001";
            //        }
            //        else if (sdr.Read())
            //        {
            //            maxNo = Convert.ToInt32(sdr[0].ToString());
            //            run = "GI01" +
            //                (dtp_date.SelectedDate.Value.Year.ToString()).Substring(dtp_date.SelectedDate.Value.Year.ToString().Length - 2) +
            //                ("0000" + dtp_date.SelectedDate.Value.Month).Substring(("0000" + dtp_date.SelectedDate.Value.Month).Length - 2, 2) +
            //                ("0000" + maxNo).Substring(("0000" + maxNo).Length - 4, 4);
            //        }
            //        con.Close();
            //    }
            //    txt_gi_number.Text = run;

            //    con.Open();
            //    cmd = new SqlCommand();
            //    cmd.CommandType = CommandType.StoredProcedure;
            //    cmd.Connection = con;
            //    cmd.CommandText = "sp_save_goods_issued_consignmentH";
            //    cmd.Parameters.AddWithValue("@do_code", run);
            //    cmd.Parameters.AddWithValue("@cust_code", public_str.company_code);
            //    cmd.Parameters.AddWithValue("@Tgl", string.Format("{0:yyyy-MM-dd}", dtp_date.SelectedDate.Value));
            //    cmd.Parameters.AddWithValue("@region_code", cb_project.SelectedValue);
            //    cmd.Parameters.AddWithValue("@ref_code", cb_ref.Text);
            //    cmd.Parameters.AddWithValue("@unit_code", txt_unit.Text);
            //    cmd.Parameters.AddWithValue("@wh_code", cb_warehouse.SelectedValue);
            //    cmd.Parameters.AddWithValue("@dept_code", cb_costcenter.SelectedValue);
            //    cmd.Parameters.AddWithValue("@remark", txt_remark.Text);
            //    cmd.Parameters.AddWithValue("@AppBy", cb_approval.SelectedValue);
            //    cmd.Parameters.AddWithValue("@OrdBy", cb_issued.SelectedValue);
            //    cmd.Parameters.AddWithValue("@FreBy", cb_receipt.SelectedValue);
            //    cmd.Parameters.AddWithValue("@userid", public_str.uid);
            //    cmd.Parameters.AddWithValue("@status_post", 0);
            //    cmd.Parameters.AddWithValue("@type_out", "C");
            //    cmd.Parameters.AddWithValue("@Lvl", public_str.level);
            //    cmd.Parameters.AddWithValue("@doc_type", "1");
            //    cmd.Parameters.AddWithValue("@info_code", selected_info_code);

            //    cmd.ExecuteNonQuery();

            //    //Save Detail

            //    foreach (GridDataItem itemD in RadGrid2.MasterTableView.Items)
            //    {
            //        cmd = new SqlCommand();
            //        cmd.CommandType = CommandType.StoredProcedure;
            //        cmd.Connection = con;
            //            cmd.CommandText = "sp_save_goods_issued_consignmentD";
            //        cmd.Parameters.AddWithValue("@do_code", run);
            //        cmd.Parameters.AddWithValue("@prod_code", (itemD.FindControl("lbl_ProdCode") as Label).Text);
            //        cmd.Parameters.AddWithValue("@prod_code_ori", (itemD.FindControl("lbl_ProdCode") as Label).Text);
            //        cmd.Parameters.AddWithValue("@info_code", selected_info_code);
            //        cmd.Parameters.AddWithValue("@qty_out", Convert.ToDouble((itemD.FindControl("lbl_Part_Qty") as Label).Text));
            //        cmd.Parameters.AddWithValue("@unit_code", (itemD.FindControl("lblUom") as Label).Text);
            //        cmd.Parameters.AddWithValue("@dept_code", cb_costcenter.SelectedValue);
            //        cmd.Parameters.AddWithValue("@type_out", "C");
            //        cmd.Parameters.AddWithValue("@wh_code", selected_wh_code);
            //        cmd.Parameters.AddWithValue("@twarranty", 0);
            //        cmd.Parameters.AddWithValue("@remark", (itemD.FindControl("lblremark") as Label).Text);
            //        cmd.Parameters.AddWithValue("@ref_code", selected_reff_code);
            //        cmd.ExecuteNonQuery();

            //    }

            //    con.Close();

            //    notif.Text = "Data berhasil disimpan";
            //    notif.Title = "Notification";
            //    notif.Show();
            //    txt_gi_number.Text = run;
            //    btnCancel.Text = "Close";
            //    (sender as Button).Text = "Update";

            //    if (Session["actionHeader"].ToString() == "headerEdit")
            //    {
            //        ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind();", true);
            //    }
            //    else
            //    {
            //        ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind('navigateToInserted');", true);
            //    }
            //    tr_doh.tr_code = run;
            //    tr_doh.selected_project = cb_project.SelectedValue;

            //}
            //catch (System.Exception ex)
            //{
            //    con.Close();
            //    RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
            //    return;
            //}
            //finally
            //{


            //    if (Session["actionHeader"].ToString() == "headerEdit")
            //    {
            //        ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind();", true);
            //    }
            //    else
            //    {
            //        ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind('navigateToInserted');", true);
            //    }

            //}
        }

        #region type reff
        protected void cb_type_ref_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Add("Consumption");
            //(sender as RadComboBox).Items.Add("Overhaul");
            (sender as RadComboBox).Items.Add("Stock Taking");
        }

        protected void cb_type_ref_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadComboBox).Text == "Consumption")
            {
                (sender as RadComboBox).SelectedValue = "6";
            }
            else if ((sender as RadComboBox).Text == "Stock Taking")
            {
                (sender as RadComboBox).SelectedValue = "7";
            }
            //else if ((sender as RadComboBox).Text == "Overhaul")
            //{
            //    (sender as RadComboBox).SelectedValue = "8";
            //}

            selected_type_reff = (sender as RadComboBox).SelectedValue;
        }

        protected void cb_type_ref_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if ((sender as RadComboBox).Text == "Consumption")
            {
                (sender as RadComboBox).SelectedValue = "6";
            }
            else if ((sender as RadComboBox).Text == "Stock Taking")
            {
                (sender as RadComboBox).SelectedValue = "7";
            }
            //else if ((sender as RadComboBox).Text == "Overhaul")
            //{
            //    (sender as RadComboBox).SelectedValue = "8";
            //}

            RadComboBox cb = (RadComboBox)sender;
            GridEditableItem item = (GridEditableItem)cb.NamingContainer;
            
            cb_CostCenter = (RadComboBox)item.FindControl("cb_CostCenter");
            cb_Project = (RadComboBox)item.FindControl("cb_Project");
            cb_ref = (RadComboBox)item.FindControl("cb_ref");
            txt_CostCenterName = (RadTextBox)item.FindControl("txt_CostCenterName");
            txt_remark = (RadTextBox)item.FindControl("txt_remark");
            txt_unit = (RadTextBox)item.FindControl("txt_unit");
            cb_CustSupp = (RadComboBox)item.FindControl("cb_CustSupp");
            RadGrid2 = (RadGrid)item.FindControl("RadGrid2");


            //(sender as RadComboBox).Text = string.Empty;
            cb_ref.SelectedValue = null;
            cb_Project.SelectedValue = null;
            cb_CostCenter.SelectedValue = null;
            txt_CostCenterName.Text = string.Empty;
            txt_unit.Text = string.Empty;
            txt_remark.Text = string.Empty;
            //lbl_reff_no.Text = string.Empty;
            selected_type_reff = (sender as RadComboBox).SelectedValue;
            cb_CustSupp.Text = public_str.company_name;
            selected_supplier = public_str.company_code;
        }
        #endregion

        #region refference

        private static DataTable GetReff(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select * from v_gi_reff WHERE doc_code LIKE @text + '%'",
             ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void LoadRef(string doc_code, string projectID, string typeRef, RadComboBox cb)
        {
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            DataTable dt = new DataTable();

            if (typeRef == "6")
            {
                SqlDataAdapter adapter = new SqlDataAdapter("SELECT TOP(20) doc_code , doc_remark FROM v_gi_reff " +
                "WHERE region_code = @project AND doc_code LIKE '%' + @text + '%'", con);
                adapter.SelectCommand.Parameters.AddWithValue("@project", projectID);
                adapter.SelectCommand.Parameters.AddWithValue("@text", doc_code);
                //DataTable dt = new DataTable();
                adapter.Fill(dt);
            }
            else if (typeRef == "8")
            {
                SqlDataAdapter adapter = new SqlDataAdapter("SELECT doc_code, doc_remark, lbm_code FROM v_gi_reff_with_ovh " +
                "WHERE overhaul = 1 AND status_doc <> '4' AND region_code = @project AND doc_code LIKE '%' + @text + '%'", con);
                adapter.SelectCommand.Parameters.AddWithValue("@project", projectID);
                adapter.SelectCommand.Parameters.AddWithValue("@text", doc_code);
                //DataTable dt = new DataTable();
                adapter.Fill(dt);
            }
            else
            {
                SqlDataAdapter adapter = new SqlDataAdapter("SELECT doc_code, doc_remark FROM v_gi_reffStock " +
                "WHERE status_doc <> '4' AND region_code = @project AND doc_code LIKE '%' + @text + '%'", con);
                adapter.SelectCommand.Parameters.AddWithValue("@project", projectID);
                adapter.SelectCommand.Parameters.AddWithValue("@text", doc_code);
                //DataTable dt = new DataTable();
                adapter.Fill(dt);
            }


            cb.DataTextField = "doc_code";
            cb.DataValueField = "doc_code";
            cb.DataSource = dt;
            cb.DataBind();
        }
        protected void cb_ref_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            RadComboBox cb = (RadComboBox)sender;
            GridEditableItem item = (GridEditableItem)cb.NamingContainer;

            cb_Project = (RadComboBox)item.FindControl("cb_Project");

            (sender as RadComboBox).Text = "";
            LoadRef(e.Text, selected_project, selected_type_reff, (sender as RadComboBox));
        }

        protected void cb_ref_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT doc_code FROM v_gi_reff WHERE doc_code = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            }

            dr.Close();
            con.Close();
        }

        protected void cb_ref_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            RadComboBox cb = (RadComboBox)sender;
            GridEditableItem item = (GridEditableItem)cb.NamingContainer;

            cb_type_ref = (RadComboBox)item.FindControl("cb_type_ref");
            cb_warehouse = (RadComboBox)item.FindControl("cb_warehouse");
            cb_CostCenter = (RadComboBox)item.FindControl("cb_CostCenter");
            txt_remark = (RadTextBox)item.FindControl("txt_remark");
            txt_unit = (RadTextBox)item.FindControl("txt_unit");
            txt_CostCenterName = (RadTextBox)item.FindControl("txt_CostCenterName");
            //lbl_reff_no = (RadLabel)item.FindControl("lbl_reff_no");
            RadGrid2 = (RadGrid)item.FindControl("RadGrid2");

            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            SqlDataReader dr;
            if (cb_type_ref.Text == "Consumption")
            {
                cmd.CommandText = "SELECT * FROM v_gi_reff WHERE doc_code = '" + (sender as RadComboBox).SelectedValue + "'";
                cmd.CommandTimeout = 0;
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    (sender as RadComboBox).Text = dr["doc_code"].ToString();
                    txt_unit.Text = dr["unit_code"].ToString();
                    cb_CostCenter.Text = dr["dept_code"].ToString();
                    txt_CostCenterName.Text = dr["CostCenterName"].ToString();
                    txt_remark.Text = dr["doc_remark"].ToString();
                    //lbl_reff_no.Text = string.Empty;
                    cb_warehouse.SelectedValue = dr["wh_code"].ToString();
                    cb_warehouse.Text = dr["wh_name"].ToString();
                }
            }
            else if (cb_type_ref.Text == "Overhaul")
            {
                cmd.CommandText = "SELECT * FROM v_gi_reff_with_ovh WHERE doc_code = '" + (sender as RadComboBox).SelectedValue + "'";
                cmd.CommandTimeout = 0;
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    (sender as RadComboBox).Text = dr["doc_code"].ToString();
                    txt_unit.Text = dr["unit_code"].ToString();
                    cb_CostCenter.Text = dr["dept_code"].ToString();
                    txt_CostCenterName.Text = dr["CostCenterName"].ToString();
                    txt_remark.Text = dr["doc_remark"].ToString();
                    lbl_reff_no.Text = "GR No. : " + dr["lbm_code"].ToString();
                    cb_warehouse.SelectedValue = dr["wh_code"].ToString();
                    cb_warehouse.Text = dr["wh_name"].ToString();
                }
            }
            else
            {
                cmd.CommandText = "SELECT * FROM v_gi_reffStock WHERE doc_code = '" + (sender as RadComboBox).SelectedValue + "'";
                cmd.CommandTimeout = 0;
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    (sender as RadComboBox).Text = dr["doc_code"].ToString();
                    txt_unit.Text = dr["unit_code"].ToString();
                    cb_CostCenter.Text = dr["dept_code"].ToString();
                    txt_CostCenterName.Text = dr["CostCenterName"].ToString();
                    txt_remark.Text = dr["doc_remark"].ToString();
                }
            }

            dr.Close();
            con.Close();


            RadGrid2.DataSource = GetDataRefDetailTable((sender as RadComboBox).SelectedValue);
            RadGrid2.DataBind();
        }
        #endregion
        public DataTable GetDataRefDetailTable(string tr_code)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_goods_issued_refD";
            cmd.Parameters.AddWithValue("@doc_code", tr_code);
            //cmd.Parameters.AddWithValue("@type_ref", "1");
            //cmd.Parameters.AddWithValue("@part_desc", cb_loc.SelectedValue);
            cmd.CommandTimeout = 0;
            cmd.ExecuteNonQuery();
            sda = new SqlDataAdapter(cmd);

            //DataTable DT = new DataTable();
            dtValues = new DataTable();

            try
            {
                sda.Fill(dtValues);
                Session["TableDetail"] = dtValues;
            }
            finally
            {
                con.Close();
            }

            return dtValues;
        }
    }
}