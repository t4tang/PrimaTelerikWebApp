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

namespace TelerikWebApplication.Form.Inventory.GoodsTransfer.InComing
{
    public partial class inv01h04gtiEditForm : System.Web.UI.Page
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
                    Session["actionEdit"] = "new";
                }
            }
        }
        public DataTable GetDataDetailTable(string lbm_code)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_goods_transfer_inD";
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

        protected void RadGrid2_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            if (!IsPostBack)
            {
                (sender as RadGrid).DataSource = new string[] { };
            }
            else if (Session["actionEdit"].ToString() == "new")
            {
                (sender as RadGrid).DataSource = new string[] { };
                (sender as RadGrid).DataSource = GetDataRefDetailTable(cb_ref.Text);
            }
            else if (Session["actionEdit"].ToString() == "edit")
            {
                (sender as RadGrid).DataSource = new string[] { };
                (sender as RadGrid).DataSource = GetDataRefDetailTable(txt_gr_number.Text);
            }
        }

        protected void RadGrid2_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadGrid).MasterTableView.Items.Count < (sender as RadGrid).MasterTableView.PageSize)
            {
                (sender as RadGrid).ClientSettings.Scrolling.AllowScroll = false;
                (sender as RadGrid).ClientSettings.Scrolling.UseStaticHeaders = false;
            }
        }
        protected void LoadRef(string do_code, string projectID, RadComboBox cb)
        {
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);

            SqlDataAdapter adapter = new SqlDataAdapter("select do_code, Tgl, region_name, wh_name, remark from v_goods_transfer_inH_reff " +
                "WHERE region_code = @project AND do_code LIKE @text + '%'", con);
            adapter.SelectCommand.Parameters.AddWithValue("@project", projectID);
            adapter.SelectCommand.Parameters.AddWithValue("@text", do_code);
            DataTable dt = new DataTable();
            adapter.Fill(dt);

            cb.DataTextField = "do_code";
            cb.DataValueField = "do_code";
            cb.DataSource = dt;
            cb.DataBind();
        }

        protected void cb_ref_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadRef(e.Text, cb_project.SelectedValue, (sender as RadComboBox));
        }

        protected void cb_ref_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT * FROM v_goods_transfer_inH_reff WHERE do_code = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            }
            dr.Close();
            con.Close();
        }

        protected void cb_ref_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            //fillReffH((sender as RadComboBox).SelectedValue);
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT * FROM v_goods_transfer_inH_reff WHERE do_code = '" + (sender as RadComboBox).SelectedValue + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).Text = dr["do_code"].ToString();
                cb_proj_from.Text = dr["region_name"].ToString();
                txt_reff_date.Text = dr["Tgl"].ToString();
            }

            //dr.Close();
            con.Close();

            RadGrid2.DataSource = GetDataRefDetailTable((sender as RadComboBox).SelectedValue);
            RadGrid2.DataBind();
        }
        protected void fill_object(string id)
        {
            con.Open();
            SqlDataReader sdr;
            SqlCommand cmd = new SqlCommand("SELECT * FROM v_goods_transfer_inH WHERE lbm_code = '" + id + "'", con);
            sdr = cmd.ExecuteReader();
            if (sdr.Read())
            {
                txt_gr_number.Text = sdr["lbm_code"].ToString();
                dtp_gr.SelectedDate = Convert.ToDateTime(sdr["lbm_date"].ToString());
                txt_reff_date.Text = String.Format("{0:dd-MM-yyyy}", sdr["DateRef"]);
                cb_proj_from.Text = sdr["from_region_name"].ToString();
                cb_ref.Text = sdr["ref_code"].ToString();
                cb_project.Text = sdr["region_name"].ToString();
                cb_project.SelectedValue = sdr["region_code"].ToString();
                cb_warehouse.Text = sdr["wh_name"].ToString();
                cb_costcenter.SelectedValue = sdr["dept_code"].ToString();
                cb_costcenter.Text = sdr["CostCenterName"].ToString();
                cb_createdBy.Text = sdr["CreateByName"].ToString();
                cb_received.Text = sdr["ReceiptByName"].ToString();
                cb_approved.Text = sdr["AppByName"].ToString();
                txt_remark.Text = sdr["remark"].ToString();
                lbl_userId.Text = lbl_userId.Text + sdr["userid"].ToString();
                lbl_lastUpdate.Text = lbl_lastUpdate.Text + String.Format("{0:dd-MM-yyyy}", sdr["lastupdate"].ToString());
                lbl_Owner.Text = lbl_Owner.Text + sdr["Owner"].ToString();
                ////lbl_printed.Text = lbl_printed.Text + sdr["Printed"].ToString();
                lbl_edited.Text = lbl_edited.Text + sdr["Edited"].ToString();
            }
            con.Close();
        }

        private static string GetStatusMessage(int offset, int total)
        {
            if (total <= 0)
                return "No matches";

            return String.Format("Items <b>1</b>-<b>{0}</b> out of <b>{1}</b>", offset, total);
        }
        public DataTable GetDataRefDetailTable(string do_code)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT * FROM v_goods_transfer_inD_reff WHERE do_code = '" + do_code + "'";
            cmd.Parameters.AddWithValue("@do_code", do_code);
            //cmd.Parameters.AddWithValue("@type_reff", cb_type_ref.SelectedValue);
            //cmd.Parameters.AddWithValue("@wh_code", cb_warehouse.SelectedValue);
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
        private void label_teks_default()
        {
            lbl_userId.Text = "User: ";
            lbl_lastUpdate.Text = "Last Update: ";
            lbl_Owner.Text = "Owner:";
            //lbl_printed.Text = "Printed: ";
            lbl_edited.Text = "Edited: ";

        }

        private void text_clear(ControlCollection ctrls)
        {
            foreach (Control ctrl in ctrls)
            {
                if (ctrl is RadTextBox)
                {
                    ((RadTextBox)ctrl).Text = "";
                }

                if (ctrl is RadComboBox)
                {
                    ((RadComboBox)ctrl).Text = "";
                }

                text_clear(ctrl.Controls);
                label_teks_default();
            }
        }

        protected void cb_project_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
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

        #region Project
        private static DataTable GetProject(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT region_code, region_name FROM ms_jobsite WHERE stEdit != 4 AND region_name LIKE @text + '%' ",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        #endregion
        protected void cb_project_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT region_code FROM ms_jobsite WHERE region_name = '" + (sender as RadComboBox).Text + "'";
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
            cmd.CommandText = "SELECT region_code FROM ms_jobsite WHERE region_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            }
            dr.Close();
            con.Close();
        }

        #region Warehouse / Storage
        private static DataTable GetWarehouse(string text, string project)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT wh_code, wh_name FROM ms_warehouse WHERE stEdit != 4 AND PlantCode = @PlantCode AND wh_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@PlantCode", project);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }

        #endregion
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
            cmd.CommandText = "SELECT wh_code FROM ms_warehouse WHERE wh_name = '" + (sender as RadComboBox).Text + "'";
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
            cmd.CommandText = "SELECT wh_code FROM ms_warehouse WHERE wh_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            }
            dr.Close();
            con.Close();
        }



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
        #endregion
        protected void cb_costcenter_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadCostCtr(e.Text, cb_project.SelectedValue, (sender as RadComboBox));
        }

        protected void cb_costcenter_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
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
                (sender as RadComboBox).SelectedValue = dr["CostCenter"].ToString();
            dr.Close();
            con.Close();
        }

        #region Approval
        protected void LoadManPower(string name, string projectID, RadComboBox cb)
        {
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);

            SqlDataAdapter adapter = new SqlDataAdapter("SELECT upper(name) as name, nik, upper(jabatan) as jabatan FROM ms_manpower " +
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
        #endregion
        protected void cb_createdBy_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadManPower(e.Text, cb_project.SelectedValue, (sender as RadComboBox));
        }

        protected void cb_createdBy_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM ms_manpower WHERE name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["nik"].ToString();
            }
            dr.Close();
            con.Close();
        }

        protected void cb_createdBy_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM ms_manpower WHERE name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["nik"].ToString();
            }

            dr.Close();
            con.Close();
        }

        protected void cb_received_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadManPower(e.Text, cb_project.SelectedValue, (sender as RadComboBox));
        }

        protected void cb_received_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM ms_manpower WHERE name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["nik"].ToString();
            }

            dr.Close();
            con.Close();
        }

        protected void cb_received_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM ms_manpower WHERE name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["nik"].ToString();
            }

            dr.Close();
            con.Close();
        }

        protected void cb_approved_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadManPower(e.Text, cb_project.SelectedValue, (sender as RadComboBox));
        }

        protected void cb_approved_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM ms_manpower WHERE name = '" + (sender as RadComboBox).Text + "'";
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
            cmd.CommandText = "SELECT nik FROM ms_manpower WHERE name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["nik"].ToString();
            }

            dr.Close();
            con.Close();
        }

        protected void btn_save_Click(object sender, EventArgs e)
        {
            long maxNo;
            string run = null;
            string trDate = string.Format("{0:dd/MM/yyyy}", dtp_gr.SelectedDate);

            try
            {
                string x = dtp_gr.SelectedDate.Value.ToString("MM");
                string y = public_str.perend.Substring(3, 2);

                if (chk_posting.Checked == true)
                {
                    RadWindowManager2.RadAlert("This transaction has been posted", 500, 200, "Error", null, "~/Images/error.png");
                    return;
                }
                else if (x != y)
                {
                    RadWindowManager2.RadAlert("Transaction date outside the transaction period", 500, 200, "Error", null, "~/Images/error.png");
                    return;
                }

                if (txt_gr_number.Text != string.Empty)
                {
                    run = txt_gr_number.Text;
                }
                else
                {
                    con.Open();
                    SqlDataReader sdr;
                    cmd = new SqlCommand("SELECT ISNULL ( MAX ( RIGHT ( inv01h04.lbm_code , 4 ) ) , 0 ) + 1 AS maxNo " +
                        "FROM inv01h04 WHERE LEFT(inv01h04.lbm_code, 4) = 'MT01' " +
                        "AND SUBSTRING(inv01h04.lbm_code, 5, 2) = SUBSTRING('" + trDate + "', 9, 2) " +
                        "AND SUBSTRING(inv01h04.lbm_code, 7, 2) = SUBSTRING('" + trDate + "', 4, 2) ", con);
                    sdr = cmd.ExecuteReader();
                    if (sdr.HasRows == false)
                    {
                        //throw new Exception();
                        run = "MT01" + dtp_gr.SelectedDate.Value.Year + dtp_gr.SelectedDate.Value.Month + "0001";
                    }
                    else if (sdr.Read())
                    {
                        maxNo = Convert.ToInt32(sdr[0].ToString());
                        run = "MT01" + (dtp_gr.SelectedDate.Value.Year.ToString()).Substring(dtp_gr.SelectedDate.Value.Year.ToString().Length - 2) +
                            ("0000" + dtp_gr.SelectedDate.Value.Month).Substring(("0000" + dtp_gr.SelectedDate.Value.Month).Length - 2, 2) +
                            ("0000" + maxNo).Substring(("0000" + maxNo).Length - 4, 4);
                    }
                    con.Close();
                }


                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_save_goods_transfer_inH";
                cmd.Parameters.AddWithValue("@lbm_code", run);
                cmd.Parameters.AddWithValue("@lbm_date", string.Format("{0:yyyy-MM-dd}", dtp_gr.SelectedDate.Value));
                cmd.Parameters.AddWithValue("@ref_date", Convert.ToDateTime(txt_reff_date.Text));
                cmd.Parameters.AddWithValue("@ref_code", cb_ref.Text);
                cmd.Parameters.AddWithValue("@status_lbm", 0);
                cmd.Parameters.AddWithValue("@wh_code", cb_warehouse.SelectedValue);
                cmd.Parameters.AddWithValue("@remark", txt_remark.Text);
                cmd.Parameters.AddWithValue("@createby", cb_createdBy.SelectedValue);
                cmd.Parameters.AddWithValue("@Receiptby", cb_received.SelectedValue);
                cmd.Parameters.AddWithValue("@AppBy", cb_approved.SelectedValue);
                cmd.Parameters.AddWithValue("@region_code", cb_project.SelectedValue);
                cmd.Parameters.AddWithValue("@userid", public_str.user_id);
                cmd.Parameters.AddWithValue("@Owner", public_str.user_id);
                cmd.Parameters.AddWithValue("@dept_code", cb_costcenter.SelectedValue);
                cmd.Parameters.AddWithValue("@cust_code", "PSG");
                cmd.Parameters.AddWithValue("@cust_name", "PRIMA SARANA GEMILANG, PT");
                cmd.Parameters.AddWithValue("@from_region_code", cb_proj_from.SelectedValue);
                cmd.Parameters.AddWithValue("@trans_code", 2);
                cmd.Parameters.AddWithValue("@ShipModeEtd", 2);
                cmd.Parameters.AddWithValue("@status_post", 0);
                //cmd.Parameters.AddWithValue("@Lvl", public_str.level);
                cmd.Parameters.AddWithValue("@doc_type", 1);
                cmd.Parameters.AddWithValue("@asset_id", "NON");
                cmd.ExecuteNonQuery();


                //Save Detail

                foreach (GridDataItem item in RadGrid2.MasterTableView.Items)
                {
                    cmd = new SqlCommand();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Connection = con;
                    cmd.CommandText = "sp_save_goods_transfer_inD";
                    cmd.Parameters.AddWithValue("@prod_code", (item.FindControl("lblProdCode") as Label).Text);
                    cmd.Parameters.AddWithValue("@from_wh_code", (item.FindControl("lblFromStorLocCode") as Label).Text);
                    cmd.Parameters.AddWithValue("@qty_receive", Convert.ToDecimal((item.FindControl("txtPartQty") as RadTextBox).Text));
                    cmd.Parameters.AddWithValue("@SatQty", (item.FindControl("lblUom") as Label).Text);
                    cmd.Parameters.AddWithValue("@hpokok", 0.00);
                    cmd.Parameters.AddWithValue("@hpokok_idr", 0.00);
                    cmd.Parameters.AddWithValue("@lbm_code", run);
                    //cmd.Parameters.AddWithValue("@hpokok", DBNull.Value);
                    cmd.Parameters.AddWithValue("@hpTot", 0.00);
                    cmd.Parameters.AddWithValue("@prod_type", "M1");
                    cmd.Parameters.AddWithValue("@twarranty", 0);
                    cmd.Parameters.AddWithValue("@remark", (item.FindControl("txtRemark_d") as RadTextBox).Text);
                    //cmd.Parameters.AddWithValue("@nomor", run);
                    cmd.Parameters.AddWithValue("@qty_hpp", 0);
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
                inv01h04gti.tr_code = run;
                inv01h04gti.selected_project = cb_project.SelectedValue;
            }
        }


        private static DataTable GetProjectFrom(string text) 
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT region_code, region_name FROM ms_jobsite WHERE stEdit != 4 AND region_name LIKE @text + '%' ",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }

        protected void cb_proj_from_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetProjectFrom(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["region_name"].ToString(), data.Rows[i]["region_name"].ToString()));
            }
        }

        protected void cb_proj_from_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT region_code FROM ms_jobsite WHERE region_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            }
            dr.Close();
            con.Close();
        }

        protected void cb_proj_from_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT region_code FROM ms_jobsite WHERE region_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            }
            dr.Close();
            con.Close();
        }
    }
}