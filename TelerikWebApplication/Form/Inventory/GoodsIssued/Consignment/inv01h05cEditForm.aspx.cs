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

namespace TelerikWebApplication.Form.Inventory.GoodsIssued.Consignment
{
    public partial class inv01h05cEditForm : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();

        private const int ItemsPerRequest = 10;
        public static string sp_code = null; 

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                dtp_date.SelectedDate = DateTime.Now;
                sp_code = null;

                if (Request.QueryString["do_code"] != null)
                {
                    fill_object(Request.QueryString["do_code"].ToString());
                    RadGrid2.DataSource = GetDataDetailTable(Request.QueryString["do_code"].ToString());
                    Session["actionEdit"] = "edit";
                }
                else
                {
                    Session["actionEdit"] = "new";
                    cb_type_ref.Text = "Consumption";
                    cb_type_ref.SelectedValue = "6";
                }
            }
        }

        protected void fill_object(string id)
        {
            con.Open();
            SqlDataReader sdr;
            SqlCommand cmd = new SqlCommand("SELECT * FROM v_gi_consignment_list WHERE do_code = '" + id + "'", con);
            sdr = cmd.ExecuteReader();
            if (sdr.Read())
            {
                txt_gi_number.Text = sdr["do_code"].ToString();
                dtp_date.SelectedDate = Convert.ToDateTime(sdr["Tgl"].ToString());
                cb_Project.SelectedValue = sdr["region_code"].ToString();
                cb_Project.Text = sdr["region_name"].ToString();
                cb_CustSupp.SelectedValue = sdr["cust_code"].ToString();
                cb_CustSupp.Text = sdr["supplier_name"].ToString();
                cb_type_ref.SelectedValue = sdr["type_do"].ToString();
                cb_type_ref.Text = sdr["do_type"].ToString();
                cb_ref.SelectedValue = sdr["ref_code"].ToString();
                cb_ref.Text = sdr["ref_code"].ToString();
                txt_unit.Text = sdr["unit_code"].ToString();
                txt_remark.Text = sdr["remark"].ToString();
                cb_warehouse.Text = sdr["wh_name"].ToString();
                cb_warehouse.SelectedValue = sdr["wh_code"].ToString();
                cb_CostCenter.SelectedValue = sdr["dept_code"].ToString();
                cb_CostCenter.Text = sdr["dept_code"].ToString();
                txt_CostCenterName.Text = sdr["CostCenterName"].ToString();
                cb_receipt.Text = sdr["receivedBy_name"].ToString();
                cb_issued.Text = sdr["issuedby_name"].ToString();
                cb_approval.Text = sdr["approveBy_name"].ToString();
                cb_receipt.SelectedValue = sdr["receivedBy_id"].ToString();
                cb_issued.SelectedValue = sdr["issuedby_id"].ToString();
                cb_approval.SelectedValue = sdr["approveBy_id"].ToString();
                lbl_userId.Text = lbl_userId.Text + sdr["userid"].ToString();
                lbl_lastUpdate.Text = lbl_lastUpdate.Text + string.Format("{0:dd-MM-yyyy}", sdr["lastupdate"].ToString());
                lbl_Owner.Text = lbl_Owner.Text + sdr["Owner"].ToString();
                lbl_edited.Text = lbl_edited.Text + sdr["Edited"].ToString();
            }

            con.Close();
        }

        public DataTable GetDataRefDetailTable(string tr_code) 
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_consignment_refD";
            cmd.Parameters.AddWithValue("@reff_code", tr_code);
            cmd.Parameters.AddWithValue("@supplier_code", cb_CustSupp.SelectedValue);
            //cmd.Parameters.AddWithValue("@reff_code", cb_ref.SelectedValue);
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

        public DataTable GetDataDetailTable(string do_code)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_consigmentD";
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

        protected void RadGrid2_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            RadGrid2.DataSource = GetDataDetailTable(txt_gi_number.Text);
        }

        protected void RadGrid2_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            var prod_code = ((GridDataItem)e.Item).GetDataKeyValue("prod_code");

            try
            {
                GridEditableItem item = (GridEditableItem)e.Item;
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "delete from inv01d03 where prod_code = @prod_code and do_code = @do_code";
                cmd.Parameters.AddWithValue("@do_code", txt_gi_number.Text);
                cmd.Parameters.AddWithValue("@prod_code", prod_code);
                cmd.ExecuteNonQuery();
                con.Close();
                RadGrid2.DataBind();

                Label lblsuccess = new Label();
                lblsuccess.Text = "Data deleted";
                lblsuccess.ForeColor = System.Drawing.Color.DarkGray;
                RadGrid2.Controls.Add(lblsuccess);
            }
            catch (Exception ex)
            {
                con.Close();
                Label lblError = new Label();
                lblError.Text = "Unable to delete data. Reason: " + ex.Message;
                lblError.ForeColor = System.Drawing.Color.Red;
                RadGrid2.Controls.Add(lblError);
                e.Canceled = true;
            }
        }

        protected void btn_save_Click(object sender, EventArgs e)
        {
            long maxNo;
            string run = null;
            string trDate = string.Format("{0:dd/MM/yyyy}", dtp_date.SelectedDate);
            
            try
            {
                lblErrorDescription.Text = "";

                string x = dtp_date.SelectedDate.Value.ToString("MM");
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

                if (Session["actionEdit"].ToString() == "edit")
                {
                    run = txt_gi_number.Text;
                }
                else
                {
                    con.Open();
                    SqlDataReader sdr;
                    cmd = new SqlCommand("SELECT ISNULL ( MAX ( RIGHT ( inv01h05.do_code , 4 ) ) , 0 ) + 1 AS maxNo " +
                        "FROM inv01h05 WHERE LEFT(inv01h05.do_code, 4) = 'GI03' " +
                        "AND SUBSTRING(inv01h05.do_code, 5, 2) = SUBSTRING('" + trDate + "', 9, 2) " +
                        "AND SUBSTRING(inv01h05.do_code, 7, 2) = SUBSTRING('" + trDate + "', 4, 2) ", con);
                    sdr = cmd.ExecuteReader();
                    if (sdr.HasRows == false)
                    {
                        //throw new Exception();
                        run = "GI03" + dtp_date.SelectedDate.Value.Year + dtp_date.SelectedDate.Value.Month + "0001";
                    }
                    else if (sdr.Read())
                    {
                        maxNo = Convert.ToInt32(sdr[0].ToString());
                        run = "GI03" + (dtp_date.SelectedDate.Value.Year.ToString()).Substring(dtp_date.SelectedDate.Value.Year.ToString().Length - 2) +
                            ("0000" + dtp_date.SelectedDate.Value.Month).Substring(("0000" + dtp_date.SelectedDate.Value.Month).Length - 2, 2) +
                            ("0000" + maxNo).Substring(("0000" + maxNo).Length - 4, 4);
                    }
                    con.Close();
                }

                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_save_consignmentH";
                cmd.Parameters.AddWithValue("@do_code", run);
                cmd.Parameters.AddWithValue("@wh_code", cb_warehouse.SelectedValue);
                cmd.Parameters.AddWithValue("@to_wh_code", "NONE");
                cmd.Parameters.AddWithValue("@ref_code", cb_ref.SelectedValue);
                cmd.Parameters.AddWithValue("@range", 0);
                cmd.Parameters.AddWithValue("@cust_code", cb_CustSupp.SelectedValue);
                cmd.Parameters.AddWithValue("@type_do", cb_type_ref.SelectedValue);
                cmd.Parameters.AddWithValue("@sales_code", "NON");
                cmd.Parameters.AddWithValue("@Tgl", string.Format("{0:yyyy-MM-dd}", dtp_date.SelectedDate.Value));
                cmd.Parameters.AddWithValue("@lastupdate", DateTime.Today);
                cmd.Parameters.AddWithValue("@userid", public_str.user_id);
                cmd.Parameters.AddWithValue("@status_post", 0);
                cmd.Parameters.AddWithValue("@region_code", cb_Project.SelectedValue);
                cmd.Parameters.AddWithValue("@dept_code", cb_CostCenter.SelectedValue);
                cmd.Parameters.AddWithValue("@unit_code", txt_unit.Text);
                cmd.Parameters.AddWithValue("@CntrDoc", 1);
                cmd.Parameters.AddWithValue("@AppBy", cb_approval.SelectedValue);
                cmd.Parameters.AddWithValue("@OrdBy", cb_issued.SelectedValue);
                cmd.Parameters.AddWithValue("@FreBy", cb_receipt.SelectedValue);
                cmd.Parameters.AddWithValue("@type_out", "C");
                cmd.Parameters.AddWithValue("@remark", txt_remark.Text);
                cmd.Parameters.AddWithValue("@Lvl", public_str.level);
                cmd.Parameters.AddWithValue("@doc_type", 1);
                cmd.ExecuteNonQuery();

                foreach (GridDataItem item in RadGrid2.MasterTableView.Items)
                {
                    cmd = new SqlCommand();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Connection = con;
                    cmd.CommandText = "sp_save_goods_issued_consignmentD";
                    cmd.Parameters.AddWithValue("@do_code", run);
                    cmd.Parameters.AddWithValue("@prod_code", (item.FindControl("txt_ProdCode") as RadTextBox).Text);
                    cmd.Parameters.AddWithValue("@prod_code_ori", (item.FindControl("txt_ProdCode") as RadTextBox).Text);
                    cmd.Parameters.AddWithValue("@info_code", (item.FindControl("lblInfoRecord") as Label).Text);
                    cmd.Parameters.AddWithValue("@validdate", string.Format("{0:yyyy-MM-dd}", (item.FindControl("dtpValidDate") as RadDatePicker).SelectedDate));
                    cmd.Parameters.AddWithValue("@qty_out", Convert.ToDouble((item.FindControl("txt_Part_Qty") as RadTextBox).Text));
                    cmd.Parameters.AddWithValue("@unit_code", (item.FindControl("lblUom") as Label).Text);
                    cmd.Parameters.AddWithValue("@dept_code", cb_CostCenter.Text);
                    cmd.Parameters.AddWithValue("@type_out", "C");
                    cmd.Parameters.AddWithValue("@wh_code", cb_warehouse.SelectedValue);
                    //if ((item.FindControl("chkWarranty") as CheckBox).Checked == true)
                    //{
                    //    cmd.Parameters.AddWithValue("@twarranty", 1);
                    //}
                    //else
                    //{
                    //    cmd.Parameters.AddWithValue("@twarranty", 0);
                    //}
                    cmd.Parameters.AddWithValue("@twarranty", 0);
                    cmd.Parameters.AddWithValue("@remark", (item.FindControl("txtRemark") as RadTextBox).Text);
                    cmd.Parameters.AddWithValue("@date", DateTime.Now);
                    cmd.ExecuteNonQuery();
                }

                con.Close();
                notif.Text = "Data berhasil disimpan";
                notif.Title = "Notification";
                notif.Show();
                txt_gi_number.Text = run;

            }
            catch (Exception ex)
            {
                lblErrorDescription.Text = "Error: " + ex.Message.ToString();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "DELETE inv01h05 WHERE do_code = '" + run + "'";
                cmd.ExecuteNonQuery();
                con.Close();
                //Response.Write("<font color='red'>" + ex.Message + "</font>");
                //RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "");
                //RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn","");
            }
        }

        #region Type Reff
        protected void cb_type_ref_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            cb_type_ref.Items.Add("Consumption");
            cb_type_ref.Items.Add("Assembly");
        }

        protected void cb_type_ref_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if (cb_type_ref.Text == "Consumption")
            {
                cb_type_ref.SelectedValue = "6";
            }
            else if (cb_type_ref.Text == "Assembly")
            {
                cb_type_ref.SelectedValue = "7";
            }
        }

        protected void cb_type_ref_PreRender(object sender, EventArgs e)
        {
            if (cb_type_ref.Text == "Consumption")
            {
                cb_type_ref.SelectedValue = "6";
            }
            else if (cb_type_ref.Text == "Assembly")
            {
                cb_type_ref.SelectedValue = "7";
            }
        }

        #endregion 

        #region Type Project

        private static DataTable GetProject(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT region_code, region_name FROM inv00h09 WHERE stEdit != 4 AND region_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }

        protected void cb_Project_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
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

        protected void cb_Project_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
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
        protected void cb_Project_PreRender(object sender, EventArgs e)
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

        #region Cust/Sup
        private static DataTable GetCustSupp(string text, string project)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT  info_code, supplier_code , region_code , cur_code , type_info , supplier_name  " +
            "FROM inv01h06 WHERE (inv01h06.type_info = '2') and (inv01h06.region_code = @project) AND supplier_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);
            adapter.SelectCommand.Parameters.AddWithValue("@project", project);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_CustSupp_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetCustSupp(e.Text, cb_Project.SelectedValue);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                cb_CustSupp.Items.Add(new RadComboBoxItem(data.Rows[i]["supplier_name"].ToString(), data.Rows[i]["supplier_name"].ToString()));
            }
        }

        protected void cb_CustSupp_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT supplier_code FROM inv01h06 WHERE supplier_name = '" + cb_CustSupp.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                cb_CustSupp.SelectedValue = dr["supplier_code"].ToString();
            }
            dr.Close();
            con.Close();
        }

        protected void cb_CustSupp_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT supplier_code FROM inv01h06 WHERE supplier_name = '" + cb_CustSupp.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["supplier_code"].ToString();
            }
            dr.Close();
            con.Close();
        }

        #endregion

        #region Referrence

        private static DataTable GetReff(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select * from v_gi_reff WHERE doc_code LIKE @text + '%'",
             ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }

        protected void LoadRef(string doc_code, string projectID, string typeRef, RadComboBox cb)
        {
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            DataTable dt = new DataTable();

            if (typeRef == "Consumption")
            {
                SqlDataAdapter adapter = new SqlDataAdapter("SELECT doc_code, doc_remark FROM v_gi_reffConsigment " +
                "WHERE status_doc <> '4' AND region_code = @project AND doc_code LIKE @text + '%'", con);
                adapter.SelectCommand.Parameters.AddWithValue("@project", projectID);
                adapter.SelectCommand.Parameters.AddWithValue("@text", doc_code);
                //DataTable dt = new DataTable();
                adapter.Fill(dt);
            }
            else
            {
                SqlDataAdapter adapter = new SqlDataAdapter("SELECT doc_code, doc_remark FROM v_gi_reffStock " +
                "WHERE status_doc <> '4' AND region_code = @project AND doc_code LIKE @text + '%'", con);
                adapter.SelectCommand.Parameters.AddWithValue("@project", projectID);
                adapter.SelectCommand.Parameters.AddWithValue("@text", doc_code);
                //DataTable dt = new DataTable();
                adapter.Fill(dt);
            }


            cb.DataTextField = "doc_code";
            cb.DataValueField = "doc_code";
            cb.DataSource = dt;
            cb.DataBind();
        }

        protected void cb_ref_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadRef(e.Text, cb_Project.SelectedValue, cb_type_ref.Text, (sender as RadComboBox));
        }

        protected void cb_ref_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT doc_code FROM v_gi_reffConsigment WHERE doc_code = '" + (sender as RadComboBox).Text + "'";
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
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            SqlDataReader dr;
            if (cb_type_ref.Text == "Consumption")
            {
                cmd.CommandText = "SELECT * FROM v_gi_reffConsigment WHERE doc_code = '" + (sender as RadComboBox).SelectedValue + "'";
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    (sender as RadComboBox).Text = dr["doc_code"].ToString();
                    txt_unit.Text = dr["unit_code"].ToString();
                    cb_CostCenter.Text = dr["dept_code"].ToString();
                    txt_CostCenterName.Text = dr["CostCenterName"].ToString();
                    txt_remark.Text = dr["doc_remark"].ToString();
                }
            }
            else
            {
                cmd.CommandText = "SELECT * FROM v_gi_reffStock WHERE doc_code = '" + (sender as RadComboBox).SelectedValue + "'";
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    (sender as RadComboBox).Text = dr["doc_code"].ToString();
                    txt_unit.Text = dr["unit_code"].ToString();
                    cb_CostCenter.Text = dr["dept_code"].ToString();
                    txt_CostCenterName.Text = dr["CostCenterName"].ToString();
                    txt_remark.Text = dr["doc_remark"].ToString();
                }
            }

            dr.Close();
            con.Close();

            RadGrid2.DataSource = GetDataRefDetailTable((sender as RadComboBox).SelectedValue);
            RadGrid2.DataBind();
        }

        #endregion


        #region Storage Loc
        private static DataTable GetStorage(string text, string project)
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
            DataTable data = GetStorage(e.Text, cb_Project.SelectedValue);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                cb_warehouse.Items.Add(new RadComboBoxItem(data.Rows[i]["wh_name"].ToString(), data.Rows[i]["wh_name"].ToString()));
            }
        }

        protected void cb_warehouse_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT wh_code FROM inv00h05 WHERE wh_name = '" + cb_Project.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_warehouse.SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_warehouse_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT wh_code FROM inv00h05 WHERE wh_name = '" + cb_warehouse.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_warehouse.SelectedValue = dr[0].ToString();
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
        protected void cb_CostCenter_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadCostCtr(e.Text, cb_Project.SelectedValue, (sender as RadComboBox));
        }

        protected void cb_CostCenter_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT CostCenter FROM inv00h11 WHERE CostCenter = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_CostCenter_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT CostCenter FROM inv00h11 WHERE CostCenter = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
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
        protected void cb_receipt_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            cb_receipt.Text = "";
            LoadManPower(e.Text, cb_Project.SelectedValue, cb_receipt);
        }
        protected void cb_receipt_DataBound(object sender, EventArgs e)
        {
            ((Literal)cb_receipt.Footer.FindControl("RadComboItemsCount")).Text = Convert.ToString(cb_receipt.Items.Count);
        }

        protected void cb_receipt_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + cb_receipt.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_receipt.SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_receipt_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + cb_receipt.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_receipt.SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_issued_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            cb_issued.Text = "";
            LoadManPower(e.Text, cb_Project.SelectedValue, cb_issued);
        }
        protected void cb_issued_DataBound(object sender, EventArgs e)
        {
            ((Literal)cb_issued.Footer.FindControl("RadComboItemsCount")).Text = Convert.ToString(cb_issued.Items.Count);
        }

        protected void cb_issued_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + cb_issued.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_issued.SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_issued_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + cb_issued.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_issued.SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_approval_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            cb_approval.Text = "";
            LoadManPower(e.Text, cb_Project.SelectedValue, cb_approval);
        }

        protected void cb_approval_DataBound(object sender, EventArgs e)
        {
            ((Literal)cb_approval.Footer.FindControl("RadComboItemsCount")).Text = Convert.ToString(cb_approval.Items.Count);
        }

        protected void cb_approval_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + cb_approval.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_approval.SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_approval_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + cb_approval.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_approval.SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }





        #endregion

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
                //(sender as RadGrid).ClientSettings.Scrolling.UseStaticHeaders = true;
                (sender as RadGrid).ClientSettings.Scrolling.ScrollHeight = 295;
            }
        }

        protected void RadGrid3_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            if (Session["actionEdit"].ToString() == "edit")
            {
                (sender as RadGrid).DataSource = GetDataTable(txt_gi_number.Text);
            }
            else
            {
                (sender as RadGrid).DataSource = new string[] { };
            }
        }
        public DataTable GetDataTable(string doc_code)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_goods_issued_journal";
            cmd.Parameters.AddWithValue("@doc_code", doc_code);
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

        protected void RadGrid3_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadGrid).MasterTableView.Items.Count < (sender as RadGrid).MasterTableView.PageSize)
            {
                (sender as RadGrid).ClientSettings.Scrolling.AllowScroll = false;
                (sender as RadGrid).ClientSettings.Scrolling.UseStaticHeaders = false;
            }
        }
    }
}