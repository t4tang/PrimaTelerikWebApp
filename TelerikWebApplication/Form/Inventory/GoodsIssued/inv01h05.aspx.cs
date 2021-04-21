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

namespace TelerikWebApplication.Form.Inventory.GoodsIssued
{
    public partial class inv01h05 : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();

        private const int ItemsPerRequest = 10;
        public static string tr_code = null;
        public static string selected_project = null;
        public static string selected_wh_code = null;
        public static string selected_reff_code = null;
        public static string tWarannty_check = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lbl_form_name.Text = "Goods Issued";
                dtp_from.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
                dtp_to.SelectedDate = DateTime.Now;
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
                    RadGrid1.Rebind(); /* Kemudian RadGrid1 akan sorting data by lastupdate (lihat sp_get_purchase_requestH*/
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
                    //RadGrid1.MasterTableView.Items[0].Selected = true;
                    RadGrid2.DataSource = GetDataDetailTable(tr_code);
                    RadGrid2.Rebind();
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
            cmd.CommandText = "SELECT region_code FROM inv00h09 WHERE region_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                selected_project= dr[0].ToString();
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            }
            dr.Close();
            con.Close();
        }
        #endregion

        #region storage loc

        protected void GetLoc(string name, string projectID, RadComboBox cb)
        {
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);

            SqlDataAdapter adapter = new SqlDataAdapter("SELECT upper(wh_code) as code,upper(wh_name) as name FROM inv00h05 " +
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

        protected void cb_loc_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT wh_code FROM inv00h05 WHERE wh_name = '" + cb_warehouse.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_warehouse.SelectedValue = dr["wh_code"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_loc_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT wh_code FROM inv00h05 WHERE wh_name = '" + cb_warehouse.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_warehouse.SelectedValue = dr["wh_code"].ToString();
            dr.Close();
            con.Close();
        }
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
            var do_code = ((GridDataItem)e.Item).GetDataKeyValue("do_code");

            try
            {
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_delete_goods_issued";
                cmd.Parameters.AddWithValue("@do_code", do_code);
                cmd.Parameters.AddWithValue("@uid", public_str.user_id);
                cmd.ExecuteNonQuery();
                con.Close();

                //Label lblOk = new Label();
                //lblOk.Text = "Data deleted successfully";
                //lblOk.ForeColor = System.Drawing.Color.Teal;
                //RadGrid1.Controls.Add(lblOk);
            }
            catch (Exception ex)
            {
                con.Close();
                //Label lblError = new Label();
                //lblError.Text = "Unable to delete data. Reason: " + ex.Message;
                //lblError.ForeColor = System.Drawing.Color.Red;
                //RadGrid1.Controls.Add(lblError);
                e.Canceled = true;
            }
        }

        protected void RadGrid1_ItemCreated(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                ImageButton editLink = (ImageButton)e.Item.FindControl("EditLink");
                editLink.Attributes["href"] = "javascript:void(0);";
                editLink.Attributes["onclick"] = String.Format("return ShowEditForm('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["do_code"], e.Item.ItemIndex);

                ImageButton printLink = (ImageButton)e.Item.FindControl("PrintLink");
                printLink.Attributes["href"] = "javascript:void(0);";
                printLink.Attributes["onclick"] = String.Format("return ShowPreview('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["do_code"], e.Item.ItemIndex);

            }
        }

        #endregion


        //private void teks_default()
        //{
        //    txt_uid.Text = "User: ";
        //    txt_owner.Text = "Owner: ";
        //    txt_lastUpdate.Text = "Last Update: ";
        //    txt_printed.Text = "Printed: ";
        //    txt_edited.Text = "Edited: ";
        //}
        //private void teks_clear()
        //{
        //    txt_uid.Text = "";
        //    txt_owner.Text = "";
        //    txt_lastUpdate.Text = "";
        //    txt_printed.Text = "";
        //    txt_edited.Text = "";

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
        //    set_info();
        //    teks_default();
        //    cb_CustSupp.Text = "PRIMA SARANA GEMILANG, PT";
        //    cb_CustSupp.SelectedValue = "PSG";
        //    cb_type_ref.Text = "Consumption";
        //    cb_type_ref.SelectedValue = "6";
        //    cb_Project.SelectedValue = public_str.site;
        //    cb_Project.Text = public_str.sitename;
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
        //    txt_uid.Text = public_str.uid;
        //    txt_lastUpdate.Text = string.Format("{0:dd/MM/yyyy hh:mm:ss}", DateTime.Today);
        //    txt_owner.Text = public_str.uid;
        //    txt_printed.Text = "0";
        //    txt_edited.Text = "0";
        //}


        #region Detail

        private void populate_detail()
        {
            if (tr_code == null)
            {
                RadGrid2.DataSource = new string[] { };
            }
            else
            {
                RadGrid2.DataSource = GetDataDetailTable(tr_code);
            }

            RadGrid2.DataBind();
        }
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
        public DataTable GetDataRefDetailTable(string do_code)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_goods_issued_refD";
            cmd.Parameters.AddWithValue("@doc_code", do_code);
            //cmd.Parameters.AddWithValue("@type_ref", "1");
            //cmd.Parameters.AddWithValue("@part_desc", cb_loc.SelectedValue);
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
        protected void RadGrid2_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            if (tr_code == null)
            {
                (sender as RadGrid).DataSource = new string[] { };
            }
            else
            {
                (sender as RadGrid).DataSource = GetDataDetailTable(tr_code);
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
                cmd.CommandText = "delete from inv01d03 where prod_code = @prod_code and do_code = @do_code";
                cmd.Parameters.AddWithValue("@do_code", tr_code);
                cmd.Parameters.AddWithValue("@prod_code", prod_code);
                cmd.ExecuteNonQuery();
                con.Close();
                RadGrid2.DataBind();

                Label lblsuccess = new Label();
                lblsuccess.Text = "Data deleted";
                lblsuccess.ForeColor = System.Drawing.Color.DarkGray;
                RadGrid2.Controls.Add(lblsuccess);
            }
            catch (Exception ex)
            {
                con.Close();
                Label lblError = new Label();
                lblError.Text = "Unable to delete data. Reason: " + ex.Message;
                lblError.ForeColor = System.Drawing.Color.Red;
                RadGrid2.Controls.Add(lblError);
                e.Canceled = true;
            }
        }

        #endregion

        protected void RadGrid1_SelectedIndexChanged(object sender, EventArgs e)
        {
            foreach (GridDataItem item in RadGrid1.SelectedItems)
            {
                tr_code = item["do_code"].Text;
                //selected_wh_code = item["warehouse"].Text;
                //selected_reff_code = item["ref_code"].Text;
            }

            populate_detail();
            Session["action"] = "list";
        }

        private static string GetStatusMessage(int offset, int total)
        {
            if (total <= 0)
                return "No matches";

            return String.Format("Items <b>1</b>-<b>{0}</b> out of <b>{1}</b>", offset, total);
        }

    }

    //protected void btnPrint_Click(object sender, ImageClickEventArgs e)
    //{
    //    btnPrint.Attributes["OnClick"] = String.Format("return ShowPreview('{0}');", txt_gi_number.Text);
    //}

    //protected void btnOk_Click(object sender, EventArgs e)
    //{
    //    foreach (GridDataItem item in RadGrid1.SelectedItems)
    //    {
    //        //label_teks_default();
    //        con.Open();
    //        SqlDataReader sdr;
    //        SqlCommand cmd = new SqlCommand("SELECT * FROM v_gi_list WHERE do_code = '" + item["do_code"].Text + "'", con);
    //        sdr = cmd.ExecuteReader();
    //        if (sdr.Read())
    //        {
    //            txt_gi_number.Text = sdr["do_code"].ToString();
    //            dtp_date.SelectedDate = Convert.ToDateTime(sdr["Tgl"].ToString());
    //            cb_type_ref.Text = sdr["type_do"].ToString();
    //            cb_CustSupp.Text = sdr["cust_name"].ToString();
    //            //cb_Project.SelectedValue = sdr["region_code"].ToString();
    //            cb_Project.Text = sdr["region_name"].ToString();
    //            //cb_costcenter.SelectedValue = sdr["dept_code"].ToString();
    //            cb_CostCenter.Text = sdr["dept_code"].ToString();
    //            txt_CostCenterName.Text = sdr["CostCenterName"].ToString();
    //            cb_loc.Text = sdr["wh_name"].ToString();
    //            cb_ref.Text = sdr["ref_code"].ToString();
    //            //cb_unit.SelectedValue = sdr["unit_code"].ToString();
    //            txt_unit.Text = sdr["unit_code"].ToString();
    //            txt_limit.Text = sdr["unit_reading"].ToString();
    //            cb_receipt.Text = sdr["FreByName"].ToString();
    //            cb_issued.Text = sdr["OrdByName"].ToString();
    //            cb_approval.Text = sdr["AppByName"].ToString();
    //            cb_receipt.SelectedValue = sdr["FreBy"].ToString();
    //            cb_issued.SelectedValue = sdr["OrdBy"].ToString();
    //            cb_approval.SelectedValue = sdr["AppBy"].ToString();
    //            txt_remark.Text = sdr["remark"].ToString();
    //            txt_uid.Text = sdr["userid"].ToString();
    //            txt_lastUpdate.Text = string.Format("{0:dd-MM-yyyy}", sdr["lastupdate"].ToString());
    //            txt_owner.Text = sdr["Owner"].ToString();
    //            txt_printed.Text = sdr["Printed"].ToString();
    //            txt_edited.Text = sdr["Edited"].ToString();
    //        }
    //        con.Close();

    //        RadGrid2.DataSource = GetDataDetailTable(txt_gi_number.Text);
    //        RadGrid2.DataBind();
    //        Session["action"] = "edit";
    //        //RadGrid2.Enabled = true;
    //        btnSave.Enabled = true;
    //        btnSave.ImageUrl = "~/Images/simpan.png";
    //        btnPrint.Enabled = true;
    //        btnPrint.ImageUrl = "~/Images/cetak.png";
    //        btnPrint.Attributes["OnClick"] = String.Format("return ShowPreview('{0}');", txt_gi_number.Text);
    //    }
    //}

}