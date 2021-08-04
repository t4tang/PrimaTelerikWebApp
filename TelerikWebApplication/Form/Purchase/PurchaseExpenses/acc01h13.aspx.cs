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
    public partial class acc01h13 : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();

        private const int ItemsPerRequest = 10;
        public static string tr_code = null;
        public static string selected_project = null;
        public static string tax1_code = null;
        public static string tax2_code = null;
        public static string tax3_code = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lbl_form_name.Text = "Purchase Expenses";
                dtp_from.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
                dtp_to.SelectedDate = DateTime.Now;
                selected_project = public_str.site;
                cb_proj_prm.SelectedValue = public_str.site;
                cb_proj_prm.Text = public_str.sitename;

                tr_code = null;
                Session["action"] = "firstLoad";
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
                    RadGrid1.Rebind(); /* Kemudian RadGrid1 akan sorting data by lastupdate (lihat sp_get_purchase_requestH*/

                    RadGrid1.MasterTableView.Items[0].Selected = true;

                    RadGrid2.DataSource = GetDataDetailTable(tr_code);
                    RadGrid2.Rebind();
                }
                else if (e.Argument == "RebindAndNavigate")
                {
                    RadGrid1.MasterTableView.SortExpressions.Clear();
                    RadGrid1.MasterTableView.GroupByExpressions.Clear();
                    RadGrid1.DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), selected_project);
                    RadGrid1.DataBind();
                    //RadGrid1.MasterTableView.CurrentPageIndex = RadGrid1.MasterTableView.PageCount - 1;
                    //RadGrid1.MasterTableView.Items[RadGrid1.Items.Count - 1].Selected = true;
                    RadGrid1.MasterTableView.Items[0].Selected = true;
                    RadGrid2.DataSource = GetDataDetailTable(tr_code);
                    RadGrid2.Rebind();
                    Session["action"] = "list";
                }
            }
            catch (Exception ex)
            {
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
            }
        }
        protected void RadGrid1_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            (sender as RadGrid).DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), cb_proj_prm.SelectedValue);
        }

        protected void RadGrid1_DeleteCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            var doc_code = ((GridDataItem)e.Item).GetDataKeyValue("pr_code");

            try
            {
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "UPDATE MUTAP SET Usr = @Usr, stamp = GETDATE(), Batal = 1 WHERE (NoBuk = @NoBuk)";
                cmd.Parameters.AddWithValue("@NoBuk", doc_code);
                cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
                cmd.ExecuteNonQuery();
                con.Close();

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

        protected void RadGrid1_ItemCreated(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                ImageButton editLink = (ImageButton)e.Item.FindControl("EditLink");
                editLink.Attributes["href"] = "javascript:void(0);";
                editLink.Attributes["onclick"] = String.Format("return ShowEditForm('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["NoBuk"], e.Item.ItemIndex);

                ImageButton printLink = (ImageButton)e.Item.FindControl("PrintLink");
                printLink.Attributes["href"] = "javascript:void(0);";
                printLink.Attributes["onclick"] = String.Format("return ShowPreview('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["NoBuk"], e.Item.ItemIndex);

            }
        }

        protected void RadGrid1_PreRender(object sender, EventArgs e)
        {
            if (Session["action"].ToString() == "firstLoad")
            {
                if (RadGrid1.MasterTableView.Items.Count > 0)
                    RadGrid1.MasterTableView.Items[0].Selected = true;

                foreach (GridDataItem gItem in RadGrid1.SelectedItems)
                {
                    tr_code = gItem["NoBuk"].Text;
                }
                populate_detail();
            }
        }

        protected void RadGrid1_SelectedIndexChanged(object sender, EventArgs e)
        {
            foreach (GridDataItem item in RadGrid1.SelectedItems)
            {
                tr_code = item["NoBuk"].Text;

                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "select PPN,OTax,pph from v_purchase_expensesH where NoBuk = '" + tr_code + "'";
                SqlDataReader dr;
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    tax1_code = dr["PPN"].ToString();
                    tax2_code = dr["OTax"].ToString();
                    tax3_code = dr["pph"].ToString();
                }
                dr.Close();
                con.Close();                
            }

            populate_detail();
            Session["action"] = "list";
        }

        protected void RadGrid2_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            if (tr_code == null)
            {
                (sender as RadGrid).DataSource = new string[] { };
            }
            else
            {
                RadGrid2.DataSource = GetDataDetailTable(tr_code);
            }
        }

        protected void RadGrid2_UpdateCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            try
            {
                con.Open();
                GridEditableItem item = (GridEditableItem)e.Item;
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_save_purchase_expensesD";
                cmd.Parameters.AddWithValue("@code_biaya", (item.FindControl("lblCodeBiaya") as Label).Text);
                cmd.Parameters.AddWithValue("@sub_price", Convert.ToDouble((item.FindControl("txtSubPrice") as RadTextBox).Text));
                cmd.Parameters.AddWithValue("@tTax", (item.FindControl("chk_tax1") as CheckBox).Checked);
                cmd.Parameters.AddWithValue("@tOtax", (item.FindControl("chk_tax2") as CheckBox).Checked);
                cmd.Parameters.AddWithValue("@tpph", (item.FindControl("chk_tax3") as CheckBox).Checked);
                cmd.Parameters.AddWithValue("@tax1_code", tax1_code);
                cmd.Parameters.AddWithValue("@tax2_code", tax2_code);
                cmd.Parameters.AddWithValue("@tax3_code", tax3_code);
                cmd.Parameters.AddWithValue("@pay_tot", Convert.ToDouble((item.FindControl("lblTotal") as RadLabel).Text));
                cmd.Parameters.AddWithValue("@debt_rema", 0);
                cmd.Parameters.AddWithValue("@Nobuk", tr_code);
                cmd.Parameters.AddWithValue("@nomor", (item.FindControl("lblNomor") as Label).Text);
                cmd.Parameters.AddWithValue("@dept_code", (item.FindControl("lblCostCtr") as Label).Text);
                cmd.Parameters.AddWithValue("@remark", (item.FindControl("txtRemark_d") as RadTextBox).Text);

                cmd.ExecuteNonQuery();

                con.Close();

                notif.Show();
            }
            catch (Exception ex)
            {
                con.Close();
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
                e.Canceled = true;
            }
        }

        protected void RadGrid2_DeleteCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            var NoBuk = ((GridDataItem)e.Item).GetDataKeyValue("Nobuk");
            var Nomor = ((GridDataItem)e.Item).GetDataKeyValue("nomor");

            try
            {
                GridEditableItem item = (GridEditableItem)e.Item;
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "DELETE FROM MUTIC_BIAYA WHERE Nobuk = @Nobuk AND nomor = @nomor";
                cmd.Parameters.AddWithValue("@Nobuk", NoBuk);
                cmd.Parameters.AddWithValue("@nomor", Nomor);
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
        private static DataTable GetProjectPrm(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT region_code, region_name FROM ms_jobsite WHERE stEdit != 4 AND region_name LIKE @text + '%' UNION SELECT 'ALL','ALL'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_proj_prm_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
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

        protected void cb_proj_prm_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
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

        protected void btnSearch_Click(object sender, EventArgs e)
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
            cmd.CommandText = "sp_get_purchase_expensesH";
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
        public DataTable GetDataDetailTable(string nobuk)
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
        private void populate_detail()
        {
            if (tr_code == null)
            {
                RadGrid2.DataSource = new string[] { };
            }
            else
            {
                RadGrid2.DataSource = GetDataDetailTable(tr_code);
            }

            RadGrid2.DataBind();
        }
    }

}