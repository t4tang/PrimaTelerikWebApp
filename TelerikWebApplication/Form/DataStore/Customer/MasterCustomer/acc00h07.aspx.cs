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

namespace TelerikWebApplication.Form.DataStore.Customer.MasterCustomer
{
    public partial class acc00h07 : System.Web.UI.Page
    {
        public static string koneksi = ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString;
        SqlConnection con = new SqlConnection(koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();
        private const int ItemsPerRequest = 10;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public DataTable GetDataTable()
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select acc00h07.cust_code, acc00h07.cust_name, acc00h07.ref_code, acc00h07.con_person, acc00h07.hp_no, acc00h07.email, " +
		                        "case acc00h07.pay_code when 'Cash' Then '01' When 'Kredit' Then '03' Else 'COD' End As pay_code, acc00h07.pay_city, acc00h07.pay_kind, acc00h07.pay_add, acc00h07.pay_phone, " + 
                                "acc00h07.pay_sli_code, acc00h07.pay_slj_code, acc00h07.pay_phone, acc00h07.pay_postal, acc00h07.pay_fax_num, acc00h07.send_city, acc00h07.send_kind, acc00h07.send_add, " + 
                                "acc00h07.send_sli_code, acc00h07.send_slj_code, acc00h07.send_phone, acc00h07.sen_postal, acc00h07.sen_fax_num, case acc00h07.cust_kind when 'Dalam Kota' Then '01' Else '02' End as cust_kind, " + 
                                "acc00h07.cust_limit, acc00h07.limit_day, acc00h07.remark, acc00h07.tax_address, acc00h07.status, acc00h07.date_enter, acc00h07.npwp_no, acc00h07.NPPKP, acc00h07.lastupdate, acc00h07.userid, " + 
                                "acc00h07.stEdit, acc00h07.discount, acc00h07.pay_code, acc00h07.account_no, acc00h07.account_no2, acc00h07.RekDP, acc00h07.korek, pur00h04.ShipModeName, sls00h01.sales_name, " +
                                "acc00h03.cur_name, pur00h01.supplier_name, inv00h27.sar_name, acc00h10.accountno +' '+ accountname as accountname1, acc00h10.accountno +' '+ accountname as accountname2 " +
                            "from acc00h07 LEFT JOIN pur00h01 ON pur00h01.supplier_code = acc00h07.ref_code INNER JOIN pur00h04 ON acc00h07.cust_kind = pur00h04.ShipMode INNER JOIN " +
                                "acc00h03 ON acc00h07.cur_code = acc00h03.cur_code INNER JOIN inv00h27 ON acc00h07.sar_code = inv00h27.sar_code INNER JOIN " +
                                "sls00h01 ON acc00h07.sales_code = sls00h01.sales_code INNER JOIN inv00h25 ON acc00h07.send_city = inv00h25.city_code AND inv00h25.city_code = acc00h07.pay_city INNER JOIN " +
                                "acc00h10 ON acc00h07.RekDP = acc00h10.accountno LEFT JOIN acc00h01 ON acc00h07.account_no = acc00h01.KoBank where acc00h07.stedit != '4'";
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

        protected void RadGrid1_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            (sender as RadGrid).DataSource = GetDataTable();
        }

        protected void RadGrid1_ItemCreated(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridEditableItem & e.Item.IsInEditMode)
            {
                GridEditFormItem item = (GridEditFormItem)e.Item;
                RadTextBox txt = (item.FindControl("txt_cust_code") as RadTextBox);
                if (e.Item.OwnerTableView.IsItemInserted)
                    txt.Enabled = true;
                else
                    txt.Enabled = false;
            }
        }

