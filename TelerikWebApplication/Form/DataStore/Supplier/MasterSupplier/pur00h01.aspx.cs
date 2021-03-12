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

namespace TelerikWebApplication.Form.DataStore.Supplier.MasterSupplier
{
    public partial class pur00h01 : System.Web.UI.Page
    {
        public static string koneksi = ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString;
        SqlConnection con = new SqlConnection(koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();
        private const int ItemsPerRequest = 10;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        private static string GetStatusMessage(int offset, int total)
        {
            if (total <= 0)
                return "No matches";

            return String.Format("Items <b>1</b>-<b>{0}</b> out of <b>{1}</b>", offset, total);
        }
        protected void RadGrid1_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            (sender as RadGrid).DataSource = GetDataTable();
        }

        public DataTable GetDataTable()
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select pur00h01.supplier_code, pur00h01.koref, pur00h01.supplier_name, pur00h08.NmGSup, acc00h07.cust_name, pur00h01.norek, acc00h03.cur_name,pur00h08.cur_code,(select accountname from acc00h10 where acc00h10.accountno = pur00h08.korek) as korekName,"+
             " (select accountname from acc00h10 where acc00h10.accountno = pur00h08.um) as umName,"+
             " (select accountname from acc00h10 where acc00h10.accountno = pur00h08.Expense) as expName ," +
             " (select TAX_NAME from acc00h05 where pur00h01.ppn = acc00h05.TAX_CODE) as TAX1NAME ," +
             " (select TAX_NAME from acc00h05 where pur00h01.OTax = acc00h05.TAX_CODE) as OTAX1NAME ," +
             " (select TAX_NAME from acc00h05 where pur00h01.pph = acc00h05.TAX_CODE) as OTAX2NAME ," +
             " pur00h01.rekname, pur00h01.bankname, pur00h04.ShipModeName, pur00h01.limit_ap, Case pur00h01.pay_code When '01' Then 'Cash' When '02' Then 'Credit' else 'COD' End as pay_code," +
             " pur00h01.JTempo, pur00h01.korek, pur00h01.um, pur00h01.Expense, pur00h01.address1, pur00h01.cityName, pur00h01.phone,  pur00h01.NPWP, pur00h01.cityName, pur00h01.fax, pur00h01.email, pur00h01.website, pur00h01.contact1, pur00h01.contact2, pur00h01.hp1, pur00h01.hp2 from pur00h01 LEFT JOIN acc00h07 ON acc00h07.cust_code = pur00h01.koref" +
             " INNER JOIN pur00h08 ON pur00h08.KoGSup = pur00h01.KoGSup INNER JOIN acc00h05 ON pur00h01.ppn = acc00h05.TAX_CODE INNER JOIN pur00h04 ON pur00h04.ShipMode = pur00h01.ShipModeEtd INNER JOIN acc00h03 ON acc00h03.cur_code = pur00h01.cur_code INNER JOIN acc00h10 ON pur00h01.korek = acc00h10.accountno where pur00h01.stedit != '4' ";

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

        private static DataTable Getacc00h07(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select cust_code, acc00h07.cust_code + ' ' + acc00h07.cust_name as cust_name from acc00h07 where cust_code like @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;

        }

