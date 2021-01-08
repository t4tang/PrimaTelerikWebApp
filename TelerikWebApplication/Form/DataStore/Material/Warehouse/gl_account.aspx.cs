﻿using System;
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

            SqlDataAdapter adapter = new SqlDataAdapter("SELECT acc00h10.accountno, UPPER(acc00h10.accountname) AS accountname, acc00h10.accountgroup, acc00h10.cur_code, acc00h12.balance, acc00h12.groupname  " +
                "FROM acc00h10 INNER JOIN acc00h12 ON acc00h10.accountgroup = acc00h12.accountgroup WHERE(acc00h10.stEdit = '0') " +
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
                cmd.CommandText = "SELECT accountname FROM acc00h10 WHERE accountno = '" + (sender as RadComboBox).Text + "'";

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
                cmd.CommandText = "SELECT accountname FROM acc00h10 WHERE accountno = '" + (sender as RadComboBox).Text + "'";

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

        protected void cb_sales_inventory_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "SELECT accountname FROM acc00h10 WHERE accountno = '" + (sender as RadComboBox).Text + "'";

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                foreach (DataRow dtr in dt.Rows)
                {
                    RadComboBox cb = (RadComboBox)sender;
                    GridEditableItem item = (GridEditableItem)cb.NamingContainer;
                    RadLabel label = (RadLabel)item.FindControl("lbl_sales_inventory");

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
    }
}