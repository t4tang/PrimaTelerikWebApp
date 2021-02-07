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


        public static string tax_check = null;
        public static string oTax_check = null;
        public static string pph_check = null;
        public static string tax1 = null;
        public static string tax2 = null;
        public static string tax3 = null;
        private object txtRemark_d;

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
                    RadGrid2.DataSource = GetDataDetailTable(txt_reg_code.Text);
                    Session["actionEdit"] = "edit";
                }
                else
                {
                    Session["actionEdit"] = "new";

                    dtp_reg.SelectedDate = DateTime.Now;
                    dtp_inv.SelectedDate = DateTime.Now;

                    cb_from_type.SelectedValue = "1";
                    cb_project.SelectedValue = public_str.site;
                    cb_project.Text = public_str.sitename;

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
                }
            }
        }

        protected void fill_object(string id)
        {
            con.Open();
            SqlDataReader sdr;
            SqlCommand cmd = new SqlCommand("SELECT a.*, b.* FROM v_invoice_incomingH a LEFT OUTER JOIN v_invoice_incoming_reff b ON " +
                "a.NoPO=b.po_code WHERE a.NoBuk =  '" + id + "'", con);
            sdr = cmd.ExecuteReader();
            if (sdr.Read())
            {
                txt_reg_code.Text = sdr["NoBuk"].ToString();
                dtp_reg.SelectedDate = Convert.ToDateTime(sdr["Tgl"].ToString());
                dtp_inv.SelectedDate = Convert.ToDateTime(sdr["TglFP"].ToString());
                cb_reff.Text = sdr["NoPO"].ToString();
                //cb_po_type.Text = sdr["TransName"].ToString();
                //cb_po_type.SelectedValue = sdr["trans_code"].ToString();
                //cb_priority.Text = sdr["prio_desc"].ToString();
                cb_supplier.Text = sdr["supplier_name"].ToString();
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
                txt_remark.Text = sdr["Remark"].ToString();
                txt_term_days.Value = Convert.ToDouble(sdr["JTempo"].ToString());
                cb_prepared.Text = sdr["Order_by"].ToString();
                cb_verified.Text = sdr["Prepare_by"].ToString();
                cb_approved.Text = sdr["Order_by"].ToString();
                txt_owner.Text = sdr["Owner"].ToString();
                txt_printed.Text = sdr["Printed"].ToString();
                txt_edited.Text = sdr["Edited"].ToString();
                txt_uid.Text = sdr["userid"].ToString();
                txt_lastUpdate.Text = string.Format("{0:dd/MM/yyyy}", sdr["lastupdate"].ToString());
                cb_term.Text = sdr["payTerm"].ToString();
                txt_pppn.Value = Convert.ToDouble(sdr["PPPN"]);
                txt_ppph.Value = Convert.ToDouble(sdr["ppph"]);
                txt_po_tax.Value = Convert.ToDouble(sdr["POTax"]);
                txt_sub_total.Value = Convert.ToDouble(sdr["jumlah"]);
                txt_tax1_value.Value = Convert.ToDouble(sdr["jtax1"]);
                txt_tax2_value.Value = Convert.ToDouble(sdr["jtax2"]);
                txt_tax3_value.Value = Convert.ToDouble(sdr["jtax3"]);
                txt_total.Value = Convert.ToDouble(sdr["Net"]);
                txt_other_value.Value = Convert.ToDouble(sdr["Othercost"]);

            }
            con.Close();
        }

        #region Detail
        public DataTable GetDataDetailTable(string NoBuk)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_invoice_incomingD";
            cmd.Parameters.AddWithValue("@NoBuk", NoBuk);
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
            if (!IsPostBack)
            {
                (sender as RadGrid).DataSource = new string[] { };
            }
            else if (Session["actionEdit"].ToString() == "new")
            {
                (sender as RadGrid).DataSource = new string[] { };
                (sender as RadGrid).DataSource = GetDataRefDetailTable(cb_reff.Text);
            }
            else if (Session["actionEdit"].ToString() == "edit")
            {
                (sender as RadGrid).DataSource = new string[] { };
                (sender as RadGrid).DataSource = GetDataRefDetailTable(cb_reff.Text);
            }
        }
        #endregion

        protected void cb_from_type_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
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
        //protected void cb_supplier_PreRender(object sender, EventArgs e)
        //{
        //    con.Open();
        //    SqlCommand cmd = new SqlCommand();
        //    cmd.Connection = con;
        //    cmd.CommandType = CommandType.Text;
        //    cmd.CommandText = "SELECT supplier_code FROM pur00h01 WHERE supplier_name = '" + (sender as RadComboBox).Text + "'";
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
            cmd.CommandText = "SELECT     pur00h01.supplier_code,acc00h04.KursRun, acc00h04.KursTax, pur00h01.cur_code, acc00h05.TAX_NAME as ppn, c.TAX_NAME AS Otax, d.TAX_NAME AS pph " + 
                                "FROM pur00h01 LEFT OUTER JOIN acc00h05 ON acc00h05.TAX_CODE = pur00h01.ppn LEFT OUTER JOIN acc00h05 AS c ON pur00h01.OTax = c.TAX_CODE LEFT OUTER JOIN " +
                                "acc00h05 AS d ON pur00h01.pph = d.TAX_CODE inner join acc00h04 on pur00h01.cur_code = acc00h04.cur_code WHERE(acc00h04.tglKurs = (SELECT     MAX(tglKurs) AS Expr1 " +
                                "FROM acc00h04)) and pur00h01.supplier_name = 'INDOTRUCK UTAMA, PT (IDR)' = '" + (sender as RadComboBox).Text + "'";
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
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT region_code, region_name FROM inv00h09 WHERE stEdit != 4 AND region_name LIKE @text + '%' ",
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
            if (cb_from_type.Text == "Purchase Order")
            {
                cmd.CommandText = "select * from v_invoice_incoming_reff where po_code = '" + (sender as RadComboBox).SelectedValue + "'";
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    (sender as RadComboBox).Text = dr["po_code"].ToString();
                    cb_cost_center.SelectedValue = dr["dept_code"].ToString();
                    cb_cost_center.Text = dr["CostCenterName"].ToString();
                    txt_remark.Text = dr["remark"].ToString();
                    //txt_po_date.Text = dr["Po_date"].ToString();
                }
            }
            else
            {
                cmd.CommandText = "select * from v_invoice_incoming_reffC where po_code = '" + (sender as RadComboBox).SelectedValue + "'";
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    (sender as RadComboBox).Text = dr["po_code"].ToString();
                    cb_cost_center.SelectedValue = dr["region_code"].ToString();
                    cb_cost_center.Text = dr["CostCenterName"].ToString();
                    txt_remark.Text = dr["remark"].ToString();
                    //txt_po_date.Text = dr["Po_date"].ToString();
                }
            }

            dr.Close();
            con.Close();

            RadGrid2.DataSource = GetDataRefDetailTable((sender as RadComboBox).SelectedValue);
            RadGrid2.DataBind();

            txt_sub_total.Value = 0;
            txt_tax1_value.Value = 0;
            txt_tax2_value.Value = 0;
            txt_tax3_value.Value = 0;
            txt_total.Value = 0;
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
                //DataTable dt = new DataTable();
                adapter.Fill(dt); 
            }
            else
            {
                SqlDataAdapter adapter = new SqlDataAdapter("SELECT po_code, Tgl, remark FROM v_invoice_incoming_reffC WHERE region_code = @region_code " +
                "AND po_code LIKE @text + '%' ORDER BY po_code",
                ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
                adapter.SelectCommand.Parameters.AddWithValue("@text", po_code);
                adapter.SelectCommand.Parameters.AddWithValue("@region_code", project);
                //DataTable dt = new DataTable();
                adapter.Fill(dt);
            }

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

        protected void cb_cost_center_PreRender(object sender, EventArgs e)
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
            cmd.CommandText = "SELECT TAX_CODE,TAX_PERC FROM  acc00h05 WHERE TAX_NAME = '" + cb_tax1.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                cb_tax1.SelectedValue = dr["TAX_CODE"].ToString();
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
            cmd.CommandText = "SELECT TAX_CODE,TAX_PERC FROM acc00h05 WHERE TAX_NAME = '" + cb_tax2.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                cb_tax2.SelectedValue = dr[0].ToString();
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
            {
                cb_tax3.SelectedValue = dr[0].ToString();
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
        #endregion
        protected void calculate_sub_price(object sender, EventArgs e)
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

            txt_sub_price.Value = (Convert.ToDouble(txt_harga.Value) * Convert.ToDouble(txt_qty.Value)) - (Convert.ToDouble(txt_harga.Value) * Convert.ToDouble(txt_qty.Value) * txt_disc.Value / 100) + (txt_factor.Value);

            CalculateSubTotal(chkTax1.Checked, chkTax2.Checked, chkTax3.Checked);
            //CalculateSubTotal();
            //CalculateTotal();
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
        protected void cb_prepared_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
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

        protected void cb_verified_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
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

        protected void cb_approved_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
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
                    cmd = new SqlCommand("SELECT ISNULL ( MAX ( RIGHT ( acc01h13.po_code , 4 ) ) , 0 ) + 1 AS maxNo " +
                        "FROM acc01h13 WHERE LEFT(acc01h13.po_code, 4) = 'BL03' " +
                        "AND SUBSTRING(acc01h13.po_code, 5, 2) = SUBSTRING('" + trDate + "', 9, 2) " +
                        "AND SUBSTRING(acc01h13.po_code, 7, 2) = SUBSTRING('" + trDate + "', 4, 2) ", con);
                    sdr = cmd.ExecuteReader();
                    if (sdr.HasRows == false)
                    {
                        //throw new Exception();
                        run = "BL03" + dtp_reg.SelectedDate.Value.Year + dtp_reg.SelectedDate.Value.Month + "0001";
                    }
                    else if (sdr.Read())
                    {
                        maxNo = Convert.ToInt32(sdr[0].ToString());
                        run = "BL03" + (dtp_reg.SelectedDate.Value.Year.ToString()).Substring(dtp_reg.SelectedDate.Value.Year.ToString().Length - 2) +
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
                cmd.Parameters.AddWithValue("@PPN", cb_tax1.SelectedValue);
                cmd.Parameters.AddWithValue("@PPNIncl", chk_ppn_incl.Checked);
                cmd.Parameters.AddWithValue("@kurs", Convert.ToDouble(txt_kurs.Value));
                cmd.Parameters.AddWithValue("@pay_code", cb_term.SelectedValue);
                cmd.Parameters.AddWithValue("@JTempo", Convert.ToDouble(txt_term_days.Value));
                cmd.Parameters.AddWithValue("@FreBy", cb_prepared.SelectedValue);
                cmd.Parameters.AddWithValue("@OrdBy", cb_verified.SelectedValue);
                cmd.Parameters.AddWithValue("@AppBy", cb_approved.SelectedValue);
                cmd.Parameters.AddWithValue("@PPPN", Convert.ToDouble(txt_pppn.Value));
                cmd.Parameters.AddWithValue("@JPPN", Convert.ToDouble(txt_tax1_value.Value));
                cmd.Parameters.AddWithValue("@JOTax", Convert.ToDouble(txt_tax2_value.Value));
                cmd.Parameters.AddWithValue("@Net", Convert.ToDouble(txt_total.Value));
                cmd.Parameters.AddWithValue("@Freight", 0);
                cmd.Parameters.AddWithValue("@DP", 0);
                cmd.Parameters.AddWithValue("@OTax", cb_tax2.SelectedValue);
                cmd.Parameters.AddWithValue("@dept_code", cb_cost_center.SelectedValue);
                cmd.Parameters.AddWithValue("@pph", cb_tax3.SelectedValue);
                cmd.Parameters.AddWithValue("@pphIncl", 0);
                cmd.Parameters.AddWithValue("@Owner", txt_owner.Text);
                cmd.Parameters.AddWithValue("@tFullSupply", 0);
                cmd.Parameters.AddWithValue("@poTax", Convert.ToDouble(txt_po_tax.Value));
                cmd.Parameters.AddWithValue("@KursTax", Convert.ToDouble(txt_tax_kurs.Value));
                cmd.Parameters.AddWithValue("@Ket", txt_remark.Text);
                cmd.Parameters.AddWithValue("@NoPO", cb_reff.Text);
                cmd.Parameters.AddWithValue("@KoSub", cb_supplier.SelectedValue);
                cmd.Parameters.AddWithValue("@NamSub", cb_supplier.Text);
                cmd.Parameters.AddWithValue("@KoMat", txt_curr.Text);
                cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
                cmd.Parameters.AddWithValue("@region_code", cb_project.SelectedValue);
                cmd.Parameters.AddWithValue("@OTaxIncl", 0);
                cmd.Parameters.AddWithValue("@Jpph", Convert.ToDouble(txt_tax3_value.Value));
                cmd.Parameters.AddWithValue("@Ppph", Convert.ToDouble(txt_ppph.Value));
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


                foreach (GridDataItem item in RadGrid2.MasterTableView.Items)
                {
                    cmd = new SqlCommand();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Connection = con;
                    cmd.CommandText = "sp_save_invoice_incomingD";
                    cmd.Parameters.AddWithValue("@NoBuk", run);
                    cmd.Parameters.AddWithValue("@prod_type", (item.FindControl("lblProdType") as Label).Text);
                    cmd.Parameters.AddWithValue("@KoBar", (item.FindControl("lblProdCode") as Label).Text);
                    cmd.Parameters.AddWithValue("@Qty", Convert.ToDouble((item.FindControl("txt_qty") as RadNumericTextBox).Value));
                    cmd.Parameters.AddWithValue("@SatQty", (item.FindControl("cb_uom_d") as RadComboBox).Text);
                    cmd.Parameters.AddWithValue("@Harga", Convert.ToDouble((item.FindControl("txt_harga") as RadNumericTextBox).Value));
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
                    cmd.Parameters.AddWithValue("@harga2", Convert.ToDouble((item.FindControl("txt_harga") as RadNumericTextBox).Value));
                    cmd.Parameters.AddWithValue("@prod_code_ori", (item.FindControl("lbl_Prod_code_ori") as Label).Text);
                    cmd.Parameters.AddWithValue("@dept_code", (item.FindControl("lbl_cost_ctr") as Label).Text);
                    cmd.Parameters.AddWithValue("@factor", Convert.ToDouble((item.FindControl("txt_factor") as RadNumericTextBox).Value));
                    cmd.Parameters.AddWithValue("@Asscost", 0);
                    cmd.Parameters.AddWithValue("@noref", cb_reff.SelectedValue);
                    cmd.Parameters.AddWithValue("@tax1", cb_tax1.Text);
                    cmd.Parameters.AddWithValue("@tax2", cb_tax2.Text);
                    cmd.Parameters.AddWithValue("@tax3", cb_tax3.Text);
                    cmd.Parameters.AddWithValue("@KoRek", 0);
                    cmd.Parameters.AddWithValue("@KvrsiQty", 1);
                    cmd.Parameters.AddWithValue("@SatHrg", 0);
                    cmd.Parameters.AddWithValue("@KvrsiHrg", 1);
                    cmd.Parameters.AddWithValue("@TDisc", "%");
                    cmd.Parameters.AddWithValue("@Freight", 0);
                    cmd.Parameters.AddWithValue("@Ass", 0);
                    cmd.Parameters.AddWithValue("@Ket", (item.FindControl("txtRemark_d") as RadTextBox).Text);
                    cmd.Parameters.AddWithValue("@tfactor", 0);
                    //cmd.Parameters.AddWithValue("@RefTransID", 0);
                    cmd.Parameters.AddWithValue("@KoBarH", 0);

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
                txt_reg_code.Text = run;

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

        
    }
}