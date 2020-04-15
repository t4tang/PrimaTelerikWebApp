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

namespace TelerikWebApplication.Form.Fico.Asset
{
    public partial class acc00h22 : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();

        private const int ItemsPerRequest = 10;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {                
                cb_project_prm.SelectedValue = public_str.site;
                cb_project_prm.Text = public_str.sitename;
                                
                Session["action"] = "firstLoad";
                //btnSave.Enabled = false;
                //btnSave.ImageUrl = "~/Images/simpan-gray.png";
            }
        }

        protected void cb_status_prm_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Add("Registered");
            (sender as RadComboBox).Items.Add("Unregistered");
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
            else if ((sender as RadComboBox).Text == "Unregistered")
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
            RadGrid1.DataSource = GetDataTable(cb_project_prm.SelectedValue, cb_status_prm.SelectedValue);
            RadGrid1.DataBind();
        }
        public DataTable GetDataTable(string project, string sts)
        {            
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            if(project != "ALL")
            {
                cmd.CommandText = "SELECT *, case mtd when 'S' then 'STRAIGHT LINE' WHEN 'D' THEN 'DOUBLE DECLINE' WHEN 'H' THEN 'HM' ELSE 'NONE' END AS Methode " +
                    "FROM acc00h22 WHERE region_code = @project AND Status = @reg_status";
            }
            else
            {
                cmd.CommandText = "SELECT *, case mtd when 'S' then 'STRAIGHT LINE' WHEN 'D' THEN 'DOUBLE DECLINE' WHEN 'H' THEN 'HM' ELSE 'NONE' END AS Methode " +
                    "FROM acc00h22 WHERE Status = @reg_status";
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
            (sender as RadGrid).DataSource = GetDataTable(cb_project_prm.SelectedValue, cb_status_prm.SelectedValue);
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
                cmd.CommandText = "UPDATE acc01h22 SET userid = @Usr, lastupdate = GETDATE(), stedit = '4' WHERE (asset_id = @asset_id)";
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
            "WHERE (acc00h22.ur_no = inv01h01.doc_code) AND (acc00h22.stedit <> '4') AND (acc00h22.prod_code = inv01d01.part_code) AND inv01d01.doc_code LIKE @text + '%')) > 0 ", con);
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
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT part_code, part_desc, part_unit, part_desc FROM inv01d01 WHERE doc_code = @text AND nomer = @nomer";
            cmd.Parameters.AddWithValue("@text", (sender as RadComboBox).Text);
            cmd.Parameters.AddWithValue("@nomer", (sender as RadComboBox).SelectedValue);
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                txt_asset_name.Text = dr["part_desc"].ToString();
                txt_material_code.Text = dr["part_code"].ToString();
                txt_qty.Text = "1";
                cb_uom.Text = dr["part_unit"].ToString();
                txt_spec.Text= dr["part_desc"].ToString();
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
            DataTable data = GetProjectPrm(e.Text);

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
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
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
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
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
    }

}