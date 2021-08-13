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

namespace TelerikWebApplication.Form.Purchase.PurchaseExpenses
{
    public partial class acc01h13EditForm : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();
        private const int ItemsPerRequest = 10;

        public static string tr_code = null;
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
            if (Request.QueryString["NoBuk"] != null)
            {
                fill_object(Request.QueryString["NoBuk"].ToString());
                RadGrid2.DataSource = GetDataDetailTableD(txt_doc_code.Text);
                RadGrid2.DataBind();
                Session["actionEdit"] = "edit";
            }
            else
            {
                Session["actionEdit"] = "new";

                dtp_purex.SelectedDate = DateTime.Now;

                //cb_project.SelectedValue = public_str.site;
                //cb_project.Text = public_str.sitename;
                //cb_tax1.Text = "NON";
                //cb_tax2.Text = "NON";
                //cb_tax3.Text = "NON";

                txt_uid.Text = public_str.user_id;
                txt_owner.Text = public_str.user_id;
                txt_lastUpdate.Text = string.Format("{0:dd/MM/yyyy}", DateTime.Now);
                txt_printed.Text = "0";
                txt_edited.Text = "0";
                txt_sub_total.Value = 0;
                txt_tax1_value.Value = 0;
                txt_tax2_value.Value = 0;
                txt_tax3_value.Value = 0;
                txt_DP.Value = 0;
                txt_total.Value = 0;
            }
        }
        private DataTable GetDataDetailTableD(string nobuk)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_purchase_expensesD";
            cmd.Parameters.AddWithValue("@nobuk", nobuk);
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
        protected void fill_object(string NoBuk)
        {
            con.Open();
            SqlDataReader sdr;
            SqlCommand cmd = new SqlCommand("SELECT * FROM v_purchase_expensesH WHERE NoBuk =  '" + NoBuk + "'", con);
            sdr = cmd.ExecuteReader();
            if (sdr.Read())
            {
                txt_doc_code.Text = sdr["NoBuk"].ToString();
                dtp_purex.SelectedDate = Convert.ToDateTime(sdr["Tgl"].ToString());
                txt_ctrl_no.Text = sdr["NoPO"].ToString();
                txt_invoice_no.Text = sdr["NoFP"].ToString();
                txt_tax_invoice.Text = sdr["invCode"].ToString();
                dtp_invoice_date.SelectedDate = Convert.ToDateTime(sdr["TglFP"].ToString());
                cb_supplier.Text = sdr["NamSup"].ToString();
                txt_curr.Text = sdr["KoMat"].ToString();
                txt_kurs.Value = Convert.ToDouble(sdr["Kurs"].ToString());
                txt_tax_kurs.Value = Convert.ToDouble(sdr["KursTax"].ToString());
                cb_tax1.Text = sdr["tax1_name"].ToString();
                cb_tax2.Text = sdr["tax2_name"].ToString();
                cb_tax3.Text = sdr["tax3_name"].ToString();
                cb_project.Text = sdr["region_name"].ToString();
                cb_cost_center.Text = sdr["CostCenterName"].ToString();
                txt_remark.Text = sdr["Ket"].ToString();
                txt_term_days.Value = Convert.ToDouble(sdr["JTempo"].ToString());
                cb_prepare_by.Text = sdr["prepare_by_name"].ToString();
                cb_checked.Text = sdr["ack_by_name"].ToString();
                cb_approved.Text = sdr["app_by_name"].ToString();
                txt_owner.Text = sdr["Owner"].ToString();
                txt_printed.Text = sdr["Printed"].ToString();
                txt_edited.Text = sdr["Edited"].ToString();
                txt_uid.Text = sdr["Usr"].ToString();
                txt_lastUpdate.Text = string.Format("{0:dd/MM/yyyy}", sdr["Stamp"].ToString());
                cb_term.Text = sdr["payTerm"].ToString();
                txt_pppn.Value = Convert.ToDouble(sdr["PPPN"]);
                txt_ppph.Value = Convert.ToDouble(sdr["PPPH"]);
                txt_po_tax.Value = Convert.ToDouble(sdr["POTax"]);
                txt_sub_total.Value = Convert.ToDouble(sdr["Jumlah"]);
                txt_tax1_value.Value = Convert.ToDouble(sdr["JPPN"]);
                txt_tax2_value.Value = Convert.ToDouble(sdr["JOTax"]);
                txt_tax3_value.Value = Convert.ToDouble(sdr["Jpph"]);
                txt_total.Value = Convert.ToDouble(sdr["Net"]);
                txt_DP.Value = Convert.ToDouble(sdr["DP"]);
            }
            con.Close();
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
        #endregion

        #region Supplier
        private static DataTable GetSupplier(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT supplier_code, supplier_name, cur_code FROM ms_supplier WHERE stEdit != 4 AND supplier_name LIKE @text + '%'",
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
        }

        protected void cb_supplier_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT     a.supplier_code,e.KursRun, e.KursTax, a.cur_code, b.TAX_NAME as ppn, c.TAX_NAME AS Otax, d.TAX_NAME AS pph, a.pay_code, a.JTempo " +
                               " FROM ms_supplier a LEFT OUTER JOIN MS_TAX AS b ON b.TAX_CODE = a.ppn LEFT OUTER JOIN MS_TAX AS c ON a.OTax = c.TAX_CODE LEFT OUTER JOIN " +
                               " MS_TAX AS d ON a.pph = d.TAX_CODE inner join ms_kurs e on a.cur_code = e.cur_code WHERE (e.tglKurs = (SELECT     MAX(tglKurs) AS Expr1 " +
                               " FROM ms_kurs)) and a.supplier_name = '" + cb_supplier.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                cb_supplier.SelectedValue = dr["supplier_code"].ToString();
                txt_curr.Text = dr["cur_code"].ToString();
                txt_kurs.Value = Convert.ToDouble(dr["KursRun"].ToString());
                txt_tax_kurs.Value = Convert.ToDouble(dr["KursTax"].ToString());
                cb_tax1.SelectedValue = dr["ppn"].ToString();
                cb_tax2.SelectedValue = dr["Otax"].ToString();
                cb_tax3.SelectedValue = dr["pph"].ToString();
                cb_term.Text = dr["pay_code"].ToString();
                txt_term_days.Text = dr["JTempo"].ToString();
            }

            dr.Close();
            con.Close();

            get_supp_info(cb_supplier.SelectedValue);
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

        #region Tax
        private static DataTable GetTax(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT TAX_NAME FROM MS_TAX WHERE stEdit != 4 AND TAX_NAME LIKE @text + '%' UNION SELECT 'NON'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
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
            {
                cb_tax1.SelectedValue = dr["TAX_CODE"].ToString();
            }

            dr.Close();
            con.Close();

            get_tax_perc(cb_tax1.SelectedValue, txt_pppn);

            foreach (GridDataItem item in this.RadGrid2.Items)
            {
                CheckBox cTax1 = (CheckBox)item.FindControl("chk_tax1");
                CheckBox cTax2 = (CheckBox)item.FindControl("chk_tax2");
                CheckBox cTax3 = (CheckBox)item.FindControl("chk_tax3");

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
            cmd.CommandText = "SELECT TAX_CODE,ISNULL(TAX_PERC,0) AS TAX_PERC FROM  MS_TAX WHERE TAX_NAME = '" + cb_tax1.Text + "'";
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
            cmd.CommandText = "SELECT TAX_CODE,ISNULL(TAX_PERC,0) AS TAX_PERC FROM MS_TAX WHERE TAX_NAME = '" + cb_tax2.Text + "'";
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
                CheckBox cTax1 = (CheckBox)item.FindControl("chk_tax1");
                CheckBox cTax2 = (CheckBox)item.FindControl("chk_tax2");
                CheckBox cTax3 = (CheckBox)item.FindControl("chk_tax3");

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
            cmd.CommandText = "SELECT TAX_CODE,ISNULL(TAX_PERC,0) AS TAX_PERC FROM  MS_TAX WHERE TAX_NAME = '" + cb_tax2.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                cb_tax2.SelectedValue = dr["TAX_CODE"].ToString();
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
            cmd.CommandText = "SELECT TAX_CODE,ISNULL(TAX_PERC,0) AS TAX_PERC FROM MS_TAX WHERE TAX_NAME = '" + cb_tax3.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                cb_tax3.SelectedValue = dr[0].ToString();
                txt_ppph.Value = Convert.ToDouble(dr["TAX_PERC"].ToString());
            }
            
            dr.Close();
            con.Close();

            get_tax_perc(cb_tax3.SelectedValue, txt_ppph);

            foreach (GridDataItem item in this.RadGrid2.Items)
            {
                CheckBox cTax1 = (CheckBox)item.FindControl("chk_tax1");
                CheckBox cTax2 = (CheckBox)item.FindControl("chk_tax2");
                CheckBox cTax3 = (CheckBox)item.FindControl("chk_tax3");

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
            cmd.CommandText = "SELECT TAX_CODE,ISNULL(TAX_PERC,0) AS TAX_PERC FROM  MS_TAX WHERE TAX_NAME = '" + cb_tax3.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                cb_tax3.SelectedValue = dr["TAX_CODE"].ToString();
                txt_ppph.Value = Convert.ToDouble(dr["TAX_PERC"].ToString());
            }

            dr.Close();
            con.Close();
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
                    (Convert.ToDouble(txt_DP.Value));

                txt_total.Text = sum.ToString();
            }
            catch (Exception)
            {

            }
        }
        #endregion

        #region Term
        protected void cb_term_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Add("Cash");
            (sender as RadComboBox).Items.Add("Credit");
            (sender as RadComboBox).Items.Add("COD");
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
        protected void cb_prepare_by_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadManPower(e.Text, cb_project.SelectedValue, cb_prepare_by);
        }
        protected void cb_prepare_DataBound(object sender, EventArgs e)
        {
            ((Literal)cb_prepare_by.Footer.FindControl("RadComboItemsCount")).Text = Convert.ToString(cb_prepare_by.Items.Count);
        }
        protected void cb_prepare_by_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM ms_manpower WHERE name = '" + cb_prepare_by.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_prepare_by.SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_prepare_by_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM ms_manpower WHERE name = '" + cb_prepare_by.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_prepare_by.SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_checked_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadManPower(e.Text, cb_project.SelectedValue, cb_checked);
        }
        protected void cb_checked_DataBound(object sender, EventArgs e)
        {
            ((Literal)cb_checked.Footer.FindControl("RadComboItemsCount")).Text = Convert.ToString(cb_checked.Items.Count);
        }
        protected void cb_checked_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM ms_manpower WHERE name = '" + cb_checked.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_checked.SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_checked_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM ms_manpower WHERE name = '" + cb_checked.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_checked.SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_approved_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadManPower(e.Text, cb_project.SelectedValue, cb_approved);
        }
        protected void cb_approved_DataBound(object sender, EventArgs e)
        {
            ((Literal)cb_approved.Footer.FindControl("RadComboItemsCount")).Text = Convert.ToString(cb_approved.Items.Count);
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

        protected void cb_approved_PreRender(object sender, EventArgs e)
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

        protected void cb_CodeBiaya_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            string sql = "SELECT  ms_biaya.code_biaya , ms_biaya.remark , ms_biaya.accountno FROM ms_biaya WHERE ( ms_biaya.stEdit = '0' ) AND remark LIKE @remark + '%'";
            SqlDataAdapter adapter = new SqlDataAdapter(sql,
                ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@remark", e.Text);

            DataTable dt = new DataTable();
            adapter.Fill(dt);

            RadComboBox comboBox = (RadComboBox)sender;
            // Clear the default Item that has been re-created from ViewState at this point.
            comboBox.Items.Clear();

            foreach (DataRow row in dt.Rows)
            {
                RadComboBoxItem item = new RadComboBoxItem();
                item.Text = row["code_biaya"].ToString();
                item.Value = row["code_biaya"].ToString();
                item.Attributes.Add("remark", row["remark"].ToString());

                comboBox.Items.Add(item);

                item.DataBind();
            }
        }

       
        protected void cb_CodeBiaya_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT code_biaya FROM ms_biaya WHERE remark = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }

        protected void btn_save_Click(object sender, EventArgs e)
        {
            long maxNo;
            string run = null;
            string trDate = string.Format("{0:dd/MM/yyyy}", dtp_purex.SelectedDate);

            try
            {
                if (Session["actionEdit"].ToString() != "new")
                {
                    run = txt_doc_code.Text;
                }
                else
                {
                    con.Open();
                    SqlDataReader sdr;
                    cmd = new SqlCommand("SELECT ISNULL ( MAX ( RIGHT ( MUTAP.NoBuk , 4 ) ) , 0 ) + 1 AS maxNo " +
                        "FROM MUTAP WHERE LEFT(MUTAP.NoBuk, 4) = 'EP01' " +
                        "AND SUBSTRING(MUTAP.NoBuk, 5, 2) = SUBSTRING('" + trDate + "', 9, 2) " +
                        "AND SUBSTRING(MUTAP.NoBuk, 7, 2) = SUBSTRING('" + trDate + "', 4, 2) ", con);
                    sdr = cmd.ExecuteReader();
                    if (sdr.HasRows == false)
                    {
                        //throw new Exception();
                        run = "EP01" + dtp_purex.SelectedDate.Value.Year + dtp_purex.SelectedDate.Value.Month + "0001";
                    }
                    else if (sdr.Read())
                    {
                        maxNo = Convert.ToInt32(sdr[0].ToString());
                        run = "EP01" + (dtp_purex.SelectedDate.Value.Year.ToString()).Substring(dtp_purex.SelectedDate.Value.Year.ToString().Length - 2) +
                            ("0000" + dtp_purex.SelectedDate.Value.Month).Substring(("0000" + dtp_purex.SelectedDate.Value.Month).Length - 2, 2) +
                            ("0000" + maxNo).Substring(("0000" + maxNo).Length - 4, 4);
                    }
                    con.Close();
                }


                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_save_purchase_expensesH";
                cmd.Parameters.AddWithValue("@NoBuk", run);
                cmd.Parameters.AddWithValue("@Kode", "EP");
                cmd.Parameters.AddWithValue("@Tgl", string.Format("{0:yyyy-MM-dd}", dtp_purex.SelectedDate.Value));
                cmd.Parameters.AddWithValue("@NoPO", txt_ctrl_no.Text);
                cmd.Parameters.AddWithValue("@NoFP", txt_invoice_no.Text);
                cmd.Parameters.AddWithValue("@TglFP", string.Format("{0:yyyy-MM-dd}", dtp_invoice_date.SelectedDate.Value));
                cmd.Parameters.AddWithValue("@KoSup", cb_supplier.SelectedValue);
                cmd.Parameters.AddWithValue("@NamSup", cb_supplier.Text);
                cmd.Parameters.AddWithValue("@KoMat", txt_curr.Text);
                cmd.Parameters.AddWithValue("@Kurs", Convert.ToDouble(txt_kurs.Value)); //10
                cmd.Parameters.AddWithValue("@KursTax", Convert.ToDouble(txt_tax_kurs.Value));
                cmd.Parameters.AddWithValue("@Jumlah", Convert.ToDouble(txt_sub_total.Value));
                cmd.Parameters.AddWithValue("@InvCode", cb_term.SelectedValue);
                cmd.Parameters.AddWithValue("@PPN", cb_tax1.SelectedValue);
                cmd.Parameters.AddWithValue("@OTax", cb_tax2.SelectedValue);
                cmd.Parameters.AddWithValue("@pph", cb_tax3.SelectedValue);
                cmd.Parameters.AddWithValue("@DP", Convert.ToDouble(txt_DP.Value));
                cmd.Parameters.AddWithValue("@region_code", cb_project.SelectedValue);
                cmd.Parameters.AddWithValue("@dept_code", cb_cost_center.SelectedValue);
                cmd.Parameters.AddWithValue("@AppBy", cb_approved.SelectedValue); //20
                cmd.Parameters.AddWithValue("@OrdBy", cb_checked.SelectedValue);
                cmd.Parameters.AddWithValue("@FreBy", cb_prepare_by.SelectedValue);
                cmd.Parameters.AddWithValue("@Ket", txt_remark.Text);
                cmd.Parameters.AddWithValue("@JTempo", Convert.ToDouble(txt_term_days.Value));
                cmd.Parameters.AddWithValue("@Owner", public_str.user_id);
                cmd.Parameters.AddWithValue("@Printed", 0);
                cmd.Parameters.AddWithValue("@Edited", 0);
                cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
                cmd.Parameters.AddWithValue("@Stamp", string.Format("{0:yyyy-MM-dd}", DateTime.Now));
                cmd.Parameters.AddWithValue("@pay_code", cb_term.SelectedValue); //30
                cmd.Parameters.AddWithValue("@PPPN", Convert.ToDouble(txt_pppn.Value));
                cmd.Parameters.AddWithValue("@Ppph", Convert.ToDouble(txt_ppph.Value));
                cmd.Parameters.AddWithValue("@POTax", Convert.ToDouble(txt_po_tax.Value));
                cmd.Parameters.AddWithValue("@JPPN", Convert.ToDouble(txt_tax1_value.Value));
                cmd.Parameters.AddWithValue("@JOTax", Convert.ToDouble(txt_tax2_value.Value));
                cmd.Parameters.AddWithValue("@Jpph", Convert.ToDouble(txt_tax3_value.Value));
                cmd.Parameters.AddWithValue("@Net", Convert.ToDouble(txt_total.Value));
                cmd.Parameters.AddWithValue("@pphIncl", 0);
                cmd.Parameters.AddWithValue("@tFullSupply", 0);
                cmd.Parameters.AddWithValue("@Otorisasi", 0); //40
                cmd.Parameters.AddWithValue("@Batal", 0);
                cmd.Parameters.AddWithValue("@posting", 0);
                cmd.Parameters.AddWithValue("@tLunas", 0);
                cmd.Parameters.AddWithValue("@PreJPPN", 0);
                cmd.Parameters.AddWithValue("@PreJPPH", 0);
                cmd.Parameters.AddWithValue("@PreJOTAX", 0);

                cmd.ExecuteNonQuery();

                foreach (GridDataItem item in RadGrid2.MasterTableView.Items)
                {
                    cmd = new SqlCommand();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Connection = con;
                    cmd.CommandText = "sp_save_purchase_expensesD";
                    cmd.Parameters.AddWithValue("@NoBuk", run);
                    cmd.Parameters.AddWithValue("@nomor", Convert.ToDouble((item.FindControl("txt_nomor") as RadNumericTextBox).Value));
                    cmd.Parameters.AddWithValue("@code_biaya", (item.FindControl("cb_CodeBiaya") as RadComboBox).Text);
                    cmd.Parameters.AddWithValue("@sub_price", Convert.ToDouble((item.FindControl("txtSubPrice") as RadNumericTextBox).Value));
                    if ((item.FindControl("chk_tax1") as CheckBox).Checked == true)
                    {
                        cmd.Parameters.AddWithValue("@tTax", 1);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@tTax", 0);
                    }
                    if ((item.FindControl("chk_tax2") as CheckBox).Checked == true)
                    {
                        cmd.Parameters.AddWithValue("@tOTax", 1);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@tOTax", 0);
                    }
                    if ((item.FindControl("chk_tax3") as CheckBox).Checked == true)
                    {
                        cmd.Parameters.AddWithValue("@tpph", 1);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@tpph", 0);
                    }
                    cmd.Parameters.AddWithValue("@pay_tot", Convert.ToDouble((item.FindControl("lblTotal") as RadNumericTextBox).Value));
                    //cmd.Parameters.AddWithValue("@debt_rema", 0);
                    cmd.Parameters.AddWithValue("@dept_code", (item.FindControl("lblCostCtr") as Label).Text);
                    cmd.Parameters.AddWithValue("@remark", Convert.ToDouble((item.FindControl("txtRemark_d") as RadNumericTextBox).Value));

                    cmd.ExecuteNonQuery();

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
                notif.Text = "Data berhasil disimpan";
                notif.Title = "Notification";
                notif.Show();
                txt_doc_code.Text = run;

                if (Session["actionEdit"].ToString() == "edit")
                {
                    ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind();", true);
                }
                else
                {
                    ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind('navigateToInserted');", true);
                }
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
                (sender as RadGrid).DataSource = GetDataDetailTableD(txt_doc_code.Text);
            }
        }

        protected void RadGrid2_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            var BiayaCode = ((GridDataItem)e.Item).GetDataKeyValue("code_biaya");

            try
            {
                GridEditableItem item = (GridEditableItem)e.Item;
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "delete from MUTIC_BIAYA where code_biaya = @code_biaya and NoBuk = @NoBuk";
                cmd.Parameters.AddWithValue("@NoBuk", txt_doc_code.Text);
                cmd.Parameters.AddWithValue("@code_biaya", BiayaCode);
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

        protected void RadGrid2_InsertCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                con.Open();
                GridEditableItem item = (GridEditableItem)e.Item;
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_save_purchase_expensesD";
                cmd.Parameters.AddWithValue("@NoBuk", txt_doc_code.Text);
                cmd.Parameters.AddWithValue("@nomor", (item.FindControl("lblNomor") as Label).Text);
                cmd.Parameters.AddWithValue("@code_biaya", (item.FindControl("cb_CodeBiaya") as RadComboBox).Text);
                cmd.Parameters.AddWithValue("@sub_price", Convert.ToDouble((item.FindControl("txtSubPrice") as RadNumericTextBox).Value));
                if ((item.FindControl("chk_tax1") as CheckBox).Checked == true)
                {
                    cmd.Parameters.AddWithValue("@tTax", 1);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@tTax", 0);
                }
                if ((item.FindControl("chk_tax2") as CheckBox).Checked == true)
                {
                    cmd.Parameters.AddWithValue("@tOTax", 1);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@tOTax", 0);
                }
                if ((item.FindControl("chk_tax3") as CheckBox).Checked == true)
                {
                    cmd.Parameters.AddWithValue("@tpph", 1);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@tpph", 0);
                }
                cmd.Parameters.AddWithValue("@pay_tot", Convert.ToDouble((item.FindControl("lblTotal") as RadNumericTextBox).Value));
                //cmd.Parameters.AddWithValue("@debt_rema", (item.FindControl("lbl_Prod_code_ori") as Label).Text);
                cmd.Parameters.AddWithValue("@dept_code", (item.FindControl("lblCostCtr") as Label).Text);
                cmd.Parameters.AddWithValue("@remark", Convert.ToDouble((item.FindControl("txtRemark_d") as RadNumericTextBox).Value));

                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                con.Close();
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
                e.Canceled = true;
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

        protected void cb_CodeBiaya_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            Session["code_biaya"] = e.Value;

            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "SELECT	code_biaya, remark FROM	ms_biaya WHERE	code_biaya = '" + (sender as RadComboBox).SelectedValue + "'";

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                foreach (DataRow dtr in dt.Rows)
                {
                    RadComboBox cb = (RadComboBox)sender;
                    GridEditableItem item = (GridEditableItem)cb.NamingContainer;
                    RadTextBox D_remark = (RadTextBox)item.FindControl("txtRemark_d");
                    //RadTextBox D_Amount = (RadTextBox)item.FindControl("txtSubPrice");
                    //CheckBox D_Tax1 = (CheckBox)item.FindControl("chk_tax1");
                    //CheckBox D_Tax2 = (CheckBox)item.FindControl("chk_tax2");
                    //CheckBox D_Tax3 = (CheckBox)item.FindControl("chk_tax3");
                    //RadTextBox D_Net = (RadTextBox)item.FindControl("lblTotal");
                    Label D_CostCenter = (Label)item.FindControl("lblCostCtr");

                    D_remark.Text = dtr["remark"].ToString();
                    //D_Amount.Text = dtr["sub_price"].ToString();
                    //D_Tax1.Checked = cb_tax1.CheckBoxes;
                    //D_Tax2.Checked = cb_tax2.CheckBoxes;
                    //D_Tax3.Checked = cb_tax3.CheckBoxes;
                    //D_Net.Text = string.Format("{0:#,###,##0.00}", dtr["pay_tot"].ToString());
                    D_CostCenter.Text = cb_cost_center.SelectedValue;
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

        protected void cb_CodeBiaya_SelectedIndexChanged1(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            Session["code_biaya"] = e.Value;

            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "SELECT	code_biaya, remark FROM	ms_biaya WHERE	code_biaya = '" + (sender as RadComboBox).SelectedValue + "'";

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                foreach (DataRow dtr in dt.Rows)
                {
                    RadComboBox cb = (RadComboBox)sender;
                    GridEditableItem item = (GridEditableItem)cb.NamingContainer;
                    RadTextBox D_remark = (RadTextBox)item.FindControl("txtRemark_d");
                    //RadTextBox D_Amount = (RadTextBox)item.FindControl("txtSubPrice");
                    //CheckBox D_Tax1 = (CheckBox)item.FindControl("chk_tax1");
                    //CheckBox D_Tax2 = (CheckBox)item.FindControl("chk_tax2");
                    //CheckBox D_Tax3 = (CheckBox)item.FindControl("chk_tax3");
                    //RadTextBox D_Net = (RadTextBox)item.FindControl("lblTotal");
                    Label D_CostCenter = (Label)item.FindControl("lblCostCtr");

                    D_remark.Text = dtr["remark"].ToString();
                    //D_Amount.Text = dtr["sub_price"].ToString();
                    //D_Tax1.Checked = cb_tax1.CheckBoxes;
                    //D_Tax2.Checked = cb_tax2.CheckBoxes;
                    //D_Tax3.Checked = cb_tax3.CheckBoxes;
                    //D_Net.Text = string.Format("{0:#,###,##0.00}", dtr["pay_tot"].ToString());
                    D_CostCenter.Text = cb_cost_center.SelectedValue;
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
    }
}