        protected void RadGrid1_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            var productId = ((GridDataItem)e.Item).GetDataKeyValue("cust_code");

            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "Update acc00h07 SET stEdit = 4 where cust_code = @cust_code";
            cmd.Parameters.AddWithValue("@cust_code", productId);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void RadGrid1_UpdateCommand(object sender, GridCommandEventArgs e)
        {
            GridEditFormItem item = (GridEditFormItem)e.Item;
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "UPDATE acc00h07 set cust_code = @cust_code, ref_code = @ref_code, cust_name = @cust_name, sar_code = @sar_code, con_person = @con_person, " +
                                "npwp_no = @npwp_no, hp_no = @hp_no, cur_code = @cur_code, email = @email, cust_kind = @cust_kind, cust_limit = @cust_limit, limit_day = @limit_day, " +
                                "pay_kind = @pay_kind, sales_code = @sales_code, send_kind = @send_kind, account_no = @account_no, NPPKP = @NPPKP, account_no2 = @account_no2, " +
                                "tax_address = @tax_address, korek = @korek, RekDP = @RekDP, pay_add = @pay_add, pay_city = @pay_city, " +
                                "pay_postal = @pay_postal, pay_sli_code = @pay_sli_code, pay_slj_code = @pay_slj_code, pay_phone = @pay_phone,pay_fax_num = @pay_fax_num, send_add = @send_add, send_city = @send_city, " +
                                "sen_postal = @sen_postal, send_sli_code = @send_sli_code, send_slj_code = @send_slj_code, send_phone = @send_phone,sen_fax_num = @sen_fax_num, lastupdate = getdate(), userid = @userid, stEdit = '0' ";
            cmd.Parameters.AddWithValue("@cust_code", (item.FindControl("txt_cust_code") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@ref_code", (item.FindControl("cb_reff") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@cust_name", (item.FindControl("txt_cust_name") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@sar_code", (item.FindControl("cb_area") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@con_person", (item.FindControl("txt_con_person") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@npwp_no", (item.FindControl("txt_npwp") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@hp_no", (item.FindControl("txt_phone") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@cur_code", (item.FindControl("cb_currency") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@email", (item.FindControl("txt_email") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@cust_kind", (item.FindControl("cb_kind") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@cust_limit", (item.FindControl("txt_credit") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@limit_day", (item.FindControl("txt_limit_day") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@pay_kind", (item.FindControl("cb_payment") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@sales_code", (item.FindControl("cb_sales") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@send_kind", (item.FindControl("cb_send_mode") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@account_no", (item.FindControl("cb_account1") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@NPPKP", (item.FindControl("txt_nppkp") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@account_no2", (item.FindControl("cb_account2") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@tax_address", (item.FindControl("txt_tax_addr") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@korek", (item.FindControl("cb_ar") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@RekDP", (item.FindControl("cb_dp") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@pay_add", (item.FindControl("txt_pay_add") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@pay_city", (item.FindControl("cb_city") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@pay_postal", (item.FindControl("txt_zip") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@pay_sli_code", (item.FindControl("txt_sli") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@pay_slj_code", (item.FindControl("txt_slj") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@pay_phone", (item.FindControl("txt_pay_phone") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@pay_fax_num", (item.FindControl("txt_fax") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@send_add", (item.FindControl("txt_send_add") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@send_city", (item.FindControl("cb_send_city") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@sen_postal", (item.FindControl("txt_send_postal") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@send_sli_code", (item.FindControl("txt_sli_code2") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@send_slj_code", (item.FindControl("txt_slj_code2") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@send_phone", (item.FindControl("txt_send_phone") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@sen_fax_num", (item.FindControl("txt_send_fax") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@userid", public_str.user_id);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void RadGrid1_InsertCommand(object sender, GridCommandEventArgs e)
        {
            GridEditableItem item = (GridEditableItem)e.Item;
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "insert into acc00h07(cust_code,cust_name,sar_code,con_person,npwp_no,hp_no,cur_code,email, " +
                                "cust_kind,cust_limit,limit_day,pay_kind,sales_code,send_kind,account_no,NPPKP,account_no2,tax_address,korek, " +
                                "RekDP,pay_add,pay_city,pay_postal,pay_sli_code,pay_slj_code,pay_phone,pay_fax_num,send_add,send_city,sen_postal, " +
                                "send_sli_code,send_slj_code,send_phone,sen_fax_num, userid, lastupdate,stEdit) " +
                                "values(@cust_code, @cust_name, @sar_code, @con_person, @npwp_no, @hp_no, @cur_code, @email, @cust_kind, " +
                                "@cust_limit, @limit_day, @pay_kind, @sales_code, @send_kind, @account_no, @NPPKP, @account_no2, @tax_address, @korek, @RekDP, " +
                                "@pay_add, @pay_city, @pay_postal, @pay_sli_code, @pay_slj_code, @pay_phone, @pay_fax_num, @send_add, @send_city, @sen_postal, @send_sli_code,  " +
                                "@send_slj_code, @send_phone, @sen_fax_num, @userid, GETDATE(), '0')";
            cmd.Parameters.AddWithValue("@cust_code", (item.FindControl("txt_cust_code") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@supplier_name", (item.FindControl("cb_reff") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@cust_name", (item.FindControl("txt_cust_name") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@sar_code", (item.FindControl("cb_area") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@con_person", (item.FindControl("txt_con_person") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@npwp_no", (item.FindControl("txt_npwp") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@hp_no", (item.FindControl("txt_phone") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@cur_code", (item.FindControl("cb_currency") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@email", (item.FindControl("txt_email") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@cust_kind", (item.FindControl("cb_kind") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@cust_limit", (item.FindControl("txt_credit") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@limit_day", (item.FindControl("txt_limit_day") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@pay_kind", (item.FindControl("cb_payment") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@sales_code", (item.FindControl("cb_sales") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@send_kind", (item.FindControl("cb_send_mode") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@account_no", (item.FindControl("cb_account1") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@NPPKP", (item.FindControl("txt_nppkp") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@account_no2", (item.FindControl("cb_account2") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@tax_address", (item.FindControl("txt_tax_addr") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@korek", (item.FindControl("cb_ar") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@RekDP", (item.FindControl("cb_dp") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@pay_add", (item.FindControl("txt_pay_add") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@pay_city", (item.FindControl("cb_city") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@pay_postal", (item.FindControl("txt_zip") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@pay_sli_code", (item.FindControl("txt_sli") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@pay_slj_code", (item.FindControl("txt_slj") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@pay_phone", (item.FindControl("txt_pay_phone") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@pay_fax_num", (item.FindControl("txt_fax") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@send_add", (item.FindControl("txt_send_add") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@send_city", (item.FindControl("cb_send_city") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@sen_postal", (item.FindControl("txt_send_postal") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@send_sli_code", (item.FindControl("txt_sli_code2") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@send_slj_code", (item.FindControl("txt_slj_code2") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@send_phone", (item.FindControl("txt_send_phone") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@sen_fax_num", (item.FindControl("txt_send_fax") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@userid", public_str.user_id);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        private static DataTable Getpur00h04(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select ShipMode, ShipModeName from pur00h04 where ShipMode like @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;

        }

        private static DataTable Getpur00h01(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select supplier_code, pur00h01.supplier_code + ' ' + pur00h01.supplier_name as supplier_name from pur00h01 where supplier_code like @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;

        }

        private static DataTable Getsls00h01(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select sales_code, sales_name from sls00h01 where sales_code like @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;

        }

        private static DataTable Getacc00h01(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select NoRek, acc00h01.NoRek + ' ' + acc00h01.NamBank as NamBank from acc00h01 where NoRek like @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;

        }

        private static DataTable Getinv00h27(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select sar_code, sar_name from inv00h27 where sar_code like @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;

        }

        private static DataTable Getacc00h03(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select cur_code, cur_name from acc00h03 where cur_code like @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;

        }

        private static DataTable Getacc00h10(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select accountno, acc00h10.accountno + ' ' + acc00h10.accountname as accountname from acc00h10 where accountno like @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;

        }

        private static DataTable Getinv00h25(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select city_code, city_name from inv00h25 where city_code like @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;

        }

        private static DataTable Getsupplier_code(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select supplier_code +' '+ supplier_name as supplier_name from pur00h01 where stEdit != 4 " +
                " AND supplier_code +' '+ supplier_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;

        }

        protected void cb_reff_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = Getsupplier_code(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["supplier_name"].ToString(), data.Rows[i]["supplier_name"].ToString()));
            }
        }

        protected void cb_reff_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select supplier_code from pur00h01 WHERE supplier_code +' '+ supplier_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["supplier_code"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_reff_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select supplier_code from pur00h01 WHERE supplier_code +' '+ supplier_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["supplier_code"].ToString();
            dr.Close();
            con.Close();
        }

        public static DataTable GetShipMode(string Text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select ShipMode, ShipModeName from pur00h04 where ShipMode like @text + '%'",
              ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", Text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;

        }

        protected void cb_send_mode_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetShipMode(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["ShipModeName"].ToString(), data.Rows[i]["ShipModeName"].ToString()));
            }
        }

        protected void cb_send_mode_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select ShipMode from pur00h04 where ShipModeName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["ShipMode"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_send_mode_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select ShipMode from pur00h04 where ShipModeName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["ShipMode"].ToString();
            dr.Close();
            con.Close();
        }

        private static DataTable Getcur(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select cur_name as cur_name from acc00h03 where stEdit != 4 " +
                                                        " AND cur_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;

        }

        protected void cb_currency_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select(accountno + ' ' + accountname) as accountname1, (accountno + ' ' + accountname) as accountname2, acc00h03.cur_name " +
                                   "from acc00h03 inner join acc00h10 on acc00h03.cur_code = acc00h10.cur_code where cur_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["cur_code"].ToString();
            dr.Close();

            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adapter.Fill(dt);
            foreach (DataRow dr1 in dt.Rows)
            {
                RadComboBox cb = (RadComboBox)sender;
                GridEditableItem item = (GridEditableItem)cb.NamingContainer;
                RadComboBox cbAccount1 = (RadComboBox)item.FindControl("cb_ar");
                RadComboBox cbAccount2 = (RadComboBox)item.FindControl("cb_dp");
                cbAccount1.SelectedValue = dr1["accountname1"].ToString();
                cbAccount2.SelectedValue = dr1["accountname2"].ToString();
            }
            con.Close();
        }

        protected void cb_currency_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = Getcur(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["cur_name"].ToString(), data.Rows[i]["cur_name"].ToString()));
            }
        }

        protected void cb_currency_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT cur_code FROM acc00h03 WHERE cur_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["cur_code"].ToString();
            dr.Close();
            con.Close();
        }

        private static DataTable Getsales(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select sales_code, sales_name from sls00h01 where sales_code like @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;

        }

        protected void cb_sales_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = Getsales(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["sales_name"].ToString(), data.Rows[i]["sales_name"].ToString()));
            }
        }

        protected void cb_sales_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select sales_code from sls00h01 where sales_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["sales_code"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_sales_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select sales_code from sls00h01 where sales_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["sales_code"].ToString();
            dr.Close();
            con.Close();
        }

        private static DataTable Getarea(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select sar_code, sar_name from inv00h27 where sar_code like @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;

        }

        protected void cb_area_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select sar_code from inv00h27 where sar_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["sar_code"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_area_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = Getarea(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["sar_name"].ToString(), data.Rows[i]["sar_name"].ToString()));
            }
        }

        protected void cb_area_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select sar_code from inv00h27 where sar_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["sar_code"].ToString();
            dr.Close();
            con.Close();
        }

        private static DataTable GetBank(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select NoRek +' '+ NamBank as NamBank from acc00h01 where stEdit != 4 " +
                " AND NoRek +' '+ NamBank LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;

        }

        protected void cb_account1_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetBank(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["NamBank"].ToString(), data.Rows[i]["NamBank"].ToString()));
            }
        }

        protected void cb_account1_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select KoBank from acc00h01 WHERE KoBank +' '+ NamBank = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["KoBank"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_account1_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select KoBank from acc00h01 WHERE KoBank +' '+ NamBank = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["KoBank"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_account2_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetBank(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["NamBank"].ToString(), data.Rows[i]["NamBank"].ToString()));
            }
        }

        protected void cb_account2_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select KoBank from acc00h01 WHERE NoRek +' '+ NamBank = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["KoBank"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_account2_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select KoBank from acc00h01 WHERE KoBank +' '+ NamBank = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["NoRek"].ToString();
            dr.Close();
            con.Close();
        }

        private static DataTable Getaccount(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select accountno +' '+ accountname as accountname from acc00h10 where stEdit != 4 " +
                " AND accountno +' '+ accountname LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;

        }

        protected void cb_ar_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = Getaccount(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["accountname"].ToString(), data.Rows[i]["accountname"].ToString()));
            }
        }

        protected void cb_ar_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select accountno from acc00h10 WHERE accountno +' '+ accountname = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["accountno"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_ar_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select accountno from acc00h10 WHERE accountno +' '+ accountname = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["accountno"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_dp_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = Getaccount(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["accountname"].ToString(), data.Rows[i]["accountname"].ToString()));
            }
        }

        protected void cb_dp_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select accountno from acc00h10 WHERE accountno +' '+ accountname = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["accountno"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_dp_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select accountno from acc00h10 WHERE accountno +' '+ accountname = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["accountno"].ToString();
            dr.Close();
            con.Close();
        }

        private static DataTable Getcity(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select city_code, city_name from inv00h25 where city_code like @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;

        }

        protected void cb_city_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = Getcity(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["city_name"].ToString(), data.Rows[i]["city_name"].ToString()));
            }
        }

        protected void cb_city_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select city_code from inv00h25 where city_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["city_code"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_city_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select city_code from inv00h25 where city_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["city_code"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_payment_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Clear();
            (sender as RadComboBox).Items.Add("Cash");
            (sender as RadComboBox).Items.Add("Credit");
            (sender as RadComboBox).Items.Add("COD");
        }

        protected void cb_payment_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadComboBox).Text == "Cash")
            {
                (sender as RadComboBox).SelectedValue = "01";
            }
            else if ((sender as RadComboBox).Text == "Credit")
            {
                (sender as RadComboBox).SelectedValue = "02";
            }
            else
            {
                (sender as RadComboBox).SelectedValue = "03";
            }
        }

        protected void cb_payment_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if ((sender as RadComboBox).Text == "Cash")
            {
                (sender as RadComboBox).SelectedValue = "01";

            }
            else if ((sender as RadComboBox).Text == "Credit")
            {
                (sender as RadComboBox).SelectedValue = "02";
            }
            else
            {
                (sender as RadComboBox).SelectedValue = "03";
            }
        }

        protected void cb_kind_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Clear();
            (sender as RadComboBox).Items.Add("Dalam Kota");
            (sender as RadComboBox).Items.Add("Luar Kota");
        }

        protected void cb_kind_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadComboBox).Text == "Dalam Kota")
            {
                (sender as RadComboBox).SelectedValue = "01";
            }
            else
            {
                (sender as RadComboBox).SelectedValue = "02";
            }
        }

        protected void cb_kind_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if ((sender as RadComboBox).Text == "Dalam Kota")
            {
                (sender as RadComboBox).SelectedValue = "01";
            }
            else
            {
                (sender as RadComboBox).SelectedValue = "02";
            }
        }

        protected void cb_send_city_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = Getcity(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["city_name"].ToString(), data.Rows[i]["city_name"].ToString()));
            }
        }

        protected void cb_send_city_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select city_code from inv00h25 where city_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["city_code"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_send_city_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select city_code from inv00h25 where city_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["city_code"].ToString();
            dr.Close();
            con.Close();
        }
    }
}
