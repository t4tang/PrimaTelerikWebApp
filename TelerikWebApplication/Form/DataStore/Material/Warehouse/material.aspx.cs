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

namespace TelerikWebApplication.Form.DataStore.Material.Warehouse
{
    public partial class material : System.Web.UI.Page
    {
        public static string koneksi = ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString;
        SqlConnection con = new SqlConnection(koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();
        public static string wh_code;

        protected void Page_Load(object sender, EventArgs e)
        {
            wh_code = Request.QueryString["wh_code"].ToString();
        }
        public DataTable GetDataDetailTable(string wh_code)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT inv00d01.wh_code, inv00d01.prod_code, inv00h01.spec, inv00h01.unit, inv00d01.QACT, inv00d01.KoLok, " +
                              "inv00d01.qtyMax, inv00d01.qtyMin FROM inv00d01 INNER JOIN inv00h01 ON inv00d01.prod_code = inv00h01.prod_code " +
                              "Where inv00d01.wh_code = '" + wh_code + "'";
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
            RadGridMaterial.DataSource = GetDataDetailTable(wh_code);
            RadGridMaterial.DataBind();
        }

        protected void RadGridMaterial_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            (sender as RadGrid).DataSource = GetDataDetailTable(wh_code);
        }
        protected void cb_prod_code_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            string sql = "SELECT TOP (100)[prod_code], [spec],[unit] FROM [inv00h01]  WHERE [stEdit] != '4' AND [spec] LIKE @spec + '%'";
            SqlDataAdapter adapter = new SqlDataAdapter(sql,
                ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@spec", e.Text);

            DataTable dt = new DataTable();
            adapter.Fill(dt);

            RadComboBox comboBox = (RadComboBox)sender;
            // Clear the default Item that has been re-created from ViewState at this point.
            comboBox.Items.Clear();

            foreach (DataRow row in dt.Rows)
            {
                RadComboBoxItem item = new RadComboBoxItem();
                item.Text = row["Prod_code"].ToString();
                item.Value = row["Prod_code"].ToString();
                item.Attributes.Add("spec", row["spec"].ToString());
                item.Attributes.Add("unit", row["unit"].ToString());
                //item.Attributes.Add("stMainNm", row["stMainNm"].ToString());

                comboBox.Items.Add(item);

                item.DataBind();
            }
        }
        protected void cb_prod_code_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            Session["action"] = "list";

            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "SELECT [prod_code], [spec],[unit] FROM " +
                    "[inv00h01] WHERE [prod_code] = '" + (sender as RadComboBox).SelectedValue + "'";

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                foreach (DataRow dtr in dt.Rows)
                {
                    RadComboBox cb = (RadComboBox)sender;
                    GridEditableItem item = (GridEditableItem)cb.NamingContainer;
                    Label lb_uom = (Label)item.FindControl("lblUom_insertTemp");
                    Label lbl_spec = (Label)item.FindControl("lblSpec_insertTemp");
                   
                    lb_uom.Text = dtr["unit"].ToString();
                    lbl_spec.Text = dtr["spec"].ToString();
                }

            }
            catch (Exception ex)
            {
                Response.Write("<script language='javascript'>alert('" + ex.Message + "')</script>");
            }
            finally
            {
                con.Close();
            }
        }

        protected void RadGridMaterial_InsertCommand(object sender, GridCommandEventArgs e)
        {
            //var kindCode = ((GridEditFormItem)e.Item).GetDataKeyValue("wh_code");

            try
            {
                //if (e.CommandName == RadGrid.inser)
                //{
                    if (e.Item is GridEditFormItem)
                    {
                        GridEditFormItem item = (GridEditFormItem)e.Item;
                        //cmd = new SqlCommand(con);
                        //cmd.CommandType = CommandType.Text;
                        //cmd.Connection = con;
                        con.Open();
                        cmd = new SqlCommand("INSERT into inv00d01 (wh_code, prod_code, QACT, qtyMax, qtyMin, Cogs) VALUES " +
                                           "(@wh_code, @prod_code, @QACT, @qtyMax, @qtyMin, 0)", con);
                        cmd.Parameters.AddWithValue("@wh_code", wh_code);
                        cmd.Parameters.AddWithValue("@prod_code", (item.FindControl("cb_prod_code") as RadComboBox).Text);
                        //cmd.Parameters.AddWithValue("@KoLok", (item.FindControl("lbl_prod_code") as DropDownList).Text);
                        cmd.Parameters.AddWithValue("@QACT", Convert.ToDouble((item.FindControl("txt_qtyActInsert") as RadTextBox).Text));
                        //cmd.Parameters.AddWithValue("@Cogs", (item.FindControl("cb_sales_return") as RadComboBox).Text);
                        //cmd.Parameters.AddWithValue("@AccInventory", (item.FindControl("cb_pur_inventory") as RadComboBox).Text);
                        //cmd.Parameters.AddWithValue("@Stamp", (item.FindControl("cb_sales_disc") as RadComboBox).Text);
                        //cmd.Parameters.AddWithValue("@Usr", (item.FindControl("cb_pur_return") as RadComboBox).Text);
                        //cmd.Parameters.AddWithValue("@Owner", (item.FindControl("cb_pur_discount") as RadComboBox).Text);
                        //cmd.Parameters.AddWithValue("@OwnStamp", (DATE).Text);
                        //cmd.Parameters.AddWithValue("@topname", (item.FindControl("cb_other_rev") as RadComboBox).Text);
                        cmd.Parameters.AddWithValue("@qtyMax", Convert.ToDouble((item.FindControl("txt_qtyMaxInsert") as RadTextBox).Text));
                        cmd.Parameters.AddWithValue("@qtyMin", Convert.ToDouble((item.FindControl("txt_qtyMinInsert") as RadTextBox).Text));
                        cmd.ExecuteNonQuery();
                        con.Close();

                        RadGridMaterial.DataBind();
                    }

                //}

                Label lblsuccess = new Label();
                lblsuccess.Text = "Data updated successfully";
                lblsuccess.ForeColor = System.Drawing.Color.Blue;
                RadGridMaterial.Controls.Add(lblsuccess);
            }
            catch (Exception ex)
            {
                con.Close();
                Label lblError = new Label();
                lblError.Text = "Unable to update data. Reason: " + ex.Message;
                lblError.ForeColor = System.Drawing.Color.Red;
                RadGridMaterial.Controls.Add(lblError);
                e.Canceled = true;
            }
        }

        protected void RadGridMaterial_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            var prodCode = ((GridDataItem)e.Item).GetDataKeyValue("prod_code");

            try
            {
                GridEditableItem item = (GridEditableItem)e.Item;
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "delete from inv00d01 where wh_code = @wh_code and prod_code = @prod_code";
                cmd.Parameters.AddWithValue("@wh_code", wh_code);
                cmd.Parameters.AddWithValue("@prod_code", (item.FindControl("lbl_prod_code") as Label).Text);
                cmd.ExecuteNonQuery();
                con.Close();
                RadGridMaterial.DataBind();

                //notif.Text = "Data berhasil dihapus";
                //notif.Title = "Notification";
                //notif.Show();
            }
            catch (Exception ex)
            {
                con.Close();
                //RadGridMaterial.RadAlert(ex.Message, 500, 200, "Error", "");
                e.Canceled = true;
            }
        }
    }
}