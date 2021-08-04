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

namespace TelerikWebApplication.Form.Inventory.FluidControl.Oil
{

    public partial class inv01h05oc : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();

        private const int ItemsPerRequest = 10;
        public static string prod_code = null;

        public static string tr_code = null;
        public static string selected_project = null;
        //public static string Selected_Project = null;
        public static string selected_storage = "";
        //public static string selected_wh_code = "";
        public static string selected_unit_code = null;
        public static string tWarannty_check = null;
        public static string selected_cost_ctr = null;
        public static string selected_info_code = null;
        public static string selected_supplier = null;
        public static string selected_type_reff = null;
        DataTable dtValues;

        RadComboBox cb_Project;
        RadComboBox cb_CostCenter;
        RadComboBox cb_ref;
        RadComboBox cb_type_ref;
        RadComboBox cb_type_out;
        RadComboBox cb_warehouse;
        RadTextBox txt_CostCenterName;
        RadTextBox txt_unit;
        RadTextBox txt_model;
        RadTextBox txt_remark;
        RadNumericTextBox txt_hm;
        RadLabel lbl_reff_no;
        RadDatePicker dtp_date;
        CheckBox chk_posting;
        RadTextBox txt_gi_number;
        RadComboBox cb_CustSupp;
        RadComboBox cb_receipt;
        RadComboBox cb_issued;
        RadComboBox cb_approval;
        //RadComboBox cb_costcenter;
        RadComboBox cb_project;
        RadComboBox cb_unit_code;
        RadComboBox cb_componen;
        RadGrid RadGrid2;
        Button btnCancel;

