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

namespace TelerikWebApplication.Form.Purchase.Purchase_order
{
    public partial class edit_form : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();
        DataTable dt = new DataTable();
        int doc_status = 0;
        private const int ItemsPerRequest = 10;

        private static string GetStatusMessage(int offset, int total)
        {
            if (total <= 0)
                return "No matches";

            return String.Format("Items <b>1</b>-<b>{0}</b> out of <b>{1}</b>", offset, total);
        }
        protected void RadAjaxManager1_AjaxRequest(object sender, AjaxRequestEventArgs e)
        {
            if (e.Argument == "Rebind")
            {
                RadGrid2.MasterTableView.SortExpressions.Clear();
                RadGrid2.MasterTableView.GroupByExpressions.Clear();
                RadGrid2.Rebind();
            }
            else if (e.Argument == "RebindAndNavigate")
            {
                RadGrid2.MasterTableView.SortExpressions.Clear();
                RadGrid2.MasterTableView.GroupByExpressions.Clear();
                RadGrid2.MasterTableView.CurrentPageIndex = RadGrid2.MasterTableView.PageCount - 1;
                RadGrid2.Rebind();
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Request.QueryString["po_code"] != null)
                {
                    get_po_head(Request.QueryString["po_code"]);
                }
                else
                {
                    txt_uid.Text = public_str.uid;
                    txt_owner.Text = public_str.uid;
                    txt_printed.Text = "0";
                    txt_edited.Text = "0";
                    txt_lastUpdate.Text = string.Format("{0:dd/MM/yyyy}", DateTime.Today);
                    txt_sub_total.Text = string.Format("{0:#,###0.00;-#,###0.00;0}", 0.ToString());
                    txt_tax1_value.Text = string.Format("{0:#,###0.00;-#,###0.00;0}", 0.ToString());
                    txt_tax2_value.Text = string.Format("{0:#,###0.00;-#,###0.00;0}", 0.ToString());
                    txt_tax3_value.Text = string.Format("{0:#,###0.00;-#,###0.00;0}", 0.ToString());
                    txt_other_value.Text = string.Format("{0:#,###0.00;-#,###0.00;0}", 0.ToString());
                    txt_total.Text = string.Format("{0:#,###0.00;-#,###0.00;0}", 0.ToString());
                    cb_po_status.Text = "OPEN";
                    cb_po_status.SelectedValue = "0";
                }
                get_po_det(Request.QueryString["po_code"]);
            }
            //else
            //{
            //    addPoDet(cb_reff.SelectedValue);
            //}
        }

        private void get_po_head(string po_no)
        {
            con.Open();
            SqlDataReader sdr;
            SqlCommand cmd = new SqlCommand("SELECT * FROM v_purchase_order WHERE po_code = '" + po_no + "'", con);
            sdr = cmd.ExecuteReader();
            //if (sdr.HasRows == false)
            //{
            //    throw new Exception();
            //}
            if (sdr.Read())
            {
                txt_po_number.Text = sdr["po_code"].ToString();
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
                txt_pr_date.Text = string.Format("{0:dd/MM/yyyy}", sdr["ref_date"].ToString());
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
                txt_pppn.Text = string.Format("{0:#,###0.00;-#,###0.00;0}", sdr["PPPN"].ToString());
                txt_ppph.Text = string.Format("{0:#,###0.00;-#,###0.00;0}", sdr["ppph"].ToString());
                txt_po_tax.Text = string.Format("{0:#,###0.00;-#,###0.00;0}", sdr["POTax"].ToString());
                //txt_tax1.Text = gv_po_header.CurrentRow.Cells["ppn"].Value.ToString();
                //txt_tax2.Text = gv_po_header.CurrentRow.Cells["OTax"].Value.ToString();
                //txt_tax3.Text = gv_po_header.CurrentRow.Cells["pph"].Value.ToString();
                txt_sub_total.Text = string.Format("{0:#,###0.00;-#,###0.00;0}", sdr["tot_amount"].ToString());
                txt_tax1_value.Text = string.Format("{0:#,###0.00;-#,###0.00;0}", sdr["jtax1"].ToString());
                txt_tax2_value.Text = string.Format("{0:#,###0.00;-#,###0.00;0}", sdr["jtax2"].ToString());
                txt_tax3_value.Text = string.Format("{0:#,###0.00;-#,###0.00;0}", sdr["jtax3"].ToString());
                txt_total.Text = string.Format("{0:#,###0.00;-#,###0.00;0}", sdr["Net"].ToString());
                txt_other_value.Text = string.Format("{0:#,###0.00;-#,###0.00;0}", sdr["Othercost"].ToString());
                cb_po_status.SelectedValue = sdr["doc_status"].ToString();
                if (sdr["doc_status"].ToString() == "0")
                {
                    cb_po_status.Text = "OPEN";
                }
                else if(sdr["doc_status"].ToString() == "1")
                {
                    cb_po_status.Text = "SHARED";
                }
                else if (sdr["doc_status"].ToString() == "2")
                {
                    cb_po_status.Text = "HOLD";
                }
            }
            con.Close();            
        }
        
        protected void btnStandard_Click(object sender, EventArgs e)
        {

            if (Page.IsPostBack) System.Threading.Thread.Sleep(3000);
        }
                
        private void get_po_det(string po_no)
        {           
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT prod_type, Prod_code, Spec, qty, SatQty, harga, Disc, ISNULL(tfactor,0) as tfactor, jumlah, tTax, tOtax, tpph, " +
                "dept_code, Prod_code_ori, twarranty, jTax1, jTax2, jTax3, nomer as nomor FROM tr_purchaseD WHERE po_code = '" + po_no + "'";
            cmd.CommandTimeout = 0;
            cmd.ExecuteNonQuery();
            sda = new SqlDataAdapter(cmd);

            DataTable DT = new DataTable();

            try
            {
                sda.Fill(DT);
                RadGrid2.DataSource = DT;
            }
            finally
            {
                con.Close();
            }
        }

        private void addPoDet(string pr_no)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT prod_type, Prod_code, Spec, qty, SatQty, 0 as harga,  dept_code, Prod_code_ori, twarranty, " +
                "nomer as nomor, no_ref FROM tr_purchase_reqD WHERE pr_code = '" + pr_no + "'";
            cmd.CommandTimeout = 0;
            cmd.ExecuteNonQuery();
            sda = new SqlDataAdapter(cmd);

            DataTable DT = new DataTable();

            try
            {
                sda.Fill(DT);
                RadGrid2.DataSource = DT;
            }
            finally
            {
                con.Close();
            }

            //return DT;
        }

        #region Purchase Type

        private static DataTable GetTrans(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT TransName, trans_code FROM ms_po_transaction WHERE stEdit <> '4' AND TransName LIKE @text + '%'",
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
            cmd.CommandText = "SELECT trans_code FROM ms_po_transaction WHERE TransName = '" + cb_po_type.Text + "'";
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
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT priority_code , prio_desc FROM ms_priority WHERE prio_desc LIKE @text + '%'",
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
            cmd.CommandText = "SELECT priority_code FROM ms_priority WHERE prio_desc = '" + cb_priority.Text + "'";
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
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT ShipMode, ShipModeName FROM ms_kirim WHERE ShipModeName LIKE @text + '%'",
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
            cmd.CommandText = "SELECT ShipMode FROM ms_kirim WHERE ShipModeName = '" + cb_ship_mode.Text + "'";
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
        protected void cb_supplier_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT supplier_code  FROM ms_supplier WHERE supplier_name = '" + cb_supplier.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_supplier.SelectedValue = dr["supplier_code"].ToString();
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
                txt_kurs.Text = string.Format("{0:#,###0.00;-#,###0.00;0}",dr["KursRun"].ToString());
                txt_tax_kurs.Text= string.Format("{0:#,###0.00;-#,###0.00;0}", dr["KursTax"].ToString());
                cb_tax1.Text= dr["tax1"].ToString();
                txt_pppn.Text= dr["p_tax1"].ToString();
                cb_tax2.Text = dr["tax2"].ToString();
                txt_po_tax.Text= dr["p_tax2"].ToString();
                cb_tax3.Text = dr["tax3"].ToString();
                txt_ppph.Text= dr["p_tax3"].ToString();
                cb_term.Text = dr["pay_term"].ToString();
                txt_term_days.Text = dr["JTempo"].ToString();
                txt_att_name.Text = dr["contact1"].ToString();                
            }

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
            cmd.CommandText = "SELECT TAX_PERC FROM  MS_TAX WHERE TAX_CODE = '" + tax_code + "'";
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
            cmd.CommandText = "SELECT TAX_CODE,TAX_PERC FROM  MS_TAX WHERE TAX_NAME = '" + cb_tax1.Text + "'";
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
            cmd.CommandText = "SELECT TAX_CODE,TAX_PERC FROM MS_TAX WHERE TAX_NAME = '" + cb_tax2.Text + "'";
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
            cmd.CommandText = "SELECT TAX_CODE,TAX_PERC FROM MS_TAX WHERE TAX_NAME = '" + cb_tax3.Text + "'";
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
                cb_project.Items.Add(new RadComboBoxItem(data.Rows[i]["region_name"].ToString(), data.Rows[i]["region_name"].ToString()));
            }
        }        
        protected void cb_project_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT region_code FROM ms_jobsite WHERE region_name = '" + cb_project.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_project.SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();

            cb_reff.Text = "";
            LoadReff(cb_project.SelectedValue);
        }
        protected void LoadProjects()
        {
            SqlConnection connection = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);

            SqlDataAdapter adapter = new SqlDataAdapter("SELECT region_code, region_name FROM ms_jobsite WHERE stEdit != 4 ORDER By region_name", connection);
            DataTable dt = new DataTable();
            adapter.Fill(dt);

            cb_project.DataTextField = "region_name";
            cb_project.DataValueField = "region_code";
            cb_project.DataSource = dt;
            cb_project.DataBind();
        }
        #endregion

        #region PO_Refference
        private static DataTable GetReff(string pr_code, string project)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT pr_code, pr_date, remark FROM v_purchase_request WHERE region_code = region_code  AND pr_code LIKE '%' + @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", pr_code);
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
            addPoDet(cb_reff.SelectedValue);
        }
       
        protected void LoadReffInfo(string code)
        {
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);

            SqlDataAdapter adapter = new SqlDataAdapter("SELECT CostCenterName,dept_code, pr_date, remark FROM v_purchase_request WHERE pr_code = @pr_code", con);
            adapter.SelectCommand.Parameters.AddWithValue("@pr_code", code);

            DataTable dt = new DataTable();
            adapter.Fill(dt);
            foreach (DataRow dr in dt.Rows)
            {
                txt_pr_date.Text = string.Format("{0:dd/MM/yyyy}", dr["Pr_date"].ToString());
                txt_remark.Text = dr["remark"].ToString();
                cb_cost_center.Text = dr["dept_code"].ToString();
            }
        }
        protected void LoadReff(string projectID)
        {
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);

            SqlDataAdapter adapter = new SqlDataAdapter("SELECT pr_code, pr_date, remark FROM v_purchase_request WHERE region_code = @project", con);
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
        private static DataTable GetManPower(string name, string project)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT upper(name) as name, nik, upper(jabatan) as jabatan " +
                "FROM ms_manpower WHERE stedit <> '4' AND region_code = '" + project + "' AND name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", name);

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
                cb_prepared.Items.Add(new RadComboBoxItem(data.Rows[i]["Name"].ToString(), data.Rows[i]["jabatan"].ToString()));
            }
        }
        protected void cb_prepared_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM ms_manpower WHERE name = '" + cb_prepared.Text + "'";
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
                cb_verified.Items.Add(new RadComboBoxItem(data.Rows[i]["Name"].ToString(), data.Rows[i]["jabatan"].ToString()));
            }
        }
        protected void cb_verified_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM ms_manpower WHERE name = '" + cb_verified.Text + "'";
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
            cmd.CommandText = "SELECT nik FROM ms_manpower WHERE name = '" + cb_approved.Text + "'";
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

    }
}