        private static DataTable Getacc00h05(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select TAX_CODE, TAX_NAME from acc00h05 where TAX_CODE like @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;

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

        private static DataTable Getpur00h08(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select KoGSup, NmGSup from pur00h08 where KoGSup like @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;

        }

        protected void RadGrid1_InsertCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            GridEditableItem item = (GridEditableItem)e.Item;
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "INSERT INTO pur00h01(supplier_code, koref, supplier_name, cur_code, KoGSup, norek," +
            " rekname, bankname, ppn, OTax, pph, ShipModeEtd, limit_ap, pay_code, JTempo, korek, um, Expense, address1, cityName, "+
            " phone, NPWP, fax, email, website, contact1, contact2, hp1, hp2, Stamp,Usr,Owner,stEdit) VALUES (@supplier_code, @koref, @supplier_name, @cur_code, @KoGSup, @norek," +
            " @rekname, @bankname, @ppn, @OTax, @pph, @ShipModeEtd, @limit_ap, @pay_code, @JTempo, @korek, @um, @Expense, @address1, @cityName, " +
            " @phone, @NPWP, @fax, @email, @website, @contact1, @contact2, @hp1, @hp2, getdate(),UPPER(@Usr),UPPER (@Owner),0)";
            cmd.Parameters.AddWithValue("@supplier_code", (item.FindControl("txt_supplier_code") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@koref", (item.FindControl("cb_refcode") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@supplier_name", (item.FindControl("txt_supplier_name") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@cur_code", (item.FindControl("txt_cur") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@KoGSup", (item.FindControl("cb_group") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@ppn", (item.FindControl("cb_tax") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@OTax", (item.FindControl("cb_tax1") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@pph", (item.FindControl("cb_tax2") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@ShipModeEtd", (item.FindControl("cb_shipmode") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@limit_ap", Convert.ToDouble((item.FindControl("txt_limit_ap") as RadNumericTextBox).Text));
            cmd.Parameters.AddWithValue("@pay_code", (item.FindControl("cb_paycode") as RadComboBox).SelectedValue);
            if ((item.FindControl("cb_paycode") as RadComboBox).Text == "Cash")
            {
                cmd.Parameters.AddWithValue("@JTempo", Convert.ToDouble("0"));
            }
            else
            {
                cmd.Parameters.AddWithValue("@JTempo", Convert.ToDouble((item.FindControl("txt_JTempo") as RadNumericTextBox).Text));
            }
            
            cmd.Parameters.AddWithValue("@korek", (item.FindControl("txt_korek") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@um", (item.FindControl("txt_um") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@Expense", (item.FindControl("txt_expense") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@address1", (item.FindControl("txt_address1") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@cityName", (item.FindControl("txt_cityName") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@phone", (item.FindControl("txt_phone") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@NPWP", (item.FindControl("txt_NPWP") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@fax", (item.FindControl("txt_fax") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@email", (item.FindControl("txt_email") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@website", (item.FindControl("txt_website") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@contact1", (item.FindControl("txt_contact1") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@contact2", (item.FindControl("txt_contact2") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@hp1", (item.FindControl("txt_hp1") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@hp2", (item.FindControl("txt_hp2") as RadTextBox).Text);
            //cmd.Parameters.AddWithValue("@postcode", (item.FindControl("txt_postcode") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@norek", (item.FindControl("txt_norek") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@rekname", (item.FindControl("txt_rekname") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@bankname", (item.FindControl("txt_bank_name") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
            cmd.Parameters.AddWithValue("@Owner", public_str.user_id);
            cmd.Parameters.AddWithValue("@status", "0");
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void RadGrid1_UpdateCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            GridEditFormItem item = (GridEditFormItem)e.Item;
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "UPDATE pur00h01 set supplier_code = @supplier_code, koref = @koref, supplier_name = @supplier_name, cur_code = @cur_code, KoGSup = @KoGSup, norek = @norek," +
            " rekname = @rekname, bankname = @bankname, ppn = @ppn, OTax = @OTax, pph = @pph,ShipModeEtd = @ShipModeEtd, limit_ap = @limit_ap,pay_code = @pay_code,JTempo = @JTempo,korek = @korek,um = @um,Expense = @Expense,address1 = @address1,cityName = @cityName, " +
            " phone = @phone, NPWP = @NPWP, fax = @fax, email = @email, website = @website, contact1 = @contact1, contact2 = @contact2, hp1 = @hp1, hp2 = @hp2, LastUpdate = getdate(), Usr = UPPER(@Usr) where supplier_code = @supplier_code";
            cmd.Parameters.AddWithValue("@supplier_code", (item.FindControl("txt_supplier_code") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@koref", (item.FindControl("cb_group") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@supplier_name", (item.FindControl("txt_supplier_name") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@cur_code", (item.FindControl("txt_cur") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@KoGSup", (item.FindControl("cb_group") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@ppn", (item.FindControl("cb_tax") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@OTax", (item.FindControl("cb_tax1") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@pph", (item.FindControl("cb_tax2") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@ShipModeEtd", (item.FindControl("cb_shipmode") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@limit_ap", Convert.ToDouble((item.FindControl("txt_limit_ap") as RadNumericTextBox).Text));
            cmd.Parameters.AddWithValue("@pay_code", (item.FindControl("cb_paycode") as RadComboBox).SelectedValue);
            if ((item.FindControl("cb_paycode") as RadComboBox).Text == "Cash")
            {
                cmd.Parameters.AddWithValue("@JTempo", Convert.ToDouble("0"));
            }
            else
            {
                cmd.Parameters.AddWithValue("@JTempo", Convert.ToDouble((item.FindControl("txt_JTempo") as RadNumericTextBox).Text));
            }
            cmd.Parameters.AddWithValue("@korek", (item.FindControl("txt_korek") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@um", (item.FindControl("txt_um") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@Expense", (item.FindControl("txt_expense") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@address1", (item.FindControl("txt_address1") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@cityName", (item.FindControl("txt_cityName") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@phone", (item.FindControl("txt_phone") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@NPWP", (item.FindControl("txt_NPWP") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@fax", (item.FindControl("txt_fax") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@email", (item.FindControl("txt_email") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@website", (item.FindControl("txt_website") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@contact1", (item.FindControl("txt_contact1") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@contact2", (item.FindControl("txt_contact2") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@hp1", (item.FindControl("txt_hp1") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@hp2", (item.FindControl("txt_hp2") as RadTextBox).Text);
            //cmd.Parameters.AddWithValue("@postcode", (item.FindControl("txt_postcode") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@norek", (item.FindControl("txt_norek") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@rekname", (item.FindControl("txt_rekname") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@bankname", (item.FindControl("txt_bank_name") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void RadGrid1_DeleteCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            var productId = ((GridDataItem)e.Item).GetDataKeyValue("supplier_code");

            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "update pur00h01 set stEdit = 4, LastUpdate = getdate(), Usr = @Usr where supplier_code = @supplier_code";
            cmd.Parameters.AddWithValue("@supplier_code", productId);
            cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void RadGrid1_ItemCreated(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
            if (e.Item is GridEditableItem & e.Item.IsInEditMode)
            {
                GridEditFormItem item = (GridEditFormItem)e.Item;
                RadTextBox txt = (item.FindControl("txt_supplier_code") as RadTextBox);
                if (e.Item.OwnerTableView.IsItemInserted)
                    txt.Enabled = true;
                else
                    txt.Enabled = false;
            }
        }

        protected void cb_refcode_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = Getcust_code(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["cust_name"].ToString(), data.Rows[i]["cust_name"].ToString()));
            }
        }

        private static DataTable Getcust_code(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select cust_code +' '+ cust_name as cust_name from acc00h07 where stEdit != 4 " +
                " AND cust_code +' '+ cust_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;

        }
        protected void cb_refcode_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select cust_code from acc00h07 WHERE cust_code +' '+ cust_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["cust_code"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_refcode_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select cust_code from acc00h07 WHERE cust_code +' '+ cust_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["cust_code"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_group_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = Getgroup(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["NmGSup"].ToString(), data.Rows[i]["NmGSup"].ToString()));
            }
        }

        public static DataTable Getgroup(string Text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select NmGSup as NmGSup from pur00h08 where stEdit != 4 " +
                  " AND NmGSup LIKE @text + '%'",
              ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", Text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;

        }
       
        protected void cb_group_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT pur00h08.* ,(select accountname from acc00h10 where acc00h10.accountno = pur00h08.korek) as korekName," +
            " (select accountname from acc00h10 where acc00h10.accountno = pur00h08.um) as umName,"+
            " (select accountname from acc00h10 where acc00h10.accountno = pur00h08.Expense) as expName, acc00h03.cur_name " +
            " FROM pur00h08 INNER JOIN acc00h03 ON pur00h08.cur_code = acc00h03.cur_code  WHERE NmGSup = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["KoGSup"].ToString();
            dr.Close();

            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adapter.Fill(dt);
            foreach (DataRow dr1 in dt.Rows)
            {
                RadComboBox cb = (RadComboBox)sender;
                GridEditableItem item = (GridEditableItem)cb.NamingContainer;
                RadTextBox txtCurr = (RadTextBox)item.FindControl("txt_cur");
                RadTextBox txtCurName = (RadTextBox)item.FindControl("txt_cur_name");
                RadTextBox txtKorek = (RadTextBox)item.FindControl("txt_korek");
                RadTextBox txtKorekname = (RadTextBox)item.FindControl("txt_korekname");
                RadTextBox txtUm = (RadTextBox)item.FindControl("txt_um");
                RadTextBox txtUmname = (RadTextBox)item.FindControl("txt_umname");
                RadTextBox txtExpense = (RadTextBox)item.FindControl("txt_expense");
                RadTextBox txtExpensename = (RadTextBox)item.FindControl("txt_expensename");
                //RadTextBox txtCurr = item.FindControl("txt_cur") as RadTextBox;
                txtCurr.Text = dr1["cur_code"].ToString();
                txtCurName.Text = dr1["cur_name"].ToString();
                txtKorek.Text = dr1["korek"].ToString();
                txtKorekname.Text = dr1["korekName"].ToString();
                txtUm.Text = dr1["um"].ToString();
                txtUmname.Text = dr1["umName"].ToString();
                txtExpense.Text = dr1["Expense"].ToString();
                txtExpensename.Text = dr1["expName"].ToString();
            }
            con.Close();
        }

        protected void cb_group_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT KoGSup FROM pur00h08 WHERE NmGSup = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["KoGSup"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_tax_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetTax(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["TAX_NAME"].ToString(), data.Rows[i]["TAX_NAME"].ToString()));
            }
        }

        private static DataTable GetTax(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select TAX_CODE, TAX_NAME from acc00h05 where TAX_CODE like @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;

        }
        protected void cb_tax_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select TAX_CODE from acc00h05 where TAX_NAME = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["TAX_CODE"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_tax_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select TAX_CODE from acc00h05 where TAX_NAME = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["TAX_CODE"].ToString();
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
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["TAX_NAME"].ToString(), data.Rows[i]["TAX_NAME"].ToString()));
            }
        }

        protected void cb_tax1_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select TAX_CODE from acc00h05 where TAX_NAME = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["TAX_CODE"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_tax1_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select TAX_CODE from acc00h05 where TAX_NAME = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["TAX_CODE"].ToString();
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
        }

        protected void cb_tax2_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select TAX_CODE from acc00h05 where TAX_NAME = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["TAX_CODE"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_tax2_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select TAX_CODE from acc00h05 where TAX_NAME = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["TAX_CODE"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_shipmode_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetShip(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["ShipModeName"].ToString(), data.Rows[i]["ShipModeName"].ToString()));
            }
        }

        private static DataTable GetShip(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select ShipMode, ShipModeName from pur00h04 where ShipMode like @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;

        }
        protected void cb_shipmode_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
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

        protected void cb_shipmode_PreRender(object sender, EventArgs e)
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

        protected void cb_paycode_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Clear();
            (sender as RadComboBox).Items.Add("Cash");
            (sender as RadComboBox).Items.Add("Credit");
            (sender as RadComboBox).Items.Add("COD");
        }

        protected void cb_paycode_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
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

        protected void cb_paycode_PreRender(object sender, EventArgs e)
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

        protected void btn_new_Click(object sender, EventArgs e)
        {
            RadGrid1.MasterTableView.IsItemInserted = true;
            RadGrid1.MasterTableView.Rebind();
        }
    }
}