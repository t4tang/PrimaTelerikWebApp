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

namespace TelerikWebApplication.Form.Fico.Bank.DownPayment
{
    public partial class acc01h01dp : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();

        private const int ItemsPerRequest = 10;
        public static string tr_code = null;
        public static string mt_code = null;
        public static string selected_bank = null;
        public static string selected_project = null;
        public static string selected_cost_ctr = null;
        public static string selected_KoTrans = null;
        public static double kursRun = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lbl_form_name.Text = "Bank Down Payment";
                dtp_from.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
                dtp_to.SelectedDate = DateTime.Now;
                cb_proj_prm.SelectedValue = public_str.site;
                selected_project = public_str.site;
                //selected_KoTrans = Items["KoTrans"].

                tr_code = null;
                Session["action"] = "firstLoad";
                Session["TableDetail"] = null;
                Session["actionDetail"] = null;
                Session["actionHeader"] = null;
            }
        }
        protected void RadAjaxManager1_AjaxRequest(object sender, AjaxRequestEventArgs e)
        {
            try
            {
                if (e.Argument == "Rebind")
                {
                    RadGrid1.MasterTableView.SortExpressions.Clear();
                    RadGrid1.MasterTableView.GroupByExpressions.Clear();
                    RadGrid1.Rebind();
                    RadGrid1.MasterTableView.Items[0].Selected = true;

                }
                else if (e.Argument == "RebindAndNavigate")
                {
                    RadGrid1.MasterTableView.SortExpressions.Clear();
                    RadGrid1.MasterTableView.GroupByExpressions.Clear();
                    RadGrid1.DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), selected_bank);
                    RadGrid1.DataBind();
                    RadGrid1.MasterTableView.CurrentPageIndex = RadGrid1.MasterTableView.PageCount - 1;

                    RadGrid1.MasterTableView.Items[RadGrid1.Items.Count - 1].Selected = true;

                    Session["action"] = "list";
                }
            }
            catch (Exception ex)
            {
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
            }
        }
        #region searching parameter
        private static DataTable GetProjectPrm(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT region_code, region_name FROM ms_jobsite WHERE stEdit != 4 AND region_name LIKE @text + '%' UNION SELECT 'ALL','ALL'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_project_prm_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {

            DataTable data = GetProjectPrm(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["region_name"].ToString(), data.Rows[i]["region_name"].ToString()));
            }
        }
        #endregion

        #region Radrid1
        protected void btnNew_Click(object sender, ImageClickEventArgs e)
        {
            Session["TableDetail"] = null;
            Session["actionHeader"] = "headerNew";
            RadGrid1.MasterTableView.IsItemInserted = true;
            RadGrid1.MasterTableView.Rebind();
            //CalculateTotal();
        }

        protected void btnSearch1_Click(object sender, EventArgs e)
        {
            RadGrid1.DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), cb_proj_prm.SelectedValue);
            RadGrid1.DataBind();
        }

        public DataTable GetDataTable(string fromDate, string toDate, string project)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_bank_down_paymentH";
            cmd.Parameters.AddWithValue("@date", fromDate);
            cmd.Parameters.AddWithValue("@todate", toDate);
            cmd.Parameters.AddWithValue("@project", project);
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
            (sender as RadGrid).DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), cb_proj_prm.SelectedValue);
        }

        protected void RadGrid1_DeleteCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            var NoBuk = ((GridDataItem)e.Item).GetDataKeyValue("NoBuk");

            try
            {
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "UPDATE glBank SET Usr = @Usr, LastUpdate = GETDATE(), Batal = '1' WHERE (NoBuk = @NoBuk)";
                cmd.Parameters.AddWithValue("@NoBuk", NoBuk);
                cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
                cmd.ExecuteNonQuery();
                con.Close();

                Label lblOk = new Label();
                lblOk.Text = "Data deleted successfully";
                lblOk.ForeColor = System.Drawing.Color.Teal;
                RadGrid1.Controls.Add(lblOk);
            }
            catch (Exception ex)
            {
                con.Close();
                Label lblError = new Label();
                lblError.Text = "Unable to delete data. Reason: " + ex.Message;
                lblError.ForeColor = System.Drawing.Color.Red;
                RadGrid1.Controls.Add(lblError);
                e.Canceled = true;
            }
        }

        protected void RadGrid1_ItemCreated(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                ImageButton printLink = (ImageButton)e.Item.FindControl("PrintLink");
                printLink.Attributes["href"] = "javascript:void(0);";
                printLink.Attributes["onclick"] = String.Format("return ShowPreview('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["NoBuk"], e.Item.ItemIndex);
            }
        }

        protected void RadGrid1_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                tr_code = null;
                GridDataItem item = e.Item as GridDataItem;
                string kode = item["NoBuk"].Text;

                tr_code = kode;

                Session["actionHeader"] = "headerEdit";
                Session["actionDetail"] = null;
            }
        }

        protected void RadGrid1_SelectedIndexChanged(object sender, EventArgs e)
        {
            foreach (GridDataItem item in RadGrid1.SelectedItems)
            {
                tr_code = item["NoBuk"].Text;
            }

            Session["actionEdit"] = "list";
        }

        protected void RadGrid1_PreRender(object sender, EventArgs e)
        {
            if (Session["action"].ToString() == "firstLoad")
            {
                if ((sender as RadGrid).MasterTableView.Items.Count > 0)
                    (sender as RadGrid).MasterTableView.Items[0].Selected = true;
                foreach (GridDataItem item in RadGrid1.SelectedItems)
                {
                    foreach (GridDataItem gItem in (sender as RadGrid).SelectedItems)
                    {
                        tr_code = gItem["NoBuk"].Text;
                    }
                }
            }
        }

        protected void RadGrid1_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
            if (e.Item is GridEditFormItem && e.Item.IsInEditMode)
            {
                //GridDataItem item = (GridDataItem)e.Item;
                var item = e.Item as GridEditFormItem;
                RadDatePicker dtp_bm = item.FindControl("dtp_bm") as RadDatePicker;
                RadComboBox cb_KoTrans = item.FindControl("cb_KoTrans") as RadComboBox;
                RadComboBox cb_tax_code = item.FindControl("cb_tax_code") as RadComboBox;
                RadNumericTextBox txt_kurs = item.FindControl("txt_kurs") as RadNumericTextBox;
                RadNumericTextBox txt_tax_kurs = item.FindControl("txt_tax_kurs") as RadNumericTextBox;

                RadTextBox txt_uid = item.FindControl("txt_uid") as RadTextBox;
                RadTextBox txt_LastUpdate = item.FindControl("txt_LastUpdate") as RadTextBox;
                RadTextBox txt_owner = item.FindControl("txt_owner") as RadTextBox;
                RadTextBox txt_printed = item.FindControl("txt_printed") as RadTextBox;
                RadTextBox txt_edited = item.FindControl("txt_edited") as RadTextBox;

                if (e.Item.OwnerTableView.IsItemInserted)
                {
                    dtp_bm.SelectedDate = DateTime.Now;
                    cb_KoTrans.Text = "PENERIMAAN";
                    cb_tax_code.Text = "NON";

                    txt_uid.Text = public_str.uid;
                    txt_LastUpdate.Text = DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss");
                    txt_owner.Text = public_str.uid;
                    txt_printed.Text = "0";
                    txt_edited.Text = "0";
                }

            }
        }

        #endregion

        #region Project
        private static DataTable GetProject(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select region_code,region_name from ms_jobsite where stEdit != 4 " +
                " AND region_name LIKE @text + '%'",
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
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select region_code from ms_jobsite WHERE region_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["region_code"].ToString();
                selected_project = dr[0].ToString();
            }
            dr.Close();
            con.Close();
        }

        protected void cb_project_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select region_code from ms_jobsite WHERE region_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["region_code"].ToString();
            dr.Close();
            con.Close();
        }
        #endregion

        protected void btnUpdate_Click(object sender, EventArgs e)
        {

        }

        protected void cb_KoTrans_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {

        }

        protected void cb_KoTrans_PreRender(object sender, EventArgs e)
        {

        }

        protected void cb_KoTrans_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

        protected void cb_bank_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {

        }

        protected void cb_bank_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

        protected void cb_bank_PreRender(object sender, EventArgs e)
        {

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

        protected void cb_prepared_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadManPower(e.Text, selected_project, (sender as RadComboBox));
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
                (sender as RadComboBox).SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_prepared_DataBound(object sender, EventArgs e)
        {
            ((Literal)(sender as RadComboBox).Footer.FindControl("RadComboItemsCount")).Text = Convert.ToString((sender as RadComboBox).Items.Count);
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
                (sender as RadComboBox).SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_checked_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadManPower(e.Text, selected_project, (sender as RadComboBox));
        }

        protected void cb_checked_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM ms_manpower WHERE name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_checked_DataBound(object sender, EventArgs e)
        {
            ((Literal)(sender as RadComboBox).Footer.FindControl("RadComboItemsCount")).Text = Convert.ToString((sender as RadComboBox).Items.Count);
        }

        protected void cb_checked_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM ms_manpower WHERE name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_approved_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadManPower(e.Text, selected_project, (sender as RadComboBox));
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
                (sender as RadComboBox).SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_approved_DataBound(object sender, EventArgs e)
        {
            ((Literal)(sender as RadComboBox).Footer.FindControl("RadComboItemsCount")).Text = Convert.ToString((sender as RadComboBox).Items.Count);
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
                (sender as RadComboBox).SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }
        #endregion

        protected void cb_tax_code_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {

        }

        protected void cb_tax_code_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            RadComboBox cb = (RadComboBox)sender;
            GridEditableItem item = (GridEditableItem)cb.NamingContainer;

            RadNumericTextBox txt_tax_amount = (RadNumericTextBox)item.FindControl("txt_tax_amount");
            RadNumericTextBox txt_amount = (RadNumericTextBox)item.FindControl("txt_amount");

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

            get_tax_value((sender as RadComboBox).SelectedValue, txt_tax_amount, txt_amount);
        }

        private void get_tax_value(string tax_code, RadNumericTextBox txt_tax_amount, RadNumericTextBox txt_amount)
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
                txt_tax_amount.Value = Convert.ToDouble(dr["TAX_PERC"].ToString()) * txt_amount.Value;
            }
            dr.Close();
            con.Close();
        }

        protected void cb_tax_code_PreRender(object sender, EventArgs e)
        {

        }

        protected void cb_cost_center_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {

        }

        protected void cb_cost_center_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

        protected void cb_cost_center_PreRender(object sender, EventArgs e)
        {

        }

        protected void calculate_total(object sender, EventArgs e)
        {
            try
            {
                RadNumericTextBox ntb = (RadNumericTextBox)sender;
                GridEditableItem item = (GridEditableItem)ntb.NamingContainer;

                RadNumericTextBox txt_tax_amount = (RadNumericTextBox)item.FindControl("txt_tax_amount");
                RadNumericTextBox txt_total = (RadNumericTextBox)item.FindControl("txt_total");

                txt_tax_amount.Value = (sender as RadNumericTextBox).Value + txt_tax_amount.Value;
                
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
    }

}