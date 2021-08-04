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

namespace TelerikWebApplication.Form.Fico.InvoiceIncoming
{
    public partial class acc01h13EditForm : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();
        private const int ItemsPerRequest = 10;

        LinkButton btnAddNewItem;

        public static string tax_check = null;
        public static string oTax_check = null;
        public static string pph_check = null;
        public static string tax1 = null;
        public static string tax2 = null;
        public static string tax3 = null;
        private object txtRemark_d;
        public DataTable dtbl = new DataTable();
        DataTable dtDetail;


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
                if (Request.QueryString["NoBuk"] != null)
                {
                    fill_object(Request.QueryString["NoBuk"].ToString());
                    //RadGrid2.DataSource = GetDataDetailTable(Request.QueryString["NoBuk"].ToString());
                    GetDataDetailTable(Request.QueryString["NoBuk"].ToString());
                    RadGrid2.DataSource = dtDetail;
                    RadGrid2.DataBind();
                    Session["actionEdit"] = "edit";
                }
                else
                {
                    Session["actionEdit"] = "new";

                    dtp_reg.SelectedDate = DateTime.Now;
                    dtp_inv.SelectedDate = DateTime.Now;
                    
                    cb_from_type.Text = "Purchase Order";
                    cb_project.SelectedValue = public_str.site;
                    cb_project.Text = public_str.sitename;

                    lbl_userId.Text = lbl_userId.Text+" "+ public_str.user_id;
                    lbl_Owner.Text = lbl_Owner.Text + " "+ public_str.user_id;
                    lbl_lastUpdate.Text = lbl_lastUpdate.Text +" "+ string.Format("{0:dd/MM/yyyy}", DateTime.Now);
                    //txt_printed.Text = "0";
                    lbl_edited.Text = lbl_edited.Text +" "+ "0";
                    txt_sub_total.Value = 0;
                    txt_tax1_value.Value = 0;
                    txt_tax2_value.Value = 0;
                    txt_tax3_value.Value = 0;
                    txt_other_value.Value = 0;
                    txt_total.Value = 0;
                    Session["TableDetail"] = null;
                    Session["actionDetail"] = "None"; 

                }
            }
        }

        protected void fill_object(string id)
        {
            con.Open();
            SqlDataReader sdr;
            //SqlCommand cmd = new SqlCommand("SELECT a.*, b.* FROM v_invoice_incomingH a LEFT OUTER JOIN v_invoice_incoming_reff b ON " +
            //    "a.NoPO=b.po_code WHERE a.NoBuk =  '" + id + "'", con);
            SqlCommand cmd = new SqlCommand("SELECT * FROM v_invoice_incomingH WHERE NoBuk =  '" + id + "'", con);
            sdr = cmd.ExecuteReader();
            if (sdr.Read())
            {
                txt_reg_code.Text = sdr["NoBuk"].ToString();
                dtp_reg.SelectedDate = Convert.ToDateTime(sdr["Tgl"].ToString());
                dtp_inv.SelectedDate = Convert.ToDateTime(sdr["TglFP"].ToString());
                cb_reff.Text = sdr["NoPO"].ToString();
                cb_from_type.Text = sdr["trans_code_desc"].ToString();
                txt_inv_no.Text= sdr["NoFP"].ToString();
                txt_inv_code.Text= sdr["invCode"].ToString();
                //cb_po_type.Text = sdr["TransName"].ToString();
                //cb_po_type.SelectedValue = sdr["trans_code"].ToString();
                //cb_priority.Text = sdr["prio_desc"].ToString();
                cb_supplier.SelectedValue = sdr["KoSup"].ToString();
                cb_supplier.Text = sdr["NamSup"].ToString();
                txt_curr.Text = sdr["KoMat"].ToString();
                txt_kurs.Value = Convert.ToDouble(sdr["Kurs"].ToString());
                txt_tax_kurs.Value = Convert.ToDouble(sdr["KursTax"].ToString());
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
                //DateTime ref_date = Convert.ToDateTime(sdr["ref_date"].ToString());
                txt_remark.Text = sdr["Ket"].ToString();
                txt_term_days.Value = Convert.ToDouble(sdr["JTempo"].ToString());
                cb_prepared.Text = sdr["prepare_by_name"].ToString();
                cb_verified.Text = sdr["ack_by_name"].ToString();
                cb_approved.Text = sdr["app_by_name"].ToString();
                lbl_Owner.Text = lbl_Owner.Text+" "+sdr["Owner"].ToString();
                //txt_printed.Text = sdr["Printed"].ToString();
                lbl_edited.Text = lbl_edited.Text+" "+ sdr["Edited"].ToString();
                lbl_userId.Text = lbl_userId.Text+" "+ sdr["Usr"].ToString();
                lbl_lastUpdate.Text = lbl_lastUpdate.Text+" "+string.Format("{0:dd/MM/yyyy}", sdr["lastupdate"].ToString());
                cb_term.Text = sdr["payTerm"].ToString();
                txt_pppn.Value = Convert.ToDouble(sdr["PPPN"]);
                txt_ppph.Value = Convert.ToDouble(sdr["ppph"]);
                txt_po_tax.Value = Convert.ToDouble(sdr["POTax"]);
                txt_sub_total.Value = Convert.ToDouble(sdr["jumlah"]);
                txt_tax1_value.Value = Convert.ToDouble(sdr["JPPN"]);
                txt_tax2_value.Value = Convert.ToDouble(sdr["JOtax"]);
                txt_tax3_value.Value = Convert.ToDouble(sdr["JPPH"]);
                txt_total.Value = Convert.ToDouble(sdr["Net"]);
                txt_other_value.Value = Convert.ToDouble(sdr["Othercost"]);

            }
            con.Close();
        }

        #region Detail
        private void DataDetailTable(string NoBuk)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_invoice_incomingD";
            cmd.Parameters.AddWithValue("@NoBuk", NoBuk);
            cmd.CommandTimeout = 0;
            cmd.ExecuteNonQuery();
            sda = new SqlDataAdapter(cmd);

            DataTable DT = new DataTable();

            try
            {
                //sda.Fill(DT);
                dtbl = new DataTable();
                sda.Fill(dtbl);
            }
            finally
            {
                con.Close();
            }
            
        }
        public DataTable GetDataDetailTable(string NoBuk)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_invoice_incomingD";
            cmd.Parameters.AddWithValue("@NoBuk", NoBuk);
            cmd.CommandTimeout = 0;
            cmd.ExecuteNonQuery();
            sda = new SqlDataAdapter(cmd);

            //DataTable DT = new DataTable();
            dtDetail = new DataTable();

            try
            {
                sda.Fill(dtDetail);
            }
            finally
            {
                con.Close();
            }

            Session["TableDetail"] = dtDetail;
            return dtDetail;
        }

        public DataTable detailTable()
        {
            dtDetail = new DataTable();
            dtDetail.Columns.Add("prod_type", typeof(string));
            dtDetail.Columns.Add("Prod_code", typeof(string));
            dtDetail.Columns.Add("qty", typeof(double));
            dtDetail.Columns.Add("part_unit", typeof(string));
            dtDetail.Columns.Add("harga", typeof(double));
            dtDetail.Columns.Add("Disc", typeof(double));
            dtDetail.Columns.Add("jumlah", typeof(double));
            dtDetail.Columns.Add("factor", typeof(double));
            dtDetail.Columns.Add("tTax", typeof(bool));
            dtDetail.Columns.Add("tOtax", typeof(bool));
            dtDetail.Columns.Add("tpph", typeof(bool));
            dtDetail.Columns.Add("dept_code", typeof(string));
            dtDetail.Columns.Add("ref_date", typeof(DateTime));
            dtDetail.Columns.Add("remark", typeof(string));
            dtDetail.Columns.Add("run", typeof(int));

            return dtDetail;
        }

        protected void RadGrid2_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            if (!IsPostBack)
            {
                (sender as RadGrid).DataSource = new string[] { };
            }
            else
            {
                if ((Session["actionDetail"].ToString() == "detailNew" || Session["actionDetail"].ToString() == "detailEdit") && Session["TableDetail"] != null)
                {
                    dtDetail = (DataTable)Session["TableDetail"];
                    (sender as RadGrid).DataSource = dtDetail;
                    Session["TableDetail"] = dtDetail;
                }
                else if (Session["actionDetail"].ToString() == "detailNew" && Session["TableDetail"] == null)
                {
                    detailTable();
                    (sender as RadGrid).DataSource = dtDetail;
                    Session["TableDetail"] = dtDetail;
                }
                else
                {
                    //(sender as RadGrid).DataSource = dtDetail;
                    dtDetail = (DataTable)Session["TableDetail"];
                    (sender as RadGrid).DataSource = dtDetail;
                    Session["TableDetail"] = dtDetail;
                }

            }
            
        }
        protected void RadGrid2_InsertCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                if (Session["actionDetail"].ToString() == "detailNew" && Session["TableDetail"] == null)
                {
                    detailTable();

                    (sender as RadGrid).DataSource = dtDetail; //populate RadGrid with datatable
                    Session["TableDetail"] = dtDetail;
                }
                GridEditableItem item = (GridEditableItem)e.Item;
                /*detailTable();*/
                dtDetail = (DataTable)Session["TableDetail"];
                DataRow drValue = dtDetail.NewRow();
                drValue["prod_type"] = (item.FindControl("lblProdTypeInsert") as RadLabel).Text;
                drValue["Prod_code"] = (item.FindControl("cb_prod_code_insertTemp") as RadComboBox).Text;
                drValue["qty"] = (item.FindControl("txt_qty_insert") as RadNumericTextBox).Value;
                drValue["part_unit"] = (item.FindControl("lblUomInsert") as RadLabel).Text;
                drValue["harga"] = (item.FindControl("txt_hargaInsert") as RadNumericTextBox).Value;
                drValue["Disc"] = (item.FindControl("txt_discInsert") as RadNumericTextBox).Value;
                drValue["jumlah"] = (item.FindControl("txt_sub_priceInsert") as RadNumericTextBox).Value;
                drValue["factor"] = (item.FindControl("txt_factorInsert") as RadNumericTextBox).Value;
                drValue["tTax"] = (item.FindControl("chkTax1Insert") as CheckBox).Checked;
                drValue["tOtax"] = (item.FindControl("chkOTaxInsert") as CheckBox).Checked;
                drValue["tpph"] = (item.FindControl("chkTpphInsert") as CheckBox).Checked;
                drValue["dept_code"] = (item.FindControl("lbl_cost_ctrInsert") as RadLabel).Text;
                drValue["ref_date"] = (item.FindControl("dtpSroDateInsert") as RadDatePicker).SelectedDate;
                drValue["remark"] = (item.FindControl("txtRemark_d_Insert") as RadTextBox).Text;
                drValue["run"] = 0;

                dtDetail.Rows.Add(drValue); //adding new row into datatable
                dtDetail.AcceptChanges();
                Session["TableDetail"] = dtDetail;
                //Session["actionDetail"] = "detailList";
                //dtDetail = (DataTable)Session["TableDetail"];

                RadGrid2.Rebind();
            }
            catch (Exception ex)
            {
                con.Close();
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
                e.Canceled = true;
            }
        }

        protected void RadGrid2_UpdateCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                GridEditableItem item = (GridEditableItem)e.Item;

                dtDetail = (DataTable)Session["TableDetail"];
                DataRow drValue = dtDetail.Rows[0];
                drValue["prod_type"] = (item.FindControl("lblProdTypeEdit") as RadLabel).Text;
                drValue["Prod_code"] = (item.FindControl("cb_prod_code_editTemp") as RadComboBox).Text;
                drValue["qty"] = (item.FindControl("txt_qty_edit") as RadNumericTextBox).Value;
                drValue["part_unit"] = (item.FindControl("lblUomEdit") as RadLabel).Text;
                drValue["harga"] = (item.FindControl("txt_hargaEdit") as RadNumericTextBox).Value;
                drValue["Disc"] = (item.FindControl("txt_discEdit") as RadNumericTextBox).Value;
                drValue["jumlah"] = (item.FindControl("txt_sub_priceEdit") as RadNumericTextBox).Value;
                drValue["factor"] = (item.FindControl("txt_factorEdit") as RadNumericTextBox).Value;
                drValue["tTax"] = (item.FindControl("chkTax1Edit") as CheckBox).Checked;
                drValue["tOtax"] = (item.FindControl("chkOTaxEdit") as CheckBox).Checked;
                drValue["tpph"] = (item.FindControl("chkTpphEdit") as CheckBox).Checked;
                drValue["dept_code"] = (item.FindControl("lbl_cost_ctrEdit") as RadLabel).Text;
                drValue["ref_date"] = (item.FindControl("dtpSroDateEdit") as RadDatePicker).SelectedDate;
                drValue["remark"] = (item.FindControl("txtRemark_d_edit") as RadTextBox).Text;
                drValue["run"] = 0;

                drValue.EndEdit(); //editing row in datatable
                dtDetail.AcceptChanges();
                Session["TableDetail"] = dtDetail;
                (sender as RadGrid).Rebind();
            }
            catch (Exception ex)
            {
                con.Close();
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
                e.Canceled = true;
            }
        }
        
        #endregion

        protected void cb_from_type_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if ((sender as RadComboBox).Text == "Purchase Order")
            {
                (sender as RadComboBox).SelectedValue = "1";
                GridCommandItem cmdItem = (GridCommandItem)RadGrid2.MasterTableView.GetItems(GridItemType.CommandItem)[0];
                //LinkButton btnAddNewItem = (LinkButton)cmdItem.FindControl("LinkButton1");
                btnAddNewItem = (LinkButton)cmdItem.FindControl("LinkButton1");
                btnAddNewItem.Enabled = false;
                LinkButton btnDeleteItem = (LinkButton)cmdItem.FindControl("LinkButton3");
                btnDeleteItem.Enabled = false;
            }
            else if ((sender as RadComboBox).Text == "Consignment")
            {
                (sender as RadComboBox).SelectedValue = "2";
                GridCommandItem cmdItem = (GridCommandItem)RadGrid2.MasterTableView.GetItems(GridItemType.CommandItem)[0];
                //LinkButton btnAddNewItem = (LinkButton)cmdItem.FindControl("LinkButton1");
                btnAddNewItem = (LinkButton)cmdItem.FindControl("LinkButton1");
                btnAddNewItem.Enabled = true;
                LinkButton btnDeleteItem = (LinkButton)cmdItem.FindControl("LinkButton3");
                btnDeleteItem.Enabled = true;
            }
        }

        protected void cb_from_type_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Add("Purchase Order");
            (sender as RadComboBox).Items.Add("Consignment");
        }

        protected void cb_from_type_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadComboBox).Text == "Purchase Order")
            {
                (sender as RadComboBox).SelectedValue = "1";
            }
            else if ((sender as RadComboBox).Text == "Consignment")
            {
                (sender as RadComboBox).SelectedValue = "2";
            }
        }

        #region Supplier
        private static DataTable GetSupplier(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT supplier_code, supplier_name FROM ms_supplier WHERE stEdit != 4 AND supplier_name LIKE @text + '%'",
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
        //protected void cb_supplier_PreRender(object sender, EventArgs e)
        //{
        //    con.Open();
        //    SqlCommand cmd = new SqlCommand();
        //    cmd.Connection = con;
        //    cmd.CommandType = CommandType.Text;
        //    cmd.CommandText = "SELECT supplier_code FROM ms_supplier WHERE supplier_name = '" + (sender as RadComboBox).Text + "'";
        //    SqlDataReader dr;
        //    dr = cmd.ExecuteReader();
        //    while (dr.Read())
        //    {
        //        (sender as RadComboBox).SelectedValue = dr[0].ToString();
        //    }
        //    dr.Close();
        //    con.Close();
        //}
        protected void cb_supplier_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT     ms_supplier.supplier_code,ms_kurs.KursRun, ms_kurs.KursTax, ms_supplier.cur_code, MS_TAX.TAX_NAME as ppnName, " +
                "c.TAX_NAME AS OtaxName, d.TAX_NAME AS pphName, MS_TAX.TAX_CODE ppn, d.TAX_CODE AS Otax, c.TAX_CODE AS pph " + 
                "FROM ms_supplier LEFT OUTER JOIN MS_TAX ON MS_TAX.TAX_CODE = ms_supplier.ppn LEFT OUTER JOIN MS_TAX AS c ON ms_supplier.OTax = c.TAX_CODE LEFT OUTER JOIN " +
                "MS_TAX AS d ON ms_supplier.pph = d.TAX_CODE inner join ms_kurs on ms_supplier.cur_code = ms_kurs.cur_code WHERE(ms_kurs.tglKurs = (SELECT     MAX(tglKurs) AS Expr1 " +
                "FROM ms_kurs)) and ms_supplier.supplier_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                //(sender as RadComboBox).Text = dr["doc_code"].ToString();
                (sender as RadComboBox).SelectedValue = dr["supplier_code"].ToString();
                txt_curr.Text = dr["cur_code"].ToString();
                txt_kurs.Value = Convert.ToDouble(dr["KursRun"].ToString());
                txt_tax_kurs.Value = Convert.ToDouble(dr["KursTax"].ToString());
                cb_tax1.SelectedValue = dr["ppn"].ToString();
                cb_tax2.SelectedValue = dr["Otax"].ToString();
                cb_tax3.SelectedValue = dr["pph"].ToString();
                cb_tax1.Text = dr["ppnName"].ToString();
                cb_tax2.Text = dr["OtaxName"].ToString();
                cb_tax3.Text = dr["pphName"].ToString();
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
            cmd.CommandText = "SELECT cur_code, JTempo, case ms_supplier.pay_code when '01' then 'Cash' when '02' then 'Credit' Else 'COD' end as pay_name  FROM ms_supplier WHERE supplier_code = '" + supp_code + "'";
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

            //SqlDataAdapter adapter = new SqlDataAdapter("SELECT cur_code, JTempo, case ms_supplier.pay_code when '01' then 'Cash' when '02' then 'Credit' Else 'COD' end as pay_name  FROM ms_supplier WHERE supplier_code = @supplier_code", con);
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT ms_supplier.supplier_name, ms_supplier.supplier_code, ms_supplier.KoGSup, ms_supplier.contact1, ms_supplier.contact2, ISNULL(MS_TAX.TAX_NAME,'NON') AS tax1, " +
            "ISNULL(MS_TAX_1.TAX_NAME, 'NON') AS tax2, ISNULL(MS_TAX_2.TAX_NAME, 'NON') AS tax3, ms_supplier.cur_code, ms_supplier.pay_code, " +
            "CASE ms_supplier.pay_code WHEN '01' THEN 'Cash' WHEN '02' THEN 'Credit' ELSE 'COD' END AS pay_term, ms_supplier.JTempo, ms_kurs.KursRun, " +
            "ms_kurs.KursTax, ms_supplier.ppn AS tax1_code, ms_supplier.OTax AS tax2_code, ms_supplier.pph AS tax3_code, " +
            "ISNULL(MS_TAX.TAX_PERC, 0) AS p_tax1, ISNULL(MS_TAX_1.TAX_PERC, 0) AS p_tax2, ISNULL(MS_TAX_2.TAX_PERC, 0) AS p_tax3 " +
            "FROM ms_supplier LEFT OUTER JOIN MS_TAX ON ms_supplier.ppn = MS_TAX.TAX_CODE LEFT OUTER JOIN MS_TAX AS MS_TAX_1 ON ms_supplier.OTax = MS_TAX_1.TAX_CODE LEFT OUTER JOIN " +
            "MS_TAX AS MS_TAX_2 ON ms_supplier.pph = MS_TAX_2.TAX_CODE LEFT OUTER JOIN ms_kurs ON ms_supplier.cur_code = ms_kurs.cur_code " +
            "WHERE(ms_supplier.stEdit <> 4) AND(ms_kurs.tglKurs = (SELECT MAX(tglKurs) AS Expr1 FROM ms_kurs AS ms_kurs_1)) AND ms_supplier.supplier_code = @supplier_code", con);
            adapter.SelectCommand.Parameters.AddWithValue("@supplier_code", supp_code);

            DataTable dt = new DataTable();
            adapter.Fill(dt);
            foreach (DataRow dr in dt.Rows)
            {
                txt_curr.Text = dr["cur_code"].ToString();
                txt_kurs.Value = Convert.ToDouble(dr["KursRun"].ToString());
                txt_tax_kurs.Value = Convert.ToDouble(dr["KursTax"].ToString());
                cb_tax1.Text = dr["tax1"].ToString();
                txt_pppn.Value = Convert.ToDouble(dr["p_tax1"].ToString());
                cb_tax2.Text = dr["tax2"].ToString();
                txt_po_tax.Value = Convert.ToDouble(dr["p_tax2"].ToString());
                cb_tax3.Text = dr["tax3"].ToString();
                txt_ppph.Value = Convert.ToDouble(dr["p_tax3"].ToString());
                cb_term.Text = dr["pay_term"].ToString();
                txt_term_days.Text = dr["JTempo"].ToString();
            }

        }
        #endregion

        protected void cb_term_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if ((sender as RadComboBox).Text == "Cash")
            {
                (sender as RadComboBox).SelectedValue = "01";
            }
            else if ((sender as RadComboBox).Text == "Credit")
            {
                (sender as RadComboBox).SelectedValue = "02";
            }
            else if ((sender as RadComboBox).Text == "COD")
            {
                (sender as RadComboBox).SelectedValue = "03";
            }
        }

        protected void cb_term_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            if ((sender as RadComboBox).Text == "Cash")
            {
                (sender as RadComboBox).SelectedValue = "01";
            }
            else if ((sender as RadComboBox).Text == "Credit")
            {
                (sender as RadComboBox).SelectedValue = "02";
            }
            else if ((sender as RadComboBox).Text == "COD")
            {
                (sender as RadComboBox).SelectedValue = "03";
            }
        }

        protected void cb_term_PreRender(object sender, EventArgs e)
        {
            (sender as RadComboBox).Items.Add("Cash");
            (sender as RadComboBox).Items.Add("Credit");
            (sender as RadComboBox).Items.Add("COD");
        }

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

        protected void cb_reff_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            SqlDataReader dr;
            cmd.CommandText = "select * from v_invoice_incoming_reff where po_code = '" + (sender as RadComboBox).SelectedValue + "'";
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).Text = dr["po_code"].ToString();
                cb_cost_center.SelectedValue = dr["dept_code"].ToString();
                cb_cost_center.Text = dr["CostCenterName"].ToString();
                txt_remark.Text = dr["remark"].ToString();
                txt_curr.Text = dr["cur_code"].ToString();
                txt_kurs.Value = Convert.ToDouble(dr["kurs"].ToString());
                txt_tax_kurs.Value = Convert.ToDouble(dr["kurs_tax"].ToString());
                cb_tax1.Text= dr["PPNName"].ToString();
                cb_tax2.Text = dr["OTaxName"].ToString();
                cb_tax3.Text = dr["PPHName"].ToString();
                cb_tax1.SelectedValue = dr["ppn"].ToString();
                cb_tax2.SelectedValue = dr["OTax"].ToString();
                cb_tax3.SelectedValue = dr["pph"].ToString();
                txt_pppn.Value = Convert.ToDouble(dr["pppn"].ToString());
                txt_ppph.Value = Convert.ToDouble(dr["POTax"].ToString());
                txt_po_tax.Value = Convert.ToDouble(dr["ppph"].ToString());
                    
            }

            dr.Close();
            con.Close();

            //RadGrid2.DataSource = GetDataRefDetailTable((sender as RadComboBox).SelectedValue);
            RefDetailTable((sender as RadComboBox).SelectedValue);
            RadGrid2.DataSource = dtDetail;
            RadGrid2.DataBind();

            foreach (GridDataItem item in this.RadGrid2.Items)
            {
                CheckBox cTax1 = (CheckBox)item.FindControl("chkTax1");
                CheckBox cTax2 = (CheckBox)item.FindControl("chkOTax");
                CheckBox cTax3 = (CheckBox)item.FindControl("chkTpph");

                if (cb_tax1.SelectedValue != "NON")
                {
                    cTax1.Checked = true;
                    CalculateSubTotal(cTax1.Checked, cTax2.Checked, cTax3.Checked);
                }
                else
                {
                    cTax1.Checked = false;
                    CalculateSubTotal(cTax1.Checked, cTax2.Checked, cTax3.Checked);
                }
            }

            CalculateTotal();
        }

        #region PO_Refference

        protected void LoadRef(string po_code, string project, string fromtype, RadComboBox cb)
        {
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            DataTable dt = new DataTable();

            if (fromtype == "Purchase Order")
            {
                SqlDataAdapter adapter = new SqlDataAdapter("SELECT po_code, Po_date, remark FROM v_invoice_incoming_reff WHERE PlantCode = @region_code " +
                "AND po_code LIKE @text + '%' ORDER BY po_code",
                ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
                adapter.SelectCommand.Parameters.AddWithValue("@text", po_code);
                adapter.SelectCommand.Parameters.AddWithValue("@region_code", project);
                adapter.Fill(dt);
            }
            //else
            //{
            //    SqlDataAdapter adapter = new SqlDataAdapter("SELECT po_code, Tgl, remark FROM v_invoice_incoming_reffC WHERE region_code = @region_code " +
            //    "AND po_code LIKE @text + '%' ORDER BY po_code",
            //    ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            //    adapter.SelectCommand.Parameters.AddWithValue("@text", po_code);
            //    adapter.SelectCommand.Parameters.AddWithValue("@region_code", project);
            //    //DataTable dt = new DataTable();
            //    adapter.Fill(dt);
            //}

            cb.DataTextField = "po_code";
            cb.DataValueField = "po_code";
            cb.DataSource = dt;
            cb.DataBind();
            
        }
        protected void cb_reff_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadRef(e.Text, cb_project.SelectedValue, cb_from_type.Text, (sender as RadComboBox));
        }

        public DataTable RefDetailTable(string po_code)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_invoice_incoming_ReffD";
            cmd.Parameters.AddWithValue("@po_code", po_code);
            cmd.CommandTimeout = 0;
            cmd.ExecuteNonQuery();
            sda = new SqlDataAdapter(cmd);

            dtDetail = new DataTable();

            try
            {
                //sda.Fill(dtbl);
                sda.Fill(dtDetail);
            }
            finally
            {
                con.Close();
            }

            Session["TableDetail"] = dtDetail;
            return dtDetail;
        }
        public DataTable GetDataRefDetailTable(string po_code)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_invoice_incoming_ReffD";
            cmd.Parameters.AddWithValue("@po_code", po_code);
            //cmd.Parameters.AddWithValue("@region_code", project_code);
            //cmd.Parameters.AddWithValue("@supplier_code", supplier_code);
            //cmd.Parameters.AddWithValue("@tax1", cb_tax1.Text);
            //cmd.Parameters.AddWithValue("@tax2", cb_tax2.Text);
            //cmd.Parameters.AddWithValue("@tax3", cb_tax3.Text);
            cmd.CommandTimeout = 0;
            cmd.ExecuteNonQuery();
            sda = new SqlDataAdapter(cmd);

            //DataTable DT = new DataTable();
            dtDetail = new DataTable();

            try
            {
                sda.Fill(dtDetail);
                //sda.Fill(dtbl);
            }
            finally
            {
                con.Close();
            }

            return dtDetail;
        }
        protected void cb_reff_ItemDataBound(object sender, RadComboBoxItemEventArgs e)
        {
            e.Item.Text = ((DataRowView)e.Item.DataItem)["po_code"].ToString();
            e.Item.Value = ((DataRowView)e.Item.DataItem)["po_code"].ToString();
        }
        protected void cb_reff_DataBound(object sender, EventArgs e)
        {
            ((Literal)cb_reff.Footer.FindControl("RadComboItemsCount")).Text = Convert.ToString(cb_reff.Items.Count);
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
            (sender as RadComboBox).Text = "";
            LoadCostCtr(e.Text, cb_project.SelectedValue, (sender as RadComboBox));
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
                (sender as RadComboBox).SelectedValue = dr["CostCenter"].ToString();
            dr.Close();
            con.Close();
        }
        #endregion

        #region TAX
        private static DataTable GetTax(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT TAX_NAME FROM MS_TAX WHERE stEdit != 4 AND TAX_NAME LIKE @text + '%' UNION SELECT 'NON'",
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
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["TAX_NAME"].ToString(), data.Rows[i]["TAX_NAME"].ToString()));
            }

            e.Message = GetStatusMessage(endOffset, data.Rows.Count);
        }

        private void get_tax_perc(string tax_code, RadNumericTextBox text_box)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT TAX_PERC FROM  MS_TAX WHERE TAX_CODE = '" + tax_code + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                text_box.Value = Convert.ToDouble(dr["TAX_PERC"].ToString());
            }
            dr.Close();
            con.Close();
        }
        protected void cb_tax1_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT TAX_CODE,TAX_PERC FROM  MS_TAX WHERE TAX_NAME = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["TAX_CODE"].ToString();
            }

            dr.Close();
            con.Close();

            get_tax_perc((sender as RadComboBox).SelectedValue, txt_pppn);

            foreach (GridDataItem item in this.RadGrid2.Items)
            {
                CheckBox cTax1 = (CheckBox)item.FindControl("chkTax1");
                CheckBox cTax2 = (CheckBox)item.FindControl("chkOTax");
                CheckBox cTax3 = (CheckBox)item.FindControl("chkTpph");

                if (cb_tax1.SelectedValue != "NON")
                {
                    cTax1.Checked = true;
                    CalculateSubTotal(cTax1.Checked, cTax2.Checked, cTax3.Checked);
                }
                else
                {
                    cTax1.Checked = false;
                    CalculateSubTotal(cTax1.Checked, cTax2.Checked, cTax3.Checked);
                }
            }
        }

        protected void cb_tax1_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT TAX_CODE,TAX_PERC FROM  MS_TAX WHERE TAX_NAME = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["TAX_CODE"].ToString();
            }

            dr.Close();
            con.Close();
        }

        protected void cb_tax2_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetTax(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["TAX_NAME"].ToString(), data.Rows[i]["TAX_NAME"].ToString()));
            }

            e.Message = GetStatusMessage(endOffset, data.Rows.Count);
        }

        protected void cb_tax2_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT TAX_CODE,TAX_PERC FROM MS_TAX WHERE TAX_NAME = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            }
            dr.Close();
            con.Close();

            get_tax_perc((sender as RadComboBox).SelectedValue, txt_po_tax);

            foreach (GridDataItem item in this.RadGrid2.Items)
            {
                CheckBox cTax1 = (CheckBox)item.FindControl("chkTax1");
                CheckBox cTax2 = (CheckBox)item.FindControl("chkOTax");
                CheckBox cTax3 = (CheckBox)item.FindControl("chkTpph");

                if ((sender as RadComboBox).SelectedValue != "NON")
                {
                    cTax2.Checked = true;
                    CalculateSubTotal(cTax1.Checked, cTax2.Checked, cTax3.Checked);
                }
                else
                {
                    cTax2.Checked = false;
                    CalculateSubTotal(cTax1.Checked, cTax2.Checked, cTax3.Checked);
                }
            }
        }

        protected void cb_tax3_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetTax(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["TAX_NAME"].ToString(), data.Rows[i]["TAX_NAME"].ToString()));
            }

            e.Message = GetStatusMessage(endOffset, data.Rows.Count);
        }

        protected void cb_tax3_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT TAX_CODE,TAX_PERC FROM MS_TAX WHERE TAX_NAME = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            }
            //txt_ppph.Text = dr["TAX_PERC"].ToString();
            dr.Close();
            con.Close();

            get_tax_perc((sender as RadComboBox).SelectedValue, txt_ppph);

            foreach (GridDataItem item in this.RadGrid2.Items)
            {
                CheckBox cTax1 = (CheckBox)item.FindControl("chkTax1");
                CheckBox cTax2 = (CheckBox)item.FindControl("chkOTax");
                CheckBox cTax3 = (CheckBox)item.FindControl("chkTpph");

                if (cb_tax3.SelectedValue != "NON")
                {
                    cTax3.Checked = true;
                    CalculateSubTotal(cTax1.Checked, cTax2.Checked, cTax3.Checked);
                }
                else
                {
                    cTax3.Checked = false;
                    CalculateSubTotal(cTax1.Checked, cTax2.Checked, cTax3.Checked);
                }
            }
        }
        #endregion
        //protected void calculate_sub_price(object sender, EventArgs e)
        //{
        //    RadNumericTextBox ntb = (RadNumericTextBox)sender;
        //    GridEditableItem item = (GridEditableItem)ntb.NamingContainer;

        //    RadNumericTextBox txt_qty = (RadNumericTextBox)item.FindControl("txt_qty");
        //    RadNumericTextBox txt_harga = (RadNumericTextBox)item.FindControl("txt_harga");
        //    RadNumericTextBox txt_disc = (RadNumericTextBox)item.FindControl("txt_disc");
        //    RadNumericTextBox txt_factor = (RadNumericTextBox)item.FindControl("txt_factor");
        //    RadNumericTextBox txt_sub_price = (RadNumericTextBox)item.FindControl("txt_sub_price");
        //    CheckBox chkTax1 = (CheckBox)item.FindControl("edt_chkTax1");
        //    CheckBox chkTax2 = (CheckBox)item.FindControl("edt_chkOTax");
        //    CheckBox chkTax3 = (CheckBox)item.FindControl("edt_chkTpph");

        //    txt_sub_price.Value = (Convert.ToDouble(txt_harga.Value) * Convert.ToDouble(txt_qty.Value)) - (Convert.ToDouble(txt_harga.Value) * Convert.ToDouble(txt_qty.Value) * txt_disc.Value / 100) + (txt_factor.Value);

        //    CalculateSubTotal(chkTax1.Checked, chkTax2.Checked, chkTax3.Checked);
        //}
        protected void calculate_sub_price_new(object sender, EventArgs e)
        {
            RadNumericTextBox ntb = (RadNumericTextBox)sender;
            GridEditableItem item = (GridEditableItem)ntb.NamingContainer;

            RadNumericTextBox txt_qty = (RadNumericTextBox)item.FindControl("txt_qty_insert");
            RadNumericTextBox txt_harga = (RadNumericTextBox)item.FindControl("txt_hargaInsert");
            RadNumericTextBox txt_disc = (RadNumericTextBox)item.FindControl("txt_discInsert");
            RadNumericTextBox txt_factor = (RadNumericTextBox)item.FindControl("txt_factorInsert");
            RadNumericTextBox txt_sub_price = (RadNumericTextBox)item.FindControl("txt_sub_priceInsert");
            CheckBox chkTax1 = (CheckBox)item.FindControl("chkTax1Insert");
            CheckBox chkTax2 = (CheckBox)item.FindControl("chkOTaxInsert");
            CheckBox chkTax3 = (CheckBox)item.FindControl("chkTpphInsert");

            txt_sub_price.Value = (Convert.ToDouble(txt_harga.Value) * Convert.ToDouble(txt_qty.Value)) - (Convert.ToDouble(txt_harga.Value) * Convert.ToDouble(txt_qty.Value) * txt_disc.Value / 100) + (txt_factor.Value);

            CalculateSubTotal(chkTax1.Checked, chkTax2.Checked, chkTax3.Checked);
        }
        protected void calculate_sub_price_edit(object sender, EventArgs e)
        {
            RadNumericTextBox ntb = (RadNumericTextBox)sender;
            GridEditableItem item = (GridEditableItem)ntb.NamingContainer;

            RadNumericTextBox txt_qty = (RadNumericTextBox)item.FindControl("txt_qty_edit");
            RadNumericTextBox txt_harga = (RadNumericTextBox)item.FindControl("txt_hargaEdit");
            RadNumericTextBox txt_disc = (RadNumericTextBox)item.FindControl("txt_discEdit");
            RadNumericTextBox txt_factor = (RadNumericTextBox)item.FindControl("txt_factorEdit");
            RadNumericTextBox txt_sub_price = (RadNumericTextBox)item.FindControl("txt_sub_priceEdit");
            CheckBox chkTax1 = (CheckBox)item.FindControl("chkTax1Edit");
            CheckBox chkTax2 = (CheckBox)item.FindControl("chkOTaxEdit");
            CheckBox chkTax3 = (CheckBox)item.FindControl("chkTpphEdit");

            txt_sub_price.Value = (Convert.ToDouble(txt_harga.Value) * Convert.ToDouble(txt_qty.Value)) - (Convert.ToDouble(txt_harga.Value) * Convert.ToDouble(txt_qty.Value) * txt_disc.Value / 100) + (txt_factor.Value);

            CalculateSubTotal(chkTax1.Checked, chkTax2.Checked, chkTax3.Checked);
        }
        private void CalculateSubTotal(bool tax1, bool tax2, bool tax3)
        //private void CalculateSubTotal(CheckBox chkb)
        {
            double amount = 0;
            double tax1_amount = 0;
            double tax2_amount = 0;
            double tax3_amount = 0;
            double sum = 0;
            double tax1_sum = 0;
            double tax2_sum = 0;
            double tax3_sum = 0;

            foreach (GridDataItem item in this.RadGrid2.Items)
            {
                try
                {
                    if (Session["actionDetail"].ToString() == "detailNew")
                    {
                        RadNumericTextBox txt_sub_price = (RadNumericTextBox)item.FindControl("txt_sub_priceInsert");
                        amount = (Convert.ToDouble(txt_sub_price.Value));
                    }
                    else if (Session["actionDetail"].ToString() == "detailEdit")
                    {
                        RadNumericTextBox txt_sub_price = (RadNumericTextBox)item.FindControl("txt_sub_priceEdit");
                        amount = (Convert.ToDouble(txt_sub_price.Value));
                    }
                    else
                    {
                        RadLabel lbl_sub_price = (RadLabel)item.FindControl("lbl_sub_price");
                        amount = (Convert.ToDouble(lbl_sub_price.Text));
                    }
                   

                    if (tax1 == true)
                    {
                        tax1_amount = 0;
                        tax1_amount = (Convert.ToDouble(txt_pppn.Value) / 100) * amount;
                        //txt_tax1_value.Value = (Convert.ToDouble(txt_tax1_value.Value) + (Convert.ToDouble(txt_pppn.Value) / 100) * amount);
                    }
                    else
                    {
                        tax1_amount = tax1_amount - (Convert.ToDouble(txt_pppn.Value) / 100) * amount;
                        //txt_tax1_value.Value = (Convert.ToDouble(txt_tax1_value.Value) - (Convert.ToDouble(txt_pppn.Value) / 100) * amount);
                    }

                    if (tax2 == true)
                    {
                        tax2_amount = (Convert.ToDouble(txt_po_tax.Value) / 100) * amount;
                    }
                    else
                    {
                        tax2_amount = tax2_amount - (Convert.ToDouble(txt_po_tax.Value) / 100) * amount;
                    }

                    if (tax3 == true)
                    {
                        tax3_amount = (Convert.ToDouble(txt_ppph.Value) / 100) * amount;
                    }
                    else
                    {
                        tax3_amount = tax3_amount - (Convert.ToDouble(txt_ppph.Value) / 100) * amount;
                    }

                    //amount = amount + tax1_value + tax2_value + tax3_value;
                }
                catch
                {
                    amount = 0;
                }
                finally
                {
                    tax1_sum += tax1_amount;
                    tax2_sum += tax2_amount;
                    tax3_sum += tax3_amount;
                    sum += amount;
                }
            }

            txt_sub_total.Value = (Convert.ToDouble(sum.ToString()));
            txt_tax1_value.Value = (Convert.ToDouble(tax1_sum.ToString()));
            txt_tax2_value.Value = (Convert.ToDouble(tax2_sum.ToString()));
            txt_tax3_value.Value = (Convert.ToDouble(tax3_sum.ToString()));

            CalculateTotal();
        }

        private void CalculateTotal()
        {
            //double amount = 0;
            double sum = 0;

            sum = (Convert.ToDouble(txt_sub_total.Value)) + (Convert.ToDouble(txt_tax1_value.Value)) +
                (Convert.ToDouble(txt_tax2_value.Value)) + (Convert.ToDouble(txt_tax3_value.Value)) +
                (Convert.ToDouble(txt_other_value.Value));

            txt_total.Text = sum.ToString();

        }

        protected void edt_chkTax1_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox ntb = (CheckBox)sender;
            GridEditableItem item = (GridEditableItem)ntb.NamingContainer;
            RadNumericTextBox txt_sub_price = (RadNumericTextBox)item.FindControl("txt_sub_price");
            double sub_price;
            double taxVal;

            if ((sender as CheckBox).Checked == true)
            {
                sub_price = Convert.ToDouble(txt_sub_price.Value);
                taxVal = Convert.ToDouble(txt_tax1_value.Value);
                txt_tax1_value.Value = taxVal + ((Convert.ToDouble(txt_pppn.Value) / 100) * sub_price);

                tax_check = "1";
            }
            else
            {
                sub_price = Convert.ToDouble(txt_sub_price.Value);
                taxVal = Convert.ToDouble(txt_tax1_value.Value);
                txt_tax1_value.Value = taxVal - ((Convert.ToDouble(txt_pppn.Value) / 100) * sub_price);

                tax_check = "0";
            }

            CalculateTotal();
        }

        protected void edt_chkOTax_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox ntb = (CheckBox)sender;
            GridEditableItem item = (GridEditableItem)ntb.NamingContainer;
            RadNumericTextBox txt_sub_price = (RadNumericTextBox)item.FindControl("txt_sub_price");
            double sub_price;
            double taxVal;

            if ((sender as CheckBox).Checked == true)
            {
                sub_price = Convert.ToDouble(txt_sub_price.Value);
                taxVal = Convert.ToDouble(txt_tax2_value.Value);
                txt_tax2_value.Value = taxVal + ((Convert.ToDouble(txt_po_tax.Value) / 100) * sub_price);

                oTax_check = "1";
            }
            else
            {
                sub_price = Convert.ToDouble(txt_sub_price.Value);
                taxVal = Convert.ToDouble(txt_tax2_value.Value);
                txt_tax2_value.Value = taxVal - ((Convert.ToDouble(txt_po_tax.Value) / 100) * sub_price);

                oTax_check = "0";
            }

            CalculateTotal();
        }

        protected void edt_chkTpph_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox ntb = (CheckBox)sender;
            GridEditableItem item = (GridEditableItem)ntb.NamingContainer;
            RadNumericTextBox txt_sub_price = (RadNumericTextBox)item.FindControl("txt_sub_price");
            double sub_price;
            double taxVal;

            if ((sender as CheckBox).Checked == true)
            {
                sub_price = Convert.ToDouble(txt_sub_price.Value);
                taxVal = Convert.ToDouble(txt_tax3_value.Value);
                txt_tax3_value.Value = taxVal + ((Convert.ToDouble(txt_ppph.Value) / 100) * sub_price);

                pph_check = "1";
            }
            else
            {
                sub_price = Convert.ToDouble(txt_sub_price.Value);
                taxVal = Convert.ToDouble(txt_tax3_value.Value);
                txt_tax3_value.Value = taxVal - ((Convert.ToDouble(txt_ppph.Value) / 100) * sub_price);

                pph_check = "0";
            }

            CalculateTotal();
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
        protected void cb_prepared_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
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

        protected void cb_prepared_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadManPower(e.Text, cb_project.SelectedValue, (sender as RadComboBox));
        }

        protected void cb_prepared_PreRender(object sender, EventArgs e)
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

        protected void cb_verified_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
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

        protected void cb_verified_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadManPower(e.Text, cb_project.SelectedValue, (sender as RadComboBox));
        }

        protected void cb_verified_PreRender(object sender, EventArgs e)
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

        protected void cb_approved_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
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

        protected void cb_approved_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadManPower(e.Text, cb_project.SelectedValue, (sender as RadComboBox));
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

        protected void btn_save_Click(object sender, EventArgs e)
        {
            long maxNo;
            string run = null;
            string trDate = string.Format("{0:dd/MM/yyyy}", dtp_reg.SelectedDate);

            try
            {
                if (Session["actionEdit"].ToString() != "new")
                {
                    run = txt_reg_code.Text;
                }
                else
                {
                    con.Open();
                    SqlDataReader sdr;
                    cmd = new SqlCommand("SELECT ISNULL ( MAX ( RIGHT ( MUTAP.NoBuk , 4 ) ) , 0 ) + 1 AS maxNo " +
                        "FROM MUTAP WHERE LEFT(MUTAP.NoBuk, 4) = 'BL01' " +
                        "AND SUBSTRING(MUTAP.NoBuk, 5, 2) = SUBSTRING('" + trDate + "', 9, 2) " +
                        "AND SUBSTRING(MUTAP.NoBuk, 7, 2) = SUBSTRING('" + trDate + "', 4, 2) ", con);
                    sdr = cmd.ExecuteReader();
                    if (sdr.HasRows == false)
                    {
                        //throw new Exception();
                        run = "BL01" + dtp_reg.SelectedDate.Value.Year + dtp_reg.SelectedDate.Value.Month + "0001";
                    }
                    else if (sdr.Read())
                    {
                        maxNo = Convert.ToInt32(sdr[0].ToString());
                        run = "BL01" + (dtp_reg.SelectedDate.Value.Year.ToString()).Substring(dtp_reg.SelectedDate.Value.Year.ToString().Length - 2) +
                            ("0000" + dtp_reg.SelectedDate.Value.Month).Substring(("0000" + dtp_reg.SelectedDate.Value.Month).Length - 2, 2) +
                            ("0000" + maxNo).Substring(("0000" + maxNo).Length - 4, 4);
                    }
                    con.Close();
                }


                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_save_invoice_incomingH";
                cmd.Parameters.AddWithValue("@NoBuk", run);
                cmd.Parameters.AddWithValue("@Tgl", string.Format("{0:yyyy-MM-dd}", dtp_reg.SelectedDate.Value));
                cmd.Parameters.AddWithValue("@NoFP", txt_inv_no.Text);
                cmd.Parameters.AddWithValue("@TglFP", string.Format("{0:yyyy-MM-dd}", dtp_inv.SelectedDate.Value));
                cmd.Parameters.AddWithValue("@InvCode", txt_inv_code.Text);
                cmd.Parameters.AddWithValue("@trans_code", cb_from_type.SelectedValue);
                cmd.Parameters.AddWithValue("@kurs", Convert.ToDouble(txt_kurs.Value));
                cmd.Parameters.AddWithValue("@pay_code", cb_term.SelectedValue);
                cmd.Parameters.AddWithValue("@JTempo", Convert.ToDouble(txt_term_days.Value));
                cmd.Parameters.AddWithValue("@FreBy", cb_prepared.SelectedValue);
                cmd.Parameters.AddWithValue("@OrdBy", cb_verified.SelectedValue);
                cmd.Parameters.AddWithValue("@AppBy", cb_approved.SelectedValue);

                cmd.Parameters.AddWithValue("@PPN", cb_tax1.SelectedValue);
                cmd.Parameters.AddWithValue("@PPPN", Convert.ToDouble(txt_pppn.Value));
                cmd.Parameters.AddWithValue("@JPPN", Convert.ToDouble(txt_tax1_value.Value));
                cmd.Parameters.AddWithValue("@PPNIncl", chk_ppn_incl.Checked);

                cmd.Parameters.AddWithValue("@OTax", cb_tax2.SelectedValue);
                cmd.Parameters.AddWithValue("@JOTax", Convert.ToDouble(txt_tax2_value.Value));
                cmd.Parameters.AddWithValue("@poTax", Convert.ToDouble(txt_po_tax.Value));
                cmd.Parameters.AddWithValue("@OTaxIncl", 0);

                cmd.Parameters.AddWithValue("@pph", cb_tax3.SelectedValue);
                cmd.Parameters.AddWithValue("@Jpph", Convert.ToDouble(txt_tax3_value.Value));
                cmd.Parameters.AddWithValue("@Ppph", Convert.ToDouble(txt_ppph.Value));
                cmd.Parameters.AddWithValue("@pphIncl", 0);

                cmd.Parameters.AddWithValue("@Net", Convert.ToDouble(txt_total.Value));
                cmd.Parameters.AddWithValue("@Freight", 0);
                cmd.Parameters.AddWithValue("@DP", 0);
                cmd.Parameters.AddWithValue("@dept_code", cb_cost_center.SelectedValue);
                cmd.Parameters.AddWithValue("@Owner",public_str.user_id);
                cmd.Parameters.AddWithValue("@tFullSupply", 0);
                cmd.Parameters.AddWithValue("@KursTax", Convert.ToDouble(txt_tax_kurs.Value));
                cmd.Parameters.AddWithValue("@Ket", txt_remark.Text);
                cmd.Parameters.AddWithValue("@NoPO", cb_reff.Text);
                cmd.Parameters.AddWithValue("@KoSup", cb_supplier.SelectedValue);
                cmd.Parameters.AddWithValue("@NamSup", cb_supplier.Text);
                cmd.Parameters.AddWithValue("@KoMat", txt_curr.Text);
                cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
                cmd.Parameters.AddWithValue("@region_code", cb_project.SelectedValue);
                cmd.Parameters.AddWithValue("@tax_invoice", DBNull.Value);
                cmd.Parameters.AddWithValue("@Jumlah", Convert.ToDouble(txt_sub_total.Value));
                cmd.Parameters.AddWithValue("@Ass", 0);
                cmd.Parameters.AddWithValue("@OwnStamp", string.Format("{0:yyyy-MM-dd}", DateTime.Now));
                cmd.Parameters.AddWithValue("@Kode", "BL");
                cmd.Parameters.AddWithValue("@Nomor", 0);
                cmd.Parameters.AddWithValue("@Selisih", 0);
                cmd.Parameters.AddWithValue("@PDisc", 0);
                cmd.Parameters.AddWithValue("@Otorisasi", 0);
                cmd.Parameters.AddWithValue("@Printed", 0);
                cmd.Parameters.AddWithValue("@Batal", 0);
                cmd.Parameters.AddWithValue("@Stamp", string.Format("{0:yyyy-MM-dd}", DateTime.Now));
                cmd.Parameters.AddWithValue("@debt_rema", Convert.ToDouble(txt_total.Value));
                cmd.Parameters.AddWithValue("@debt_netto", Convert.ToDouble(txt_total.Value));
                cmd.Parameters.AddWithValue("@tot_disc", 0);
                cmd.Parameters.AddWithValue("@tot_ret", 0);
                cmd.Parameters.AddWithValue("@tot_pay", 0);
                cmd.Parameters.AddWithValue("@tot_pay_num", 0);
                cmd.Parameters.AddWithValue("@posting", 0);
                cmd.Parameters.AddWithValue("@tLunas", 0);
                cmd.Parameters.AddWithValue("@PreJPPN", 0);
                cmd.Parameters.AddWithValue("@PreJPPH", 0);
                cmd.Parameters.AddWithValue("@PreJOTAX", 0);
                cmd.Parameters.AddWithValue("@Edited", 0);

                cmd.ExecuteNonQuery();

                //foreach(DataRow dr in dtbl.Rows)
                //{
                //    cmd = new SqlCommand();
                //    cmd.CommandType = CommandType.StoredProcedure;
                //    cmd.Connection = con;
                //    cmd.CommandText = "sp_save_invoice_incomingD";
                //    cmd.Parameters.AddWithValue("@NoBuk", run);
                //    cmd.Parameters.AddWithValue("@prod_type", dr["prod_type"]);
                //    cmd.Parameters.AddWithValue("@KoBar", dr["prod_code"]);
                //    cmd.Parameters.AddWithValue("@Qty", Convert.ToDouble(dr["Qty"]));
                //    cmd.Parameters.AddWithValue("@SatQty", dr["SatQty"]);
                //    cmd.Parameters.AddWithValue("@Harga", Convert.ToDouble(dr["Harga"]));
                //    cmd.Parameters.AddWithValue("@Disc", Convert.ToDouble(dr["Disc"]));
                //    cmd.Parameters.AddWithValue("@tTax", dr["tTax"]);
                //    cmd.Parameters.AddWithValue("@tOTax", dr["tOTax"]);
                //    cmd.Parameters.AddWithValue("@tpph", dr["tpph"]);                   
                //    cmd.Parameters.AddWithValue("@harga2", Convert.ToDouble(dr["harga2"]));
                //    cmd.Parameters.AddWithValue("@prod_code_ori", dr["prod_code_ori"]);
                //    cmd.Parameters.AddWithValue("@dept_code", dr["dept_code"]);
                //    cmd.Parameters.AddWithValue("@factor", Convert.ToDouble(dr["factor"]));
                //    cmd.Parameters.AddWithValue("@Asscost", 0);
                //    cmd.Parameters.AddWithValue("@noref", cb_reff.SelectedValue);
                //    cmd.Parameters.AddWithValue("@KoRek", 0);
                //    cmd.Parameters.AddWithValue("@KvrsiQty", 1);
                //    cmd.Parameters.AddWithValue("@SatHrg", 0);
                //    cmd.Parameters.AddWithValue("@KvrsiHrg", 1);
                //    cmd.Parameters.AddWithValue("@TDisc", "%");
                //    cmd.Parameters.AddWithValue("@Freight", 0);
                //    cmd.Parameters.AddWithValue("@Ass", 0);
                //    cmd.Parameters.AddWithValue("@Ket", dr["remark"]);
                //    cmd.Parameters.AddWithValue("@tfactor", 0);
                //    cmd.Parameters.AddWithValue("@KoBarH", 0);

                //    cmd.ExecuteNonQuery();
                //    notif.Text = "Data berhasil disimpan";
                //    notif.Title = "Notification";
                //    notif.Show();
                //    txt_reg_code.Text = run;
                //}


                foreach (GridDataItem item in RadGrid2.MasterTableView.Items)
                {
                    if((item.FindControl("chk_select") as CheckBox).Checked)
                    {
                        cmd = new SqlCommand();
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Connection = con;
                        cmd.CommandText = "sp_save_invoice_incomingD";
                        cmd.Parameters.AddWithValue("@NoBuk", run);
                        cmd.Parameters.AddWithValue("@prod_type", (item.FindControl("lblProdType") as RadLabel).Text);
                        cmd.Parameters.AddWithValue("@KoBar", (item.FindControl("lblProdCode") as RadLabel).Text);
                        cmd.Parameters.AddWithValue("@Qty", Convert.ToDouble((item.FindControl("lbl_qty") as RadLabel).Text));
                        cmd.Parameters.AddWithValue("@SatQty", (item.FindControl("lbl_uom") as RadLabel).Text);
                        cmd.Parameters.AddWithValue("@Harga", Convert.ToDouble((item.FindControl("lbl_harga") as RadLabel).Text));
                        cmd.Parameters.AddWithValue("@Disc", Convert.ToDouble((item.FindControl("lbl_disc") as RadLabel).Text));
                        if ((item.FindControl("chkTax1") as CheckBox).Checked == true)
                        {
                            cmd.Parameters.AddWithValue("@tTax", 1);
                        }
                        else
                        {
                            cmd.Parameters.AddWithValue("@tTax", 0);
                        }
                        if ((item.FindControl("chkOTax") as CheckBox).Checked == true)
                        {
                            cmd.Parameters.AddWithValue("@tOTax", 1);
                        }
                        else
                        {
                            cmd.Parameters.AddWithValue("@tOTax", 0);
                        }
                        if ((item.FindControl("chkTpph") as CheckBox).Checked == true)
                        {
                            cmd.Parameters.AddWithValue("@tpph", 1);
                        }
                        else
                        {
                            cmd.Parameters.AddWithValue("@tpph", 0);
                        }
                        cmd.Parameters.AddWithValue("@harga2", Convert.ToDouble((item.FindControl("lbl_sub_price") as RadLabel).Text));
                        cmd.Parameters.AddWithValue("@prod_code_ori", (item.FindControl("lblProdCode") as RadLabel).Text);
                        cmd.Parameters.AddWithValue("@dept_code", (item.FindControl("lbl_cost_ctr") as RadLabel).Text);
                        cmd.Parameters.AddWithValue("@factor", Convert.ToDouble((item.FindControl("lbl_factor") as RadLabel).Text));
                        cmd.Parameters.AddWithValue("@Asscost", 0);
                        cmd.Parameters.AddWithValue("@noref", cb_reff.SelectedValue);
                        //cmd.Parameters.AddWithValue("@tax1", cb_tax1.Text);
                        //cmd.Parameters.AddWithValue("@tax2", cb_tax2.Text);
                        //cmd.Parameters.AddWithValue("@tax3", cb_tax3.Text);
                        cmd.Parameters.AddWithValue("@KoRek", 0);
                        cmd.Parameters.AddWithValue("@KvrsiQty", 1);
                        cmd.Parameters.AddWithValue("@SatHrg", DBNull.Value);
                        cmd.Parameters.AddWithValue("@KvrsiHrg", 1);
                        cmd.Parameters.AddWithValue("@TDisc", "%");
                        cmd.Parameters.AddWithValue("@Freight", 0);
                        cmd.Parameters.AddWithValue("@Ass", 0);
                        cmd.Parameters.AddWithValue("@Ket", (item.FindControl("txtRemark_d") as RadTextBox).Text);
                        cmd.Parameters.AddWithValue("@tfactor", 0);
                        //cmd.Parameters.AddWithValue("@RefTransID", 0);
                        cmd.Parameters.AddWithValue("@KoBarH", DBNull.Value);

                        cmd.ExecuteNonQuery();
                    }
                    
                    notif.Text = "Data berhasil disimpan";
                    notif.Title = "Notification";
                    notif.Show();
                    txt_reg_code.Text = run;
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

                if (Session["actionEdit"].ToString() == "edit")
                {
                    ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind();", true);
                }
                else
                {
                    ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind('navigateToInserted');", true);
                }

                //acc01h13.tr_code = run;
                //acc01h13.selected_project = cb_project.SelectedValue;
            }
        }

        private void populate_dataTable()
        {
            //foreach(GridDataItem item in RadGrid2.Items)
            //{
            //    string prodType = (item.FindControl("lblProdType") as Label).Text;

            //}
            int columncount = 0;

            foreach (GridColumn column in RadGrid2.MasterTableView.Columns)
            {
                if (!string.IsNullOrEmpty(column.UniqueName) && !string.IsNullOrEmpty(column.HeaderText))
                {
                    columncount++;
                    dtbl.Columns.Add(column.UniqueName, typeof(string));
                }
            }

            DataRow dr;
            foreach (GridDataItem item in RadGrid2.Items)
            {
                dr = dtbl.NewRow();

                for (int i = 0; i < columncount; i++)
                {
                    dr[i] = item[RadGrid2.MasterTableView.Columns[i].UniqueName].Text;
                }

                dtbl.Rows.Add(dr);
            }

        }
        protected void RadGrid2_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadGrid).MasterTableView.Items.Count < (sender as RadGrid).MasterTableView.PageSize)
            {
                (sender as RadGrid).ClientSettings.Scrolling.AllowScroll = false;
                (sender as RadGrid).ClientSettings.Scrolling.UseStaticHeaders = false;
            }


            if (cb_from_type.SelectedValue == "2" && (sender as RadGrid).MasterTableView.IsItemInserted == false)
            {
                GridCommandItem cmdItem = (GridCommandItem)RadGrid2.MasterTableView.GetItems(GridItemType.CommandItem)[0];
                LinkButton btnAddNewItem = (LinkButton)cmdItem.FindControl("LinkButton1");
                btnAddNewItem.Enabled = true;

                
            }
        }

        protected void RadGrid3_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            if (Session["actionEdit"].ToString() == "edit")
            {
                (sender as RadGrid).DataSource = GetJournalTable(txt_reg_code.Text);
            }
            else
            {
                (sender as RadGrid).DataSource = new string[] { };
            }
        }
        public DataTable GetJournalTable(string doc_code)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_invoice_incoming_journal";
            cmd.Parameters.AddWithValue("@NoBuk", doc_code);
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

        //protected void RadGrid2_DeleteCommand(object sender, GridCommandEventArgs e)
        //{
        //    populate_dataTable();
        //    RadGrid1.DataSource = dtbl;
        //    RadGrid1.DataBind();
        //}

        protected void btnJournal_Click(object sender, EventArgs e)
        {
            //populate_dataTable();
            //RadGrid1.DataSource = dtbl;
            //RadGrid1.DataBind();
        }

        protected void chk_select_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox chk = sender as CheckBox;
            GridDataItem item = (GridDataItem)chk.NamingContainer;
            if (!chk.Checked)
            {
                //item.Enabled = false;
                foreach (GridDataItem gdi in RadGrid2.SelectedItems)
                {
                    (gdi.FindControl("txt_qty") as RadNumericTextBox).ReadOnly = true;
                    (gdi.FindControl("txt_harga") as RadNumericTextBox).ReadOnly = true;
                    (gdi.FindControl("txt_disc") as RadNumericTextBox).ReadOnly = true;
                    //(gdi.FindControl("lbl_uom") as RadLabel).Enabled = true;
                    (gdi.FindControl("txt_factor") as RadNumericTextBox).ReadOnly = true;
                    (gdi.FindControl("edt_chkTax1") as CheckBox).Enabled = true;
                    (gdi.FindControl("edt_chkOTax") as CheckBox).Enabled = true;
                    (gdi.FindControl("edt_chkTpph") as CheckBox).Enabled = true;
                    (gdi.FindControl("dtpSroDate") as RadDatePicker).Enabled = true;
                    (gdi.FindControl("txtRemark_d") as RadTextBox).ReadOnly = true;
                }
            }
            else
            {
                foreach (GridDataItem gdi in RadGrid2.SelectedItems)
                {
                    (gdi.FindControl("txt_qty") as RadNumericTextBox).ReadOnly = false;
                    (gdi.FindControl("txt_harga") as RadNumericTextBox).ReadOnly = false;
                    (gdi.FindControl("txt_disc") as RadNumericTextBox).ReadOnly = false;
                    //(gdi.FindControl("lbl_uom") as RadLabel).Enabled = false;
                    (gdi.FindControl("txt_factor") as RadNumericTextBox).ReadOnly = false;
                    (gdi.FindControl("edt_chkTax1") as CheckBox).Enabled = false;
                    (gdi.FindControl("edt_chkOTax") as CheckBox).Enabled = false;
                    (gdi.FindControl("edt_chkTpph") as CheckBox).Enabled = false;
                    (gdi.FindControl("dtpSroDate") as RadDatePicker).Enabled = false;
                    (gdi.FindControl("txtRemark_d") as RadTextBox).ReadOnly = false;
                }
            }
        }

        protected void RadGrid2_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                CheckBox chk = e.Item.FindControl("chk_select") as CheckBox;
                chk.Attributes.Add("onclick", "Select('" + e.Item.ItemIndex + "');");
            }
        }

        protected void RadGrid2_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if(e.Item is GridDataItem)
            {
                CheckBox chk = e.Item.FindControl("chk_select") as CheckBox;
                chk.Attributes.Add("onclick", "Select('" + e.Item.ItemIndex + "');");   
            }

            //if (Session["actionDetail"].ToString() == "detailNew")
            //{
            //    if (cb_from_type.SelectedValue == "2")
            //    {
            //        GridDataItem item = (GridDataItem)e.Item;
            //        RadComboBox cb_prodcode = (RadComboBox)item.FindControl("cb_prod_code_insertTemp");
            //        cb_prodcode.Enabled = true;
            //    }
            //}
            //else if (Session["actionDetail"].ToString() == "detailNew")
            //{
            //    if (cb_from_type.SelectedValue == "2")
            //    {
            //        GridDataItem item = (GridDataItem)e.Item;
            //        RadComboBox cb_prodcode = (RadComboBox)item.FindControl("cb_prod_code_editTemp");
            //        cb_prodcode.Enabled = true;
            //    }
            //}
        }


        protected void RadGrid2_ItemCommand(object sender, GridCommandEventArgs e)
        {
            
            if (e.CommandName == "RowClick" && cb_from_type.SelectedValue == "2")
            {
                GridCommandItem cmdItem = (GridCommandItem)RadGrid2.MasterTableView.GetItems(GridItemType.CommandItem)[0];
                LinkButton btnDeleteSelected = (LinkButton)cmdItem.FindControl("LinkButton3");
                btnDeleteSelected.Enabled = true;
            }

            if (e.CommandName == RadGrid.InitInsertCommandName)
            {
                Session["actionDetail"] = "detailNew";
            }
            else if (e.CommandName == RadGrid.EditCommandName)
            {
                Session["actionDetail"] = "detailEdit";
            }
        }

        protected void cb_prod_code_insertTemp_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            try
            {
                if (cb_from_type.SelectedValue == "2")
                {
                    string sql = "SELECT TOP (100)[prod_code], [prod_spec], [unit_code], [qty_out], [disc], [price], [do_code], [Tgl], [info_code], [dept_code] " +
                    "FROM [v_invoice_incoming_from_consigment]  WHERE cust_code != @cust_code AND region_code = @region_code AND prod_spec LIKE @spec + '%'";
                    SqlDataAdapter adapter = new SqlDataAdapter(sql,
                        ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
                    adapter.SelectCommand.Parameters.AddWithValue("@cust_code", cb_supplier.SelectedValue);
                    adapter.SelectCommand.Parameters.AddWithValue("@region_code", cb_project.SelectedValue);
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
                        item.Attributes.Add("prod_spec", row["prod_spec"].ToString());
                        item.Attributes.Add("unit_code", row["unit_code"].ToString());
                        item.Attributes.Add("qty_out", row["qty_out"].ToString());
                        item.Attributes.Add("disc", row["disc"].ToString());
                        item.Attributes.Add("price", row["price"].ToString());
                        item.Attributes.Add("do_code", row["do_code"].ToString());
                        item.Attributes.Add("Tgl", row["Tgl"].ToString());
                        item.Attributes.Add("info_code", row["info_code"].ToString());
                        item.Attributes.Add("dept_code", row["dept_code"].ToString());

                        comboBox.Items.Add(item);

                        item.DataBind();
                    }
                }
                
            }
            catch (Exception ex)
            {
                Response.Write("<script language='javascript'>alert('" + ex.Message + "')</script>");
            }
            
        }

        protected void cb_prod_code_insertTemp_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "SELECT [prod_code], [prod_spec], [unit_code], [qty_out], [disc], [price], [do_code], [Tgl], [info_code], [dept_code] " +
                    "FROM [v_invoice_incoming_from_consigment] WHERE prod_code = '" + (sender as RadComboBox).SelectedValue + "'";

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                foreach (DataRow dtr in dt.Rows)
                {
                    RadComboBox cb = (RadComboBox)sender;
                    GridEditableItem item = (GridEditableItem)cb.NamingContainer;

                    //Label lblQtyRs;
                    RadLabel lbl_UoM;
                    RadLabel lbl_prodType;
                    RadNumericTextBox txtPartQty;
                    RadNumericTextBox txtPrice;
                    RadNumericTextBox txtdisc;
                    RadNumericTextBox txtSubPrice;
                    RadLabel txtCostCtr;
                    RadDatePicker Tgl;
                    RadNumericTextBox txtFactor;
                    CheckBox ttax1;
                    CheckBox tOtax;
                    CheckBox tpph;

                    lbl_prodType = (RadLabel)item.FindControl("lblProdTypeInsert");
                    txtPartQty = (RadNumericTextBox)item.FindControl("txt_qty_insert");
                    lbl_UoM = (RadLabel)item.FindControl("lblUomInsert");
                    txtPrice = (RadNumericTextBox)item.FindControl("txt_hargaInsert");
                    txtdisc = (RadNumericTextBox)item.FindControl("txt_discInsert");
                    txtSubPrice = (RadNumericTextBox)item.FindControl("txt_sub_priceInsert");
                    txtCostCtr = (RadLabel)item.FindControl("lbl_cost_ctrInsert");
                    Tgl = (RadDatePicker)item.FindControl("dtpSroDateInsert");
                    txtFactor = (RadNumericTextBox)item.FindControl("txt_factorInsert");
                    ttax1= (CheckBox)item.FindControl("chkTax1Insert");
                    tOtax = (CheckBox)item.FindControl("chkOTaxInsert");
                    tpph = (CheckBox)item.FindControl("chkTpphInsert");

                    lbl_prodType.Text = "M1";
                    txtPartQty.Value = Convert.ToDouble(dtr["qty_out"].ToString());
                    lbl_UoM.Text = dtr["unit_code"].ToString();
                    txtPrice.Value= Convert.ToDouble(dtr["price"].ToString());
                    txtdisc.Value = Convert.ToDouble(dtr["disc"].ToString());
                    txtSubPrice.Value = Convert.ToDouble(dtr["price"].ToString()) * Convert.ToDouble(dtr["qty_out"].ToString());
                    txtCostCtr.Text = dtr["dept_code"].ToString();
                    Tgl.SelectedDate= Convert.ToDateTime(dtr["Tgl"].ToString());
                    txtFactor.Value = 0;
                    if(cb_tax1.Text != "NON")
                    {
                        ttax1.Checked = true;
                    }
                    if (cb_tax2.Text != "NON")
                    {
                        tOtax.Checked = true;
                    }
                    if (cb_tax3.Text != "NON")
                    {
                        tpph.Checked = true;
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
                foreach (GridDataItem item in this.RadGrid2.Items)
                {
                    CheckBox cTax1 = (CheckBox)item.FindControl("chkTax1Insert");
                    CheckBox cTax2 = (CheckBox)item.FindControl("chkOTaxInsert");
                    CheckBox cTax3 = (CheckBox)item.FindControl("chkTpphInsert");

                    if (cb_tax1.SelectedValue != "NON")
                    {
                        cTax1.Checked = true;
                        CalculateSubTotal(cTax1.Checked, cTax2.Checked, cTax3.Checked);
                    }
                    else
                    {
                        cTax1.Checked = false;
                        CalculateSubTotal(cTax1.Checked, cTax2.Checked, cTax3.Checked);
                    }
                }

                CalculateTotal();
            }
        }

        protected void cb_prod_code_editTemp_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "SELECT [prod_code], [prod_spec], [unit_code], [qty_out], [disc], [price], [do_code], [Tgl], [info_code], [dept_code] " +
                    "FROM [v_invoice_incoming_from_consigment] WHERE prod_code = '" + (sender as RadComboBox).SelectedValue + "'";

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                foreach (DataRow dtr in dt.Rows)
                {
                    RadComboBox cb = (RadComboBox)sender;
                    GridEditableItem item = (GridEditableItem)cb.NamingContainer;

                    //Label lblQtyRs;
                    RadLabel lbl_UoM;
                    RadLabel lbl_prodType;
                    RadNumericTextBox txtPartQty;
                    RadNumericTextBox txtPrice;
                    RadNumericTextBox txtdisc;
                    RadNumericTextBox txtSubPrice;
                    RadLabel txtCostCtr;
                    RadDatePicker Tgl;
                    RadNumericTextBox txtFactor;
                    CheckBox ttax1;
                    CheckBox tOtax;
                    CheckBox tpph;

                    lbl_prodType = (RadLabel)item.FindControl("lblProdTypeEdit");
                    txtPartQty = (RadNumericTextBox)item.FindControl("txt_qty_Edit");
                    lbl_UoM = (RadLabel)item.FindControl("lblUomEdit");
                    txtPrice = (RadNumericTextBox)item.FindControl("txt_hargaEdit");
                    txtdisc = (RadNumericTextBox)item.FindControl("txt_discEdit");
                    txtSubPrice = (RadNumericTextBox)item.FindControl("txt_sub_priceEdit");
                    txtCostCtr = (RadLabel)item.FindControl("lbl_cost_ctrEdit");
                    Tgl = (RadDatePicker)item.FindControl("dtpSroDateEdit");
                    txtFactor = (RadNumericTextBox)item.FindControl("txt_factorEdit");
                    ttax1 = (CheckBox)item.FindControl("chkTax1Edit");
                    tOtax = (CheckBox)item.FindControl("chkOTaxEdit");
                    tpph = (CheckBox)item.FindControl("chkTpphEdit");

                    lbl_prodType.Text = "M1";
                    txtPartQty.Value = Convert.ToDouble(dtr["qty_out"].ToString());
                    lbl_UoM.Text = dtr["unit_code"].ToString();
                    txtPrice.Value = Convert.ToDouble(dtr["price"].ToString());
                    txtdisc.Value = Convert.ToDouble(dtr["disc"].ToString());
                    txtSubPrice.Value = Convert.ToDouble(dtr["price"].ToString()) * Convert.ToDouble(dtr["qty_out"].ToString());
                    txtCostCtr.Text = dtr["dept_code"].ToString();
                    Tgl.SelectedDate = Convert.ToDateTime(dtr["Tgl"].ToString());
                    txtFactor.Value = 0;
                    if (cb_tax1.Text != "NON")
                    {
                        ttax1.Checked = true;
                    }
                    if (cb_tax2.Text != "NON")
                    {
                        tOtax.Checked = true;
                    }
                    if (cb_tax3.Text != "NON")
                    {
                        tpph.Checked = true;
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
                foreach (GridDataItem item in this.RadGrid2.Items)
                {
                    CheckBox cTax1 = (CheckBox)item.FindControl("chkTax1Edit");
                    CheckBox cTax2 = (CheckBox)item.FindControl("chkOTaxEdit");
                    CheckBox cTax3 = (CheckBox)item.FindControl("chkTpphEdit");

                    if (cb_tax1.SelectedValue != "NON")
                    {
                        cTax1.Checked = true;
                        CalculateSubTotal(cTax1.Checked, cTax2.Checked, cTax3.Checked);
                    }
                    else
                    {
                        cTax1.Checked = false;
                        CalculateSubTotal(cTax1.Checked, cTax2.Checked, cTax3.Checked);
                    }
                }

                CalculateTotal();
            }
        }

    }
}