        public DataTable DetailDtbl()
        {
            dtValues = new DataTable();
            dtValues.Columns.Add("prod_code", typeof(string));
            dtValues.Columns.Add("prod_spec", typeof(string));
            dtValues.Columns.Add("qty_out", typeof(double));
            dtValues.Columns.Add("unit_code", typeof(string));

            return dtValues;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lbl_form_name.Text = "Unit Oil Consumption";
                dtp_from.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
                dtp_to.SelectedDate = DateTime.Now;
                selected_project = public_str.site;
                cb_proj_prm.Text = public_str.sitename;
                selected_storage = "";
                
                Session["action"] = "firstLoad";
                Session["TableDetail"] = null;
                Session["actionDetail"] = null;
                Session["actionHeader"] = null;

            }
        }

        protected void RadAjaxManager1_AjaxRequest(object sender, AjaxRequestEventArgs e)
        {
            if (e.Argument == "Rebind")
            {
                RadGrid1.MasterTableView.SortExpressions.Clear();
                RadGrid1.MasterTableView.GroupByExpressions.Clear();
                RadGrid1.Rebind();
            }
            else if (e.Argument == "RebindAndNavigate")
            {
                RadGrid1.MasterTableView.SortExpressions.Clear();
                RadGrid1.MasterTableView.GroupByExpressions.Clear();
                RadGrid1.MasterTableView.CurrentPageIndex = RadGrid1.MasterTableView.PageCount - 1;
                RadGrid1.Rebind();
            }
        }

        protected void btnNew_Click(object sender, ImageClickEventArgs e)
        {
            Session["TableDetail"] = null;
            Session["actionHeader"] = "headerNew";
            RadGrid1.MasterTableView.IsItemInserted = true;
            RadGrid1.MasterTableView.Rebind();
        }

        #region Project ( Parameter )
        private static DataTable GetProjectParam(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT region_code, region_name FROM ms_jobsite WHERE stEdit != 4 AND region_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_proj_prm_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetProjectParam(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                cb_proj_prm.Items.Add(new RadComboBoxItem(data.Rows[i]["region_name"].ToString(), data.Rows[i]["region_name"].ToString()));
            }
        }

        protected void cb_proj_prm_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT region_code FROM ms_jobsite WHERE region_name = '" + cb_proj_prm.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                cb_proj_prm.SelectedValue = dr[0].ToString();
                selected_project = dr[0].ToString();
            }
                
            dr.Close();
            con.Close();
        }
        #endregion

        #region Warehouse ( Parameters )
        private static DataTable GetWarehouse(string text, string project)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT wh_code, wh_name FROM ms_warehouse WHERE stEdit != 4 AND tClass IN('1','2') AND PlantCode = @PlantCode AND wh_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@PlantCode", project);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_warehouse_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetWarehouse(e.Text, selected_project);

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
                selected_storage = dr[0].ToString();
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
                selected_storage = dr[0].ToString();
            }
            dr.Close();
            con.Close();
        }
        #endregion

        #region Header
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            RadGrid1.DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), cb_proj_prm.SelectedValue);
            RadGrid1.DataBind();
        }
        public DataTable GetDataTable(string fromDate, string toDate, string project)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_oil_consumption";
            cmd.Parameters.AddWithValue("@date", fromDate);
            cmd.Parameters.AddWithValue("@todate", toDate);
            cmd.Parameters.AddWithValue("@project", project);
            //cmd.Parameters.AddWithValue("@warehouse", storage);
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
            (sender as RadGrid).DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), cb_proj_prm.SelectedValue);
        }

        protected void RadGrid1_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                //tr_code = null;
                GridDataItem item = e.Item as GridDataItem;
                string kode = item["do_code"].Text;
                tr_code = kode;
                selected_project = item["region_code"].Text;
                selected_storage = item["wh_code"].Text;
                selected_unit_code = item["unit_code"].Text;

                Session["actionHeader"] = "headerEdit";
                Session["actionDetail"] = null;
            }
        }

        protected void RadGrid1_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            var do_code = ((GridDataItem)e.Item).GetDataKeyValue("do_code");

            try
            {
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_delete_oil_consumptionH";
                cmd.Parameters.AddWithValue("@do_code", do_code);
                cmd.Parameters.AddWithValue("@userid", public_str.user_id);
                cmd.ExecuteNonQuery();
                con.Close();

                Label lblOk = new Label();
                lblOk.Text = "Data deleted successfully";
                lblOk.ForeColor = System.Drawing.Color.Teal;
                RadGrid1.Controls.Add(lblOk);
            }
            catch (Exception ex)
            {
                con.Close();
                Label lblError = new Label();
                lblError.Text = "Unable to delete data. Reason: " + ex.Message;
                lblError.ForeColor = System.Drawing.Color.Red;
                RadGrid1.Controls.Add(lblError);
                e.Canceled = true;
            }
        }

        protected void RadGrid1_ItemCreated(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                //ImageButton editLink = (ImageButton)e.Item.FindControl("EditLink");
                //editLink.Attributes["href"] = "javascript:void(0);";
                //editLink.Attributes["onclick"] = String.Format("return ShowEditForm('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["do_code"], e.Item.ItemIndex);

                ImageButton printLink = (ImageButton)e.Item.FindControl("PrintLink");
                printLink.Attributes["href"] = "javascript:void(0);";
                printLink.Attributes["onclick"] = String.Format("return ShowPreview('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["do_code"], e.Item.ItemIndex);

            }
        }

        protected void RadGrid1_SelectedIndexChanged(object sender, EventArgs e)
        {
            foreach (GridDataItem item in RadGrid1.SelectedItems)
            {
                tr_code = item["do_code"].Text;
            }

            Session["actionEdit"] = "list";
        }

        protected void RadGrid1_PreRender(object sender, EventArgs e)
        {
            if (Session["action"].ToString() == "firstLoad")
            {
                if ((sender as RadGrid).MasterTableView.Items.Count > 0)
                    (sender as RadGrid).MasterTableView.Items[0].Selected = true;
                foreach (GridDataItem item in RadGrid1.SelectedItems)
                {
                    if (tr_code == null)
                    {
                        tr_code = item["do_code"].Text;
                    }
                }

            }
        }

        #endregion

        #region Project
        private static DataTable GetProject(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT region_code, region_name FROM ms_jobsite WHERE stEdit != 4 AND region_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_Project_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
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

        protected void cb_Project_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
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
                selected_project = dr[0].ToString();
            }
            dr.Close();
            con.Close();
        }

        protected void cb_Project_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT region_code FROM ms_jobsite WHERE region_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }
        #endregion

        #region Warehouse
        private static DataTable GetWarehouseH(string text, string project)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT wh_code, wh_name FROM ms_warehouse WHERE stEdit != 4 AND tClass IN('1','2') AND PlantCode = @PlantCode AND wh_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@PlantCode", project);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_warehouseH_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetWarehouseH(e.Text, selected_project);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["wh_name"].ToString(), data.Rows[i]["wh_name"].ToString()));
            }
        }

        protected void cb_warehouseH_PreRender(object sender, EventArgs e)
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

        protected void cb_warehouseH_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
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
        #endregion

        #region Component
        private static DataTable GetComponent(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT compart_code, compart_remark FROM ms_compartment WHERE stEdit != 4 AND compart_remark LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_componen_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetComponent(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["compart_remark"].ToString(), data.Rows[i]["compart_remark"].ToString()));
            }
        }

        protected void cb_componen_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT compart_code FROM ms_compartment WHERE compart_remark = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            }
            dr.Close();
            con.Close();
        }

        protected void cb_componen_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT compart_code FROM ms_compartment WHERE compart_remark = '" + (sender as RadComboBox).Text + "'";
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

        #region Type Out
        protected void cb_type_out_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Add("Planned Maintenance");
            (sender as RadComboBox).Items.Add("Breakdown");
            (sender as RadComboBox).Items.Add("Add");
            (sender as RadComboBox).Items.Add("Incident");
        }

        protected void cb_type_out_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadComboBox).Text == "Planned Maintenance")
            {
                (sender as RadComboBox).SelectedValue = "1";
            }
            else if ((sender as RadComboBox).Text == "Breakdown")
            {
                (sender as RadComboBox).SelectedValue = "2";
            }
            else if ((sender as RadComboBox).Text == "Add")
            {
                (sender as RadComboBox).SelectedValue = "3";
            }
            else if ((sender as RadComboBox).Text == "Incident")
            {
                (sender as RadComboBox).SelectedValue = "4";
            }
        }

        protected void cb_type_out_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if ((sender as RadComboBox).Text == "Planned Maintenance")
            {
                (sender as RadComboBox).SelectedValue = "1";
            }
            else if ((sender as RadComboBox).Text == "Breakdown")
            {
                (sender as RadComboBox).SelectedValue = "2";
            }
            else if ((sender as RadComboBox).Text == "Add")
            {
                (sender as RadComboBox).SelectedValue = "3";
            }
            else if ((sender as RadComboBox).Text == "Incident")
            {
                (sender as RadComboBox).SelectedValue = "4";
            }
        }
        #endregion

        #region Unit
        //private static DataTable GetUnit(string text, string project)
        //{
        //    SqlDataAdapter adapter = new SqlDataAdapter("SELECT unit_code, unit_name, model_no FROM ms_unit WHERE stEdit != 4 AND active = 1 AND region_code = @region_code AND unit_name LIKE @text + '%'",
        //    ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
        //    adapter.SelectCommand.Parameters.AddWithValue("@region_code", project);
        //    adapter.SelectCommand.Parameters.AddWithValue("@text", text);

        //    DataTable data = new DataTable();
        //    adapter.Fill(data);

        //    return data;
        //}
        protected void cb_unit_code_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT unit_code, unit_name, model_no FROM ms_unit WHERE stEdit != 4 AND active = 1 AND region_code = @region_code AND unit_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@region_code", selected_project);
            adapter.SelectCommand.Parameters.AddWithValue("@text", e.Text);

            DataTable dt = new DataTable();
            adapter.Fill(dt);

            RadComboBox comboBox = (RadComboBox)sender;
            // Clear the default Item that has been re-created from ViewState at this point.
            comboBox.Items.Clear();

            foreach (DataRow row in dt.Rows)
            {
                RadComboBoxItem item = new RadComboBoxItem();
                item.Text = row["unit_code"].ToString();
                item.Value = row["unit_code"].ToString();
                item.Attributes.Add("model_no", row["model_no"].ToString());
                item.Attributes.Add("unit_name", row["unit_name"].ToString());

                comboBox.Items.Add(item);

                item.DataBind();
            }
        }

        protected void cb_unit_code_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT unit_code, model_no, unit_name, region_code, dept_code, cap_tanki, sn_sarana FROM ms_unit " +
                                "WHERE active = '1' AND tFuel = 1 AND stedit <> '4' AND unit_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
                selected_unit_code = dr[0].ToString();
            }
            dr.Close();
            con.Close();
        }

        protected void cb_unit_code_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            RadComboBox cb = (RadComboBox)sender;
            GridEditableItem item = (GridEditableItem)cb.NamingContainer;

            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT	ms_unit.unit_code, ms_unit.model_no, ms_unit.unit_name, ms_unit.region_code, ms_unit.dept_code, " +
                                "ms_unit.cap_tanki, ms_unit.sn_sarana, ms_cost_center.CostCenterName " +
                                "FROM    ms_unit INNER JOIN " +
                                "ms_cost_center ON ms_unit.dept_code = ms_cost_center.CostCenter " +
                                "WHERE ms_unit.active = '1' AND ms_unit.tFuel = 1 AND ms_unit.stEdit <> '4' AND unit_code = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
                selected_unit_code = dr[0].ToString();

                txt_model = (RadTextBox)item.FindControl("txt_model");
                txt_model.Text = dr["model_no"].ToString();

                cb_CostCenter = (RadComboBox)item.FindControl("cb_CostCenter");
                cb_CostCenter.Text = dr["dept_code"].ToString();

                txt_CostCenterName = (RadTextBox)item.FindControl("txt_CostCenterName");
                txt_CostCenterName.Text = dr["CostCenterName"].ToString();
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

            SqlDataAdapter adapter = new SqlDataAdapter("SELECT upper(CostCenter) as code,upper(CostCenterName) as name FROM ms_cost_center " +
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
        protected void cb_CostCenter_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadCostCtr(e.Text, selected_project, (sender as RadComboBox));
        }

        protected void cb_CostCenter_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT CostCenter FROM ms_cost_center WHERE CostCenterName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["CostCenter"].ToString();
                selected_cost_ctr = dr[0].ToString();
            }
            dr.Close();
            con.Close();
        }

        protected void cb_CostCenter_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT CostCenter FROM ms_cost_center WHERE CostCenterName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["CostCenter"].ToString();
                selected_cost_ctr = dr[0].ToString();
            }
            dr.Close();
            con.Close();
        }
        #endregion

        #region Detail
        public DataTable GetDataDetailTable(string do_code)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_OilConsumptionD";
            cmd.Parameters.AddWithValue("@do_code", do_code);
            cmd.CommandTimeout = 0;
            cmd.ExecuteNonQuery();
            sda = new SqlDataAdapter(cmd);

            dtValues = new DataTable();

            try
            {
                sda.Fill(dtValues);
            }
            finally
            {
                con.Close();
            }

            return dtValues;
        }
        protected void RadGrid2_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            if (Session["TableDetail"] == null && Session["actionHeader"].ToString() != "headerEdit") // Insert Session
            {
                (sender as RadGrid).DataSource = new string[] { };
            }
            else
            {
                if (Session["actionHeader"].ToString() == "headerEdit" && Session["actionDetail"] == null)
                {
                    Session["TableDetail"] = null;
                    (sender as RadGrid).DataSource = GetDataDetailTable(tr_code);
                }
                else if (Session["TableDetail"] == null)
                {
                    DetailDtbl();
                }
                else
                {
                    dtValues = (DataTable)Session["TableDetail"];
                }
                (sender as RadGrid).DataSource = dtValues; //populate RadGrid with datatable
                Session["TableDetail"] = dtValues;
            }
        }

        protected void RadGrid2_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            var InvCode = ((GridDataItem)e.Item).GetDataKeyValue("inv_code");

            try
            {
                GridEditableItem item = (GridEditableItem)e.Item;
                Label lbl_prod_code;
                RadNumericTextBox lbl_Part_Qty;

                lbl_Part_Qty = (RadNumericTextBox)item.FindControl("lbl_Part_Qty");
                lbl_prod_code = (Label)item.FindControl("lbl_prod_code");

                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_delete_oil_consumptionD";
                cmd.Parameters.AddWithValue("@do_code", tr_code);
                cmd.Parameters.AddWithValue("@prod_code", lbl_prod_code.Text);
                cmd.Parameters.AddWithValue("@wh_code", selected_storage);
                cmd.Parameters.AddWithValue("@qty", lbl_Part_Qty.Value);
                cmd.ExecuteNonQuery();
                con.Close();
                (sender as RadGrid).DataBind();

                Label lblsuccess = new Label();
                lblsuccess.Text = "Data deleted";
                lblsuccess.ForeColor = System.Drawing.Color.DarkGray;
                (sender as RadGrid).Controls.Add(lblsuccess);
            }
            catch (Exception ex)
            {
                con.Close();
                Label lblError = new Label();
                lblError.Text = "Unable to delete data. Reason: " + ex.Message;
                lblError.ForeColor = System.Drawing.Color.Red;
                (sender as RadGrid).Controls.Add(lblError);
                e.Canceled = true;
            }
        }

        protected void RadGrid2_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadGrid).MasterTableView.Items.Count < (sender as RadGrid).MasterTableView.PageSize)
            {
                (sender as RadGrid).ClientSettings.Scrolling.AllowScroll = false;
                (sender as RadGrid).ClientSettings.Scrolling.UseStaticHeaders = false;
            }
            else
            {
                (sender as RadGrid).ClientSettings.Scrolling.AllowScroll = true;
                (sender as RadGrid).ClientSettings.Scrolling.ScrollHeight = 195;
            }
        }

        protected void RadGrid2_UpdateCommand(object sender, GridCommandEventArgs e)
        {
            GridEditableItem item = (GridEditableItem)e.Item;

            dtValues = (DataTable)Session["TableDetail"];
            DataRow drValue = dtValues.NewRow();
            drValue["slip_no"] = tr_code;
            drValue["inv_code"] = (item.FindControl("cb_inv_code") as RadComboBox).Text;
            drValue["fkno"] = (item.FindControl("txt_invCode") as RadTextBox).Text;
            drValue["slip_date"] = (item.FindControl("txt_InvDate") as RadTextBox).Text;
            drValue["remark"] = (item.FindControl("txt_remark") as RadTextBox).Text;
            drValue["pay_amount"] = (item.FindControl("txt_amount") as RadNumericTextBox).Text;
            drValue["region_code"] = (item.FindControl("txt_projectDetail") as RadTextBox).Text;
            drValue["dept_code"] = (item.FindControl("txt_CostCenter") as RadTextBox).Text;
            //drValue["run"] = 0;

            drValue.EndEdit(); //editing row in datatable
            dtValues.AcceptChanges();
            //Session["TableDetail"] = dtValues;
            (sender as RadGrid).DataSource = dtValues;
            (sender as RadGrid).Rebind();
        }

        protected void RadGrid2_InsertCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                GridEditableItem item = (GridEditableItem)e.Item;

                //if (Session["actionEdit"].ToString() == "new" && Session["TableDetail"] == null)
                if (Session["actionDetail"].ToString() == "detailNew" && Session["TableDetail"] == null)
                {
                    DetailDtbl();

                    (sender as RadGrid).DataSource = dtValues; //populate RadGrid with datatable
                    Session["TableDetail"] = dtValues;
                }

                dtValues = (DataTable)Session["TableDetail"];
                DataRow drValue = dtValues.NewRow();
                drValue["slip_no"] = tr_code;
                drValue["inv_code"] = (item.FindControl("cb_inv_code_insert") as RadComboBox).Text;
                drValue["fkno"] = (item.FindControl("txt_invCode_insert") as RadTextBox).Text;
                drValue["slip_date"] = (item.FindControl("txt_InvDate_insert") as RadTextBox).Text;
                drValue["remark"] = (item.FindControl("txt_remark_insert") as RadTextBox).Text;
                drValue["pay_amount"] = (item.FindControl("txt_amount_insert") as RadNumericTextBox).Text;
                drValue["region_code"] = (item.FindControl("txt_projectDetail_insert") as RadTextBox).Text;
                drValue["dept_code"] = (item.FindControl("txt_CostCenter_insert") as RadTextBox).Text;
                //drValue["run"] = 0;

                dtValues.Rows.Add(drValue); //adding new row into datatable
                dtValues.AcceptChanges();
                Session["TableDetail"] = dtValues;
                (sender as RadGrid).Rebind();
                Session["actionDetail"] = "detailList";

            }
            catch (Exception ex)
            {
                con.Close();
                Label lblError = new Label();
                lblError.Text = "Unable to insert data. Reason: " + ex.Message;
                lblError.ForeColor = System.Drawing.Color.Red;
                (sender as RadGrid).Controls.Add(lblError);
                e.Canceled = true;
            }
        }

        protected void RadGrid2_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == RadGrid.InitInsertCommandName)
            {
                Session["actionDetail"] = "detailNew";
            }
            else if (e.CommandName == RadGrid.EditCommandName)
            {
                Session["actionDetail"] = "detailEdit";
            }
        }
        #endregion

        #region Prod Code
        protected void cb_prod_code_editTemp_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            string sql = "select * from v_product_by_warehouse where wh_code = '"+ selected_storage + "' AND prod_code LIKE @text + '%'";

            SqlDataAdapter adapter = new SqlDataAdapter(sql,
                ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", e.Text);

            DataTable dt = new DataTable();
            adapter.Fill(dt);

            RadComboBox comboBox = (RadComboBox)sender;
            // Clear the default Item that has been re-created from ViewState at this point.
            comboBox.Items.Clear();

            foreach (DataRow row in dt.Rows)
            {
                RadComboBoxItem item = new RadComboBoxItem();
                item.Text = row["prod_code"].ToString();
                item.Value = row["prod_code"].ToString();
                item.Attributes.Add("spec", row["spec"].ToString());
                item.Attributes.Add("brand_name", row["brand_name"].ToString());
                item.Attributes.Add("unit", row["unit"].ToString());
                item.Attributes.Add("QACT", row["QACT"].ToString());

                comboBox.Items.Add(item);

                item.DataBind();
            }
        }

        protected void cb_prod_code_editTemp_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT * FROM v_Oil_ConsumptionD WHERE prod_code = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_prod_code_editTemp_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            Session["prod_code"] = e.Value;

            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "SELECT prod_code, koref, spec, brand_name, QACT, price_sale, unit, stMain FROM v_Oil_ConsumptionD WHERE prod_code = '" + (sender as RadComboBox).SelectedValue + "'";

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                foreach (DataRow dtr in dt.Rows)
                {
                    RadComboBox cb = (RadComboBox)sender;
                    GridEditableItem item = (GridEditableItem)cb.NamingContainer;
                    if (Session["actionDetail"].ToString() == "detailNew")
                    {
                        Label l_spec = (Label)item.FindControl("lblSpec_insert");
                        RadNumericTextBox t_qty = (RadNumericTextBox)item.FindControl("txt_Part_Qty_insert");
                        Label l_uom = (Label)item.FindControl("lblUom_insert");

                        l_spec.Text = dtr["SOH"].ToString();
                        t_qty.Text = dtr["qty_out"].ToString();
                        l_uom.Text = dtr["uom"].ToString();
                    }
                    //else if (Session["actionDetail"].ToString() == "detailEdit")
                    //{
                    //    Label l_spec = (Label)item.FindControl("lblSpec_edit");
                    //    RadNumericTextBox t_qty = (RadNumericTextBox)item.FindControl("txt_Part_Qty_edit");
                    //    Label l_uom = (Label)item.FindControl("lblUom_edit");

                    //    l_spec.Text = dtr["spec"].ToString();
                    //    t_qty.Value = 0;
                    //    l_uom.Text = dtr["unit"].ToString();
                    //}
                    else
                    {
                        Label l_spec = (Label)item.FindControl("lblSpec");
                        RadNumericTextBox t_qty = (RadNumericTextBox)item.FindControl("lbl_Part_Qty");
                        Label l_uom = (Label)item.FindControl("lblUom");

                        l_spec.Text = dtr["SOH"].ToString();
                        t_qty.Text = dtr["qty_out"].ToString();
                        l_uom.Text = dtr["uom"].ToString();
                    }
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
        #endregion

        #region Journal
        public DataTable GetDataJournalTable(string do_code) 
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "";
            cmd.Parameters.AddWithValue("@do_code", do_code);
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
        protected void RadGrid3_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            if (Session["actionHeader"].ToString() == "headerEdit")
            {
                (sender as RadGrid).DataSource = GetDataJournalTable(tr_code);
            }
            else
            {
                (sender as RadGrid).DataSource = new string[] { };
            }
        }

        protected void RadGrid3_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadGrid).MasterTableView.Items.Count < (sender as RadGrid).MasterTableView.PageSize)
            {
                (sender as RadGrid).ClientSettings.Scrolling.AllowScroll = false;
                (sender as RadGrid).ClientSettings.Scrolling.UseStaticHeaders = false;
            }
        }
        #endregion

        protected void btnSave_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridEditableItem item = (GridEditableItem)btn.NamingContainer;

            RadTextBox txt_gi_number = (RadTextBox)item.FindControl("txt_gi_number");
            RadDatePicker dtp_date = (RadDatePicker)item.FindControl("dtp_date");
            RadComboBox cb_Project = (RadComboBox)item.FindControl("cb_Project");
            RadComboBox cb_warehouseH = (RadComboBox)item.FindControl("cb_warehouseH");
            RadComboBox cb_componen = (RadComboBox)item.FindControl("cb_componen");
            RadComboBox cb_type_out = (RadComboBox)item.FindControl("cb_type_out");
            RadComboBox cb_unit_code = (RadComboBox)item.FindControl("cb_unit_code");
            RadTextBox txt_model = (RadTextBox)item.FindControl("txt_model");
            RadTextBox txt_hm = (RadTextBox)item.FindControl("txt_hm");
            RadComboBox cb_CostCenter = (RadComboBox)item.FindControl("cb_CostCenter");
            RadTextBox txt_CostCenterName = (RadTextBox)item.FindControl("txt_CostCenterName");
            RadTextBox txt_remark = (RadTextBox)item.FindControl("txt_remark");
            //RadComboBox cb_Checked = (RadComboBox)item.FindControl("cb_Checked");
            //RadComboBox cb_Approval = (RadComboBox)item.FindControl("cb_Approval");
            //RadComboBox cb_check = (RadComboBox)item.FindControl("cb_check");
            //RadComboBox cb_approve = (RadComboBox)item.FindControl("cb_approve");
            //RadTextBox txt_remark = (RadTextBox)item.FindControl("txt_remark");

            Button btnCancel = (Button)item.FindControl("btnCancel");
            RadGrid Grid2 = (RadGrid)item.FindControl("RadGrid2");
            RadGrid RadGrid3 = (RadGrid)item.FindControl("RadGrid3");

            long maxNo;
            string run = null;
            string trDate = string.Format("{0:dd/MM/yyyy}", dtp_date.SelectedDate);

            try
            {
                if ((sender as Button).Text == "Update")
                {
                    run = txt_gi_number.Text;
                }
                else
                {
                    con.Open();
                    SqlDataReader sdr;
                    cmd = new SqlCommand("SELECT ISNULL ( MAX ( RIGHT ( tr_doh.do_code , 4 ) ) , 0 ) + 1 AS maxNo " +
                        "FROM tr_doh WHERE LEFT(tr_doh.do_code, 4) = 'FC01' " +
                        "AND SUBSTRING(tr_doh.do_code, 5, 2) = SUBSTRING('" + trDate + "', 9, 2) " +
                        "AND SUBSTRING(tr_doh.do_code, 7, 2) = SUBSTRING('" + trDate + "', 4, 2) ", con);
                    sdr = cmd.ExecuteReader();
                    if (sdr.HasRows == false)
                    {
                        //throw new Exception();
                        run = "FC01" + dtp_date.SelectedDate.Value.Year + dtp_date.SelectedDate.Value.Month + "0001";
                    }
                    else if (sdr.Read())
                    {
                        maxNo = Convert.ToInt32(sdr[0].ToString());
                        run = "FC01" + (dtp_date.SelectedDate.Value.Year.ToString()).Substring(dtp_date.SelectedDate.Value.Year.ToString().Length - 2) +
                            ("0000" + dtp_date.SelectedDate.Value.Month).Substring(("0000" + dtp_date.SelectedDate.Value.Month).Length - 2, 2) +
                            ("0000" + maxNo).Substring(("0000" + maxNo).Length - 4, 4);
                    }
                    con.Close();
                }


                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_save_Cash_PaymentH";
                cmd.Parameters.AddWithValue("@slip_no", run);
                cmd.Parameters.AddWithValue("@slip_date", string.Format("{0:yyyy-MM-dd}", dtp_bm.SelectedDate.Value));
                cmd.Parameters.AddWithValue("@noctrl", txt_NoCtrl.Text);
                cmd.Parameters.AddWithValue("@cust_code", cb_supplier.SelectedValue);
                cmd.Parameters.AddWithValue("@cur_code", txt_CurCode.Text);
                cmd.Parameters.AddWithValue("@kurs", Convert.ToDouble(txt_kurs.Text));
                cmd.Parameters.AddWithValue("@accountno", cb_ref.SelectedValue);
                cmd.Parameters.AddWithValue("@cashbank", cb_cash.SelectedValue);
                cmd.Parameters.AddWithValue("@cur_code_acc", txt_CurCode2.Text);
                cmd.Parameters.AddWithValue("@kurs_acc", Convert.ToDouble(txt_kurs2.Text));
                cmd.Parameters.AddWithValue("@Remark", txt_remark.Text);
                cmd.Parameters.AddWithValue("@freby", cb_Prepared.SelectedValue);
                cmd.Parameters.AddWithValue("@ordby", cb_Checked.SelectedValue);
                cmd.Parameters.AddWithValue("@appby", cb_Approval.SelectedValue);
                cmd.Parameters.AddWithValue("@lvl", 1);
                cmd.Parameters.AddWithValue("@userid", public_str.user_id);
                cmd.Parameters.AddWithValue("@lastupdate", DateTime.Today);
                cmd.Parameters.AddWithValue("@pay_way", 1);
                cmd.Parameters.AddWithValue("@tot_pay", 0);
                cmd.Parameters.AddWithValue("@status_post", 0);
                cmd.Parameters.AddWithValue("@trans_kind", 1);
                cmd.Parameters.AddWithValue("@tot_pay_idr", 0);
                cmd.Parameters.AddWithValue("@tot_pay_acc", 0);
                cmd.Parameters.AddWithValue("@kursBeli", 0);
                cmd.ExecuteNonQuery();

                foreach (GridDataItem itemD in Grid2.MasterTableView.Items)
                {
                    Label lbl_InvCode;
                    Label lbl_inv_code;
                    Label lbl_slip_date;
                    Label lbl_remark;
                    Label lbl_pay_amount;
                    Label lbl_project_detail;
                    Label lbl_cost_ctr;
                    //Label lbl_cost_center;

                    lbl_InvCode = (Label)itemD.FindControl("lbl_InvCode");
                    lbl_inv_code = (Label)itemD.FindControl("lbl_inv_code");
                    lbl_slip_date = (Label)itemD.FindControl("lbl_slip_date");
                    lbl_remark = (Label)itemD.FindControl("lbl_remark");
                    lbl_pay_amount = (Label)itemD.FindControl("lbl_pay_amount");
                    lbl_project_detail = (Label)itemD.FindControl("lbl_project_detail");
                    lbl_cost_ctr = (Label)itemD.FindControl("lbl_cost_ctr");
                    //lbl_cost_center = (Label)itemD.FindControl("lbl_cost_center");

                    cmd = new SqlCommand();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Connection = con;
                    cmd.CommandText = "sp_save_Cash_PaymentD";
                    cmd.Parameters.AddWithValue("@slip_no", run);
                    cmd.Parameters.AddWithValue("@inv_code", lbl_InvCode.Text);
                    cmd.Parameters.AddWithValue("@fkno", lbl_inv_code.Text);
                    //cmd.Parameters.AddWithValue("@slip_date", string.Format("{0:yyyy-MM-dd}", lbl_slip_date.Text));
                    cmd.Parameters.AddWithValue("@remark", lbl_remark.Text);
                    cmd.Parameters.AddWithValue("@pay_amount", Convert.ToDouble(lbl_pay_amount.Text));
                    cmd.Parameters.AddWithValue("@pay_amount_acc", selected_amount);
                    //cmd.Parameters.AddWithValue("@pay_amount_idr", selected_amount);
                    cmd.Parameters.AddWithValue("@dept_code", lbl_cost_ctr.Text);
                    cmd.Parameters.AddWithValue("@region_code", lbl_project_detail.Text);
                    //cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
                    //cmd.Parameters.AddWithValue("@Owner", public_str.user_id);
                    cmd.ExecuteNonQuery();

                }

                notif.Show("Data saved");
            }
            catch (Exception ex)
            {
                con.Close();
                Response.Write("<font color='red'>" + ex.Message + "</font>");
            }
            finally
            {
                con.Close();
                txt_gi_number.Text = run;
                tr_code = run;
                RadGrid3.DataSource = GetDataJournalTable(tr_code);
                RadGrid3.MasterTableView.DataBind();

                RadGrid1.MasterTableView.IsItemInserted = false;
            }
        }

        
    }
}