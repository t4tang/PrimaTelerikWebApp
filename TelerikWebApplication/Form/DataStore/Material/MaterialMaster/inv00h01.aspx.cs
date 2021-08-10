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

namespace TelerikWebApplication.Form.Master_data.Material.Material_master
{
    public partial class material_master : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();

        private object _dataItem = null;
        private const int ItemsPerRequest = 10;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                //RadGrid1.MasterTableView.EditMode = (GridEditMode)Enum.Parse(typeof(GridEditMode), "EditForms");
            }
        }       

        private static string GetStatusMessage(int offset, int total)
        {
            if (total <= 0)
                return "No matches";

            return String.Format("Items <b>1</b>-<b>{0}</b> out of <b>{1}</b>", offset, total);
        }
        public DataTable GetDataTable()
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT ms_product.brand_code, ms_product_group.group_name, ms_product_kind.kind_name, "+
                "ms_product.prod_code, ms_product.spec, ms_brand.brand_name, ms_product.kind_code, ms_product.unit," +
                "case ms_product.stMain when 0 then 'Stock and Value' when 1 then 'Only Stock' else 'Non Stock' end as stMain, ms_product.tConsig, " +
                "ms_product.tActive, isnull (ms_product.QtyMin,0) as QtyMin, isnull (ms_product.QtyMinPur,0) as QtyMinPur,  " +
                "isnull (ms_product.SalesFore,0) as SalesFore, ms_product.tWarranty, isnull (ms_product.price_sale,0) as price_sale, "+
                "ms_product.tSN, ms_product.tMonitor, ms_product.warranty, ms_product.group_code FROM ms_product INNER JOIN " +
                "ms_brand ON ms_product.brand_code = ms_brand.brand_code INNER JOIN ms_product_group ON ms_product.group_code = "+
                "ms_product_group.group_code INNER JOIN ms_product_kind ON ms_product.kind_code = ms_product_kind.kind_code " +
                "WHERE(ms_product.stEdit <> '4')";
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
        protected void RadGrid1_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            (sender as RadGrid).DataSource = GetDataTable();
        }

        protected void RadGrid1_UpdateCommand(object source, GridCommandEventArgs e)
        {
            try
            {
                if (e.CommandName == RadGrid.UpdateCommandName)
                {
                    if (e.Item is GridEditFormItem)
                        {
                            GridEditFormItem item = (GridEditFormItem)e.Item;

                            cmd = new SqlCommand("update ms_product set spec = @spec, unit = @unit, QtyMin = @Qtymin,  " +
                                "brand_code = @brand_code, group_code = @group_code, kind_code = @kind_code, " +
                                "stMain = CASE @stMain WHEN 'Stock and Value' THEN '1' WHEN 'Only Stock' THEN '2' ELSE '0' END , " +
                                "qtyminpur = @qtyminpur, SalesFore = @SalesFore, price_sale = @price_sale, tSN = @tSN,  " +
                                "tActive = @tActive, tWarranty = @tWarranty, tMonitor = @tMonitor, tConsig = @tConsig where prod_code = @prod_code", con);
                            con.Open();
                            cmd.Parameters.AddWithValue("@prod_code", (item.FindControl("txt_material_code") as TextBox).Text);
                            cmd.Parameters.AddWithValue("@spec", (item.FindControl("txt_specification") as TextBox).Text); 
                            cmd.Parameters.AddWithValue("@unit", (item.FindControl("cb_uom") as RadComboBox).SelectedValue); 
                            cmd.Parameters.AddWithValue("@brand_code", (item.FindControl("cb_brand") as RadComboBox).SelectedValue);
                            cmd.Parameters.AddWithValue("@group_code", (item.FindControl("cb_group") as RadComboBox).SelectedValue);
                            cmd.Parameters.AddWithValue("@kind_code", (item.FindControl("cb_category") as RadComboBox).SelectedValue);
                            cmd.Parameters.AddWithValue("@stMain", (item.FindControl("cb_st_main") as RadComboBox).Text);
                            cmd.Parameters.AddWithValue("@QtyMin", Convert.ToDouble((item.FindControl("txt_min_stock") as RadNumericTextBox).Text));
                            cmd.Parameters.AddWithValue("@qtyminpur", Convert.ToDouble((item.FindControl("txt_min_purchase") as RadNumericTextBox).Text));
                            cmd.Parameters.AddWithValue("@SalesFore", Convert.ToDouble((item.FindControl("txt_sales_forecast") as RadNumericTextBox).Text));
                            cmd.Parameters.AddWithValue("@price_sale", Convert.ToDouble((item.FindControl("txt_selling_price") as RadNumericTextBox).Text));
                            cmd.Parameters.AddWithValue("@tSN", (item.FindControl("chk_use_SN") as CheckBox).Checked ? 1 : 0);
                            cmd.Parameters.AddWithValue("@tActive", (item.FindControl("chk_active") as CheckBox).Checked? 1 : 0);
                            cmd.Parameters.AddWithValue("@tWarranty", (item.FindControl("chk_warranty") as CheckBox).Checked ? 1 : 0);
                            cmd.Parameters.AddWithValue("@tMonitor", (item.FindControl("chk_monitoring_stock") as CheckBox).Checked ? 1 : 0);
                            cmd.Parameters.AddWithValue("@tConsig", (item.FindControl("chk_consignment") as CheckBox).Checked ? 1 : 0);
                            cmd.ExecuteNonQuery();
                            con.Close();

                            RadGrid1.DataBind();
                    }

                }

                Label lblsuccess = new Label();
                lblsuccess.Text = "Data updated successfully";
                lblsuccess.ForeColor = System.Drawing.Color.Blue;
                RadGrid1.Controls.Add(lblsuccess);
            }
            catch (Exception ex)
            {
                con.Close();
                Label lblError = new Label();
                lblError.Text = "Unable to update data. Reason: " + ex.Message;
                lblError.ForeColor = System.Drawing.Color.Red;
                RadGrid1.Controls.Add(lblError);
                e.Canceled = true;                
            }
            
        }
        protected void RadGrid1_InsertCommand(object source, GridCommandEventArgs e)
        {
            GridEditableItem item = (GridEditableItem)e.Item;
            try
            {
                cmd = new SqlCommand("insert into ms_product (prod_code, spec, unit, QtyMin, brand_code, group_code, kind_code, " +
                        "stMain, qtyminpur, SalesFore, price_sale, tSN, tActive, tWarranty, tMonitor, tConsig, stEdit) values " +
                        "(@prod_code, @spec, @unit, @Qtymin, @brand_code, @group_code,@kind_code, " +
                        "CASE @StMain WHEN 'Stock and value' THEN '0' WHEN 'Only Stock' THEN '1' ELSE '2' END, @qtyminpur, " +
                        "@SalesFore, @price_sale, @tSN, @tActive, @tWarranty, @tMonitor, @tConsig, '0')", con);
                con.Open();
                cmd.Parameters.AddWithValue("@prod_code", (item.FindControl("txt_material_code") as TextBox).Text);
                cmd.Parameters.AddWithValue("@spec", (item.FindControl("txt_specification") as TextBox).Text);
                cmd.Parameters.AddWithValue("@unit", (item.FindControl("cb_uom") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@brand_code", (item.FindControl("cb_brand") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@group_code", (item.FindControl("cb_group") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@kind_code", (item.FindControl("cb_category") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@stMain", (item.FindControl("cb_st_main") as RadComboBox).Text);
                cmd.Parameters.AddWithValue("@QtyMin", Convert.ToDouble((item.FindControl("txt_min_stock") as RadNumericTextBox).Text));
                cmd.Parameters.AddWithValue("@qtyminpur", Convert.ToDouble((item.FindControl("txt_min_purchase") as RadNumericTextBox).Text));
                cmd.Parameters.AddWithValue("@SalesFore", Convert.ToDouble((item.FindControl("txt_sales_forecast") as RadNumericTextBox).Text));
                cmd.Parameters.AddWithValue("@price_sale", Convert.ToDouble((item.FindControl("txt_selling_price") as RadNumericTextBox).Text));
                cmd.Parameters.AddWithValue("@tSN", (item.FindControl("chk_use_SN") as CheckBox).Checked ? 1 : 0);
                cmd.Parameters.AddWithValue("@tActive", (item.FindControl("chk_active") as CheckBox).Checked ? 1 : 0);
                cmd.Parameters.AddWithValue("@tWarranty", (item.FindControl("chk_warranty") as CheckBox).Checked ? 1 : 0);
                cmd.Parameters.AddWithValue("@tMonitor", (item.FindControl("chk_monitoring_stock") as CheckBox).Checked ? 1 : 0);
                cmd.Parameters.AddWithValue("@tConsig", (item.FindControl("chk_consignment") as CheckBox).Checked ? 1 : 0);
                cmd.ExecuteNonQuery();
                con.Close();

                RadGrid1.DataBind();

                Label lblsuccess = new Label();
                lblsuccess.Text = "Data inserted successfully";
                lblsuccess.ForeColor = System.Drawing.Color.Blue;
                RadGrid1.Controls.Add(lblsuccess);


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
        protected void RadGrid1_DeleteCommand(object source, GridCommandEventArgs e)
        {
            UserControl userControl = (UserControl)e.Item.FindControl(GridEditFormItem.EditFormUserControlID);

            try
            {
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "update ms_product set stEdit = 4 where prod_code = @prod_code";
                cmd.Parameters.AddWithValue("@prod_code", RadGrid1.MasterTableView.Items[0].GetDataKeyValue("prod_code").ToString());
                cmd.ExecuteNonQuery();
                con.Close();

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
        private static DataTable GetUoM(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT unit_code, unit_name FROM ms_uom WHERE stEdit != '4' AND unit_name LIKE @text + '%'",
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
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["unit_name"].ToString(), data.Rows[i]["unit_name"].ToString()));
            }

            e.Message = GetStatusMessage(endOffset, data.Rows.Count);
        }
        private static DataTable GetBrand(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT brand_code, brand_name FROM ms_brand WHERE stEdit != '4' AND brand_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_brand_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetBrand(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
               (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["brand_name"].ToString(), data.Rows[i]["brand_name"].ToString()));
            }

            e.Message = GetStatusMessage(endOffset, data.Rows.Count);
        }
        private static DataTable GetCategory(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT kind_code, kind_name FROM ms_product_kind WHERE stEdit != '4' AND kind_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_category_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetCategory(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["kind_name"].ToString(), data.Rows[i]["kind_name"].ToString()));
            }

            e.Message = GetStatusMessage(endOffset, data.Rows.Count);
        }
        private static DataTable GetGroup(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT group_code, group_name FROM ms_product_group WHERE stEdit != '4' AND group_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_group_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetGroup(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["group_name"].ToString(), data.Rows[i]["group_name"].ToString()));
            }

            e.Message = GetStatusMessage(endOffset, data.Rows.Count);
        }
        protected void cb_st_main_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            // Load cb_st_main items
            (sender as RadComboBox).Items.Add("Stock and Value");
            (sender as RadComboBox).Items.Add("Only Stock");
            (sender as RadComboBox).Items.Add("Non Stock");
        }
        protected void cb_st_main_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadComboBox).Text == "Stock and Value")
            {
                (sender as RadComboBox).SelectedValue = "0";
            }
            else if ((sender as RadComboBox).Text == "Only Stock")
            {
                (sender as RadComboBox).SelectedValue = "1";
            }
            else
            {
                (sender as RadComboBox).SelectedValue = "2";
            }
        }
        protected void cb_uom_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT unit_code FROM ms_uom WHERE unit_name = '" + (sender as RadComboBox).Text + "'";
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
            cmd.CommandText = "SELECT unit_code FROM ms_uom WHERE unit_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }
        protected void cb_brand_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT brand_code FROM ms_brand WHERE brand_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())

                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }
        protected void cb_brand_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT brand_code FROM ms_brand WHERE brand_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())

                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }
        protected void cb_category_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT kind_code FROM ms_product_kind WHERE kind_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }
        protected void cb_category_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT kind_code FROM ms_product_kind WHERE kind_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }
        protected void cb_group_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT group_code FROM ms_product_group WHERE group_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }
        protected void cb_group_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT group_code FROM ms_product_group WHERE group_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }
        protected void RadGrid1_ItemCreated(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridEditableItem & e.Item.IsInEditMode)
            {
                GridEditFormItem item = (GridEditFormItem)e.Item;
                TextBox txt = (item.FindControl("txt_material_code") as TextBox);
                if (e.Item.OwnerTableView.IsItemInserted)
                    txt.Enabled = true;
                else
                    txt.Enabled = false;
            }
        }

        protected void RadMultiPage1_PageViewCreated(object sender, RadMultiPageEventArgs e)
        {
            string userControlName = e.PageView.ID + "CS.ascx";

            Control userControl = Page.LoadControl(userControlName);
            userControl.ID = e.PageView.ID + "_userControl";

            e.PageView.Controls.Add(userControl);
        }

        protected void RadGridPageView1_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {

            (sender as RadGrid).DataSource = GetDataTablePageView(prod_code);
        }
        public DataTable GetDataTablePageView(string prod_code)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select ms_product_detail.KoLok, ms_product_detail.QACT, ms_warehouse.wh_name, ms_product_detail.wh_code, ms_product_detail.prod_code  from ms_product_detail, ms_warehouse " +
                              "where prod_code = '" + prod_code + "' and ms_product_detail.wh_code = ms_warehouse.wh_code";
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

        protected void btnRetrieve_Click(object sender, EventArgs e)
        {
            //GetDataTablePageView(string prod_code);
        }

        protected void RadGrid1_SelectedIndexChanged(object sender, EventArgs e)
        {
            //foreach (GridDataItem item in RadGrid1.SelectedItems)
            //{
            //    (item.FindControl("RadGridPageView1") as RadGrid).DataSource = GetDataTablePageView(item["prod_code"].Text);

            //}
        }

        private static string prod_code = null;
        protected void RadGrid1_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridEditableItem && e.Item.IsInEditMode)
            {
                GridEditableItem item = (GridEditableItem)e.Item;
                RadGrid grid = (RadGrid)item.FindControl("RadGridPageView1");
                grid.DataSource = GetDataTablePageView((item.FindControl("txt_material_code") as TextBox).Text);

                
            }
        }

        protected void RadGrid1_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                GridDataItem item = e.Item as GridDataItem;
                string kode = item["prod_code"].Text;
                prod_code = kode;
            }
        }

        protected void btn_new_Click(object sender, EventArgs e)
        {
            RadGrid1.MasterTableView.IsItemInserted = true;
            RadGrid1.MasterTableView.Rebind();
        }
    }
}        