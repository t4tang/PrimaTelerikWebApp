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

namespace TelerikWebApplication.Form.Preventive_maintenance.DBCM
{
    public partial class dbcm : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();

        private const int ItemsPerRequest = 10;
        public static string selected_project = null;
        public static string tr_code = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            lbl_form_name.Text = "Daily Breakdown Condition Monitoring";
            dtp_from.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
            dtp_to.SelectedDate = DateTime.Now;
            selected_project = public_str.site;
            cb_proj_prm.SelectedValue = public_str.site;
            cb_proj_prm.Text = public_str.sitename;

            tr_code = null;
            Session["action"] = "firstLoad";
        }

        protected void RadAjaxManager1_AjaxRequest(object sender, Telerik.Web.UI.AjaxRequestEventArgs e)
        {
            //try
            //{
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
                    RadGrid1.DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), cb_proj_prm.SelectedValue);
                    RadGrid1.DataBind();
                    RadGrid1.MasterTableView.CurrentPageIndex = (sender as RadGrid).MasterTableView.PageCount - 1;

                    RadGrid1.MasterTableView.Items[(sender as RadGrid).Items.Count - 1].Selected = true;
                    Session["action"] = "list";
                }
            //}
            //catch (Exception ex)
            //{
            //    RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
            //}
        }

        #region Project Prm
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
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }

        #endregion

        protected void RadGrid1_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            RadGrid1.DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), cb_proj_prm.SelectedValue);

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
            cmd.CommandText = "sp_get_DMCB";
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

        protected void RadGrid1_UpdateCommand(object sender, GridCommandEventArgs e)
        {
            //try
            //{
                con.Open();
                GridEditableItem item = (GridEditableItem)e.Item;
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "UPDATE tr_machine_conditiondd SET remark_activity = @remark_activity, esti_date = @esti_date, " +                                     "esti_time = @esti_time, no_part = @no_part, part_date = @part_date, part_eta = @part_eta "+                                    "WHERE trans_id = @trans_id AND run = @run";
                cmd.Parameters.AddWithValue("@trans_id", (item.FindControl("lbl_WO2") as Label).Text);
                //cmd.Parameters.AddWithValue("@remark", (item.FindControl("txt_remark") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@remark_activity", (item.FindControl("txt_activ") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@esti_date", (item.FindControl("dtp_estiRFUDate") as RadDatePicker).SelectedDate.Value);
                //cmd.Parameters.AddWithValue("@esti_time", (item.FindControl("dp_estiRFUTime") as RadTimePicker).SelectedTime.Value);
                cmd.Parameters.AddWithValue("@esti_time", Convert.ToDouble((item.FindControl("dp_estiRFUTime") as RadTimePicker).SelectedDate.Value.TimeOfDay.Hours) +
                    (Convert.ToDouble((item.FindControl("dp_estiRFUTime") as RadTimePicker).SelectedDate.Value.TimeOfDay.Minutes) * 1 / 100));
                cmd.Parameters.AddWithValue("@no_part", (item.FindControl("txt_proNo") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@part_date", (item.FindControl("dtp_matProDate") as RadDatePicker).SelectedDate.Value);
                cmd.Parameters.AddWithValue("@part_eta", (item.FindControl("dtp_matProEta") as RadDatePicker).SelectedDate.Value);
            //cmd.Parameters.AddWithValue("@part_eta", Convert.ToDouble((item.FindControl("rtp_matProEtaTime") as RadTimePicker).SelectedDate.Value.TimeOfDay.Hours) +
            //            (Convert.ToDouble((item.FindControl("rtp_matProEtaTime") as RadTimePicker).SelectedDate.Value.TimeOfDay.Minutes) * 1 / 100));
                cmd.Parameters.AddWithValue("@run", (item.FindControl("lbl_run2") as Label).Text);
                cmd.ExecuteNonQuery();
                con.Close();
            //}
            //catch (Exception ex)
            //{
            //    con.Close();
            //    RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
            //    e.Canceled = true;
            //}
        }

        protected void RadGrid1_ItemCreated(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                HyperLink vie_wo_link = (HyperLink)e.Item.FindControl("link_wo");
                vie_wo_link.Attributes["href"] = "javascript:void(0);";
                vie_wo_link.Attributes["onclick"] = String.Format("return ShowWoForm('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["trans_id"], e.Item.ItemIndex);

               
            }
        }

        //protected void RadGrid1_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    foreach (GridDataItem item in RadGrid1.SelectedItems)
        //    {
        //        tr_code = item["trans_id"].Text;
        //    }

        //    Session["action"] = "list";
        //}
    }
}