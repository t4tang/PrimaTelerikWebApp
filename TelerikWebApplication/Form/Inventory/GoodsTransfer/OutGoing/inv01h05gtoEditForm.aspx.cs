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

namespace TelerikWebApplication.Form.Inventory.GoodsTransfer.OutGoing
{
    public partial class inv01h05gtoEditForm : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();

        private const int ItemsPerRequest = 10;
        public static string tr_code = null;
        public static string selected_project = null;
        public static string selected_storage = null;
        public static string selected_cost_ctr = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                dtp_do.SelectedDate = DateTime.Now;
                if (Request.QueryString["do_code"] != null)
                {
                    fill_object(Request.QueryString["do_code"].ToString());
                    //RadGrid2.DataSource = GetDataDetailTable(txt_do_code.Text);
                    Session["actionEdit"] = "edit";
                }
                else
                {
                    Session["actionEdit"] = "new";
                }
            }
        }

        #region Project To

        private static DataTable GetProjectFrom(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT region_code, region_name FROM inv00h09 WHERE stEdit != 4 AND region_name LIKE @text + '%' ",
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

        protected void cb_proj_from_PreRender(object sender, EventArgs e)
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

        #region CostCenter
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

        protected void cb_CostCtr_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadCostCtr(e.Text, cb_proj_from.SelectedValue, (sender as RadComboBox));
        }

        protected void cb_CostCtr_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
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

        protected void cb_CostCtr_PreRender(object sender, EventArgs e)
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
        #endregion

        #region WareHouse / Storage

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
            DataTable data = GetWarehouse(e.Text, cb_proj_from.SelectedValue);

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

        #region Expedition

        private static DataTable GetExpedition(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT EXP_CODE, EXP_NAME FROM pur00h03 WHERE stEdit != 4 AND EXP_NAME LIKE @text + '%' ",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }

        protected void cb_expedition_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetExpedition(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["EXP_NAME"].ToString(), data.Rows[i]["EXP_NAME"].ToString()));
            }
        }

        protected void cb_expedition_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT EXP_CODE FROM pur00h03 WHERE EXP_NAME = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            }
            dr.Close();
            con.Close();
        }

        protected void cb_expedition_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT EXP_CODE FROM pur00h03 WHERE EXP_NAME = '" + (sender as RadComboBox).Text + "'";
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

        #region Ship Mode

        protected void cb_ship_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            cb_ship.Items.Add("Sea");
            cb_ship.Items.Add("Air");
            cb_ship.Items.Add("Courier");
        }

        protected void cb_ship_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if (cb_ship.Text == "Sea")
            {
                cb_ship.SelectedValue = "1";
            }
            else if (cb_ship.Text == "Air")
            {
                cb_ship.SelectedValue = "2";
            }
            else if (cb_ship.Text == "Courier")
            {
                cb_ship.SelectedValue = "3";
            }
        }

        protected void cb_ship_PreRender(object sender, EventArgs e)
        {
            if (cb_ship.Text == "Sea")
            {
                cb_ship.SelectedValue = "1";
            }
            else if (cb_ship.Text == "Air")
            {
                cb_ship.SelectedValue = "2";
            }
            else if (cb_ship.Text == "Courier")
            {
                cb_ship.SelectedValue = "3";
            }
        }
        #endregion

        #region Project To

        private static DataTable GetProjectTo(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT region_code, region_name FROM inv00h09 WHERE stEdit != 4 AND region_name LIKE @text + '%' ",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }

        protected void cb_proj_to_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetProjectTo(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["region_name"].ToString(), data.Rows[i]["region_name"].ToString()));
            }
        }

        protected void cb_proj_to_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
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

        protected void cb_proj_to_PreRender(object sender, EventArgs e)
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

        #region Warehouse / storage To

        private static DataTable GetWarehouseTo(string text, string project)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT wh_code, wh_name FROM inv00h05 WHERE stEdit != 4 AND PlantCode = @PlantCode AND wh_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@PlantCode", project);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }

        protected void cb_warehouse_to_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetWarehouseTo(e.Text, cb_proj_to.SelectedValue);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["wh_name"].ToString(), data.Rows[i]["wh_name"].ToString()));
            }
        }

        protected void cb_warehouse_to_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
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

        protected void cb_warehouse_to_PreRender(object sender, EventArgs e)
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

        #endregion Project To

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

        protected void cb_prepare_by_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            cb_prepare_by.Text = "";
            LoadManPower(e.Text, cb_proj_from.SelectedValue, cb_prepare_by);
        }

        protected void cb_prepare_by_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + cb_prepare_by.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                cb_prepare_by.SelectedValue = dr["nik"].ToString();
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
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + cb_prepare_by.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                cb_prepare_by.SelectedValue = dr["nik"].ToString();
            }
            dr.Close();
            con.Close();
        }

        protected void cb_send_by_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            cb_send_by.Text = "";
            LoadManPower(e.Text, cb_proj_from.SelectedValue, cb_send_by);
        }

        protected void cb_send_by_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + cb_send_by.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                cb_send_by.SelectedValue = dr["nik"].ToString();
            }
            dr.Close();
            con.Close();
        }

        protected void cb_send_by_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + cb_send_by.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                cb_send_by.SelectedValue = dr["nik"].ToString();
            }
            dr.Close();
            con.Close();
        }

        protected void cb_ack_by_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            cb_ack_by.Text = "";
            LoadManPower(e.Text, cb_proj_from.SelectedValue, cb_ack_by);
        }

        protected void cb_ack_by_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + cb_ack_by.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                cb_ack_by.SelectedValue = dr["nik"].ToString();
            }
            dr.Close();
            con.Close();
        }

        protected void cb_ack_by_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + cb_ack_by.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                cb_ack_by.SelectedValue = dr["nik"].ToString();
            }
            dr.Close();
            con.Close();
        }
        #endregion

        //public DataTable GetDataDetailTable(string do_code)
        //{
        //    con.Open();
        //    cmd = new SqlCommand();
        //    cmd.CommandType = CommandType.StoredProcedure;
        //    cmd.Connection = con;
        //    cmd.CommandText = "sp_get_goods_transfer_outD2";
        //    cmd.Parameters.AddWithValue("@do_code", do_code);
        //    cmd.CommandTimeout = 0;
        //    cmd.ExecuteNonQuery();
        //    sda = new SqlDataAdapter(cmd);

        //    DataTable DT = new DataTable();

        //    try
        //    {
        //        sda.Fill(DT);
        //    }
        //    finally
        //    {
        //        con.Close();
        //    }

        //    return DT;
        //}

        //protected void RadGrid2_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        //{
        //    if (!IsPostBack)
        //    {
        //        (sender as RadGrid).DataSource = new string[] { };
        //    }
        //    //else if (Session["actionEdit"].ToString() == "new")
        //    //{
        //    //    (sender as RadGrid).DataSource = new string[] { };
        //    //    (sender as RadGrid).DataSource = GetDataRefDetailTable(cb_ref.Text);
        //    //}
        //    else if (Session["actionEdit"].ToString() == "new")
        //    {
        //        (sender as RadGrid).DataSource = new string[] { };
        //        (sender as RadGrid).DataSource = GetDataDetailTable(txt_do_code.Text);
        //    }

        //    //RadGrid2.DataSource = GetDataDetailTable(txt_do_code.Text);
        //}

        //protected void RadGrid2_PreRender(object sender, EventArgs e)
        //{
        //    if ((sender as RadGrid).MasterTableView.Items.Count < (sender as RadGrid).MasterTableView.PageSize)
        //    {
        //        (sender as RadGrid).ClientSettings.Scrolling.AllowScroll = false;
        //        (sender as RadGrid).ClientSettings.Scrolling.UseStaticHeaders = false;
        //    }
        //}

        protected void fill_object(string id)
        {
            con.Open();
            SqlDataReader sdr;
            SqlCommand cmd = new SqlCommand("SELECT * FROM v_goods_transfer_outH WHERE do_code = '" + id + "'", con);
            sdr = cmd.ExecuteReader();
            if (sdr.Read())
            {
                txt_do_code.Text = sdr["do_code"].ToString();
                dtp_do.SelectedDate = Convert.ToDateTime(sdr["Tgl"].ToString());
                cb_proj_from.Text = sdr["region_name"].ToString();
                cb_CostCtr.Text = sdr["CostCenterName"].ToString();
                cb_warehouse.Text = sdr["ori_wh_name"].ToString();
                //cb_ref.Text = sdr["ref_code"].ToString();
                cb_expedition.Text = sdr["KoExp"].ToString();
                cb_ship.Text = sdr["ShipModeEtd"].ToString();
                cb_proj_to.Text = sdr["to_region_name"].ToString();
                cb_warehouse_to.Text = sdr["dest_wh_name"].ToString();
                //txt_hm.Text = String.Format("{0:#,###,###.00}", sdr["time_reading"]);
                //cb_cost_ctr.SelectedValue = sdr["dept_code"].ToString();
                //cb_cost_ctr.Text = sdr["CostCenterName"].ToString();
                cb_prepare_by.Text = sdr["FreBy"].ToString();
                cb_send_by.Text = sdr["OrdBy"].ToString();
                cb_ack_by.Text = sdr["AppBy"].ToString();
                //cb_approved.Text = sdr["NameAppBy"].ToString();
                txt_remark.Text = sdr["remark"].ToString();
                //lbl_userId.Text = lbl_userId.Text + sdr["userid"].ToString();
                //lbl_lastUpdate.Text = lbl_lastUpdate.Text + String.Format("{0:dd-MM-yyyy}", sdr["lastupdate"].ToString());
                //lbl_Owner.Text = lbl_Owner.Text + sdr["Owner"].ToString();
                //lbl_printed.Text = lbl_printed.Text + sdr["Printed"].ToString();
                //lbl_edited.Text = lbl_edited.Text + sdr["Edited"].ToString();
            }
            con.Close();
        }

        //protected void cb_prod_code_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        //{
        //    string sql = "SELECT  inv00h01.prod_code, inv00h01.spec, inv00h04.brand_name, inv00h01.unit as unit_code, inv00d01.QACT " +
        //                    "FROM inv00h01 INNER JOIN " +
        //                    "inv00d01 ON inv00h01.prod_code = inv00d01.prod_code INNER JOIN " +
        //                    "inv00h04 ON inv00h01.brand_code = inv00h04.brand_code INNER JOIN " +
        //                    "inv00h02 ON inv00h01.kind_code = inv00h02.kind_code " +
        //                    "WHERE(inv00d01.wh_code = @wh_code) AND(inv00h02.stMain = '2') AND spec LIKE @spec + '%'";
        //    SqlDataAdapter adapter = new SqlDataAdapter(sql,
        //        ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
        //    adapter.SelectCommand.Parameters.AddWithValue("@wh_code", cb_warehouse.SelectedValue);
        //    adapter.SelectCommand.Parameters.AddWithValue("@spec", e.Text);
        //    //adapter.SelectCommand.Parameters.AddWithValue("@brand_name", e.Text);
        //    //adapter.SelectCommand.Parameters.AddWithValue("@unit", e.Text);
        //    //adapter.SelectCommand.Parameters.AddWithValue("@QACT", e.Text);

        //    DataTable dt = new DataTable();
        //    adapter.Fill(dt);

        //    RadComboBox comboBox = (RadComboBox)sender;
        //    // Clear the default Item that has been re-created from ViewState at this point.
        //    comboBox.Items.Clear();

        //    foreach (DataRow row in dt.Rows)
        //    {
        //        RadComboBoxItem item = new RadComboBoxItem();
        //        item.Text = row["prod_code"].ToString();
        //        item.Value = row["prod_code"].ToString();
        //        item.Attributes.Add("spec", row["spec"].ToString());
        //        item.Attributes.Add("brand_name", row["brand_name"].ToString());
        //        item.Attributes.Add("unit_code", row["unit_code"].ToString());
        //        item.Attributes.Add("QACT", row["QACT"].ToString());
        //        //item.Text = row["brand_name"].ToString();

        //        comboBox.Items.Add(item);
                               
        //        item.DataBind();
        //    }
        //}

        //protected void cb_prod_code_PreRender(object sender, EventArgs e)
        //{
        //    con.Open();
        //    SqlCommand cmd = new SqlCommand();
        //    cmd.Connection = con;
        //    cmd.CommandType = CommandType.Text;
        //    cmd.CommandText = "SELECT prod_code FROM inv00h01 WHERE spec = '" + (sender as RadComboBox).Text + "'";
        //    SqlDataReader dr;
        //    dr = cmd.ExecuteReader();
        //    while (dr.Read())
        //        (sender as RadComboBox).SelectedValue = dr[0].ToString();
        //    dr.Close();
        //    con.Close();
        //}

        //protected void cb_prod_code_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        //{
        //    Session["prod_code"] = e.Value;

        //    try
        //    {
        //        con.Open();
        //        SqlCommand cmd = new SqlCommand();
        //        cmd.Connection = con;
        //        cmd.CommandType = CommandType.Text;
        //        cmd.CommandText = "SELECT unit AS unit_code FROM inv00h01 where prod_code = '" + (sender as RadComboBox).SelectedValue + "'";

        //        SqlDataAdapter adapter = new SqlDataAdapter(cmd);
        //        DataTable dt = new DataTable();
        //        adapter.Fill(dt);
        //        foreach (DataRow dtr in dt.Rows)
        //        {
        //            RadComboBox cb = (RadComboBox)sender;
        //            GridEditableItem item = (GridEditableItem)cb.NamingContainer;
        //            RadTextBox T_UnitCode = (RadTextBox)item.FindControl("txt_unit");

        //            T_UnitCode.Text = dtr["unit_code"].ToString();
                    
        //        }

        //    }
        //    catch (Exception ex)
        //    {
        //        Response.Write("<script language='javascript'>alert('" + ex.Message + "')</script>");
        //    }
        //    finally
        //    {
        //        con.Close();
        //    }
        //}

        protected void btn_save_Click(object sender, EventArgs e)
        {
            long maxNo;
            string run = null;
            string trDate = string.Format("{0:dd/MM/yyyy}", dtp_do.SelectedDate);

            try
            {
                if (Session["action"].ToString() == "edit")
                {
                    run = txt_do_code.Text;
                }
                else
                {
                    con.Open();
                    SqlDataReader sdr;
                    cmd = new SqlCommand("SELECT ISNULL ( MAX ( RIGHT ( inv01h05.do_code , 4 ) ) , 0 ) + 1 AS maxNo " +
                        "FROM inv01h05 WHERE LEFT(inv01h05.do_code, 4) = 'TR03' " +
                        "AND SUBSTRING(inv01h05.do_code, 5, 2) = SUBSTRING('" + trDate + "', 9, 2) " +
                        "AND SUBSTRING(inv01h05.do_code, 7, 2) = SUBSTRING('" + trDate + "', 4, 2) ", con);
                    sdr = cmd.ExecuteReader();
                    if (sdr.HasRows == false)
                    {
                        //throw new Exception();
                        run = "TR03" + dtp_do.SelectedDate.Value.Year + dtp_do.SelectedDate.Value.Month + "0001";
                    }
                    else if (sdr.Read())
                    {
                        maxNo = Convert.ToInt32(sdr[0].ToString());
                        run = "TR03" + (dtp_do.SelectedDate.Value.Year.ToString()).Substring(dtp_do.SelectedDate.Value.Year.ToString().Length - 2) +
                            ("0000" + dtp_do.SelectedDate.Value.Month).Substring(("0000" + dtp_do.SelectedDate.Value.Month).Length - 2, 2) +
                            ("0000" + maxNo).Substring(("0000" + maxNo).Length - 4, 4);
                    }
                    con.Close();
                }

                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_save_goods_transfer_outH";
                cmd.Parameters.AddWithValue("@do_code", run);
                cmd.Parameters.AddWithValue("@Tgl", string.Format("{0:yyyy-MM-dd}", dtp_do.SelectedDate.Value));
                cmd.Parameters.AddWithValue("@wh_code", cb_warehouse.SelectedValue);
                cmd.Parameters.AddWithValue("@to_wh_code", cb_warehouse_to.SelectedValue);
                cmd.Parameters.AddWithValue("@sales_code", "NON");
                cmd.Parameters.AddWithValue("@remark", txt_remark.Text);
                cmd.Parameters.AddWithValue("@ref_code", DBNull.Value);
                cmd.Parameters.AddWithValue("@cust_code", "PSG");
                cmd.Parameters.AddWithValue("@status_do", 3);
                cmd.Parameters.AddWithValue("@userid", public_str.user_id);
                cmd.Parameters.AddWithValue("@dept_code", cb_CostCtr.SelectedValue);
                cmd.Parameters.AddWithValue("@region_code", cb_proj_from.SelectedValue);
                cmd.Parameters.AddWithValue("@AppBy", cb_ack_by.SelectedValue);
                cmd.Parameters.AddWithValue("@OrdBy", cb_send_by.SelectedValue);
                cmd.Parameters.AddWithValue("@FreBy", cb_prepare_by.SelectedValue);
                cmd.Parameters.AddWithValue("@to_region_code", cb_proj_to.SelectedValue);
                cmd.Parameters.AddWithValue("@cust_name", "PRIMA SARANA GEMILANG, PT");
                cmd.Parameters.AddWithValue("@Lvl", public_str.level);
                cmd.Parameters.AddWithValue("@Owner", public_str.user_id);
                cmd.Parameters.AddWithValue("@ShipModeEtd", cb_ship.SelectedValue);
                cmd.Parameters.AddWithValue("@KoExp", cb_expedition.SelectedValue);
                cmd.ExecuteNonQuery();


                //foreach (GridDataItem item in RadGrid2.MasterTableView.Items)
                //{
                //    con.Open();
                //    cmd = new SqlCommand();
                //    cmd.CommandType = CommandType.StoredProcedure;
                //    cmd.Connection = con;
                //    cmd.CommandText = "sp_save_goods_transfer_outD";
                //    cmd.Parameters.AddWithValue("@do_code", tr_code);
                //    cmd.Parameters.AddWithValue("@prod_code", (item.FindControl("lblProdCode") as Label).Text);
                //    cmd.Parameters.AddWithValue("@qty_out", Convert.ToDouble((item.FindControl("lblQtyOut") as Label).Text));
                //    cmd.Parameters.AddWithValue("@unit_code", (item.FindControl("lblUnitCode") as Label).Text);
                //    cmd.Parameters.AddWithValue("@hpokok", 0);
                //    cmd.Parameters.AddWithValue("@type_out", 'N');
                //    cmd.Parameters.AddWithValue("@disc", 0);
                //    cmd.Parameters.AddWithValue("@price", 0);
                //    cmd.Parameters.AddWithValue("@wh_code", selected_storage);
                //    cmd.Parameters.AddWithValue("@remark", (item.FindControl("lblRemark") as Label).Text);
                //    cmd.Parameters.AddWithValue("@dept_code", selected_cost_ctr);
                //    cmd.Parameters.AddWithValue("@twarranty", 0);
                //    cmd.Parameters.AddWithValue("@Prod_code_ori", (item.FindControl("lblProdCode") as Label).Text);
                //    cmd.Parameters.AddWithValue("@tFullLink", 0);
                //    cmd.ExecuteNonQuery();
                //}
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
                txt_do_code.Text = run;

                if (Session["actionEdit"].ToString() == "edit")
                {
                    ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind();", true);
                }
                else
                {
                    ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind('navigateToInserted');", true);
                }
                inv01h05gto.tr_code = run;
                inv01h05gto.selected_project = cb_proj_from.SelectedValue;
            }


        }
    }
}