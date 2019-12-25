using System;
using System.Collections.Generic;
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
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                RadGrid1.MasterTableView.EditMode = (GridEditMode)Enum.Parse(typeof(GridEditMode), "EditForms");

            }
        }

        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();
        public DataTable GetDataTable()
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT ms_product.brand_code, ms_product_group.group_name, ms_product_kind.kind_name, "+
                "ms_product.prod_code, ms_product.spec, ms_brand.brand_name, ms_product.kind_code, ms_product.unit, "+
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
            UserControl userControl = (UserControl)e.Item.FindControl(GridEditFormItem.EditFormUserControlID);
            try
            {
                cmd = new SqlCommand("update ms_product set spec = @spec, unit = @unit, QtyMin = @Qtymin,  " +
                        "brand_code = @brand_code, group_code = @group_code, kind_code = @kind_code, " +
                        "stMain = CASE @stMain WHEN 'Stock and Value' THEN '1' WHEN 'Only Stock' THEN '2' ELSE '0' END , " +
                        "qtyminpur = @qtyminpur, SalesFore = @SalesFore, price_sale = @price_sale, tSN = @tSN,  " +
                        "tActive = @tActive, tWarranty = @tWarranty, tMonitor = @tMonitor, tConsig = @tConsig where prod_code = @prod_code", con);
                con.Open();
                cmd.Parameters.AddWithValue("@prod_code", (userControl.FindControl("txt_material_code") as TextBox).Text);
                cmd.Parameters.AddWithValue("@spec", (userControl.FindControl("txt_specification") as TextBox).Text);
                cmd.Parameters.AddWithValue("@unit", (userControl.FindControl("cb_uom") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@brand_code", (userControl.FindControl("cb_brand") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@group_code", (userControl.FindControl("cb_group") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@kind_code", (userControl.FindControl("cb_category") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@stMain", (userControl.FindControl("cb_st_main") as RadComboBox).Text);
                cmd.Parameters.AddWithValue("@QtyMin", Convert.ToDouble((userControl.FindControl("txt_min_stock") as TextBox).Text));
                cmd.Parameters.AddWithValue("@qtyminpur", Convert.ToDouble((userControl.FindControl("txt_min_purchase") as TextBox).Text));
                cmd.Parameters.AddWithValue("@SalesFore", Convert.ToDouble((userControl.FindControl("txt_sales_forecast") as TextBox).Text));
                cmd.Parameters.AddWithValue("@price_sale", Convert.ToDouble((userControl.FindControl("txt_selling_price") as TextBox).Text));
                cmd.Parameters.AddWithValue("@tSN", (userControl.FindControl("chk_use_serial_number") as RadCheckBox).Checked);
                cmd.Parameters.AddWithValue("@tActive", (userControl.FindControl("chk_active") as RadCheckBox).Checked);
                cmd.Parameters.AddWithValue("@tWarranty", (userControl.FindControl("chk_warranty") as RadCheckBox).Checked);
                cmd.Parameters.AddWithValue("@tMonitor", (userControl.FindControl("chk_monitoring_stock") as RadCheckBox).Checked);
                cmd.Parameters.AddWithValue("@tConsig", (userControl.FindControl("chk_consignment") as RadCheckBox).Checked);
                cmd.ExecuteNonQuery();
                con.Close();

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
            UserControl userControl = (UserControl)e.Item.FindControl(GridEditFormItem.EditFormUserControlID);

            try
            {
                cmd = new SqlCommand("insert into ms_product (prod_code, spec, unit, QtyMin, brand_code, group_code, kind_code, " +
                        "stMain, qtyminpur, SalesFore, price_sale, tSN, tActive, tWarranty, tMonitor, tConsig, stEdit) values " +
                        "(@prod_code, @spec, @unit, @Qtymin, @brand_code, @group_code,@kind_code, " +
                        "CASE @StMain WHEN 'Stock and value' THEN '0' WHEN 'Only Stock' THEN '1' ELSE '2' END, @qtyminpur, " +
                        "@SalesFore, @price_sale, @tSN, @tActive, @tWarranty, @tMonitor, @tConsig, '0')", con);
                con.Open();
                cmd.Parameters.AddWithValue("@prod_code", (userControl.FindControl("txt_material_code") as TextBox).Text);
                cmd.Parameters.AddWithValue("@spec", (userControl.FindControl("txt_specification") as TextBox).Text);
                cmd.Parameters.AddWithValue("@unit", (userControl.FindControl("cb_uom") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@brand_code", (userControl.FindControl("cb_brand") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@group_code", (userControl.FindControl("cb_group") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@kind_code", (userControl.FindControl("cb_category") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@stMain", (userControl.FindControl("cb_st_main") as RadComboBox).Text);
                cmd.Parameters.AddWithValue("@QtyMin", Convert.ToDouble((userControl.FindControl("txt_min_stock") as TextBox).Text));
                cmd.Parameters.AddWithValue("@qtyminpur", Convert.ToDouble((userControl.FindControl("txt_min_purchase") as TextBox).Text));
                cmd.Parameters.AddWithValue("@SalesFore", Convert.ToDouble((userControl.FindControl("txt_sales_forecast") as TextBox).Text));
                cmd.Parameters.AddWithValue("@price_sale", Convert.ToDouble((userControl.FindControl("txt_selling_price") as TextBox).Text));
                cmd.Parameters.AddWithValue("@tSN", (userControl.FindControl("chk_use_serial_number") as RadCheckBox).Checked);
                cmd.Parameters.AddWithValue("@tActive", (userControl.FindControl("chk_active") as RadCheckBox).Checked);
                cmd.Parameters.AddWithValue("@tWarranty", (userControl.FindControl("chk_warranty") as RadCheckBox).Checked);
                cmd.Parameters.AddWithValue("@tMonitor", (userControl.FindControl("chk_monitoring_stock") as RadCheckBox).Checked);
                cmd.Parameters.AddWithValue("@tConsig", (userControl.FindControl("chk_consignment") as RadCheckBox).Checked);
                cmd.ExecuteNonQuery();
                con.Close();

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

        //protected void ConfigureNotification(object sender, System.EventArgs args)
        //{
        //    //String
        //    RadNotification1.Title = this.Title.Text;
        //    RadNotification1.Text = this.Text.Text;
        //    RadNotification1.TitleIcon = this.titleIcon.SelectedValue;
        //    RadNotification1.ContentIcon = this.contentIcon.SelectedValue;
        //    RadNotification1.ShowSound = this.showSound.SelectedValue;

        //    //Enum
        //    RadNotification1.Position = (NotificationPosition)Enum.Parse(typeof(Telerik.Web.UI.NotificationPosition), this.Position.SelectedValue);
        //    RadNotification1.Animation = (NotificationAnimation)Enum.Parse(typeof(Telerik.Web.UI.NotificationAnimation), this.Animation.SelectedValue);
        //    RadNotification1.ContentScrolling = (NotificationScrolling)Enum.Parse(typeof(Telerik.Web.UI.NotificationScrolling), this.ContentScrolling.SelectedValue);

        //    //Unit
        //    RadNotification1.Width = this.Width.Text != string.Empty ? Unit.Parse(this.Width.Text) : RadNotification1.Width;
        //    RadNotification1.Height = this.Height.Text != string.Empty ? Unit.Parse(this.Height.Text) : RadNotification1.Height;

        //    //Integer
        //    RadNotification1.OffsetX = !Object.Equals(this.OffsetX.Value, null) ? int.Parse(this.OffsetX.Value.ToString()) : RadNotification1.OffsetX;
        //    RadNotification1.OffsetY = !Object.Equals(this.OffsetY.Value, null) ? int.Parse(this.OffsetY.Value.ToString()) : RadNotification1.OffsetY;
        //    RadNotification1.AutoCloseDelay = !Object.Equals(this.AutoCloseDelay.Value, null) ? int.Parse(this.AutoCloseDelay.Value.ToString()) : RadNotification1.AutoCloseDelay;
        //    RadNotification1.AnimationDuration = !Object.Equals(this.AnimationDuration.Value, null) ? int.Parse(this.AnimationDuration.Value.ToString()) : RadNotification1.AnimationDuration;
        //    RadNotification1.Opacity = int.Parse(this.opacity.Value.ToString());

        //    //Boolean
        //    RadNotification1.Pinned = this.Pinned.Checked;
        //    RadNotification1.EnableRoundedCorners = this.corners.Checked;
        //    RadNotification1.EnableShadow = this.shadow.Checked;
        //    RadNotification1.KeepOnMouseOver = this.keepMouse.Checked;
        //    RadNotification1.VisibleTitlebar = this.titlebar.Checked;
        //    RadNotification1.ShowCloseButton = this.closeBtn.Checked;
        //}

    }
}        