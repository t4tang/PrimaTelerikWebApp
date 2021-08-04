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
            cmd.CommandText = "select ms_supplier.supplier_code, ms_supplier.koref, ms_supplier.supplier_name, ms_Group_Supplier.NmGSup, ms_customer.cust_name, ms_supplier.norek, ms_currency.cur_name,ms_Group_Supplier.cur_code,(select accountname from gl_account where gl_account.accountno = ms_Group_Supplier.korek) as korekName,"+
             " (select accountname from gl_account where gl_account.accountno = ms_Group_Supplier.um) as umName,"+
             " (select accountname from gl_account where gl_account.accountno = ms_Group_Supplier.Expense) as expName ," +
             " (select TAX_NAME from MS_TAX where ms_supplier.ppn = MS_TAX.TAX_CODE) as TAX1NAME ," +
             " (select TAX_NAME from MS_TAX where ms_supplier.OTax = MS_TAX.TAX_CODE) as OTAX1NAME ," +
             " (select TAX_NAME from MS_TAX where ms_supplier.pph = MS_TAX.TAX_CODE) as OTAX2NAME ," +
             " ms_supplier.rekname, ms_supplier.bankname, ms_kirim.ShipModeName, ms_supplier.limit_ap, Case ms_supplier.pay_code When '01' Then 'Cash' When '02' Then 'Credit' else 'COD' End as pay_code," +
             " ms_supplier.JTempo, ms_supplier.korek, ms_supplier.um, ms_supplier.Expense, ms_supplier.address1, ms_supplier.cityName, ms_supplier.phone,  ms_supplier.NPWP, ms_supplier.cityName, ms_supplier.fax, ms_supplier.email, ms_supplier.website, ms_supplier.contact1, ms_supplier.contact2, ms_supplier.hp1, ms_supplier.hp2 from ms_supplier LEFT JOIN ms_customer ON ms_customer.cust_code = ms_supplier.koref" +
             " INNER JOIN ms_Group_Supplier ON ms_Group_Supplier.KoGSup = ms_supplier.KoGSup INNER JOIN MS_TAX ON ms_supplier.ppn = MS_TAX.TAX_CODE INNER JOIN ms_kirim ON ms_kirim.ShipMode = ms_supplier.ShipModeEtd INNER JOIN ms_currency ON ms_currency.cur_code = ms_supplier.cur_code INNER JOIN gl_account ON ms_supplier.korek = gl_account.accountno where ms_supplier.stedit != '4' ";

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

        private static DataTable Getms_customer(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select cust_code, ms_customer.cust_code + ' ' + ms_customer.cust_name as cust_name from ms_customer where cust_code like @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;

        }

        private static DataTable GetMS_TAX(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select TAX_CODE, TAX_NAME from MS_TAX where TAX_CODE like @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;

        }

        private static DataTable Getms_kirim(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select ShipMode, ShipModeName from ms_kirim where ShipMode like @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;

        }

        private static DataTable Getms_Group_Supplier(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select KoGSup, NmGSup from ms_Group_Supplier where KoGSup like @text + '%'",
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
            cmd.CommandText = "INSERT INTO ms_supplier(supplier_code, koref, supplier_name, cur_code, KoGSup, norek," +
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
            cmd.CommandText = "UPDATE ms_supplier set supplier_code = @supplier_code, koref = @koref, supplier_name = @supplier_name, cur_code = @cur_code, KoGSup = @KoGSup, norek = @norek," +
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
            cmd.CommandText = "update ms_supplier set stEdit = 4, LastUpdate = getdate(), Usr = @Usr where supplier_code = @supplier_code";
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
            SqlDataAdapter adapter = new SqlDataAdapter("select cust_code +' '+ cust_name as cust_name from ms_customer where stEdit != 4 " +
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
            cmd.CommandText = "select cust_code from ms_customer WHERE cust_code +' '+ cust_name = '" + (sender as RadComboBox).Text + "'";
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
            cmd.CommandText = "select cust_code from ms_customer WHERE cust_code +' '+ cust_name = '" + (sender as RadComboBox).Text + "'";
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
            SqlDataAdapter adapter = new SqlDataAdapter("select NmGSup as NmGSup from ms_Group_Supplier where stEdit != 4 " +
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
            cmd.CommandText = "SELECT ms_Group_Supplier.* ,(select accountname from gl_account where gl_account.accountno = ms_Group_Supplier.korek) as korekName," +
            " (select accountname from gl_account where gl_account.accountno = ms_Group_Supplier.um) as umName,"+
            " (select accountname from gl_account where gl_account.accountno = ms_Group_Supplier.Expense) as expName, ms_currency.cur_name " +
            " FROM ms_Group_Supplier INNER JOIN ms_currency ON ms_Group_Supplier.cur_code = ms_currency.cur_code  WHERE NmGSup = '" + (sender as RadComboBox).Text + "'";
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
            cmd.CommandText = "SELECT KoGSup FROM ms_Group_Supplier WHERE NmGSup = '" + (sender as RadComboBox).Text + "'";
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
            SqlDataAdapter adapter = new SqlDataAdapter("select TAX_CODE, TAX_NAME from MS_TAX where TAX_CODE like @text + '%'",
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
            cmd.CommandText = "select TAX_CODE from MS_TAX where TAX_NAME = '" + (sender as RadComboBox).Text + "'";
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
            cmd.CommandText = "select TAX_CODE from MS_TAX where TAX_NAME = '" + (sender as RadComboBox).Text + "'";
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
            cmd.CommandText = "select TAX_CODE from MS_TAX where TAX_NAME = '" + (sender as RadComboBox).Text + "'";
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
            cmd.CommandText = "select TAX_CODE from MS_TAX where TAX_NAME = '" + (sender as RadComboBox).Text + "'";
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
            cmd.CommandText = "select TAX_CODE from MS_TAX where TAX_NAME = '" + (sender as RadComboBox).Text + "'";
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
            cmd.CommandText = "select TAX_CODE from MS_TAX where TAX_NAME = '" + (sender as RadComboBox).Text + "'";
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
            SqlDataAdapter adapter = new SqlDataAdapter("select ShipMode, ShipModeName from ms_kirim where ShipMode like @text + '%'",
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
            cmd.CommandText = "select ShipMode from ms_kirim where ShipModeName = '" + (sender as RadComboBox).Text + "'";
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
            cmd.CommandText = "select ShipMode from ms_kirim where ShipModeName = '" + (sender as RadComboBox).Text + "'";
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