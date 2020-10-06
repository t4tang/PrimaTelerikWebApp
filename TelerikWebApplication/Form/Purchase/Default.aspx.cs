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

namespace TelerikWebApplication.Forms.Purchase
{
    public partial class Default : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                public_str.modul = "Purchase";
                lbl_form_name.Text = "Document Review";
                RadListBox1.DataSource = GetDataTable();
                RadListBox1.DataBind();
            }
        }
        protected void RadGrid1_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            (sender as RadGrid).DataSource = GetDataTable();
        }
        public DataTable GetDataTable()
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_need_approval_summary";
            cmd.Parameters.AddWithValue("@modul", "PUR");
            cmd.Parameters.AddWithValue("@uid", public_str.uid);
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
        protected void RadGrid2_ItemCreated(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                ImageButton imgLink = (ImageButton)e.Item.FindControl("ViewLink");
                imgLink.Attributes["href"] = "javascript:void(0);";
                imgLink.Attributes["onclick"] = String.Format("return ShowPreview('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["tr_no"], e.Item.ItemIndex);
                

            }
        }
        protected void RadGrid1_SelectedIndexChanged(object sender, EventArgs e)
        {
            //foreach (GridDataItem item in RadGrid1.SelectedItems)
            //{
            //    RadGrid2.DataSource = GetDataDetailTable(item["TRANSAKSI"].Text);
            //    RadGrid2.DataBind();
            //}
            ////populate_detail();
        }
        private void populate_detail()
        {
            //if (tr_code == null)
            //{
            //    RadGrid2.DataSource = new string[] { };
            //}
            //else
            //{
            //RadGrid2.DataSource = GetDataDetailTable(tr_code);
            //}

            RadGrid2.DataBind();
        }
        public DataTable GetDataDetailTable(string transaction_name)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_need_approval_list";
            cmd.Parameters.AddWithValue("@transaction", transaction_name);
            cmd.Parameters.AddWithValue("@uid", public_str.uid);
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
        protected void edt_chkApv1_CheckedChanged(object sender, EventArgs e)
        {

        }
        protected void edt_chkApv2_CheckedChanged(object sender, EventArgs e)
        {

        }
        protected void edt_chkApv3_CheckedChanged(object sender, EventArgs e)
        {

        }
        protected void edt_chkApv1_PreRender(object sender, EventArgs e)
        {

            //if ((sender as CheckBox).Checked == true)
            //{
            //    tax_check = "1";
            //}
            //else
            //{
            //    tax_check = "0";
            //}
        }
        protected void edt_chkApv2_PreRender(object sender, EventArgs e)
        {

            //if ((sender as CheckBox).Checked == true)
            //{
            //    tax_check = "1";
            //}
            //else
            //{
            //    tax_check = "0";
            //}
        }
        protected void edt_chkApv3_PreRender(object sender, EventArgs e)
        {

            //if ((sender as CheckBox).Checked == true)
            //{
            //    tax_check = "1";
            //}
            //else
            //{
            //    tax_check = "0";
            //}
        }
        protected void RadAjaxManager1_AjaxRequest(object sender, AjaxRequestEventArgs e)
        {
            //if (e.Argument == "Rebind")
            //{
            //    RadGrid1.MasterTableView.SortExpressions.Clear();
            //    RadGrid1.MasterTableView.GroupByExpressions.Clear();
            //    RadGrid1.Rebind(); /* Kemudian RadGrid1 akan sorting data by lastupdate (lihat sp_get_purchase_requestH*/

            //    RadGrid1.MasterTableView.Items[0].Selected = true;

            //    //RadGrid2.DataSource = GetDataDetailTable(tr_code);
            //    //RadGrid2.Rebind();
            //}
            //else if (e.Argument == "RebindAndNavigate")
            //{
            //    RadGrid1.MasterTableView.SortExpressions.Clear();
            //    RadGrid1.MasterTableView.GroupByExpressions.Clear();
            //    //RadGrid1.DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), selected_project);
            //    RadGrid1.DataBind();
            //    //RadGrid1.MasterTableView.CurrentPageIndex = RadGrid1.MasterTableView.PageCount - 1;
            //    //RadGrid1.MasterTableView.Items[RadGrid1.Items.Count - 1].Selected = true;
            //    RadGrid1.MasterTableView.Items[0].Selected = true;
            //    //RadGrid2.DataSource = GetDataDetailTable(tr_code);
            //    //RadGrid2.Rebind();
            //    Session["action"] = "list";
            //}


        }

        protected void RadListBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            foreach (RadListBoxItem item in RadListBox1.SelectedItems)
            {
                RadGrid2.DataSource = GetDataDetailTable(item.Text);
                RadGrid2.DataBind();
            }
        }
    }
}