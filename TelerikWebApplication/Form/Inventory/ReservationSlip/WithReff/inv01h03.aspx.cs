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

namespace TelerikWebApplication.Form.Inventory.ReservationSlip.WithReff
{
    public partial class inv01h03 : System.Web.UI.Page
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
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lbl_form_name.Text = "Reservation Slip";
                dtp_from.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
                dtp_to.SelectedDate = DateTime.Now;
                //cb_proj_prm.SelectedValue = public_str.site;
                selected_project = public_str.site;
                cb_proj_prm.Text = public_str.sitename;

                tr_code = null;
                Session["action"] = "firstLoad";
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
                    RadGrid1.MasterTableView.CurrentPageIndex = RadGrid1.MasterTableView.PageCount - 1;
                    //RadGrid1.MasterTableView.Items[RadGrid1.Items.Count - 1].Selected = true;
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
            RadGrid1.DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), selected_project);
            RadGrid1.DataBind();
        }

        #region project
        private static DataTable GetProjectPrm(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT region_code, region_name FROM ms_jobsite WHERE stEdit != 4 AND region_name LIKE @text + '%' UNION SELECT 'ALL','ALL'",
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
                selected_project = (sender as RadComboBox).SelectedValue;
            }
            dr.Close();
            con.Close();

        }
        #endregion

        #region Header
        protected void RadGrid1_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            (sender as RadGrid).DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), selected_project);
        }
        public DataTable GetDataTable(string fromDate, string toDate, string project)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_reservation_slipH";
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
        protected void RadGrid1_ItemCreated(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                ImageButton editLink = (ImageButton)e.Item.FindControl("EditLink");
                editLink.Attributes["href"] = "javascript:void(0);";
                editLink.Attributes["onclick"] = String.Format("return ShowEditForm('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["doc_code"], e.Item.ItemIndex);

                ImageButton printLink = (ImageButton)e.Item.FindControl("PrintLink");
                printLink.Attributes["href"] = "javascript:void(0);";
                printLink.Attributes["onclick"] = String.Format("return ShowPreview('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["doc_code"], e.Item.ItemIndex);

            }
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
        protected void RadGrid1_SelectedIndexChanged(object sender, EventArgs e)
        {
            foreach (GridDataItem item in RadGrid1.SelectedItems)
            {
                tr_code = item["doc_code"].Text;
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
                    tr_code = gItem["doc_code"].Text;
                }
                //populate_detail();
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
        //protected void RadGrid2_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        //{
        //    if (tr_code == null)
        //    {
        //        (sender as RadGrid).DataSource = new string[] { };
        //    }
        //    else
        //    {
        //        RadGrid2.DataSource = GetDataDetailTable(tr_code);
        //    }
        //}
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
                cmd.CommandText = "delete from fleet_docd where part_code = @part_code and doc_code = @doc_code";
                cmd.Parameters.AddWithValue("@doc_code", tr_code);
                cmd.Parameters.AddWithValue("@part_code", partCode);
                cmd.ExecuteNonQuery();
                con.Close();
                //RadGrid2.DataBind();

                //notif.Text = "Data berhasil dihapus";
                //notif.Title = "Notification";
                //notif.Show();
            }
            catch (Exception ex)
            {
                con.Close();
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "");
                e.Canceled = true;
            }
        }
        protected void RadGrid2_InsertCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                con.Open();
                GridEditableItem item = (GridEditableItem)e.Item;
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_get_reservation_slipD";
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
        #endregion


        //protected void cb_project_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
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

        //protected void cb_project_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        //{
        //    con.Open();
        //    SqlCommand cmd = new SqlCommand();
        //    cmd.Connection = con;
        //    cmd.CommandType = CommandType.Text;
        //    cmd.CommandText = "SELECT region_code FROM ms_jobsite WHERE region_name = '" + (sender as RadComboBox).Text + "'";
        //    SqlDataReader dr;
        //    dr = cmd.ExecuteReader();
        //    while (dr.Read())
        //        (sender as RadComboBox).SelectedValue = dr[0].ToString();
        //    dr.Close();
        //    con.Close();

        //    cb_warehouse.Text = string.Empty;
        //    cb_ref.Text = string.Empty;
        //    texbox_clear(Page.Controls);
        //    RadGrid2.DataSource = new string[] { };
        //    RadGrid2.DataBind();
        //}


        //private void texbox_clear(ControlCollection ctrls)
        //{
        //    foreach (Control ctrl in ctrls)
        //    {
        //        if (ctrl is RadTextBox)
        //        {
        //            ((RadTextBox)ctrl).Text = "";
        //        }
        //        //else if (ctrl is RadComboBox)
        //        //    ((RadComboBox)ctrl).Text = "";

        //        texbox_clear(ctrl.Controls);

        //    }
        //}
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


        //protected void cb_ref_PreRender(object sender, EventArgs e)
        //{
        //    con.Open();
        //    SqlCommand cmd = new SqlCommand();
        //    cmd.Connection = con;
        //    cmd.CommandType = CommandType.Text;
        //    cmd.CommandText = "SELECT doc_code FROM v_rs_reff WHERE doc_code = '" + (sender as RadComboBox).Text + "'";
        //    SqlDataReader dr;
        //    dr = cmd.ExecuteReader();
        //    while (dr.Read())
        //        (sender as RadComboBox).SelectedValue = dr[0].ToString();
        //    dr.Close();
        //    con.Close();
        //}



        //protected void RadGrid2_save_handler(object sender, GridCommandEventArgs e)
        //{
        //    try
        //    {
        //        GridEditableItem item = (GridEditableItem)e.Item;
        //        con.Open();
        //        cmd = new SqlCommand();
        //        cmd.CommandType = CommandType.StoredProcedure;
        //        cmd.Connection = con;
        //        cmd.CommandText = "sp_save_rsD";
        //        cmd.Parameters.AddWithValue("@doc_code", tr_code);
        //        cmd.Parameters.AddWithValue("@part_code", (item.FindControl("lblProdCode") as Label).Text);
        //        cmd.Parameters.AddWithValue("@oh_qty", Convert.ToDouble((item.FindControl("lblSoh") as Label).Text));
        //        cmd.Parameters.AddWithValue("@part_qty", Convert.ToDouble((item.FindControl("txtPartQty") as RadTextBox).Text));
        //        cmd.Parameters.AddWithValue("@part_unit", (item.FindControl("lblUom") as Label).Text);
        //        cmd.Parameters.AddWithValue("@remark", (item.FindControl("txtRemark_d") as RadTextBox).Text);
        //        cmd.Parameters.AddWithValue("@dept_code", (item.FindControl("lblCostCtr") as Label).Text);
        //        cmd.Parameters.AddWithValue("@tWarranty", "0");
        //        cmd.Parameters.AddWithValue("@deliv_date", string.Format("{0:yyyy-MM-dd}", (item.FindControl("dtpDelivDate") as RadDatePicker).SelectedDate));
        //        cmd.Parameters.AddWithValue("@prod_type", (item.FindControl("lblProdType") as Label).Text);
        //        cmd.ExecuteNonQuery();
        //        con.Close();

        //        notif.Show();
        //    }
        //    catch (Exception ex)
        //    {
        //        con.Close();
        //        RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
        //        e.Canceled = true;
        //    }
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
        //    }

        //}

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


        //protected void RadGrid2_BatchEditCommand(object sender, GridBatchEditingEventArgs e)
        //{
        //    foreach (GridBatchEditingCommand command in e.Commands)
        //    {
        //        if ((command.Type == GridBatchEditingCommandType.Update))
        //        {   
        //            try
        //            {
        //                //foreach (GridDataItem gItem in RadGrid1.SelectedItems)
        //                //{
        //                //    tr_code = gItem["doc_code"].Text;
        //                //}
        //                //con.Open();
        //                //GridEditableItem item = (GridEditableItem)e.Item;
        //                //cmd = new SqlCommand();
        //                //cmd.CommandType = CommandType.StoredProcedure;
        //                //cmd.Connection = con;
        //                //cmd.CommandText = "sp_save_rsD";
        //                //cmd.Parameters.AddWithValue("@doc_code", tr_code);
        //                //cmd.Parameters.AddWithValue("@part_code", (item.FindControl("lblProdCode") as Label).Text);
        //                //cmd.Parameters.AddWithValue("@oh_qty", Convert.ToDouble((item.FindControl("lblSoh") as Label).Text));
        //                //cmd.Parameters.AddWithValue("@part_qty", Convert.ToDouble((item.FindControl("txtPartQty") as RadTextBox).Text));
        //                //cmd.Parameters.AddWithValue("@part_unit", (item.FindControl("lblUom") as Label).Text);
        //                //cmd.Parameters.AddWithValue("@remark", (item.FindControl("txtRemark_d") as RadTextBox).Text);
        //                //cmd.Parameters.AddWithValue("@dept_code", (item.FindControl("lblCostCtr") as Label).Text);
        //                //cmd.Parameters.AddWithValue("@tWarranty", "0");
        //                //cmd.Parameters.AddWithValue("@deliv_date", string.Format("{0:yyyy-MM-dd}", (item.FindControl("dtpDelivDate") as RadDatePicker).SelectedDate));
        //                //cmd.Parameters.AddWithValue("@prod_type", (item.FindControl("lblProdType") as Label).Text);
        //                //cmd.ExecuteNonQuery();
        //                //con.Close();

        //                foreach (GridDataItem item in RadGrid2.MasterTableView.Items)
        //                {
        //                    cmd = new SqlCommand();
        //                    cmd.CommandType = CommandType.StoredProcedure;
        //                    cmd.Connection = con;
        //                    cmd.CommandText = "sp_save_rsD";
        //                    cmd.Parameters.AddWithValue("@doc_code", tr_code);
        //                    cmd.Parameters.AddWithValue("@part_code", (item.FindControl("lblProdCode") as Label).Text);
        //                    cmd.Parameters.AddWithValue("@oh_qty", Convert.ToDouble((item.FindControl("lblSoh") as Label).Text));
        //                    cmd.Parameters.AddWithValue("@part_qty", Convert.ToDouble((item.FindControl("txtPartQty") as RadTextBox).Text));
        //                    cmd.Parameters.AddWithValue("@part_unit", (item.FindControl("lblUom") as Label).Text);
        //                    cmd.Parameters.AddWithValue("@remark", (item.FindControl("txtRemark_d") as RadTextBox).Text);
        //                    cmd.Parameters.AddWithValue("@dept_code", (item.FindControl("lblCostCtr") as Label).Text);
        //                    cmd.Parameters.AddWithValue("@tWarranty", "0");
        //                    cmd.Parameters.AddWithValue("@deliv_date", string.Format("{0:yyyy-MM-dd}", (item.FindControl("dtpDelivDate") as RadDatePicker).SelectedDate));
        //                    cmd.Parameters.AddWithValue("@prod_type", (item.FindControl("lblProdType") as Label).Text);
        //                    cmd.ExecuteNonQuery();
        //                }


        //                notif.Show();
        //            }
        //            catch (Exception ex)
        //            {
        //                con.Close();
        //                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
        //                e.Canceled = true;
        //            }
        //        }
        //    }
        //}



        //protected void btnNew_Click(object sender, ImageClickEventArgs e)
        //{
        //    Session["action"] = "new";
        //    btnSave.Enabled = true;
        //    btnSave.ImageUrl = "~/Images/simpan.png";
        //    //RadGrid2.Enabled = false;
        //    btnPrint.Enabled = false;
        //    btnPrint.ImageUrl = "~/Images/cetak-gray.png";
        //    RadGrid2.DataSource = new string[] { };
        //    RadGrid2.DataBind();
        //    if (Session["action"].ToString() != "firstLoad")
        //    {
        //        clear_text(Page.Controls);
        //    }
        //    label_teks_default();
        //    cb_type_ref.Text = "Work Order";
        //    cb_type_ref.SelectedValue = "1";
        //    cb_project.SelectedValue = public_str.site;
        //    cb_project.Text = public_str.sitename;
        //    dtp_exe.SelectedDate = dtp_rs.SelectedDate;
        //}

        //protected void btnSave_Click(object sender, ImageClickEventArgs e)
        //{
        //    long maxNo;
        //    string run = null;
        //    string trDate = string.Format("{0:dd/MM/yyyy}", dtp_rs.SelectedDate);

        //    try
        //    {
        //        if (Session["action"].ToString() == "edit")
        //        {
        //            run = txt_doc_code.Text;
        //        }
        //        else
        //        {
        //            con.Open();
        //            SqlDataReader sdr;
        //            cmd = new SqlCommand("SELECT ISNULL ( MAX ( RIGHT ( fleet_doch.doc_code , 4 ) ) , 0 ) + 1 AS maxNo " +
        //                "FROM fleet_doch WHERE LEFT(fleet_doch.doc_code, 4) = 'RS01' " +
        //                "AND SUBSTRING(fleet_doch.doc_code, 5, 2) = SUBSTRING('" + trDate + "', 9, 2) " +
        //                "AND SUBSTRING(fleet_doch.doc_code, 7, 2) = SUBSTRING('" + trDate + "', 4, 2) ", con);
        //            sdr = cmd.ExecuteReader();
        //            if (sdr.HasRows == false)
        //            {
        //                //throw new Exception();
        //                run = "RS01" + dtp_rs.SelectedDate.Value.Year + dtp_rs.SelectedDate.Value.Month + "0001";
        //            }
        //            else if (sdr.Read())
        //            {
        //                maxNo = Convert.ToInt32(sdr[0].ToString());
        //                run = "RS01" + (dtp_rs.SelectedDate.Value.Year.ToString()).Substring(dtp_rs.SelectedDate.Value.Year.ToString().Length - 2) +
        //                    ("0000" + dtp_rs.SelectedDate.Value.Month).Substring(("0000" + dtp_rs.SelectedDate.Value.Month).Length - 2, 2) +
        //                    ("0000" + maxNo).Substring(("0000" + maxNo).Length - 4, 4);
        //            }
        //            con.Close();
        //        }


        //        con.Open();
        //        cmd = new SqlCommand();
        //        cmd.CommandType = CommandType.StoredProcedure;
        //        cmd.Connection = con;
        //        cmd.CommandText = "sp_save_rsH";
        //        cmd.Parameters.AddWithValue("@doc_code", run);
        //        cmd.Parameters.AddWithValue("@doc_date", string.Format("{0:yyyy-MM-dd}", dtp_rs.SelectedDate.Value));
        //        //cmd.Parameters.AddWithValue("@ref_date", dtp_ref.Text);
        //        cmd.Parameters.AddWithValue("@type_ref", cb_type_ref.SelectedValue);
        //        cmd.Parameters.AddWithValue("@date_exec", string.Format("{0:yyyy-MM-dd}", dtp_exe.SelectedDate.Value));
        //        cmd.Parameters.AddWithValue("@order_by", cb_orderBy.SelectedValue);
        //        cmd.Parameters.AddWithValue("@receive_by", cb_received.SelectedValue);
        //        cmd.Parameters.AddWithValue("@approval_by", cb_approved.SelectedValue);
        //        cmd.Parameters.AddWithValue("@doc_remark", txt_remark.Text);
        //        cmd.Parameters.AddWithValue("@unit_code", txt_unit_code.Text);
        //        cmd.Parameters.AddWithValue("@model_no", txt_unit_name.Text);
        //        if (txt_hm.Text != "")
        //        {
        //            cmd.Parameters.AddWithValue("@time_reading", Convert.ToDouble(txt_hm.Text));
        //        }
        //        else
        //        {
        //            cmd.Parameters.AddWithValue("@time_reading", 0);
        //        }
        //        cmd.Parameters.AddWithValue("@userid", public_str.user_id);
        //        cmd.Parameters.AddWithValue("@tFullSupply", "0");
        //        cmd.Parameters.AddWithValue("@LastUpdate", DateTime.Today);
        //        cmd.Parameters.AddWithValue("@region_code", cb_project.SelectedValue);
        //        cmd.Parameters.AddWithValue("@dept_code", txt_cost_center.Text);
        //        cmd.Parameters.AddWithValue("@sro_code", cb_ref.SelectedValue);
        //        cmd.Parameters.AddWithValue("@Owner", public_str.user_id);
        //        cmd.Parameters.AddWithValue("@Stamp", DateTime.Today);
        //        //cmd.Parameters.AddWithValue("@Printed", txt_printed.Text);
        //        //cmd.Parameters.AddWithValue("@Edited", txt_edited.Text);
        //        cmd.Parameters.AddWithValue("@Lvl", public_str.level);
        //        cmd.Parameters.AddWithValue("@wh_code", cb_warehouse.SelectedValue);
        //        //cmd.Parameters.AddWithValue("@wh_code", cb_warehouse.SelectedValue);
        //        cmd.ExecuteNonQuery();


        //        // Save Detail

        //        foreach (GridDataItem item in RadGrid2.MasterTableView.Items)
        //        {
        //            cmd = new SqlCommand();
        //            cmd.CommandType = CommandType.StoredProcedure;
        //            cmd.Connection = con;
        //            cmd.CommandText = "sp_save_rsD";
        //            cmd.Parameters.AddWithValue("@doc_code", run);
        //            cmd.Parameters.AddWithValue("@part_code", (item.FindControl("lblProdCode") as Label).Text);
        //            cmd.Parameters.AddWithValue("@oh_qty", Convert.ToDouble((item.FindControl("lblSoh") as Label).Text));
        //            cmd.Parameters.AddWithValue("@part_qty", Convert.ToDouble((item.FindControl("txtPartQty") as RadTextBox).Text));
        //            cmd.Parameters.AddWithValue("@part_unit", (item.FindControl("lblUom") as Label).Text);
        //            cmd.Parameters.AddWithValue("@remark", (item.FindControl("txtRemark_d") as RadTextBox).Text);
        //            cmd.Parameters.AddWithValue("@dept_code", (item.FindControl("lblCostCtr") as Label).Text);
        //            cmd.Parameters.AddWithValue("@tWarranty", "0");
        //            cmd.Parameters.AddWithValue("@deliv_date", string.Format("{0:yyyy-MM-dd}", (item.FindControl("dtpDelivDate") as RadDatePicker).SelectedDate));
        //            cmd.Parameters.AddWithValue("@prod_type", (item.FindControl("lblProdType") as Label).Text);
        //            cmd.ExecuteNonQuery();
        //        }


        //        con.Close();
        //        notif.Text = "Data berhasil disimpan";
        //        notif.Title = "Notification";
        //        notif.Show();
        //        txt_doc_code.Text = run;
        //        //RadGrid2.Enabled = true;
        //        btnSave.Enabled = false;
        //        btnPrint.Enabled = true;
        //        btnPrint.ImageUrl = "~/Images/cetak.png";
        //        btnPrint.Attributes["OnClick"] = String.Format("return ShowPreview('{0}');", txt_doc_code.Text);
        //        if (Session["action"].ToString() == "new" && chk_to_pr.Checked == true)
        //        {
        //            if (cb_type_ref.SelectedValue == "1")
        //            {
        //                Response.Redirect("~/Form/Purchase/PurchaseReq/pur01h01.aspx?pr_code=" + System.Web.HttpUtility.UrlEncode(run) +
        //                "&reff_date=" + System.Web.HttpUtility.UrlEncode(string.Format("{0:dd-MM-yyyy}", dtp_rs.SelectedDate.Value)) +
        //                "&project=" + System.Web.HttpUtility.UrlEncode(cb_project.Text) +
        //                "&costCtr=" + System.Web.HttpUtility.UrlEncode(txt_cost_center.Text) +
        //                "&unit=" + System.Web.HttpUtility.UrlEncode(txt_unit_code.Text) +
        //                "&hm=" + System.Web.HttpUtility.UrlEncode(txt_hm.Text) +
        //                "&model=" + System.Web.HttpUtility.UrlEncode(txt_unit_name.Text) +
        //                "&wo=" + System.Web.HttpUtility.UrlEncode(cb_ref.SelectedValue) +
        //                "&remark=" + System.Web.HttpUtility.UrlEncode(txt_remark.Text));
        //            }
        //            else if (cb_type_ref.SelectedValue == "2")
        //            {
        //                Response.Redirect("~/Form/Purchase/PurchaseReq/pur01h01a.aspx?pr_code=" + System.Web.HttpUtility.UrlEncode(run) +
        //                "&reff_date=" + System.Web.HttpUtility.UrlEncode(string.Format("{0:dd-MM-yyyy}", dtp_rs.SelectedDate.Value)) +
        //                "&project=" + System.Web.HttpUtility.UrlEncode(cb_project.Text) +
        //                "&costCtr=" + System.Web.HttpUtility.UrlEncode(txt_cost_center.Text) +
        //                "&unit=" + System.Web.HttpUtility.UrlEncode(txt_unit_code.Text) +
        //                "&remark=" + System.Web.HttpUtility.UrlEncode(txt_remark.Text));
        //            }
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        con.Close();
        //        //Response.Write("<font color='red'>" + ex.Message + "</font>");
        //        RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "");
        //        //RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn","");
        //    }
        //}

        //protected void btnPrint_Click(object sender, ImageClickEventArgs e)
        //{
        //    btnPrint.Attributes["OnClick"] = String.Format("return ShowPreview('{0}');", txt_doc_code.Text);
        //}

        //private static DataTable GetWarehouse(string text, string project)
        //{
        //    SqlDataAdapter adapter = new SqlDataAdapter("SELECT wh_code, wh_name FROM ms_warehouse WHERE stEdit != 4 AND PlantCode = @PlantCode AND wh_name LIKE @text + '%'",
        //    ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
        //    adapter.SelectCommand.Parameters.AddWithValue("@PlantCode", project);
        //    adapter.SelectCommand.Parameters.AddWithValue("@text", text);

        //    DataTable data = new DataTable();
        //    adapter.Fill(data);

        //    return data;
        //}
        //protected void cb_warehouse_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        //{
        //    DataTable data = GetWarehouse(e.Text, cb_project.SelectedValue);

        //    int itemOffset = e.NumberOfItems;
        //    int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
        //    e.EndOfItems = endOffset == data.Rows.Count;

        //    for (int i = itemOffset; i < endOffset; i++)
        //    {
        //        (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["wh_name"].ToString(), data.Rows[i]["wh_name"].ToString()));
        //    }
        //}

        //protected void cb_warehouse_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        //{
        //    con.Open();
        //    SqlCommand cmd = new SqlCommand();
        //    cmd.Connection = con;
        //    cmd.CommandType = CommandType.Text;
        //    cmd.CommandText = "SELECT wh_code FROM ms_warehouse WHERE wh_name = '" + (sender as RadComboBox).Text + "'";
        //    SqlDataReader dr;
        //    dr = cmd.ExecuteReader();
        //    while (dr.Read())
        //        (sender as RadComboBox).SelectedValue = dr[0].ToString();
        //    dr.Close();
        //    con.Close();
        //}

        //protected void cb_warehouse_PreRender(object sender, EventArgs e)
        //{
        //    con.Open();
        //    SqlCommand cmd = new SqlCommand();
        //    cmd.Connection = con;
        //    cmd.CommandType = CommandType.Text;
        //    cmd.CommandText = "SELECT wh_code FROM ms_warehouse WHERE wh_name = '" + (sender as RadComboBox).Text + "'";
        //    SqlDataReader dr;
        //    dr = cmd.ExecuteReader();
        //    while (dr.Read())
        //        (sender as RadComboBox).SelectedValue = dr[0].ToString();
        //    dr.Close();
        //    con.Close();
        //}


        //protected void cb_prod_code_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        //{
        //    string sql = "SELECT TOP (100)[prod_code], [spec] FROM [ms_product]  WHERE stEdit != '4' AND spec LIKE @spec + '%'";
        //    SqlDataAdapter adapter = new SqlDataAdapter(sql,
        //        ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
        //    adapter.SelectCommand.Parameters.AddWithValue("@spec", e.Text);

        //    DataTable dt = new DataTable();
        //    adapter.Fill(dt);

        //    RadComboBox comboBox = (RadComboBox)sender;
        //    // Clear the default Item that has been re-created from ViewState at this point.
        //    comboBox.Items.Clear();

        //    foreach (DataRow row in dt.Rows)
        //    {
        //        RadComboBoxItem item = new RadComboBoxItem();
        //        item.Text = row["prod_code"].ToString();
        //        item.Value = row["prod_code"].ToString();
        //        item.Attributes.Add("spec", row["spec"].ToString());

        //        comboBox.Items.Add(item);

        //        item.DataBind();
        //    }
        //}

        //protected void cb_prod_code_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        //{
        //    Session["prod_code"] = e.Value;

        //    try
        //    {
        //        con.Open();
        //        SqlCommand cmd = new SqlCommand();
        //        cmd.Connection = con;
        //        cmd.CommandType = CommandType.Text;
        //        cmd.CommandText = "SELECT spec,unit FROM ms_product WHERE prod_code = '" + (sender as RadComboBox).SelectedValue + "'";

        //        SqlDataAdapter adapter = new SqlDataAdapter(cmd);
        //        DataTable dt = new DataTable();
        //        adapter.Fill(dt);
        //        foreach (DataRow dtr in dt.Rows)
        //        {
        //            RadComboBox cb = (RadComboBox)sender;
        //            GridEditableItem item = (GridEditableItem)cb.NamingContainer;
        //            RadTextBox t_spec = (RadTextBox)item.FindControl("txt_prod_name");
        //            RadComboBox cb_prodType = (RadComboBox)item.FindControl("cb_uom_d");
        //            RadComboBox cbDept_d = (RadComboBox)item.FindControl("cb_dept_d");

        //            t_spec.Text = dtr["spec"].ToString();
        //            cb_prodType.Text = dtr["unit"].ToString();
        //            cbDept_d.Text = cb_cost_center.SelectedValue;
        //        }

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

        //protected void cb_prod_code_PreRender(object sender, EventArgs e)
        //{
        //    con.Open();
        //    SqlCommand cmd = new SqlCommand();
        //    cmd.Connection = con;
        //    cmd.CommandType = CommandType.Text;
        //    cmd.CommandText = "SELECT prod_code FROM ms_product WHERE spec = '" + (sender as RadComboBox).Text + "'";
        //    SqlDataReader dr;
        //    dr = cmd.ExecuteReader();
        //    while (dr.Read())
        //        (sender as RadComboBox).SelectedValue = dr[0].ToString();
        //    dr.Close();
        //    con.Close();
        //}
    }
}