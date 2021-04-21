using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using TelerikWebApplication.Class;

namespace TelerikWebApplication.Form.Fico.AssetRetirement
{
    public partial class acc00h22rtm : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();

        private const int ItemsPerRequest = 10;
        public static string tr_code = null;
        public static string selected_cost_ctr = null;
        public static string selected_project = null;
        DataTable dtValues;

        RadTextBox txt_doc_code;
        RadComboBox cb_priority;
        RadDatePicker dtp_pr;
        RadComboBox cb_type_ref;
        RadComboBox cb_project;
        RadComboBox cb_warehouse;
        RadComboBox cb_cost_ctr;
        RadTextBox txt_remark;
        RadComboBox cb_prepare_by;
        RadComboBox cb_orderBy;
        RadComboBox cb_checked;
        RadComboBox cb_approved;
        Button btnCancel;
        RadGrid Grid2;

        private static string GetStatusMessage(int offset, int total)
        {
            if (total <= 0)
                return "No matches";

            return String.Format("Items <b>1</b>-<b>{0}</b> out of <b>{1}</b>", offset, total);
        }
        public DataTable DetailDtbl()
        {
            dtValues = new DataTable();
            dtValues.Columns.Add("pr_code", typeof(string));
            dtValues.Columns.Add("Prod_code", typeof(string));
            dtValues.Columns.Add("part_desc", typeof(string));
            dtValues.Columns.Add("no_ref", typeof(string));
            dtValues.Columns.Add("stock_hand", typeof(double));
            dtValues.Columns.Add("qty", typeof(double));
            dtValues.Columns.Add("qtypo", typeof(double));
            dtValues.Columns.Add("SatQty", typeof(string));
            dtValues.Columns.Add("dept_code", typeof(string));
            dtValues.Columns.Add("DeliDate", typeof(DateTime));
            dtValues.Columns.Add("Remark", typeof(string));
            dtValues.Columns.Add("nomor", typeof(int));

            return dtValues;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //lbl_form_name.Text = "Purchase Request";
                //dtp_from.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
                //dtp_to.SelectedDate = DateTime.Now;
                //selected_project = public_str.site;
                //cb_proj_prm.Text = public_str.sitename;

                //tr_code = null;
                //Session["action"] = "firstLoad";
                //Session["TableDetail"] = null;
                //Session["actionDetail"] = null;
                //Session["actionHeader"] = null;
            }
        }
        protected void RadAjaxManager1_AjaxRequest(object sender, AjaxRequestEventArgs e)
        {
            //try
            //{
            //    if (e.Argument == "Rebind")
            //    {
            //        RadGrid1.MasterTableView.SortExpressions.Clear();
            //        RadGrid1.MasterTableView.GroupByExpressions.Clear();
            //        RadGrid1.Rebind();
            //    }
            //    else if (e.Argument == "RebindAndNavigate")
            //    {
            //        RadGrid1.MasterTableView.SortExpressions.Clear();
            //        RadGrid1.MasterTableView.GroupByExpressions.Clear();
            //        RadGrid1.DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), selected_project);
            //        RadGrid1.DataBind();
            //        //RadGrid1.Rebind();
            //        RadGrid1.MasterTableView.CurrentPageIndex = RadGrid1.MasterTableView.PageCount - 1;
            //        RadGrid1.MasterTableView.Items[RadGrid1.Items.Count - 1].Selected = true;
            //        Session["action"] = "list";
            //    }
            //}
            //catch (Exception ex)
            //{
            //    RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
            //}

        }
    }
}