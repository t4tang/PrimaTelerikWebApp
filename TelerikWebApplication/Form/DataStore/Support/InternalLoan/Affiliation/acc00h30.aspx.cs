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
            cmd.CommandText = "select ms_afiliasi.emp_code, ms_afiliasi.emp_name, ms_afiliasi.cur_code, ms_afiliasi.alamat, ms_afiliasi.ref_code, ms_currency.cur_name, ms_cost_center.CostCenterName, ms_jobsite.region_name, ms_Group_Afiliasi.NmGAfi, " +
                " (select accountno +' '+ accountname from gl_account where gl_account.accountno = ms_afiliasi.korek) as korekname,ms_afiliasi.korek, " +
                " (select accountno +' '+ accountname from gl_account where gl_account.accountno = ms_afiliasi.norek) as norekname,ms_afiliasi.norek, " +
                " (select accountno +' '+ accountname from gl_account where gl_account.accountno = ms_afiliasi.um) as umname,ms_afiliasi.um, " +
                " (select accountno +' '+ accountname from gl_account where gl_account.accountno = ms_afiliasi.ar_inter) as ar_intername,ms_afiliasi.ar_inter, " +
                " (select accountno +' '+ accountname from gl_account where gl_account.accountno = ms_afiliasi.inc_inter) as inc_intername,ms_afiliasi.inc_inter, " +
                " (select accountno +' '+ accountname from gl_account where gl_account.accountno = ms_afiliasi.ap_inter) as ap_intername,ms_afiliasi.ap_inter, " +
                " (select accountno +' '+ accountname from gl_account where gl_account.accountno = ms_afiliasi.ap_accrued) as ap_accruedname,ms_afiliasi.ap_accrued, " +
                " (select accountno +' '+ accountname from gl_account where gl_account.accountno = ms_afiliasi.exp_inter) as exp_intername, ms_afiliasi.exp_inter" +
                " from ms_afiliasi INNER JOIN gl_account ON gl_account.accountno = ms_afiliasi.korek INNER JOIN ms_jobsite ON ms_jobsite.region_code = ms_afiliasi.region_code " +
                " INNER JOIN ms_cost_center ON ms_cost_center.CostCenter = ms_afiliasi.dept_code INNER JOIN ms_Group_Afiliasi ON ms_Group_Afiliasi.KoGAfi = ms_afiliasi.KoGAfi " +
               " INNER JOIN ms_currency ON ms_currency.cur_code = ms_afiliasi.cur_code where ms_afiliasi.stedit != 4  ";

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

        private static DataTable Getms_Group_Afiliasi(string text)
        {

            SqlDataAdapter adapter = new SqlDataAdapter("select KoGAfi, KoGAfi + ' ' + NmGAfi as NmGAfi from ms_Group_Afiliasi where KoGAfi like @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;

        }
        private static DataTable Getgl_account(string text)
        {

            SqlDataAdapter adapter = new SqlDataAdapter("select accountno, accountno + ' ' + accountname as accountname from gl_account where accountno like @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;

        }

        private static DataTable Getms_cost_center(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select CostCenter, CostCenter + ' ' + CostCenterName as CostCenterName from ms_cost_center where CostCenter like @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;

        }

        private static DataTable Getms_jobsite(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select region_code, region_code + ' ' + region_name as region_name from ms_jobsite where region_name like @text + '%'",
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
            cmd.CommandText = "INSERT INTO ms_afiliasi(emp_code, emp_name, cur_code, alamat, ref_code, KoGAfi, korek, norek, um, dept_code, region_code, ar_inter, inc_inter, ap_inter, ap_accrued, exp_inter, type_af,Stamp,Usr,Owner,stEdit)" +
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
            cmd.CommandText = "UPDATE ms_afiliasi set emp_code = @emp_code, emp_name = @emp_name, korek = @korek, um = @um, cur_code = @cur_code, alamat = @alamat, ref_code = @ref_code,KoGAfi = @KoGAfi, dept_code = @dept_code, region_code = @region_code," +
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
            cmd.CommandText = "update ms_afiliasi set stEdit = 4, LastUpdate = getdate(), Usr = @Usr where emp_code = @emp_code";
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
            SqlDataAdapter adapter = new SqlDataAdapter("select region_code, region_code + ' ' + region_name as region_name from ms_jobsite where stEdit != 4 " +
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
            cmd.CommandText = "select region_code FROM ms_jobsite WHERE region_code +' '+ region_name = '" + (sender as RadComboBox).Text + "'";
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
            cmd.CommandText = "select region_code FROM ms_jobsite WHERE region_code +' '+ region_name = '" + (sender as RadComboBox).Text + "'";
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

            SqlDataAdapter adapter = new SqlDataAdapter("SELECT CostCenter, CostCenterName FROM ms_cost_center WHERE region_code = @region_code", con);
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
            SqlDataAdapter adapter = new SqlDataAdapter("select CostCenter, CostCenter + ' ' + CostCenterName as CostCenterName from ms_cost_center where stEdit != 4" +
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
            cmd.CommandText = "select CostCenter from ms_cost_center where CostCenterName = '" + (sender as RadComboBox).Text + "'";
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
            cmd.CommandText = "select CostCenter from ms_cost_center where CostCenterName = '" + (sender as RadComboBox).Text + "'";
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
            SqlDataAdapter adapter = new SqlDataAdapter("select NmGAfi as NmGAfi from ms_Group_Afiliasi where stEdit != 4 " +
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
            cmd.CommandText = "SELECT ms_Group_Afiliasi.* ,(select accountno +' '+ accountname from gl_account where gl_account.accountno = ms_Group_Afiliasi.korek) as korekname, " +
                " (select accountno +' '+ accountname from gl_account where gl_account.accountno = ms_Group_Afiliasi.norek) as norekname, " +
                " (select accountno +' '+ accountname from gl_account where gl_account.accountno = ms_Group_Afiliasi.um) as umname, " +
                " (select accountno +' '+ accountname from gl_account where gl_account.accountno = ms_Group_Afiliasi.ar_inter) as ar_intername, " +
                " (select accountno +' '+ accountname from gl_account where gl_account.accountno = ms_Group_Afiliasi.inc_inter) as inc_intername, " +
                " (select accountno +' '+ accountname from gl_account where gl_account.accountno = ms_Group_Afiliasi.ap_inter) as ap_intername, " +
                " (select accountno +' '+ accountname from gl_account where gl_account.accountno = ms_Group_Afiliasi.ap_accrued) as ap_accruedname, " +
                " (select accountno +' '+ accountname from gl_account where gl_account.accountno = ms_Group_Afiliasi.exp_inter) as exp_intername, ms_currency.cur_name " +
            " FROM ms_Group_Afiliasi INNER JOIN ms_currency ON ms_Group_Afiliasi.cur_code = ms_currency.cur_code WHERE ms_Group_Afiliasi.NmGAfi = '" + (sender as RadComboBox).Text + "'";
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
            cmd.CommandText = "SELECT KoGAfi FROM ms_Group_Afiliasi WHERE NmGAfi = '" + (sender as RadComboBox).Text + "'";
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