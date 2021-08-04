using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using TelerikWebApplication.Class;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace TelerikWebApplication.Form.Inventory.StockOpname.Generate
{
    public partial class inv01h11 : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();

        private const int ItemsPerRequest = 10;

        public static string tr_code = null;
        public static string selected_project = null;
        public static string selected_wh_code = null;
        public static string selectedCostCenter = null;
        public static string tWarannty_check = null;
        DataTable dtValues;

        public DataTable DetailDtbl()
        {
            dtValues = new DataTable();
            dtValues.Columns.Add("rv_code", typeof(string));
            dtValues.Columns.Add("Prod_code", typeof(string));
            dtValues.Columns.Add("wh_code", typeof(string));
            dtValues.Columns.Add("Spec", typeof(string));
            dtValues.Columns.Add("qty_sis", typeof(double));
            dtValues.Columns.Add("SatQty", typeof(string));
            dtValues.Columns.Add("remark", typeof(string));
            dtValues.Columns.Add("dept_code", typeof(string));
            dtValues.Columns.Add("nomor", typeof(int));

            return dtValues;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lbl_form_name.Text = "Stock Opname (Generate)";
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

        protected void btnNew_Click(object sender, ImageClickEventArgs e)
        {
            Session["TableDetail"] = null;
            Session["actionHeader"] = "headerNew";
            RadGrid1.MasterTableView.IsItemInserted = true;
            RadGrid1.MasterTableView.Rebind();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridEditableItem item = (GridEditableItem)btn.NamingContainer;

            RadDatePicker dtp_so = (RadDatePicker)item.FindControl("dtp_so");
            CheckBox chk_posting = (CheckBox)item.FindControl("chk_posting");
            RadTextBox txt_so_number = (RadTextBox)item.FindControl("txt_so_number");
            RadComboBox cb_warehouse = (RadComboBox)item.FindControl("cb_warehouse");
            RadTextBox txt_remark = (RadTextBox)item.FindControl("txt_remark");
            RadComboBox cb_costcenter = (RadComboBox)item.FindControl("cb_costcenter");
            RadComboBox cb_project = (RadComboBox)item.FindControl("cb_project");
            RadGrid RadGrid2 = (RadGrid)item.FindControl("RadGrid2");
            Button btnCancel = (Button)item.FindControl("btnCancel");


            long maxNo;
            string run = null;
            string trDate = string.Format("{0:dd/MM/yyyy}", dtp_so.SelectedDate);

            try
            {
                string x = dtp_so.SelectedDate.Value.ToString("MM");
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
                    run = txt_so_number.Text;

                }
                else
                {
                    con.Open();
                    SqlDataReader sdr;
                    cmd = new SqlCommand("SELECT ISNULL ( MAX ( RIGHT ( tr_revisi_genH.rv_code , 4 ) ) , 0 ) + 1 AS maxNo " +
                       "FROM tr_revisi_genH WHERE LEFT(tr_revisi_genH.rv_code, 4) ='SR01' " +
                       "AND SUBSTRING(tr_revisi_genH.rv_code, 5, 2) = SUBSTRING('" + trDate + "', 9, 2) " +
                       "AND SUBSTRING(tr_revisi_genH.rv_code, 7, 2) = SUBSTRING('" + trDate + "', 4, 2) ", con);
                    sdr = cmd.ExecuteReader();
                    if (sdr.HasRows == false)
                    {
                        //throw new Exception();
                        run = "SR01" + dtp_so.SelectedDate.Value.Year + dtp_so.SelectedDate.Value.Month + "0001";
                    }
                    else if (sdr.Read())
                    {
                        maxNo = Convert.ToInt32(sdr[0].ToString());
                        run = "SR01" +
                            (dtp_so.SelectedDate.Value.Year.ToString()).Substring(dtp_so.SelectedDate.Value.Year.ToString().Length - 2) +
                            ("0000" + dtp_so.SelectedDate.Value.Month).Substring(("0000" + dtp_so.SelectedDate.Value.Month).Length - 2, 2) +
                            ("0000" + maxNo).Substring(("0000" + maxNo).Length - 4, 4);
                    }
                    con.Close();
                }
                txt_so_number.Text = run;

                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_save_stock_opnameH";
                cmd.Parameters.AddWithValue("@rv_code", run);
                cmd.Parameters.AddWithValue("@rv_date", string.Format("{0:yyyy-MM-dd}", dtp_so.SelectedDate.Value));
                cmd.Parameters.AddWithValue("@wh_code", cb_warehouse.SelectedValue);
                cmd.Parameters.AddWithValue("@userid", public_str.uid);
                cmd.Parameters.AddWithValue("@remark", txt_remark.Text);
                cmd.Parameters.AddWithValue("@region_code", cb_project.SelectedValue);
                cmd.Parameters.AddWithValue("@dept_code", cb_costcenter.SelectedValue);
                cmd.Parameters.AddWithValue("@kode", "SR");

                cmd.ExecuteNonQuery();

                //Save Detail

                foreach (GridDataItem itemD in RadGrid2.MasterTableView.Items)
                {
                    cmd = new SqlCommand();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Connection = con;
                    cmd.CommandText = "sp_save_stock_opnameD";
                    cmd.Parameters.AddWithValue("@rv_code", run);
                    cmd.Parameters.AddWithValue("@qty_sis", Convert.ToDouble((itemD.FindControl("txtPartQty") as RadNumericTextBox).Value));
                    cmd.Parameters.AddWithValue("@wh_code", cb_warehouse.SelectedValue);
                    cmd.Parameters.AddWithValue("@prod_code", (itemD.FindControl("lblProdCode") as Label).Text);
                    cmd.Parameters.AddWithValue("@Spec", (itemD.FindControl("lblSpec") as Label).Text);
                    cmd.Parameters.AddWithValue("@SatQty", (itemD.FindControl("lblUom") as Label).Text);
                    cmd.Parameters.AddWithValue("@dept_code", (itemD.FindControl("lblCostCtr") as Label).Text);
                    cmd.Parameters.AddWithValue("@date", string.Format("{0:yyyy-MM-dd}", dtp_so.SelectedDate.Value));   
                    cmd.Parameters.AddWithValue("@nomor", (itemD.FindControl("lblNomor") as Label).Text);
                    cmd.Parameters.AddWithValue("@remark", (itemD.FindControl("txtRemark") as RadTextBox).Text);

                    cmd.ExecuteNonQuery();

                }

                con.Close();

                notif.Text = "Data berhasil disimpan";
                notif.Title = "Notification";
                notif.Show();
                txt_so_number.Text = run;

                if (Session["actionHeader"].ToString() == "headerEdit")
                {
                    ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind();", true);
                }
                else
                {
                    ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind('navigateToInserted');", true);
                    (sender as Button).Text = "Update";
                    btnCancel.Text = "Close";
                }
                tr_code = run;
                selected_project = cb_project.SelectedValue;

            }
            catch (System.Exception ex)
            {
                con.Close();
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
            }
            finally
            {
                
                txt_so_number.Text = run;

                if (Session["actionHeader"].ToString() == "headerEdit")
                {
                    ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind();", true);
                }
                else
                {
                    ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind('navigateToInserted');", true);
                }
            }
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
            cmd.CommandText = "sp_get_stock_opname_generateH";
            cmd.Parameters.AddWithValue("@date", date);
            cmd.Parameters.AddWithValue("@todate", todate);
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
            var rv_code = ((GridDataItem)e.Item).GetDataKeyValue("rv_code");

            try
            {
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_delete_stok_opname_generateH";
                cmd.Parameters.AddWithValue("@rv_code", rv_code);
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
                tr_code = item["rv_code"].Text;
                selected_wh_code = item["warehouse"].Text;
                selectedCostCenter = item["ref_code"].Text;
            }

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
                    tr_code = gItem["rv_code"].Text;
                }
            }


            if ((sender as RadGrid).MasterTableView.Items.Count < (sender as RadGrid).MasterTableView.PageSize)
            {
                (sender as RadGrid).ClientSettings.Scrolling.AllowScroll = false;
                (sender as RadGrid).ClientSettings.Scrolling.UseStaticHeaders = false;
            }
        }
        protected void RadGrid1_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                tr_code = null;
                GridDataItem item = e.Item as GridDataItem;
                string kode = item["rv_code"].Text;
                tr_code = kode;
                selected_project = item["region_code"].Text;
                selected_wh_code = item["warehouse"].Text;

                Session["actionHeader"] = "headerEdit";
                Session["actionDetail"] = null;
            }
        }
        #endregion

        #region Detail        
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
        public DataTable GetDataDetailTable(string rv_code)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_stock_opname_generateD";
            cmd.Parameters.AddWithValue("@rv_code", rv_code);
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
            if ((sender as RadGrid).MasterTableView.Items.Count < (sender as RadGrid).MasterTableView.PageSize)
            {
                (sender as RadGrid).ClientSettings.Scrolling.AllowScroll = false;
                (sender as RadGrid).ClientSettings.Scrolling.UseStaticHeaders = false;
            }
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
                cmd.CommandText = "delete from tr_revisi_genD where prod_code = @prod_code and rv_code = @rv_code";
                cmd.Parameters.AddWithValue("@rv_code", tr_code);
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
            drValue["rv_code"] = tr_code;
            drValue["Prod_code"] = (item.FindControl("cbProdCodeEdit") as RadComboBox).Text;
            drValue["Spec"] = (item.FindControl("lblSpecEdit") as Label).Text;
            drValue["qty_sis"] = (item.FindControl("txtPartQtyEdit") as RadNumericTextBox).Value;
            drValue["SatQty"] = (item.FindControl("cb_uom_d") as RadComboBox).Text;
            drValue["dept_code"] = (item.FindControl("cb_dept_d") as RadComboBox).Text;
            drValue["Remark"] = (item.FindControl("txtRemarkEdit") as RadTextBox).Text;

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
                drValue["rv_code"] = tr_code;
                drValue["Prod_code"] = (item.FindControl("cbProdCodeInsert") as RadComboBox).Text;
                drValue["Spec"] = (item.FindControl("lblSpecInsert") as Label).Text;
                drValue["qty_sis"] = (item.FindControl("txtPartQtyInsert") as RadNumericTextBox).Value;
                drValue["SatQty"] = (item.FindControl("cb_uom_d_insert") as RadComboBox).Text;
                drValue["dept_code"] = (item.FindControl("cb_dept_d_insert") as RadComboBox).Text;
                drValue["Remark"] = (item.FindControl("txtRemarkInsert") as RadTextBox).Text;

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
                cmd.CommandText= "SELECT ms_product_detail.wh_code, ms_product_detail.prod_code, ms_product_detail.KoLok, ms_product_detail.QACT, " +
                "ms_product_kind.stMain, ms_product.spec, ms_product.unit " +
                "FROM ms_product_detail INNER JOIN ms_product ON ms_product_detail.prod_code = ms_product.prod_code INNER JOIN " +
                "ms_product_kind ON ms_product.kind_code = ms_product_kind.kind_code " +
                "WHERE(ms_product_detail.wh_code = '" + selected_wh_code + "') AND(ms_product_detail.prod_code = '" + (sender as RadComboBox).Text + "')";
                //cmd.CommandText = "SELECT a.spec,a.unit,b.KoLok as lokasi,ISNULL(b.QACT,0) AS QACT FROM ms_product a, ms_product_detail b WHERE a.prod_code = b.prod_code " +
                //    "AND b.wh_code = '" + selected_wh_code + "' AND a.prod_code = '" + (sender as RadComboBox).SelectedValue + "'";

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                foreach (DataRow dtr in dt.Rows)
                {
                    RadComboBox cb = (RadComboBox)sender;
                    GridEditableItem item = (GridEditableItem)cb.NamingContainer;
                    if (Session["actionDetail"].ToString() == "detailNew")
                    {
                        Label lblSpecInsert = (Label)item.FindControl("lblSpecInsert");
                        RadNumericTextBox txtPartQtyInsert = (RadNumericTextBox)item.FindControl("txtPartQtyInsert");
                        RadComboBox cb_uom = (RadComboBox)item.FindControl("cb_uom_d_insert");
                        RadComboBox cb_dept_d_insert = (RadComboBox)item.FindControl("cb_dept_d_insert");

                        lblSpecInsert.Text = dtr["spec"].ToString();
                        txtPartQtyInsert.Value = Convert.ToDouble(dtr["QACT"].ToString());
                        cb_uom.Text = dtr["unit"].ToString();
                        cb_dept_d_insert.Text = selectedCostCenter;
                    }
                    else if (Session["actionDetail"].ToString() == "detailEdit")
                    {
                        Label lblSpecEdit = (Label)item.FindControl("lblSpecEdit");
                        RadNumericTextBox txt_qty = (RadNumericTextBox)item.FindControl("txt_qty");
                        RadComboBox cb_uom = (RadComboBox)item.FindControl("cb_uom_d");
                        RadComboBox cb_dept_d = (RadComboBox)item.FindControl("cb_dept_d");

                        //lbl_ori_loc.Text = dtr["lokasi"].ToString();
                        cb_uom.Text = dtr["unit"].ToString();
                        txt_qty.Value = 0;
                        cb_dept_d.Text = selectedCostCenter;
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

        protected void cb_cost_center_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            RadComboBox cb = (RadComboBox)sender;
            GridEditableItem item = (GridEditableItem)cb.NamingContainer;
            RadComboBox cb_project = (RadComboBox)item.FindControl("cb_project");

            (sender as RadComboBox).Text = "";
            LoadCostCtr(e.Text, selected_project, (sender as RadComboBox));

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
                (sender as RadComboBox).SelectedValue = dr["CostCenter"].ToString();
                selectedCostCenter = dr["CostCenter"].ToString();
            }

            dr.Close();
            con.Close();
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
                (sender as RadComboBox).SelectedValue = dr["CostCenter"].ToString();
                selectedCostCenter = dr["CostCenter"].ToString();
            }
            dr.Close();
            con.Close();
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

       
    }
}