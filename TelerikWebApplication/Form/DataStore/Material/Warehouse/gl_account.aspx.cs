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
    public partial class gl_account : System.Web.UI.Page
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
            cmd.CommandText = "SELECT * FROM v_gl_account_of_category WHERE wh_code = '" + wh_code + "'";
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
            //if (selected_wh_code == null)
            //{
            //    RadGridGLAcc.DataSource = new string[] { };
            //}
            //else
            //{
            RadGridGLAcc.DataSource = GetDataDetailTable(wh_code);
            //}

            RadGridGLAcc.DataBind();
        }
        protected void RadGridGLAcc_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            (sender as RadGrid).DataSource = GetDataDetailTable(wh_code);
        }
        protected void GetAccount(string accountno, RadComboBox cb)
        {
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);

            SqlDataAdapter adapter = new SqlDataAdapter("SELECT gl_account.accountno, UPPER(gl_account.accountname) AS accountname, gl_account.accountgroup, gl_account.cur_code, gl_account_group.balance, gl_account_group.groupname  " +
                "FROM gl_account INNER JOIN gl_account_group ON gl_account.accountgroup = gl_account_group.accountgroup WHERE(gl_account.stEdit = '0') " +
                "AND accountno LIKE @text + '%'", con);
            adapter.SelectCommand.Parameters.AddWithValue("@text", accountno);
            DataTable dt = new DataTable();
            adapter.Fill(dt);

            cb.DataTextField = "accountno";
            cb.DataValueField = "accountno";
            cb.DataSource = dt;
            cb.DataBind();
        }
        protected void cb_acc_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            GetAccount(e.Text, (sender as RadComboBox));
        }

        protected void cb_sales_acc_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "SELECT accountname FROM gl_account WHERE accountno = '" + (sender as RadComboBox).Text + "'";

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                foreach (DataRow dtr in dt.Rows)
                {
                    RadComboBox cb = (RadComboBox)sender;
                    GridEditableItem item = (GridEditableItem)cb.NamingContainer;
                    RadLabel label = (RadLabel)item.FindControl("lbl_sales_acc_name");

                    label.Text = dtr["accountname"].ToString();
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

        protected void cb_sales_return_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "SELECT accountname FROM gl_account WHERE accountno = '" + (sender as RadComboBox).Text + "'";

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                foreach (DataRow dtr in dt.Rows)
                {
                    RadComboBox cb = (RadComboBox)sender;
                    GridEditableItem item = (GridEditableItem)cb.NamingContainer;
                    RadLabel label = (RadLabel)item.FindControl("lbl_sales_return");

                    label.Text = dtr["accountname"].ToString();
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

        protected void cb_sales_disc_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "SELECT accountname FROM gl_account WHERE accountno = '" + (sender as RadComboBox).Text + "'";

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                foreach (DataRow dtr in dt.Rows)
                {
                    RadComboBox cb = (RadComboBox)sender;
                    GridEditableItem item = (GridEditableItem)cb.NamingContainer;
                    RadLabel label = (RadLabel)item.FindControl("lbl_sales_disc_name");

                    label.Text = dtr["accountname"].ToString();
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

        protected void cb_sales_cogs_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "SELECT accountname FROM gl_account WHERE accountno = '" + (sender as RadComboBox).Text + "'";

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                foreach (DataRow dtr in dt.Rows)
                {
                    RadComboBox cb = (RadComboBox)sender;
                    GridEditableItem item = (GridEditableItem)cb.NamingContainer;
                    RadLabel label = (RadLabel)item.FindControl("lbl_sales_cogs_name");

                    label.Text = dtr["accountname"].ToString();
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

        protected void cb_sales_inventory_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "SELECT accountname FROM gl_account WHERE accountno = '" + (sender as RadComboBox).Text + "'";

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                foreach (DataRow dtr in dt.Rows)
                {
                    RadComboBox cb = (RadComboBox)sender;
                    GridEditableItem item = (GridEditableItem)cb.NamingContainer;
                    RadLabel label = (RadLabel)item.FindControl("lbl_pur_inventory_name");

                    label.Text = dtr["accountname"].ToString();
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

        protected void cb_pur_return_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "SELECT accountname FROM gl_account WHERE accountno = '" + (sender as RadComboBox).Text + "'";

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                foreach (DataRow dtr in dt.Rows)
                {
                    RadComboBox cb = (RadComboBox)sender;
                    GridEditableItem item = (GridEditableItem)cb.NamingContainer;
                    RadLabel label = (RadLabel)item.FindControl("lbl_pur_return_name");

                    label.Text = dtr["accountname"].ToString();
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

        protected void cb_pur_discount_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "SELECT accountname FROM gl_account WHERE accountno = '" + (sender as RadComboBox).Text + "'";

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                foreach (DataRow dtr in dt.Rows)
                {
                    RadComboBox cb = (RadComboBox)sender;
                    GridEditableItem item = (GridEditableItem)cb.NamingContainer;
                    RadLabel label = (RadLabel)item.FindControl("lbl_pur_discount_name");

                    label.Text = dtr["accountname"].ToString();
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

        protected void cb_other_assembly_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "SELECT accountname FROM gl_account WHERE accountno = '" + (sender as RadComboBox).Text + "'";

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                foreach (DataRow dtr in dt.Rows)
                {
                    RadComboBox cb = (RadComboBox)sender;
                    GridEditableItem item = (GridEditableItem)cb.NamingContainer;
                    RadLabel label = (RadLabel)item.FindControl("lbl_other_assembly_name");

                    label.Text = dtr["accountname"].ToString();
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

        protected void cb_other_rev_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "SELECT accountname FROM gl_account WHERE accountno = '" + (sender as RadComboBox).Text + "'";

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                foreach (DataRow dtr in dt.Rows)
                {
                    RadComboBox cb = (RadComboBox)sender;
                    GridEditableItem item = (GridEditableItem)cb.NamingContainer;
                    RadLabel label = (RadLabel)item.FindControl("lbl_other_rev_name");

                    label.Text = dtr["accountname"].ToString();
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

        protected void cb_other_consumption_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "SELECT accountname FROM gl_account WHERE accountno = '" + (sender as RadComboBox).Text + "'";

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                foreach (DataRow dtr in dt.Rows)
                {
                    RadComboBox cb = (RadComboBox)sender;
                    GridEditableItem item = (GridEditableItem)cb.NamingContainer;
                    RadLabel label = (RadLabel)item.FindControl("lbl_other_consumption_name");

                    label.Text = dtr["accountname"].ToString();
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

        protected void cb_other_consign_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "SELECT accountname FROM gl_account WHERE accountno = '" + (sender as RadComboBox).Text + "'";

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                foreach (DataRow dtr in dt.Rows)
                {
                    RadComboBox cb = (RadComboBox)sender;
                    GridEditableItem item = (GridEditableItem)cb.NamingContainer;
                    RadLabel label = (RadLabel)item.FindControl("lbl_other_consign_name");

                    label.Text = dtr["accountname"].ToString();
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

        protected void btnUpdateAcc_Click(object sender, EventArgs e)
        {
            //foreach (GridEditableItem item in RadGridGLAcc.Items)
            //{
            //    con.Open();
            //    cmd = new SqlCommand();
            //    cmd.CommandType = CommandType.Text;
            //    cmd.Connection = con;
            //    cmd.CommandText = "UPDATE ms_wh_account set AccCOGS = @AccCOGS, AccSales = @AccSales, AccReturn = @AccReturn, " +
            //                      "AccInventory = @AccInventory, AccSalesDisc = @AccSalesDisc, AccReturnBeli = @AccReturnBeli, " +
            //                      "AccDiscBeli = @AccDiscBeli, AccAssem = @AccAssem, AccRev = @AccRev, AccConsum = @AccConsum, " +
            //                      "AccConsign = @AccConsign where wh_code = @wh_code and kind_code = @kind_code";
            //    cmd.Parameters.AddWithValue("@AccCOGS", (item.FindControl("cb_sales_cogs") as RadTextBox).Text);
            //    cmd.Parameters.AddWithValue("@AccSales", (item.FindControl("cb_sales_acc") as RadTextBox).Text);
            //    cmd.Parameters.AddWithValue("@AccReturn", (item.FindControl("cb_sales_return") as RadTextBox).Text);
            //    cmd.Parameters.AddWithValue("@AccInventory", (item.FindControl("cb_pur_inventory") as RadTextBox).Text);
            //    cmd.Parameters.AddWithValue("@AccSalesDisc", (item.FindControl("cb_sales_disc") as RadTextBox).Text);
            //    cmd.Parameters.AddWithValue("@AccReturnBeli", (item.FindControl("cb_pur_return") as RadTextBox).Text);
            //    cmd.Parameters.AddWithValue("@AccDiscBeli", (item.FindControl("cb_pur_discount") as RadTextBox).Text);
            //    cmd.Parameters.AddWithValue("@AccAssem", (item.FindControl("cb_other_assembly") as RadTextBox).Text);
            //    cmd.Parameters.AddWithValue("@AccRev", (item.FindControl("cb_other_rev") as RadTextBox).Text);
            //    cmd.Parameters.AddWithValue("@AccConsum", (item.FindControl("cb_other_consumption") as RadTextBox).Text);
            //    cmd.Parameters.AddWithValue("@AccConsign", (item.FindControl("cb_other_consign") as RadTextBox).Text);
            //    cmd.ExecuteNonQuery();
            //    con.Close();
            //}
        }

        protected void RadGridGLAcc_UpdateCommand(object sender, GridCommandEventArgs e)
        {
            //var whCode = ((GridEditFormItem)e.Item).GetDataKeyValue("wh_code");
            var kindCode = ((GridEditFormItem)e.Item).GetDataKeyValue("kind_code");

            try
            {
                if (e.CommandName == RadGrid.UpdateCommandName)
                {
                    if (e.Item is GridEditFormItem)
                    {
                        GridEditFormItem item = (GridEditFormItem)e.Item;
                        //cmd = new SqlCommand(con);
                        //cmd.CommandType = CommandType.Text;
                        //cmd.Connection = con;
                        con.Open();
                        cmd = new SqlCommand("UPDATE ms_wh_account set AccCOGS = @AccCOGS, AccSales = @AccSales, AccReturn = @AccReturn, " +
                                      "AccInventory = @AccInventory, AccSalesDisc = @AccSalesDisc, AccReturnBeli = @AccReturnBeli, " +
                                      "AccDiscBeli = @AccDiscBeli, AccAssem = @AccAssem, AccRev = @AccRev, AccConsum = @AccConsum, " +
                                      "AccConsign = @AccConsign where wh_code = @wh_code and kind_code = @kind_code",con);
                        cmd.Parameters.AddWithValue("@wh_code", wh_code);
                        cmd.Parameters.AddWithValue("@kind_code", kindCode);
                        cmd.Parameters.AddWithValue("@AccCOGS", (item.FindControl("cb_sales_cogs") as RadComboBox).Text);
                        cmd.Parameters.AddWithValue("@AccSales", (item.FindControl("cb_sales_acc") as RadComboBox).Text);
                        cmd.Parameters.AddWithValue("@AccReturn", (item.FindControl("cb_sales_return") as RadComboBox).Text);
                        cmd.Parameters.AddWithValue("@AccInventory", (item.FindControl("cb_pur_inventory") as RadComboBox).Text);
                        cmd.Parameters.AddWithValue("@AccSalesDisc", (item.FindControl("cb_sales_disc") as RadComboBox).Text);
                        cmd.Parameters.AddWithValue("@AccReturnBeli", (item.FindControl("cb_pur_return") as RadComboBox).Text);
                        cmd.Parameters.AddWithValue("@AccDiscBeli", (item.FindControl("cb_pur_discount") as RadComboBox).Text);
                        cmd.Parameters.AddWithValue("@AccAssem", (item.FindControl("cb_other_assembly") as RadComboBox).Text);
                        cmd.Parameters.AddWithValue("@AccRev", (item.FindControl("cb_other_rev") as RadComboBox).Text);
                        cmd.Parameters.AddWithValue("@AccConsum", (item.FindControl("cb_other_consumption") as RadComboBox).Text);
                        cmd.Parameters.AddWithValue("@AccConsign", (item.FindControl("cb_other_consign") as RadComboBox).Text);
                        cmd.ExecuteNonQuery();
                        con.Close();

                        RadGridGLAcc.DataBind();
                    }

                }

                Label lblsuccess = new Label();
                lblsuccess.Text = "Data updated successfully";
                lblsuccess.ForeColor = System.Drawing.Color.Blue;
                RadGridGLAcc.Controls.Add(lblsuccess);
            }
            catch (Exception ex)
            {
                con.Close();
                Label lblError = new Label();
                lblError.Text = "Unable to update data. Reason: " + ex.Message;
                lblError.ForeColor = System.Drawing.Color.Red;
                RadGridGLAcc.Controls.Add(lblError);
                e.Canceled = true;
            }
        }

        protected void RadGridGLAcc_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            var kindCode = ((GridDataItem)e.Item).GetDataKeyValue("kind_code");

            try
            {
                GridEditableItem item = (GridEditableItem)e.Item;
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "delete from ms_wh_account where wh_code = @wh_code and kind_code = @kind_code";
                cmd.Parameters.AddWithValue("@wh_code", wh_code);
                cmd.Parameters.AddWithValue("@kind_code", kindCode);
                cmd.ExecuteNonQuery();
                con.Close();
                RadGridGLAcc.DataBind();

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
