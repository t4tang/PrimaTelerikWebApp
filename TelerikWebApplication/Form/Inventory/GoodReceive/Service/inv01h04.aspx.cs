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

namespace TelerikWebApplication.Form.Inventory.GoodReceive.Service
{
    public partial class inv01h04 : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();

        private static bool isExceed = false;
        private const int ItemsPerRequest = 10;

        public static string tr_code = null;
        public static string selected_project = null;
        public static string selected_wh_code = null;
        public static string selected_reff_code = null;
        public static string tWarannty_check = null;
        DataTable dtValues;

        public DataTable DetailDtbl()
        {
            dtValues = new DataTable();
            dtValues.Columns.Add("lbm_code", typeof(string));
            dtValues.Columns.Add("Prod_code", typeof(string));
            dtValues.Columns.Add("prod_type", typeof(string));
            //dtValues.Columns.Add("dest_loc", typeof(string));
            dtValues.Columns.Add("KoLok", typeof(string));
            dtValues.Columns.Add("qty_Sisa", typeof(double));
            dtValues.Columns.Add("SatQty", typeof(string));
            dtValues.Columns.Add("dept_code", typeof(string));
            dtValues.Columns.Add("Remark", typeof(string));
            dtValues.Columns.Add("nocontr", typeof(string));
            dtValues.Columns.Add("twarranty", typeof(bool));

            return dtValues;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lbl_form_name.Text = "Service Receipt";
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

                    //RadGrid1.MasterTableView.Items[0].Selected = true;

                    //RadGrid2.DataSource = GetDataDetailTable(tr_code);
                    //RadGrid2.Rebind();
                }
                else if (e.Argument == "RebindAndNavigate")
                {
                    RadGrid1.MasterTableView.SortExpressions.Clear();
                    RadGrid1.MasterTableView.GroupByExpressions.Clear();
                    RadGrid1.DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), selected_project);
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
                
        #region searching parameter
        private static DataTable GetProjectPrm(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT region_code, region_name FROM ms_jobsite WHERE stEdit != 4 AND region_name LIKE @text + '%' UNION SELECT 'ALL','ALL'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_project_prm_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
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
        #endregion

        #region Header
        protected void RadGrid1_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            (sender as RadGrid).DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), cb_proj_prm.SelectedValue);
        }
        public DataTable GetDataTable(string date, string todate, string project)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_goods_receiveH";
            cmd.Parameters.AddWithValue("@date", date);
            cmd.Parameters.AddWithValue("@todate", todate);
            cmd.Parameters.AddWithValue("@project", project);
            cmd.Parameters.AddWithValue("@doc_type", "1");
            cmd.Parameters.AddWithValue("@trans_code", "1");
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
        protected void RadGrid1_ItemCreated(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                //ImageButton editLink = (ImageButton)e.Item.FindControl("EditLink");
                //editLink.Attributes["href"] = "javascript:void(0);";
                //editLink.Attributes["onclick"] = String.Format("return ShowEditForm('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["lbm_code"], e.Item.ItemIndex);

                ImageButton printLink = (ImageButton)e.Item.FindControl("PrintLink");
                printLink.Attributes["href"] = "javascript:void(0);";
                printLink.Attributes["onclick"] = String.Format("return ShowPreview('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["lbm_code"], e.Item.ItemIndex);

            }
        }
        protected void RadGrid1_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            var doc_code = ((GridDataItem)e.Item).GetDataKeyValue("lbm_code");

            try
            {
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_delete_goods_receive";
                cmd.Parameters.AddWithValue("@lbm_code", doc_code);
                cmd.Parameters.AddWithValue("@uid", public_str.user_id);
                cmd.ExecuteNonQuery();
                con.Close();

                notif.Text = "Data berhasil dihapus";
                notif.Title = "Notification";
                notif.Show();
            }
            catch (Exception ex)
            {
                con.Close();
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "");
                e.Canceled = true;
            }
        }
        protected void RadGrid1_SelectedIndexChanged(object sender, EventArgs e)
        {
            foreach (GridDataItem item in RadGrid1.SelectedItems)
            {
                tr_code = item["lbm_code"].Text;
                selected_wh_code = item["warehouse"].Text;
                selected_reff_code= item["ref_code"].Text;
            }

            populate_detail();
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
                    tr_code = gItem["lbm_code"].Text;
                }
                //populate_detail();
            }


            if ((sender as RadGrid).MasterTableView.Items.Count < (sender as RadGrid).MasterTableView.PageSize)
            {
                (sender as RadGrid).ClientSettings.Scrolling.AllowScroll = false;
                (sender as RadGrid).ClientSettings.Scrolling.UseStaticHeaders = false;
            }
        }
        #endregion

        #region Detail
        private void populate_detail()
        {
            if (tr_code == null)
            {
                //RadGrid2.DataSource = new string[] { };
            }
            else
            {
                //RadGrid2.DataSource = GetDataDetailTable(tr_code);
            }

            //RadGrid2.DataBind();
        }
        protected void RadGrid2_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            //if (tr_code == null)
            //{
            //    (sender as RadGrid).DataSource = new string[] { };
            //}
            //else
            //{
            //    (sender as RadGrid).DataSource = GetDataDetailTable(tr_code);
            //}

            if (Session["TableDetail"] == null && Session["actionHeader"].ToString() != "headerEdit") // Insert Session
            {
                if(Session["actionDetail"] != null)
                {
                    dtValues = (DataTable)Session["TableDetail"];
                    (sender as RadGrid).DataSource = dtValues; 
                    Session["TableDetail"] = dtValues;
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
        public DataTable GetDataDetailTable(string gr_code)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_goods_receiveD";
            cmd.Parameters.AddWithValue("@lbm_code", gr_code);
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
        }
        protected void RadGrid2_PreRender(object sender, EventArgs e)
        {
            //if ((sender as RadGrid).MasterTableView.Items.Count < (sender as RadGrid).MasterTableView.PageSize)
            //{
            //    (sender as RadGrid).ClientSettings.Scrolling.AllowScroll = false;
            //    (sender as RadGrid).ClientSettings.Scrolling.UseStaticHeaders = false;
            //}

            if ((sender as RadGrid).MasterTableView.Items.Count < (sender as RadGrid).MasterTableView.PageSize)
            {
                (sender as RadGrid).ClientSettings.Scrolling.AllowScroll = false;
                (sender as RadGrid).ClientSettings.Scrolling.UseStaticHeaders = false;
            }
            //else
            //{
            //    (sender as RadGrid).ClientSettings.Scrolling.AllowScroll = true;
            //    //(sender as RadGrid).ClientSettings.Scrolling.UseStaticHeaders = true;
            //    (sender as RadGrid).ClientSettings.Scrolling.ScrollHeight = 225;
            //}
        }
        protected void RadGrid2_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            var partCode = ((GridDataItem)e.Item).GetDataKeyValue("prod_code");

            try
            {
                GridEditableItem item = (GridEditableItem)e.Item;
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "delete from tr_lbmd where prod_code = @prod_code and lbm_code = @lbm_code";
                cmd.Parameters.AddWithValue("@lbm_code", tr_code);
                cmd.Parameters.AddWithValue("@prod_code", partCode);
                cmd.ExecuteNonQuery();
                con.Close();
                (sender as RadGrid).DataBind();

                notif.Text = "Data berhasil dihapus";
                notif.Title = "Notification";
                notif.Show();
            }
            catch (Exception ex)
            {
                con.Close();
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "");
                e.Canceled = true;
            }
        }
        protected void RadGrid2_UpdateCommand(object sender, GridCommandEventArgs e)
        {
            GridEditableItem item = (GridEditableItem)e.Item;

            dtValues = (DataTable)Session["TableDetail"];
            DataRow drValue = dtValues.Rows[0];
            //drValue["lbm_code"] = tr_code;
            drValue["prod_code"] = (item.FindControl("cbProdCodeEdit") as RadComboBox).Text;
            drValue["prod_type"] = (item.FindControl("lblProdTypEdit") as Label).Text;
            drValue["KoLok"] = (item.FindControl("cbKolokEdit") as RadComboBox).Text;
            drValue["qty_Sisa"] = (item.FindControl("txtPartQtyEdit") as RadNumericTextBox).Value;
            drValue["SatQty"] = (item.FindControl("cb_uom_d") as RadComboBox).Text;
            drValue["dept_code"] = (item.FindControl("cb_dept_d") as RadComboBox).Text;
            drValue["Remark"] = (item.FindControl("txtRemarkEdit") as RadTextBox).Text;
            drValue["nocontr"] = (item.FindControl("lblRsEdit") as Label).Text;
            drValue["twarranty"] = (item.FindControl("chkWarrantyEdit") as CheckBox).Checked;
            
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
                
                if (Session["actionDetail"].ToString() == "detailNew" && Session["TableDetail"] == null)
                {
                    DetailDtbl();

                    (sender as RadGrid).DataSource = dtValues; //populate RadGrid with datatable
                    Session["TableDetail"] = dtValues;
                }

                dtValues = (DataTable)Session["TableDetail"];
                DataRow drValue = dtValues.NewRow();
                drValue["lbm_code"] = tr_code;
                drValue["prod_code"] = (item.FindControl("cbProdCodeInsert") as RadComboBox).Text;
                drValue["prod_type"] = (item.FindControl("lblProdTypeInsert") as Label).Text;
                drValue["KoLok"] = (item.FindControl("cbKolokInsert") as RadComboBox).Text;
                drValue["qty_Sisa"] = (item.FindControl("txtPartQtyInsert") as RadNumericTextBox).Value;
                drValue["SatQty"] = (item.FindControl("cb_uom_d_insert") as RadComboBox).Text;
                drValue["dept_code"] = (item.FindControl("cb_dept_d_insert") as RadNumericTextBox).Value;
                drValue["Remark"] = (item.FindControl("cb_dept_d_insert") as RadTextBox).Text;
                drValue["nocontr"] = (item.FindControl("lblRsInsert") as Label).Text; 
                drValue["twarranty"] = (item.FindControl("chkWarrantyInsert") as CheckBox).Checked;
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
        #endregion

        //#region Cost Center
        //protected void LoadCostCtr(string name, string projectID, RadComboBox cb)
        //{
        //    SqlConnection con = new SqlConnection(
        //    ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);

        //    SqlDataAdapter adapter = new SqlDataAdapter("SELECT upper(CostCenter) as code,upper(CostCenterName) as name FROM ms_cost_center " +
        //        "WHERE stEdit <> '4' AND region_code = @project AND CostCenterName LIKE @text + '%'", con);
        //    adapter.SelectCommand.Parameters.AddWithValue("@project", projectID);
        //    adapter.SelectCommand.Parameters.AddWithValue("@text", name);
        //    DataTable dt = new DataTable();
        //    adapter.Fill(dt);

        //    cb.DataTextField = "name";
        //    cb.DataValueField = "code";
        //    cb.DataSource = dt;
        //    cb.DataBind();
        //}
        //protected void cb_cost_center_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        //{
        //    RadComboBox cb = (RadComboBox)sender;
        //    GridEditableItem item = (GridEditableItem)cb.NamingContainer;
        //    RadComboBox cb_project = (RadComboBox)item.FindControl("cb_project");

        //    (sender as RadComboBox).Text = "";
        //    LoadCostCtr(e.Text, selected_project, (sender as RadComboBox));

        //}
        //protected void cb_cost_center_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        //{
        //    con.Open();
        //    SqlCommand cmd = new SqlCommand();
        //    cmd.Connection = con;
        //    cmd.CommandType = CommandType.Text;
        //    cmd.CommandText = "SELECT CostCenter FROM ms_cost_center WHERE CostCenterName = '" + (sender as RadComboBox).Text + "'";
        //    SqlDataReader dr;
        //    dr = cmd.ExecuteReader();
        //    while (dr.Read())
        //    {
        //        (sender as RadComboBox).SelectedValue = dr["CostCenter"].ToString();
        //        selected_cost_ctr = dr["CostCenter"].ToString();
        //    }

        //    dr.Close();
        //    con.Close();
        //}
        //protected void cb_cost_center_PreRender(object sender, EventArgs e)
        //{
        //    con.Open();
        //    SqlCommand cmd = new SqlCommand();
        //    cmd.Connection = con;
        //    cmd.CommandType = CommandType.Text;
        //    cmd.CommandText = "SELECT CostCenter FROM ms_cost_center WHERE CostCenterName = '" + (sender as RadComboBox).Text + "'";
        //    SqlDataReader dr;
        //    dr = cmd.ExecuteReader();
        //    while (dr.Read())
        //    {
        //        (sender as RadComboBox).SelectedValue = dr["CostCenter"].ToString();
        //        selected_cost_ctr = dr["CostCenter"].ToString();
        //    }
        //    dr.Close();
        //    con.Close();
        //}
        //#endregion

        #region location
        protected void LoadLocation(string name, string storage, RadComboBox cb)
        {
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);

            SqlDataAdapter adapter = new SqlDataAdapter("SELECT ms_lokbar.KdLok, ms_lokbar.NmLok, ms_lokbar.lastupdate, ms_lokbar.userid, ms_lokbar.stEdit, ms_lokbar.wh_code " +
            "FROM ms_lokbar LEFT OUTER JOIN ms_product_detail ON ms_lokbar.NmLok = ms_product_detail.KoLok " +
            "WHERE  (ms_lokbar.wh_code = @wh_code) AND (ms_product_detail.QACT = 0 OR ms_product_detail.KoLok IS NULL) AND ms_lokbar.stEdit <> '4'" +
             "AND ms_lokbar.NmLok LIKE @text + '%'", con);
            adapter.SelectCommand.Parameters.AddWithValue("@wh_code", storage);
            adapter.SelectCommand.Parameters.AddWithValue("@text", name);
            DataTable dt = new DataTable();
            adapter.Fill(dt);

            cb.DataTextField = "NmLok";
            cb.DataValueField = "NmLok";
            cb.DataSource = dt;
            cb.DataBind();
        }
        protected void cbKolok_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadLocation(e.Text, selected_wh_code, (sender as RadComboBox));
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
            string sql = "SELECT TOP (100)[prod_code], [spec] FROM [ms_product]  WHERE stEdit != '4' AND spec LIKE @spec + '%'";
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
                cmd.CommandText = "SELECT a.spec,a.unit,b.KoLok as lokasi,ISNULL(b.QACT,0) AS QACT FROM ms_product a, ms_product_detail b WHERE a.prod_code = b.prod_code " +
                    "AND b.wh_code = '" + selected_wh_code + "' AND a.prod_code = '" + (sender as RadComboBox).SelectedValue + "'";

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                foreach (DataRow dtr in dt.Rows)
                {
                    RadComboBox cb = (RadComboBox)sender;
                    GridEditableItem item = (GridEditableItem)cb.NamingContainer;
                    if (Session["actionDetail"].ToString() == "detailNew")
                    {
                        //Label lbl_ori_loc = (Label)item.FindControl("lbl_ori_loc_insert");
                        RadNumericTextBox txt_qty = (RadNumericTextBox)item.FindControl("txt_qty_insert");
                        RadComboBox cb_uom = (RadComboBox)item.FindControl("cb_uom_d_insert");
                        //RadNumericTextBox txt_soh = (RadNumericTextBox)item.FindControl("txt_soh_insert");

                        //lbl_ori_loc.Text = dtr["lokasi"].ToString();
                        cb_uom.Text = dtr["unit"].ToString();
                        txt_qty.Value = 0;
                        //txt_soh.Text = dtr["QACT"].ToString();
                    }
                    //else if (Session["actionDetail"].ToString() == "detailEdit")
                    //{
                    //    //Label lbl_ori_loc = (Label)item.FindControl("lbl_ori_loc_edit");
                    //    RadNumericTextBox txt_qty = (RadNumericTextBox)item.FindControl("txt_qty");
                    //    RadComboBox cb_uom = (RadComboBox)item.FindControl("cb_uom_d");
                    //    //RadNumericTextBox txt_soh = (RadNumericTextBox)item.FindControl("txt_soh");

                    //    //lbl_ori_loc.Text = dtr["lokasi"].ToString();
                    //    cb_uom.Text = dtr["unit"].ToString();
                    //    txt_qty.Value = 0;
                    //    //txt_soh.Text = dtr["QACT"].ToString();
                    //}
                    else
                    {
                        //Label lbl_ori_loc = (Label)item.FindControl("lbl_ori_loc_edit");
                        RadNumericTextBox txt_qty = (RadNumericTextBox)item.FindControl("txtPartQty");
                        Label lb_uom = (Label)item.FindControl("lblUom");
                        //RadNumericTextBox txt_soh = (RadNumericTextBox)item.FindControl("txt_soh");

                        //lbl_ori_loc.Text = dtr["lokasi"].ToString();
                        lb_uom.Text = dtr["unit"].ToString();
                        txt_qty.Value = 0;
                        //txt_soh.Text = dtr["QACT"].ToString();
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
        protected void e_chkWarranty_CheckedChanged(object sender, EventArgs e)
        {
            if((sender as CheckBox).Checked == true)
            {
                tWarannty_check = "1";
            }
            else
            {
                tWarannty_check = "0";
            }
        }

        //protected void RadGrid2_PreRender(object sender, EventArgs e)
        //{
        //    if ((sender as RadGrid).MasterTableView.Items.Count < (sender as RadGrid).MasterTableView.PageSize)
        //    {
        //        (sender as RadGrid).ClientSettings.Scrolling.AllowScroll = false;
        //        (sender as RadGrid).ClientSettings.Scrolling.UseStaticHeaders = false;
        //    }
        //}

        #region Supplier
        private static DataTable GetSupplier(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select supplier_code, supplier_name from ms_supplier where supplier_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_supplier_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
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

        protected void cb_supplier_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select supplier_code from ms_supplier WHERE supplier_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["supplier_code"].ToString();
            dr.Close();

            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adapter.Fill(dt);

            con.Close();
        }

        protected void cb_supplier_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select supplier_code from ms_supplier WHERE supplier_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["supplier_code"].ToString();
            dr.Close();

            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adapter.Fill(dt);

            con.Close();
        }
        #endregion

        #region Project
        private static DataTable GetProject(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT region_code, region_name FROM ms_jobsite WHERE stEdit != 4 AND region_name LIKE @text + '%' ",
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

        protected void cb_project_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
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
                selected_project = dr[0].ToString();
            }
            dr.Close();
            con.Close();

        }

        protected void cb_project_PreRender(object sender, EventArgs e)
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

        #region Warehouse / Storage 
        private static DataTable GetWarehouse(string text, string project)
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
            DataTable data = GetWarehouse(e.Text, selected_project);

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
                selected_wh_code = dr[0].ToString();
            }
            dr.Close();

            RadComboBox cb = (RadComboBox)sender;
            GridEditableItem itm = (GridEditableItem)cb.NamingContainer;

            RadGrid RadGrid2 = (RadGrid)itm.FindControl("RadGrid2");

            foreach (GridDataItem item in RadGrid2.MasterTableView.Items)
            {
                Label lblProdCode;
                Label lblKolok;
                lblProdCode = (item.FindControl("lblProdCode") as Label);
                lblKolok = (item.FindControl("lblKolok") as Label);

                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "SELECT ms_lokbar.KdLok, ms_lokbar.NmLok, ms_lokbar.lastupdate, ms_lokbar.userid, ms_lokbar.stEdit, ms_lokbar.wh_code " +
                                "FROM ms_lokbar LEFT OUTER JOIN ms_product_detail ON ms_lokbar.NmLok = ms_product_detail.KoLok " +
                                "WHERE  (ms_lokbar.wh_code = '" + (sender as RadComboBox).SelectedValue + "') AND " +
                                "ms_lokbar.stEdit <> '4' AND ms_product_detail.prod_code = '" + lblProdCode.Text + "' ";
                //SqlDataReader dr;
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    lblKolok.Text = dr["NmLok"].ToString();
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
            cmd.CommandText = "SELECT wh_code FROM ms_warehouse WHERE wh_name = '" + (sender as RadComboBox).Text + "'";
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
        protected void cb_prepare_by_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadManPower(e.Text, selected_project, (sender as RadComboBox));
        }
        protected void cb_prepare_by_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
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
        protected void cb_prepare_by_PreRender(object sender, EventArgs e)
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
        protected void cb_orderBy_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadManPower(e.Text, selected_project, (sender as RadComboBox));
        }
        protected void cb_orderBy_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
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
        protected void cb_orderBy_PreRender(object sender, EventArgs e)
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
        protected void cb_received_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
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
        protected void cb_received_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadManPower(e.Text, selected_project, (sender as RadComboBox));
        }
        protected void cb_received_PreRender(object sender, EventArgs e)
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
        protected void cb_approved_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadManPower(e.Text, selected_project, (sender as RadComboBox));
        }
        protected void cb_approved_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
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
            {
                (sender as RadComboBox).SelectedValue = dr["nik"].ToString();
            }

            dr.Close();
            con.Close();
        }
        #endregion

        #region GR Source
        protected void cb_from_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Add("Supplier");
            //(sender as RadComboBox).Items.Add("Overhaul");
            (sender as RadComboBox).Items.Add("Consigment");
            (sender as RadComboBox).Items.Add("Return");
            (sender as RadComboBox).Items.Add("Assembly");
        }

        protected void cb_from_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if ((sender as RadComboBox).Text == "Supplier")
            {
                (sender as RadComboBox).SelectedValue = "1";
            }
            else if ((sender as RadComboBox).Text == "Consigment")
            {
                (sender as RadComboBox).SelectedValue = "2";
            }
            else if ((sender as RadComboBox).Text == "Return")
            {
                (sender as RadComboBox).SelectedValue = "3";
            }
            else if ((sender as RadComboBox).Text == "Assembly")
            {
                (sender as RadComboBox).SelectedValue = "4";
            }
            //else if ((sender as RadComboBox).Text == "Overhaul")
            //{
            //    (sender as RadComboBox).SelectedValue = "5";
            //}
        }

        protected void cb_from_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadComboBox).Text == "Return")
            {
                (sender as RadComboBox).SelectedValue = "1";
            }
            else if ((sender as RadComboBox).Text == "Consigment")
            {
                (sender as RadComboBox).SelectedValue = "2";
            }
            else if ((sender as RadComboBox).Text == "Supplier")
            {
                (sender as RadComboBox).SelectedValue = "3";
            }
            else if ((sender as RadComboBox).Text == "Assembly")
            {
                (sender as RadComboBox).SelectedValue = "4";
            }
            //else if ((sender as RadComboBox).Text == "Overhaul")
            //{
            //    (sender as RadComboBox).SelectedValue = "5";
            //}
        }
        #endregion

        #region Refferences

        private static DataTable GetReff(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("sp_get_goods_receive_ref",
             ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void LoadReff(string po_code, string project, string vendor, string typeRef, RadComboBox cb)
        {
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            DataTable dt = new DataTable();

            if (typeRef == "Supplier")
            {
                SqlDataAdapter adapter = new SqlDataAdapter("SELECT po_code, Po_date, remark FROM v_goods_receiveH_reff WHERE vendor_code = '" + vendor + "' " +
                    "AND PlantCode = '" + project + "' AND po_code LIKE @text + '%' ", con);
                adapter.SelectCommand.Parameters.AddWithValue("@vendor_code", vendor);
                adapter.SelectCommand.Parameters.AddWithValue("@project", project);
                adapter.SelectCommand.Parameters.AddWithValue("@text", po_code);
                //DataTable dt = new DataTable();
                adapter.Fill(dt);
            }
            
            cb.DataTextField = "po_code";
            cb.DataValueField = "po_code";
            cb.DataSource = dt;
            cb.DataBind();
        }
        protected void cb_ref_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            RadComboBox cb = (RadComboBox)sender;
            GridEditableItem item = (GridEditableItem)cb.NamingContainer;

            RadComboBox cb_supplier = (RadComboBox)item.FindControl("cb_supplier");
            RadComboBox cb_from = (RadComboBox)item.FindControl("cb_from");

            (sender as RadComboBox).Text = "";
            LoadReff(e.Text, selected_project, cb_supplier.SelectedValue, cb_from.Text, (sender as RadComboBox));

        }

        protected void cb_ref_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            RadComboBox cb = (RadComboBox)sender;
            GridEditableItem item = (GridEditableItem)cb.NamingContainer;

            RadComboBox cb_costcenter = (RadComboBox)item.FindControl("cb_costcenter");
            RadComboBox cb_from = (RadComboBox)item.FindControl("cb_from");
            RadComboBox cb_warehouse = (RadComboBox)item.FindControl("cb_warehouse");
            RadTextBox txt_reff_date = (RadTextBox)item.FindControl("txt_reff_date");
            RadTextBox txt_remark = (RadTextBox)item.FindControl("txt_remark");

            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            SqlDataReader dr;
            if (cb_from.Text == "Supplier")
            {
                cmd.CommandText = "SELECT * FROM v_goods_receiveH_reff WHERE po_code = '" + (sender as RadComboBox).SelectedValue + "'";
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    (sender as RadComboBox).Text = dr["po_code"].ToString();
                    txt_reff_date.Text = dr["Po_date"].ToString();
                    cb_costcenter.Text = dr["CostCenterName"].ToString();
                    txt_remark.Text = dr["remark"].ToString();
                }
                dr.Close();
            }

            con.Close();
            
            RadGrid RadGrid2 = (RadGrid)item.FindControl("RadGrid2");

            RadGrid2.DataSource = GetDataRefDetailTable((sender as RadComboBox).SelectedValue, cb_warehouse.SelectedValue);
            RadGrid2.DataBind();
        }

        public DataTable GetDataRefDetailTable(string doc_code, string wh_code)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_goods_receive_refD";
            cmd.Parameters.AddWithValue("@po_code", doc_code);
            cmd.Parameters.AddWithValue("@wh_code", wh_code);
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
                Session["TableDetail"] = dtValues;
            }

            return dtValues;
        }
        #endregion
        protected void btnSave_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridEditableItem item = (GridEditableItem)btn.NamingContainer;

            RadDatePicker dtp_gr = (RadDatePicker)item.FindControl("dtp_gr");
            CheckBox chk_posting =(CheckBox)item.FindControl("chk_posting");
            RadTextBox txt_gr_number = (RadTextBox)item.FindControl("txt_gr_number");
            RadComboBox cb_warehouse = (RadComboBox)item.FindControl("cb_warehouse");
            RadTextBox txt_delivery_note = (RadTextBox)item.FindControl("txt_delivery_note");
            RadTextBox txt_remark = (RadTextBox)item.FindControl("txt_remark");
            RadComboBox cb_ref = (RadComboBox)item.FindControl("cb_ref");
            RadComboBox cb_supplier = (RadComboBox)item.FindControl("cb_supplier");
            RadComboBox cb_createdBy = (RadComboBox)item.FindControl("cb_createdBy");
            RadComboBox cb_received = (RadComboBox)item.FindControl("cb_received");
            RadComboBox cb_approved = (RadComboBox)item.FindControl("cb_approved");
            RadComboBox cb_costcenter = (RadComboBox)item.FindControl("cb_costcenter");
            RadComboBox cb_project = (RadComboBox)item.FindControl("cb_project");
            RadGrid RadGrid2 = (RadGrid)item.FindControl("RadGrid2");
            RadGrid RadGrid3 = (RadGrid)item.FindControl("RadGrid3");
            Button btnCancel = (Button)item.FindControl("btnCancel");

            long maxNo;
            string run = null;
            string trDate = string.Format("{0:dd/MM/yyyy}", dtp_gr.SelectedDate);

            try
            {
                if (isExceed == true)
                {
                    RadWindowManager2.RadAlert("Transaction can not be proccess", 500, 200, "Error", null, "~/Images/error.png");
                    return;
                }
                else
                {
                    string x = dtp_gr.SelectedDate.Value.ToString("MM");
                    string y = public_str.perend.Substring(3, 2);

                    if (chk_posting.Checked == true)
                    {
                        RadWindowManager2.RadAlert("This transaction has been posted", 500, 200, "Error", null, "~/Images/error.png");
                        return;
                    }
                    else if (x != y)
                    {
                        RadWindowManager2.RadAlert("Transaction date outside the transaction period", 500, 200, "Error", null, "~/Images/error.png");
                        return;
                    }

                    if (Session["actionHeader"].ToString() == "headerEdit")
                    {
                        run = txt_gr_number.Text;

                    }
                    else
                    {
                        con.Open();
                        SqlDataReader sdr;
                        cmd = new SqlCommand("SELECT ISNULL ( MAX ( RIGHT ( tr_lbmh.lbm_code , 4 ) ) , 0 ) + 1 AS maxNo " +
                           "FROM tr_lbmh WHERE LEFT(tr_lbmh.lbm_code, 4) ='GR01' " +
                           "AND SUBSTRING(tr_lbmh.lbm_code, 5, 2) = SUBSTRING('" + trDate + "', 9, 2) " +
                           "AND SUBSTRING(tr_lbmh.lbm_code, 7, 2) = SUBSTRING('" + trDate + "', 4, 2) ", con);
                        sdr = cmd.ExecuteReader();
                        if (sdr.HasRows == false)
                        {
                            //throw new Exception();
                            run = "GR01" + dtp_gr.SelectedDate.Value.Year + dtp_gr.SelectedDate.Value.Month + "0001";
                        }
                        else if (sdr.Read())
                        {
                            maxNo = Convert.ToInt32(sdr[0].ToString());
                            run = "GR01" +
                                (dtp_gr.SelectedDate.Value.Year.ToString()).Substring(dtp_gr.SelectedDate.Value.Year.ToString().Length - 2) +
                                ("0000" + dtp_gr.SelectedDate.Value.Month).Substring(("0000" + dtp_gr.SelectedDate.Value.Month).Length - 2, 2) +
                                ("0000" + maxNo).Substring(("0000" + maxNo).Length - 4, 4);
                        }
                        con.Close();
                    }
                    txt_gr_number.Text = run;

                    con.Open();
                    cmd = new SqlCommand();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Connection = con;
                    cmd.CommandText = "sp_save_goods_receiveH";
                    cmd.Parameters.AddWithValue("@trans_code", "1");
                    cmd.Parameters.AddWithValue("@lbm_code", run);
                    cmd.Parameters.AddWithValue("@lbm_date", string.Format("{0:yyyy-MM-dd}", dtp_gr.SelectedDate.Value));
                    cmd.Parameters.AddWithValue("@wh_code", cb_warehouse.SelectedValue);
                    cmd.Parameters.AddWithValue("@sj", txt_delivery_note.Text);
                    cmd.Parameters.AddWithValue("@remark", txt_remark.Text);
                    cmd.Parameters.AddWithValue("@ref_code", cb_ref.Text);
                    cmd.Parameters.AddWithValue("@userid", public_str.uid);
                    cmd.Parameters.AddWithValue("@cust_code", cb_supplier.SelectedValue);
                    cmd.Parameters.AddWithValue("@cust_name", cb_supplier.Text);
                    //cmd.Parameters.AddWithValue("@ref_date", string.Format("{0:yyyy-MM-dd}", txt_reff_date.Text));
                    cmd.Parameters.AddWithValue("@createby", cb_createdBy.SelectedValue);
                    cmd.Parameters.AddWithValue("@Receiptby", cb_received.SelectedValue);
                    cmd.Parameters.AddWithValue("@approval", cb_approved.SelectedValue);
                    cmd.Parameters.AddWithValue("@dept_code", cb_costcenter.SelectedValue);
                    cmd.Parameters.AddWithValue("@region_code", cb_project.SelectedValue);
                    cmd.Parameters.AddWithValue("@Owner", public_str.uid);
                    cmd.Parameters.AddWithValue("@Lvl", public_str.level);
                    cmd.Parameters.AddWithValue("@doc_type", "1");

                    cmd.ExecuteNonQuery();

                    //Save Detail

                    foreach (GridDataItem itemD in RadGrid2.MasterTableView.Items)
                    {
                        cmd = new SqlCommand();
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Connection = con;
                        cmd.CommandText = "sp_save_goods_receiveD";
                        cmd.Parameters.AddWithValue("@lbm_code", run);
                        cmd.Parameters.AddWithValue("@prod_code", (itemD.FindControl("lblProdCode") as Label).Text);
                        cmd.Parameters.AddWithValue("@wh_code", cb_warehouse.SelectedValue);
                        cmd.Parameters.AddWithValue("@qty_receive", Convert.ToDouble((itemD.FindControl("txtPartQty") as RadTextBox).Text));
                        cmd.Parameters.AddWithValue("@ref_code", cb_ref.Text);
                        cmd.Parameters.AddWithValue("@koLok", (itemD.FindControl("lblKoLok") as Label).Text);
                        cmd.Parameters.AddWithValue("@UID", public_str.uid);
                        cmd.Parameters.AddWithValue("@SatQty", (itemD.FindControl("lblUom") as Label).Text);
                        cmd.Parameters.AddWithValue("@remark", (itemD.FindControl("txtRemark") as RadTextBox).Text);
                        cmd.Parameters.AddWithValue("@code", "GR");
                        if ((itemD.FindControl("chkWarranty") as CheckBox).Checked == true)
                        {
                            cmd.Parameters.AddWithValue("@twarranty", 1);
                        }
                        else
                        {
                            cmd.Parameters.AddWithValue("@twarranty", 0);
                        }

                        cmd.ExecuteNonQuery();

                    }

                    notif.Show("Data saved");
                    txt_gr_number.Text = run;

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

            }
            catch (System.Exception ex)
            {
                con.Close();
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
            }
            finally
            {
                con.Close();
                inv01h04.tr_code = run;
                inv01h04.selected_project = cb_project.SelectedValue;
                RadGrid3.DataSource = GetDataJournalTable(tr_code);
                RadGrid3.MasterTableView.DataBind();
            }
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
                string kode = item["lbm_code"].Text;
                tr_code = kode;
                selected_project = item["region_code"].Text;
                selected_wh_code = item["warehouse"].Text;

                Session["actionHeader"] = "headerEdit";
                Session["actionDetail"] = null;
            }
        }

        

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
        protected void cb_dept_d_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadCostCtr(e.Text, selected_project, (sender as RadComboBox));
        }

        protected void cb_dept_d_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT CostCenter FROM ms_cost_center WHERE CostCenterName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["CostCenter"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_dept_d_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
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
                (sender as RadComboBox).SelectedValue = dr["CostCenter"].ToString();
            }
            dr.Close();
            con.Close();
        }

        #endregion

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
            cmd.CommandText = "sp_get_goods_receive_journal";
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


        protected void validasi_jumlah(object sender, EventArgs e)
        {
            try
            {
                double qtySisa = 0;
                double qtyReceive = 0;

                RadTextBox tb = (RadTextBox)sender;
                GridEditableItem item = (GridEditableItem)tb.NamingContainer;
                RadTextBox txtPartQtySisa = (RadTextBox)item.FindControl("txtPartQtySisa");

                qtySisa = Convert.ToDouble(txtPartQtySisa.Text);
                qtyReceive = Convert.ToDouble((sender as RadTextBox).Text);

                if (qtyReceive > qtySisa)
                {
                    (sender as RadTextBox).ForeColor = System.Drawing.Color.Red;
                    notif.TitleIcon = "info";
                    notif.ContentIcon = "info";
                    notif.Show("Receive quantity exceeds the purchase quantity");
                    isExceed = true;
                }
                else
                {
                    //rGrid2.Controls.Add(new LiteralControl(string.Format("<span style='color:red'>{0}</span>", DBNull.Value)));
                    (sender as RadTextBox).ForeColor = System.Drawing.Color.Black;
                    isExceed = false;
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script language=\"javascript\">");
                if (ex.InnerException == null)
                {
                    Response.Write("alert(\"" + ex.Message.ToString() + "\");");
                }
                else
                {
                    Response.Write("alert(\"" + ex.InnerException.Message.ToString() + "\");");
                }
                Response.Write("</script>");
            }

        }

        protected void RadGrid1_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridEditFormItem && e.Item.IsInEditMode)
            {
                //GridDataItem item = (GridDataItem)e.Item;
                var item = e.Item as GridEditFormItem;
                RadComboBox cb_project = item.FindControl("cb_project") as RadComboBox;
                RadComboBox cb_from = item.FindControl("cb_from") as RadComboBox;
                RadDatePicker dtp_gr = item.FindControl("dtp_gr") as RadDatePicker;

                if (e.Item.OwnerTableView.IsItemInserted)
                {
                    cb_from.Text = "Supplier";
                    cb_project.Text = public_str.sitename;
                    dtp_gr.SelectedDate = DateTime.Now;
                }

            }
            
        }
    }

}