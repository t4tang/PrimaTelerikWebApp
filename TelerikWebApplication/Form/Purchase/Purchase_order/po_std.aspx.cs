using TelerikWebApplication.Class;
using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace TelerikWebApplication.Forms.Purchase.Purchase_order
{
    public partial class po_std : System.Web.UI.Page
    {
        private const int ItemsPerRequest = 10;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //RadGrid1.MasterTableView.EditMode = (GridEditMode)Enum.Parse(typeof(GridEditMode), "EditForms");
                RadGrid1.MasterTableView.EditMode = (GridEditMode)Enum.Parse(typeof(GridEditMode), "PopUp");
                dtp_from.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
                dtp_to.SelectedDate = DateTime.Now;
                //cb_project.Text = public_str.sitename;
                cb_project_prm.SelectedValue = public_str.site;
            }
        }

        protected void RadGrid1_PreRender(object sender, System.EventArgs e)
        {
            if (!this.IsPostBack && this.RadGrid1.MasterTableView.Items.Count > 1)
            {
                this.RadGrid1.MasterTableView.Items[0].Edit = false;
                this.RadGrid1.MasterTableView.Rebind();
            }
        }

        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();
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
                        cmd = new SqlCommand("SELECT ISNULL ( MAX ( RIGHT ( tr_purchaseH.po_code , 4 ) ) , 0 ) + 1 AS maxNo " +
                            "FROM tr_purchaseH WHERE LEFT(tr_purchaseH.po_code, 4) = 'PO03' " +
                            "AND SUBSTRING(tr_purchaseH.po_code, 5, 2) = SUBSTRING('" + trDate + "', 9, 2) " +
                            "AND SUBSTRING(tr_purchaseH.po_code, 7, 2) = SUBSTRING('" + trDate + "', 4, 2) ", con);
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
                        run = (userControl.FindControl("txt_po_number") as TextBox).Text;
                    }

                    int tax1Inc;
                    int tax2Inc;
                    int tax3Inc;

                    if ((userControl.FindControl("chk_ppn_incl") as CheckBox).Checked == true)
                    {
                        tax1Inc = 1;
                    }
                    else
                    {
                        tax1Inc = 0;
                    }

                    if ((userControl.FindControl("cb_tax2") as RadComboBox).Text == "0")
                    {
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

                    cmd.Parameters.AddWithValue("@PPNIncl", tax1Inc);
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

                    //cmd = new SqlCommand("delete tr_purchaseD where tDel = '0' and po_code = '" + txt_po_no.Text + "'", con);
                    //cmd.CommandType = CommandType.Text;
                    //cmd.ExecuteNonQuery();

                    //cmd = new SqlCommand("update tr_purchaseD set tDel = '0' where po_code = '" + txt_po_no.Text + "'", con);
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
        private static DataTable GetProject(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT region_code, region_name FROM ms_jobsite WHERE stEdit != 4 AND region_name LIKE @text + '%'",
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
                cb_project_prm.Items.Add(new RadComboBoxItem(data.Rows[i]["region_name"].ToString(), data.Rows[i]["region_name"].ToString()));
            }
        }
        protected void cb_project_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT region_code FROM ms_jobsite WHERE region_name = '" + cb_project_prm.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_project_prm.SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
            
        }
    }
}