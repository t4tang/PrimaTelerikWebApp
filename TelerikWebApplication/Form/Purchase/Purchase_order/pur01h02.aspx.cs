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

namespace TelerikWebApplication.Forms.Purchase.Purchase_order
{
    public partial class pur01h02 : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();

        private const int ItemsPerRequest = 10;

        public static string tr_code = null;
        public static string reff_code = null;
        public static string selected_project = null;
        public static string tax_check = null;
        public static string oTax_check = null;
        public static string pph_check = null;
        public static string tax1 = null;
        public static string tax2 = null;
        public static string tax3 = null;
        private static string GetStatusMessage(int offset, int total)
        {
            if (total <= 0)
                return "No matches";

            return String.Format("Items <b>1</b>-<b>{0}</b> out of <b>{1}</b>", offset, total);
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lbl_form_name.Text = "Purchase Order";
                dtp_from.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
                dtp_to.SelectedDate = DateTime.Now;
                selected_project = public_str.site;
                cb_proj_prm.SelectedValue = public_str.site;
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

                    RadGrid2.DataSource = GetDataDetailTable(tr_code);
                    RadGrid2.Rebind();
                }
                else if (e.Argument == "RebindAndNavigate")
                {
                    RadGrid1.MasterTableView.SortExpressions.Clear();
                    RadGrid1.MasterTableView.GroupByExpressions.Clear();
                    RadGrid1.DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), selected_project);
                    RadGrid1.DataBind();
                    //RadGrid1.MasterTableView.CurrentPageIndex = RadGrid1.MasterTableView.PageCount - 1;
                    //RadGrid1.MasterTableView.Items[RadGrid1.Items.Count - 1].Selected = true;
                    RadGrid1.MasterTableView.Items[0].Selected = true;
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
        public DataTable GetDataTable(string fromDate, string toDate, string project)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_purchase_orderH";
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
            (sender as RadGrid).DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), cb_proj_prm.SelectedValue);
        }
        protected void RadGrid1_DeleteCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            var doc_code = ((GridDataItem)e.Item).GetDataKeyValue("po_code");

            try
            {
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "UPDATE pur01h02 SET userid = @Usr, lastupdate = GETDATE(), status_pur = '4' WHERE (po_code = @po_code)";
                cmd.Parameters.AddWithValue("@po_code", doc_code);
                cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
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
        protected void RadGrid1_ItemCreated(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                ImageButton editLink = (ImageButton)e.Item.FindControl("EditLink");
                editLink.Attributes["href"] = "javascript:void(0);";
                editLink.Attributes["onclick"] = String.Format("return ShowEditForm('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["po_code"], e.Item.ItemIndex);

                ImageButton printLink = (ImageButton)e.Item.FindControl("PrintLink");
                printLink.Attributes["href"] = "javascript:void(0);";
                printLink.Attributes["onclick"] = String.Format("return ShowPreview('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["po_code"], e.Item.ItemIndex);

            }
        }
        protected void RadGrid1_SelectedIndexChanged(object sender, EventArgs e)
        {
            foreach (GridDataItem item in RadGrid1.SelectedItems)
            {
                tr_code = item["po_code"].Text;
                reff_code = item["refNo"].Text;
                tax1 = item["tax1"].Text;
                tax2 = item["tax2"].Text;
                tax3 = item["tax3"].Text;
            }

            populate_detail();
            Session["action"] = "list";
        }
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
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            RadGrid1.DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), cb_proj_prm.SelectedValue);
            RadGrid1.DataBind();
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
        private static DataTable GetProject(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT region_code, region_name FROM inv00h09 WHERE stEdit != 4 AND region_name LIKE @text + '%' ",
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
            }
            dr.Close();
            con.Close();
            
        }
        public DataTable GetDataDetailTable(string po_no)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT po_code, prod_type, Prod_code, Spec, qty, SatQty, harga, Disc, ISNULL(tfactor,0) as factor, jumlah, CAST(tTax AS Bit) AS tTax, " +
                "CAST(tOtax AS Bit) AS tOtax, CAST(tpph AS Bit) AS tpph, " +
                "dept_code, Prod_code_ori, twarranty, jTax1, jTax2, jTax3, nomer as nomor FROM pur01d02 WHERE po_code = '" + po_no + "'";
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
                RadGrid2.DataSource = GetDataDetailTable(tr_code);
            }
        }
        protected void RadGrid2_UpdateCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            try
            {
                con.Open();
                GridEditableItem item = (GridEditableItem)e.Item;
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_save_purchase_orderD";
                cmd.Parameters.AddWithValue("@po_code", tr_code);
                cmd.Parameters.AddWithValue("@prod_type", (item.FindControl("lblProdType") as Label).Text);
                cmd.Parameters.AddWithValue("@Prod_code", (item.FindControl("cb_prod_code") as RadComboBox).Text);
                cmd.Parameters.AddWithValue("@qty", Convert.ToDouble((item.FindControl("txt_qty") as RadNumericTextBox).Text));
                cmd.Parameters.AddWithValue("@SatQty", (item.FindControl("lblUom") as Label).Text);
                cmd.Parameters.AddWithValue("@harga2", Convert.ToDouble((item.FindControl("txt_harga") as RadTextBox).Text));
                cmd.Parameters.AddWithValue("@Disc", Convert.ToDouble((item.FindControl("txt_disc") as RadTextBox).Text));
                cmd.Parameters.AddWithValue("@tTax", tax_check);
                cmd.Parameters.AddWithValue("@tOTax", oTax_check);
                cmd.Parameters.AddWithValue("@tpph", pph_check);
                cmd.Parameters.AddWithValue("@harga", Convert.ToDouble((item.FindControl("txt_harga") as RadTextBox).Text));
                cmd.Parameters.AddWithValue("@Prod_code_ori", (item.FindControl("lbl_Prod_code_ori") as Label).Text);
                cmd.Parameters.AddWithValue("@dept_code", (item.FindControl("lbl_cost_ctr") as Label).Text);
                cmd.Parameters.AddWithValue("@factor", Convert.ToDouble((item.FindControl("txt_factor") as RadTextBox).Text));
                cmd.Parameters.AddWithValue("@Asscost", 0);
                cmd.Parameters.AddWithValue("@reff_no", reff_code);
                cmd.Parameters.AddWithValue("@tax1", tax1);
                cmd.Parameters.AddWithValue("@tax2", tax2);
                cmd.Parameters.AddWithValue("@tax3", tax3);
                
                cmd.ExecuteNonQuery();

                con.Close();

                notif.Show();
            }
            catch (Exception ex)
            {
                con.Close();
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
                e.Canceled = true;
            }
        }
        protected void RadGrid2_DeleteCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            var partCode = ((GridDataItem)e.Item).GetDataKeyValue("Prod_code");

            try
            {
                GridEditableItem item = (GridEditableItem)e.Item;
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "delete from pur01d02 where Prod_code = @part_code and po_code = @doc_code";
                cmd.Parameters.AddWithValue("@doc_code", tr_code);
                cmd.Parameters.AddWithValue("@part_code", partCode);
                cmd.ExecuteNonQuery();
                con.Close();
                RadGrid2.DataBind();

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

        #region Tax
        protected void edt_chkTax1_CheckedChanged(object sender, EventArgs e)
        {
            if ((sender as CheckBox).Checked == true)
            {
                tax_check = "1";
            }
            else
            {
                tax_check = "0";
            }
        }

        protected void edt_chkOTax_CheckedChanged(object sender, EventArgs e)
        {
            if ((sender as CheckBox).Checked == true)
            {
                oTax_check = "1";
            }
            else
            {
                oTax_check = "0";
            }
        }

        protected void edt_chkTpph_CheckedChanged(object sender, EventArgs e)
        {
            if ((sender as CheckBox).Checked == true)
            {
                pph_check = "1";
            }
            else
            {
                pph_check = "0";
            }
        }

        protected void edt_chkTax1_PreRender(object sender, EventArgs e)
        {
            if ((sender as CheckBox).Checked == true)
            {
                tax_check = "1";
            }
            else
            {
                tax_check = "0";
            }
        }
        protected void edt_chkOTax_PreRender(object sender, EventArgs e)
        {
            if ((sender as CheckBox).Checked == true)
            {
                oTax_check = "1";
            }
            else
            {
                oTax_check = "0";
            }
        }

        protected void edt_chkTpph_PreRender(object sender, EventArgs e)
        {
            if ((sender as CheckBox).Checked == true)
            {
                pph_check = "1";
            }
            else
            {
                pph_check = "0";
            }
        }

        #endregion


        //private void get_po(string fromDate, string toDate, string project)
        //{
        //    con.Open();
        //    cmd = new SqlCommand();
        //    cmd.CommandType = CommandType.StoredProcedure;
        //    cmd.Connection = con;
        //    cmd.CommandText = "sp_get_purchase_order";
        //    cmd.Parameters.AddWithValue("@date", fromDate);
        //    cmd.Parameters.AddWithValue("@todate", toDate);
        //    cmd.Parameters.AddWithValue("@project", project);
        //    cmd.CommandTimeout = 0;
        //    cmd.ExecuteNonQuery();
        //    sda = new SqlDataAdapter(cmd);

        //    DataTable DT = new DataTable();

        //    try
        //    {
        //        sda.Fill(DT);
        //        RadGrid1.DataSource = DT;
        //        RadGrid1.DataBind();
        //    }
        //    finally
        //    {
        //        con.Close();
        //    }

        //}


        //////protected void chk_lock_detail_CheckedChanged(object sender, EventArgs e)
        //////{
        //////    if (chk_lock_detail.Checked)
        //////    {
        //////        RadGrid2.Enabled = false;
        //////    }
        //////}
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
        //    cb_po_type.Text = "Inventory";
        //    cb_po_type.SelectedValue = "INV";
        //    cb_priority.Text = "Hight/Urgent";
        //    cb_priority.SelectedValue = "1";
        //    cb_project.SelectedValue = public_str.site;
        //    cb_project.Text = public_str.sitename;
        //    dtp_exp.SelectedDate = dtp_po.SelectedDate;
        //}

        //private void set_info()
        //{
        //    txt_uid.Text = public_str.uid;
        //    txt_lastUpdate.Text = string.Format("{0:dd/MM/yyyy hh:mm:ss}", DateTime.Today);
        //    txt_owner.Text = public_str.uid;
        //    txt_printed.Text = "0";
        //    txt_edited.Text = "0";
        //}
        ////private void clear_text(ControlCollection ctrls)
        ////{
        ////    foreach (Control ctrl in ctrls)
        ////    {
        ////        if (ctrl is RadTextBox)
        ////        {
        ////            ((RadTextBox)ctrl).Text = "";
        ////        }
        ////        else if (ctrl is RadComboBox)
        ////            ((RadComboBox)ctrl).Text = "";

        ////        clear_text(ctrl.Controls);

        ////    }
        ////}

        //private void teks_default()
        //{
        //    txt_uid.Text = "User: ";
        //    txt_lastUpdate.Text = "Last Update: ";
        //    txt_owner.Text = "Owner:";
        //    txt_printed.Text = "Printed: ";
        //    txt_edited.Text = "Edited: ";

        //}

        //private void teks_clear()
        //{
        //    txt_uid.Text = "";
        //    txt_lastUpdate.Text = "";
        //    txt_owner.Text = "";
        //    txt_printed.Text = "";
        //    txt_edited.Text = "";

        //}

        //protected void btnSave_Click(object sender, ImageClickEventArgs e)
        //{
        //    long maxNo;
        //    string run = null;
        //    string trDate = string.Format("{0:dd/MM/yyyy}", dtp_po.SelectedDate);

        //    try
        //    {
        //        if (Session["action"].ToString() == "edit")
        //        {
        //            run = txt_po_code.Text;
        //        }
        //        else
        //        {
        //            con.Open();
        //            SqlDataReader sdr;
        //            cmd = new SqlCommand("SELECT ISNULL ( MAX ( RIGHT ( pur01h01.po_code , 4 ) ) , 0 ) + 1 AS maxNo " +
        //                "FROM pur01h01 WHERE LEFT(pur01h01.po_code, 4) = 'PR01' " +
        //                "AND SUBSTRING(pur01h01.po_code, 5, 2) = SUBSTRING('" + trDate + "', 9, 2) " +
        //                "AND SUBSTRING(pur01h01.po_code, 7, 2) = SUBSTRING('" + trDate + "', 4, 2) ", con);
        //            sdr = cmd.ExecuteReader();
        //            if (sdr.HasRows == false)
        //            {
        //                //throw new Exception();
        //                run = "PR01" + dtp_po.SelectedDate.Value.Year + dtp_po.SelectedDate.Value.Month + "0001";
        //            }
        //            else if (sdr.Read())
        //            {
        //                maxNo = Convert.ToInt32(sdr[0].ToString());
        //                run = "PR01" + (dtp_po.SelectedDate.Value.Year.ToString()).Substring(dtp_po.SelectedDate.Value.Year.ToString().Length - 2) +
        //                    ("0000" + dtp_po.SelectedDate.Value.Month).Substring(("0000" + dtp_po.SelectedDate.Value.Month).Length - 2, 2) +
        //                    ("0000" + maxNo).Substring(("0000" + maxNo).Length - 4, 4);
        //            }
        //            con.Close();
        //        }


        //        con.Open();
        //        cmd = new SqlCommand();
        //        cmd.CommandType = CommandType.StoredProcedure;
        //        cmd.Connection = con;
        //        cmd.CommandText = "sp_save_poH";
        //        cmd.Parameters.AddWithValue("@po_code", run);
        //        cmd.Parameters.AddWithValue("@Po_date", string.Format("{0:yyyy-MM-dd}", dtp_po.SelectedDate.Value));
        //        cmd.Parameters.AddWithValue("@exp_date", string.Format("{0:yyyy-MM-dd}", dtp_exp.SelectedDate.Value));
        //        cmd.Parameters.AddWithValue("@trans_code", cb_po_type.SelectedValue);
        //        cmd.Parameters.AddWithValue("@priority_code", cb_priority.Text);
        //        cmd.Parameters.AddWithValue("@etd", string.Format("{0:yyyy-MM-dd}", dtp_etd.SelectedDate.Value));
        //        cmd.Parameters.AddWithValue("@ShipModeEtd", cb_ship_mode.SelectedValue);
        //        cmd.Parameters.AddWithValue("@ppn", cb_tax1.SelectedValue);
        //        cmd.Parameters.AddWithValue("@PPNIncl", chk_ppn_incl.Checked);
        //        cmd.Parameters.AddWithValue("@kurs", txt_kurs.Text);
        //        cmd.Parameters.AddWithValue("@kurs_tax", txt_tax_kurs.Text);
        //        cmd.Parameters.AddWithValue("@pay_code", cb_term.SelectedValue);
        //        cmd.Parameters.AddWithValue("@JTempo", txt_term_days.Text);
        //        cmd.Parameters.AddWithValue("@attname", txt_term_days.Text);
        //        cmd.Parameters.AddWithValue("@remark", txt_remark.Text);
        //        cmd.Parameters.AddWithValue("@FreBy", cb_prepared.SelectedValue);
        //        cmd.Parameters.AddWithValue("@OrdBy", cb_verified.SelectedValue);
        //        cmd.Parameters.AddWithValue("@AppBy", cb_approved.SelectedValue);
        //        cmd.Parameters.AddWithValue("@vendor_code", cb_supplier.SelectedValue);
        //        cmd.Parameters.AddWithValue("@vendor_name", cb_supplier.SelectedValue);
        //        cmd.Parameters.AddWithValue("@cur_code", txt_curr.Text);
        //        cmd.Parameters.AddWithValue("@tot_amount", txt_remark.Text);
        //        cmd.Parameters.AddWithValue("@PPPN", txt_pppn.Text);
        //        cmd.Parameters.AddWithValue("@userid", public_str.user_id);
        //        cmd.Parameters.AddWithValue("@JPPN", txt_tax1_value.Text);
        //        cmd.Parameters.AddWithValue("@OTaxIncl", cb_tax1.SelectedValue);
        //        cmd.Parameters.AddWithValue("@JOTax", txt_tax2_value.Text);
        //        cmd.Parameters.AddWithValue("@Net", txt_sub_total.Text);
        //        cmd.Parameters.AddWithValue("@Freight", 0);
        //        cmd.Parameters.AddWithValue("@Othercost", txt_other_value.Text);
        //        cmd.Parameters.AddWithValue("@Ass", 0);
        //        cmd.Parameters.AddWithValue("@DP", 0);
        //        cmd.Parameters.AddWithValue("@OTax", cb_tax2.SelectedValue);
        //        cmd.Parameters.AddWithValue("@PlantCode", cb_project.SelectedValue);
        //        cmd.Parameters.AddWithValue("@dept_code", cb_cost_center.SelectedValue);
        //        cmd.Parameters.AddWithValue("@no_ref", cb_reff.SelectedValue);
        //        cmd.Parameters.AddWithValue("@ref_date", txt_pr_date.Text);
        //        cmd.Parameters.AddWithValue("@pph", "NON");
        //        cmd.Parameters.AddWithValue("@pphIncl", cb_tax3.SelectedValue);
        //        cmd.Parameters.AddWithValue("@Jpph", txt_tax3_value.Text);
        //        cmd.Parameters.AddWithValue("@Owner", txt_owner.Text);
        //        cmd.Parameters.AddWithValue("@OwnStamp", string.Format("{0:yyyy-MM-dd}", DateTime.Now));
        //        cmd.Parameters.AddWithValue("@doc_type", 1);
        //        cmd.Parameters.AddWithValue("@tFullSupply", 0);
        //        cmd.Parameters.AddWithValue("@tMonOrder", 0);
        //        cmd.Parameters.AddWithValue("@doc_status", cb_priority.SelectedValue);
        //        cmd.Parameters.AddWithValue("@share_date", string.Format("{0:yyyy-MM-dd}", dtp_share_date.SelectedDate.Value));
        //        //cmd.Parameters.AddWithValue("@deliv_address", "");
        //        cmd.Parameters.AddWithValue("@valid_period", txt_validity.Text);
        //        cmd.Parameters.AddWithValue("@ppph", txt_ppph.Text);
        //        cmd.Parameters.AddWithValue("@poTax", txt_po_tax.Text);

        //        //cmd.Parameters.AddWithValue("@asset_id", "NON");
        //        cmd.ExecuteNonQuery();


        //        // Save Detail
        //        //cmd = new SqlCommand();
        //        //cmd.CommandType = CommandType.Text;
        //        //cmd.Connection = con;
        //        //cmd.CommandText = "DELETE FROM pur01d01 WHERE po_code = @po_code";
        //        //cmd.Parameters.AddWithValue("@po_code", run);
        //        //cmd.ExecuteNonQuery();

        //        foreach (GridDataItem item in RadGrid2.MasterTableView.Items)
        //        {
        //            cmd = new SqlCommand();
        //            cmd.CommandType = CommandType.StoredProcedure;
        //            cmd.Connection = con;
        //            cmd.CommandText = "sp_save_poD";
        //            cmd.Parameters.AddWithValue("@prod_type", (item.FindControl("txt_type") as RadTextBox).Text);
        //            cmd.Parameters.AddWithValue("@Prod_code", (item.FindControl("cb_prod_code") as RadComboBox).SelectedValue);
        //            cmd.Parameters.AddWithValue("@spec", (item.FindControl("txt_prod_name") as RadTextBox).Text);
        //            cmd.Parameters.AddWithValue("@qty", Convert.ToDouble((item.FindControl("txt_qty") as RadTextBox).Text));
        //            cmd.Parameters.AddWithValue("@SatQty", (item.FindControl("cb_uom_d") as RadComboBox).SelectedValue);
        //            cmd.Parameters.AddWithValue("@harga", (item.FindControl("lblHarga") as Label).Text);
        //            cmd.Parameters.AddWithValue("@Disc", (item.FindControl("txt_disc") as RadTextBox).Text);
        //            cmd.Parameters.AddWithValue("@factor", (item.FindControl("txt_factor") as RadTextBox).Text);
        //            cmd.Parameters.AddWithValue("@jumlah", (item.FindControl("txt_sub_price") as RadTextBox).Text);
        //            cmd.Parameters.AddWithValue("@dept_code", (item.FindControl("txt_cost_ctr") as RadTextBox).Text);
        //            cmd.Parameters.AddWithValue("@Prod_code_ori", (item.FindControl("txt_Prod_code_ori") as RadTextBox).Text);
        //            cmd.Parameters.AddWithValue("@harga2", (item.FindControl("lblHarga") as Label).Text);
        //            //cmd.Parameters.AddWithValue("@tTax", (item.FindControl("lblRS") as RadTextBox).Text);
        //            //cmd.Parameters.AddWithValue("@tOTax", (item.FindControl("lblUom") as RadTextBox).Text);
        //            //cmd.Parameters.AddWithValue("@tpph", (item.FindControl("lblRS") as RadTextBox).Text);
        //            cmd.Parameters.AddWithValue("@nomer", (item.FindControl("lblUom") as RadTextBox).Text);
        //            cmd.Parameters.AddWithValue("@JDisc", (item.FindControl("txt_JDisk") as RadTextBox).Text);
        //            cmd.Parameters.AddWithValue("@HPokok", (item.FindControl("txt_HPokok") as RadTextBox).Text);
        //            cmd.Parameters.AddWithValue("@jumlah2", (item.FindControl("txt_sub_price") as RadTextBox).Text);
        //            cmd.Parameters.AddWithValue("@NoContr", (item.FindControl("txt_NoContr") as RadTextBox).Text);
        //            //cmd.Parameters.AddWithValue("@jTax1", (item.FindControl("lblRS") as RadTextBox).Text);
        //            //cmd.Parameters.AddWithValue("@jTax2", (item.FindControl("lblRS") as RadTextBox).Text);
        //            //cmd.Parameters.AddWithValue("@jTax3", (item.FindControl("lblRS") as RadTextBox).Text);
        //            cmd.Parameters.AddWithValue("@Asscost", 0);

        //            cmd.ExecuteNonQuery();

        //        }
        //        con.Close();

        //        //HttpContext.Current.Response.Write("<script>alert('" + System.Web.HttpUtility.HtmlEncode("Berhasil disimpan") + "')</script>");
        //        notif.Text = "Data berhasil disimpan";
        //        notif.Title = "Notification";
        //        notif.Show();
        //        txt_po_code.Text = run;
        //        //RadGrid2.Enabled = true;
        //        btnSave.Enabled = false;
        //        btnPrint.Enabled = true;
        //        btnPrint.ImageUrl = "~/Images/cetak.png";
        //        btnPrint.Attributes["OnClick"] = String.Format("return ShowPreview('{0}');", txt_po_code.Text);
        //    }
        //    catch (System.Exception ex)
        //    {
        //        con.Close();
        //        RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
        //        //RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "");
        //        //Response.Write("<font color='red'>" + ex.Message + "</font>");
        //    }
        //    //pur01h02_slip._tot_amount = Convert.ToDouble(txt_total.Text);
        //}

        ////protected void btnPrint_Click(object sender, ImageClickEventArgs e)
        ////{
        ////    //pur01h02_slip._tot_amount = Convert.ToDouble(txt_total.Text);
        ////    btnPrint.Attributes["OnClick"] = String.Format("return ShowPreview('{0}');", txt_po_code.Text);

        ////}



        ////protected void RadGrid2_save_handler(object sender, GridCommandEventArgs e)
        ////{
        ////    //try
        ////    //{
        ////    //    GridEditableItem item = (GridEditableItem)e.Item;
        ////    //    con.Open();
        ////    //    cmd = new SqlCommand();
        ////    //    cmd.CommandType = CommandType.StoredProcedure;
        ////    //    cmd.Connection = con;
        ////    //    cmd.CommandText = "sp_save_urD";
        ////    //    cmd.Parameters.AddWithValue("@doc_code", txt_ur_number.Text);
        ////    //    cmd.Parameters.AddWithValue("@part_code", (item.FindControl("cb_prod_code") as RadComboBox).Text);
        ////    //    cmd.Parameters.AddWithValue("@part_qty", Convert.ToDecimal((item.FindControl("txt_qty") as RadTextBox).Text));
        ////    //    cmd.Parameters.AddWithValue("@part_unit", (item.FindControl("cb_uom_d") as RadComboBox).Text);
        ////    //    cmd.Parameters.AddWithValue("@remark", (item.FindControl("txt_remark_d") as RadTextBox).Text);
        ////    //    cmd.Parameters.AddWithValue("@dept_code", (item.FindControl("cb_dept_d") as RadComboBox).Text);
        ////    //    cmd.ExecuteNonQuery();
        ////    //    con.Close();
        ////    //    RadGrid2.DataBind();
        ////    //    RadGrid2.Rebind();

        ////    //    Label lblsuccess = new Label();
        ////    //    lblsuccess.Text = "Data saved";
        ////    //    lblsuccess.ForeColor = System.Drawing.Color.DarkGray;
        ////    //    RadGrid2.Controls.Add(lblsuccess);
        ////    //}
        ////    //catch (Exception ex)
        ////    //{
        ////    //    con.Close();
        ////    //    Label lblError = new Label();
        ////    //    lblError.Text = "Unable to insert data. Reason: " + ex.Message;
        ////    //    lblError.ForeColor = System.Drawing.Color.Red;
        ////    //    RadGrid2.Controls.Add(lblError);
        ////    //    e.Canceled = true;
        ////    //}
        ////}
        //protected void RadGrid1_SaveCommand(object source, GridCommandEventArgs e)
        //{
        //    UserControl userControl = (UserControl)e.Item.FindControl(GridEditFormItem.EditFormUserControlID);

        //    try
        //    {
        //        if ((userControl.FindControl("txt_validity") as TextBox).Text != "0")
        //        {
        //            long maxNo;
        //            string run = null;
        //            RadDatePicker dtp_po = userControl.FindControl("dtp_po") as RadDatePicker;
        //            string trDate = string.Format("{0:dd/MM/yyyy}", dtp_po.SelectedDate.Value);
        //            //trDate = string.Format("{0:dd/MM/yyyy}", dtp_po.SelectedDate.Value);

        //            if ((userControl.FindControl("txt_validity") as TextBox).Text == string.Empty)
        //            {
        //                con.Open();
        //                SqlDataReader sdr;
        //                cmd = new SqlCommand("SELECT ISNULL ( MAX ( RIGHT ( pur01h02.po_code , 4 ) ) , 0 ) + 1 AS maxNo " +
        //                    "FROM pur01h02 WHERE LEFT(pur01h02.po_code, 4) = 'PO03' " +
        //                    "AND SUBSTRING(pur01h02.po_code, 5, 2) = SUBSTRING('" + trDate + "', 9, 2) " +
        //                    "AND SUBSTRING(pur01h02.po_code, 7, 2) = SUBSTRING('" + trDate + "', 4, 2) ", con);
        //                sdr = cmd.ExecuteReader();
        //                if (sdr.HasRows == false)
        //                {
        //                    //throw new Exception();
        //                    run = "PO01" + dtp_po.SelectedDate.Value.Year + dtp_po.SelectedDate.Value.Month + "0001";
        //                }
        //                else if (sdr.Read())
        //                {
        //                    maxNo = Convert.ToInt32(sdr[0].ToString());
        //                    run = "PO03" + (dtp_po.SelectedDate.Value.Year.ToString()).Substring(dtp_po.SelectedDate.Value.Year.ToString().Length - 2) +
        //                        ("0000" + dtp_po.SelectedDate.Value.Month).Substring(("0000" + dtp_po.SelectedDate.Value.Month).Length - 2, 2) +
        //                        ("0000" + maxNo).Substring(("0000" + maxNo).Length - 4, 4);
        //                }

        //                //txt_po_no.Text = run.ToString();
        //                con.Close();
        //            }
        //            else
        //            {
        //                run = (userControl.FindControl("txt_po_code") as TextBox).Text;
        //            }

        //            int tax1Inc;
        //            int tax2Inc;
        //            int tax3Inc;

        //            if ((userControl.FindControl("chk_ppn_incl") as CheckBox).Checked == true)
        //            {
        //                if ((userControl.FindControl("cb_tax2") as RadComboBox).Text == "0")
        //                {
        //                    tax1Inc = 1;
        //                }
        //                else
        //                {
        //                    tax1Inc = 0;

        //                }
        //                tax2Inc = 0;
        //            }
        //            else
        //            {
        //                tax2Inc = 1;
        //            }

        //            if ((userControl.FindControl("cb_tax3") as RadComboBox).Text == "0")
        //            {
        //                tax3Inc = 0;
        //            }
        //            else
        //            {
        //                tax3Inc = 1;
        //            }

        //            int t_fsupply = 0;
        //            if ((userControl.FindControl("cb_full_supply") as CheckBox).Checked == true)
        //            {
        //                t_fsupply = 1;
        //            }
        //            else
        //            {
        //                t_fsupply = 0;
        //            }
        //            int t_monitor_order = 0;
        //            if ((userControl.FindControl("cb_monitor_order") as CheckBox).Checked == true)
        //            {
        //                t_monitor_order = 1;
        //            }
        //            else
        //            {
        //                t_monitor_order = 0;
        //            }

        //            con.Open();
        //            cmd = new SqlCommand();
        //            cmd.CommandType = CommandType.StoredProcedure;
        //            cmd.Connection = con;
        //            cmd.CommandText = "sp_save_poH";
        //            cmd.Parameters.AddWithValue("@po_code", run);
        //            cmd.Parameters.AddWithValue("@Po_date", string.Format("{0:yyyy-MM-dd}", dtp_po.SelectedDate.Value));
        //            cmd.Parameters.AddWithValue("@exp_date", string.Format("{0:yyyy-MM-dd}", (userControl.FindControl("dtp_exp") as RadDatePicker).SelectedDate.Value));
        //            cmd.Parameters.AddWithValue("@trans_code", (userControl.FindControl("cb_po_type") as RadComboBox).Text);
        //            cmd.Parameters.AddWithValue("@priority_code", (userControl.FindControl("cb_priority") as RadComboBox).Text);
        //            cmd.Parameters.AddWithValue("@etd", string.Format("{0:yyyy-MM-dd}", (userControl.FindControl("dtp_etd") as RadDatePicker).SelectedDate.Value));
        //            cmd.Parameters.AddWithValue("@ShipModeEtd", (userControl.FindControl("cb_priority") as RadComboBox).SelectedValue);
        //            cmd.Parameters.AddWithValue("@kurs", double.Parse((userControl.FindControl("txt_kurs") as TextBox).Text));
        //            cmd.Parameters.AddWithValue("@kurs_tax", double.Parse((userControl.FindControl("txt_tax_kurs") as TextBox).Text));
        //            cmd.Parameters.AddWithValue("@pay_code", (userControl.FindControl("cb_term") as RadComboBox).SelectedValue);
        //            cmd.Parameters.AddWithValue("@JTempo", double.Parse((userControl.FindControl("txt_term_days") as TextBox).Text));
        //            cmd.Parameters.AddWithValue("@attname", (userControl.FindControl("txt_term_days") as TextBox).Text);
        //            cmd.Parameters.AddWithValue("@FreBy", (userControl.FindControl("cb_prepared") as RadComboBox).SelectedValue);
        //            cmd.Parameters.AddWithValue("@OrdBy", (userControl.FindControl("cb_verified") as RadComboBox).SelectedValue);
        //            cmd.Parameters.AddWithValue("@AppBy", (userControl.FindControl("cb_approved") as RadComboBox).SelectedValue);
        //            cmd.Parameters.AddWithValue("@remark", (userControl.FindControl("txt_remark") as TextBox).Text);
        //            cmd.Parameters.AddWithValue("@vendor_code", (userControl.FindControl("cb_supplier") as RadComboBox).SelectedValue);
        //            cmd.Parameters.AddWithValue("@vendor_name", (userControl.FindControl("cb_supplier") as RadComboBox).Text);
        //            cmd.Parameters.AddWithValue("@tot_amount", double.Parse((userControl.FindControl("txt_remark") as TextBox).Text));
        //            cmd.Parameters.AddWithValue("@cur_code", (userControl.FindControl("cb_priority") as RadComboBox).Text);
        //            cmd.Parameters.AddWithValue("@userid", (userControl.FindControl("txt_uid") as TextBox).Text);

        //            //cmd.Parameters.AddWithValue("@PPNIncl", tax1Inc);
        //            cmd.Parameters.AddWithValue("@ppn", (userControl.FindControl("cb_tax1") as RadComboBox).SelectedValue);
        //            cmd.Parameters.AddWithValue("@PPPN", double.Parse((userControl.FindControl("txt_pppn") as TextBox).Text));
        //            cmd.Parameters.AddWithValue("@JPPN", double.Parse((userControl.FindControl("txt_tax1_value") as TextBox).Text));

        //            cmd.Parameters.AddWithValue("@OTaxIncl", tax2Inc);
        //            cmd.Parameters.AddWithValue("@OTax", (userControl.FindControl("cb_tax2") as RadComboBox).SelectedValue);
        //            cmd.Parameters.AddWithValue("@poTax", double.Parse((userControl.FindControl("txt_po_tax") as TextBox).Text));
        //            cmd.Parameters.AddWithValue("@JOTax", double.Parse((userControl.FindControl("txt_tax2_value") as TextBox).Text));

        //            cmd.Parameters.AddWithValue("@pphIncl", tax3Inc);
        //            cmd.Parameters.AddWithValue("@pph", (userControl.FindControl("cb_tax3") as RadComboBox).SelectedValue);
        //            cmd.Parameters.AddWithValue("@ppph", double.Parse((userControl.FindControl("txt_ppph") as TextBox).Text));
        //            cmd.Parameters.AddWithValue("@Jpph", double.Parse((userControl.FindControl("txt_tax3_value") as TextBox).Text));

        //            cmd.Parameters.AddWithValue("@Net", double.Parse((userControl.FindControl("txt_sub_total") as TextBox).Text));
        //            cmd.Parameters.AddWithValue("@Freight", 0);
        //            cmd.Parameters.AddWithValue("@Othercost", double.Parse((userControl.FindControl("txt_other_value") as TextBox).Text));
        //            cmd.Parameters.AddWithValue("@Ass", 0);
        //            cmd.Parameters.AddWithValue("@DP", 0);
        //            cmd.Parameters.AddWithValue("@PlantCode", (userControl.FindControl("cb_project") as RadComboBox).SelectedValue);
        //            cmd.Parameters.AddWithValue("@dept_code", (userControl.FindControl("cb_cost_center") as RadComboBox).SelectedValue);
        //            if ((userControl.FindControl("txt_reff_no") as TextBox).Text != string.Empty)
        //            {
        //                cmd.Parameters.AddWithValue("@no_ref", (userControl.FindControl("txt_reff_no") as TextBox).Text);
        //                cmd.Parameters.AddWithValue("@ref_date", Convert.ToDateTime((userControl.FindControl("txt_reff_date") as TextBox).Text));
        //            }
        //            else
        //            {
        //                cmd.Parameters.AddWithValue("@no_ref", DBNull.Value);
        //                cmd.Parameters.AddWithValue("@ref_date", DBNull.Value);
        //            }

        //            cmd.Parameters.AddWithValue("@Owner", (userControl.FindControl("txt_owner") as TextBox).Text);
        //            cmd.Parameters.AddWithValue("@OwnStamp", string.Format("{0:yyyy-MM-dd}", DateTime.Now));
        //            cmd.Parameters.AddWithValue("@doc_type", "1");
        //            cmd.Parameters.AddWithValue("@tFullSupply", t_fsupply);
        //            cmd.Parameters.AddWithValue("@tMonOrder", t_monitor_order);
        //            cmd.Parameters.AddWithValue("@doc_status", (userControl.FindControl("cb_priority") as RadComboBox).Text);
        //            cmd.Parameters.AddWithValue("@share_date", string.Format("{0:yyyy-MM-dd}", (userControl.FindControl("dtp_share_date") as RadDatePicker).SelectedDate.Value));
        //            cmd.Parameters.AddWithValue("@deliv_address", "");
        //            cmd.Parameters.AddWithValue("@valid_period", double.Parse((userControl.FindControl("txt_validity") as TextBox).Text));
        //            cmd.Parameters.AddWithValue("@Lvl", public_str.level);
        //            cmd.ExecuteNonQuery();


        //            ////======= INSERT DETAIL =====================
        //            //cmd = new SqlCommand("sp_save_poD", con);
        //            //cmd.CommandType = CommandType.StoredProcedure;

        //            //cmd.Parameters.Add(new SqlParameter("@po_code", SqlDbType.NVarChar));
        //            //cmd.Parameters.Add(new SqlParameter("@prod_type", SqlDbType.NVarChar));
        //            //cmd.Parameters.Add(new SqlParameter("@Prod_code", SqlDbType.NVarChar));
        //            //cmd.Parameters.Add(new SqlParameter("@qty", SqlDbType.Decimal));
        //            //cmd.Parameters.Add(new SqlParameter("@SatQty", SqlDbType.NVarChar));
        //            //cmd.Parameters.Add(new SqlParameter("@harga2", SqlDbType.Money));
        //            //cmd.Parameters.Add(new SqlParameter("@Disc", SqlDbType.Decimal));
        //            //cmd.Parameters.Add(new SqlParameter("@tTax", SqlDbType.Int));
        //            //cmd.Parameters.Add(new SqlParameter("@tOTax", SqlDbType.Int));
        //            //cmd.Parameters.Add(new SqlParameter("@tpph", SqlDbType.Int));
        //            //cmd.Parameters.Add(new SqlParameter("@nomer", SqlDbType.Int));
        //            //cmd.Parameters.Add(new SqlParameter("@Jdisc", SqlDbType.Money));
        //            //cmd.Parameters.Add(new SqlParameter("@jumlah", SqlDbType.Money));
        //            //cmd.Parameters.Add(new SqlParameter("@Spec", SqlDbType.NVarChar));
        //            //cmd.Parameters.Add(new SqlParameter("@Hpokok", SqlDbType.Money));
        //            //cmd.Parameters.Add(new SqlParameter("@jumlah2", SqlDbType.Money));
        //            //cmd.Parameters.Add(new SqlParameter("@harga", SqlDbType.Money));
        //            //cmd.Parameters.Add(new SqlParameter("@NoContr", SqlDbType.NVarChar));
        //            //cmd.Parameters.Add(new SqlParameter("@prod_code_ori", SqlDbType.NVarChar));
        //            //cmd.Parameters.Add(new SqlParameter("@dept_code", SqlDbType.NVarChar));
        //            //cmd.Parameters.Add(new SqlParameter("@jTax1", SqlDbType.Money));
        //            //cmd.Parameters.Add(new SqlParameter("@jTax2", SqlDbType.Money));
        //            //cmd.Parameters.Add(new SqlParameter("@jTax3", SqlDbType.Money));
        //            //cmd.Parameters.Add(new SqlParameter("@factor", SqlDbType.Money));
        //            //cmd.Parameters.Add(new SqlParameter("@Asscost", SqlDbType.Money));


        //            //foreach (GridViewRowInfo row in (userControl.FindControl("RadGrid2") as RadGrid).Rows)
        //            //{
        //            //    cmd.Parameters["@po_code"].Value = run;
        //            //    cmd.Parameters["@prod_type"].Value = row.Cells["prod_type"].Value;
        //            //    cmd.Parameters["@Prod_code"].Value = row.Cells["MaterialCode"].Value;
        //            //    cmd.Parameters["@qty"].Value = row.Cells["QOrder"].Value;
        //            //    cmd.Parameters["@SatQty"].Value = row.Cells["UOM"].Value;
        //            //    cmd.Parameters["@harga2"].Value = row.Cells["Price"].Value;
        //            //    cmd.Parameters["@Disc"].Value = row.Cells["Disc"].Value;
        //            //    if (row.Cells["tTax"].Value != null)
        //            //    {
        //            //        cmd.Parameters["@tTax"].Value = row.Cells["tTax"].Value;
        //            //    }
        //            //    else
        //            //    {
        //            //        cmd.Parameters["@tTax"].Value = 0;
        //            //    }
        //            //    if (row.Cells["tOTax"].Value != null)
        //            //    {
        //            //        cmd.Parameters["@tOTax"].Value = row.Cells["tOTax"].Value;
        //            //    }
        //            //    else
        //            //    {
        //            //        cmd.Parameters["@tOTax"].Value = 0;
        //            //    }
        //            //    if (row.Cells["tpph"].Value != null)
        //            //    {
        //            //        cmd.Parameters["@tpph"].Value = row.Cells["tpph"].Value;
        //            //    }
        //            //    else
        //            //    {
        //            //        cmd.Parameters["@tpph"].Value = 0;
        //            //    }
        //            //    cmd.Parameters["@nomer"].Value = row.Cells["nomor"].Value;
        //            //    cmd.Parameters["@Jdisc"].Value = row.Cells["Disc"].Value; //?
        //            //    cmd.Parameters["@jumlah"].Value = row.Cells["SubPrice"].Value;
        //            //    cmd.Parameters["@Spec"].Value = row.Cells["Description"].Value;
        //            //    cmd.Parameters["@Hpokok"].Value = row.Cells["Price"].Value;
        //            //    cmd.Parameters["@jumlah2"].Value = row.Cells["SubPrice"].Value;
        //            //    cmd.Parameters["@harga"].Value = row.Cells["Price"].Value;
        //            //    if (row.Cells["no_ref"].Value != null)
        //            //    {
        //            //        cmd.Parameters["@NoContr"].Value = row.Cells["no_ref"].Value;
        //            //    }
        //            //    else
        //            //    {
        //            //        cmd.Parameters["@NoContr"].Value = DBNull.Value;
        //            //    }

        //            //    cmd.Parameters["@prod_code_ori"].Value = row.Cells["OriginalMaterial"].Value;
        //            //    cmd.Parameters["@dept_code"].Value = row.Cells["dept_code"].Value;
        //            //    cmd.Parameters["@jTax1"].Value = row.Cells["jTax1"].Value;
        //            //    cmd.Parameters["@jTax2"].Value = row.Cells["jTax2"].Value;
        //            //    cmd.Parameters["@jTax3"].Value = row.Cells["jTax3"].Value;
        //            //    cmd.Parameters["@factor"].Value = row.Cells["Factor"].Value;
        //            //    cmd.Parameters["@Asscost"].Value = 0;

        //            //    cmd.ExecuteNonQuery();
        //            //}

        //            //cmd = new SqlCommand("delete pur01d02 where tDel = '0' and po_code = '" + txt_po_no.Text + "'", con);
        //            //cmd.CommandType = CommandType.Text;
        //            //cmd.ExecuteNonQuery();

        //            //cmd = new SqlCommand("update pur01d02 set tDel = '0' where po_code = '" + txt_po_no.Text + "'", con);
        //            //cmd.CommandType = CommandType.Text;
        //            //cmd.ExecuteNonQuery();

        //            con.Close();
        //            (userControl.FindControl("txt_po_no") as TextBox).Text = run;
        //            (userControl.FindControl("txt_edited") as TextBox).Text = "0";
        //            (userControl.FindControl("txt_lastUpdate") as TextBox).Text = string.Format("{0:yyyy/MM/dd}", DateTime.Now);
        //            (userControl.FindControl("txt_printed") as TextBox).Text = "0";
        //            //RadMessageBox.Show("Records Saved sucessfully");
        //            //ses_detail();
        //            Label lblsuccess = new Label();
        //            lblsuccess.Text = "Data saved successfully";
        //            lblsuccess.ForeColor = System.Drawing.Color.Blue;
        //            RadGrid1.Controls.Add(lblsuccess);
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        con.Close();
        //        Label lblError = new Label();
        //        lblError.Text = "Unable to save data. Reason: " + ex.Message;
        //        lblError.ForeColor = System.Drawing.Color.Red;
        //        RadGrid1.Controls.Add(lblError);
        //        e.Canceled = true;
        //    }
        //}
        //protected void RadGrid2_DeleteCommand(object sender, GridCommandEventArgs e)
        //{

        //}
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
                cmd.CommandText = "SELECT spec,unit FROM inv00h01 WHERE prod_code = '" + (sender as RadComboBox).SelectedValue + "'";

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                foreach (DataRow dtr in dt.Rows)
                {
                    RadComboBox cb = (RadComboBox)sender;
                    GridEditableItem item = (GridEditableItem)cb.NamingContainer;
                    RadTextBox t_spec = (RadTextBox)item.FindControl("txt_prod_name");
                    RadComboBox cb_prodType = (RadComboBox)item.FindControl("cb_uom_d");
                    RadComboBox cbDept_d = (RadComboBox)item.FindControl("cb_dept_d");

                    t_spec.Text = dtr["spec"].ToString();
                    cb_prodType.Text = dtr["unit"].ToString();
                    //cbDept_d.Text = cb_cost_center.SelectedValue;
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

        protected void RadGrid1_PreRender(object sender, System.EventArgs e)
        {
            if (!this.IsPostBack && this.RadGrid1.MasterTableView.Items.Count > 1)
            {
                this.RadGrid1.MasterTableView.Items[0].Edit = false;
                this.RadGrid1.MasterTableView.Rebind();
            }
        }

    }
}