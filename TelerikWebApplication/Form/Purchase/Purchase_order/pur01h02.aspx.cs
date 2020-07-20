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
                //RadGrid1.MasterTableView.EditMode = (GridEditMode)Enum.Parse(typeof(GridEditMode), "EditForms");
                //RadGrid1.MasterTableView.EditMode = (GridEditMode)Enum.Parse(typeof(GridEditMode), "PopUp");
                dtp_from.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
                dtp_to.SelectedDate = DateTime.Now;
                //cb_project.Text = public_str.sitename;
                cb_project_prm.SelectedValue = public_str.site;

                //label_teks_default();
                dtp_po.SelectedDate = DateTime.Now;
                Session["action"] = "firstLoad";
                //RadGrid2.Enabled = false;
                btnSave.Enabled = false;
                btnSave.ImageUrl = "~/Images/simpan-gray.png";
                btnPrint.Enabled = false;
                btnPrint.ImageUrl = "~/Images/cetak-gray.png";
            }
        }

        //protected void RadGrid1_ItemCreated(object sender, GridItemEventArgs e)
        //{
        //    if (e.Item is GridDataItem)
        //    {
        //        //HyperLink editLink = (HyperLink)e.Item.FindControl("EditLink");
        //        ImageButton editLink = (ImageButton)e.Item.FindControl("EditLink");
        //        editLink.Attributes["href"] = "javascript:void(0);";
        //        editLink.Attributes["onclick"] = String.Format("return ShowEditForm('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["po_code"], e.Item.ItemIndex);
        //    }
        //}
        protected void RadGrid1_PreRender(object sender, System.EventArgs e)
        {
            if (!this.IsPostBack && this.RadGrid1.MasterTableView.Items.Count > 1)
            {
                this.RadGrid1.MasterTableView.Items[0].Edit = false;
                this.RadGrid1.MasterTableView.Rebind();
            }
        }


        public DataTable GetDataTable(string fromDate, string toDate, string project)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_purchase_order";
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
            (sender as RadGrid).DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), cb_project_prm.SelectedValue);
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            get_po(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), cb_project_prm.SelectedValue);
        }
        private void get_po(string fromDate, string toDate, string project)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_purchase_order";
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
                RadGrid1.DataSource = DT;
                RadGrid1.DataBind();
            }
            finally
            {
                con.Close();
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
        protected void btnOk_Click(object sender, EventArgs e)
        {
            foreach (GridDataItem item in RadGrid1.SelectedItems)
            {
                con.Open();
                SqlDataReader sdr;
                SqlCommand cmd = new SqlCommand("SELECT a.*, b.unit_code FROM v_purchase_order a LEFT OUTER JOIN pur01h01 b ON " +
                    "a.no_ref=b.po_code WHERE a.po_code =  '" + item["po_code"].Text + "'", con);
                sdr = cmd.ExecuteReader();
                if (sdr.Read())
                {
                    txt_po_code.Text = sdr["po_code"].ToString();
                    dtp_po.SelectedDate = Convert.ToDateTime(sdr["Po_date"].ToString());
                    dtp_exp.SelectedDate = Convert.ToDateTime(sdr["exp_date"].ToString());
                    cb_reff.Text = sdr["no_ref"].ToString();
                    cb_po_type.Text = sdr["TransName"].ToString();
                    cb_priority.Text = sdr["prio_desc"].ToString();
                    dtp_etd.SelectedDate = Convert.ToDateTime(sdr["etd"].ToString());
                    cb_ship_mode.Text = sdr["ShipMode"].ToString();
                    cb_supplier.Text = sdr["vendor_name"].ToString();
                    txt_curr.Text = sdr["cur_code"].ToString();
                    txt_kurs.Text = sdr["kurs"].ToString();
                    txt_tax_kurs.Text = sdr["kurs_tax"].ToString();
                    if (sdr["ppnIncl"].ToString() == "1")
                    {
                        chk_ppn_incl.Checked = true;
                    }
                    else
                    {
                        chk_ppn_incl.Checked = false;
                    }
                    cb_tax1.Text = sdr["tax1"].ToString();
                    cb_tax2.Text = sdr["tax2"].ToString();
                    cb_tax3.Text = sdr["tax3"].ToString();
                    cb_project.Text = sdr["region_name"].ToString();
                    cb_cost_center.Text = sdr["CostCenterName"].ToString();
                    //txt_Po_date.Text = string.Format("{0:dd/MM/yyyy}", sdr["ref_date"].ToString());
                    txt_remark.Text = sdr["Remark"].ToString();
                    txt_term_days.Text = sdr["JTempo"].ToString();
                    cb_prepared.Text = sdr["Order_by"].ToString();
                    cb_verified.Text = sdr["Prepare_by"].ToString();
                    cb_approved.Text = sdr["Order_by"].ToString();
                    txt_owner.Text = sdr["Owner"].ToString();
                    txt_printed.Text = sdr["Printed"].ToString();
                    txt_edited.Text = sdr["Edited"].ToString();
                    txt_uid.Text = sdr["userid"].ToString();
                    txt_lastUpdate.Text = string.Format("{0:dd/MM/yyyy}", sdr["lastupdate"].ToString());
                    txt_validity.Text = sdr["validity_period"].ToString();
                    cb_term.Text = sdr["payTerm"].ToString();
                    txt_pppn.Value = Convert.ToDouble(sdr["PPPN"]);
                    txt_ppph.Value = Convert.ToDouble(sdr["ppph"]);
                    txt_po_tax.Value = Convert.ToDouble(sdr["POTax"]);
                    txt_sub_total.Value = Convert.ToDouble(sdr["tot_amount"]);
                    txt_tax1_value.Value = Convert.ToDouble(sdr["jtax1"]);
                    txt_tax2_value.Value = Convert.ToDouble(sdr["jtax2"]);
                    txt_tax3_value.Value = Convert.ToDouble(sdr["jtax3"]);
                    txt_total.Value = Convert.ToDouble(sdr["Net"]);
                    txt_other_value.Value = Convert.ToDouble(sdr["Othercost"]);
                    cb_po_status.SelectedValue = sdr["doc_status"].ToString();
                    if (sdr["doc_status"].ToString() == "0")
                    {
                        cb_po_status.Text = "OPEN";
                    }
                    else if (sdr["doc_status"].ToString() == "1")
                    {
                        cb_po_status.Text = "SHARED";
                    }
                    else if (sdr["doc_status"].ToString() == "2")
                    {
                        cb_po_status.Text = "HOLD";
                    }
                    //pur01h02_slip._tot_amount = Convert.ToDouble(sdr["tot_amount"]);
                    //pur01h02_slip._unit_code = sdr["unit_code"].ToString();
                }
                con.Close();

                //RadGrid2.DataSource = GetDataDetailTable(txt_po_code.Text);
                ////RadGrid2.DataBind();
                Session["action"] = "edit";
                RadGrid2.Enabled = true;
                btnSave.Enabled = false;
                //btnSave.ImageUrl = "~/Images/simpan.png";
                btnPrint.Enabled = true;
                btnPrint.ImageUrl = "~/Images/cetak.png";
                btnPrint.Attributes["OnClick"] = String.Format("return ShowPreview('{0}');", txt_po_code.Text);
            }

        }

        protected void RadGrid1_SaveCommand(object source, GridCommandEventArgs e)
        {
            UserControl userControl = (UserControl)e.Item.FindControl(GridEditFormItem.EditFormUserControlID);

            try
            {
                if ((userControl.FindControl("txt_validity") as TextBox).Text != "0")
                {
                    long maxNo;
                    string run = null;
                    RadDatePicker dtp_po = userControl.FindControl("dtp_po") as RadDatePicker;
                    string trDate = string.Format("{0:dd/MM/yyyy}", dtp_po.SelectedDate.Value);
                    //trDate = string.Format("{0:dd/MM/yyyy}", dtp_po.SelectedDate.Value);

                    if ((userControl.FindControl("txt_validity") as TextBox).Text == string.Empty)
                    {
                        con.Open();
                        SqlDataReader sdr;
                        cmd = new SqlCommand("SELECT ISNULL ( MAX ( RIGHT ( pur01h02.po_code , 4 ) ) , 0 ) + 1 AS maxNo " +
                            "FROM pur01h02 WHERE LEFT(pur01h02.po_code, 4) = 'PO03' " +
                            "AND SUBSTRING(pur01h02.po_code, 5, 2) = SUBSTRING('" + trDate + "', 9, 2) " +
                            "AND SUBSTRING(pur01h02.po_code, 7, 2) = SUBSTRING('" + trDate + "', 4, 2) ", con);
                        sdr = cmd.ExecuteReader();
                        if (sdr.HasRows == false)
                        {
                            //throw new Exception();
                            run = "PO01" + dtp_po.SelectedDate.Value.Year + dtp_po.SelectedDate.Value.Month + "0001";
                        }
                        else if (sdr.Read())
                        {
                            maxNo = Convert.ToInt32(sdr[0].ToString());
                            run = "PO03" + (dtp_po.SelectedDate.Value.Year.ToString()).Substring(dtp_po.SelectedDate.Value.Year.ToString().Length - 2) +
                                ("0000" + dtp_po.SelectedDate.Value.Month).Substring(("0000" + dtp_po.SelectedDate.Value.Month).Length - 2, 2) +
                                ("0000" + maxNo).Substring(("0000" + maxNo).Length - 4, 4);
                        }

                        //txt_po_no.Text = run.ToString();
                        con.Close();
                    }
                    else
                    {
                        run = (userControl.FindControl("txt_po_code") as TextBox).Text;
                    }

                    int tax1Inc;  
                    int tax2Inc;
                    int tax3Inc;

                    if ((userControl.FindControl("chk_ppn_incl") as CheckBox).Checked == true)
                    {
                    if ((userControl.FindControl("cb_tax2") as RadComboBox).Text == "0")
                    {
                        tax1Inc = 1;
                    }
                    else
                    {
                        tax1Inc = 0;

                    }
                        tax2Inc = 0;
                    }
                    else
                    {
                        tax2Inc = 1;
                    }

                    if ((userControl.FindControl("cb_tax3") as RadComboBox).Text == "0")
                    {
                        tax3Inc = 0;
                    }
                    else
                    {
                        tax3Inc = 1;
                    }

                    int t_fsupply = 0;
                    if ((userControl.FindControl("cb_full_supply") as CheckBox).Checked == true)
                    {
                        t_fsupply = 1;
                    }
                    else
                    {
                        t_fsupply = 0;
                    }
                    int t_monitor_order = 0;
                    if ((userControl.FindControl("cb_monitor_order") as CheckBox).Checked == true)
                    {
                        t_monitor_order = 1;
                    }
                    else
                    {
                        t_monitor_order = 0;
                    }

                    con.Open();
                    cmd = new SqlCommand();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Connection = con;
                    cmd.CommandText = "sp_save_poH";
                    cmd.Parameters.AddWithValue("@po_code", run);
                    cmd.Parameters.AddWithValue("@Po_date", string.Format("{0:yyyy-MM-dd}", dtp_po.SelectedDate.Value));
                    cmd.Parameters.AddWithValue("@exp_date", string.Format("{0:yyyy-MM-dd}", (userControl.FindControl("dtp_exp") as RadDatePicker).SelectedDate.Value));
                    cmd.Parameters.AddWithValue("@trans_code", (userControl.FindControl("cb_po_type") as RadComboBox).Text);
                    cmd.Parameters.AddWithValue("@priority_code", (userControl.FindControl("cb_priority") as RadComboBox).Text);
                    cmd.Parameters.AddWithValue("@etd", string.Format("{0:yyyy-MM-dd}", (userControl.FindControl("dtp_etd") as RadDatePicker).SelectedDate.Value));
                    cmd.Parameters.AddWithValue("@ShipModeEtd", (userControl.FindControl("cb_priority") as RadComboBox).SelectedValue);
                    cmd.Parameters.AddWithValue("@kurs", double.Parse((userControl.FindControl("txt_kurs") as TextBox).Text));
                    cmd.Parameters.AddWithValue("@kurs_tax", double.Parse((userControl.FindControl("txt_tax_kurs") as TextBox).Text));
                    cmd.Parameters.AddWithValue("@pay_code", (userControl.FindControl("cb_term") as RadComboBox).SelectedValue);
                    cmd.Parameters.AddWithValue("@JTempo", double.Parse((userControl.FindControl("txt_term_days") as TextBox).Text));
                    cmd.Parameters.AddWithValue("@attname", (userControl.FindControl("txt_term_days") as TextBox).Text);
                    cmd.Parameters.AddWithValue("@FreBy", (userControl.FindControl("cb_prepared") as RadComboBox).SelectedValue);
                    cmd.Parameters.AddWithValue("@OrdBy", (userControl.FindControl("cb_verified") as RadComboBox).SelectedValue);
                    cmd.Parameters.AddWithValue("@AppBy", (userControl.FindControl("cb_approved") as RadComboBox).SelectedValue);
                    cmd.Parameters.AddWithValue("@remark", (userControl.FindControl("txt_remark") as TextBox).Text);
                    cmd.Parameters.AddWithValue("@vendor_code", (userControl.FindControl("cb_supplier") as RadComboBox).SelectedValue);
                    cmd.Parameters.AddWithValue("@vendor_name", (userControl.FindControl("cb_supplier") as RadComboBox).Text);
                    cmd.Parameters.AddWithValue("@tot_amount", double.Parse((userControl.FindControl("txt_remark") as TextBox).Text));
                    cmd.Parameters.AddWithValue("@cur_code", (userControl.FindControl("cb_priority") as RadComboBox).Text);
                    cmd.Parameters.AddWithValue("@userid", (userControl.FindControl("txt_uid") as TextBox).Text);

                    //cmd.Parameters.AddWithValue("@PPNIncl", tax1Inc);
                    cmd.Parameters.AddWithValue("@ppn", (userControl.FindControl("cb_tax1") as RadComboBox).SelectedValue);
                    cmd.Parameters.AddWithValue("@PPPN", double.Parse((userControl.FindControl("txt_pppn") as TextBox).Text));
                    cmd.Parameters.AddWithValue("@JPPN", double.Parse((userControl.FindControl("txt_tax1_value") as TextBox).Text));

                    cmd.Parameters.AddWithValue("@OTaxIncl", tax2Inc);
                    cmd.Parameters.AddWithValue("@OTax", (userControl.FindControl("cb_tax2") as RadComboBox).SelectedValue);
                    cmd.Parameters.AddWithValue("@poTax", double.Parse((userControl.FindControl("txt_po_tax") as TextBox).Text));
                    cmd.Parameters.AddWithValue("@JOTax", double.Parse((userControl.FindControl("txt_tax2_value") as TextBox).Text));

                    cmd.Parameters.AddWithValue("@pphIncl", tax3Inc);
                    cmd.Parameters.AddWithValue("@pph", (userControl.FindControl("cb_tax3") as RadComboBox).SelectedValue);
                    cmd.Parameters.AddWithValue("@ppph", double.Parse((userControl.FindControl("txt_ppph") as TextBox).Text));
                    cmd.Parameters.AddWithValue("@Jpph", double.Parse((userControl.FindControl("txt_tax3_value") as TextBox).Text));

                    cmd.Parameters.AddWithValue("@Net", double.Parse((userControl.FindControl("txt_sub_total") as TextBox).Text));
                    cmd.Parameters.AddWithValue("@Freight", 0);
                    cmd.Parameters.AddWithValue("@Othercost", double.Parse((userControl.FindControl("txt_other_value") as TextBox).Text));
                    cmd.Parameters.AddWithValue("@Ass", 0);
                    cmd.Parameters.AddWithValue("@DP", 0);
                    cmd.Parameters.AddWithValue("@PlantCode", (userControl.FindControl("cb_project") as RadComboBox).SelectedValue);
                    cmd.Parameters.AddWithValue("@dept_code", (userControl.FindControl("cb_cost_center") as RadComboBox).SelectedValue);
                    if ((userControl.FindControl("txt_reff_no") as TextBox).Text != string.Empty)
                    {
                        cmd.Parameters.AddWithValue("@no_ref", (userControl.FindControl("txt_reff_no") as TextBox).Text);
                        cmd.Parameters.AddWithValue("@ref_date", Convert.ToDateTime((userControl.FindControl("txt_reff_date") as TextBox).Text));
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@no_ref", DBNull.Value);
                        cmd.Parameters.AddWithValue("@ref_date", DBNull.Value);
                    }

                    cmd.Parameters.AddWithValue("@Owner", (userControl.FindControl("txt_owner") as TextBox).Text);
                    cmd.Parameters.AddWithValue("@OwnStamp", string.Format("{0:yyyy-MM-dd}", DateTime.Now));
                    cmd.Parameters.AddWithValue("@doc_type", "1");
                    cmd.Parameters.AddWithValue("@tFullSupply", t_fsupply);
                    cmd.Parameters.AddWithValue("@tMonOrder", t_monitor_order);
                    cmd.Parameters.AddWithValue("@doc_status", (userControl.FindControl("cb_priority") as RadComboBox).Text);
                    cmd.Parameters.AddWithValue("@share_date", string.Format("{0:yyyy-MM-dd}", (userControl.FindControl("dtp_share_date") as RadDatePicker).SelectedDate.Value));
                    cmd.Parameters.AddWithValue("@deliv_address", "");
                    cmd.Parameters.AddWithValue("@valid_period", double.Parse((userControl.FindControl("txt_validity") as TextBox).Text));
                    cmd.Parameters.AddWithValue("@Lvl", public_str.level);
                    cmd.ExecuteNonQuery();


                    ////======= INSERT DETAIL =====================
                    //cmd = new SqlCommand("sp_save_poD", con);
                    //cmd.CommandType = CommandType.StoredProcedure;

                    //cmd.Parameters.Add(new SqlParameter("@po_code", SqlDbType.NVarChar));
                    //cmd.Parameters.Add(new SqlParameter("@prod_type", SqlDbType.NVarChar));
                    //cmd.Parameters.Add(new SqlParameter("@Prod_code", SqlDbType.NVarChar));
                    //cmd.Parameters.Add(new SqlParameter("@qty", SqlDbType.Decimal));
                    //cmd.Parameters.Add(new SqlParameter("@SatQty", SqlDbType.NVarChar));
                    //cmd.Parameters.Add(new SqlParameter("@harga2", SqlDbType.Money));
                    //cmd.Parameters.Add(new SqlParameter("@Disc", SqlDbType.Decimal));
                    //cmd.Parameters.Add(new SqlParameter("@tTax", SqlDbType.Int));
                    //cmd.Parameters.Add(new SqlParameter("@tOTax", SqlDbType.Int));
                    //cmd.Parameters.Add(new SqlParameter("@tpph", SqlDbType.Int));
                    //cmd.Parameters.Add(new SqlParameter("@nomer", SqlDbType.Int));
                    //cmd.Parameters.Add(new SqlParameter("@Jdisc", SqlDbType.Money));
                    //cmd.Parameters.Add(new SqlParameter("@jumlah", SqlDbType.Money));
                    //cmd.Parameters.Add(new SqlParameter("@Spec", SqlDbType.NVarChar));
                    //cmd.Parameters.Add(new SqlParameter("@Hpokok", SqlDbType.Money));
                    //cmd.Parameters.Add(new SqlParameter("@jumlah2", SqlDbType.Money));
                    //cmd.Parameters.Add(new SqlParameter("@harga", SqlDbType.Money));
                    //cmd.Parameters.Add(new SqlParameter("@NoContr", SqlDbType.NVarChar));
                    //cmd.Parameters.Add(new SqlParameter("@prod_code_ori", SqlDbType.NVarChar));
                    //cmd.Parameters.Add(new SqlParameter("@dept_code", SqlDbType.NVarChar));
                    //cmd.Parameters.Add(new SqlParameter("@jTax1", SqlDbType.Money));
                    //cmd.Parameters.Add(new SqlParameter("@jTax2", SqlDbType.Money));
                    //cmd.Parameters.Add(new SqlParameter("@jTax3", SqlDbType.Money));
                    //cmd.Parameters.Add(new SqlParameter("@factor", SqlDbType.Money));
                    //cmd.Parameters.Add(new SqlParameter("@Asscost", SqlDbType.Money));


                    //foreach (GridViewRowInfo row in (userControl.FindControl("RadGrid2") as RadGrid).Rows)
                    //{
                    //    cmd.Parameters["@po_code"].Value = run;
                    //    cmd.Parameters["@prod_type"].Value = row.Cells["prod_type"].Value;
                    //    cmd.Parameters["@Prod_code"].Value = row.Cells["MaterialCode"].Value;
                    //    cmd.Parameters["@qty"].Value = row.Cells["QOrder"].Value;
                    //    cmd.Parameters["@SatQty"].Value = row.Cells["UOM"].Value;
                    //    cmd.Parameters["@harga2"].Value = row.Cells["Price"].Value;
                    //    cmd.Parameters["@Disc"].Value = row.Cells["Disc"].Value;
                    //    if (row.Cells["tTax"].Value != null)
                    //    {
                    //        cmd.Parameters["@tTax"].Value = row.Cells["tTax"].Value;
                    //    }
                    //    else
                    //    {
                    //        cmd.Parameters["@tTax"].Value = 0;
                    //    }
                    //    if (row.Cells["tOTax"].Value != null)
                    //    {
                    //        cmd.Parameters["@tOTax"].Value = row.Cells["tOTax"].Value;
                    //    }
                    //    else
                    //    {
                    //        cmd.Parameters["@tOTax"].Value = 0;
                    //    }
                    //    if (row.Cells["tpph"].Value != null)
                    //    {
                    //        cmd.Parameters["@tpph"].Value = row.Cells["tpph"].Value;
                    //    }
                    //    else
                    //    {
                    //        cmd.Parameters["@tpph"].Value = 0;
                    //    }
                    //    cmd.Parameters["@nomer"].Value = row.Cells["nomor"].Value;
                    //    cmd.Parameters["@Jdisc"].Value = row.Cells["Disc"].Value; //?
                    //    cmd.Parameters["@jumlah"].Value = row.Cells["SubPrice"].Value;
                    //    cmd.Parameters["@Spec"].Value = row.Cells["Description"].Value;
                    //    cmd.Parameters["@Hpokok"].Value = row.Cells["Price"].Value;
                    //    cmd.Parameters["@jumlah2"].Value = row.Cells["SubPrice"].Value;
                    //    cmd.Parameters["@harga"].Value = row.Cells["Price"].Value;
                    //    if (row.Cells["no_ref"].Value != null)
                    //    {
                    //        cmd.Parameters["@NoContr"].Value = row.Cells["no_ref"].Value;
                    //    }
                    //    else
                    //    {
                    //        cmd.Parameters["@NoContr"].Value = DBNull.Value;
                    //    }

                    //    cmd.Parameters["@prod_code_ori"].Value = row.Cells["OriginalMaterial"].Value;
                    //    cmd.Parameters["@dept_code"].Value = row.Cells["dept_code"].Value;
                    //    cmd.Parameters["@jTax1"].Value = row.Cells["jTax1"].Value;
                    //    cmd.Parameters["@jTax2"].Value = row.Cells["jTax2"].Value;
                    //    cmd.Parameters["@jTax3"].Value = row.Cells["jTax3"].Value;
                    //    cmd.Parameters["@factor"].Value = row.Cells["Factor"].Value;
                    //    cmd.Parameters["@Asscost"].Value = 0;

                    //    cmd.ExecuteNonQuery();
                    //}

                    //cmd = new SqlCommand("delete pur01d02 where tDel = '0' and po_code = '" + txt_po_no.Text + "'", con);
                    //cmd.CommandType = CommandType.Text;
                    //cmd.ExecuteNonQuery();

                    //cmd = new SqlCommand("update pur01d02 set tDel = '0' where po_code = '" + txt_po_no.Text + "'", con);
                    //cmd.CommandType = CommandType.Text;
                    //cmd.ExecuteNonQuery();

                    con.Close();
                    (userControl.FindControl("txt_po_no") as TextBox).Text = run;
                    (userControl.FindControl("txt_edited") as TextBox).Text = "0";
                    (userControl.FindControl("txt_lastUpdate") as TextBox).Text = string.Format("{0:yyyy/MM/dd}", DateTime.Now);
                    (userControl.FindControl("txt_printed") as TextBox).Text = "0";
                    //RadMessageBox.Show("Records Saved sucessfully");
                    //ses_detail();
                    Label lblsuccess = new Label();
                    lblsuccess.Text = "Data saved successfully";
                    lblsuccess.ForeColor = System.Drawing.Color.Blue;
                    RadGrid1.Controls.Add(lblsuccess);
                }
            }
            catch (Exception ex)
            {
                con.Close();
                Label lblError = new Label();
                lblError.Text = "Unable to save data. Reason: " + ex.Message;
                lblError.ForeColor = System.Drawing.Color.Red;
                RadGrid1.Controls.Add(lblError);
                e.Canceled = true;
            }
        }

        //protected void RadGrid1_InsertCommand(object source, GridCommandEventArgs e)
        //{
        //    UserControl userControl = (UserControl)e.Item.FindControl(GridEditFormItem.EditFormUserControlID);

        //    //Create new row in the DataSource
        //    DataRow newRow = this.Purchase_H.NewRow();

        //    //Insert new values
        //    Hashtable newValues = new Hashtable();

        //    newValues["Country"] = (userControl.FindControl("TextBox7") as TextBox).Text;
        //    newValues["City"] = (userControl.FindControl("TextBox8") as TextBox).Text;
        //    newValues["Region"] = (userControl.FindControl("TextBox9") as TextBox).Text;
        //    newValues["HomePhone"] = (userControl.FindControl("HomePhoneBox") as RadMaskedTextBox).Text;
        //    newValues["BirthDate"] = (userControl.FindControl("BirthDatePicker") as RadDatePicker).SelectedDate.ToString();
        //    newValues["TitleOfCourtesy"] = (userControl.FindControl("ddlTOC") as DropDownList).SelectedItem.Value;

        //    newValues["Notes"] = (userControl.FindControl("TextBox1") as TextBox).Text;
        //    newValues["Address"] = (userControl.FindControl("TextBox6") as TextBox).Text;
        //    newValues["FirstName"] = (userControl.FindControl("TextBox2") as TextBox).Text;
        //    newValues["LastName"] = (userControl.FindControl("TextBox3") as TextBox).Text;
        //    newValues["HireDate"] = (userControl.FindControl("HireDatePicker") as RadDatePicker).SelectedDate.ToString();
        //    newValues["Title"] = (userControl.FindControl("TextBox4") as TextBox).Text;

        //    //make sure that unique primary key value is generated for the inserted row 
        //    newValues["po_code"] = (int)this.Purchase_H.Rows[this.Purchase_H.Rows.Count - 1]["po_code"] + 1;
        //    try
        //    {
        //        foreach (DictionaryEntry entry in newValues)
        //        {
        //            newRow[(string)entry.Key] = entry.Value;
        //        }
        //        this.Purchase_H.Rows.Add(newRow);
        //        this.Purchase_H.AcceptChanges();
        //    }
        //    catch (Exception ex)
        //    {
        //        Label lblError = new Label();
        //        lblError.Text = "Unable to insert data. Reason: " + ex.Message;
        //        lblError.ForeColor = System.Drawing.Color.Red;
        //        RadGrid1.Controls.Add(lblError);

        //        e.Canceled = true;
        //    }
        //}

        protected void RadGrid1_DeleteCommand(object source, GridCommandEventArgs e)
        {

        }

        protected void ColumnClick(object source, GridViewEditEventArgs e)
        {
            UserControl UControl = (UserControl)Page.FindControl("po_std_data_entry.ascx");
        }
        private static DataTable GetProject_prm(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT region_code, region_name FROM inv00h09 WHERE stEdit != 4 AND region_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_projectPrm_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetProject_prm(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                cb_project_prm.Items.Add(new RadComboBoxItem(data.Rows[i]["region_name"].ToString(), data.Rows[i]["region_name"].ToString()));
            }
        }
        protected void cb_projectPrm_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT region_code FROM inv00h09 WHERE region_name = '" + cb_project_prm.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_project_prm.SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();

            //get_po(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), cb_project_prm.SelectedValue);

        }
        #region Purchase Type

        private static DataTable GetTrans(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT TransName, trans_code FROM pur00h05 WHERE stEdit <> '4' AND TransName LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_po_type_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetTrans(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                cb_po_type.Items.Add(new RadComboBoxItem(data.Rows[i]["TransName"].ToString(), data.Rows[i]["TransName"].ToString()));
            }

            e.Message = GetStatusMessage(endOffset, data.Rows.Count);
        }

        protected void cb_po_type_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT trans_code FROM pur00h05 WHERE TransName = '" + cb_po_type.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_po_type.SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }
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
                cb_priority.Items.Add(new RadComboBoxItem(data.Rows[i]["prio_desc"].ToString(), data.Rows[i]["prio_desc"].ToString()));
            }

            e.Message = GetStatusMessage(endOffset, data.Rows.Count);
        }

        protected void cb_priority_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT priority_code FROM pur00h06 WHERE prio_desc = '" + cb_priority.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_priority.SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }
        #endregion

        #region Ship Mode
        private static DataTable GetShipMode(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT ShipMode, ShipModeName FROM pur00h04 WHERE ShipModeName LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_ship_mode_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetShipMode(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                cb_ship_mode.Items.Add(new RadComboBoxItem(data.Rows[i]["ShipModeName"].ToString(), data.Rows[i]["ShipModeName"].ToString()));
            }

            e.Message = GetStatusMessage(endOffset, data.Rows.Count);
        }
        protected void cb_ship_mode_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT ShipMode FROM pur00h04 WHERE ShipModeName = '" + cb_ship_mode.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_ship_mode.SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }
        #endregion

        #region Supplier
        private static DataTable GetSupplier(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT supplier_code, supplier_name FROM pur00h01 WHERE stEdit != 4 AND supplier_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_supplier_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetSupplier(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                cb_supplier.Items.Add(new RadComboBoxItem(data.Rows[i]["supplier_name"].ToString(), data.Rows[i]["supplier_name"].ToString()));
            }

            e.Message = GetStatusMessage(endOffset, data.Rows.Count);
        }
        protected void cb_supplier_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT     a.supplier_code,e.KursRun, e.KursTax, a.cur_code, b.TAX_NAME as ppn, c.TAX_NAME AS Otax, d.TAX_NAME AS pph " +
                               " FROM pur00h01 a LEFT OUTER JOIN acc00h05 AS b ON b.TAX_CODE = a.ppn LEFT OUTER JOIN acc00h05 AS c ON a.OTax = c.TAX_CODE LEFT OUTER JOIN " +
                               " acc00h05 AS d ON a.pph = d.TAX_CODE inner join acc00h04 e on a.cur_code = e.cur_code WHERE (e.tglKurs = (SELECT     MAX(tglKurs) AS Expr1 " +
                               " FROM acc00h04)) and a.supplier_name = '" + cb_supplier.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                //(sender as RadComboBox).Text = dr["doc_code"].ToString();
                cb_supplier.SelectedValue = dr["supplier_code"].ToString();
                txt_curr.Text = dr["cur_code"].ToString();
                txt_kurs.Text = dr["KursRun"].ToString();
                txt_tax_kurs.Text = dr["KursTax"].ToString();
                cb_tax1.SelectedValue = dr["ppn"].ToString();
                cb_tax2.SelectedValue = dr["Otax"].ToString();
                cb_tax3.SelectedValue = dr["pph"].ToString();
            }
                
            dr.Close();
            con.Close();

            get_supp_info(cb_supplier.SelectedValue);
        }

        private void get_supp_info1(string supp_code)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT cur_code, JTempo, case pur00h01.pay_code when '01' then 'Cash' when '02' then 'Credit' Else 'COD' end as pay_name  FROM pur00h01 WHERE supplier_code = '" + supp_code + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            //while (dr.Read())            
            txt_curr.Text = dr["cur_code"].ToString();
            cb_term.Text = dr["pay_name"].ToString();
            txt_term_days.Text = dr["JTempo"].ToString();
            dr.Close();
            con.Close();
        }

        protected void get_supp_info(string supp_code)
        {
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);

            //SqlDataAdapter adapter = new SqlDataAdapter("SELECT cur_code, JTempo, case pur00h01.pay_code when '01' then 'Cash' when '02' then 'Credit' Else 'COD' end as pay_name  FROM pur00h01 WHERE supplier_code = @supplier_code", con);
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT pur00h01.supplier_name, pur00h01.supplier_code, pur00h01.KoGSup, pur00h01.contact1, pur00h01.contact2, ISNULL(acc00h05.TAX_NAME,'NON') AS tax1, " +
            "ISNULL(acc00h05_1.TAX_NAME, 'NON') AS tax2, ISNULL(acc00h05_2.TAX_NAME, 'NON') AS tax3, pur00h01.cur_code, pur00h01.pay_code, " +
            "CASE pur00h01.pay_code WHEN '01' THEN 'Cash' WHEN '02' THEN 'Credit' ELSE 'COD' END AS pay_term, pur00h01.JTempo, acc00h04.KursRun, " +
            "acc00h04.KursTax, pur00h01.ppn AS tax1_code, pur00h01.OTax AS tax2_code, pur00h01.pph AS tax3_code, " +
            "ISNULL(acc00h05.TAX_PERC, 0) AS p_tax1, ISNULL(acc00h05_1.TAX_PERC, 0) AS p_tax2, ISNULL(acc00h05_2.TAX_PERC, 0) AS p_tax3 " +
            "FROM pur00h01 LEFT OUTER JOIN acc00h05 ON pur00h01.ppn = acc00h05.TAX_CODE LEFT OUTER JOIN acc00h05 AS acc00h05_1 ON pur00h01.OTax = acc00h05_1.TAX_CODE LEFT OUTER JOIN " +
            "acc00h05 AS acc00h05_2 ON pur00h01.pph = acc00h05_2.TAX_CODE LEFT OUTER JOIN acc00h04 ON pur00h01.cur_code = acc00h04.cur_code " +
            "WHERE(pur00h01.stEdit <> 4) AND(acc00h04.tglKurs = (SELECT MAX(tglKurs) AS Expr1 FROM acc00h04 AS acc00h04_1)) AND pur00h01.supplier_code = @supplier_code", con);
            adapter.SelectCommand.Parameters.AddWithValue("@supplier_code", supp_code);

            DataTable dt = new DataTable();
            adapter.Fill(dt);
            foreach (DataRow dr in dt.Rows)
            {
                txt_curr.Text = dr["cur_code"].ToString();
                txt_kurs.Text = string.Format("{0:#,###0.00;-#,###0.00;0}", dr["KursRun"].ToString());
                txt_tax_kurs.Text = string.Format("{0:#,###0.00;-#,###0.00;0}", dr["KursTax"].ToString());
                cb_tax1.Text = dr["tax1"].ToString();
                txt_pppn.Text = dr["p_tax1"].ToString();
                cb_tax2.Text = dr["tax2"].ToString();
                txt_po_tax.Text = dr["p_tax2"].ToString();
                cb_tax3.Text = dr["tax3"].ToString();
                txt_ppph.Text = dr["p_tax3"].ToString();
                cb_term.Text = dr["pay_term"].ToString();
                txt_term_days.Text = dr["JTempo"].ToString();
                txt_att_name.Text = dr["contact1"].ToString();
            }

        }
        #endregion

        #region TAX
        private static DataTable GetTax(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT TAX_NAME FROM acc00h05 WHERE stEdit != 4 AND TAX_NAME LIKE @text + '%' UNION SELECT 'NON'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_tax1_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetTax(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                cb_tax1.Items.Add(new RadComboBoxItem(data.Rows[i]["TAX_NAME"].ToString(), data.Rows[i]["TAX_NAME"].ToString()));
            }

            e.Message = GetStatusMessage(endOffset, data.Rows.Count);

            //get_tax_perc(cb_tax1.SelectedValue);
        }
        private void get_tax_perc(string tax_code, RadNumericTextBox text_box)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT TAX_PERC FROM  acc00h05 WHERE TAX_CODE = '" + tax_code + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                text_box.Text = dr["TAX_PERC"].ToString();
            dr.Close();
            con.Close();
        }
        protected void cb_tax1_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT TAX_CODE,TAX_PERC FROM  acc00h05 WHERE TAX_NAME = '" + cb_tax1.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_tax1.SelectedValue = dr["TAX_CODE"].ToString();
            //txt_pppn.Text = dr["TAX_PERC"].ToString();
            dr.Close();
            con.Close();

            get_tax_perc(cb_tax1.SelectedValue, txt_pppn);
        }
        protected void cb_tax2_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetTax(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                cb_tax2.Items.Add(new RadComboBoxItem(data.Rows[i]["TAX_NAME"].ToString(), data.Rows[i]["TAX_NAME"].ToString()));
            }

            e.Message = GetStatusMessage(endOffset, data.Rows.Count);
        }
        protected void cb_tax2_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT TAX_CODE,TAX_PERC FROM acc00h05 WHERE TAX_NAME = '" + cb_tax2.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_tax2.SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();

            get_tax_perc(cb_tax2.SelectedValue, txt_po_tax);
        }
        protected void cb_tax3_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetTax(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                cb_tax3.Items.Add(new RadComboBoxItem(data.Rows[i]["TAX_NAME"].ToString(), data.Rows[i]["TAX_NAME"].ToString()));
            }

            e.Message = GetStatusMessage(endOffset, data.Rows.Count);
        }
        protected void cb_tax3_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT TAX_CODE,TAX_PERC FROM acc00h05 WHERE TAX_NAME = '" + cb_tax3.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_tax3.SelectedValue = dr[0].ToString();
            //txt_ppph.Text = dr["TAX_PERC"].ToString();
            dr.Close();
            con.Close();

            get_tax_perc(cb_tax3.SelectedValue, txt_ppph);
        }
        #endregion

        #region Project
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
                cb_project.Items.Add(new RadComboBoxItem(data.Rows[i]["region_name"].ToString(), data.Rows[i]["region_name"].ToString()));
            }
        }
        protected void cb_project_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT region_code FROM inv00h09 WHERE region_name = '" + cb_project.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_project.SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();

            cb_reff.Text = "";
            LoadReff(e.Value);
            cb_prepared.Text = "";
            LoadManPower(e.Value, cb_prepared);
            cb_verified.Text = "";
            LoadManPower(e.Value, cb_verified);
            cb_approved.Text = "";
            LoadManPower(e.Value, cb_approved);

        }
        protected void LoadProjects()
        {
            SqlConnection connection = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);

            SqlDataAdapter adapter = new SqlDataAdapter("SELECT region_code, region_name FROM inv00h09 WHERE stEdit != 4 ORDER By region_name", connection);
            DataTable dt = new DataTable();
            adapter.Fill(dt);

            cb_project.DataTextField = "region_name";
            cb_project.DataValueField = "region_code";
            cb_project.DataSource = dt;
            cb_project.DataBind();
        }
        #endregion

        #region PO_Refference
        private static DataTable GetReff(string po_code, string project)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT pr_code, Pr_date, remark FROM v_purchase_request WHERE region_code = region_code " +
                "AND pr_code LIKE @text + '%' ORDER BY pr_code",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", po_code);
            adapter.SelectCommand.Parameters.AddWithValue("@region_code", project);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_reff_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetReff(e.Text, cb_project.SelectedValue);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                cb_reff.Items.Add(new RadComboBoxItem(data.Rows[i]["pr_code"].ToString(), data.Rows[i]["pr_code"].ToString()));
            }

            e.Message = GetStatusMessage(endOffset, data.Rows.Count);
        }
        protected void cb_reff_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select * from v_purchase_request where pr_code = '" + cb_reff.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_reff.SelectedValue = dr["pr_code"].ToString();
            dr.Close();
            con.Close();

            LoadReffInfo(cb_reff.SelectedValue);
            //addPoDet(cb_reff.SelectedValue);
        }

        protected void LoadReffInfo(string code)
        {
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);

            SqlDataAdapter adapter = new SqlDataAdapter("SELECT CostCenterName,dept_code, Pr_date, remark FROM v_purchase_request WHERE pr_code = @pr_code", con);
            adapter.SelectCommand.Parameters.AddWithValue("@pr_code", code);

            DataTable dt = new DataTable();
            adapter.Fill(dt);
            foreach (DataRow dr in dt.Rows)
            {
                //txt_Po_date.Text = string.Format("{0:dd/MM/yyyy}", dr["Po_date"].ToString());
                txt_remark.Text = dr["remark"].ToString();
                cb_cost_center.Text = dr["dept_code"].ToString();
            }
        }
        protected void LoadReff(string projectID)
        {
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);

            SqlDataAdapter adapter = new SqlDataAdapter("SELECT pr_code, Pr_date, remark FROM v_purchase_request WHERE region_code = @project", con);
            adapter.SelectCommand.Parameters.AddWithValue("@project", projectID);

            DataTable dt = new DataTable();
            adapter.Fill(dt);

            cb_reff.DataTextField = "pr_code";
            cb_reff.DataValueField = "pr_code";
            cb_reff.DataSource = dt;
            cb_reff.DataBind();
        }

        protected void cb_reff_ItemDataBound(object sender, RadComboBoxItemEventArgs e)
        {
            e.Item.Text = ((DataRowView)e.Item.DataItem)["pr_code"].ToString();
            e.Item.Value = ((DataRowView)e.Item.DataItem)["pr_code"].ToString();
        }

        protected void cb_reff_DataBound(object sender, EventArgs e)
        {
            //set the initial footer label
            ((Literal)cb_reff.Footer.FindControl("RadComboItemsCount")).Text = Convert.ToString(cb_reff.Items.Count);
        }
        #endregion

        #region Approval Man Power

        protected void LoadManPower(string projectID, RadComboBox cb)
        {
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);

            SqlDataAdapter adapter = new SqlDataAdapter("SELECT upper(name) as name, nik, upper(jabatan) as jabatan FROM inv00h26 " +
                "WHERE stedit <> '4' AND region_code = @project", con);
            adapter.SelectCommand.Parameters.AddWithValue("@project", projectID);

            DataTable dt = new DataTable();
            adapter.Fill(dt);

            cb.DataTextField = "name";
            cb.DataValueField = "nik";
            cb.DataSource = dt;
            cb.DataBind();
        }
        private static DataTable GetManPower(string name, string project)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT upper(name) as name, nik, upper(jabatan) as jabatan " +
                "FROM inv00h26 WHERE stedit <> '4' AND region_code = @project AND name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", name);
            adapter.SelectCommand.Parameters.AddWithValue("@project", project);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_prepared_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetManPower(e.Text, cb_project.SelectedValue);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                cb_prepared.Items.Add(new RadComboBoxItem(data.Rows[i]["Name"].ToString(), data.Rows[i]["Name"].ToString()));
            }
        }
        protected void cb_prepared_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + cb_prepared.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_prepared.SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }
        protected void cb_prepared_DataBound(object sender, EventArgs e)
        {
            ((Literal)cb_prepared.Footer.FindControl("RadComboItemsCount")).Text = Convert.ToString(cb_prepared.Items.Count);
        }

        protected void cb_verified_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetManPower(e.Text, cb_project.SelectedValue);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                cb_verified.Items.Add(new RadComboBoxItem(data.Rows[i]["Name"].ToString(), data.Rows[i]["Name"].ToString()));
            }
        }
        protected void cb_verified_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + cb_verified.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_verified.SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }
        protected void cb_verified_DataBound(object sender, EventArgs e)
        {
            ((Literal)cb_verified.Footer.FindControl("RadComboItemsCount")).Text = Convert.ToString(cb_verified.Items.Count);
        }
        protected void cb_approved_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetManPower(e.Text, cb_project.SelectedValue);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                cb_approved.Items.Add(new RadComboBoxItem(data.Rows[i]["Name"].ToString(), data.Rows[i]["jabatan"].ToString()));
            }
        }
        protected void cb_approved_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + cb_approved.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_approved.SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }
        #endregion

        #region Doc. Status 

        private void get_doc_status(string obj_value)
        {
            if (obj_value == "OPEN")
            {
                cb_po_status.SelectedValue = "0";
            }
            else if (obj_value == "SHARED")
            {
                cb_po_status.SelectedValue = "1";
            }
            else if (obj_value == "HOLD")
            {
                cb_po_status.SelectedValue = "2";
            }
            else
            {
                cb_po_status.SelectedValue = "3";
            }
        }
        protected void cb_po_status_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            get_doc_status(cb_po_status.Text);
        }

        protected void cb_po_status_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            cb_po_status.Items.Add("OPEN");
            cb_po_status.Items.Add("SHARED");
            cb_po_status.Items.Add("HOLD");
        }
        #endregion

        ////protected void chk_lock_detail_CheckedChanged(object sender, EventArgs e)
        ////{
        ////    if (chk_lock_detail.Checked)
        ////    {
        ////        RadGrid2.Enabled = false;
        ////    }
        ////}
        protected void btnNew_Click(object sender, ImageClickEventArgs e)
        {
            Session["action"] = "new";
            btnSave.Enabled = true;
            btnSave.ImageUrl = "~/Images/simpan.png";
            //RadGrid2.Enabled = false;
            btnPrint.Enabled = false;
            btnPrint.ImageUrl = "~/Images/cetak-gray.png";
            RadGrid2.DataSource = new string[] { };
            RadGrid2.DataBind();
            if (Session["action"].ToString() != "firstLoad")
            {
                clear_text(Page.Controls);
            }
            set_info();
            teks_default();
            cb_po_type.Text = "Inventory";
            cb_po_type.SelectedValue = "INV";
            cb_priority.Text = "Hight/Urgent";
            cb_priority.SelectedValue = "1";
            cb_project.SelectedValue = public_str.site;
            cb_project.Text = public_str.sitename;
            dtp_exp.SelectedDate = dtp_po.SelectedDate;
        }

        private void set_info()
        {
            txt_uid.Text = public_str.uid;
            txt_lastUpdate.Text = string.Format("{0:dd/MM/yyyy hh:mm:ss}", DateTime.Today);
            txt_owner.Text = public_str.uid;
            txt_printed.Text = "0";
            txt_edited.Text = "0";
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

        private void teks_default()
        {
            txt_uid.Text = "User: ";
            txt_lastUpdate.Text = "Last Update: ";
            txt_owner.Text = "Owner:";
            txt_printed.Text = "Printed: ";
            txt_edited.Text = "Edited: ";

        }

        private void teks_clear()
        {
            txt_uid.Text = "";
            txt_lastUpdate.Text = "";
            txt_owner.Text = "";
            txt_printed.Text = "";
            txt_edited.Text = "";

        }

        protected void btnSave_Click(object sender, ImageClickEventArgs e)
        {
            long maxNo;
            string run = null;
            string trDate = string.Format("{0:dd/MM/yyyy}", dtp_po.SelectedDate);

            try
            {
                if (Session["action"].ToString() == "edit")
                {
                    run = txt_po_code.Text;
                }
                else
                {
                    con.Open();
                    SqlDataReader sdr;
                    cmd = new SqlCommand("SELECT ISNULL ( MAX ( RIGHT ( pur01h01.po_code , 4 ) ) , 0 ) + 1 AS maxNo " +
                        "FROM pur01h01 WHERE LEFT(pur01h01.po_code, 4) = 'PR01' " +
                        "AND SUBSTRING(pur01h01.po_code, 5, 2) = SUBSTRING('" + trDate + "', 9, 2) " +
                        "AND SUBSTRING(pur01h01.po_code, 7, 2) = SUBSTRING('" + trDate + "', 4, 2) ", con);
                    sdr = cmd.ExecuteReader();
                    if (sdr.HasRows == false)
                    {
                        //throw new Exception();
                        run = "PR01" + dtp_po.SelectedDate.Value.Year + dtp_po.SelectedDate.Value.Month + "0001";
                    }
                    else if (sdr.Read())
                    {
                        maxNo = Convert.ToInt32(sdr[0].ToString());
                        run = "PR01" + (dtp_po.SelectedDate.Value.Year.ToString()).Substring(dtp_po.SelectedDate.Value.Year.ToString().Length - 2) +
                            ("0000" + dtp_po.SelectedDate.Value.Month).Substring(("0000" + dtp_po.SelectedDate.Value.Month).Length - 2, 2) +
                            ("0000" + maxNo).Substring(("0000" + maxNo).Length - 4, 4);
                    }
                    con.Close();
                }


                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_save_poH";
                cmd.Parameters.AddWithValue("@po_code", run);
                cmd.Parameters.AddWithValue("@Po_date", string.Format("{0:yyyy-MM-dd}", dtp_po.SelectedDate.Value));
                cmd.Parameters.AddWithValue("@exp_date", string.Format("{0:yyyy-MM-dd}", dtp_exp.SelectedDate.Value));
                cmd.Parameters.AddWithValue("@trans_code", cb_po_type.SelectedValue);
                cmd.Parameters.AddWithValue("@priority_code", cb_priority.Text);
                cmd.Parameters.AddWithValue("@etd", string.Format("{0:yyyy-MM-dd}", dtp_etd.SelectedDate.Value));
                cmd.Parameters.AddWithValue("@ShipModeEtd", cb_ship_mode.SelectedValue);
                cmd.Parameters.AddWithValue("@ppn", cb_tax1.SelectedValue);
                cmd.Parameters.AddWithValue("@PPNIncl", chk_ppn_incl.Checked);
                cmd.Parameters.AddWithValue("@kurs", txt_kurs.Text);
                cmd.Parameters.AddWithValue("@kurs_tax", txt_tax_kurs.Text);
                cmd.Parameters.AddWithValue("@pay_code", cb_term.SelectedValue);
                cmd.Parameters.AddWithValue("@JTempo", txt_term_days.Text);
                cmd.Parameters.AddWithValue("@attname", txt_term_days.Text);
                cmd.Parameters.AddWithValue("@remark", txt_remark.Text);
                cmd.Parameters.AddWithValue("@FreBy", cb_prepared.SelectedValue);
                cmd.Parameters.AddWithValue("@OrdBy", cb_verified.SelectedValue);
                cmd.Parameters.AddWithValue("@AppBy", cb_approved.SelectedValue);
                cmd.Parameters.AddWithValue("@vendor_code", cb_supplier.SelectedValue);
                cmd.Parameters.AddWithValue("@vendor_name", cb_supplier.SelectedValue);
                cmd.Parameters.AddWithValue("@cur_code", txt_curr.Text);
                cmd.Parameters.AddWithValue("@tot_amount", txt_remark.Text);
                cmd.Parameters.AddWithValue("@PPPN", txt_pppn.Text);
                cmd.Parameters.AddWithValue("@userid", public_str.user_id);
                cmd.Parameters.AddWithValue("@JPPN", txt_tax1_value.Text);
                cmd.Parameters.AddWithValue("@OTaxIncl", cb_tax1.SelectedValue);
                cmd.Parameters.AddWithValue("@JOTax", txt_tax2_value.Text);
                cmd.Parameters.AddWithValue("@Net", txt_sub_total.Text);
                cmd.Parameters.AddWithValue("@Freight", 0);
                cmd.Parameters.AddWithValue("@Othercost", txt_other_value.Text);
                cmd.Parameters.AddWithValue("@Ass", 0);
                cmd.Parameters.AddWithValue("@DP", 0);
                cmd.Parameters.AddWithValue("@OTax", cb_tax2.SelectedValue);
                cmd.Parameters.AddWithValue("@PlantCode", cb_project.SelectedValue);
                cmd.Parameters.AddWithValue("@dept_code", cb_cost_center.SelectedValue);
                cmd.Parameters.AddWithValue("@no_ref", cb_reff.SelectedValue);
                cmd.Parameters.AddWithValue("@ref_date", txt_pr_date.Text);
                cmd.Parameters.AddWithValue("@pph", "NON");
                cmd.Parameters.AddWithValue("@pphIncl", cb_tax3.SelectedValue);
                cmd.Parameters.AddWithValue("@Jpph", txt_tax3_value.Text);
                cmd.Parameters.AddWithValue("@Owner", txt_owner.Text);
                cmd.Parameters.AddWithValue("@OwnStamp", string.Format("{0:yyyy-MM-dd}", DateTime.Now));
                cmd.Parameters.AddWithValue("@doc_type", 1);
                cmd.Parameters.AddWithValue("@tFullSupply", 0);
                cmd.Parameters.AddWithValue("@tMonOrder", 0);
                cmd.Parameters.AddWithValue("@doc_status", cb_priority.SelectedValue);
                cmd.Parameters.AddWithValue("@share_date", string.Format("{0:yyyy-MM-dd}", dtp_share_date.SelectedDate.Value));
                //cmd.Parameters.AddWithValue("@deliv_address", "");
                cmd.Parameters.AddWithValue("@valid_period", txt_validity.Text);
                cmd.Parameters.AddWithValue("@ppph", txt_ppph.Text);
                cmd.Parameters.AddWithValue("@poTax", txt_po_tax.Text);

                //cmd.Parameters.AddWithValue("@asset_id", "NON");
                cmd.ExecuteNonQuery();


                // Save Detail
                //cmd = new SqlCommand();
                //cmd.CommandType = CommandType.Text;
                //cmd.Connection = con;
                //cmd.CommandText = "DELETE FROM pur01d01 WHERE po_code = @po_code";
                //cmd.Parameters.AddWithValue("@po_code", run);
                //cmd.ExecuteNonQuery();

                foreach (GridDataItem item in RadGrid2.MasterTableView.Items)
                {
                    cmd = new SqlCommand();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Connection = con;
                    cmd.CommandText = "sp_save_poD";
                    cmd.Parameters.AddWithValue("@prod_type", (item.FindControl("txt_type") as RadTextBox).Text);
                    cmd.Parameters.AddWithValue("@Prod_code", (item.FindControl("cb_prod_code") as RadComboBox).SelectedValue);
                    cmd.Parameters.AddWithValue("@spec", (item.FindControl("txt_prod_name") as RadTextBox).Text);
                    cmd.Parameters.AddWithValue("@qty", Convert.ToDouble((item.FindControl("txt_qty") as RadTextBox).Text));
                    cmd.Parameters.AddWithValue("@SatQty", (item.FindControl("cb_uom_d") as RadComboBox).SelectedValue);
                    cmd.Parameters.AddWithValue("@harga", (item.FindControl("lblHarga") as Label).Text);
                    cmd.Parameters.AddWithValue("@Disc", (item.FindControl("txt_disc") as RadTextBox).Text);
                    cmd.Parameters.AddWithValue("@factor", (item.FindControl("txt_factor") as RadTextBox).Text);
                    cmd.Parameters.AddWithValue("@jumlah", (item.FindControl("txt_sub_price") as RadTextBox).Text);
                    cmd.Parameters.AddWithValue("@dept_code", (item.FindControl("txt_cost_ctr") as RadTextBox).Text);
                    cmd.Parameters.AddWithValue("@Prod_code_ori", (item.FindControl("txt_Prod_code_ori") as RadTextBox).Text);
                    cmd.Parameters.AddWithValue("@harga2", (item.FindControl("lblHarga") as Label).Text);
                    //cmd.Parameters.AddWithValue("@tTax", (item.FindControl("lblRS") as RadTextBox).Text);
                    //cmd.Parameters.AddWithValue("@tOTax", (item.FindControl("lblUom") as RadTextBox).Text);
                    //cmd.Parameters.AddWithValue("@tpph", (item.FindControl("lblRS") as RadTextBox).Text);
                    cmd.Parameters.AddWithValue("@nomer", (item.FindControl("lblUom") as RadTextBox).Text);
                    cmd.Parameters.AddWithValue("@JDisc", (item.FindControl("txt_JDisk") as RadTextBox).Text);
                    cmd.Parameters.AddWithValue("@HPokok", (item.FindControl("txt_HPokok") as RadTextBox).Text);
                    cmd.Parameters.AddWithValue("@jumlah2", (item.FindControl("txt_sub_price") as RadTextBox).Text);
                    cmd.Parameters.AddWithValue("@NoContr", (item.FindControl("txt_NoContr") as RadTextBox).Text);
                    //cmd.Parameters.AddWithValue("@jTax1", (item.FindControl("lblRS") as RadTextBox).Text);
                    //cmd.Parameters.AddWithValue("@jTax2", (item.FindControl("lblRS") as RadTextBox).Text);
                    //cmd.Parameters.AddWithValue("@jTax3", (item.FindControl("lblRS") as RadTextBox).Text);
                    cmd.Parameters.AddWithValue("@Asscost", 0);

                    cmd.ExecuteNonQuery();

                }
                con.Close();

                //HttpContext.Current.Response.Write("<script>alert('" + System.Web.HttpUtility.HtmlEncode("Berhasil disimpan") + "')</script>");
                notif.Text = "Data berhasil disimpan";
                notif.Title = "Notification";
                notif.Show();
                txt_po_code.Text = run;
                //RadGrid2.Enabled = true;
                btnSave.Enabled = false;
                btnPrint.Enabled = true;
                btnPrint.ImageUrl = "~/Images/cetak.png";
                btnPrint.Attributes["OnClick"] = String.Format("return ShowPreview('{0}');", txt_po_code.Text);
            }
            catch (System.Exception ex)
            {
                con.Close();
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
                //RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "");
                //Response.Write("<font color='red'>" + ex.Message + "</font>");
            }
            //pur01h02_slip._tot_amount = Convert.ToDouble(txt_total.Text);
        }

        //protected void btnPrint_Click(object sender, ImageClickEventArgs e)
        //{
        //    //pur01h02_slip._tot_amount = Convert.ToDouble(txt_total.Text);
        //    btnPrint.Attributes["OnClick"] = String.Format("return ShowPreview('{0}');", txt_po_code.Text);

        //}

        protected void RadGrid2_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            RadGrid2.DataSource = GetDataDetailTable(txt_po_code.Text);
        }
        public DataTable GetDataDetailTable(string po_no)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT prod_type, Prod_code, Spec, qty, SatQty, harga, Disc, ISNULL(tfactor,0) as factor, jumlah, tTax, tOtax, tpph, " +
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
        //protected void RadGrid2_save_handler(object sender, GridCommandEventArgs e)
        //{
        //    //try
        //    //{
        //    //    GridEditableItem item = (GridEditableItem)e.Item;
        //    //    con.Open();
        //    //    cmd = new SqlCommand();
        //    //    cmd.CommandType = CommandType.StoredProcedure;
        //    //    cmd.Connection = con;
        //    //    cmd.CommandText = "sp_save_urD";
        //    //    cmd.Parameters.AddWithValue("@doc_code", txt_ur_number.Text);
        //    //    cmd.Parameters.AddWithValue("@part_code", (item.FindControl("cb_prod_code") as RadComboBox).Text);
        //    //    cmd.Parameters.AddWithValue("@part_qty", Convert.ToDecimal((item.FindControl("txt_qty") as RadTextBox).Text));
        //    //    cmd.Parameters.AddWithValue("@part_unit", (item.FindControl("cb_uom_d") as RadComboBox).Text);
        //    //    cmd.Parameters.AddWithValue("@remark", (item.FindControl("txt_remark_d") as RadTextBox).Text);
        //    //    cmd.Parameters.AddWithValue("@dept_code", (item.FindControl("cb_dept_d") as RadComboBox).Text);
        //    //    cmd.ExecuteNonQuery();
        //    //    con.Close();
        //    //    RadGrid2.DataBind();
        //    //    RadGrid2.Rebind();

        //    //    Label lblsuccess = new Label();
        //    //    lblsuccess.Text = "Data saved";
        //    //    lblsuccess.ForeColor = System.Drawing.Color.DarkGray;
        //    //    RadGrid2.Controls.Add(lblsuccess);
        //    //}
        //    //catch (Exception ex)
        //    //{
        //    //    con.Close();
        //    //    Label lblError = new Label();
        //    //    lblError.Text = "Unable to insert data. Reason: " + ex.Message;
        //    //    lblError.ForeColor = System.Drawing.Color.Red;
        //    //    RadGrid2.Controls.Add(lblError);
        //    //    e.Canceled = true;
        //    //}
        //}

        protected void RadGrid2_DeleteCommand(object sender, GridCommandEventArgs e)
        {

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
                    cbDept_d.Text = cb_cost_center.SelectedValue;
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

    }
}