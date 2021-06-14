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
//using System.Windows.Forms;

namespace TelerikWebApplication.Form.Fico.Asset
{
    public partial class acc00h22 : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();

        private const int ItemsPerRequest = 10;
        RadTextBox txt_doc_code;
        RadComboBox cb_depre_by_prm;
        RadComboBox cb_years_depre_prm;
        RadComboBox cb_ur_number;
        RadComboBox cb_uom;
        RadComboBox cb_asset_class;
        RadComboBox cb_asset_type;
        RadComboBox cb_asset_status;
        RadComboBox cb_taxx_group;
        RadComboBox cb_project;
        RadComboBox cb_cost_center;
        RadComboBox cb_unit;
        RadComboBox cb_pic;
        RadComboBox cb_currency;
        RadTextBox txt_doc_number;
        RadTextBox txt_serial_number;
        RadTextBox txt_asset_name;
        RadTextBox txt_material_code;
        RadNumericTextBox txt_qty;
        RadTextBox txt_spec;
        RadTextBox txt_use_life_year;
        RadTextBox txt_dep_method;
        RadTextBox txt_appreciation;
        RadComboBox cb_status_reg;
        RadTextBox txt_acc_depre_no;
        RadTextBox txt_acc_depre_desc;
        RadTextBox txt_cost_depre_no;
        RadTextBox txt_cost_depre_desc;
        RadTextBox txt_acc_lost_no;
        RadTextBox txt_acc_lost_desc;
        RadTextBox txt_acc_gain_no;
        RadTextBox txt_acc_gain_desc;
        RadTextBox txt_acc_disposal_no;
        RadTextBox txt_acc_disposal_desc;
        RadTextBox txt_cost_accu_no;
        RadTextBox txt_cost_accu_desc;
        RadTextBox txt_tax_kurs;
        RadNumericTextBox txt_pur_cost;
        RadNumericTextBox txt_pur_cost_valas;
        RadTextBox txt_order_no;
        RadDatePicker dtp_order_date;
        RadNumericTextBox txt_uselife_hour;
        RadNumericTextBox txt_pre_depre_month;
        RadNumericTextBox txt_pre_depre_val;
        RadNumericTextBox txt_acq_val;
        RadNumericTextBox txt_salvage_val;
        RadDatePicker dtp_depre_start;
        RadDatePicker dtp_depre_last_post;
        //RadDatePicker dtp_sold_date;
        //RadNumericTextBox txt_actual_resale_val;
        RadNumericTextBox txt_hm_min;
        RadTabStrip RadTabStrip1;
        RadGrid RadGrid2;
        Button btnCancel;

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                lbl_form_name.Text = "Asset Register";
                cb_status_prm.Text = "Registered";
                cb_status_prm.SelectedValue = "B";
                //cb_depre_by_prm.Text = "Monthly";
                //cb_years_depre_prm.Text = (DateTime.Today.Year).ToString();

