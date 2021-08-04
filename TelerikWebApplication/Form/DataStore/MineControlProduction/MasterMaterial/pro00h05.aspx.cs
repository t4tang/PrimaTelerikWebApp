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

namespace TelerikWebApplication.Form.DataStore.MineControlProduction.MasterMaterial
{
    public partial class pro00h05 : System.Web.UI.Page
    {
        public static string koneksi = ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString;
        SqlConnection con = new SqlConnection(koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();
        private const int ItemsPerRequest = 10;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public DataTable GetDataTable()
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT MCC_MS_MATERIAL.prod_code, MCC_MS_MATERIAL.spec, CASE MCC_MS_MATERIAL.kind_code WHEN 'CL' THEN 'CL' ELSE 'OB' END AS kind_code, " +
                                "CASE MCC_MS_MATERIAL.tActive WHEN '1' THEN 'YES' ELSE 'NO' END AS tActive FROM MCC_MS_MATERIAL " +
                                " WHERE MCC_MS_MATERIAL.stEdit !=4";
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
            (sender as RadGrid).DataSource = GetDataTable();
        }

        protected void RadGrid1_DeleteCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            var productId = ((GridDataItem)e.Item).GetDataKeyValue("prod_code");

            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "Update MCC_MS_MATERIAL SET stEdit = 4 where prod_code = @prod_code";
            cmd.Parameters.AddWithValue("@prod_code", productId);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void RadGrid1_UpdateCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.Item is GridEditFormItem)
            {
                GridEditFormItem item = (GridEditFormItem)e.Item;
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "UPDATE MCC_MS_MATERIAL SET spec = @spec, tActive = @tActive, kind_code =  @kind_code , " + 
                                    "Usr = @Usr, Stamp = getdate(), Owner = @Owner, stEdit = '0' " +
                                    "WHERE prod_code = @prod_code";
                cmd.Parameters.AddWithValue("@prod_code", (item.FindControl("txt_material_code") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@spec", (item.FindControl("txt_spec") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@kind_code", (item.FindControl("cb_cat") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
                cmd.Parameters.AddWithValue("@Owner", public_str.user_id);
                cmd.Parameters.AddWithValue("@tActive", (item.FindControl("chk_active") as CheckBox).Checked ? 1 : 0);
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }

        protected void RadGrid1_InsertCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            GridEditableItem item = (GridEditableItem)e.Item;
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "INSERT INTO MCC_MS_MATERIAL (prod_code, spec, tActive, kind_code, Usr, Stamp, Owner, stEdit) " +
                                "VALUES (@prod_code, @spec, @tActive, @kind_code, @Usr, getdate(), @Owner, '0')";
            cmd.Parameters.AddWithValue("@prod_code", (item.FindControl("txt_material_code") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@spec", (item.FindControl("txt_spec") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@tActive", (item.FindControl("chk_active") as CheckBox).Checked ? 1 : 0);
            cmd.Parameters.AddWithValue("@kind_code", (item.FindControl("cb_cat") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
            cmd.Parameters.AddWithValue("@Owner", public_str.user_id);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void cb_cat_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadComboBox).Text == "CL")
            {
                (sender as RadComboBox).SelectedValue = "CL";
            }
            else
            {
                (sender as RadComboBox).SelectedValue = "OB";
            }
        }

        protected void cb_cat_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Clear();
            (sender as RadComboBox).Items.Add("CL");
            (sender as RadComboBox).Items.Add("OB");
        }

        protected void cb_cat_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if ((sender as RadComboBox).Text == "CL")
            {
                (sender as RadComboBox).SelectedValue = "CL";
            }
            else
            {
                (sender as RadComboBox).SelectedValue = "OB";
            }
        }

        protected void RadGrid1_ItemCreated1(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridEditableItem & e.Item.IsInEditMode)
            {
                GridEditFormItem item = (GridEditFormItem)e.Item;
                RadTextBox txt = (item.FindControl("txt_material_code") as RadTextBox);
                if (e.Item.OwnerTableView.IsItemInserted)
                    txt.Enabled = true;
                else
                    txt.Enabled = false;
            }
        }

        protected void btn_new_Click(object sender, EventArgs e)
        {
            RadGrid1.MasterTableView.IsItemInserted = true;
            RadGrid1.MasterTableView.Rebind();
        }
    }
}