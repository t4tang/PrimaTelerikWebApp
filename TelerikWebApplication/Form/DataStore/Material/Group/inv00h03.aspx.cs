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

namespace TelerikWebApplication.Form.DataStore.Material.Group
{
    public partial class inv00h03 : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
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

        public DataTable GetDataTable()
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT inv00h03.group_code, inv00h03.group_name, " +
                              "CASE GroupType WHEN 'P' THEN 'Sparepart' WHEN 'F' THEN 'Fuel' WHEN 'O' THEN 'Oil' WHEN 'S' THEN 'Service' WHEN "+
                              "'A' THEN 'Asset' ELSE 'Other' END AS GroupType FROM inv00h03 WHERE(inv00h03.stEdit != '4') ";
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

        protected void cb_group_type_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadComboBox).Text == "Sparepart")
            {
                (sender as RadComboBox).SelectedValue = "P";
            }
            else if ((sender as RadComboBox).Text == "Fuel")
            {
                (sender as RadComboBox).SelectedValue = "F";
            }
            else if ((sender as RadComboBox).Text == "Oil")
            {
                (sender as RadComboBox).SelectedValue = "O";
            }
            else if ((sender as RadComboBox).Text == "Service")
            {
                (sender as RadComboBox).SelectedValue = "S";
            }
            else if ((sender as RadComboBox).Text == "Asset")
            {
                (sender as RadComboBox).SelectedValue = "A";
            }
            else
            {
                (sender as RadComboBox).SelectedValue = "N";
            }
        }
        
        protected void cb_group_type_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Add("Sparepart");
            (sender as RadComboBox).Items.Add("Fuel");
            (sender as RadComboBox).Items.Add("Oil");
            (sender as RadComboBox).Items.Add("Service");
            (sender as RadComboBox).Items.Add("Asset");
            (sender as RadComboBox).Items.Add("Other");
        }

        protected void cb_group_type_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if ((sender as RadComboBox).Text == "Sparepart")
            {
                (sender as RadComboBox).SelectedValue = "P";
            }
            else if ((sender as RadComboBox).Text == "Fuel")
            {
                (sender as RadComboBox).SelectedValue = "F";
            }
            else if ((sender as RadComboBox).Text == "Oil")
            {
                (sender as RadComboBox).SelectedValue = "O";
            }
            else if ((sender as RadComboBox).Text == "Service")
            {
                (sender as RadComboBox).SelectedValue = "S";
            }
            else if ((sender as RadComboBox).Text == "Asset")
            {
                (sender as RadComboBox).SelectedValue = "A";
            }
            else
            {
                (sender as RadComboBox).SelectedValue = "N";
            }
        }

        protected void RadGrid1_InsertCommand(object sender, GridCommandEventArgs e)
        {
            try
            { 
                GridEditableItem item = (GridEditableItem)e.Item;
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "INSERT INTO inv00h03(group_code,group_name,lastupdate,userid,stEdit,GroupType) " +
                                  "VALUES (@group_code,@group_name,getdate(),@userid,0,@GroupType)";
                cmd.Parameters.AddWithValue("@group_code", (item.FindControl("txt_group_code") as TextBox).Text);
                cmd.Parameters.AddWithValue("@group_name", (item.FindControl("txt_group_name") as TextBox).Text);
                cmd.Parameters.AddWithValue("@userid", public_str.user_id);
                cmd.Parameters.AddWithValue("@GroupType", (item.FindControl("cb_group_type") as RadComboBox).SelectedValue);
                //cmd.Parameters.AddWithValue("@GroupType", (item.FindControl("rbl_group_type") as RadioButtonList).SelectedItem);
                cmd.ExecuteNonQuery();
                con.Close();

                Label lblsuccess = new Label();
                lblsuccess.Text = "Data inserted successfully";
                lblsuccess.ForeColor = System.Drawing.Color.Blue;
                RadGrid1.Controls.Add(lblsuccess);
            }
            catch (Exception ex)
            {
                con.Close();
                Label lblError = new Label();
                lblError.Text = "Unable to insert data. Reason: " + ex.Message;
                lblError.ForeColor = System.Drawing.Color.Red;
                RadGrid1.Controls.Add(lblError);
                e.Canceled = true;
            }
        }
        protected void RadGrid1_UpdateCommand(object sender, GridCommandEventArgs e)
        {

            if (e.Item is GridEditFormItem)
            {
                try
                { 
                    GridEditFormItem item = (GridEditFormItem)e.Item;
                    con.Open();
                    cmd = new SqlCommand();
                    cmd.CommandType = CommandType.Text;
                    cmd.Connection = con;
                    cmd.CommandText = "UPDATE inv00h03 SET group_name = @group_name, GroupType = @GroupType, lastupdate = getdate(), userid = @userid " +
                                        "WHERE group_code = @group_code";
                    cmd.Parameters.AddWithValue("@group_code", (item.FindControl("txt_group_code") as TextBox).Text);
                    cmd.Parameters.AddWithValue("@group_name", (item.FindControl("txt_group_name") as TextBox).Text);
                    cmd.Parameters.AddWithValue("@userid", public_str.user_id);
                    cmd.Parameters.AddWithValue("@GroupType", (item.FindControl("cb_group_type") as RadComboBox).SelectedValue);
                    //cmd.Parameters.AddWithValue("@GroupType", (item.FindControl("rbl_group_type") as RadioButtonList).SelectedItem);
                    cmd.ExecuteNonQuery();
                    con.Close();

                    Label lblsuccess = new Label();
                    lblsuccess.Text = "Data inserted successfully";
                    lblsuccess.ForeColor = System.Drawing.Color.Blue;
                    RadGrid1.Controls.Add(lblsuccess);
                }
                catch (Exception ex)
                {
                    con.Close();
                    Label lblError = new Label();
                    lblError.Text = "Unable to update data. Reason: " + ex.Message;
                    lblError.ForeColor = System.Drawing.Color.Red;
                    RadGrid1.Controls.Add(lblError);
                    e.Canceled = true;
                }
            }
        }
        protected void RadGrid1_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                var group_code = ((GridDataItem)e.Item).GetDataKeyValue("group_code");

                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "Update inv00h03 SET stEdit = 4, userid = @userId where group_code = @group_code";
                cmd.Parameters.AddWithValue("@group_code", group_code);
                cmd.Parameters.AddWithValue("@userId", public_str.user_id);
                cmd.ExecuteNonQuery();
                con.Close();

                Label lblsuccess = new Label();
                lblsuccess.Text = "Data inserted successfully";
                lblsuccess.ForeColor = System.Drawing.Color.Blue;
                RadGrid1.Controls.Add(lblsuccess);
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

        protected void RadGrid1_ItemCreated(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridEditableItem & e.Item.IsInEditMode)
            {
                GridEditFormItem item = (GridEditFormItem)e.Item;
                TextBox txt = (item.FindControl("txt_group_code") as TextBox);
                if (e.Item.OwnerTableView.IsItemInserted)
                    txt.Enabled = true;
                else
                    txt.Enabled = false;
            }
        }

        protected void rbl_group_type_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadioButtonList).SelectedValue == "Sparepart")
            {
                (sender as RadioButtonList).SelectedValue = "P";
            }
            else if ((sender as RadioButtonList).SelectedValue == "Fuel")
            {
                (sender as RadioButtonList).SelectedValue = "F";
            }
            else if ((sender as RadioButtonList).SelectedValue == "Oil")
            {
                (sender as RadioButtonList).SelectedValue = "O";
            }
            else if ((sender as RadioButtonList).SelectedValue == "Service")
            {
                (sender as RadioButtonList).SelectedValue = "S";
            }
            else if ((sender as RadioButtonList).SelectedValue == "Asset")
            {
                (sender as RadioButtonList).SelectedValue = "A";
            }
            else
            {
                (sender as RadioButtonList).SelectedValue = "N";
            }
        }

        protected void btn_new_Click(object sender, EventArgs e)
        {
            RadGrid1.MasterTableView.IsItemInserted = true;
            RadGrid1.MasterTableView.Rebind();
        }
    }
}