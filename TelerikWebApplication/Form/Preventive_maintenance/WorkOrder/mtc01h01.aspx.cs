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

namespace TelerikWebApplication.Form.Preventive_maintenance.WorkOrder
{
    public partial class mtc01h01 : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();

        private const int ItemsPerRequest = 10;
        public static string tr_code = null;
        public static string wo_code = null;
        public static string selected_project = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lbl_form_name.Text = "Work Order";
                dtp_from.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
                dtp_to.SelectedDate = DateTime.Now;
                selected_project = public_str.site;
                cb_proj_prm.SelectedValue = public_str.site;
                cb_proj_prm.Text = public_str.sitename;

                tr_code = null;
                Session["action"] = "firstLoad";


            }
            
        }
        protected void RadAjaxManager1_AjaxRequest(object sender, AjaxRequestEventArgs e)
        {
            try
            {
                if (e.Argument == "Rebind")
                {
                    RadGrid1.MasterTableView.SortExpressions.Clear();
                    RadGrid1.MasterTableView.GroupByExpressions.Clear();
                    RadGrid1.Rebind(); /* Kemudian RadGrid1 akan sorting data by lastupdate (lihat sp_get_purchase_requestH*/
                    RadGrid1.MasterTableView.Items[0].Selected = true;

                }
                else if (e.Argument == "RebindAndNavigate")
                {
                    RadGrid1.MasterTableView.SortExpressions.Clear();
                    RadGrid1.MasterTableView.GroupByExpressions.Clear();
                    RadGrid1.DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), selected_project);
                    RadGrid1.DataBind();
                    RadGrid1.MasterTableView.CurrentPageIndex = RadGrid1.MasterTableView.PageCount - 1;
                    RadGrid1.MasterTableView.Items[RadGrid1.Items.Count - 1].Selected = true;
                    
                    //RadGrid2.DataSource = GetDataDetailTable(tr_code);
                    RadGrid2.Rebind();
                    Session["action"] = "list";
                }
            }
            catch (Exception ex)
            {
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
            }
        }

        #region project param
        private static DataTable GetProjectPrm(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT region_code, region_name FROM inv00h09 WHERE stEdit != 4 AND region_name LIKE @text + '%' UNION SELECT 'ALL','ALL'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }

        protected void cb_proj_prm_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
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

        protected void cb_proj_prm_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
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

        protected void RadGrid1_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            RadGrid1.DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), selected_project);
        }
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
            cmd.CommandText = "sp_get_work_orderH";
            cmd.Parameters.AddWithValue("@date", fromDate);
            cmd.Parameters.AddWithValue("@todate", toDate);
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
       
        public DataTable GetOperation(string trans_id)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT  chart_code ,  trans_id , formula, mtc00h25.OprName FROM mtc01h03, mtc00h25 WHERE mtc00h25.OprCode = mtc01h03.chart_code AND trans_id = @trans_id";
            cmd.Parameters.AddWithValue("@trans_id", trans_id);
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
        public DataTable GetManpowerService(string trans_id)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT work_date, time_tot, price, time_start, time_finish, sub_price, trans_id, chart_code, employee_code, adj_tot, " +
                "remark FROM mtc01h05 WHERE trans_id = @trans_id";
            cmd.Parameters.AddWithValue("@trans_id", trans_id);
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
            var trans_id = ((GridDataItem)e.Item).GetDataKeyValue("trans_id");

            try
            {
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "UPDATE mtc01h01 SET userid = @userid, lastupdate = GETDATE(), void = '4' WHERE (trans_id = @trans_id)";
                cmd.Parameters.AddWithValue("@trans_id", trans_id);
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
                //editLink.Attributes["onclick"] = String.Format("return ShowEditForm('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["trans_id"], e.Item.ItemIndex);

                ImageButton printLink = (ImageButton)e.Item.FindControl("PrintLink");
                printLink.Attributes["href"] = "javascript:void(0);";
                printLink.Attributes["onclick"] = String.Format("return ShowPreview('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["trans_id"], e.Item.ItemIndex);

            }
        }
        protected void RadGrid1_SelectedIndexChanged(object sender, EventArgs e)
        {
            foreach (GridDataItem item in RadGrid1.SelectedItems)
            {
                tr_code = item["trans_id"].Text;
            }

            populate_detail();
            Session["action"] = "list";
        }
        private void populate_detail()
        {
            if (tr_code == null)
            {
                RadGrid2.DataSource = new string[] { };
                RadGrid2.DataBind();
                RadGrid3.DataSource = new string[] { };
                RadGrid3.DataBind();
                RadGrid4.DataSource = new string[] { };
                RadGrid4.DataBind();
                RadGrid5.DataSource = new string[] { };
                RadGrid5.DataBind();
            }
            else
            {
                //populate_component(tr_code);
                RadGrid2.DataSource = GetDBMB(tr_code);
                RadGrid2.DataBind();
                RadGrid3.DataSource = GetExtService(tr_code);
                RadGrid3.DataBind();
                RadGrid4.DataSource = GetOperation(tr_code);
                RadGrid4.DataBind();
                RadGrid5.DataSource = GetMatrialRequest(tr_code);
                RadGrid5.DataBind();

            }

        }
        //private void populate_component(string id)
        //{
        //    try
        //    {
        //        con.Open();
        //        SqlCommand cmd = new SqlCommand();
        //        cmd.Connection = con;
        //        cmd.CommandType = CommandType.Text;
        //        cmd.CommandText = "SELECT com_group, com_group_name, com_code, com_name, DIAG_CODE, diag_remark, sym_code, sym_name, remark " +
        //            "FROM v_work_orderH WHERE trans_id = '" + id + "'";

        //        SqlDataAdapter adapter = new SqlDataAdapter(cmd);
        //        DataTable dt = new DataTable();
        //        adapter.Fill(dt);
        //        foreach (DataRow dtr in dt.Rows)
        //        {
        //            cb_compGroup.SelectedValue = dtr["com_group"].ToString();
        //            cb_compGroup.Text = dtr["com_group_name"].ToString();
        //            cb_comp.SelectedValue = dtr["com_code"].ToString();
        //            cb_comp.Text = dtr["com_name"].ToString();
        //            cb_diagnosis.SelectedValue = dtr["DIAG_CODE"].ToString();
        //            cb_diagnosis.Text = dtr["diag_remark"].ToString();
        //            cb_symptom.SelectedValue = dtr["sym_code"].ToString();
        //            cb_symptom.Text = dtr["sym_name"].ToString();
        //            txt_jobDesc.Text = dtr["remark"].ToString();
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

        

        protected void RadGrid4_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            if (tr_code == null)
            {
                (sender as RadGrid).DataSource = new string[] { };
            }
            else
            {
                (sender as RadGrid).DataSource = GetOperation(tr_code);
            }
        }       
        
        protected void RadGrid1_NeedDataSource1(object sender, GridNeedDataSourceEventArgs e)
        {
            RadGrid1.DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), cb_proj_prm.SelectedValue);

        }
        protected void cb_operation_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {            
            string sql = "SELECT OprCode, OprName  FROM mtc00h25 WHERE stEdit != 4 AND OprName LIKE @text + '%'";
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
                item.Text = row["OprName"].ToString();
                item.Value = row["OprCode"].ToString();
                item.Attributes.Add("OprName", row["OprName"].ToString());

                comboBox.Items.Add(item);

                item.DataBind();
            }
        }
        protected void cb_operation_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "SELECT OprCode FROM mtc00h25 WHERE OprName = '" + (sender as RadComboBox).Text + "'";

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                foreach (DataRow dtr in dt.Rows)
                {
                    RadComboBox cb = (RadComboBox)sender;
                    GridEditableItem item = (GridEditableItem)cb.NamingContainer;
                    Label lbl_chart_code = (Label)item.FindControl("lbl_chart_code");

                    lbl_chart_code.Text = dtr["OprCode"].ToString();
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
        protected void cb_MR_operation_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            string sql = "SELECT mtc01h03.chart_code, mtc00h25.OprName  FROM mtc00h25, mtc01h03 WHERE mtc01h03.trans_id= @trans_id AND mtc00h25.OprCode= mtc01h03.chart_code AND mtc00h25.OprName LIKE @text + '%'";
            SqlDataAdapter adapter = new SqlDataAdapter(sql,
                ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@trans_id", tr_code);
            adapter.SelectCommand.Parameters.AddWithValue("@text", e.Text);

            DataTable dt = new DataTable();
            adapter.Fill(dt);

            RadComboBox comboBox = (RadComboBox)sender;
            // Clear the default Item that has been re-created from ViewState at this point.
            comboBox.Items.Clear();

            foreach (DataRow row in dt.Rows)
            {
                RadComboBoxItem item = new RadComboBoxItem();
                item.Text = row["OprName"].ToString();
                item.Value = row["chart_code"].ToString();
                item.Attributes.Add("OprName", row["OprName"].ToString());

                comboBox.Items.Add(item);

                item.DataBind();
            }
        }
        protected void cb_MR_operation_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "SELECT OprCode FROM mtc00h25 WHERE OprName = '" + (sender as RadComboBox).Text + "'";
                
                SqlDataReader dr;
                dr = cmd.ExecuteReader();
                while (dr.Read())
                    (sender as RadComboBox).SelectedValue = dr["OprCode"].ToString();
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
        protected void RadGrid4_InsertCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                con.Open();
                GridEditableItem item = (GridEditableItem)e.Item;
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "INSERT INTO mtc01h03 (chart_code, trans_id, formula) VALUES (@chart_code,@trans_id,@formula)";
                cmd.Parameters.AddWithValue("@trans_id", tr_code);
                cmd.Parameters.AddWithValue("@chart_code", (item.FindControl("lbl_chart_code") as Label).Text);
                cmd.Parameters.AddWithValue("@formula", "0");

                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                con.Close();
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
                e.Canceled = true;
            }
            finally
            {
                con.Close();

            }
        }
        protected void RadGrid4_UpdateCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                con.Open();
                GridEditableItem item = (GridEditableItem)e.Item;
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "UPDATE mtc01h03 SET formula = @formula WHERE trans_id = @trans_id AND chart_code = @chart_code ";
                cmd.Parameters.AddWithValue("@trans_id", tr_code);
                cmd.Parameters.AddWithValue("@chart_code", (item.FindControl("lbl_chart_code") as Label).Text);
                cmd.Parameters.AddWithValue("@formula", "0");

                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                con.Close();
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
                e.Canceled = true;
            }
            finally
            {
                con.Close();
            }
        }
        protected void RadGrid4_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                con.Open();
                GridEditableItem item = (GridEditableItem)e.Item;
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "DELETE mtc01h03 WHERE trans_id = @trans_id AND chart_code = @chart_code ";
                cmd.Parameters.AddWithValue("@trans_id", tr_code);
                cmd.Parameters.AddWithValue("@chart_code", (item.FindControl("lbl_chart_code") as Label).Text);

                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                con.Close();
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
                e.Canceled = true;
            }
            finally
            {
                con.Close();
            }
        }
        
        #region Material Request
        public DataTable GetMatrialRequest(string trans_id)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT sro_code, prod_type, part_code, part_desc, part_qty, part_unit, deliv_date, CAST(tWarranty AS Bit) AS tWarranty, " +
                "remark, sro_code, trans_id, chart_code, mtc00h25.OprName FROM inv01d02, mtc00h25  WHERE trans_id = @trans_id AND mtc00h25.OprCode=inv01d02.chart_code";
            cmd.Parameters.AddWithValue("@trans_id", trans_id);
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
        protected void RadGrid5_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            if (tr_code == null)
            {
                (sender as RadGrid).DataSource = new string[] { };
            }
            else
            {
                (sender as RadGrid).DataSource = GetMatrialRequest(tr_code);
            }
        }

        protected void cb_prod_code_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            string sql = "SELECT TOP (100)[prod_code], [spec], [unit] FROM [inv00h01]  WHERE stEdit != '4' AND spec LIKE @spec + '%'";
            SqlDataAdapter adapter = new SqlDataAdapter(sql,
                ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@spec", e.Text);

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
                item.Attributes.Add("unit", row["unit"].ToString());

                comboBox.Items.Add(item);

                item.DataBind();
            }
        }

        protected void cb_prod_code_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "SELECT spec,unit FROM inv00h01 WHERE prod_code = '" + (sender as RadComboBox).SelectedValue + "'";

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                foreach (DataRow dtr in dt.Rows)
                {
                    RadComboBox cb = (RadComboBox)sender;
                    GridEditableItem item = (GridEditableItem)cb.NamingContainer;

                    RadNumericTextBox lblQtyRs;
                    Label lbl_UoM;
                    Label lbl_prodType;
                    RadNumericTextBox txtPartQty;

                    if (RadGrid3.MasterTableView.IsItemInserted)
                    {
                        lbl_prodType = (Label)item.FindControl("lbl_prodType_insertTemp");
                        txtPartQty = (RadNumericTextBox)item.FindControl("txt_qty_insertTemp");
                        lblQtyRs = (RadNumericTextBox)item.FindControl("txt_qtyRs_insertTemp");
                        lbl_UoM = (Label)item.FindControl("lbl_UoM_insertTemp");
                    }
                    else
                    {
                        lbl_prodType = (Label)item.FindControl("lbl_prodType_editTemp");
                        txtPartQty = (RadNumericTextBox)item.FindControl("txt_qty_editTemp");
                        lblQtyRs = (RadNumericTextBox)item.FindControl("txt_qtyRs_editTemp");
                        lbl_UoM = (Label)item.FindControl("lbl_UoM_editTemp");
                    }

                    lbl_prodType.Text = "M1";
                    lblQtyRs.Text = "0";
                    lbl_UoM.Text = dtr["unit"].ToString();
                    txtPartQty.Value = 0;
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

        #region eksternal Service
        public DataTable GetExtService(string trans_id)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT trans_date, mtc01h04.sup_code, mtc01h04.sup_code, pur00h01.supplier_name, description, price, trans_id " +
                                "FROM mtc01h04, pur00h01 WHERE mtc01h04.sup_code=pur00h01.supplier_code AND trans_id = @trans_id";
            cmd.Parameters.AddWithValue("@trans_id", trans_id);
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
            if (tr_code == null)
            {
                (sender as RadGrid).DataSource = new string[] { };
            }
            else
            {
                (sender as RadGrid).DataSource = GetExtService(tr_code);
            }
        }
        protected void RadGrid3_InsertCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                con.Open();
                GridEditableItem item = (GridEditableItem)e.Item;
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "INSERT INTO mtc01h04 (trans_id, sup_code, description, trans_date, price) " +
                "VALUES(@trans_id, @sup_code, @description, @trans_date, @price)";
                cmd.Parameters.AddWithValue("@trans_id", tr_code);
                cmd.Parameters.AddWithValue("@sup_code", (item.FindControl("lbl_SupCode") as Label).Text);
                cmd.Parameters.AddWithValue("@description", (item.FindControl("txt_description") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@trans_date", (item.FindControl("dtpDate") as RadDatePicker).SelectedDate);
                cmd.Parameters.AddWithValue("@price", (item.FindControl("txt_rate") as RadTextBox).Text);

                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                con.Close();
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
                e.Canceled = true;
            }
            finally
            {
                con.Close();

            }
        }
        protected void RadGrid3_UpdateCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                con.Open();
                GridEditableItem item = (GridEditableItem)e.Item;
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "UPDATE mtc01h04 SET description = @description, trans_date = @trans_date, price = @price " +
                "WHERE trans_id = @trans_id AND sup_code = @sup_code";
                cmd.Parameters.AddWithValue("@trans_id", tr_code);
                cmd.Parameters.AddWithValue("@sup_code", (item.FindControl("lbl_SupCode") as Label).Text);
                cmd.Parameters.AddWithValue("@description", (item.FindControl("txt_description") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@trans_date", (item.FindControl("dtpDate") as RadDatePicker).SelectedDate);
                cmd.Parameters.AddWithValue("@price", (item.FindControl("txt_rate") as RadTextBox).Text);

                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                con.Close();
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
                e.Canceled = true;
            }
            finally
            {
                con.Close();

            }
        }
        protected void RadGrid3_EditCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                con.Open();
                GridEditableItem item = (GridEditableItem)e.Item;
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "UPDATE mtc01h04 SET description = @description, trans_date = @trans_date, price = @price " +
                "WHERE trans_id = @trans_id AND sup_code = @sup_code";
                cmd.Parameters.AddWithValue("@trans_id", tr_code);
                cmd.Parameters.AddWithValue("@sup_code", (item.FindControl("cb_supplier") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@description", (item.FindControl("txt_description") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@trans_date", (item.FindControl("dtpDate") as RadDatePicker).SelectedDate);
                cmd.Parameters.AddWithValue("@price", (item.FindControl("txt_rate") as RadTextBox).Text);

                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                con.Close();
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
                e.Canceled = true;
            }
            finally
            {
                con.Close();

            }
        }
        protected void RadGrid3_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                con.Open();
                GridEditableItem item = (GridEditableItem)e.Item;
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "DELETE mtc01h04 WHERE trans_id = @trans_id AND sup_code = @sup_code";
                cmd.Parameters.AddWithValue("@trans_id", tr_code);
                cmd.Parameters.AddWithValue("@sup_code", (item.FindControl("cb_supplier") as RadComboBox).SelectedValue);

                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                con.Close();
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
                e.Canceled = true;
            }
            finally
            {
                con.Close();

            }

        }
        protected void cb_supplier_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            string sql = "SELECT supplier_code, supplier_name FROM pur00h01 WHERE stEdit != 4 AND supplier_name LIKE @text + '%'";
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
                item.Text = row["supplier_name"].ToString();
                item.Value = row["supplier_code"].ToString();
                item.Attributes.Add("supplier_name", row["supplier_name"].ToString());

                comboBox.Items.Add(item);

                item.DataBind();
            }
        }
        protected void cb_supplier_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "SELECT supplier_code FROM pur00h01 WHERE supplier_name = '" + (sender as RadComboBox).Text + "'";
                SqlDataReader dr;
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    //(sender as RadComboBox).SelectedValue = dr[0].ToString();
                    RadComboBox ntb = (RadComboBox)sender;
                    GridEditableItem item = (GridEditableItem)ntb.NamingContainer;

                    Label lbl_supp_code = (Label)item.FindControl("lbl_SupCode");
                    lbl_supp_code.Text = dr[0].ToString();
                }
                    
                dr.Close();

            }
            catch (Exception ex)
            {
                con.Close();
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
            }
            finally
            {
                con.Close();

            }

        }

        #endregion

        #region DMBD
        protected void RadGrid2_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            if (tr_code == null)
            {
                (sender as RadGrid).DataSource = new string[] { };
            }
            else
            {
                (sender as RadGrid).DataSource = GetDBMB(tr_code);
            }
        }
        public DataTable GetDBMB(string trans_id)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT down_date, CONVERT(time, REPLACE(down_time, '.', ':'), 110) AS down_time, CONVERT(time, REPLACE(down_act, '.', ':'), 110) AS down_act,  " +
                "CONVERT(time, REPLACE(down_up, '.', ':'), 110) AS down_up, remark_activity, remark, trans_id, tot_time_down, run_num, tot_time_num, esti_date, " +
                "esti_time, no_part, part_item, part_date, part_eta, status FROM mtc01d01 WHERE  trans_id = @trans_id";
            cmd.Parameters.AddWithValue("@trans_id", trans_id);
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
        
        protected void RadGrid2_InsertCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                con.Open();
                GridEditableItem item = (GridEditableItem)e.Item;
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "INSERT INTO mtc01d01 ( down_date, down_time, down_act, down_up, remark_activity, trans_id, tot_time_down, status )  " +
                                    "VALUES (@down_date,@down_time,@down_act,@down_up,@remark_activity,@trans_id,@down_up - @down_time,@status)";
                cmd.Parameters.AddWithValue("@trans_id", tr_code);
                cmd.Parameters.AddWithValue("@down_date", (item.FindControl("trans_date_edt") as RadDatePicker).SelectedDate);
                cmd.Parameters.AddWithValue("@down_time", Convert.ToDouble((item.FindControl("rtp_breakdownTime") as RadTimePicker).SelectedDate.Value.TimeOfDay.Hours) +
                (Convert.ToDouble((item.FindControl("rtp_breakdownTime") as RadTimePicker).SelectedDate.Value.TimeOfDay.Minutes) * 1 / 100));
                //cmd.Parameters.AddWithValue("@down_time", (item.FindControl("rtp_breakdownTime") as RadTimePicker).SelectedDate);
                cmd.Parameters.AddWithValue("@down_act", Convert.ToDouble((item.FindControl("rtp_breakdownAct") as RadTimePicker).SelectedDate.Value.TimeOfDay.Hours) +
                (Convert.ToDouble((item.FindControl("rtp_breakdownAct") as RadTimePicker).SelectedDate.Value.TimeOfDay.Minutes) * 1 / 100));
                //cmd.Parameters.AddWithValue("@down_act", (item.FindControl("rtp_breakdownAct") as RadTimePicker).SelectedDate);
                cmd.Parameters.AddWithValue("@down_up", Convert.ToDouble((item.FindControl("rtp_breakdownUp") as RadTimePicker).SelectedDate.Value.TimeOfDay.Hours) +
                (Convert.ToDouble((item.FindControl("rtp_breakdownUp") as RadTimePicker).SelectedDate.Value.TimeOfDay.Minutes) * 1 / 100));
                //cmd.Parameters.AddWithValue("@down_up", (item.FindControl("rtp_breakdownUp") as RadTimePicker).SelectedDate);
                cmd.Parameters.AddWithValue("@remark_activity", (item.FindControl("txt_remark") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@status", (item.FindControl("cb_bd_status") as RadComboBox).Text);

                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                con.Close();
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
                e.Canceled = true;
            }
            finally
            {
                con.Close();

            }
        }

        protected void RadGrid2_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                con.Open();
                GridEditableItem item = (GridEditableItem)e.Item;
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "DELETE mtc01d01 WHERE trans_id = @trans_id AND status = @status  AND down_date = @down_date " +
                    "AND down_time = (SELECT CAST(LEFT(@down_time,2)+'.'+SUBSTRING(@down_time,4,2) AS numeric(10,2)))";
                cmd.Parameters.AddWithValue("@trans_id", tr_code);
                cmd.Parameters.AddWithValue("@status", (item.FindControl("lbl_status") as Label).Text);
                cmd.Parameters.AddWithValue("@down_date", (item.FindControl("trans_date") as RadDatePicker).SelectedDate);
                cmd.Parameters.AddWithValue("@down_time", (item.FindControl("lbl_down_time") as Label).Text);

                cmd.ExecuteNonQuery();

                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "DELETE mtc01h03 WHERE trans_id = @trans_id AND chart_code = @status  AND down_date = @down_date " +
                    "AND down_time = (SELECT CAST(LEFT(@down_time,2)+'.'+SUBSTRING(@down_time,4,2) AS numeric(10,2)))";
                cmd.Parameters.AddWithValue("@trans_id", tr_code);
                cmd.Parameters.AddWithValue("@status", (item.FindControl("lbl_status") as Label).Text);
                cmd.Parameters.AddWithValue("@down_date", (item.FindControl("trans_date") as RadDatePicker).SelectedDate);
                cmd.Parameters.AddWithValue("@down_time", (item.FindControl("lbl_down_time") as Label).Text);

                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                con.Close();
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
                e.Canceled = true;
            }
            finally
            {
                con.Close();

            }
        }
        protected void cb_bd_status_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            string sql = "SELECT wo_status, wo_desc, mType, remark FROM mtc00h19 WHERE(mType NOT IN('0', '4')) AND wo_desc LIKE @text +'%'";
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
                item.Text = row["wo_status"].ToString();
                item.Value = row["wo_status"].ToString();
                item.Attributes.Add("wo_desc", row["wo_desc"].ToString());
                item.Attributes.Add("remark", row["remark"].ToString());

                comboBox.Items.Add(item);

                item.DataBind();
            }
        }
        protected void RadGrid2_UpdateCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                con.Open();
                GridEditableItem item = (GridEditableItem)e.Item;
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "UPDATE mtc01d01 SET down_act = @down_act, down_up = @down_up, remark_activity = @remark_activity, tot_time_down = @down_up - @down_time " +
                                    "WHERE  (trans_id = @trans_id) AND (down_date = @down_date) AND (down_time = @down_time)";
                cmd.Parameters.AddWithValue("@trans_id", tr_code);
                cmd.Parameters.AddWithValue("@down_date", (item.FindControl("trans_date_edt") as RadDatePicker).SelectedDate);
                cmd.Parameters.AddWithValue("@down_time", Convert.ToDouble((item.FindControl("rtp_breakdownTime") as RadTimePicker).SelectedDate.Value.TimeOfDay.Hours) +
                (Convert.ToDouble((item.FindControl("rtp_breakdownTime") as RadTimePicker).SelectedDate.Value.TimeOfDay.Minutes) * 1 / 100));
                cmd.Parameters.AddWithValue("@down_act", Convert.ToDouble((item.FindControl("rtp_breakdownAct") as RadTimePicker).SelectedDate.Value.TimeOfDay.Hours) +
                (Convert.ToDouble((item.FindControl("rtp_breakdownAct") as RadTimePicker).SelectedDate.Value.TimeOfDay.Minutes) * 1 / 100));
                cmd.Parameters.AddWithValue("@down_up", Convert.ToDouble((item.FindControl("rtp_breakdownUp") as RadTimePicker).SelectedDate.Value.TimeOfDay.Hours) +
                (Convert.ToDouble((item.FindControl("rtp_breakdownUp") as RadTimePicker).SelectedDate.Value.TimeOfDay.Minutes) * 1 / 100));
                cmd.Parameters.AddWithValue("@remark_activity", (item.FindControl("txt_remark") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@status", (item.FindControl("cb_bd_status") as RadComboBox).Text);

                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                con.Close();
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
                e.Canceled = true;
            }
            finally
            {
                con.Close();

            }
        }
        #endregion

        protected void btnNew_Click(object sender, ImageClickEventArgs e)
        {
            RadGrid1.MasterTableView.IsItemInserted = true;
            RadGrid1.MasterTableView.Rebind();

            //RadTabStrip1.Enabled = false;
        }

        protected void RadGrid5_InsertCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                GridEditableItem item = (GridEditableItem)e.Item;
                RadNumericTextBox lblQtyRs;
                Label lbl_UoM;
                Label lbl_prodType;
                RadNumericTextBox txtPartQty;
                RadComboBox cbProdCode;
                RadComboBox cbChart;
                CheckBox chkWaranty;
                RadTextBox txtRemark;
                Label lblChart;

                if (RadGrid3.MasterTableView.IsItemInserted)
                {
                    lbl_prodType = (Label)item.FindControl("lbl_prodType_insertTemp");
                    txtPartQty = (RadNumericTextBox)item.FindControl("txt_qty_insertTemp");
                    lblQtyRs = (RadNumericTextBox)item.FindControl("txt_qtyRs_insertTemp");
                    lbl_UoM = (Label)item.FindControl("lbl_UoM_insertTemp");
                    cbProdCode = (RadComboBox)item.FindControl("cb_prod_code_insertTemp");
                    //cbChart = (RadComboBox)item.FindControl("cb_operation_insertTemp");
                    chkWaranty = (CheckBox)item.FindControl("chk_waranty_insertTemp");
                    txtRemark = (RadTextBox)item.FindControl("txt_remark_insertTemp");
                }
                else
                {
                    lbl_prodType = (Label)item.FindControl("lbl_prodType_editTemp");
                    txtPartQty = (RadNumericTextBox)item.FindControl("txt_qty_editTemp");
                    lblQtyRs = (RadNumericTextBox)item.FindControl("txt_qtyRs_editTemp");
                    lbl_UoM = (Label)item.FindControl("lbl_UoM_editTemp");
                    cbProdCode = (RadComboBox)item.FindControl("cb_prod_code_editTemp");
                    cbChart = (RadComboBox)item.FindControl("cb_operation");
                    chkWaranty = (CheckBox)item.FindControl("chk_waranty_editTemp");
                    txtRemark = (RadTextBox)item.FindControl("txt_remark_editTemp");
                    lblChart = (Label)item.FindControl("lbl_operation");
                }

                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_save_material_requestD";
                cmd.Parameters.AddWithValue("@prod_type", lbl_prodType.Text);
                cmd.Parameters.AddWithValue("@item", DBNull.Value);
                cmd.Parameters.AddWithValue("@part_qty", Convert.ToDouble(txtPartQty.Text));
                cmd.Parameters.AddWithValue("@sro_code", tr_code);
                cmd.Parameters.AddWithValue("@part_code", cbProdCode.Text);
                cmd.Parameters.AddWithValue("@part_unit", lbl_UoM.Text);
                //cmd.Parameters.AddWithValue("@chart_code", chartCode_selected);
                cmd.Parameters.AddWithValue("@trans_id", wo_code);
                cmd.Parameters.AddWithValue("@deliv_date", DBNull.Value);
                if (chkWaranty.Checked == true)
                {
                    cmd.Parameters.AddWithValue("@tWarranty", 1);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@tWarranty", 0);
                }
                cmd.Parameters.AddWithValue("@remark", txtRemark.Text);
                cmd.ExecuteNonQuery();


                //notif.Show();

            }
            catch (Exception ex)
            {
                con.Close();
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
                e.Canceled = true;
            }
            finally
            {
                con.Close();
                //RadGrid3.DataSource = GetDataDetailByChartCode(txt_mr_number.Text, chart_code);
                //RadGrid3.DataBind();
            }
        }

        protected void RadGrid5_EditCommand(object sender, GridCommandEventArgs e)
        {

        }

        protected void RadGrid5_DeleteCommand(object sender, GridCommandEventArgs e)
        {

        }
    }
}