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

namespace TelerikWebApplication
{
    public partial class dashboard : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();

        protected void Page_Load(object sender, EventArgs e)
        {

        }
        

        protected void btn_prev_mtc_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("~/Form/Preventive_maintenance/Default.aspx");
        }

        protected void btn_inventory_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("~/Form/Inventory/Default.aspx");
        }

        protected void btn_purchase_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("~/Form/Purchase/Default.aspx");
        }

        protected void btn_fico_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("~/Form/Fico/Default.aspx");
        }

        protected void btn_production_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("~/Form/Production/Default.aspx");
        }

        protected void btn_sales_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("~/Form/Sales/Default.aspx");
        }

        protected void btn_datastore_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("~/Form/DataStore/Default.aspx");
        }

        protected void btn_security_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("~/Form/Security/Default.aspx");
        }

        protected void RadGrid1_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            (sender as RadGrid).DataSource = GetDataTable();
        }

        protected void RadGrid1_ItemCreated(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                ImageButton imgLink = (ImageButton)e.Item.FindControl("ViewLink");
                imgLink.Attributes["href"] = "javascript:void(0);";
                if (e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["kode"].ToString() == "PO")
                {
                    imgLink.Attributes["onclick"] = String.Format("return ShowPOPreview('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["tr_no"], e.Item.ItemIndex);
                }
                else if (e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["kode"].ToString() == "GR")
                {
                    imgLink.Attributes["onclick"] = String.Format("return ShowGRPreview('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["tr_no"], e.Item.ItemIndex);
                }
                else if (e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["kode"].ToString() == "RV")
                {
                    imgLink.Attributes["onclick"] = String.Format("return ShowGRPreview('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["tr_no"], e.Item.ItemIndex);
                }
                else if (e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["kode"].ToString() == "UR")
                {
                    imgLink.Attributes["onclick"] = String.Format("return ShowURPreview('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["tr_no"], e.Item.ItemIndex);
                }
            }
        }
        public DataTable GetDataTable()
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_transaction_review_list";
            cmd.Parameters.AddWithValue("@uid", public_str.uid);
            cmd.Parameters.AddWithValue("@include_closed", chk_all.Checked);
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

        protected void chk_all_CheckedChanged(object sender, EventArgs e)
        {
            //(sender as CheckBox).Checked = false;
            RadGrid1.DataSource = GetDataTable();
            RadGrid1.DataBind();
        }

        protected void btn_report_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("~/Form/Reports/ReportDashboard.aspx");
        }
    }
}