                Session["action"] = "firstLoad";
                Session["actionHeader"] = null;
            }
        }

        protected void cb_status_prm_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Add("Registered");
            (sender as RadComboBox).Items.Add("Unregister");
            (sender as RadComboBox).Items.Add("Scrap");
            (sender as RadComboBox).Items.Add("Sold");
            (sender as RadComboBox).Items.Add("Lost");
        }

        protected void cb_status_prm_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if ((sender as RadComboBox).Text == "Registered")
            {
                (sender as RadComboBox).SelectedValue = "B";
            }
            else if ((sender as RadComboBox).Text == "Unregister")
            {
                (sender as RadComboBox).SelectedValue = "N";
            }
            else if ((sender as RadComboBox).Text == "Scrap")
            {
                (sender as RadComboBox).SelectedValue = "S";
            }
            else if ((sender as RadComboBox).Text == "Sold")
            {
                (sender as RadComboBox).SelectedValue = "L";
            }
            else if ((sender as RadComboBox).Text == "Lost")
            {
                (sender as RadComboBox).SelectedValue = "H";
            }
        }

        protected void cb_project_prm_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT region_code FROM inv00h09 WHERE region_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }
        protected void cb_project_prm_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT region_code FROM inv00h09 WHERE region_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_project_prm_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetProjectPrm(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["region_name"].ToString(), data.Rows[i]["region_name"].ToString()));
            }
        }
        private static DataTable GetProjectPrm(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT region_code, region_name FROM inv00h09 WHERE stEdit != 4 AND region_name LIKE @text + '%' UNION SELECT 'ALL','ALL'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);
            
            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            RadGrid1.DataSource = GetDataTable(cb_project_prm.SelectedValue, cb_status_prm.Text);
            RadGrid1.DataBind();
        }
        public DataTable GetDataTable(string project, string sts)
        {            
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            if(sts == "Registered")
            {
                if (cb_project_prm.Text != "ALL")
                {
                    cmd.CommandText = "SELECT * FROM v_asset_list WHERE region_code = @project AND Status = @reg_status";
                }
                else
                {
                    cmd.CommandText = "SELECT * FROM v_asset_list WHERE Status = @reg_status";
                }
            }
            else
            {
                if (cb_project_prm.Text != "ALL")
                {
                    cmd.CommandText = "SELECT * FROM v_asset_list_unregister WHERE region_code = @project AND Status = @reg_status";
                }
                else
                {
                    cmd.CommandText = "SELECT * FROM v_asset_list_unregister WHERE Status = @reg_status";
                }
            }
            cmd.Parameters.AddWithValue("@project", project);
            cmd.Parameters.AddWithValue("@reg_status", sts);
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

        protected void RadGrid1_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            if (!IsPostBack)
            {
                (sender as RadGrid).DataSource = GetDataTable("", "");
            }
            else
            {
                (sender as RadGrid).DataSource = GetDataTable(cb_project_prm.SelectedValue, cb_status_prm.Text);
            }
        }
        protected void RadGrid1_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            var asset_code = ((GridDataItem)e.Item).GetDataKeyValue("asset_id");

            try
            {
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "UPDATE acc00h22 SET userid = @Usr, lastupdate = GETDATE(), stedit = '4' WHERE (asset_id = @asset_id)";
                cmd.Parameters.AddWithValue("@asset_id", asset_code);
                cmd.ExecuteNonQuery();

                con.Close();

                //Label lblOk = new Label();
                //lblOk.Text = "Data deleted successfully";
                //lblOk.ForeColor = System.Drawing.Color.Teal;
                //RadGrid1.Controls.Add(lblOk);
            }
            catch (Exception ex)
            {
                con.Close();
                //Label lblError = new Label();
                //lblError.Text = "Unable to delete data. Reason: " + ex.Message;
                //lblError.ForeColor = System.Drawing.Color.Red;
                //RadGrid1.Controls.Add(lblError);
                e.Canceled = true;
            }
        }

        protected void cb_ur_number_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {            
            (sender as RadComboBox).Text = "";
            LoadUR(e.Text, (sender as RadComboBox));
        }

        #region UR
        protected void LoadUR(string text, RadComboBox cb)
        {
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT inv01d01.doc_code, inv01h01.region_code, inv01d01.part_code,inv01d01.part_qty,inv01d01.part_unit, inv01d01.prod_type, " +
            "inv01d01.part_desc, inv01d01.nomer, inv01d01.remark, inv01d01.dept_code, '' as fig_image, '' as item, " +
            "(inv01d01.part_qty - (SELECT  ISNULL(SUM(acc00h22.Qty), 0) FROM acc00h22  WHERE(acc00h22.ur_no = inv01h01.doc_code) AND " +
            "(acc00h22.stedit <> '4') AND (acc00h22.prod_code = inv01d01.part_code))) AS 'qty_Sisa' FROM inv01d01, inv01h01 WHERE inv01h01.doc_code = inv01d01.doc_code AND " +
            "inv01h01.stEdit <> '4' AND inv01h01.tAsset = '1' AND inv01h01.trans_status = '01' AND (inv01d01.part_qty - (SELECT  ISNULL(SUM(acc00h22.Qty), 0) FROM acc00h22 " +
            "WHERE (inv01h01.tAsset = '1') AND (acc00h22.ur_no = inv01h01.doc_code) AND (acc00h22.stedit <> '4') AND (acc00h22.prod_code = inv01d01.part_code) " +
            "AND inv01d01.doc_code LIKE @text + '%')) > 0 ", con);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);
            DataTable dt = new DataTable();
            adapter.Fill(dt);

            cb.DataTextField = "doc_code";
            cb.DataValueField = "nomer";
            cb.DataSource = dt;
            cb.DataBind();
            
        }

        protected void cb_ur_number_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            RadComboBox cb = (RadComboBox)sender;
            GridEditableItem item = (GridEditableItem)cb.NamingContainer;

            RadTextBox txt_asset_name = item.FindControl("txt_asset_name") as RadTextBox;
            RadTextBox txt_material_code = item.FindControl("txt_material_code") as RadTextBox;
            RadNumericTextBox txt_qty = item.FindControl("txt_qty") as RadNumericTextBox;
            RadComboBox cb_uom = item.FindControl("cb_uom") as RadComboBox;
            RadTextBox txt_spec = item.FindControl("txt_spec") as RadTextBox;
            RadComboBox cb_project = item.FindControl("cb_project") as RadComboBox;
            RadComboBox cb_cost_center = item.FindControl("cb_cost_center") as RadComboBox;
            RadComboBox cb_status_reg = item.FindControl("cb_status_reg") as RadComboBox;

            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT d.part_code, d.part_desc, d.part_qty, d.part_unit, reg.region_name, cc.CostCenterName, 'Unregister' AS [status] " +
                              "FROM inv01d01 d, inv01h01 h, inv00h09 reg, inv00h11 cc " +
                              "WHERE d.doc_code = h.doc_code AND reg.region_code = h.region_code AND cc.CostCenter = h.dept_code AND d.doc_code = @text AND d.nomer = @nomer";
            cmd.Parameters.AddWithValue("@text", (sender as RadComboBox).Text);
            cmd.Parameters.AddWithValue("@nomer", (sender as RadComboBox).SelectedValue);
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                txt_asset_name.Text = dr["part_desc"].ToString();
                txt_material_code.Text = dr["part_code"].ToString();
                //txt_qty.Text = dr["part_qty"].ToString();
                txt_qty.Text = "1";
                cb_uom.Text = dr["part_unit"].ToString();
                txt_spec.Text= dr["part_desc"].ToString();
                cb_project.Text = dr["region_name"].ToString();
                cb_cost_center.Text = dr["CostCenterName"].ToString();
                cb_status_reg.Text = dr["status"].ToString();
            }
            
            dr.Close();            
            con.Close();
        }
        #endregion

        #region UOM
        private static DataTable GetUoM(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT unit_code, unit_name FROM inv00h08 WHERE stEdit != 4 AND unit_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_uom_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetUoM(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["unit_code"].ToString(), data.Rows[i]["unit_code"].ToString()));
            }
        }

        protected void cb_uom_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT unit_code FROM inv00h08 WHERE unit_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            }
                
            dr.Close();
            con.Close();
        }

        protected void cb_uom_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT unit_code FROM inv00h08 WHERE unit_name = '" + (sender as RadComboBox).Text + "'";
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

        #region Asset Class
        protected void LoadAssetClass(string text, RadComboBox cb)
        {
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT AK_CODE, upper(AK_NAME) as AK_NAME, exp_life_year, " +
            "(CASE mtd WHEN 'S' THEN 'STRAIGHT LINE'  WHEN 'D' THEN 'DOUBLE DECLINE' WHEN 'T' THEN 'DECLINING BALANCE' WHEN 'N' THEN 'NONE' " +
            "WHEN 'H' THEN 'HM' WHEN 'K' THEN 'KM' END) AS Method FROM acc00h23 WHERE stedit <> '4' AND AK_NAME LIKE @text + '%'", con);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);
            DataTable dt = new DataTable();
            adapter.Fill(dt);

            cb.DataTextField = "AK_NAME";
            cb.DataValueField = "AK_NAME";
            cb.DataSource = dt;
            cb.DataBind();

        }
        protected void cb_asset_class_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadAssetClass(e.Text, (sender as RadComboBox));
        }

        protected void cb_asset_class_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            try
            {
                RadComboBox cb = (RadComboBox)sender;
                GridEditableItem item = (GridEditableItem)cb.NamingContainer;

                txt_use_life_year = item.FindControl("txt_use_life_year") as RadTextBox;
                txt_dep_method = item.FindControl("txt_dep_method") as RadTextBox;
                txt_appreciation = item.FindControl("txt_appreciation") as RadTextBox;
                cb_status_reg = item.FindControl("cb_status_reg") as RadComboBox;
                txt_acc_depre_no = item.FindControl("txt_acc_depre_no") as RadTextBox;
                txt_acc_depre_desc = item.FindControl("txt_acc_depre_desc") as RadTextBox;
                txt_cost_depre_no = item.FindControl("txt_cost_depre_no") as RadTextBox;
                txt_cost_depre_desc = item.FindControl("txt_cost_depre_desc") as RadTextBox;
                txt_acc_lost_no = item.FindControl("txt_acc_lost_no") as RadTextBox;
                txt_acc_lost_desc = item.FindControl("txt_acc_lost_desc") as RadTextBox;
                txt_acc_gain_no = item.FindControl("txt_acc_gain_no") as RadTextBox;
                txt_acc_gain_desc = item.FindControl("txt_acc_gain_desc") as RadTextBox;
                txt_acc_disposal_no = item.FindControl("txt_acc_disposal_no") as RadTextBox;
                txt_acc_disposal_desc = item.FindControl("txt_acc_disposal_desc") as RadTextBox;
                txt_cost_accu_no = item.FindControl("txt_cost_accu_no") as RadTextBox;
                txt_cost_accu_desc = item.FindControl("txt_cost_accu_desc") as RadTextBox;

                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "SELECT *, (CASE mtd WHEN 'S' THEN 'STRAIGHT LINE'  WHEN 'D' THEN 'DOUBLE DECLINE' WHEN 'T' THEN 'DECLINING BALANCE' " +
                    "WHEN 'N' THEN 'NONE' WHEN 'H' THEN 'HM' WHEN 'K' THEN 'KM' END) AS Method " +
                    "FROM acc00h23 WHERE stEdit != 4 AND AK_NAME = '" +  (sender as RadComboBox).Text.Trim() + "'";
                SqlDataReader dr;
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    (sender as RadComboBox).SelectedValue = dr["AK_CODE"].ToString();
                    txt_use_life_year.Text = dr["exp_life_year"].ToString();
                    txt_dep_method.Text = dr["Method"].ToString();
                    txt_appreciation.Text = dr["mtd_per"].ToString();
                    cb_status_reg.Text = "Registered";
                    txt_acc_depre_no.Text = dr["ak_rek"].ToString();
                    txt_acc_depre_desc.Text = dr["ak_rek_name"].ToString();
                    txt_cost_depre_no.Text = dr["ak_cum_rek"].ToString();
                    txt_cost_depre_desc.Text = dr["ak_cum_rek_name"].ToString();
                    txt_acc_lost_no.Text = dr["ak_ex_rek"].ToString();
                    txt_acc_lost_desc.Text = dr["ak_ex_rek_name"].ToString();
                    txt_acc_gain_no.Text = dr["ak_gain"].ToString();
                    txt_acc_gain_desc.Text = dr["ak_gain_name"].ToString();
                    txt_acc_disposal_no.Text = dr["ak_disposal"].ToString();
                    txt_acc_disposal_desc.Text = dr["ak_disposal_name"].ToString();
                    txt_cost_accu_no.Text = dr["asset_rek"].ToString();
                    txt_cost_accu_desc.Text = dr["asset_rek_name"].ToString();
                }
                    
                dr.Close();
                con.Close();

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

        protected void cb_asset_class_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT AK_CODE FROM acc00h23 WHERE AK_NAME = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }
        #endregion

        #region Asset Type
        private static DataTable GetAssetType(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT upper(acc00h24.AK_GROUP_NAME) as AK_GROUP_NAME, acc00h24.AK_GROUP FROM acc00h24 WHERE acc00h24.stEdit <> '4' AND AK_GROUP_NAME LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_asset_type_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetAssetType(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["AK_GROUP_NAME"].ToString(), data.Rows[i]["AK_GROUP_NAME"].ToString()));
            }
        }

        protected void cb_asset_type_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT AK_GROUP FROM acc00h24 WHERE AK_GROUP_NAME = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_asset_type_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT AK_GROUP FROM acc00h24 WHERE AK_GROUP_NAME = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }
        #endregion

        #region Asset Status
        private static DataTable GetAssetSts(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT acc00h26.status_code , upper(acc00h26.Status_name) as Status_name FROM acc00h26 WHERE acc00h26.stEdit <> '4' AND acc00h26.Status_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_asset_status_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetAssetSts(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["Status_name"].ToString(), data.Rows[i]["Status_name"].ToString()));
            }
        }

        protected void cb_asset_status_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT status_code FROM acc00h26 WHERE Status_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_asset_status_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT status_code FROM acc00h26 WHERE Status_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }
        #endregion

        #region Asset Tax Group
        private static DataTable GetAssetTaxGrp(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT  acc00h25.TaxGroup, acc00h25.TaxGroupName FROM acc00h25 WHERE (acc00h25.stEdit <> '4') AND acc00h25.TaxGroupName LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }

        protected void cb_taxx_group_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetAssetTaxGrp(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["TaxGroupName"].ToString(), data.Rows[i]["TaxGroupName"].ToString()));
            }
        }

        protected void cb_taxx_group_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT TaxGroup FROM acc00h25 WHERE TaxGroupName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_taxx_group_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT TaxGroup FROM acc00h25 WHERE TaxGroupName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }
        #endregion

        #region Project
        protected void LoadProject(string text, RadComboBox cb)
        {
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT region_code, upper(region_name) as region_name FROM inv00h09 WHERE stEdit != 4 AND region_name LIKE @text + '%'", con);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);
            DataTable dt = new DataTable();
            adapter.Fill(dt);

            cb.DataTextField = "region_name";
            cb.DataValueField = "region_name";
            cb.DataSource = dt;
            cb.DataBind();
        }
        protected void cb_project_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadProject(e.Text, (sender as RadComboBox));
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
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
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
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }
        #endregion

        #region Cost Center
        protected void LoadCostCtr(string text, RadComboBox cb)
        {
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT CostCenter, upper(CostCenterName) as CostCenterName FROM inv00h11 WHERE stEdit != 4 AND CostCenterName LIKE @text + '%'", con);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);
            DataTable dt = new DataTable();
            adapter.Fill(dt);

            cb.DataTextField = "CostCenterName";
            cb.DataValueField = "CostCenterName";
            cb.DataSource = dt;
            cb.DataBind();
        }
        protected void cb_cost_center_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadCostCtr(e.Text, (sender as RadComboBox));
        }

        protected void cb_cost_center_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
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

        protected void cb_cost_center_PreRender(object sender, EventArgs e)
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
        #endregion

        #region Unit
        protected void LoadUnit(string text, string project, RadComboBox cb)
        {
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT unit_code, upper(unit_name) as unit_name, model_no, region_code FROM mtc00h16 WHERE stEdit != 4 " +
                "AND unit_name LIKE @text + '%' AND region_code = @region_code", con);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);
            adapter.SelectCommand.Parameters.AddWithValue("@region_code", project);
            DataTable dt = new DataTable();
            adapter.Fill(dt);

            cb.DataTextField = "unit_code";
            cb.DataValueField = "unit_code";
            cb.DataSource = dt;
            cb.DataBind();
        }
        protected void cb_unit_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            RadComboBox cb = (RadComboBox)sender;
            GridEditableItem item = (GridEditableItem)cb.NamingContainer;
            RadComboBox cb_project = item.FindControl("cb_project") as RadComboBox;

            (sender as RadComboBox).Text = "";
            LoadUnit(e.Text, cb_project.SelectedValue, (sender as RadComboBox));
        }
        #endregion

        #region Asset PIC
        private static DataTable GetAssetPIC(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT Pic_Code, upper(pic_name) as pic_name FROM acc00h27 WHERE stEdit <> '4' AND pic_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_pic_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetAssetPIC(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["pic_name"].ToString(), data.Rows[i]["pic_name"].ToString()));
            }
        }

        protected void cb_pic_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT Pic_Code FROM acc00h27 WHERE pic_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_pic_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT Pic_Code FROM acc00h27 WHERE pic_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }
        #endregion

        protected void btnOk_Click(object sender, EventArgs e)
        {
            RadGrid1.DataSource = GetDataTable(cb_project_prm.SelectedValue, cb_status_prm.SelectedValue);
            RadGrid1.DataBind();

            //foreach (GridDataItem item in RadGrid1.SelectedItems)
            //{
            //    con.Open();
            //    SqlDataReader sdr;
            //    SqlCommand cmd = new SqlCommand("SELECT * FROM v_asset_list WHERE asset_id = '" + item["asset_id"].Text + "'", con);
            //    sdr = cmd.ExecuteReader();
            //    if (sdr.Read())
            //    {
            //        txt_doc_number.Text = sdr["asset_id"].ToString();
            //        cb_ur_number.Text = sdr["ur_no"].ToString();
            //        txt_asset_name.Text = sdr["AssetName"].ToString();
            //        txt_material_code.Text = sdr["prod_code"].ToString();
            //        txt_qty.Value = Convert.ToDouble(sdr["Qty"].ToString());
            //        cb_uom.Text = sdr["SatQty"].ToString();
            //        txt_spec.Text = sdr["AssetSpec"].ToString();
            //        cb_asset_class.Text = sdr["AK_NAME"].ToString();
            //        cb_asset_type.Text = sdr["AK_GROUP_NAME"].ToString();
            //        cb_asset_status.Text = sdr["status_name"].ToString();
            //        cb_taxx_group.Text = sdr["taxGroupName"].ToString();
            //        txt_serial_number.Text = sdr["SerialNumber"].ToString();
            //        cb_project.Text = sdr["region_name"].ToString();
            //        cb_cost_center.Text = sdr["CostCenterName"].ToString();
            //        cb_unit.Text = sdr["unit_code"].ToString();
            //        cb_pic.Text = sdr["dept_name"].ToString();

            //        cb_currency.Text = sdr["cur_name"].ToString();
            //        txt_tax_kurs.Text = sdr["KursTax"].ToString();
            //        txt_pur_cost.Value = Convert.ToDouble(sdr["Harga"]);
            //        txt_pur_cost_valas.Value = Convert.ToDouble(sdr["jumlah"]);
            //        txt_order_no.Text = sdr["ordernumber"].ToString();
            //        dtp_order_date.SelectedDate = Convert.ToDateTime(sdr["tgl_beli"].ToString());

            //        txt_use_life_year.Text = sdr["exp_life_year"].ToString();
            //        txt_uselife_hour.Value = Convert.ToDouble(sdr["exp_life_hour"]);
            //        txt_dep_method.Text = sdr["mtd"].ToString();
            //        txt_appreciation.Text = sdr["mtd_per"].ToString();
            //        txt_pre_depre_month.Text = sdr["susut_month"].ToString();
            //        txt_pre_depre_val.Value = Convert.ToDouble(sdr["Susut"]);
            //        txt_acq_val.Value = Convert.ToDouble(sdr["aquis_value"]);
            //        txt_salvage_val.Value = Convert.ToDouble(sdr["harga_min"]);
            //        txt_status.Text = sdr["status"].ToString();
            //        dtp_depre_start.SelectedDate = Convert.ToDateTime(sdr["Depstart"].ToString());
            //        if(sdr["depstart_pos"] != null)
            //        {
            //            dtp_depre_last_post.SelectedDate=(DateTime?)DateTime.Parse(sdr["Depstart"].ToString());
            //        }

            //        txt_acc_depre_no.Text = sdr["ak_rek"].ToString();
            //        txt_acc_depre_desc.Text = sdr["ak_rek_name"].ToString();
            //        txt_cost_depre_no.Text = sdr["ak_cum_rek"].ToString();
            //        txt_cost_depre_desc.Text = sdr["ak_cum_rek_name"].ToString();
            //        txt_acc_lost_no.Text = sdr["ak_ex_rek"].ToString();
            //        txt_acc_lost_desc.Text = sdr["ak_ex_rek_name"].ToString();
            //        txt_acc_gain_no.Text = sdr["ak_gain"].ToString();
            //        txt_acc_gain_desc.Text = sdr["ak_gain_name"].ToString();
            //        txt_acc_disposal_no.Text = sdr["ak_disposal"].ToString();
            //        txt_acc_disposal_desc.Text = sdr["ak_disposal_name"].ToString();
            //        txt_cost_accu_no.Text = sdr["asset_rek"].ToString();
            //        txt_cost_accu_desc.Text = sdr["asset_rek_name"].ToString();

            //        if (sdr["tgl_jual"].ToString() != "")
            //        {
            //            dtp_sold_date.SelectedDate = Convert.ToDateTime(sdr["tgl_jual"].ToString());
            //        }
            //        else
            //        {
            //            dtp_sold_date.Clear();
            //        }                    
            //        txt_actual_resale_val.Text = sdr["jumlah_jual"].ToString();
            //        txt_hm_min.Value = Convert.ToDouble(sdr["hm_min"]);
            //        //txt_hm_rate.Value = Convert.ToDouble(sdr["hm_rate"]);
            //    }
            //    con.Close();

            //    Session["action"] = "edit";
            //    //btnSave.Enabled = true;
            //    //btnSave.ImageUrl = "~/Images/simpan.png";
            //    //RadTabStrip1.Tabs[4].Enabled = true;
            //}
        }

        protected void btnNew_Click(object sender, ImageClickEventArgs e)
        {
            RadGrid1.MasterTableView.IsItemInserted = true;
            RadGrid1.MasterTableView.Rebind();
            Session["actionHeader"] = "headerNew";
        }
        private void clear_text(ControlCollection ctrls)
        {
            foreach (System.Web.UI.Control ctrl in ctrls)
            {
                if (ctrl is RadTextBox)
                {
                    ((RadTextBox)ctrl).Text = "";
                }
                else if (ctrl is RadNumericTextBox)
                {
                    ((RadNumericTextBox)ctrl).Text = "";
                }
                else if (ctrl is RadComboBox)
                {
                    ((RadComboBox)ctrl).Text = "";
                }
                else if (ctrl is RadDatePicker)
                {
                    ((RadDatePicker)ctrl).Clear();
                }

                clear_text(ctrl.Controls);
                
            }
        }

        //protected void RadTabStrip1_TabClick(object sender, RadTabStripEventArgs e)
        //{
        //    if (RadTabStrip1.SelectedIndex == 4)
        //    {
        //        //RadTabStrip1.Attributes["OnTabClick"] = String.Format("return ShowPreview('{0}');", txt_doc_number.Text);
        //        String.Format("return ShowPreview('{0}');", txt_doc_number.Text);
        //    }
        //}

        //protected void Button1_Click(object sender, EventArgs e)
        //{
        //    Button1.Attributes["OnClick"] = String.Format("return ShowPreview('{0}');", txt_doc_number.Text);
        //}

        public DataTable GetDataDepre(string asset_code, string year)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_asset_depre_by_month";
            cmd.Parameters.AddWithValue("@asset_id", asset_code);
            cmd.Parameters.AddWithValue("@tahun", year);
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
        public DataTable GetDataDepreYearly(string asset_code)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_asset_depre_by_year";
            cmd.Parameters.AddWithValue("@asset_id", asset_code);
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
        protected void btn_retrive_depre_Click(object sender, EventArgs e)
        {
            System.Web.UI.WebControls.Button btn = (System.Web.UI.WebControls.Button)sender;
            GridEditableItem item = (GridEditableItem)btn.NamingContainer;

            RadGrid2 = (RadGrid)item.FindControl("RadGrid2");
            txt_doc_code = (RadTextBox)item.FindControl("txt_doc_code");
            cb_years_depre_prm = (RadComboBox)item.FindControl("cb_years_depre_prm");
            cb_depre_by_prm = (RadComboBox)item.FindControl("cb_depre_by_prm");
            txt_dep_method = (RadTextBox)item.FindControl("txt_dep_method");

            GridColumn col_susut = RadGrid2.MasterTableView.GetColumn("susut");
            GridColumn tot_hm = RadGrid2.MasterTableView.GetColumn("tot_hm");

            if (cb_depre_by_prm.Text == "Monthly")
            {
                RadGrid2.DataSource = GetDataDepre(txt_doc_code.Text, cb_years_depre_prm.Text);
                if(txt_dep_method.Text=="HM")
                {
                    col_susut.Visible=false;
                    tot_hm.Visible = true;
                }
                else
                {
                    col_susut.Visible = true;
                    tot_hm.Visible = false;
                }
            }
            else
            {
                RadGrid2.DataSource = GetDataDepreYearly(txt_doc_number.Text);

            }
            RadGrid2.DataBind();
        }

        protected void cb_depre_prm_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Add("Monthly");
            (sender as RadComboBox).Items.Add("Yearly");
        }
        protected void cb_depre_by_prm_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            RadComboBox cb = (RadComboBox)sender;
            GridEditableItem item = (GridEditableItem)cb.NamingContainer;

            RadGrid2 = (RadGrid)item.FindControl("RadGrid2");
            cb_years_depre_prm = (RadComboBox)item.FindControl("cb_years_depre_prm");


            GridColumn col_bulan = RadGrid2.MasterTableView.GetColumn("bulan_tahun");
            GridColumn col_status = RadGrid2.MasterTableView.GetColumn("status");

            if ((sender as RadComboBox).Text == "Monthly")
            {
                col_bulan.HeaderText = "Month";
                col_status.Visible = true;
                cb_years_depre_prm.Enabled = true;
            }
            else
            {
                col_bulan.HeaderText = "Year";
                col_status.Visible = false;
                cb_years_depre_prm.Enabled = false;
            }
        }
        private static DataTable GetYearDeprePrm(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT DISTINCT(Left(YearMonth,4)) AS tahun FROM acc00d22 WHERE asset_id = @text ",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_years_depre_prm_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            
            RadComboBox cb = (RadComboBox)sender;
            GridEditableItem item = (GridEditableItem)cb.NamingContainer;

            txt_doc_number = (RadTextBox)item.FindControl("txt_doc_code");
            DataTable data = GetYearDeprePrm(txt_doc_number.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["tahun"].ToString(), data.Rows[i]["tahun"].ToString()));
            }
        }
        protected void RadGrid2_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            //(sender as RadGrid).DataSource = new string []{ };
            RadGrid grid = (RadGrid)sender;
            GridEditableItem item = (GridEditableItem)grid.NamingContainer;

            RadGrid2 = (RadGrid)item.FindControl("RadGrid2");
            cb_depre_by_prm = (RadComboBox)item.FindControl("cb_depre_by_prm");
            txt_doc_number = (RadTextBox)item.FindControl("txt_doc_number");
            cb_years_depre_prm = (RadComboBox)item.FindControl("cb_years_depre_prm");

            if (cb_depre_by_prm.Text == "Monthly")
            {
                (sender as RadGrid).DataSource = GetDataDepre(txt_doc_number.Text, cb_years_depre_prm.Text);
            }
            else
            {
                (sender as RadGrid).DataSource = GetDataDepreYearly(txt_doc_number.Text);

            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridEditableItem item = (GridEditableItem)btn.NamingContainer;
            txt_doc_code = (RadTextBox)item.FindControl("txt_doc_code");

            txt_doc_number = (RadTextBox)item.FindControl("txt_doc_number");
            cb_asset_class = (RadComboBox)item.FindControl("cb_asset_class");
            txt_asset_name = (RadTextBox)item.FindControl("txt_asset_name");
            cb_status_reg = (RadComboBox)item.FindControl("cb_status_reg");
            txt_qty = (RadNumericTextBox)item.FindControl("txt_qty");
            cb_uom = (RadComboBox)item.FindControl("cb_uom");
            cb_cost_center = (RadComboBox)item.FindControl("cb_cost_center");
            cb_project = (RadComboBox)item.FindControl("cb_project");
            txt_material_code = (RadTextBox)item.FindControl("txt_material_code");
            cb_taxx_group = (RadComboBox)item.FindControl("cb_taxx_group");
            cb_unit = (RadComboBox)item.FindControl("cb_unit");
            cb_ur_number = (RadComboBox)item.FindControl("cb_ur_number");
            cb_asset_type = (RadComboBox)item.FindControl("cb_asset_type");
            cb_pic = (RadComboBox)item.FindControl("cb_pic");
            txt_spec = (RadTextBox)item.FindControl("txt_spec");
            RadGrid2 = (RadGrid)item.FindControl("RadGrid2");
            RadTabStrip1 = (RadTabStrip)item.FindControl("RadTabStrip1");
            txt_pur_cost = (RadNumericTextBox)item.FindControl("txt_pur_cost");
            txt_pur_cost_valas = (RadNumericTextBox)item.FindControl("txt_pur_cost_valas");
            txt_pre_depre_val = (RadNumericTextBox)item.FindControl("txt_pre_depre_val");
            dtp_order_date = (RadDatePicker)item.FindControl("dtp_order_date");
            txt_salvage_val = (RadNumericTextBox)item.FindControl("txt_salvage_val");
            cb_currency = (RadComboBox)item.FindControl("cb_currency");
            txt_tax_kurs = (RadTextBox)item.FindControl("txt_tax_kurs");
            cb_asset_status = (RadComboBox)item.FindControl("cb_asset_status");
            txt_order_no = (RadTextBox)item.FindControl("txt_order_no");
            txt_serial_number = (RadTextBox)item.FindControl("txt_serial_number");
            txt_use_life_year = (RadTextBox)item.FindControl("txt_use_life_year");
            txt_dep_method = (RadTextBox)item.FindControl("txt_dep_method");
            txt_appreciation = (RadTextBox)item.FindControl("txt_appreciation");
            dtp_depre_start = (RadDatePicker)item.FindControl("dtp_depre_start");
            txt_acq_val = (RadNumericTextBox)item.FindControl("txt_acq_val");
            txt_pre_depre_month = (RadNumericTextBox)item.FindControl("txt_pre_depre_month");
            dtp_depre_last_post = (RadDatePicker)item.FindControl("dtp_depre_last_post");
            txt_uselife_hour = (RadNumericTextBox)item.FindControl("txt_uselife_hour");
            txt_hm_min = (RadNumericTextBox)item.FindControl("txt_hm_min");
            btnCancel = (Button)item.FindControl("btnCancel");
            long maxNo;
            string run = null;
            
            try
            {
                if (Session["actionHeader"].ToString() == "headerEdit")
                {
                    run = txt_doc_code.Text;
                    con.Open();
                    SqlDataReader sdr;
                    cmd = new SqlCommand("SELECT TOP(1) posting FROM acc00d22 WHERE asset_id = '" + txt_doc_code.Text + "'", con);
                    sdr = cmd.ExecuteReader();
                    while (sdr.Read())
                    {
                        if (sdr[0].ToString() == "1")
                        {
                            //MessageBox.Show("Unable to edit data, depreciation has been posted!");
                            ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "ClientScript", "alert('Unable to edit data, depreciation has been posted!')", true);
                            //ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('Unable to edit data, depreciation has been posted!');", true);
                            //System.Windows.Forms.MessageBox.Show("Unable to edit data, depreciation has been posted!", "Attention", MessageBoxButtons.OK, MessageBoxIcon.Hand);

                            con.Close();
                            return;
                        }
                    }

                    con.Close();
                }
                else
                {
                    con.Open();
                    SqlDataReader sdr;
                    cmd = new SqlCommand("SELECT MAX(RIGHT( asset_id , 6 )) + 1 FROM ACC00H22 WHERE (asset_id LIKE '" + cb_asset_class.SelectedValue +"' + '%' )", con);
                    sdr = cmd.ExecuteReader();
                    if (sdr.HasRows == false)
                    {
                        //throw new Exception();
                        run = cb_asset_class.SelectedValue + "-" + "000001";
                    }
                    else if (sdr.Read())
                    {
                        maxNo = Convert.ToInt32(sdr[0].ToString());
                        run = cb_asset_class.SelectedValue + "-" + ("000000" + maxNo).Substring(("000000" + maxNo).Length - 6, 6);
                    }
                    con.Close();
                }


                con.Open();
                cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandType = CommandType.StoredProcedure;
                if (cb_status_reg.Text == "Unregister")
                {
                    cmd.CommandText = "sp_save_asset_unregister";
                    cmd.Parameters.AddWithValue("@asset_id", run);
                    cmd.Parameters.AddWithValue("@asset_number", txt_doc_number.Text);
                    cmd.Parameters.AddWithValue("@AssetName", txt_asset_name.Text);
                    cmd.Parameters.AddWithValue("@AssetSpec", txt_spec.Text);
                    cmd.Parameters.AddWithValue("@ak_code", cb_asset_class.SelectedValue);
                    cmd.Parameters.AddWithValue("@Qty", Convert.ToDecimal(txt_qty.Value));
                    cmd.Parameters.AddWithValue("@SatQty", cb_uom.Text);
                    cmd.Parameters.AddWithValue("@Harga", 0);
                    cmd.Parameters.AddWithValue("@Jumlah", 0);
                    cmd.Parameters.AddWithValue("@Status", "N");
                    cmd.Parameters.AddWithValue("@stedit", "1");
                    cmd.Parameters.AddWithValue("@userid", public_str.user_id);
                    cmd.Parameters.AddWithValue("@lastupdate", DateTime.Today);
                    cmd.Parameters.AddWithValue("@dept_code", cb_cost_center.SelectedValue);
                    cmd.Parameters.AddWithValue("@region_code", cb_project.SelectedValue);
                    cmd.Parameters.AddWithValue("@prod_code", txt_material_code.Text);
                    cmd.Parameters.AddWithValue("@TaxGroup", cb_taxx_group.SelectedValue);
                    cmd.Parameters.AddWithValue("@unit_code", cb_unit.SelectedValue);
                    cmd.Parameters.AddWithValue("@ur_no", cb_ur_number.Text);
                    cmd.Parameters.AddWithValue("@AK_GROUP", cb_asset_type.SelectedValue);
                    cmd.Parameters.AddWithValue("@Pic_Code", cb_pic.SelectedValue);
                }
                else
                {
                    cmd.CommandText = "sp_save_asset_register";
                    cmd.Parameters.AddWithValue("@asset_id", run);
                    cmd.Parameters.AddWithValue("@asset_number", txt_doc_number.Text);
                    cmd.Parameters.AddWithValue("@AssetName", txt_asset_name.Text);
                    cmd.Parameters.AddWithValue("@AssetSpec", txt_spec.Text);
                    cmd.Parameters.AddWithValue("@ak_code", cb_asset_class.SelectedValue);
                    cmd.Parameters.AddWithValue("@ak_code_ori", cb_asset_class.SelectedValue);
                    cmd.Parameters.AddWithValue("@Qty", txt_qty.Value);
                    cmd.Parameters.AddWithValue("@SatQty", cb_uom.Text);
                    cmd.Parameters.AddWithValue("@Harga", txt_pur_cost.Value);
                    cmd.Parameters.AddWithValue("@Jumlah", txt_pur_cost_valas.Value);
                    cmd.Parameters.AddWithValue("@Susut", txt_pre_depre_val.Value);
                    cmd.Parameters.AddWithValue("@jumlah_jual", 0);
                    cmd.Parameters.AddWithValue("@tgl_beli", dtp_order_date.SelectedDate.Value);
                    cmd.Parameters.AddWithValue("@harga_min", txt_salvage_val.Value);
                    cmd.Parameters.AddWithValue("@Status", "B");
                    cmd.Parameters.AddWithValue("@stedit", "1");
                    cmd.Parameters.AddWithValue("@userid", public_str.user_id);
                    cmd.Parameters.AddWithValue("@lastupdate", DateTime.Today);
                    cmd.Parameters.AddWithValue("@cur_code", cb_currency.SelectedValue);
                    cmd.Parameters.AddWithValue("@KursTax", Convert.ToDouble(txt_tax_kurs.Text));
                    cmd.Parameters.AddWithValue("@HargaOri", Convert.ToDecimal(txt_pur_cost_valas.Text));
                    cmd.Parameters.AddWithValue("@dept_code", cb_cost_center.SelectedValue);
                    cmd.Parameters.AddWithValue("@region_code", cb_project.SelectedValue);
                    cmd.Parameters.AddWithValue("@DataStatus", cb_asset_status.SelectedValue);
                    cmd.Parameters.AddWithValue("@ordernumber", txt_order_no.Text);
                    cmd.Parameters.AddWithValue("@SerialNumber", txt_serial_number.Text);
                    cmd.Parameters.AddWithValue("@prod_code", txt_material_code.Text);
                    cmd.Parameters.AddWithValue("@AK_GROUP", cb_asset_type.SelectedValue);
                    cmd.Parameters.AddWithValue("@TaxGroup", cb_taxx_group.SelectedValue);
                    cmd.Parameters.AddWithValue("@Pic_Code", cb_pic.SelectedValue);
                    cmd.Parameters.AddWithValue("@unit_code", cb_unit.SelectedValue);
                    cmd.Parameters.AddWithValue("@exp_life_year", Convert.ToInt32(txt_use_life_year.Text));
                    cmd.Parameters.AddWithValue("@mtd", txt_dep_method.Text);
                    cmd.Parameters.AddWithValue("@mtd_per", Convert.ToDecimal(txt_appreciation.Text));
                    cmd.Parameters.AddWithValue("@Depstart", dtp_depre_start.SelectedDate.Value);
                    cmd.Parameters.AddWithValue("@aquis_value", txt_acq_val.Value);
                    cmd.Parameters.AddWithValue("@IOCC", "IO");
                    cmd.Parameters.AddWithValue("@susut_month", Convert.ToInt32(txt_pre_depre_month.Text));
                    cmd.Parameters.AddWithValue("@depstart_pos", dtp_depre_last_post.SelectedDate.Value);
                    cmd.Parameters.AddWithValue("@status_trans", "0");
                    cmd.Parameters.AddWithValue("@ur_no", cb_ur_number.Text);
                    //cmd.Parameters.AddWithValue("@harga_jual", Convert.ToDecimal(txt_actual_resale_val.Text));
                    //cmd.Parameters.AddWithValue("@tgl_jual", string.Format("{0:yyyy-MM-dd}", dtp_sold_date.SelectedDate.Value));
                    cmd.Parameters.AddWithValue("@exp_life_hour", txt_uselife_hour.Value);
                    cmd.Parameters.AddWithValue("@hm_min", Convert.ToDecimal(txt_hm_min.Text));
                    //cmd.Parameters.AddWithValue("@hm_rate", Convert.ToDouble(txt_hm_rate.Text));
                }

                cmd.ExecuteNonQuery();
                //con.Close();

                //txt_doc_code.Text = run;
                //btnCancel.Text = "Close";
                //RadGrid2.Enabled = true;
                //RadTabStrip1.Tabs[4].Enabled = true;
                //ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "ClientScript", "alert('Data saccessfully saved')", true);
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + ex + "');", true);
                con.Close();
                return;
            }
            finally
            {
                con.Close();
                txt_doc_code.Text = run;
                txt_doc_number.Text = run;
                notif.Text = "Data telah disimpan";
                notif.Show();

                if ((sender as Button).Text == "Update")
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind();", true);
                }
                else
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind('navigateToInserted');", true);
                    (sender as Button).Text = "Update";
                    btnCancel.Text = "Close";
                }

                RadGrid1.MasterTableView.IsItemInserted = false;
            }
        }

        private static DataTable GetCurrency(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT upper(cur_code) as cur_code, upper(cur_name) as cur_name FROM acc00h03 WHERE stEdit <> '4' AND cur_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_currency_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetCurrency(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["cur_name"].ToString(), data.Rows[i]["cur_name"].ToString()));
            }
        }

        protected void cb_currency_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT cur_code FROM acc00h03 WHERE cur_name = '" + (sender as RadComboBox).Text + "'";            
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["cur_code"].ToString();
            }
            dr.Close();

            //cmd.CommandText = "";
            cmd.CommandText = "SELECT top(1) KursRun FROM acc00h04 WHERE cur_code = '" + (sender as RadComboBox).SelectedValue + "'  order by tglKurs desc";
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                txt_tax_kurs.Text = dr["KursRun"].ToString();
            }
            dr.Close();
            con.Close();
        }

        protected void cb_currency_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT cur_code FROM acc00h03 WHERE cur_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();

        }

        protected void txt_pur_cost_TextChanged(object sender, EventArgs e)
        {
            txt_pur_cost_valas.Text = txt_pur_cost.Text;
        }

        protected void txt_hm_rate_TextChanged(object sender, EventArgs e)
        {

        }

        protected void btn_new_Click(object sender, EventArgs e)
        {
            RadGrid1.MasterTableView.IsItemInserted = true;
            RadGrid1.MasterTableView.Rebind();
        }

        protected void RadGrid1_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                Session["actionHeader"] = "headerEdit";
                Session["actionDetail"] = null;
            }
        }

        protected void cb_status_reg_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Add("Registered");
            (sender as RadComboBox).Items.Add("Unregister");
        }

        protected void cb_status_reg_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if ((sender as RadComboBox).Text == "Registered")
            {
                (sender as RadComboBox).SelectedValue = "B";
            }
            else if ((sender as RadComboBox).Text == "Unregister")
            {
                (sender as RadComboBox).SelectedValue = "N";
            }
        }

        protected void cb_status_reg_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadComboBox).Text == "Registered")
            {
                (sender as RadComboBox).SelectedValue = "B";
            }
            else if ((sender as RadComboBox).Text == "Unregister")
            {
                (sender as RadComboBox).SelectedValue = "N";
            }
        }
    }

}