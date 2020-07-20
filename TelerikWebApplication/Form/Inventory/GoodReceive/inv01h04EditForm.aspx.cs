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
    public partial class inv01h04EditForm : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();

        private const int ItemsPerRequest = 10;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                dtp_gr.SelectedDate = DateTime.Now;
                if (Request.QueryString["lbm_code"] != null)
                {
                    fill_object(Request.QueryString["lbm_code"].ToString());
                    RadGrid2.DataSource = GetDataDetailTable(txt_gr_number.Text);
                    Session["actionEdit"] = "edit";
                }
                else
                {
                    cb_from.Text = "Supplier";
                    Session["actionEdit"] = "new";
                }
            }
        }
        protected void fill_object(string id)
        {
            con.Open();
            SqlDataReader sdr;
            SqlCommand cmd = new SqlCommand("SELECT * FROM v_goods_receiveH WHERE trans_code='1' AND lbm_code = '" + id + "'", con);
            sdr = cmd.ExecuteReader();
            if (sdr.Read())
            {
                txt_gr_number.Text = sdr["lbm_code"].ToString();
                cb_from.Text = sdr["NmMasuk"].ToString();
                //cb_from.SelectedValue = sdr["trans_code"].ToString();
                cb_project.Text = sdr["region_name"].ToString();
                cb_supplier.Text = sdr["cust_name"].ToString();
                //cb_supplier.SelectedValue = sdr["cust_code"].ToString();
                cb_ref.Text = sdr["ref_code"].ToString();
                txt_reff_date.Text = string.Format("{0:dd-MM-yyyy}", sdr["ref_date"].ToString());
                cb_costcenter.Text = sdr["CostCenterName"].ToString();
                txt_delivery_note.Text = sdr["sj"].ToString();
                cb_warehouse.Text = sdr["wh_name"].ToString();
                //cb_warehouse.SelectedValue = sdr["wh_code"].ToString();
                txt_remark.Text = sdr["remark"].ToString();
                cb_createdBy.Text = sdr["createby_name"].ToString();
                //cb_createdBy.SelectedValue = sdr["createby"].ToString();
                cb_received.Text = sdr["Receiptby_name"].ToString();
                //cb_received.SelectedValue = sdr["Receiptby"].ToString();
                cb_approved.Text = sdr["approval_name"].ToString();
                //cb_approved.SelectedValue = sdr["approval"].ToString();
                lbl_lastUpdate.Text = lbl_lastUpdate.Text + string.Format("{0:dd-MM-yyyy}", sdr["lastupdate"].ToString());
                lbl_userId.Text = lbl_userId.Text + sdr["userid"].ToString();
                lbl_Owner.Text = lbl_Owner.Text + sdr["Owner"].ToString();
                lbl_edited.Text = lbl_edited.Text + sdr["Edited"].ToString();
                //chk_posting.Text = sdr["status_post"].ToString();

            }
            con.Close();

        }
        public DataTable GetDataDetailTable(string lbm_code)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_goods_receiveD";
            cmd.Parameters.AddWithValue("@lbm_code", lbm_code);
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

        protected void btnSave_Click(object sender, EventArgs e)
        {
            long maxNo;
            string run = null;
            string trDate = string.Format("{0:dd/MM/yyyy}", dtp_gr.SelectedDate);

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
                        run = "GR03" + dtp_gr.SelectedDate.Value.Year + dtp_gr.SelectedDate.Value.Month + "0001";
                    }
                    else if (sdr.Read())
                    {
                        maxNo = Convert.ToInt32(sdr[0].ToString());
                        run = "GR03" +
                            (dtp_gr.SelectedDate.Value.Year.ToString()).Substring(dtp_gr.SelectedDate.Value.Year.ToString().Length - 2) +
                            ("0000" + dtp_gr.SelectedDate.Value.Month).Substring(("0000" + dtp_gr.SelectedDate.Value.Month).Length - 2, 2) +
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
                cmd.Parameters.AddWithValue("@lbm_date", string.Format("{0:yyyy-MM-dd}", dtp_gr.SelectedDate.Value));
                cmd.Parameters.AddWithValue("@wh_code", cb_warehouse.SelectedValue);
                cmd.Parameters.AddWithValue("@sj", txt_delivery_note.Text);
                cmd.Parameters.AddWithValue("@remark", txt_remark.Text);
                cmd.Parameters.AddWithValue("@ref_code", cb_ref.Text);
                cmd.Parameters.AddWithValue("@userid", public_str.uid);
                cmd.Parameters.AddWithValue("@cust_code", cb_supplier.SelectedValue);
                cmd.Parameters.AddWithValue("@cust_name", cb_supplier.Text);
                //cmd.Parameters.AddWithValue("@ref_date", string.Format("{0:yyyy-MM-dd}", txt_reff_date.Text));
                cmd.Parameters.AddWithValue("@createby", cb_createdBy.SelectedValue);
                cmd.Parameters.AddWithValue("@Receiptby", cb_received.SelectedValue);
                cmd.Parameters.AddWithValue("@approval", cb_approved.SelectedValue);
                cmd.Parameters.AddWithValue("@dept_code", cb_costcenter.SelectedValue);
                cmd.Parameters.AddWithValue("@region_code", cb_project.SelectedValue);
                cmd.Parameters.AddWithValue("@Owner", public_str.uid);
                cmd.Parameters.AddWithValue("@Lvl", public_str.level);

                //cmd.Parameters.AddWithValue("@trans_code", cb_from.SelectedValue);
                //cmd.Parameters.AddWithValue("@status_lbm", cb_from.SelectedValue);
                //cmd.Parameters.AddWithValue("@lastupdate", DateTime.Now);
                //cmd.Parameters.AddWithValue("@status_post", DateTime.Today);
                //cmd.Parameters.AddWithValue("@OwnStamp", string.Format("{0:yyyy-MM-dd}", dtp_gr.SelectedDate));

                //cmd.Parameters.AddWithValue("@po_code", txt.SelectedValue);
                //cmd.Parameters.AddWithValue("@PlantCode", txt_remark.Text);
                //cmd.Parameters.AddWithValue("@asset_id", Convert.ToDecimal(txt_kurs2.Text));
                //cmd.Parameters.AddWithValue("@Printed", txt_printed.Text);
                //cmd.Parameters.AddWithValue("@Edited", txt_edited.Text);
                //cmd.Parameters.AddWithValue("@Otorisasi", txt_NoCtrl.Text);
                //cmd.Parameters.AddWithValue("@OtoUsr", public_str.level);
                //cmd.Parameters.AddWithValue("@OtoStamp", cb_pre.SelectedValue);
                //cmd.Parameters.AddWithValue("@doc_type", cb_approve.SelectedValue);
                //cmd.Parameters.AddWithValue("@from_region_code", txt_NoCtrl.Text);
                //cmd.Parameters.AddWithValue("@tAllocate", txt_NoCtrl.Text);
                cmd.ExecuteNonQuery();

                //Save Detail

                foreach (GridDataItem item in RadGrid2.MasterTableView.Items)
                {
                    cmd = new SqlCommand();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Connection = con;
                    cmd.CommandText = "sp_save_goods_receiveD";
                    cmd.Parameters.AddWithValue("@lbm_code", run);
                    cmd.Parameters.AddWithValue("@prod_code", (item.FindControl("lblProdCode") as Label).Text);
                    cmd.Parameters.AddWithValue("@wh_code", cb_warehouse.SelectedValue);
                    cmd.Parameters.AddWithValue("@qty_receive", Convert.ToDouble((item.FindControl("txtPartQty") as RadTextBox).Text));
                    cmd.Parameters.AddWithValue("@ref_code", DBNull.Value);
                    cmd.Parameters.AddWithValue("@koLok", DBNull.Value);
                    cmd.Parameters.AddWithValue("@UID", public_str.uid);


                    cmd.ExecuteNonQuery();
                }
            }
            catch (System.Exception ex)
            {
                con.Close();
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
            }
            finally
            {
                con.Close();
                notif.Text = "Data berhasil disimpan";
                notif.Title = "Notification";
                notif.Show();
                txt_gr_number.Text = run;

                if (Session["actionEdit"].ToString() == "edit")
                {
                    ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind();", true);
                }
                else
                {
                    ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind('navigateToInserted');", true);
                }
                inv01h04.tr_code = run;
                inv01h04.selected_project = cb_project.SelectedValue;
            }
        }


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
        protected void cb_project_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
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
        
        #region Warehouse / Storage 
        private static DataTable GetWarehouse(string text, string project)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT wh_code, wh_name FROM inv00h05 WHERE stEdit != 4 AND PlantCode = @PlantCode AND wh_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@PlantCode", project);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_warehouse_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetWarehouse(e.Text, cb_project.SelectedValue);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["wh_name"].ToString(), data.Rows[i]["wh_name"].ToString()));
            }
        }

        protected void cb_warehouse_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT wh_code FROM inv00h05 WHERE wh_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            }
            dr.Close();
            con.Close();
        }

        protected void cb_warehouse_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT wh_code FROM inv00h05 WHERE wh_name = '" + (sender as RadComboBox).Text + "'";
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

        #region Cost Center
        protected void LoadCostCtr(string name, string projectID, RadComboBox cb)
        {
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);

            SqlDataAdapter adapter = new SqlDataAdapter("SELECT upper(CostCenter) as code,upper(CostCenterName) as name FROM inv00h11 " +
                "WHERE stEdit <> '4' AND region_code = @project AND CostCenterName LIKE @text + '%'", con);
            adapter.SelectCommand.Parameters.AddWithValue("@project", projectID);
            adapter.SelectCommand.Parameters.AddWithValue("@text", name);
            DataTable dt = new DataTable();
            adapter.Fill(dt);

            cb.DataTextField = "name";
            cb.DataValueField = "code";
            cb.DataSource = dt;
            cb.DataBind();
        }
        protected void cb_cost_ctr_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadCostCtr(e.Text, cb_project.SelectedValue, (sender as RadComboBox));

        }
        protected void cb_cost_ctr_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT CostCenter FROM inv00h11 WHERE CostCenterName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["CostCenter"].ToString();
            }
            dr.Close();
            con.Close();
        }
        protected void cb_cost_ctr_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT CostCenter FROM inv00h11 WHERE CostCenterName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["CostCenter"].ToString();
            dr.Close();
            con.Close();
        }
        #endregion

        #region Approval
        protected void LoadManPower(string name, string projectID, RadComboBox cb)
        {
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);

            SqlDataAdapter adapter = new SqlDataAdapter("SELECT upper(name) as name, nik, upper(jabatan) as jabatan FROM inv00h26 " +
                "WHERE stedit <> '4' AND region_code = @project AND name LIKE @text + '%'", con);
            adapter.SelectCommand.Parameters.AddWithValue("@project", projectID);
            adapter.SelectCommand.Parameters.AddWithValue("@text", name);
            DataTable dt = new DataTable();
            adapter.Fill(dt);

            cb.DataTextField = "name";
            cb.DataValueField = "nik";
            cb.DataSource = dt;
            cb.DataBind();
        }
        protected void cb_prepare_by_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadManPower(e.Text, cb_project.SelectedValue, (sender as RadComboBox));
        }
        protected void cb_prepare_by_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["nik"].ToString();
            }
            dr.Close();
            con.Close();

        }
        protected void cb_prepare_by_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["nik"].ToString();
            }

            dr.Close();
            con.Close();
        }
        protected void cb_orderBy_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadManPower(e.Text, cb_project.SelectedValue, (sender as RadComboBox));
        }
        protected void cb_orderBy_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["nik"].ToString();
            }

            dr.Close();
            con.Close();
        }
        protected void cb_orderBy_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["nik"].ToString();
            }

            dr.Close();
            con.Close();
        }
        protected void cb_received_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["nik"].ToString();
            }

            dr.Close();
            con.Close();
        }
        protected void cb_received_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadManPower(e.Text, cb_project.SelectedValue, (sender as RadComboBox));
        }
        protected void cb_received_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["nik"].ToString();
            }

            dr.Close();
            con.Close();
        }
        protected void cb_approved_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadManPower(e.Text, cb_project.SelectedValue, (sender as RadComboBox));
        }
        protected void cb_approved_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["nik"].ToString();
            }

            dr.Close();
            con.Close();
        }
        protected void cb_approved_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["nik"].ToString();
            }

            dr.Close();
            con.Close();
        }
        #endregion

        #region GR Source
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
        #endregion

        #region Refferences

        private static DataTable GetReff(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("sp_get_goods_receive_ref",
             ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void LoadReff(string po_code, string project, string vendor, string typeRef, RadComboBox cb)
        {
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            DataTable dt = new DataTable();

            if (typeRef == "Supplier")
            {
                SqlDataAdapter adapter = new SqlDataAdapter("SELECT po_code, Po_date, remark FROM v_goods_receiveH_reff WHERE vendor_code = '" + vendor + "' " +
                    "AND PlantCode = '" + project + "' AND po_code LIKE @text + '%' ", con);
                adapter.SelectCommand.Parameters.AddWithValue("@vendor_code", vendor);
                adapter.SelectCommand.Parameters.AddWithValue("@project", project);
                adapter.SelectCommand.Parameters.AddWithValue("@text", po_code);
                //DataTable dt = new DataTable();
                adapter.Fill(dt);
            }
            //else
            //{
            //    SqlDataAdapter adapter = new SqlDataAdapter("SELECT doc_code, remark FROM v_rs_reff_general " +
            //    "WHERE region_code = @project AND doc_code LIKE @text + '%'", con);
            //    adapter.SelectCommand.Parameters.AddWithValue("@project", projectID);
            //    adapter.SelectCommand.Parameters.AddWithValue("@text", doc_code);
            //    //DataTable dt = new DataTable();
            //    adapter.Fill(dt);
            //}


            cb.DataTextField = "po_code";
            cb.DataValueField = "po_code";
            cb.DataSource = dt;
            cb.DataBind();
        }
        protected void cb_ref_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadReff(e.Text, cb_project.SelectedValue, cb_supplier.SelectedValue, cb_from.Text, (sender as RadComboBox));

        }

        protected void cb_ref_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            SqlDataReader dr;
            if (cb_from.Text == "Supplier")
            {
                cmd.CommandText = "SELECT * FROM v_goods_receiveH_reff WHERE po_code = '" + (sender as RadComboBox).SelectedValue + "'";
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    (sender as RadComboBox).Text = dr["po_code"].ToString();
                    txt_reff_date.Text = dr["Po_date"].ToString();
                    cb_costcenter.Text = dr["CostCenterName"].ToString();                    
                    txt_remark.Text = dr["remark"].ToString();
                }
                dr.Close();
            }
            //else
            //{
            //    cmd.CommandText = "SELECT * FROM v_rs_reff_general WHERE doc_code = '" + (sender as RadComboBox).SelectedValue + "'";
            //    dr = cmd.ExecuteReader();
            //    while (dr.Read())
            //    {
            //        (sender as RadComboBox).Text = dr["doc_code"].ToString();
            //        cb_cost_ctr.SelectedValue = dr["dept_code"].ToString();
            //        cb_cost_ctr.Text = dr["CostCenterName"].ToString();
            //        txt_remark.Text = dr["remark"].ToString();
            //    }
            //}


            
            con.Close();


            RadGrid2.DataSource = GetDataRefDetailTable((sender as RadComboBox).SelectedValue, cb_warehouse.SelectedValue);
            RadGrid2.DataBind();
            //}

        }

        protected void cb_ref_PreRender(object sender, EventArgs e)
        {
            //if (Session["actionEdit"].ToString() == "edit")
            //{
            //    (sender as RadComboBox).Enabled = false;
            //}
            //else
            //{
            //    con.Open();
            //    SqlCommand cmd = new SqlCommand();
            //    cmd.Connection = con;
            //    cmd.CommandType = CommandType.Text;
            //    cmd.CommandText = "SELECT doc_code FROM v_rs_reff WHERE doc_code = '" + (sender as RadComboBox).Text + "'";
            //    SqlDataReader dr;
            //    dr = cmd.ExecuteReader();
            //    while (dr.Read())
            //    {
            //        (sender as RadComboBox).SelectedValue = dr[0].ToString();
            //    }
            //    dr.Close();
            //    con.Close();
            //}

        }

        public DataTable GetDataRefDetailTable(string doc_code, string wh_code)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_goods_receive_refD";
            cmd.Parameters.AddWithValue("@po_code", doc_code);
            cmd.Parameters.AddWithValue("@wh_code", wh_code);
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
        #endregion

        protected void RadGrid2_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            if (!IsPostBack)
            {
                (sender as RadGrid).DataSource = new string[] { };
            }
            else if (Session["actionEdit"].ToString() == "new")
            {
                (sender as RadGrid).DataSource = new string[] { };
                (sender as RadGrid).DataSource = GetDataRefDetailTable(cb_ref.Text, cb_warehouse.SelectedValue);
            }
            else if (Session["actionEdit"].ToString() == "edit")
            {
                (sender as RadGrid).DataSource = new string[] { };
                (sender as RadGrid).DataSource = GetDataRefDetailTable(txt_gr_number.Text, cb_warehouse.SelectedValue);
            }
        }

        protected void RadGrid2_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadGrid).MasterTableView.Items.Count < (sender as RadGrid).MasterTableView.PageSize)
            {
                (sender as RadGrid).ClientSettings.Scrolling.AllowScroll = false;
                (sender as RadGrid).ClientSettings.Scrolling.UseStaticHeaders = false;
            }
            //else
            //{
            //    (sender as RadGrid).ClientSettings.Scrolling.AllowScroll = true;
            //    (sender as RadGrid).ClientSettings.Scrolling.UseStaticHeaders = true;
            //    (sender as RadGrid).ClientSettings.Scrolling.ScrollHeight = 200;
            //}
        }

        protected void cbKolok_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {

        }
    }
}