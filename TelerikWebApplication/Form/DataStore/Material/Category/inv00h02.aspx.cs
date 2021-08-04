using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using TelerikWebApplication.Class;

namespace TelerikWebApplication.Form.Master_data.Material.Category
{
    public partial class category : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();
        private const int ItemsPerRequest = 10;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lbl_form_name.Text = "Material Category";
            }
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
            cmd.CommandText = "SELECT ms_product_kind.kind_code, ms_product_kind.kind_name, ms_product_kind.prod_type_code, ms_product_kind.stMain, ms_product_kind.stEdit, " +
                              "CASE stMain WHEN '0' THEN 'Stock and Value' WHEN '1' THEN 'Only Stock' WHEN '2' THEN 'Non Stock' END AS status_main, " +
                              "ms_product_type.prod_type_name " +
                              "FROM ms_product_kind INNER JOIN " +
                              "ms_product_type ON ms_product_kind.prod_type_code = ms_product_type.prod_type_code " +
                              "WHERE(ms_product_kind.stEdit <> '4') ";
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

        private static DataTable GetCategory(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT prod_type_code, prod_type_name FROM ms_product_type WHERE stEdit != '4' AND prod_type_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_type_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetCategory(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["prod_type_name"].ToString(), data.Rows[i]["prod_type_name"].ToString()));
            }

            e.Message = GetStatusMessage(endOffset, data.Rows.Count);
        }


        protected void cb_type_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT prod_type_code from ms_product_type where prod_type_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_st_main_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            // Load cb_st_main items
            (sender as RadComboBox).Items.Add("Stock and Value");
            (sender as RadComboBox).Items.Add("Only Stock");
            (sender as RadComboBox).Items.Add("Non Stock");
        }

        protected void RadGrid1_InsertCommand(object source, GridCommandEventArgs e)
        {
            try
            {
                GridEditableItem item = (GridEditableItem)e.Item;
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "insert into ms_product_kind(kind_code, kind_name, prod_type_code, StMain, stEdit, lastupdate, userid) values " +
                        "(@kind_code, @kind_name,@prod_type_code, CASE @StMain WHEN 'Stock and value' THEN '0' WHEN 'Only Stock' THEN '1' " +
                        "ELSE '2' END, '0', getdate(),@userid)";
                cmd.Parameters.AddWithValue("@kind_code", (item.FindControl("txt_kind_code") as TextBox).Text);
                cmd.Parameters.AddWithValue("@kind_name", (item.FindControl("txt_kind_name") as TextBox).Text);
                cmd.Parameters.AddWithValue("@prod_type_code", (item.FindControl("cb_type") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@stMain", (item.FindControl("cb_st_main") as RadComboBox).Text);
                cmd.Parameters.AddWithValue("@userid", public_str.user_id);
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
        protected void RadGrid1_UpdateCommand(object source, GridCommandEventArgs e)
        {
            try
            {
                if (e.CommandName == RadGrid.UpdateCommandName)
                {
                    if (e.Item is GridEditFormItem)
                    {
                        GridEditFormItem item = (GridEditFormItem)e.Item;

                        cmd = new SqlCommand("update ms_product_kind set kind_name = @kind_name, prod_type_code = @prod_type_code, " +
                                "StMain = CASE @StMain WHEN 'Stock and value' THEN '0' WHEN 'Only Stock' THEN '1' " +
                                "ELSE '2' END, LastUpdate = getdate(), Userid = @Usr where kind_code = @kind_code", con);
                        con.Open();
                        cmd.Parameters.AddWithValue("@kind_code", (item.FindControl("txt_kind_code") as TextBox).Text);
                        cmd.Parameters.AddWithValue("@kind_name", (item.FindControl("txt_kind_name") as TextBox).Text);
                        cmd.Parameters.AddWithValue("@prod_type_code", (item.FindControl("cb_type") as RadComboBox).SelectedValue);
                        cmd.Parameters.AddWithValue("@stMain", (item.FindControl("cb_st_main") as RadComboBox).Text);
                        cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
                        cmd.ExecuteNonQuery();
                        con.Close();
                    }
                }
                Label lblsuccess = new Label();
                lblsuccess.Text = "Data updated successfully";
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

        protected void RadGrid1_DeleteCommand(object source, GridCommandEventArgs e)
          {
            var kind_code = ((GridDataItem)e.Item).GetDataKeyValue("kind_code");

            try
            {
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "update ms_product_kind set stEdit = '4', LastUpdate = getdate(), Userid = @Usr where kind_code = @kind_code";
                cmd.Parameters.AddWithValue("@kind_code", kind_code);
                cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
                cmd.ExecuteNonQuery();
                con.Close();

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

        protected void cb_st_main_PreRender(object sender, EventArgs e)
        {
            if((sender as RadComboBox).Text== "Stock and Value")
            {
                (sender as RadComboBox).SelectedValue = "0";
            }
            else if ((sender as RadComboBox).Text == "Only Stock")
            {
                (sender as RadComboBox).SelectedValue = "1";
            }
            else
            {
                (sender as RadComboBox).SelectedValue = "2";
            }
        }

        protected void cb_st_main_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if ((sender as RadComboBox).Text == "Stock and Value")
            {
                (sender as RadComboBox).SelectedValue = "0";
            }
            else if ((sender as RadComboBox).Text == "Only Stock")
            {
                (sender as RadComboBox).SelectedValue = "1";
            }
            else
            {
                (sender as RadComboBox).SelectedValue = "2";
            }
        }

        protected void cb_type_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT prod_type_code from ms_product_type where prod_type_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }

        protected void RadGrid1_ItemCreated(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridEditableItem & e.Item.IsInEditMode)
            {
                GridEditFormItem item = (GridEditFormItem)e.Item;
                TextBox txt = (item.FindControl("txt_kind_code") as TextBox);
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