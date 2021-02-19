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

namespace TelerikWebApplication.Form.Purchase.InfoRecord
{
    public partial class inv01h06EditForm : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();

        private const int ItemsPerRequest = 10;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["info_code"] != null)
                {
                    fill_object(Request.QueryString["info_code"].ToString());
                    RadGrid2.DataSource = GetDataDetailTable(txt_info_record.Text);
                    RadGrid2.DataBind();
                    Session["actionEdit"] = "edit";
                    RadGrid2.Enabled = true;
                    //btn_edit_item.Enabled = true;
                }
                else
                {
                    Session["actionEdit"] = "new";

                    cb_type.Text = "Standard";
                    //cb_project.SelectedValue = public_str.site;
                    //cb_project.Text = public_str.sitename;
                    txt_uid.Text = public_str.user_id;
                    txt_owner.Text = public_str.user_id;
                    txt_lastUpdate.Text = string.Format("{0:dd/MM/yyyy}", DateTime.Now);
                    txt_printed.Text = "0";
                    txt_edited.Text = "0";
                    txt_disch.Text = "0";
                    
                }
            }
        }
        protected void fill_object(string id)
        {
            con.Open();
            SqlDataReader sdr;
            SqlCommand cmd = new SqlCommand("SELECT * FROM v_info_recordH WHERE stEdit <> '4' AND info_code = '" + id + "'", con);
            sdr = cmd.ExecuteReader();
            if (sdr.Read())
            {
                txt_info_record.Text = sdr["info_code"].ToString();
                cb_type.Text = sdr["type_info"].ToString();
                cb_project.Text = sdr["region_name"].ToString();
                cb_supplier.Text = sdr["cust_name"].ToString();
                txt_curr.Text = sdr["cur_code"].ToString();
                txt_disch.Text = sdr["Disc"].ToString();
                txt_remark.Text = sdr["remark"].ToString();

                txt_owner.Text = sdr["Owner"].ToString();
                txt_printed.Text = sdr["Printed"].ToString();
                txt_edited.Text = sdr["Edited"].ToString();
                txt_uid.Text = sdr["userid"].ToString();
                txt_lastUpdate.Text = string.Format("{0:dd/MM/yyyy}", sdr["LastUpdate"].ToString());              

            }
            con.Close();

        }

        #region Type
        protected void cb_type_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Add("Standard");
            (sender as RadComboBox).Items.Add("Consigment");
        }

        protected void cb_type_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if ((sender as RadComboBox).Text == "Standard")
            {
                (sender as RadComboBox).SelectedValue = "1";
            }
            else if ((sender as RadComboBox).Text == "Consigment")
            {
                (sender as RadComboBox).SelectedValue = "2";
            }
        }

        protected void cb_type_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadComboBox).Text == "Standard")
            {
                (sender as RadComboBox).SelectedValue = "1";
            }
            else if ((sender as RadComboBox).Text == "Consigment")
            {
                (sender as RadComboBox).SelectedValue = "2";
            }
        }

        #endregion

        #region Project
        private static DataTable GetProject(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT region_code, region_name FROM inv00h09 WHERE stEdit != 4 AND region_name LIKE @text + '%' ",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_project_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetProject(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["region_name"].ToString(), data.Rows[i]["region_name"].ToString()));
            }
        }

        protected void cb_project_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT region_code FROM inv00h09 WHERE region_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            }
            dr.Close();
            con.Close();
        }

        protected void cb_project_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT region_code FROM inv00h09 WHERE region_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            }
            dr.Close();
            con.Close();
        }
        #endregion

        #region Supplier
        private static DataTable GetSupplier(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select supplier_code, supplier_name from pur00h01 where supplier_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_supplier_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetSupplier(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["supplier_name"].ToString(), data.Rows[i]["supplier_name"].ToString()));
            }
        }

        protected void cb_supplier_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT     a.supplier_code, a.cur_code " +
                               " FROM pur00h01 a inner join acc00h04 e on a.cur_code = e.cur_code WHERE a.supplier_name = '" + cb_supplier.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                //(sender as RadComboBox).Text = dr["doc_code"].ToString();
                (sender as RadComboBox).SelectedValue = dr["supplier_code"].ToString();
                txt_curr.Text = dr["cur_code"].ToString();
            }

            dr.Close();
            con.Close();
        }

        protected void cb_supplier_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select supplier_code from pur00h01 WHERE supplier_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["supplier_code"].ToString();
            dr.Close();

            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adapter.Fill(dt);

            con.Close();
        }
        #endregion

        protected void btnSave_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                string run;

                if (Session["actionEdit"].ToString() == "edit")
                {
                    run = txt_info_record.Text;

                }
                else
                {
                    run = cb_project.SelectedValue + "-" + cb_supplier.SelectedValue + "-" + cb_type.SelectedValue;
                }
                txt_info_record.Text = run;

                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_save_info_recordH";
                cmd.Parameters.AddWithValue("@info_code", run);
                cmd.Parameters.AddWithValue("@type_info", cb_type.SelectedValue);
                cmd.Parameters.AddWithValue("@cur_code", txt_curr.Text);
                cmd.Parameters.AddWithValue("@remark", txt_remark.Text);
                cmd.Parameters.AddWithValue("@Disc", txt_disch.Text);
                cmd.Parameters.AddWithValue("@userid", public_str.uid);
                cmd.Parameters.AddWithValue("@supplier_code", cb_supplier.SelectedValue);
                cmd.Parameters.AddWithValue("@supplier_name", cb_supplier.Text);
                cmd.Parameters.AddWithValue("@region_code", cb_project.SelectedValue);
                cmd.Parameters.AddWithValue("@Owner", public_str.uid);
                //cmd.Parameters.AddWithValue("@Lvl", public_str.level);
                

                cmd.ExecuteNonQuery();

                //Save Detail

                foreach (GridDataItem item in RadGrid2.MasterTableView.Items)
                {
                    cmd = new SqlCommand();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Connection = con;
                    cmd.CommandText = "sp_save_info_recordD";
                    cmd.Parameters.AddWithValue("@info_code", run);
                    cmd.Parameters.AddWithValue("@prod_code", (item.FindControl("lblProdCode") as Label).Text);
                    cmd.Parameters.AddWithValue("@qty", Convert.ToDouble((item.FindControl("txt_qty") as RadTextBox).Text));
                    cmd.Parameters.AddWithValue("@min_qty", Convert.ToDouble((item.FindControl("txt_qty_min") as RadTextBox).Text));
                    cmd.Parameters.AddWithValue("@max_qty", Convert.ToDouble((item.FindControl("txt_qty_max") as RadTextBox).Text));
                    cmd.Parameters.AddWithValue("@harga", Convert.ToDouble((item.FindControl("txt_harga") as RadTextBox).Text));
                    cmd.Parameters.AddWithValue("@Disc", Convert.ToDouble((item.FindControl("txt_disc") as RadTextBox).Text));
                    cmd.Parameters.AddWithValue("@SatQty", (item.FindControl("lblUom") as Label).Text);
                    cmd.Parameters.AddWithValue("@remark", (item.FindControl("txtRemark_d") as RadTextBox).Text);
                    cmd.Parameters.AddWithValue("@ValidDate", string.Format("{0:yyyy-MM-dd}", (item.FindControl("dtpDelivDate") as RadDatePicker).SelectedDate));

                    cmd.ExecuteNonQuery();

                    con.Close();
                    notif.Text = "Data berhasil disimpan";
                    notif.Title = "Notification";
                    notif.Show();
                    txt_info_record.Text = run;

                    if (Session["actionEdit"].ToString() == "edit")
                    {
                        ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind();", true);
                    }
                    else
                    {
                        ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind('navigateToInserted');", true);
                    }
                    inv01h06.tr_code = run;
                    inv01h06.selected_project = cb_project.SelectedValue;
                }

                con.Close();

            }
            catch (System.Exception ex)
            {
                con.Close();
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
            }
        }

        protected void RadGrid2_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            if (!IsPostBack)
            {
                (sender as RadGrid).DataSource = new string[] { };
            }
            else if (Session["actionEdit"].ToString() == "new")
            {
                (sender as RadGrid).DataSource = new string[] { };
            }
            else if (Session["actionEdit"].ToString() == "edit")
            {
                (sender as RadGrid).DataSource = new string[] { };
                (sender as RadGrid).DataSource = GetDataDetailTable(txt_info_record.Text);
            }
        }

        public DataTable GetDataDetailTable(string info_code)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT prod_code, qty, min_qty, max_qty, SatQty, harga, disc, validdate, remark  FROM v_info_recordD where info_code = @info_code";
            cmd.Parameters.AddWithValue("@info_code", info_code);
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
        protected void RadGrid2_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadGrid).MasterTableView.Items.Count < (sender as RadGrid).MasterTableView.PageSize)
            {
                (sender as RadGrid).ClientSettings.Scrolling.AllowScroll = false;
                (sender as RadGrid).ClientSettings.Scrolling.UseStaticHeaders = false;
            }
        }

        protected void RadGrid2_DeleteCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            var partCode = ((GridDataItem)e.Item).GetDataKeyValue("Prod_code");

            try
            {
                GridEditableItem item = (GridEditableItem)e.Item;
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "delete from inv01d06 where prod_code = @prod_code and info_code = @info_code";
                cmd.Parameters.AddWithValue("@info_code", txt_info_record.Text);
                cmd.Parameters.AddWithValue("@prod_code", partCode);
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

    }
}