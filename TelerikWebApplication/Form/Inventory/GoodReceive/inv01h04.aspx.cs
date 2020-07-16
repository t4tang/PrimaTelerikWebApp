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

namespace TelerikWebApplication.Form.Inventory.GoodReceive
{
    public partial class inv01h04 : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();
        private const int ItemsPerRequest = 10;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                dtp_from.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
                dtp_to.SelectedDate = DateTime.Now;
                //cb_bank_prm.SelectedValue = public_str.site;

                set_info();
                Session["action"] = "Firstload";
                RadGrid2.Enabled = false;
                btnSave.Enabled = false;
                btnSave.ImageUrl = "~/Images/simpan-gray.png";
                btnPrint.Enabled = false;
                btnPrint.ImageUrl = "~/Images/cetak-gray.png";
                //dtp_created.SelectedDate = DateTime.Now;
            }
        }
        private void set_info()
        {
            txt_uid.Text = public_str.uid;
            txt_lastUpdate.Text = string.Format("{0:dd/MM/yyyy hh:mm:ss}", DateTime.Now);
            txt_owner.Text = public_str.uid;
            txt_printed.Text = "0";
            txt_edited.Text = "0";
        }
        protected void btnOk_Click(object sender, EventArgs e)
        {
            foreach (GridDataItem item in RadGrid1.SelectedItems)
            {
                //txt_ur_number.Text = item["doc_code"].Text;
                //dtp_ur.SelectedDate = Convert.ToDateTime(item["doc_date"].Text);

                con.Open();
                SqlDataReader sdr;
                SqlCommand cmd = new SqlCommand("SELECT * FROM v_good_receiveH WHERE trans_code='1' AND lbm_code = '" + item["lbm_code"].Text + "'", con);
                sdr = cmd.ExecuteReader();
                if (sdr.Read())
                {
                    txt_gr_number.Text = sdr["lbm_code"].ToString();
                    cb_from.Text = sdr["trans_code"].ToString();
                    dtp_from.SelectedDate = Convert.ToDateTime(sdr["ref_date"].ToString());
                    cb_project.Text = sdr["region_name"].ToString();
                    cb_supplier.Text = sdr["cust_name"].ToString();
                    txt_supplier.Text = sdr["cust_name"].ToString();
                    cb_ref.Text = sdr["ref_code"].ToString();
                    dtp_ref.SelectedDate = Convert.ToDateTime(sdr["ref_date"].ToString());
                    cb_costcenter.Text = sdr["CostCenterName"].ToString();
                    txt_delivery_note.Text = sdr["sj"].ToString();
                    cb_storage.Text = sdr["wh_name"].ToString();
                    cb_created.Text = sdr["createby_name"].ToString();
                    cb_received.Text = sdr["Receiptby_name"].ToString();
                    cb_approved.Text = sdr["approval_name"].ToString();
                    //txt_lastupdate.Text = string.Format("{0:dd-MM-yyyy}", sdr["lastupdate"].ToString());
                    txt_remark.Text = sdr["remark"].ToString();
                    txt_uid.Text = sdr["userid"].ToString();
                    txt_lastUpdate.Text = sdr["lastupdate"].ToString();
                    txt_owner.Text = sdr["Owner"].ToString();
                    txt_printed.Text = sdr["Printed"].ToString();
                    txt_edited.Text = sdr["Edited"].ToString();
                    chk_posting.Text = sdr["status_post"].ToString();
                }
                con.Close();
                RadGrid2.DataSource = GetDataDetailTable(txt_gr_number.Text);
                RadGrid2.DataBind();
                Session["action"] = "edit";
                btnSave.Enabled = true;
                btnSave.ImageUrl = "~/Images/simpan.png";
                btnPrint.Enabled = true;
                btnPrint.ImageUrl = "~/Images/cetak.png";
                btnPrint.Attributes["OnClick"] = String.Format("return ShowPreview('{0}');", txt_gr_number.Text);
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            RadGrid1.DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), cb_project_prm.SelectedValue);
            RadGrid1.DataBind();
        }

        protected void btnNew_Click(object sender, ImageClickEventArgs e)
        {
            Session["action"] = "new";
            btnSave.Enabled = true;
            btnSave.ImageUrl = "~/Images/simpan.png";
            RadGrid2.DataSource = new string[] { };
            RadGrid2.DataBind();
            RadGrid2.Enabled = false;
            btnPrint.ImageUrl = "~/Images/cetak-gray.png";
            if (Session["action"].ToString() != "FirstLoad")
            {
                clear_text(Page.Controls);
            }
            set_info();
        }
        private void clear_text(ControlCollection ctrls)
        {
            foreach (Control ctrl in ctrls)
            {
                if (ctrl is RadTextBox)
                {
                    ((RadTextBox)ctrl).Text = string.Empty;
                }
                if (ctrl is RadComboBox)
                    ((RadComboBox)ctrl).Text = string.Empty;
            }
        }
        private static DataTable GetSupplier(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select cust_code, cust_name from v_good_receiveH where cust_name LIKE @text + '%'",
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
            cmd.CommandText = "select * from v_good_receiveH WHERE cust_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["cust_code"].ToString();
            dr.Close();

            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adapter.Fill(dt);
            //foreach (DataRow dr1 in dt.Rows)
            //{
            //    RadComboBox cb = (RadComboBox)sender;
            //    GridEditableItem item = (GridEditableItem)cb.NamingContainer;
            //    RadTextBox txtCurr = (RadTextBox)item.FindControl("txt_currency");
            //    RadTextBox txtCurr = item.FindControl("txt_cur") as RadTextBox;
            //    txt_currency.Text = dr1["cur_code"].ToString();
            //    txt_kurs.Text = dr1["kurs"].ToString();
            //}
            con.Close();
        }

        protected void cb_project_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select * from v_good_receiveH WHERE cust_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["cust_code"].ToString();
            dr.Close();

            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adapter.Fill(dt);
            //foreach (DataRow dr1 in dt.Rows)
            //{
            //    RadComboBox cb = (RadComboBox)sender;
            //    GridEditableItem item = (GridEditableItem)cb.NamingContainer;
            //    RadTextBox txtCurr = (RadTextBox)item.FindControl("txt_currency");
            //    RadTextBox txtCurr = item.FindControl("txt_cur") as RadTextBox;
            //    txt_currency.Text = dr1["cur_code"].ToString();
            //    txt_kurs.Text = dr1["kurs"].ToString();
            //}
            con.Close();
        }

        protected void cb_supplier_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetSupplier(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["cust_name"].ToString(), data.Rows[i]["cust_name"].ToString()));
            }
        }

        protected void cb_supplier_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select * from v_good_receiveH WHERE cust_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["cust_code"].ToString();
            dr.Close();

            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adapter.Fill(dt);
            //foreach (DataRow dr1 in dt.Rows)
            //{
            //    RadComboBox cb = (RadComboBox)sender;
            //    GridEditableItem item = (GridEditableItem)cb.NamingContainer;
            //    RadTextBox txtCurr = (RadTextBox)item.FindControl("txt_currency");
            //    RadTextBox txtCurr = item.FindControl("txt_cur") as RadTextBox;
            //    txt_currency.Text = dr1["cur_code"].ToString();
            //    txt_kurs.Text = dr1["kurs"].ToString();
            //}
            con.Close();
        }

        protected void cb_supplier_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select * from v_good_receiveH WHERE cust_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["cust_code"].ToString();
            dr.Close();

            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adapter.Fill(dt);
            //foreach (DataRow dr1 in dt.Rows)
            //{
            //    RadComboBox cb = (RadComboBox)sender;
            //    GridEditableItem item = (GridEditableItem)cb.NamingContainer;
            //    RadTextBox txtCurr = (RadTextBox)item.FindControl("txt_currency");
            //    RadTextBox txtCurr = item.FindControl("txt_cur") as RadTextBox;
            //    txt_currency.Text = dr1["cur_code"].ToString();
            //    txt_kurs.Text = dr1["kurs"].ToString();
            //}
            con.Close();
        }
        private static DataTable GetCostCenter(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT CostCenter, CostCenterName from inv00h11 WHERE stEdit != 4 AND CostCenterName LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_costcenter_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetCostCenter(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["CostCenterName"].ToString(), data.Rows[i]["CostCenterName"].ToString()));
            }
        }

        protected void cb_costcenter_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT CostCenter FROM inv00h11 WHERE CostCenterName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_costcenter_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT CostCenter FROM inv00h11 WHERE CostCenterName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }

        private static DataTable GetWarehouse(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT wh_code, wh_name FROM inv00h05 WHERE stEdit != 4 AND wh_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }

        protected void cb_storage_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetWarehouse(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["wh_name"].ToString(), data.Rows[i]["wh_name"].ToString()));
            }
        }

        protected void cb_storage_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT wh_code FROM inv00h05 WHERE wh_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_storage_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT wh_code FROM inv00h05 WHERE wh_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }

        private static DataTable GetUsers(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT Nik, Name from inv00h26 WHERE stEdit != 4 AND Name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }

        protected void cb_created_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetUsers(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["Name"].ToString(), data.Rows[i]["Name"].ToString()));
            }
        }

        protected void cb_created_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + cb_approved.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_approved.SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_created_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + cb_approved.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_approved.SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_received_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetUsers(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["Name"].ToString(), data.Rows[i]["Name"].ToString()));
            }
        }

        protected void cb_received_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + cb_approved.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_approved.SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_received_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + cb_approved.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_approved.SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_approved_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetUsers(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["Name"].ToString(), data.Rows[i]["Name"].ToString()));
            }
        }

        protected void cb_approved_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + cb_approved.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_approved.SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_approved_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + cb_approved.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_approved.SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }

        protected void btnSave_Click(object sender, ImageClickEventArgs e)
        {
            long maxNo;
            string run = null;
            string trDate = string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate);

            try
            {
                if (Session["action"].ToString() == "edit")
                {
                    run = txt_gr_number.Text;
                }
                else
                {
                    con.Open();
                    SqlDataReader sdr;
                    cmd = new SqlCommand("SELECT ISNULL ( MAX ( RIGHT ( inv01h04.lbm_code , 4 ) ) , 0 ) + 1 AS maxNo " +
                       "FROM inv01h04 WHERE LEFT(inv01h04.lbm_code, 4) ='GR03' " +
                       "AND SUBSTRING(inv01h04.lbm_code, 5, 2) = SUBSTRING('" + trDate + "', 9, 2) " +
                       "AND SUBSTRING(inv01h04.lbm_code, 7, 2) = SUBSTRING('" + trDate + "', 4, 2) ", con);
                    sdr = cmd.ExecuteReader();
                    if (sdr.HasRows == false)
                    {
                        //throw new Exception();
                        run = "GR03" + dtp_from.SelectedDate.Value.Year + dtp_from.SelectedDate.Value.Month + "0001";
                    }
                    else if (sdr.Read())
                    {
                        maxNo = Convert.ToInt32(sdr[0].ToString());
                        run = "GR03" +
                            (dtp_from.SelectedDate.Value.Year.ToString()).Substring(dtp_from.SelectedDate.Value.Year.ToString().Length - 2) +
                            ("0000" + dtp_from.SelectedDate.Value.Month).Substring(("0000" + dtp_from.SelectedDate.Value.Month).Length - 2, 2) +
                            ("0000" + maxNo).Substring(("0000" + maxNo).Length - 4, 4);
                    }
                    con.Close();
                }
                txt_gr_number.Text = run;

                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_save_goods_receiveH";
                cmd.Parameters.AddWithValue("@lbm_code", run);
                cmd.Parameters.AddWithValue("@cust_code", cb_supplier.SelectedValue);
                cmd.Parameters.AddWithValue("@cust_name", txt_supplier.Text);
                cmd.Parameters.AddWithValue("@trans_code", cb_from.SelectedValue);
                cmd.Parameters.AddWithValue("@ref_code", cb_ref.SelectedValue);
                cmd.Parameters.AddWithValue("@lbm_date", string.Format("{0:yyyy-MM-dd}", dtp_gr.SelectedDate));
                cmd.Parameters.AddWithValue("@ref_date", string.Format("{0:yyyy-MM-dd}", dtp_ref.SelectedDate.Value));
                //cmd.Parameters.AddWithValue("@po_code", txt.SelectedValue);
                cmd.Parameters.AddWithValue("@status_lbm", cb_from.SelectedValue);
                cmd.Parameters.AddWithValue("@sj", txt_delivery_note.Text);
                cmd.Parameters.AddWithValue("@lastupdate", txt_lastUpdate.Text);
                cmd.Parameters.AddWithValue("@userid", txt_uid.Text);
                cmd.Parameters.AddWithValue("@remark", txt_remark.Text);
                cmd.Parameters.AddWithValue("@wh_code", cb_storage.Text);
                cmd.Parameters.AddWithValue("@status_post", DateTime.Today);
                //cmd.Parameters.AddWithValue("@PlantCode", txt_remark.Text);
                cmd.Parameters.AddWithValue("@createby", cb_created.SelectedValue);
                cmd.Parameters.AddWithValue("@Receiptby", cb_received.SelectedValue);
                cmd.Parameters.AddWithValue("@approval", cb_approved.SelectedValue);
                cmd.Parameters.AddWithValue("@dept_code", txt_costcenter.Text);
                cmd.Parameters.AddWithValue("@region_code", txt_project.Text);
                //cmd.Parameters.AddWithValue("@asset_id", Convert.ToDecimal(txt_kurs2.Text));
                cmd.Parameters.AddWithValue("@Owner", txt_owner.Text);
                cmd.Parameters.AddWithValue("@OwnStamp", string.Format("{0:yyyy-MM-dd}", dtp_gr.SelectedDate));
                cmd.Parameters.AddWithValue("@Printed", txt_printed.Text);
                cmd.Parameters.AddWithValue("@Edited", txt_edited.Text);
                //cmd.Parameters.AddWithValue("@Otorisasi", txt_NoCtrl.Text);
                //cmd.Parameters.AddWithValue("@OtoUsr", public_str.level);
                //cmd.Parameters.AddWithValue("@OtoStamp", cb_pre.SelectedValue);
                cmd.Parameters.AddWithValue("@Lvl", public_str.level);
                //cmd.Parameters.AddWithValue("@doc_type", cb_approve.SelectedValue);
                //cmd.Parameters.AddWithValue("@from_region_code", txt_NoCtrl.Text);
                //cmd.Parameters.AddWithValue("@tAllocate", txt_NoCtrl.Text);
                cmd.ExecuteNonQuery();

                Label lblsuccess = new Label();
                lblsuccess.Text = "Data saved successfully";
                lblsuccess.ForeColor = System.Drawing.Color.Blue;
                //RadGrid1.Controls.Add(lblsuccess);
                con.Close();
            }
            catch (Exception ex)
            {
                con.Close();
                Label lblError = new Label();
                lblError.Text = "Unable to save data. Reason: " + ex.Message;
                lblError.ForeColor = System.Drawing.Color.Red;
                //RadGrid1.Controls.Add(lblError);
                //throw;
            }
        }

        protected void RadGrid1_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            (sender as RadGrid).DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), cb_project_prm.SelectedValue);
        }
        public DataTable GetDataTable(string date, string todate, string project)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_goods_receiveH";
            cmd.Parameters.AddWithValue("@date", date);
            cmd.Parameters.AddWithValue("@todate", todate);
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
        protected void RadGrid1_DeleteCommand(object sender, GridCommandEventArgs e)
        {

        }
        protected void RadGrid2_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            //(sender as RadGrid).DataSource = GetDataDetailTable(txt_gr_number.Text);
        }
        public DataTable GetDataDetailTable(string slip_no)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT * FROM v_bank_paymentD where slip_no = @slipno";
            cmd.Parameters.AddWithValue("@slipno", slip_no);
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
        protected void RadGrid2_DeleteCommand(object sender, GridCommandEventArgs e)
        {

        }
        protected void cb_project_prm_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
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
        private static DataTable GetProject(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select region_code, region_name from inv00h09 WHERE stEdit != 4 AND region_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_project_prm_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT region_code FROM inv00h09 WHERE region_name = '" + cb_project_prm.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_project_prm.SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }

        protected void btnPrint_Click(object sender, ImageClickEventArgs e)
        {

        }
        protected void cb_from_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Add("Supplier");
            (sender as RadComboBox).Items.Add("Consigment");
            (sender as RadComboBox).Items.Add("Return");
            (sender as RadComboBox).Items.Add("Assembly");
        }

        protected void cb_from_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if ((sender as RadComboBox).Text == "Return")
            {
                (sender as RadComboBox).SelectedValue = "1";
            }
            else if ((sender as RadComboBox).Text == "Compliment")
            {
                (sender as RadComboBox).SelectedValue = "2";
            }
            else if ((sender as RadComboBox).Text == "Supplier")
            {
                (sender as RadComboBox).SelectedValue = "3";
            }
            else if ((sender as RadComboBox).Text == "Assembly")
            {
                (sender as RadComboBox).SelectedValue = "4";
            }
        }

        protected void cb_from_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadComboBox).Text == "Return")
            {
                (sender as RadComboBox).SelectedValue = "1";
            }
            else if ((sender as RadComboBox).Text == "Compliment")
            {
                (sender as RadComboBox).SelectedValue = "2";
            }
            else if ((sender as RadComboBox).Text == "Supplier")
            {
                (sender as RadComboBox).SelectedValue = "3";
            }
            else if ((sender as RadComboBox).Text == "Assembly")
            {
                (sender as RadComboBox).SelectedValue = "4";
            }
        }
    }
}