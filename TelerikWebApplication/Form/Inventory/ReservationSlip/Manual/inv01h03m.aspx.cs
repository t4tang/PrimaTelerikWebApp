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

namespace TelerikWebApplication.Form.Inventory.ReservationSlip.Manual
{
    public partial class inv01h03m : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();

        private const int ItemsPerRequest = 10;

        public static string tr_code = null;
        public static string selected_project = null;
        public static string selected_cost_ctr = null;
        public static string selected_wh_code = null;
        public static string selected_type_reff = null;
        public static string selected_reff_no = null;

        DataTable dtValues;
        public DataTable DetailDtbl()
        {
            dtValues = new DataTable();
            dtValues.Columns.Add("prod_type", typeof(string));
            dtValues.Columns.Add("part_code", typeof(string));
            dtValues.Columns.Add("part_desc", typeof(string));
            dtValues.Columns.Add("mr_qty", typeof(double));
            dtValues.Columns.Add("OH_qty", typeof(double));
            dtValues.Columns.Add("part_qty", typeof(double));
            dtValues.Columns.Add("QtyPR", typeof(double));
            dtValues.Columns.Add("QtyGi", typeof(double));
            dtValues.Columns.Add("part_unit", typeof(string));
            dtValues.Columns.Add("dept_code", typeof(string));
            dtValues.Columns.Add("deliv_date", typeof(DateTime));
            dtValues.Columns.Add("remark", typeof(string));
            dtValues.Columns.Add("tWarranty", typeof(bool));
            dtValues.Columns.Add("nomor", typeof(int));

            return dtValues;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lbl_form_name.Text = "Reservation Slip Manual";
                dtp_from.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
                dtp_to.SelectedDate = DateTime.Now;
                //cb_proj_prm.SelectedValue = public_str.site;
                selected_project = public_str.site;
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
                    RadGrid1.Rebind();
                }
                else if (e.Argument == "RebindAndNavigate")
                {
                    RadGrid1.MasterTableView.SortExpressions.Clear();
                    RadGrid1.MasterTableView.GroupByExpressions.Clear();
                    RadGrid1.DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), selected_project);
                    RadGrid1.DataBind();
                    //RadGrid1.Rebind();
                    RadGrid1.MasterTableView.CurrentPageIndex = RadGrid1.MasterTableView.PageCount - 1;
                    RadGrid1.MasterTableView.Items[RadGrid1.Items.Count - 1].Selected = true;
                    //RadGrid2.DataSource = new string[] { };
                    //RadGrid2.DataSource = GetDataRefDetailTable(selected_reff_no);
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
        protected void RadGrid1_PreRender(object sender, EventArgs e)
        {
            if (Session["action"].ToString() == "firstLoad")
            {
                if (RadGrid1.MasterTableView.Items.Count > 0)
                    RadGrid1.MasterTableView.Items[0].Selected = true;

                foreach (GridDataItem gItem in RadGrid1.SelectedItems)
                {
                    tr_code = gItem["doc_code"].Text;
                    selected_cost_ctr = gItem["dept_code"].Text;
                }
                //populate_detail();
            }

        }

        #region project param
        private static DataTable GetProjectPrm(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT region_code, region_name FROM inv00h09 WHERE stEdit != 4 AND region_name LIKE @text + '%' UNION SELECT 'ALL','ALL'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);
            
            return data;
        }
        protected void cb_proj_prm_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
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
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();

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
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            RadGrid1.DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), selected_project);
            RadGrid1.DataBind();
        }

       
        public DataTable GetDataTable(string fromDate, string toDate, string project)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_reservation_slip_manualH";
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
        
        protected void RadGrid1_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            (sender as RadGrid).DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), selected_project);
        }

        protected void RadGrid1_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            var doc_code = ((GridDataItem)e.Item).GetDataKeyValue("doc_code");

            try
            {
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "UPDATE fleet_doch SET userid = @Usr, lastupdate = GETDATE(), status_doc = '4' WHERE (doc_code = @doc_code)";
                cmd.Parameters.AddWithValue("@doc_code", doc_code);
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

        protected void cb_type_ref_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {

            (sender as RadComboBox).Items.Add("Work Order");
            (sender as RadComboBox).Items.Add("General Request");
        }

        protected void cb_type_ref_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if ((sender as RadComboBox).Text == "Work Order")
            {
                (sender as RadComboBox).SelectedValue = "1";
            }
            else if ((sender as RadComboBox).Text == "General Request")
            {
                (sender as RadComboBox).SelectedValue = "2";
            }
       
        }

        protected void cb_type_ref_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadComboBox).Text == "Work Order")
            {
                (sender as RadComboBox).SelectedValue = "1";
            }
            else if ((sender as RadComboBox).Text == "General Request")
            {
                (sender as RadComboBox).SelectedValue = "2";
            }
        }

        private static DataTable GetProject(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT region_code, region_name FROM inv00h09 WHERE stEdit != 4 AND region_name LIKE @text + '%'",
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
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }
        private void texbox_clear(ControlCollection ctrls)
        {
            foreach (Control ctrl in ctrls)
            {
                if (ctrl is RadTextBox)
                {
                    ((RadTextBox)ctrl).Text = "";
                }
                //else if (ctrl is RadComboBox)
                //    ((RadComboBox)ctrl).Text = "";

                texbox_clear(ctrl.Controls);

            }
        }
        private static DataTable GetReff(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select * from v_rs_reff where doc_code LIKE @text + '%'",
             ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void LoadReff(string doc_code, string projectID, string typeRef, RadComboBox cb)
        {
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            DataTable dt = new DataTable();

            if (typeRef == "Work Order")
            {
                SqlDataAdapter adapter = new SqlDataAdapter("SELECT doc_code, remark FROM v_rs_reff " +
                "WHERE void <> '4' AND region_code = @project AND doc_code LIKE @text + '%'", con);
                adapter.SelectCommand.Parameters.AddWithValue("@project", projectID);
                adapter.SelectCommand.Parameters.AddWithValue("@text", doc_code);
                //DataTable dt = new DataTable();
                adapter.Fill(dt);
            }
            else
            {
                SqlDataAdapter adapter = new SqlDataAdapter("SELECT doc_code, remark FROM v_rs_reff_general " +
                "WHERE region_code = @project AND doc_code LIKE @text + '%'", con);
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
        
        protected void cb_ref_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT doc_code FROM v_rs_reff WHERE doc_code = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
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
        public DataTable GetDataDetailTable(string doc_code)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_reservation_slipD";
            cmd.Parameters.AddWithValue("@doc_code", doc_code);
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
                //drValue["sro_code"] = tr_code;
                drValue["prod_type"] = (item.FindControl("lbl_prodType_insertTemp") as Label).Text;
                drValue["part_code"] = (item.FindControl("cb_prod_code_insertTemp") as RadComboBox).Text;
                drValue["mr_qty"] = (item.FindControl("lbl_mr_qty_insertTemp") as Label).Text;
                drValue["OH_qty"] = (item.FindControl("lbl_soh_insertTemp") as Label).Text;
                drValue["part_qty"] = (item.FindControl("txt_part_qty_insertTemp") as RadNumericTextBox).Text;
                drValue["QtyPR"] = (item.FindControl("lbl_qty_pr_insertTemp") as Label).Text;
                drValue["QtyGi"] = (item.FindControl("lbl_qty_gi_insertTemp") as Label).Text;
                drValue["part_unit"] = (item.FindControl("lbl_uom_insertTemp") as Label).Text;
                drValue["dept_code"] = (item.FindControl("lbl_cost_ctr_insertTemp") as Label).Text;
                drValue["deliv_date"] = (item.FindControl("dtp_deliv_date_insertTemp") as RadDatePicker).SelectedDate;
                drValue["tWarranty"] = (item.FindControl("chk_waranty_insertTemp") as CheckBox).Checked;
                drValue["remark"] = (item.FindControl("txt_remark_insertTemp") as RadTextBox).Text;
                drValue["nomor"] = 0;

                dtValues.Rows.Add(drValue); //adding new row into datatable
                dtValues.AcceptChanges();
                Session["TableDetail"] = dtValues;
                (sender as RadGrid).Rebind();
                Session["actionDetail"] = "detailList";
                

                

            }
            catch (Exception ex)
            {
                //con.Close();
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
                e.Canceled = true;
            }
        }
        protected void RadGrid2_UpdateCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                GridEditableItem item = (GridEditableItem)e.Item;

                dtValues = (DataTable)Session["TableDetail"];
                DataRow drValue = dtValues.Rows[0];
                drValue["prod_type"] = (item.FindControl("lbl_prodType_editTemp") as Label).Text;
                drValue["part_code"] = (item.FindControl("cb_prod_code_editTemp") as RadComboBox).Text;
                drValue["mr_qty"] = (item.FindControl("lbl_mr_qty_editTemp") as Label).Text;
                drValue["OH_qty"] = (item.FindControl("lbl_soh_editTemp") as Label).Text;
                drValue["part_qty"] = (item.FindControl("txt_part_qty_editTemp") as RadNumericTextBox).Text;
                drValue["QtyPR"] = (item.FindControl("lbl_qty_pr_editTemp") as Label).Text;
                drValue["QtyGi"] = (item.FindControl("lbl_qty_gi_editTemp") as Label).Text;
                drValue["part_unit"] = (item.FindControl("lbl_uom_editTemp") as Label).Text;
                drValue["dept_code"] = (item.FindControl("lbl_cost_ctr_editTemp") as Label).Text;
                drValue["deliv_date"] = (item.FindControl("dtp_deliv_date_editTemp") as RadDatePicker).SelectedDate;
                drValue["tWarranty"] = (item.FindControl("chk_waranty_editTemp") as CheckBox).Checked;
                drValue["remark"] = (item.FindControl("txt_remark_editTemp") as RadTextBox).Text;
                drValue["nomor"] = (item.FindControl("lbl_runEdit") as Label).Text;

                drValue.EndEdit(); //editing row in datatable
                dtValues.AcceptChanges();
                Session["TableDetail"] = dtValues;
                (sender as RadGrid).Rebind();

            }
            catch (Exception ex)
            {
                //con.Close();
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
                e.Canceled = true;
            }
        }
        protected void RadGrid2_save_handler(object sender, GridCommandEventArgs e)
        {
            try
            {
                GridEditableItem item = (GridEditableItem)e.Item;
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_save_reservation_slipD";
                cmd.Parameters.AddWithValue("@doc_code", tr_code);
                cmd.Parameters.AddWithValue("@part_code", (item.FindControl("lblProdCode") as Label).Text);
                cmd.Parameters.AddWithValue("@oh_qty", Convert.ToDouble((item.FindControl("lblSoh") as Label).Text));
                cmd.Parameters.AddWithValue("@part_qty", Convert.ToDouble((item.FindControl("txtPartQty") as RadTextBox).Text));
                cmd.Parameters.AddWithValue("@part_unit", (item.FindControl("lblUom") as Label).Text);
                cmd.Parameters.AddWithValue("@remark", (item.FindControl("txtRemark_d") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@dept_code", (item.FindControl("lblCostCtr") as Label).Text);
                cmd.Parameters.AddWithValue("@tWarranty", "0");
                cmd.Parameters.AddWithValue("@deliv_date", string.Format("{0:yyyy-MM-dd}", (item.FindControl("dtpDelivDate") as RadDatePicker).SelectedDate));
                cmd.Parameters.AddWithValue("@prod_type", (item.FindControl("lblProdType") as Label).Text);
                cmd.ExecuteNonQuery();                
                con.Close();

                //notif.Show();
            }
            catch (Exception ex)
            {
                con.Close();
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
                e.Canceled = true;
            }
        }

        protected void RadGrid2_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            var partCode = ((GridDataItem)e.Item).GetDataKeyValue("part_code");

            try
            {
                GridEditableItem item = (GridEditableItem)e.Item;
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "delete from inv01d03 where part_code = @part_code and doc_code = @doc_code";
                cmd.Parameters.AddWithValue("@doc_code", tr_code);
                cmd.Parameters.AddWithValue("@part_code", partCode);
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
        protected void RadGrid1_SelectedIndexChanged(object sender, EventArgs e)
        {
            foreach (GridDataItem item in RadGrid1.SelectedItems)
            {
                tr_code = item["doc_code"].Text;
                selected_cost_ctr = item["dept_code"].Text;
            }
            
            Session["actionEdit"] = "list";
        }

        protected void RadGrid1_ItemCreated(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                //ImageButton editLink = (ImageButton)e.Item.FindControl("EditLink");
                //editLink.Attributes["href"] = "javascript:void(0);";
                //editLink.Attributes["onclick"] = String.Format("return ShowEditForm('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["doc_code"], e.Item.ItemIndex);

                ImageButton printLink = (ImageButton)e.Item.FindControl("PrintLink");
                printLink.Attributes["href"] = "javascript:void(0);";
                printLink.Attributes["onclick"] = String.Format("return ShowPreview('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["doc_code"], e.Item.ItemIndex);

            }
        }
        
        protected void cb_prod_code_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            string sql = "SELECT TOP (100)[prod_code], [spec],[unit],[stMainNm] FROM [v_rs_manual_reff_detail]  WHERE [spec] LIKE @spec + '%'";
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
                item.Text = row["Prod_code"].ToString();
                item.Value = row["Prod_code"].ToString();
                item.Attributes.Add("spec", row["spec"].ToString());
                item.Attributes.Add("unit", row["unit"].ToString());
                item.Attributes.Add("stMainNm", row["stMainNm"].ToString());

                comboBox.Items.Add(item);

                item.DataBind();
            }
        }

        protected void cb_prod_code_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            Session["action"] = "list";

            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "SELECT [prod_code], [spec],[unit],[QACT] FROM " +
                    "[v_rs_manual_reff_detail] WHERE [prod_code] = '" + (sender as RadComboBox).SelectedValue + "'";

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                foreach (DataRow dtr in dt.Rows)
                {
                    RadComboBox cb = (RadComboBox)sender;
                    GridEditableItem item = (GridEditableItem)cb.NamingContainer;

                    if (Session["actionDetail"].ToString() == "detailNew")
                    {
                        Label lbl_UoM = (Label)item.FindControl("lbl_UoM_insertTemp");
                        Label lbl_prodType = (Label)item.FindControl("lbl_prodType_insertTemp");
                        Label lbl_soh = (Label)item.FindControl("lbl_soh_insertTemp");
                        RadNumericTextBox txt_qty = (RadNumericTextBox)item.FindControl("txt_part_qty_insertTemp");
                        Label lbl_cost_ctr = (Label)item.FindControl("lbl_cost_ctr_insertTemp");
                        Label lbl_mr_qty = (Label)item.FindControl("lbl_mr_qty_insertTemp");
                        Label lbl_pr_qty = (Label)item.FindControl("lbl_qty_pr_insertTemp");
                        Label lbl_supp_qty = (Label)item.FindControl("lbl_qty_gi_insertTemp");
                        RadDatePicker dt_deliv_date = (RadDatePicker)item.FindControl("dtp_deliv_date_insertTemp");

                        txt_qty.Text = string.Format("{0:#,###,##0.00}", 0);
                        lbl_prodType.Text = "M1";
                        lbl_UoM.Text = dtr["unit"].ToString();
                        lbl_soh.Text = string.Format("{0:#,###,##0.00}", dtr["QACT"].ToString());
                        lbl_cost_ctr.Text = selected_cost_ctr;
                        lbl_mr_qty.Text = string.Format("{0:#,###,##0.00}", 0);
                        lbl_pr_qty.Text = string.Format("{0:#,###,##0.00}", 0);
                        lbl_supp_qty.Text = string.Format("{0:#,###,##0.00}", 0);
                        dt_deliv_date.SelectedDate = DateTime.Now.AddDays(17);

                    }
                    else if (Session["actionDetail"].ToString() == "detailEdit")
                    {
                        Label lbl_UoM = (Label)item.FindControl("lbl_UoM_editTemp");
                        Label lbl_prodType = (Label)item.FindControl("lbl_prodType_editTemp");
                        Label lbl_soh = (Label)item.FindControl("lbl_soh_editTemp");
                        RadNumericTextBox txt_qty = (RadNumericTextBox)item.FindControl("txt_part_qty_editTemp");
                        Label lbl_cost_ctr = (Label)item.FindControl("lbl_cost_ctr_editTemp");
                        Label lbl_mr_qty = (Label)item.FindControl("lbl_mr_qty_editTemp");
                        Label lbl_pr_qty = (Label)item.FindControl("lbl_qty_pr_editTemp");
                        Label lbl_supp_qty = (Label)item.FindControl("lbl_qty_gi_editTemp");
                        RadDatePicker dt_deliv_date = (RadDatePicker)item.FindControl("dtp_deliv_date_editTemp");

                        txt_qty.Text = string.Format("{0:#,###,##0.00}", 0);
                        lbl_prodType.Text = "M1";
                        lbl_UoM.Text = dtr["unit"].ToString();
                        lbl_soh.Text = string.Format("{0:#,###,##0.00}", dtr["QACT"].ToString());
                        lbl_cost_ctr.Text = selected_cost_ctr;
                        lbl_mr_qty.Text = string.Format("{0:#,###,##0.00}", 0);
                        lbl_pr_qty.Text = string.Format("{0:#,###,##0.00}", 0);
                        lbl_supp_qty.Text = string.Format("{0:#,###,##0.00}", 0);
                        dt_deliv_date.SelectedDate = DateTime.Now.AddDays(17);

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

        private static string GetStatusMessage(int offset, int total)
        {
            if (total <= 0)
                return "No matches";

            return String.Format("Items <b>1</b>-<b>{0}</b> out of <b>{1}</b>", offset, total);
        }

        #region Refferences

        //private static DataTable GetReff(string text)
        //{
        //    SqlDataAdapter adapter = new SqlDataAdapter("select * from v_rs_reff where doc_code LIKE @text + '%'",
        //     ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
        //    adapter.SelectCommand.Parameters.AddWithValue("@text", text);

        //    DataTable data = new DataTable();
        //    adapter.Fill(data);

        //    return data;
        //}
        //protected void LoadReff(string doc_code, string projectID, string typeRef, RadComboBox cb)
        //{
        //    SqlConnection con = new SqlConnection(
        //    ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
        //    DataTable dt = new DataTable();

        //    if (typeRef == "Work Order")
        //    {
        //        SqlDataAdapter adapter = new SqlDataAdapter("SELECT doc_code, remark FROM v_rs_reff " +
        //        "WHERE void <> '4' AND region_code = @project AND doc_code LIKE @text + '%'", con);
        //        adapter.SelectCommand.Parameters.AddWithValue("@project", projectID);
        //        adapter.SelectCommand.Parameters.AddWithValue("@text", doc_code);
        //        //DataTable dt = new DataTable();
        //        adapter.Fill(dt);
        //    }
        //    else
        //    {
        //        SqlDataAdapter adapter = new SqlDataAdapter("SELECT doc_code, remark FROM v_rs_reff_general " +
        //        "WHERE region_code = @project AND doc_code LIKE @text + '%'", con);
        //        adapter.SelectCommand.Parameters.AddWithValue("@project", projectID);
        //        adapter.SelectCommand.Parameters.AddWithValue("@text", doc_code);
        //        //DataTable dt = new DataTable();
        //        adapter.Fill(dt);
        //    }


        //    cb.DataTextField = "doc_code";
        //    cb.DataValueField = "doc_code";
        //    cb.DataSource = dt;
        //    cb.DataBind();
        //}

        //public DataTable GetDataRefDetailTable(string doc_code)
        //{
        //    con.Open();
        //    cmd = new SqlCommand();
        //    cmd.CommandType = CommandType.StoredProcedure;
        //    cmd.Connection = con;
        //    cmd.CommandText = "sp_get_rs_refD";
        //    cmd.Parameters.AddWithValue("@doc_code", doc_code);
        //    cmd.Parameters.AddWithValue("@type_reff", cb_type_ref.SelectedValue);
        //    cmd.Parameters.AddWithValue("@wh_code", cb_warehouse.SelectedValue);
        //    cmd.CommandTimeout = 0;
        //    cmd.ExecuteNonQuery();
        //    sda = new SqlDataAdapter(cmd);

        //    DataTable DT = new DataTable();

        //    try
        //    {
        //        sda.Fill(DT);
        //    }
        //    finally
        //    {
        //        con.Close();
        //    }

        //    return DT;
        //}
        #endregion

        #region Priority 
        private static DataTable GetPriority(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT priority_code , prio_desc FROM pur00h06 WHERE prio_desc LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }

        protected void cb_priority_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetPriority(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["prio_desc"].ToString(), data.Rows[i]["prio_desc"].ToString()));
            }

            e.Message = GetStatusMessage(endOffset, data.Rows.Count);
        }

        protected void cb_priority_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT priority_code FROM pur00h06 WHERE prio_desc = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            }
            dr.Close();
            con.Close();
        }
        protected void cb_priority_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT priority_code FROM pur00h06 WHERE prio_desc = '" + (sender as RadComboBox).Text + "'";
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

        #region Reff Type
        //protected void cb_type_ref_PreRender(object sender, EventArgs e)
        //{
        //    if ((sender as RadComboBox).Text == "Work Order")
        //    {
        //        (sender as RadComboBox).SelectedValue = "1";
        //    }
        //    else if ((sender as RadComboBox).Text == "General Request")
        //    {
        //        (sender as RadComboBox).SelectedValue = "2";
        //    }
        //}
        //protected void cb_type_ref_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        //{
        //    (sender as RadComboBox).Items.Add("Work Order");
        //    (sender as RadComboBox).Items.Add("General Request");
        //}
        //protected void cb_type_ref_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        //{
        //    if ((sender as RadComboBox).Text == "Work Order")
        //    {
        //        (sender as RadComboBox).SelectedValue = "1";
        //    }
        //    else if ((sender as RadComboBox).Text == "General Request")
        //    {
        //        (sender as RadComboBox).SelectedValue = "2";
        //        //mrCodeValidator.ControlToValidate = null;
        //        //woCodeValidator.ControlToValidate = null;
        //    }
        //}
        #endregion

        #region Project
        //private static DataTable GetProject(string text)
        //{
        //    SqlDataAdapter adapter = new SqlDataAdapter("SELECT region_code, region_name FROM inv00h09 WHERE stEdit != 4 AND region_name LIKE @text + '%' ",
        //    ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
        //    adapter.SelectCommand.Parameters.AddWithValue("@text", text);

        //    DataTable data = new DataTable();
        //    adapter.Fill(data);

        //    return data;
        //}
        //protected void cb_project_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        //{

        //    DataTable data = GetProject(e.Text);

        //    int itemOffset = e.NumberOfItems;
        //    int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
        //    e.EndOfItems = endOffset == data.Rows.Count;

        //    for (int i = itemOffset; i < endOffset; i++)
        //    {
        //        (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["region_name"].ToString(), data.Rows[i]["region_name"].ToString()));
        //    }
        //}
        protected void cb_projectTemp_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            RadComboBox cb = (RadComboBox)sender;
            GridEditableItem item = (GridEditableItem)cb.NamingContainer;
            RadTextBox txt_unit_name = (item.FindControl("txt_unit_name") as RadTextBox);
            RadComboBox cb_warehouse = (item.FindControl("cb_warehouse") as RadComboBox);
            RadComboBox cb_cost_ctr = (item.FindControl("cb_cost_ctr") as RadComboBox);
            RadComboBox cb_unit = (item.FindControl("cb_unit") as RadComboBox);
            RadTextBox txt_hm = (item.FindControl("txt_hm") as RadTextBox);
            RadTextBox txt_remark = (item.FindControl("txt_remark") as RadTextBox);

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

            cb_warehouse.Text = string.Empty;
            //cb_ref.Text = string.Empty;
            cb_cost_ctr.Text = string.Empty;
            cb_warehouse.SelectedValue = null;
            //cb_ref.SelectedValue = null;
            cb_cost_ctr.SelectedValue = null;
            cb_unit.Text = string.Empty;
            cb_unit.SelectedValue = null;
            txt_unit_name.Text = string.Empty;
            txt_hm.Text = string.Empty;
            txt_remark.Text = string.Empty;
        }

        //protected void cb_project_PreRender(object sender, EventArgs e)
        //{
        //    con.Open();
        //    SqlCommand cmd = new SqlCommand();
        //    cmd.Connection = con;
        //    cmd.CommandType = CommandType.Text;
        //    cmd.CommandText = "SELECT region_code FROM inv00h09 WHERE region_name = '" + (sender as RadComboBox).Text + "'";
        //    SqlDataReader dr;
        //    dr = cmd.ExecuteReader();
        //    while (dr.Read())
        //    {
        //        (sender as RadComboBox).SelectedValue = dr[0].ToString();
        //    }
        //    dr.Close();
        //    con.Close();
        //}
        #endregion

        #region unit
        protected void GetUnit(string text, string project, RadComboBox cb)
        {
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);

            SqlDataAdapter adapter = new SqlDataAdapter("SELECT mtc00h16.unit_code, mtc00h16.model_no, mtc00h16.unit_name, mtc00h16.region_code, mtc00h16.dept_code, inv00h11.CostCenterName " +
                "FROM mtc00h16 INNER JOIN inv00h11 ON mtc00h16.dept_code = inv00h11.CostCenter WHERE mtc00h16.active = '1' AND mtc00h16.region_code = @project AND unit_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@project", project);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable dt = new DataTable();
            adapter.Fill(dt);


            cb.DataTextField = "unit_code";
            cb.DataValueField = "unit_code";
            cb.DataSource = dt;
            cb.DataBind();

        }

        protected void cb_unit_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            RadComboBox cb = (RadComboBox)sender;
            GridEditableItem item = (GridEditableItem)cb.NamingContainer;
            RadComboBox cb_project = (item.FindControl("cb_project") as RadComboBox);

            (sender as RadComboBox).Text = "";
            GetUnit(e.Text, cb_project.SelectedValue, (sender as RadComboBox));
        }
        protected void cb_unit_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            RadComboBox cb = (RadComboBox)sender;
            GridEditableItem item = (GridEditableItem)cb.NamingContainer;
            RadTextBox txt_unit_name = (item.FindControl("txt_unit_name") as RadTextBox);
            RadComboBox cb_cost_ctr = (item.FindControl("cb_cost_ctr") as RadComboBox);

            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT model_no, mtc00h16.dept_code, inv00h11.CostCenterName FROM mtc00h16 INNER JOIN " +
                "inv00h11 ON mtc00h16.dept_code = inv00h11.CostCenter WHERE unit_code = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                //(sender as RadComboBox).SelectedValue = dr[0].ToString();
                txt_unit_name.Text = dr["model_no"].ToString();
                cb_cost_ctr.Text = dr["CostCenterName"].ToString();
                cb_cost_ctr.SelectedValue = dr["dept_code"].ToString();
            }
            dr.Close();
            con.Close();

        }
        protected void cb_unit_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT unit_code FROM mtc00h16 WHERE unit_name = '" + (sender as RadComboBox).Text + "'";
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
            RadComboBox cb_project = (item.FindControl("cb_project") as RadComboBox);

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
            }
            dr.Close();
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
        protected void cb_cost_ctr_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            RadComboBox cb = (RadComboBox)sender;
            GridEditableItem item = (GridEditableItem)cb.NamingContainer;
            RadComboBox cb_project = (item.FindControl("cb_project") as RadComboBox);

            (sender as RadComboBox).Text = "";
            LoadCostCtr(e.Text, cb_project.SelectedValue, (sender as RadComboBox));

        }
        protected void cb_cost_ctr_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
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
            }
            dr.Close();
            con.Close();
        }
        protected void cb_cost_ctr_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT CostCenter FROM inv00h11 WHERE CostCenterName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["CostCenter"].ToString();
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
        protected void cb_prepare_by_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            RadComboBox cb = (RadComboBox)sender;
            GridEditableItem item = (GridEditableItem)cb.NamingContainer;
            RadComboBox cb_project = (item.FindControl("cb_project") as RadComboBox);

            (sender as RadComboBox).Text = "";
            LoadManPower(e.Text, cb_project.SelectedValue, (sender as RadComboBox));
        }
        protected void cb_prepare_by_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
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
        protected void cb_prepare_by_PreRender(object sender, EventArgs e)
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
        protected void cb_orderBy_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            RadComboBox cb = (RadComboBox)sender;
            GridEditableItem item = (GridEditableItem)cb.NamingContainer;
            RadComboBox cb_project = (item.FindControl("cb_project") as RadComboBox);

            (sender as RadComboBox).Text = "";
            LoadManPower(e.Text, cb_project.SelectedValue, (sender as RadComboBox));
        }
        protected void cb_orderBy_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
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
        protected void cb_orderBy_PreRender(object sender, EventArgs e)
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
        protected void cb_received_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
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
        protected void cb_received_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            RadComboBox cb = (RadComboBox)sender;
            GridEditableItem item = (GridEditableItem)cb.NamingContainer;
            RadComboBox cb_project = (item.FindControl("cb_project") as RadComboBox);

            (sender as RadComboBox).Text = "";
            LoadManPower(e.Text, cb_project.SelectedValue, (sender as RadComboBox));
        }
        protected void cb_received_PreRender(object sender, EventArgs e)
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
        protected void cb_approved_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            RadComboBox cb = (RadComboBox)sender;
            GridEditableItem item = (GridEditableItem)cb.NamingContainer;
            RadComboBox cb_project = (item.FindControl("cb_project") as RadComboBox);

            (sender as RadComboBox).Text = ""; 
            LoadManPower(e.Text, cb_project.SelectedValue, (sender as RadComboBox));
        }
        protected void cb_approved_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
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
        protected void cb_approved_PreRender(object sender, EventArgs e)
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

        protected void RadGrid1_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                GridDataItem item = e.Item as GridDataItem;
                string kode = item["doc_code"].Text;
                tr_code = kode;

                Session["actionHeader"] = "headerEdit";
                Session["actionDetail"] = null;
            }
        }

        protected void btnNew_Click(object sender, ImageClickEventArgs e)
        {
            Session["TableDetail"] = null;
            Session["actionHeader"] = "headerNew";
            RadGrid1.MasterTableView.IsItemInserted = true;
            RadGrid1.MasterTableView.Rebind();
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

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridEditableItem item = (GridEditableItem)btn.NamingContainer;

            RadTextBox txt_doc_code = (RadTextBox)item.FindControl("txt_doc_code");
            RadDatePicker dtp_rs = (RadDatePicker)item.FindControl("dtp_rs");
            RadDatePicker dtp_exe = (RadDatePicker)item.FindControl("dtp_exe");
            RadComboBox cb_type_ref = (RadComboBox)item.FindControl("cb_type_ref");
            RadComboBox cb_project = (RadComboBox)item.FindControl("cb_project");
            RadComboBox cb_warehouse = (RadComboBox)item.FindControl("cb_warehouse");
            RadTextBox txt_mr_no = (RadTextBox)item.FindControl("txt_mr_no");
            RadTextBox txt_wo_no = (RadTextBox)item.FindControl("txt_wo_no");
            RadComboBox cb_unit = (RadComboBox)item.FindControl("cb_unit");
            RadTextBox txt_unit_name = (RadTextBox)item.FindControl("txt_unit_name");
            RadTextBox txt_hm = (RadTextBox)item.FindControl("txt_hm");
            RadComboBox cb_cost_ctr = (RadComboBox)item.FindControl("cb_cost_ctr");
            RadComboBox cb_orderBy = (RadComboBox)item.FindControl("cb_orderBy");
            RadComboBox cb_approved = (RadComboBox)item.FindControl("cb_approved");
            RadComboBox cb_received = (RadComboBox)item.FindControl("cb_received");
            RadTextBox txt_remark = (RadTextBox)item.FindControl("txt_remark");
            Button btnCancel = (Button)item.FindControl("btnCancel");
            RadGrid Grid2 = (RadGrid)item.FindControl("RadGrid2");


            long maxNo;
            string run = null;
            string trDate = string.Format("{0:dd/MM/yyyy}", dtp_rs.SelectedDate);

            try
            {
                if ((sender as Button).Text == "Update")
                {
                    run = txt_doc_code.Text;
                }
                else
                {
                    con.Open();
                    SqlDataReader sdr;
                    cmd = new SqlCommand("SELECT ISNULL ( MAX ( RIGHT ( inv01h03.doc_code , 4 ) ) , 0 ) + 1 AS maxNo " +
                        "FROM inv01h03 WHERE LEFT(inv01h03.doc_code, 4) = 'RS03' " +
                        "AND SUBSTRING(inv01h03.doc_code, 5, 2) = SUBSTRING('" + trDate + "', 9, 2) " +
                        "AND SUBSTRING(inv01h03.doc_code, 7, 2) = SUBSTRING('" + trDate + "', 4, 2) ", con);
                    sdr = cmd.ExecuteReader();
                    if (sdr.HasRows == false)
                    {
                        //throw new Exception();
                        run = "RS03" + dtp_rs.SelectedDate.Value.Year + dtp_rs.SelectedDate.Value.Month + "0001";
                    }
                    else if (sdr.Read())
                    {
                        maxNo = Convert.ToInt32(sdr[0].ToString());
                        run = "RS03" + (dtp_rs.SelectedDate.Value.Year.ToString()).Substring(dtp_rs.SelectedDate.Value.Year.ToString().Length - 2) +
                            ("0000" + dtp_rs.SelectedDate.Value.Month).Substring(("0000" + dtp_rs.SelectedDate.Value.Month).Length - 2, 2) +
                            ("0000" + maxNo).Substring(("0000" + maxNo).Length - 4, 4);
                    }
                    con.Close();
                }


                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_save_reservation_slipH";
                cmd.Parameters.AddWithValue("@doc_code", run);
                cmd.Parameters.AddWithValue("@doc_date", string.Format("{0:yyyy-MM-dd}", dtp_rs.SelectedDate.Value));
                cmd.Parameters.AddWithValue("@date_exec", string.Format("{0:yyyy-MM-dd}", dtp_exe.SelectedDate.Value));
                cmd.Parameters.AddWithValue("@receive_by", cb_received.SelectedValue);
                cmd.Parameters.AddWithValue("@approval_by", cb_approved.SelectedValue);
                cmd.Parameters.AddWithValue("@order_by", cb_orderBy.SelectedValue);
                cmd.Parameters.AddWithValue("@sro_code", DBNull.Value);
                cmd.Parameters.AddWithValue("@doc_remark", txt_remark.Text);
                cmd.Parameters.AddWithValue("@userid", public_str.user_id);
                cmd.Parameters.AddWithValue("@LastUpdate", DateTime.Today);
                cmd.Parameters.AddWithValue("@region_code", cb_project.SelectedValue);
                cmd.Parameters.AddWithValue("@dept_code", cb_cost_ctr.SelectedValue);
                cmd.Parameters.AddWithValue("@type_ref", cb_type_ref.SelectedValue);
                cmd.Parameters.AddWithValue("@type_source", "2");
                cmd.Parameters.AddWithValue("@tFullSupply", "0");
                cmd.Parameters.AddWithValue("@unit_code", cb_unit.Text);
                cmd.Parameters.AddWithValue("@model_no", txt_unit_name.Text);
                cmd.Parameters.AddWithValue("@Owner", public_str.user_id);
                if (txt_hm.Text != "")
                {
                    cmd.Parameters.AddWithValue("@time_reading", Convert.ToDouble(txt_hm.Text));
                }
                else
                {
                    cmd.Parameters.AddWithValue("@time_reading", 0);
                }
                cmd.Parameters.AddWithValue("@Stamp", DateTime.Today);
                cmd.Parameters.AddWithValue("@Lvl", public_str.level);
                cmd.Parameters.AddWithValue("@wh_code", cb_warehouse.SelectedValue);

                cmd.ExecuteNonQuery();

                foreach (GridDataItem itemD in Grid2.MasterTableView.Items)
                {
                    Label lbl_prod_code;
                    Label lbl_soh;
                    Label lbl_part_qty;
                    Label lbl_uom;
                    Label lbl_remark;
                    Label lbl_dept_code;
                    CheckBox chkWaranty;
                    Label lbl_prodType;
                    RadDatePicker dtp_deliv_date;

                    lbl_prodType = (Label)itemD.FindControl("lblProdType");
                    lbl_soh = (Label)itemD.FindControl("lbl_soh");
                    lbl_part_qty = (Label)itemD.FindControl("lbl_part_qty");
                    lbl_uom = (Label)itemD.FindControl("lbl_uom");
                    lbl_prod_code = (Label)itemD.FindControl("lbl_prod_code");
                    lbl_dept_code = (Label)itemD.FindControl("lbl_cost_ctr");
                    chkWaranty = (CheckBox)itemD.FindControl("chk_waranty");
                    lbl_remark = (Label)itemD.FindControl("lbl_remark");
                    dtp_deliv_date = (RadDatePicker)itemD.FindControl("dtp_deliv_date");


                    //con.Open();
                    cmd = new SqlCommand();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Connection = con;
                    cmd.CommandText = "sp_save_reservation_slipD";
                    cmd.Parameters.AddWithValue("@doc_code", run);
                    cmd.Parameters.AddWithValue("@part_code", lbl_prod_code.Text);
                    cmd.Parameters.AddWithValue("@oh_qty", Convert.ToDouble(lbl_soh.Text));
                    cmd.Parameters.AddWithValue("@part_qty", Convert.ToDouble(lbl_part_qty.Text));
                    cmd.Parameters.AddWithValue("@part_unit", lbl_uom.Text);
                    cmd.Parameters.AddWithValue("@remark", lbl_remark.Text);
                    cmd.Parameters.AddWithValue("@dept_code", lbl_dept_code.Text);
                    if (chkWaranty.Checked == true)
                    {
                        cmd.Parameters.AddWithValue("@tWarranty", 1);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@tWarranty", 0);
                    }
                    cmd.Parameters.AddWithValue("@deliv_date", dtp_deliv_date.SelectedDate);
                    cmd.Parameters.AddWithValue("@prod_type", lbl_prodType.Text);
                    cmd.ExecuteNonQuery();
                                       

                }

            }
            catch (Exception ex)
            {
                con.Close();
                //Response.Write("<font color='red'>" + ex.Message + "</font>");
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "");
                //RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn","");
            }
            finally
            {
                con.Close();
                notif.Text = "Data berhasil disimpan";
                notif.Title = "Notification";
                notif.Show();
                txt_doc_code.Text = run;

                if ((sender as Button).Text == "Update")
                {
                    ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind();", true);
                }
                else
                {
                    inv01h03m.tr_code = run;
                    inv01h03m.selected_project = cb_project.SelectedValue;
                    ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind('navigateToInserted');", true);
                    (sender as Button).Text = "Update";
                    btnCancel.Text = "Close";
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
    }
}