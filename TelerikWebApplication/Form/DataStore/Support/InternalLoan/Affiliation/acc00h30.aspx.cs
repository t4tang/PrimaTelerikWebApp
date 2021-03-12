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

namespace TelerikWebApplication.Form.DataStore.Support.InternalLoan.Affiliation
{
    public partial class acc00h30 : System.Web.UI.Page
    {
        public static string koneksi = ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString;
        SqlConnection con = new SqlConnection(koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();
        private const int ItemsPerRequest = 10;
        protected void Page_Load(object sender, EventArgs e)
        {

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
            cmd.CommandText = "select acc00h30.emp_code, acc00h30.emp_name, acc00h30.cur_code, acc00h30.alamat, acc00h30.ref_code, acc00h03.cur_name, inv00h11.CostCenterName, inv00h09.region_name, acc00h29.NmGAfi, " +
                " (select accountno +' '+ accountname from acc00h10 where acc00h10.accountno = acc00h30.korek) as korekname,acc00h30.korek, " +
                " (select accountno +' '+ accountname from acc00h10 where acc00h10.accountno = acc00h30.norek) as norekname,acc00h30.norek, " +
                " (select accountno +' '+ accountname from acc00h10 where acc00h10.accountno = acc00h30.um) as umname,acc00h30.um, " +
                " (select accountno +' '+ accountname from acc00h10 where acc00h10.accountno = acc00h30.ar_inter) as ar_intername,acc00h30.ar_inter, " +
                " (select accountno +' '+ accountname from acc00h10 where acc00h10.accountno = acc00h30.inc_inter) as inc_intername,acc00h30.inc_inter, " +
                " (select accountno +' '+ accountname from acc00h10 where acc00h10.accountno = acc00h30.ap_inter) as ap_intername,acc00h30.ap_inter, " +
                " (select accountno +' '+ accountname from acc00h10 where acc00h10.accountno = acc00h30.ap_accrued) as ap_accruedname,acc00h30.ap_accrued, " +
                " (select accountno +' '+ accountname from acc00h10 where acc00h10.accountno = acc00h30.exp_inter) as exp_intername, acc00h30.exp_inter" +
                " from acc00h30 INNER JOIN acc00h10 ON acc00h10.accountno = acc00h30.korek INNER JOIN inv00h09 ON inv00h09.region_code = acc00h30.region_code " +
                " INNER JOIN inv00h11 ON inv00h11.CostCenter = acc00h30.dept_code INNER JOIN acc00h29 ON acc00h29.KoGAfi = acc00h30.KoGAfi " +
               " INNER JOIN acc00h03 ON acc00h03.cur_code = acc00h30.cur_code where acc00h30.stedit != 4  ";

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

        private static DataTable Getacc00h29(string text)
        {

            SqlDataAdapter adapter = new SqlDataAdapter("select KoGAfi, KoGAfi + ' ' + NmGAfi as NmGAfi from acc00h29 where KoGAfi like @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;

        }
        private static DataTable Getacc00h10(string text)
        {

            SqlDataAdapter adapter = new SqlDataAdapter("select accountno, accountno + ' ' + accountname as accountname from acc00h10 where accountno like @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;

        }

        private static DataTable Getinv00h11(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select CostCenter, CostCenter + ' ' + CostCenterName as CostCenterName from inv00h11 where CostCenter like @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;

        }

        private static DataTable Getinv00h09(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select region_code, region_code + ' ' + region_name as region_name from inv00h09 where region_name like @text + '%'",
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
            cmd.CommandText = "INSERT INTO acc00h30(emp_code, emp_name, cur_code, alamat, ref_code, KoGAfi, korek, norek, um, dept_code, region_code, ar_inter, inc_inter, ap_inter, ap_accrued, exp_inter, type_af,Stamp,Usr,Owner,stEdit)" +
                " VALUES (@emp_code, @emp_name, @cur_code, @alamat, @ref_code,@KoGAfi,@korek, @norek, @um, @dept_code, @region_code,@ar_inter, @inc_inter, @ap_inter, @ap_accrued, @exp_inter, 1, getdate(),UPPER(@Usr),UPPER (@Owner),0)";
            cmd.Parameters.AddWithValue("@emp_code", (item.FindControl("txt_emp_code") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@emp_name", (item.FindControl("txt_emp_name") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@alamat", (item.FindControl("txt_alamat") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@ref_code", (item.FindControl("txt_ref_code") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@KoGAfi", (item.FindControl("cb_group") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@dept_code", (item.FindControl("cb_CostCenter") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@region_code", (item.FindControl("cb_project") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@korek", (item.FindControl("txt_korek") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@um", (item.FindControl("txt_um") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@norek", (item.FindControl("txt_norek") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@cur_code", (item.FindControl("txt_cur") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@ar_inter", (item.FindControl("txt_ar_inter") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@inc_inter", (item.FindControl("txt_inc_inter") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@ap_inter", (item.FindControl("txt_ap_inter") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@ap_accrued", (item.FindControl("txt_ap_accrued") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@exp_inter", (item.FindControl("txt_exp_inter") as RadTextBox).Text);
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
            cmd.CommandText = "UPDATE acc00h30 set emp_code = @emp_code, emp_name = @emp_name, korek = @korek, um = @um, cur_code = @cur_code, alamat = @alamat, ref_code = @ref_code,KoGAfi = @KoGAfi, dept_code = @dept_code, region_code = @region_code," +
                " norek = @norek, ar_inter = @ar_inter, inc_inter = @inc_inter, ap_inter = @ap_inter, ap_accrued = @ap_accrued, exp_inter = @exp_inter, LastUpdate = getdate(), Usr = UPPER(@Usr) where emp_code = @emp_code";
            cmd.Parameters.AddWithValue("@emp_code", (item.FindControl("txt_emp_code") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@emp_name", (item.FindControl("txt_emp_name") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@alamat", (item.FindControl("txt_alamat") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@ref_code", (item.FindControl("txt_ref_code") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@KoGAfi", (item.FindControl("cb_group") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@dept_code", (item.FindControl("cb_CostCenter") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@region_code", (item.FindControl("cb_project") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@korek", (item.FindControl("txt_korek") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@um", (item.FindControl("txt_um") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@norek", (item.FindControl("txt_norek") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@cur_code", (item.FindControl("txt_cur") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@ar_inter", (item.FindControl("txt_ar_inter") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@inc_inter", (item.FindControl("txt_inc_inter") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@ap_inter", (item.FindControl("txt_ap_inter") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@ap_accrued", (item.FindControl("txt_ap_accrued") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@exp_inter", (item.FindControl("txt_exp_inter") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void RadGrid1_DeleteCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            var productId = ((GridDataItem)e.Item).GetDataKeyValue("emp_code");

            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "update acc00h30 set stEdit = 4, LastUpdate = getdate(), Usr = @Usr where emp_code = @emp_code";
            cmd.Parameters.AddWithValue("@emp_code", productId);
            cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void RadGrid1_ItemCreated(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
            if (e.Item is GridEditableItem & e.Item.IsInEditMode)
            {
                GridEditFormItem item = (GridEditFormItem)e.Item;
                RadTextBox txt = (item.FindControl("txt_emp_code") as RadTextBox);
                if (e.Item.OwnerTableView.IsItemInserted)
                    txt.Enabled = true;
                else
                    txt.Enabled = false;
            }
        }

        protected void cb_project_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetRegion(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["region_name"].ToString(), data.Rows[i]["region_name"].ToString()));
            }
        }

        private static DataTable GetRegion(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select region_code, region_code + ' ' + region_name as region_name from inv00h09 where stEdit != 4 " +
                " AND region_code +' '+ region_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;

        }
        protected void cb_project_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select region_code FROM inv00h09 WHERE region_code +' '+ region_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["region_code"].ToString();
            dr.Close();
            con.Close();

            RadComboBox cb = (RadComboBox)sender;
            GridEditableItem item = (GridEditableItem)cb.NamingContainer;
            RadComboBox cb_CostCenter = (RadComboBox)item.FindControl("cb_CostCenter");
            cb_CostCenter.Text = "";
            LoadCostCtr((sender as RadComboBox).SelectedValue, sender);
        }

        protected void cb_project_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select region_code FROM inv00h09 WHERE region_code +' '+ region_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["region_code"].ToString();
            dr.Close();
            con.Close();
        }

        protected void LoadCostCtr(string projectID, object sender)
        {
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);

            SqlDataAdapter adapter = new SqlDataAdapter("SELECT CostCenter, CostCenterName FROM inv00h11 WHERE region_code = @region_code", con);
            adapter.SelectCommand.Parameters.AddWithValue("@region_code", projectID);

            DataTable dt = new DataTable();
            adapter.Fill(dt);

            RadComboBox cb = (RadComboBox)sender;
            GridEditableItem item = (GridEditableItem)cb.NamingContainer;
            RadComboBox cb_CostCenter = (RadComboBox)item.FindControl("cb_CostCenter");
            cb_CostCenter.Text = "";
            cb_CostCenter.DataTextField = "CostCenterName";
            cb_CostCenter.DataValueField = "CostCenter";
            cb_CostCenter.DataSource = dt;
            cb_CostCenter.DataBind();
        }
        protected void cb_CostCenter_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetCostCenter(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["CostCenterName"].ToString(), data.Rows[i]["CostCenterName"].ToString()));
            }
        }

        private static DataTable GetCostCenter(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select CostCenter, CostCenter + ' ' + CostCenterName as CostCenterName from inv00h11 where stEdit != 4" +
                " AND CostCenter +' '+ CostCenterName LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;

        }
        protected void cb_CostCenter_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select CostCenter from inv00h11 where CostCenterName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["CostCenter"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_CostCenter_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select CostCenter from inv00h11 where CostCenterName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["CostCenter"].ToString();
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
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["NmGAfi"].ToString(), data.Rows[i]["NmGAfi"].ToString()));
            }
        }

        public static DataTable Getgroup(string Text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select NmGAfi as NmGAfi from acc00h29 where stEdit != 4 " +
                  " AND NmGAfi LIKE @text + '%'",
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
            cmd.CommandText = "SELECT acc00h29.* ,(select accountno +' '+ accountname from acc00h10 where acc00h10.accountno = acc00h29.korek) as korekname, " +
                " (select accountno +' '+ accountname from acc00h10 where acc00h10.accountno = acc00h29.norek) as norekname, " +
                " (select accountno +' '+ accountname from acc00h10 where acc00h10.accountno = acc00h29.um) as umname, " +
                " (select accountno +' '+ accountname from acc00h10 where acc00h10.accountno = acc00h29.ar_inter) as ar_intername, " +
                " (select accountno +' '+ accountname from acc00h10 where acc00h10.accountno = acc00h29.inc_inter) as inc_intername, " +
                " (select accountno +' '+ accountname from acc00h10 where acc00h10.accountno = acc00h29.ap_inter) as ap_intername, " +
                " (select accountno +' '+ accountname from acc00h10 where acc00h10.accountno = acc00h29.ap_accrued) as ap_accruedname, " +
                " (select accountno +' '+ accountname from acc00h10 where acc00h10.accountno = acc00h29.exp_inter) as exp_intername, acc00h03.cur_name " +
            " FROM acc00h29 INNER JOIN acc00h03 ON acc00h29.cur_code = acc00h03.cur_code WHERE acc00h29.NmGAfi = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
           dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["KoGAfi"].ToString();
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
                RadTextBox txtnorek = (RadTextBox)item.FindControl("txt_norek");
                RadTextBox txtnorekname = (RadTextBox)item.FindControl("txt_norekname");
                RadTextBox txt_ar_inter = (RadTextBox)item.FindControl("txt_ar_inter");
                RadTextBox txt_ar_intername = (RadTextBox)item.FindControl("txt_ar_intername");
                RadTextBox txt_inc_inter = (RadTextBox)item.FindControl("txt_inc_inter");
                RadTextBox txt_inc_intername = (RadTextBox)item.FindControl("txt_inc_intername");
                RadTextBox txt_ap_inter = (RadTextBox)item.FindControl("txt_ap_inter");
                RadTextBox txt_ap_intername = (RadTextBox)item.FindControl("txt_ap_intername");
                RadTextBox txt_ap_accrued = (RadTextBox)item.FindControl("txt_ap_accrued");
                RadTextBox txt_ap_accruedname = (RadTextBox)item.FindControl("txt_ap_accruedname");
                RadTextBox txt_exp_inter = (RadTextBox)item.FindControl("txt_exp_inter");
                RadTextBox txt_exp_intername = (RadTextBox)item.FindControl("txt_exp_intername");
                //RadTextBox txtCurr = item.FindControl("txt_cur") as RadTextBox;
                txtCurr.Text = dr1["cur_code"].ToString();
                txtCurName.Text = dr1["cur_name"].ToString();
                txtKorek.Text = dr1["korek"].ToString();
                txtKorekname.Text = dr1["korekName"].ToString();
                txtUm.Text = dr1["um"].ToString();
                txtUmname.Text = dr1["umname"].ToString();
                txtnorek.Text = dr1["norek"].ToString();
                txtnorekname.Text = dr1["norekname"].ToString();
                txt_ar_inter.Text = dr1["ar_inter"].ToString();
                txt_ar_intername.Text = dr1["ar_intername"].ToString();
                txt_inc_inter.Text = dr1["inc_inter"].ToString();
                txt_inc_intername.Text = dr1["inc_intername"].ToString();
                txt_ap_inter.Text = dr1["ap_inter"].ToString();
                txt_ap_intername.Text = dr1["ap_intername"].ToString();
                txt_ap_accrued.Text = dr1["ap_accrued"].ToString();
                txt_ap_accruedname.Text = dr1["ap_accruedname"].ToString();
                txt_exp_inter.Text = dr1["exp_inter"].ToString();
                txt_exp_intername.Text = dr1["exp_intername"].ToString();
            }
            con.Close();
        }

        protected void cb_group_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT KoGAfi FROM acc00h29 WHERE NmGAfi = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["KoGAfi"].ToString();
            dr.Close();
            con.Close();
        }

        protected void btn_new_Click(object sender, EventArgs e)
        {
            RadGrid1.MasterTableView.IsItemInserted = true;
            RadGrid1.MasterTableView.Rebind();
        }
    }
}