using System;
using System.Collections.Generic;
using System.ComponentModel;
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
    public partial class po_std_data_entry : System.Web.UI.UserControl
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();
        private const int ItemsPerRequest = 10;


        public static string tax_check = null;
        public static string oTax_check = null;
        public static string pph_check = null;
        public static string tax1 = null;
        public static string tax2 = null;
        public static string tax3 = null;

        private static bool isOverBgt = false;

        public static string account_code = null;
        //public static double budget_rem = 0;
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
                if (Request.QueryString["po_code"] != null)
                {
                    fill_object(Request.QueryString["po_code"].ToString());
                    RadGrid2.DataSource = GetDataDetailTable(txt_po_code.Text);
                    RadGrid2.DataBind();
                    Session["actionEdit"] = "edit";
                    RadGrid2.Enabled = true;
                    //btn_edit_item.Enabled = true;
                }
                else
                {
                    Session["actionEdit"] = "new";

                    dtp_po.SelectedDate = DateTime.Now;
                    dtp_exp.SelectedDate = DateTime.Now;
                    dtp_etd.SelectedDate = DateTime.Now;

                    cb_priority.SelectedValue = "1";
                    cb_priority.Text = "High/Urgent";
                    cb_po_type.SelectedValue = "INV";
                    cb_po_type.Text = "Inventory";
                    cb_project.SelectedValue = public_str.site;
                    cb_project.Text = public_str.sitename;
                    cb_tax1.Text = "NON";
                    cb_tax2.Text = "NON";
                    cb_tax3.Text = "NON";

                    txt_uid.Text = public_str.user_id;
                    txt_owner.Text = public_str.user_id;
                    txt_lastUpdate.Text = string.Format("{0:dd/MM/yyyy}", DateTime.Now);
                    txt_printed.Text = "0";
                    txt_edited.Text = "0";
                    txt_sub_total.Value = 0;
                    txt_tax1_value.Value = 0;
                    txt_tax2_value.Value = 0;
                    txt_tax3_value.Value = 0;
                    txt_other_value.Value = 0;
                    txt_total.Value = 0;
                    cb_po_status.Text = "OPEN";
                    cb_po_status.SelectedValue = "0";
                    dtp_share_date.Enabled = false;
                    //chk_overhoul.Enabled = true;
                }
            }
        }

        protected void fill_object(string id)
        {
            con.Open();
            SqlDataReader sdr;
            SqlCommand cmd = new SqlCommand("SELECT a.*, b.unit_code FROM v_purchase_order a LEFT OUTER JOIN pur01h01 b ON " +
                "a.no_ref=b.pr_code WHERE a.po_code =  '" + id + "'", con);
            sdr = cmd.ExecuteReader();
            if (sdr.Read())
            {
                txt_po_code.Text = sdr["po_code"].ToString();
                dtp_po.SelectedDate = Convert.ToDateTime(sdr["Po_date"].ToString());
                dtp_exp.SelectedDate = Convert.ToDateTime(sdr["exp_date"].ToString());
                cb_reff.Text = sdr["no_ref"].ToString();
                cb_po_type.Text = sdr["TransName"].ToString();
                cb_po_type.SelectedValue = sdr["trans_code"].ToString();
                cb_priority.Text = sdr["prio_desc"].ToString();
                dtp_etd.SelectedDate = Convert.ToDateTime(sdr["etd"].ToString());
                cb_ship_mode.Text = sdr["ShipMode"].ToString();
                cb_supplier.Text = sdr["vendor_name"].ToString();
                txt_curr.Text = sdr["cur_code"].ToString();
                txt_kurs.Value = Convert.ToDouble(sdr["kurs"].ToString());
                txt_tax_kurs.Value = Convert.ToDouble(sdr["kurs_tax"].ToString());
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
                DateTime ref_date = Convert.ToDateTime(sdr["ref_date"].ToString());
                txt_pr_date.Text = ref_date.ToString("dd/MM/yyyy");
                txt_remark.Text = sdr["Remark"].ToString();
                txt_term_days.Value = Convert.ToDouble(sdr["JTempo"].ToString());
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
                txt_att_name.Text = sdr["attname"].ToString();

                if (Convert.ToDouble(sdr["Net"]) < 50000000)
                {
                    lbl_verify2.Text = "Approved By";
                    lbl_approved.Text = "";
                    cb_approved.Visible = false;

                    cb_prepared.SelectedValue = sdr["FreBy"].ToString();
                    cb_verified.SelectedValue = sdr["OrdBy"].ToString();
                    cb_verified2.SelectedValue = sdr["AppBy"].ToString();
                    cb_prepared.Text = sdr["Prepare_by"].ToString();
                    cb_verified.Text = sdr["Order_by"].ToString();
                    cb_verified2.Text = sdr["Approve_by"].ToString();
                }
                else
                {
                    lbl_verify2.Text = "";
                    lbl_approved.Text = "Approved By";
                    cb_verified2.Visible = true;
                    cb_approved.Visible = true;

                    cb_prepared.SelectedValue = sdr["FreBy"].ToString();
                    cb_verified.SelectedValue = sdr["OrdBy"].ToString();
                    cb_verified2.SelectedValue = sdr["OrdBy2"].ToString();
                    cb_approved.SelectedValue = sdr["AppBy"].ToString();
                    cb_prepared.Text = sdr["Prepare_by"].ToString();
                    cb_verified.Text = sdr["Order_by"].ToString();
                    cb_verified2.Text = sdr["Order_by2"].ToString();
                    cb_approved.Text = sdr["Approve_by"].ToString();
                }
                chk_overhoul.Checked = Convert.ToBoolean(sdr["overhaul"].ToString());

                if (sdr["status_pur"].ToString() == "1")
                {
                    btn_prepare_checked.Visible = true;
                    cb_prepared.Enabled = false;
                }
                if (sdr["status_pur"].ToString() == "2")
                {
                    btn_prepare_checked.Visible = true;
                    cb_prepared.Enabled = false;
                    btn_verified_checked.Visible = true;
                    cb_verified.Enabled = false;
                }
                if (sdr["status_pur"].ToString() == "2" && sdr["OrdBy_chk"].ToString() == "1")
                {
                    btn_prepare_checked.Visible = true;
                    cb_prepared.Enabled = false;
                    btn_verified_checked.Visible = true;
                    cb_verified.Enabled = false;
                    btn_verified2_checked.Visible = true;
                    cb_verified2.Enabled = false;
                }
                if (sdr["status_pur"].ToString() == "3" && sdr["OrdBy_chk"].ToString() != "1")
                {
                    btn_prepare_checked.Visible = true;
                    cb_prepared.Enabled = false;
                    btn_verified_checked.Visible = true;
                    cb_verified.Enabled = false;
                    btn_verified2_checked.Visible = true;
                    cb_verified2.Enabled = false;
                }
            }
            con.Close();
        }

        #region Detail
        public DataTable GetDataDetailTable(string po_code)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT po_code, prod_type, Prod_code, Spec, qty, SatQty, harga, Disc, ISNULL(tfactor,0) as factor, " +
                "jumlah, CAST(tTax AS Bit) AS tTax, CAST(tOtax AS Bit) AS tOtax, CAST(tpph AS Bit) AS tpph, " +
                "dept_code, Prod_code_ori, twarranty, jTax1, jTax2, jTax3, nomer as nomor, '' as account_code, 0 as budget_rem " +
                "FROM pur01d02 WHERE po_code = '" + po_code + "'";
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
        protected void RadGrid2_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadGrid).MasterTableView.Items.Count < (sender as RadGrid).MasterTableView.PageSize)
            {
                (sender as RadGrid).ClientSettings.Scrolling.AllowScroll = false;
                (sender as RadGrid).ClientSettings.Scrolling.UseStaticHeaders = false;
            }
            else
            {
                (sender as RadGrid).ClientSettings.Scrolling.AllowScroll = true;
                (sender as RadGrid).ClientSettings.Scrolling.UseStaticHeaders = true;
                (sender as RadGrid).ClientSettings.Scrolling.ScrollHeight = 270;
            }
        }
        protected void RadGrid2_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            if (!IsPostBack)
            {
                (sender as RadGrid).DataSource = new string[] { };
            }
            else if (Session["actionEdit"].ToString() == "new")
            {
                (sender as RadGrid).DataSource = new string[] { };
                (sender as RadGrid).DataSource = GetDataRefDetailTable(cb_reff.Text, cb_project.SelectedValue, "");
            }
            else if (Session["actionEdit"].ToString() == "edit")
            {
                (sender as RadGrid).DataSource = new string[] { };
                (sender as RadGrid).DataSource = GetDataRefDetailTable(cb_reff.Text, cb_project.SelectedValue, cb_supplier.SelectedValue);

            }
        }
        #endregion

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
        protected void cb_priority_PreRender(object sender, EventArgs e)
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
        protected void cb_ship_mode_PreRender(object sender, EventArgs e)
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
            cmd.CommandText = "SELECT     a.supplier_code,e.KursRun, e.KursTax, a.cur_code, b.TAX_NAME as TAX1_NAME, c.TAX_NAME AS TAX2_NAME, d.TAX_NAME AS TAX3_NAME, a.ppn, a.OTax, a.pph " +
                               " FROM ms_supplier a LEFT OUTER JOIN acc00h05 AS b ON b.TAX_CODE = a.ppn LEFT OUTER JOIN acc00h05 AS c ON a.OTax = c.TAX_CODE LEFT OUTER JOIN " +
                               " acc00h05 AS d ON a.pph = d.TAX_CODE inner join acc00h04 e on a.cur_code = e.cur_code WHERE (e.tglKurs = (SELECT     MAX(tglKurs) AS Expr1 " +
                               " FROM acc00h04)) and a.supplier_name = '" + cb_supplier.Text + "'";
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
                cb_tax1.Text = dr["TAX1_NAME"].ToString();
                cb_tax2.Text = dr["TAX2_NAME"].ToString();
                cb_tax3.Text = dr["TAX3_NAME"].ToString();
            }

            dr.Close();
            con.Close();

            get_supp_info(cb_supplier.SelectedValue);
        }
        protected void cb_supplier_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT a.supplier_code FROM ms_supplier a WHERE a.supplier_name = '" + cb_supplier.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            }

            dr.Close();
            con.Close();
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
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT ms_supplier.supplier_name, ms_supplier.supplier_code, ms_supplier.KoGSup, ms_supplier.contact1, ms_supplier.contact2, ISNULL(acc00h05.TAX_NAME,'NON') AS tax1, " +
            "ISNULL(acc00h05_1.TAX_NAME, 'NON') AS tax2, ISNULL(acc00h05_2.TAX_NAME, 'NON') AS tax3, ms_supplier.cur_code, ms_supplier.pay_code, " +
            "CASE ms_supplier.pay_code WHEN '01' THEN 'Cash' WHEN '02' THEN 'Credit' ELSE 'COD' END AS pay_term, ms_supplier.JTempo, acc00h04.KursRun, " +
            "acc00h04.KursTax, ms_supplier.ppn AS tax1_code, ms_supplier.OTax AS tax2_code, ms_supplier.pph AS tax3_code, " +
            "ISNULL(acc00h05.TAX_PERC, 0) AS p_tax1, ISNULL(acc00h05_1.TAX_PERC, 0) AS p_tax2, ISNULL(acc00h05_2.TAX_PERC, 0) AS p_tax3 " +
            "FROM ms_supplier LEFT OUTER JOIN acc00h05 ON ms_supplier.ppn = acc00h05.TAX_CODE LEFT OUTER JOIN acc00h05 AS acc00h05_1 ON ms_supplier.OTax = acc00h05_1.TAX_CODE LEFT OUTER JOIN " +
            "acc00h05 AS acc00h05_2 ON ms_supplier.pph = acc00h05_2.TAX_CODE LEFT OUTER JOIN acc00h04 ON ms_supplier.cur_code = acc00h04.cur_code " +
            "WHERE(ms_supplier.stEdit <> 4) AND(acc00h04.tglKurs = (SELECT MAX(tglKurs) AS Expr1 FROM acc00h04 AS acc00h04_1)) AND ms_supplier.supplier_code = @supplier_code", con);
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
            cmd.CommandText = "SELECT TAX_CODE,TAX_PERC FROM  acc00h05 WHERE TAX_NAME = '" + cb_tax1.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                cb_tax1.SelectedValue = dr["TAX_CODE"].ToString();
            }

            dr.Close();
            con.Close();

            get_tax_perc(cb_tax1.SelectedValue, txt_pppn);

            foreach (GridDataItem item in this.RadGrid2.Items)
            {
                CheckBox cTax1 = (CheckBox)item.FindControl("edt_chkTax1");
                CheckBox cTax2 = (CheckBox)item.FindControl("edt_chkOTax");
                CheckBox cTax3 = (CheckBox)item.FindControl("edt_chkTpph");

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
            cmd.CommandText = "SELECT TAX_CODE,ISNULL(TAX_PERC,0) AS TAX_PERC FROM  acc00h05 WHERE TAX_NAME = '" + cb_tax1.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                cb_tax1.SelectedValue = dr["TAX_CODE"].ToString();
                txt_pppn.Value = Convert.ToDouble(dr["TAX_PERC"].ToString());
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
            cmd.CommandText = "SELECT TAX_CODE,ISNULL(TAX_PERC,0) AS TAX_PERC FROM acc00h05 WHERE TAX_NAME = '" + cb_tax2.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                cb_tax2.SelectedValue = dr[0].ToString();
                txt_po_tax.Value = Convert.ToDouble(dr["TAX_PERC"].ToString());
            }
            dr.Close();
            con.Close();

            get_tax_perc(cb_tax2.SelectedValue, txt_po_tax);

            foreach (GridDataItem item in this.RadGrid2.Items)
            {
                CheckBox cTax1 = (CheckBox)item.FindControl("edt_chkTax1");
                CheckBox cTax2 = (CheckBox)item.FindControl("edt_chkOTax");
                CheckBox cTax3 = (CheckBox)item.FindControl("edt_chkTpph");

                if (cb_tax2.SelectedValue != "NON")
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
        protected void cb_tax2_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT TAX_CODE,ISNULL(TAX_PERC,0) AS TAX_PERC FROM  acc00h05 WHERE TAX_NAME = '" + cb_tax2.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                cb_tax1.SelectedValue = dr["TAX_CODE"].ToString();
                txt_po_tax.Value = Convert.ToDouble(dr["TAX_PERC"].ToString());
            }

            dr.Close();
            con.Close();
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
            cmd.CommandText = "SELECT TAX_CODE,ISNULL(TAX_PERC,0) AS TAX_PERC FROM acc00h05 WHERE TAX_NAME = '" + cb_tax3.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                cb_tax3.SelectedValue = dr[0].ToString();
                txt_ppph.Value = Convert.ToDouble(dr["TAX_PERC"].ToString());
            }
            //txt_ppph.Text = dr["TAX_PERC"].ToString();
            dr.Close();
            con.Close();

            get_tax_perc(cb_tax3.SelectedValue, txt_ppph);

            foreach (GridDataItem item in this.RadGrid2.Items)
            {
                CheckBox cTax1 = (CheckBox)item.FindControl("edt_chkTax1");
                CheckBox cTax2 = (CheckBox)item.FindControl("edt_chkOTax");
                CheckBox cTax3 = (CheckBox)item.FindControl("edt_chkTpph");

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
        protected void cb_tax3_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT TAX_CODE,ISNULL(TAX_PERC,0) AS TAX_PERC FROM  acc00h05 WHERE TAX_NAME = '" + cb_tax3.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                cb_tax1.SelectedValue = dr["TAX_CODE"].ToString();
                txt_ppph.Value = Convert.ToDouble(dr["TAX_PERC"].ToString());
            }

            dr.Close();
            con.Close();
        }
        protected void edt_chkTax1_CheckedChanged(object sender, EventArgs e)
        {
            try
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
            finally
            {
                CalculateTotal();
            }
        }

        protected void edt_chkOTax_CheckedChanged(object sender, EventArgs e)
        {
            try
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
            finally
            {
                CalculateTotal();

            }
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
            //double amount = 0;
            //CheckBox ckb = (CheckBox)sender;
            //GridEditableItem item = (GridEditableItem)ckb.NamingContainer;
            //RadNumericTextBox txt_sub_price = (RadNumericTextBox)item.FindControl("txt_sub_price");
            //amount = (Convert.ToDouble(txt_sub_price.Value));
            if ((sender as CheckBox).Checked == true)
            {
                pph_check = "1";
                //txt_tax1_value.Value = (Convert.ToDouble(txt_tax1_value.Value) + (Convert.ToDouble(txt_pppn.Value) / 100) * amount);
            }
            else
            {
                pph_check = "0";
                //txt_tax1_value.Value = (Convert.ToDouble(txt_tax1_value.Value) - (Convert.ToDouble(txt_pppn.Value) / 100) * amount);
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

        #region PO_Refference

        protected void LoadRef(string pr_code, string project, RadComboBox cb)
        {
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);

            SqlDataAdapter adapter = new SqlDataAdapter("SELECT top 10 pr_code, Pr_date, remark FROM v_purchase_order_reff WHERE region_code = @region_code " +
                "AND pr_code LIKE @text + '%' ORDER BY pr_code",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", pr_code);
            adapter.SelectCommand.Parameters.AddWithValue("@region_code", project);
            DataTable dt = new DataTable();
            adapter.Fill(dt);

            cb.DataTextField = "pr_code";
            cb.DataValueField = "pr_code";
            cb.DataSource = dt;
            cb.DataBind();
        }
        protected void cb_reff_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            if (Session["actionEdit"].ToString() == "new")
            {
                LoadRef(e.Text, cb_project.SelectedValue, (sender as RadComboBox));
            }

            //DataTable data = GetReff(e.Text, cb_project.SelectedValue);

            //int itemOffset = e.NumberOfItems;
            //int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            //e.EndOfItems = endOffset == data.Rows.Count;

            //for (int i = itemOffset; i < endOffset; i++)
            //{
            //    cb_reff.Items.Add(new RadComboBoxItem(data.Rows[i]["pr_code"].ToString(), data.Rows[i]["pr_code"].ToString()));
            //}

            //e.Message = GetStatusMessage(endOffset, data.Rows.Count);
        }
        protected void cb_reff_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            //con.Open();
            //SqlCommand cmd = new SqlCommand();
            //cmd.Connection = con;
            //cmd.CommandType = CommandType.Text;
            //cmd.CommandText = "select * from v_purchase_request where pr_code = '" + cb_reff.Text + "'";
            //SqlDataReader dr;
            //dr = cmd.ExecuteReader();
            //while (dr.Read())
            //    cb_reff.SelectedValue = dr["pr_code"].ToString();
            //dr.Close();
            //con.Close();

            //LoadReffInfo(cb_reff.SelectedValue);
            ////addPoDet(cb_reff.SelectedValue);

            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select * from v_purchase_order_reff where pr_code = '" + (sender as RadComboBox).SelectedValue + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).Text = dr["pr_code"].ToString();
                cb_cost_center.SelectedValue = dr["dept_code"].ToString();
                cb_cost_center.Text = dr["CostCenterName"].ToString();
                txt_remark.Text = dr["remark"].ToString();
                txt_pr_date.Text = dr["Pr_date"].ToString();
            }

            //dr.Close();
            con.Close();

            RadGrid2.DataSource = GetDataRefDetailTable((sender as RadComboBox).SelectedValue, cb_project.SelectedValue, cb_supplier.SelectedValue);
            RadGrid2.DataBind();

            txt_sub_total.Value = 0;
            txt_tax1_value.Value = 0;
            txt_tax2_value.Value = 0;
            txt_tax3_value.Value = 0;
            txt_total.Value = 0;

        }
        //protected void cb_reff_PreRender(object sender, EventArgs e)
        //{
        //    con.Open();
        //    SqlCommand cmd = new SqlCommand();
        //    cmd.Connection = con;
        //    cmd.CommandType = CommandType.Text;
        //    cmd.CommandText = "select * from v_purchase_order_reff where pr_code = '" + (sender as RadComboBox).SelectedValue + "'";
        //    SqlDataReader dr;
        //    dr = cmd.ExecuteReader();
        //    while (dr.Read())
        //    {
        //        (sender as RadComboBox).SelectedValue = dr["pr_code"].ToString();
        //    }
        //}
        public DataTable GetDataRefDetailTable(string pr_code, string project_code, string supplier_code)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_purchase_order_reffD";
            cmd.Parameters.AddWithValue("@pr_code", pr_code);
            cmd.Parameters.AddWithValue("@region_code", project_code);
            cmd.Parameters.AddWithValue("@supplier_code", supplier_code);
            cmd.Parameters.AddWithValue("@tax1", cb_tax1.Text);
            cmd.Parameters.AddWithValue("@tax2", cb_tax2.Text);
            cmd.Parameters.AddWithValue("@tax3", cb_tax3.Text);
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
        protected void cb_prepared_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadManPower(e.Text, cb_project.SelectedValue, (sender as RadComboBox));
        }
        protected void cb_prepared_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
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
        protected void ccb_prepared_PreRender(object sender, EventArgs e)
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

        protected void cb_verified_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
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
        protected void cb_verified_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
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

        protected void cb_approved_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadManPower(e.Text, cb_project.SelectedValue, (sender as RadComboBox));
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
            get_doc_status((sender as RadComboBox).Text);

            if ((sender as RadComboBox).SelectedValue == "1")
            {
                dtp_share_date.Enabled = true;
            }
        }

        protected void cb_po_status_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            cb_po_status.Items.Add("OPEN");
            cb_po_status.Items.Add("SHARED");
            cb_po_status.Items.Add("HOLD");
        }
        #endregion


        protected void calculate_sub_price(object sender, EventArgs e)
        {
            try
            {
                RadNumericTextBox ntb = (RadNumericTextBox)sender;
                GridEditableItem item = (GridEditableItem)ntb.NamingContainer;

                RadNumericTextBox txt_qty = (RadNumericTextBox)item.FindControl("txt_qty");
                RadNumericTextBox txt_harga = (RadNumericTextBox)item.FindControl("txt_harga");
                RadNumericTextBox txt_disc = (RadNumericTextBox)item.FindControl("txt_disc");
                RadNumericTextBox txt_factor = (RadNumericTextBox)item.FindControl("txt_factor");
                RadNumericTextBox txt_sub_price = (RadNumericTextBox)item.FindControl("txt_sub_price");
                CheckBox chkTax1 = (CheckBox)item.FindControl("edt_chkTax1");
                CheckBox chkTax2 = (CheckBox)item.FindControl("edt_chkOTax");
                CheckBox chkTax3 = (CheckBox)item.FindControl("edt_chkTpph");
                Label lbl_account_code = (Label)item.FindControl("lbl_account_code");

                account_code = lbl_account_code.Text;
                txt_sub_price.Value = (Convert.ToDouble(txt_harga.Value) * Convert.ToDouble(txt_qty.Value)) - (Convert.ToDouble(txt_harga.Value) * Convert.ToDouble(txt_qty.Value) * txt_disc.Value / 100) + (txt_factor.Value);

                CalculateSubTotal(chkTax1.Checked, chkTax2.Checked, chkTax3.Checked);
                txt_sub_price.Text = txt_sub_price.Value.ToString();
                budget_check(account_code);
                //CalculateSubTotal();
                //CalculateTotal();
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

        private void budget_check(string account)
        {
            double subTotalPerAccount = 0;
            double budget_rem = 0;

            foreach (GridDataItem item in RadGrid2.Items)
            {
                Label lbl_account_code = (Label)item.FindControl("lbl_account_code");
                Label lbl_budget_rem = (Label)item.FindControl("lbl_budget_rem");
                RadNumericTextBox txt_sub_price = (RadNumericTextBox)item.FindControl("txt_sub_price");
                if (lbl_account_code.Text == account)
                {
                    subTotalPerAccount = subTotalPerAccount + Convert.ToDouble(txt_sub_price.Value);
                    budget_rem = Convert.ToDouble(lbl_budget_rem.Text);
                    budget_rem = budget_rem - subTotalPerAccount;


                }
            }

            if (budget_rem < 0)
            {
                string text;
                text = "your purchase exceeds the specified budget value";
                RadGrid2.Controls.Add(new LiteralControl(string.Format("<span style='color:red'>{0}</span>", text)));
                isOverBgt = true;
            }
            else
            {
                RadGrid2.Controls.Add(new LiteralControl(string.Format("<span style='color:red'>{0}</span>", DBNull.Value)));
                isOverBgt = false;
            }
        }
        private void CalculateSubTotal(bool tax1, bool tax2, bool tax3)
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
                    //amount = (RadNumericTextBox)item.Item("txt_sub_price").Controls(1).Value;
                    RadNumericTextBox txt_sub_price = (RadNumericTextBox)item.FindControl("txt_sub_price");
                    amount = (Convert.ToDouble(txt_sub_price.Value));

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
            try
            {
                //double amount = 0;
                double sum = 0;

                sum = (Convert.ToDouble(txt_sub_total.Value)) + (Convert.ToDouble(txt_tax1_value.Value)) +
                    (Convert.ToDouble(txt_tax2_value.Value)) + (Convert.ToDouble(txt_tax3_value.Value)) +
                    (Convert.ToDouble(txt_other_value.Value));

                txt_total.Text = sum.ToString();

                if (sum >= 50000000)
                {
                    lbl_verify2.Visible = false;
                    lbl_approved.Text = "Approved By";
                    lbl_verify2.Text = "";
                    cb_approved.Visible = true;
                }
                else
                {
                    lbl_verify2.Text = "Approved By";
                    lbl_approved.Text = "";
                    lbl_approved.Visible = false;
                    cb_approved.Visible = false;
                }
            }
            catch (Exception)
            {

            }


        }

        protected void btn_save_Click(object sender, EventArgs e)
        {
            long maxNo;
            string run = null;
            string trDate = string.Format("{0:dd/MM/yyyy}", dtp_po.SelectedDate);

            try
            {
                if (isOverBgt)
                {
                    RadWindowManager2.RadAlert("", 500, 200, "Error", "callBackFn", "~/Images/error.png");
                    return;
                }
                else
                {
                    if (Session["actionEdit"].ToString() != "new")
                    {
                        run = txt_po_code.Text;
                    }
                    else
                    {
                        con.Open();
                        SqlDataReader sdr;
                        cmd = new SqlCommand("SELECT ISNULL ( MAX ( RIGHT ( pur01h02.po_code , 4 ) ) , 0 ) + 1 AS maxNo " +
                            "FROM pur01h02 WHERE LEFT(pur01h02.po_code, 4) = 'PO01' " +
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
                            run = "PO01" + (dtp_po.SelectedDate.Value.Year.ToString()).Substring(dtp_po.SelectedDate.Value.Year.ToString().Length - 2) +
                                ("0000" + dtp_po.SelectedDate.Value.Month).Substring(("0000" + dtp_po.SelectedDate.Value.Month).Length - 2, 2) +
                                ("0000" + maxNo).Substring(("0000" + maxNo).Length - 4, 4);
                        }
                        con.Close();
                    }


                    con.Open();
                    cmd = new SqlCommand();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Connection = con;
                    cmd.CommandText = "sp_save_purchase_orderH";
                    cmd.Parameters.AddWithValue("@po_code", run);
                    cmd.Parameters.AddWithValue("@Po_date", string.Format("{0:yyyy-MM-dd}", dtp_po.SelectedDate.Value));
                    cmd.Parameters.AddWithValue("@exp_date", string.Format("{0:yyyy-MM-dd}", dtp_exp.SelectedDate.Value));
                    cmd.Parameters.AddWithValue("@trans_code", cb_po_type.SelectedValue);
                    cmd.Parameters.AddWithValue("@priority_code", cb_priority.SelectedValue);
                    cmd.Parameters.AddWithValue("@etd", string.Format("{0:yyyy-MM-dd}", dtp_etd.SelectedDate.Value));
                    cmd.Parameters.AddWithValue("@ShipModeEtd", cb_ship_mode.SelectedValue);
                    cmd.Parameters.AddWithValue("@ppn", cb_tax1.SelectedValue);
                    cmd.Parameters.AddWithValue("@PPNIncl", chk_ppn_incl.Checked);
                    cmd.Parameters.AddWithValue("@kurs", Convert.ToDouble(txt_kurs.Value));
                    cmd.Parameters.AddWithValue("@kurs_tax", Convert.ToDouble(txt_tax_kurs.Value));
                    cmd.Parameters.AddWithValue("@pay_code", cb_term.SelectedValue);
                    cmd.Parameters.AddWithValue("@JTempo", Convert.ToDouble(txt_term_days.Value));
                    cmd.Parameters.AddWithValue("@attname", txt_att_name.Text);
                    cmd.Parameters.AddWithValue("@remark", txt_remark.Text);
                    cmd.Parameters.AddWithValue("@vendor_code", cb_supplier.SelectedValue);
                    cmd.Parameters.AddWithValue("@vendor_name", cb_supplier.Text);
                    cmd.Parameters.AddWithValue("@cur_code", txt_curr.Text);
                    cmd.Parameters.AddWithValue("@tot_amount", Convert.ToDouble(txt_sub_total.Value));
                    cmd.Parameters.AddWithValue("@PPPN", Convert.ToDouble(txt_pppn.Value));
                    cmd.Parameters.AddWithValue("@userid", public_str.user_id);
                    cmd.Parameters.AddWithValue("@JPPN", Convert.ToDouble(txt_tax1_value.Value));
                    cmd.Parameters.AddWithValue("@OTaxIncl", 0);
                    cmd.Parameters.AddWithValue("@JOTax", Convert.ToDouble(txt_tax2_value.Value));
                    cmd.Parameters.AddWithValue("@Net", Convert.ToDouble(txt_total.Value));
                    cmd.Parameters.AddWithValue("@Freight", 0);
                    cmd.Parameters.AddWithValue("@Othercost", Convert.ToDouble(txt_other_value.Value));
                    cmd.Parameters.AddWithValue("@Ass", 0);
                    cmd.Parameters.AddWithValue("@DP", 0);
                    cmd.Parameters.AddWithValue("@OTax", cb_tax2.SelectedValue);
                    cmd.Parameters.AddWithValue("@PlantCode", cb_project.SelectedValue);
                    cmd.Parameters.AddWithValue("@dept_code", cb_cost_center.SelectedValue);
                    cmd.Parameters.AddWithValue("@no_ref", cb_reff.Text);
                    cmd.Parameters.AddWithValue("@ref_date", Convert.ToDateTime(txt_pr_date.Text));
                    cmd.Parameters.AddWithValue("@pph", cb_tax3.SelectedValue);
                    cmd.Parameters.AddWithValue("@pphIncl", 0);
                    cmd.Parameters.AddWithValue("@Jpph", Convert.ToDouble(txt_tax3_value.Value));
                    cmd.Parameters.AddWithValue("@Owner", txt_owner.Text);
                    cmd.Parameters.AddWithValue("@OwnStamp", string.Format("{0:yyyy-MM-dd}", DateTime.Now));
                    cmd.Parameters.AddWithValue("@doc_type", 1);
                    cmd.Parameters.AddWithValue("@tFullSupply", 0);
                    cmd.Parameters.AddWithValue("@tMonOrder", 0);
                    cmd.Parameters.AddWithValue("@doc_status", cb_priority.SelectedValue);
                    cmd.Parameters.AddWithValue("@deliv_address", DBNull.Value);
                    if (dtp_share_date.SelectedDate != null)
                    {
                        cmd.Parameters.AddWithValue("@share_date", string.Format("{0:yyyy-MM-dd}", dtp_share_date.SelectedDate.Value));
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@share_date", DBNull.Value);
                    }
                    cmd.Parameters.AddWithValue("@valid_period", 0);
                    cmd.Parameters.AddWithValue("@ppph", Convert.ToDouble(txt_ppph.Value));
                    cmd.Parameters.AddWithValue("@poTax", Convert.ToDouble(txt_po_tax.Value));
                    cmd.Parameters.AddWithValue("@overhaul", chk_overhoul.Checked);
                    if (txt_total.Value < 50000000)
                    {
                        cmd.Parameters.AddWithValue("@FreBy", cb_prepared.SelectedValue);
                        cmd.Parameters.AddWithValue("@OrdBy", cb_verified.SelectedValue);
                        cmd.Parameters.AddWithValue("@OrdBy2", DBNull.Value);
                        cmd.Parameters.AddWithValue("@AppBy", cb_verified2.SelectedValue);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@FreBy", cb_prepared.SelectedValue);
                        cmd.Parameters.AddWithValue("@OrdBy", cb_verified.SelectedValue);
                        cmd.Parameters.AddWithValue("@OrdBy2", cb_verified2.SelectedValue);
                        cmd.Parameters.AddWithValue("@AppBy", cb_approved.SelectedValue);
                    }

                    cmd.ExecuteNonQuery();


                    foreach (GridEditableItem item in RadGrid2.MasterTableView.Items)
                    {
                        cmd = new SqlCommand();
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Connection = con;
                        cmd.CommandText = "sp_save_purchase_orderD";
                        cmd.Parameters.AddWithValue("@po_code", run);
                        cmd.Parameters.AddWithValue("@prod_type", (item.FindControl("lblProdType") as Label).Text);
                        cmd.Parameters.AddWithValue("@Prod_code", (item.FindControl("lblProdCode") as Label).Text);
                        cmd.Parameters.AddWithValue("@qty", Convert.ToDouble((item.FindControl("txt_qty") as RadNumericTextBox).Value));
                        cmd.Parameters.AddWithValue("@SatQty", (item.FindControl("cb_uom_d") as RadComboBox).Text);
                        cmd.Parameters.AddWithValue("@harga2", Convert.ToDouble((item.FindControl("txt_harga") as RadNumericTextBox).Value));
                        cmd.Parameters.AddWithValue("@Disc", Convert.ToDouble((item.FindControl("txt_disc") as RadNumericTextBox).Value));
                        if ((item.FindControl("edt_chkTax1") as CheckBox).Checked == true)
                        {
                            cmd.Parameters.AddWithValue("@tTax", 1);
                        }
                        else
                        {
                            cmd.Parameters.AddWithValue("@tTax", 0);
                        }
                        if ((item.FindControl("edt_chkOTax") as CheckBox).Checked == true)
                        {
                            cmd.Parameters.AddWithValue("@tOTax", 1);
                        }
                        else
                        {
                            cmd.Parameters.AddWithValue("@tOTax", 0);
                        }
                        if ((item.FindControl("edt_chkTpph") as CheckBox).Checked == true)
                        {
                            cmd.Parameters.AddWithValue("@tpph", 1);
                        }
                        else
                        {
                            cmd.Parameters.AddWithValue("@tpph", 0);
                        }
                        cmd.Parameters.AddWithValue("@harga", Convert.ToDouble((item.FindControl("txt_harga") as RadNumericTextBox).Value));
                        cmd.Parameters.AddWithValue("@Prod_code_ori", (item.FindControl("lbl_Prod_code_ori") as Label).Text);
                        cmd.Parameters.AddWithValue("@dept_code", (item.FindControl("lbl_cost_ctr") as Label).Text);
                        cmd.Parameters.AddWithValue("@factor", Convert.ToDouble((item.FindControl("txt_factor") as RadNumericTextBox).Value));
                        cmd.Parameters.AddWithValue("@Asscost", 0);
                        cmd.Parameters.AddWithValue("@reff_no", cb_reff.Text);
                        cmd.Parameters.AddWithValue("@tax1", cb_tax1.Text);
                        cmd.Parameters.AddWithValue("@tax2", cb_tax2.Text);
                        cmd.Parameters.AddWithValue("@tax3", cb_tax3.Text);

                        //cmd.Parameters.AddWithValue("@jumlah", (item.FindControl("txt_sub_price") as RadTextBox).Text);
                        //cmd.Parameters.AddWithValue("@nomer", (item.FindControl("lblUom") as RadTextBox).Text);
                        //cmd.Parameters.AddWithValue("@JDisc", (item.FindControl("txt_JDisk") as RadTextBox).Text);
                        //cmd.Parameters.AddWithValue("@HPokok", (item.FindControl("txt_HPokok") as RadTextBox).Text);
                        //cmd.Parameters.AddWithValue("@jumlah2", (item.FindControl("txt_sub_price") as RadTextBox).Text);
                        //cmd.Parameters.AddWithValue("@NoContr", (item.FindControl("txt_NoContr") as RadTextBox).Text);
                        //cmd.Parameters.AddWithValue("@jTax1", (item.FindControl("lblRS") as RadTextBox).Text);
                        //cmd.Parameters.AddWithValue("@jTax2", (item.FindControl("lblRS") as RadTextBox).Text);
                        //cmd.Parameters.AddWithValue("@jTax3", (item.FindControl("lblRS") as RadTextBox).Text);

                        cmd.ExecuteNonQuery();

                    }

                    con.Close();
                    notif.Text = "Data berhasil disimpan";
                    notif.Title = "Notification";
                    notif.Show();
                    txt_po_code.Text = run;

                    //if (Session["actionEdit"].ToString() == "edit")
                    //{
                    //    ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind();", true);
                    //}
                    //else
                    //{
                    //    RadGrid2.Enabled = true;
                    //    ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind('navigateToInserted');", true);
                    //}

                }

            }
            catch (System.Exception ex)
            {
                con.Close();
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
            }
        }

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

        protected void cb_term_PreRender(object sender, EventArgs e)
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
            (sender as RadComboBox).Items.Add("Cash");
            (sender as RadComboBox).Items.Add("Credit");
            (sender as RadComboBox).Items.Add("COD");
        }

        protected void RadGrid2_UpdateCommand(object sender, GridCommandEventArgs e)
        {
            con.Open();
            GridEditableItem item = (GridEditableItem)e.Item;
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_save_purchase_orderD";
            cmd.Parameters.AddWithValue("@po_code", txt_po_code.Text);
            cmd.Parameters.AddWithValue("@prod_type", (item.FindControl("lblProdType") as Label).Text);
            cmd.Parameters.AddWithValue("@Prod_code", (item.FindControl("lblProdCode") as Label).Text);
            cmd.Parameters.AddWithValue("@qty", Convert.ToDouble((item.FindControl("txt_qty") as RadNumericTextBox).Value));
            cmd.Parameters.AddWithValue("@SatQty", (item.FindControl("cb_uom_d") as RadComboBox).Text);
            cmd.Parameters.AddWithValue("@harga2", Convert.ToDouble((item.FindControl("txt_harga") as RadNumericTextBox).Value));
            cmd.Parameters.AddWithValue("@Disc", Convert.ToDouble((item.FindControl("txt_disc") as RadNumericTextBox).Value));
            if ((item.FindControl("edt_chkTax1") as CheckBox).Checked == true)
            {
                cmd.Parameters.AddWithValue("@tTax", 1);
            }
            else
            {
                cmd.Parameters.AddWithValue("@tTax", 0);
            }
            if ((item.FindControl("edt_chkOTax") as CheckBox).Checked == true)
            {
                cmd.Parameters.AddWithValue("@tOTax", 1);
            }
            else
            {
                cmd.Parameters.AddWithValue("@tOTax", 0);
            }
            if ((item.FindControl("edt_chkTpph") as CheckBox).Checked == true)
            {
                cmd.Parameters.AddWithValue("@tpph", 1);
            }
            else
            {
                cmd.Parameters.AddWithValue("@tpph", 0);
            }
            cmd.Parameters.AddWithValue("@harga", Convert.ToDouble((item.FindControl("txt_harga") as RadNumericTextBox).Value));
            cmd.Parameters.AddWithValue("@Prod_code_ori", (item.FindControl("lbl_Prod_code_ori") as Label).Text);
            cmd.Parameters.AddWithValue("@dept_code", (item.FindControl("lbl_cost_ctr") as Label).Text);
            cmd.Parameters.AddWithValue("@factor", Convert.ToDouble((item.FindControl("txt_factor") as RadNumericTextBox).Value));
            cmd.Parameters.AddWithValue("@Asscost", 0);
            cmd.Parameters.AddWithValue("@reff_no", cb_reff.SelectedValue);
            cmd.Parameters.AddWithValue("@tax1", cb_tax1.Text);
            cmd.Parameters.AddWithValue("@tax2", cb_tax2.Text);
            cmd.Parameters.AddWithValue("@tax3", cb_tax3.Text);

            cmd.ExecuteNonQuery();
            con.Close();
        }

    }
}