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

namespace TelerikWebApplication.Form.Inventory.LocationChange
{
    public partial class inv01h10 : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();

        private const int ItemsPerRequest = 10;
        public static string tr_code = null;
        public static string selected_project = null;
        public static string selected_cost_ctr = null;
        public static string selected_wh = null;
        DataTable dtValues;

        RadGrid RadGrid2;
        RadComboBox cb_project;
        private static string GetStatusMessage(int offset, int total)
        {
            if (total <= 0)
                return "No matches";

            return String.Format("Items <b>1</b>-<b>{0}</b> out of <b>{1}</b>", offset, total);
        }

        public DataTable DetailDtbl()
        {
            dtValues = new DataTable();
            dtValues.Columns.Add("tr_code", typeof(string));
            dtValues.Columns.Add("prod_code", typeof(string));
            dtValues.Columns.Add("ori_loc", typeof(string));
            dtValues.Columns.Add("dest_loc", typeof(string));
            dtValues.Columns.Add("qty", typeof(double));
            dtValues.Columns.Add("soh", typeof(double));
            dtValues.Columns.Add("uom", typeof(string));
            dtValues.Columns.Add("wh_code", typeof(string));
            dtValues.Columns.Add("run", typeof(int));

            return dtValues;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lbl_form_name.Text = "Material Location Changes";
                dtp_from.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
                dtp_to.SelectedDate = DateTime.Now;
                selected_project = public_str.site;
                cb_proj_prm.SelectedValue = public_str.site;
                cb_proj_prm.Text = public_str.sitename;

                tr_code = null;
                Session["action"] = "firstLoad";
                Session["TableDetail"] = null;
                Session["actionDetail"] = null;
                Session["actionHeader"] = null;
            }
        }
        public DataTable GetDataTable(string fromDate, string toDate, string project)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select * from v_location_change where st_edit != 4 and tr_date Between @date and @todate and region_code = @project";
            cmd.Parameters.AddWithValue("@date", fromDate);
            cmd.Parameters.AddWithValue("@todate", toDate);
            cmd.Parameters.AddWithValue("@project", project);
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
        protected void RadAjaxManager1_AjaxRequest(object sender, Telerik.Web.UI.AjaxRequestEventArgs e)
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
                    RadGrid1.DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), selected_project);
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
        #region Search
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            RadGrid1.DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), cb_proj_prm.SelectedValue);
            RadGrid1.DataBind();
        }
        protected void cb_proj_prm_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT region_code FROM inv00h09 WHERE region_name = '" + (sender as RadComboBox).Text + "'";
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

        protected void cb_proj_prm_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
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

        private static DataTable GetProjectPrm(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT region_code, region_name FROM inv00h09 WHERE stEdit != 4 AND region_name LIKE @text + '%' UNION SELECT 'ALL','ALL'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }

        protected void cb_project_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT region_code FROM inv00h09 WHERE region_name = '" + (sender as RadComboBox).Text + "'";
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
        

        protected void btnNew_Click(object sender, ImageClickEventArgs e)
        {
            Session["TableDetail"] = null;
            Session["actionHeader"] = "headerNew";
            RadGrid1.MasterTableView.IsItemInserted = true;
            RadGrid1.MasterTableView.Rebind();
        }

        protected void RadGrid1_ItemCreated(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                ImageButton printLink = (ImageButton)e.Item.FindControl("PrintLink");
                printLink.Attributes["href"] = "javascript:void(0);";
                printLink.Attributes["onclick"] = String.Format("return ShowPreview('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["tr_code"], e.Item.ItemIndex);

            }
        }

        protected void RadGrid1_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                tr_code = null;
                GridDataItem item = e.Item as GridDataItem;
                string kode = item["tr_code"].Text;
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
                        tr_code = gItem["tr_code"].Text;
                    }
                }

            }
        }

        protected void RadGrid1_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            (sender as RadGrid).DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), cb_proj_prm.SelectedValue);
        }

        protected void RadGrid1_DeleteCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridEditableItem item = (GridEditableItem)btn.NamingContainer;

            RadTextBox txt_tr_code = (RadTextBox)item.FindControl("txt_tr_code");
            RadDatePicker dtp_tr = (RadDatePicker)item.FindControl("dtp_tr");
            RadComboBox cb_project = (RadComboBox)item.FindControl("cb_project");
            RadComboBox cb_warehouse = (RadComboBox)item.FindControl("cb_warehouse");
            RadComboBox cb_prepare_by = (RadComboBox)item.FindControl("cb_prepare_by");
            RadComboBox cb_verified = (RadComboBox)item.FindControl("cb_verified");
            RadComboBox cb_approved = (RadComboBox)item.FindControl("cb_approved");
            RadTextBox txt_remark = (RadTextBox)item.FindControl("txt_remark");
                        
            Button btnCancel = (Button)item.FindControl("btnCancel");
            RadGrid Grid2 = (RadGrid)item.FindControl("RadGrid2");

            long maxNo;
            string run = null;
            string trDate = string.Format("{0:dd/MM/yyyy}", dtp_tr.SelectedDate);

            try
            {
                if ((sender as Button).Text == "Update")
                {
                    run = txt_tr_code.Text;
                }
                else
                {
                    con.Open();
                    SqlDataReader sdr;
                    cmd = new SqlCommand("SELECT ISNULL ( MAX ( RIGHT ( inv01h10.tr_code , 4 ) ) , 0 ) + 1 AS maxNo " +
                        "FROM inv01h10 WHERE LEFT(inv01h10.tr_code, 4) = 'LC01' " +
                        "AND SUBSTRING(inv01h10.tr_code, 5, 2) = SUBSTRING('" + trDate + "', 9, 2) " +
                        "AND SUBSTRING(inv01h10.tr_code, 7, 2) = SUBSTRING('" + trDate + "', 4, 2) ", con);
                    sdr = cmd.ExecuteReader();
                    if (sdr.HasRows == false)
                    {
                        //throw new Exception();
                        run = "LC01" + dtp_tr.SelectedDate.Value.Year + dtp_tr.SelectedDate.Value.Month + "0001";
                    }
                    else if (sdr.Read())
                    {
                        maxNo = Convert.ToInt32(sdr[0].ToString());
                        run = "LC01" + (dtp_tr.SelectedDate.Value.Year.ToString()).Substring(dtp_tr.SelectedDate.Value.Year.ToString().Length - 2) +
                            ("0000" + dtp_tr.SelectedDate.Value.Month).Substring(("0000" + dtp_tr.SelectedDate.Value.Month).Length - 2, 2) +
                            ("0000" + maxNo).Substring(("0000" + maxNo).Length - 4, 4);
                    }
                    con.Close();
                }


                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_save_location_changeH";
                cmd.Parameters.AddWithValue("@tr_code", run);
                cmd.Parameters.AddWithValue("@tr_date", string.Format("{0:yyyy-MM-dd}", dtp_tr.SelectedDate.Value));
                cmd.Parameters.AddWithValue("@region_code", selected_project);
                cmd.Parameters.AddWithValue("@wh_code", selected_wh);
                cmd.Parameters.AddWithValue("@remark", txt_remark.Text);
                cmd.Parameters.AddWithValue("@crtBy", cb_prepare_by.SelectedValue);
                cmd.Parameters.AddWithValue("@chkBy", cb_verified.SelectedValue);
                cmd.Parameters.AddWithValue("@appBy", cb_approved.SelectedValue);
                cmd.Parameters.AddWithValue("@userid", public_str.user_id);
                cmd.Parameters.AddWithValue("@Owner", public_str.user_id);
                cmd.Parameters.AddWithValue("@OwnStamp", DateTime.Today);
                cmd.Parameters.AddWithValue("@Lvl", public_str.level);
                cmd.ExecuteNonQuery();

                foreach (GridDataItem itemD in Grid2.MasterTableView.Items)
                {                   
                    Label lbl_prod_code = (Label)itemD.FindControl("lbl_prod_code");
                    Label lbl_ori_loc = (Label)itemD.FindControl("lbl_ori_loc");
                    Label lbl_dest_loc = (Label)itemD.FindControl("lbl_dest_loc");
                    Label lbl_qty = (Label)itemD.FindControl("lbl_qty");
                    Label lbl_uom = (Label)itemD.FindControl("lbl_uom_d");
                    Label lbl_soh = (Label)itemD.FindControl("lbl_soh");
                    //Label lbl_wh_code = (Label)itemD.FindControl("wh_code");

                    cmd = new SqlCommand();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Connection = con;
                    cmd.CommandText = "sp_save_location_changeD";
                    cmd.Parameters.AddWithValue("@tr_code", run);
                    cmd.Parameters.AddWithValue("@prod_code", lbl_prod_code.Text);
                    cmd.Parameters.AddWithValue("@ori_loc", lbl_ori_loc.Text);
                    cmd.Parameters.AddWithValue("@dest_loc", lbl_dest_loc.Text);
                    cmd.Parameters.AddWithValue("@qty", Convert.ToDecimal(lbl_qty.Text));
                    cmd.Parameters.AddWithValue("@soh", Convert.ToDecimal(lbl_soh.Text));
                    cmd.Parameters.AddWithValue("@uom", lbl_uom.Text);
                    cmd.Parameters.AddWithValue("@wh_code", selected_wh);
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
                txt_tr_code.Text = run;
                notif.Text = "Data telah disimpan";
                notif.Show();

                if ((sender as Button).Text == "Update")
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind();", true);
                }
                else
                {
                    tr_code = run;
                    selected_project = cb_project.SelectedValue;
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind('navigateToInserted');", true);
                    (sender as Button).Text = "Update";
                    btnCancel.Text = "Close";
                }

                RadGrid1.MasterTableView.IsItemInserted = false;
            }
        }
        #region Project
        private static DataTable GetProject(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT region_code, region_name FROM inv00h09 WHERE stEdit != 4 AND region_name LIKE @text + '%' ",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_project_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
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

        protected void cb_project_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT region_code FROM inv00h09 WHERE region_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
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

        protected void cb_approval_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadManPower(e.Text, selected_project, (sender as RadComboBox));
        }
        protected void cb_approval_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["nik"].ToString();
            }

            dr.Close();
            con.Close();
        }
        protected void cb_approval_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + (sender as RadComboBox).Text + "'";
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

        public DataTable GetDataDetailTable(string tr_code)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT inv01d10.tr_code, inv01d10.prod_code, inv00h01.spec, inv01d10.ori_loc, " +
                "inv01d10.dest_loc, inv01d10.qty, inv01d10.soh, inv01d10.uom, inv01d10.wh_code " +
                "FROM inv01d10 LEFT OUTER JOIN inv00h01 ON inv01d10.prod_code = inv00h01.prod_code WHERE tr_code = @tr_code";
            cmd.Parameters.AddWithValue("@tr_code", tr_code);
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
                drValue["tr_code"] = tr_code;
                drValue["prod_code"] = (item.FindControl("cb_prod_code_insert") as RadComboBox).Text;
                drValue["ori_loc"] = (item.FindControl("lbl_ori_loc_insert") as Label).Text;
                drValue["dest_loc"] = (item.FindControl("cb_dest_loc_insert") as RadComboBox).Text;
                drValue["qty"] = (item.FindControl("txt_qty_insert") as RadNumericTextBox).Value;
                drValue["soh"] = (item.FindControl("txt_soh_insert") as RadNumericTextBox).Value;
                drValue["uom"] = (item.FindControl("cb_uom_d_insert") as RadComboBox).Text;
                drValue["wh_code"] = selected_wh;
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
            drValue["tr_code"] = tr_code;
            drValue["prod_code"] = (item.FindControl("cb_prod_code") as RadComboBox).Text;
            drValue["ori_loc"] = (item.FindControl("lbl_ori_loc_edit") as Label).Text;
            drValue["dest_loc"] = (item.FindControl("cb_dest_loc") as RadComboBox).Text;
            drValue["qty"] = (item.FindControl("txt_qty") as RadNumericTextBox).Value;
            drValue["soh"] = (item.FindControl("txt_soh") as RadNumericTextBox).Value;
            drValue["uom"] = (item.FindControl("cb_uom_d") as RadComboBox).Text;
            drValue["wh_code"] = selected_wh;
            //drValue["run"] = 0;

            drValue.EndEdit(); //editing row in datatable
            dtValues.AcceptChanges();
            Session["TableDetail"] = dtValues;
            (sender as RadGrid).Rebind();
        }

        protected void RadGrid2_DeleteCommand(object sender, GridCommandEventArgs e)
        {

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

        
        #region location
        protected void LoadLocation(string name, string storage, RadComboBox cb)
        {
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);

            SqlDataAdapter adapter = new SqlDataAdapter("SELECT inv00h12.KdLok, inv00h12.NmLok, inv00h12.lastupdate, inv00h12.userid, inv00h12.stEdit, inv00h12.wh_code " +
            "FROM inv00h12 LEFT OUTER JOIN inv00d01 ON inv00h12.NmLok = inv00d01.KoLok " +
            "WHERE  (inv00h12.wh_code = @wh_code) AND (inv00d01.QACT = 0 OR inv00d01.KoLok IS NULL) AND inv00h12.stEdit <> '4'" +
             "AND inv00h12.NmLok LIKE @text + '%'", con);
            adapter.SelectCommand.Parameters.AddWithValue("@wh_code", storage);
            adapter.SelectCommand.Parameters.AddWithValue("@text", name);
            DataTable dt = new DataTable();
            adapter.Fill(dt);

            cb.DataTextField = "NmLok";
            cb.DataValueField = "NmLok";
            cb.DataSource = dt;
            cb.DataBind();
        }
        protected void cb_des_loc_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadLocation(e.Text, selected_wh, (sender as RadComboBox));
        }
       
        #endregion
        #region Product
        protected void cb_prod_code_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT prod_code FROM inv00h01 WHERE spec = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }
        protected void cb_prod_code_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            string sql = "SELECT TOP (100)[prod_code], [spec] FROM [inv00h01]  WHERE stEdit != '4' AND spec LIKE @spec + '%'";
            SqlDataAdapter adapter = new SqlDataAdapter(sql,
                ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
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
                item.Attributes.Add("spec", row["spec"].ToString());

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
                cmd.CommandText = "SELECT a.spec,a.unit,b.KoLok as lokasi,ISNULL(b.QACT,0) AS QACT FROM inv00h01 a, inv00d01 b WHERE a.prod_code = b.prod_code " +
                    "AND b.wh_code = '" + selected_wh + "' AND a.prod_code = '" + (sender as RadComboBox).SelectedValue + "'";

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                foreach (DataRow dtr in dt.Rows)
                {
                    RadComboBox cb = (RadComboBox)sender;
                    GridEditableItem item = (GridEditableItem)cb.NamingContainer;
                    if (Session["actionDetail"].ToString() == "detailNew")
                    {
                        Label lbl_ori_loc = (Label)item.FindControl("lbl_ori_loc_insert");
                        RadNumericTextBox txt_qty = (RadNumericTextBox)item.FindControl("txt_qty_insert");
                        RadComboBox cb_uom = (RadComboBox)item.FindControl("cb_uom_d_insert");
                        RadNumericTextBox txt_soh = (RadNumericTextBox)item.FindControl("txt_soh_insert");

                        lbl_ori_loc.Text = dtr["lokasi"].ToString();
                        cb_uom.Text = dtr["unit"].ToString();
                        txt_qty.Value = 0;
                        txt_soh.Text = dtr["QACT"].ToString();
                    }
                    else if (Session["actionDetail"].ToString() == "detailEdit")
                    {
                        Label lbl_ori_loc = (Label)item.FindControl("lbl_ori_loc_edit");
                        RadNumericTextBox txt_qty = (RadNumericTextBox)item.FindControl("txt_qty");
                        RadComboBox cb_uom = (RadComboBox)item.FindControl("cb_uom_d");
                        RadNumericTextBox txt_soh = (RadNumericTextBox)item.FindControl("txt_soh");

                        lbl_ori_loc.Text = dtr["lokasi"].ToString();
                        cb_uom.Text = dtr["unit"].ToString();
                        txt_qty.Value = 0;
                        txt_soh.Text = dtr["QACT"].ToString();
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

        #region Warehouse / Storage 
        private static DataTable GetWarehouse(string text, string project)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT wh_code, wh_name FROM inv00h05 WHERE stEdit != 4 AND PlantCode = @PlantCode AND wh_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@PlantCode", project);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_warehouse_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            RadComboBox cb = (RadComboBox)sender;
            GridEditableItem item = (GridEditableItem)cb.NamingContainer;

            cb_project = (RadComboBox)item.FindControl("cb_project");

            DataTable data = GetWarehouse(e.Text, cb_project.SelectedValue);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["wh_name"].ToString(), data.Rows[i]["wh_name"].ToString()));
            }
        }

        protected void cb_warehouse_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            RadComboBox cb = (RadComboBox)sender;
            GridEditableItem item = (GridEditableItem)cb.NamingContainer;

            RadGrid2 = (RadGrid)item.FindControl("RadGrid2");

            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT wh_code FROM inv00h05 WHERE wh_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
                selected_wh = dr[0].ToString();
            }
            dr.Close();

            foreach (GridDataItem Griditem in RadGrid2.MasterTableView.Items)
            {
                Label lblProdCode;
                RadComboBox cbKolok;
                lblProdCode = (Griditem.FindControl("lblProdCode") as Label);
                cbKolok = (Griditem.FindControl("cbKolok") as RadComboBox);

                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "SELECT inv00h12.KdLok, inv00h12.NmLok, inv00h12.lastupdate, inv00h12.userid, inv00h12.stEdit, inv00h12.wh_code " +
                                "FROM inv00h12 LEFT OUTER JOIN inv00d01 ON inv00h12.NmLok = inv00d01.KoLok " +
                                "WHERE  (inv00h12.wh_code = '" + (sender as RadComboBox).SelectedValue + "') AND " +
                                "inv00h12.stEdit <> '4' AND inv00d01.prod_code = '" + lblProdCode.Text + "' ";
                //SqlDataReader dr;
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    cbKolok.Text = dr["NmLok"].ToString();
                    cbKolok.Enabled = false;
                }
                dr.Close();

            }
            con.Close();
        }

        protected void cb_warehouse_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT wh_code FROM inv00h05 WHERE wh_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
                selected_wh = dr[0].ToString();
            }
            dr.Close();
            con.Close();
        }
        #endregion
        
    }
}