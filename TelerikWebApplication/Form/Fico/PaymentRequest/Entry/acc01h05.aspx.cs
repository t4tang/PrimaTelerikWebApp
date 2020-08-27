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

namespace TelerikWebApplication.Form.Fico.PaymentRequest.Entry
{
    public partial class acc01h05 : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();

        private const int ItemsPerRequest = 10;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                dtp_from.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
                dtp_to.SelectedDate = DateTime.Now;
                cb_project_prm.SelectedValue = public_str.site;
                cb_project_prm.Text = public_str.sitename;

                //set_info();
                dtp_doc.SelectedDate = DateTime.Now;
                Session["action"] = "firstLoad";
                btnSave.Enabled = false;
                btnSave.ImageUrl = "~/Images/simpan-gray.png";
                btnPrint.Enabled = false;
                btnPrint.ImageUrl = "~/Images/cetak-gray.png";                
            }
        }
        protected void btnNew_Click(object sender, ImageClickEventArgs e)
        {
            if (Session["action"].ToString() != "firstLoad")
            {
                clear_text(Page.Controls);
            }
            Session["action"] = "new";
            btnSave.Enabled = true;
            btnSave.ImageUrl = "~/Images/simpan.png";
            btnPrint.Enabled = false;
            btnPrint.ImageUrl = "~/Images/cetak-gray.png";
            set_info();
            rbl_status.SelectedValue = "0";
            dtp_doc.SelectedDate = DateTime.Now;
        }
        private void clear_text(ControlCollection ctrls)
        {
            foreach (Control ctrl in ctrls)
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

                dtp_from.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
                dtp_to.SelectedDate = DateTime.Now;
            }
        }
        private void set_info()
        {
            txt_uid.Text = public_str.uid;
            txt_lastUpdate.Text = string.Format("{0:dd/MM/yyyy hh:mm:ss}", DateTime.Now);
            txt_owner.Text = public_str.uid;
            txt_edited.Text = "0";
        }
        private static DataTable GetProjectPrm(string text)
        {
            //SqlDataAdapter adapter = new SqlDataAdapter("SELECT region_code, region_name FROM inv00h09 WHERE stEdit != 4 AND region_name LIKE @text + '%' UNION SELECT 'ALL','ALL'",
            //ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            //adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            string cmd;
            if (public_str.site != "HOF")
            {
                cmd = "SELECT a.region_code, b.region_name FROM inv00h26 a, inv00h09 b WHERE a.region_code=b.region_code AND a.Nik = '" + public_str.user_id + "' AND b.stEdit <> 4 AND b.region_name LIKE @text + '%' ";
            }
            else
            {
                cmd = "SELECT region_code, region_name FROM inv00h09  WHERE stEdit <> 4 AND region_name LIKE @text + '%' UNION SELECT 'ALL','ALL' ";
            }

            SqlDataAdapter adapter = new SqlDataAdapter(cmd, ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_project_prm_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
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
        private static DataTable GetProject(string text)
        {
            string cmd;
            if(public_str.site != "HOF")
            {
                cmd = "SELECT a.region_code, b.region_name FROM inv00h26 a, inv00h09 b WHERE a.region_code=b.region_code AND a.Nik = '" + public_str.user_id + "' AND b.stEdit <> 4 AND b.region_name LIKE @text + '%' ";
            }
            else
            {
                cmd= "SELECT region_code, region_name FROM inv00h09  WHERE stEdit <> 4 AND region_name LIKE @text + '%'";
            }

            SqlDataAdapter adapter = new SqlDataAdapter(cmd,ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
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
        protected void cb_cost_center_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetDepartment(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["dept_name"].ToString(), data.Rows[i]["dept_name"].ToString()));
            }

        }
        private static DataTable GetDepartment(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT dept_code, dept_name FROM inv00h10 WHERE stEdit != 4 AND dept_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_cost_center_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT dept_code FROM inv00h10 WHERE dept_name = '" + (sender as RadComboBox).Text + "'";
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
            cmd.CommandText = "SELECT dept_code FROM inv00h10 WHERE dept_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            RadGrid1.DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), cb_project_prm.SelectedValue);
            RadGrid1.DataBind();
        }
        protected void RadGrid1_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            (sender as RadGrid).DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), cb_project_prm.SelectedValue);
        }
        public DataTable GetDataTable(string fromDate, string toDate, string project)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_payment_request_entry";
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

        protected void RadGrid1_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            var doc_code = ((GridDataItem)e.Item).GetDataKeyValue("doc_no");

            try
            {
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "UPDATE acc01h05 SET userid = @Usr, lastupdate = GETDATE(), stEdit = '4' WHERE (doc_no = @doc_code)";
                cmd.Parameters.AddWithValue("@doc_code", doc_code);
                cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
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
        protected void btnOk_Click(object sender, EventArgs e)
        {
            foreach (GridDataItem item in RadGrid1.SelectedItems)
            {
                con.Open();
                SqlDataReader sdr;
                SqlCommand cmd = new SqlCommand("SELECT * FROM v_payment_requset_list WHERE doc_no = '" + item["doc_no"].Text + "'", con);
                sdr = cmd.ExecuteReader();
                if (sdr.Read())
                {
                    txt_doc_number.Text = sdr["doc_no"].ToString();
                    dtp_doc.SelectedDate = Convert.ToDateTime(sdr["doc_date"].ToString());
                    dtp_due_date.SelectedDate = Convert.ToDateTime(sdr["exp_date"].ToString());
                    txt_object.Text = sdr["objek"].ToString();
                    txt_amount.Value = Convert.ToDouble(sdr["amount"].ToString());
                    cb_project.Text = sdr["region_name"].ToString();
                    cb_cost_center.Text = sdr["dept_name"].ToString();
                    txt_pay_to.Text = sdr["pay_to"].ToString();
                    txt_remark.Text = sdr["description"].ToString();
                    txt_pay_methode.Text = sdr["pay_metod"].ToString();
                    cb_request.Text = sdr["createBy1_name"].ToString();
                    cb_request2.Text = sdr["createBy2_name"].ToString();
                    cb_approved.Text = sdr["approveBy1_name"].ToString();
                    cb_approved2.Text = sdr["approveBy2_name"].ToString();
                    txt_uid.Text = sdr["userid"].ToString();
                    txt_lastUpdate.Text = string.Format("{0:dd-MM-yyyy}", sdr["lastupdate"].ToString());
                    txt_owner.Text = sdr["doc_owner"].ToString();
                    txt_edited.Text = sdr["edited"].ToString();
                    rbl_status.SelectedValue = sdr["doc_status"].ToString();
                    if(sdr["doc_status"].ToString() == "1")
                    { 
                        dtp_approved_date.SelectedDate= Convert.ToDateTime(sdr["approval_date"].ToString());
                    }
                    else
                    {
                        dtp_approved_date.Clear();
                        dtp_approved_date.Enabled = false;
                    }
                }
                con.Close();

                Session["action"] = "edit";
                btnSave.Enabled = true;
                btnSave.ImageUrl = "~/Images/simpan.png";
                btnPrint.Enabled = true;
                btnPrint.ImageUrl = "~/Images/cetak.png";
                btnPrint.Attributes["OnClick"] = String.Format("return ShowPreview('{0}');", txt_doc_number.Text);
            }

        }

        protected void btnSave_Click(object sender, ImageClickEventArgs e)
        {
            //long maxNo;
            string run = null;
            string trDate = string.Format("{0:dd/MM/yyyy}", dtp_doc.SelectedDate);

            if(txt_doc_number.Text != "")
            {
                run = txt_doc_number.Text;
            }
            else
            {
                run = "";
            }

            try
            {               
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_save_payment_request";
                cmd.Parameters.AddWithValue("@doc_no", run);
                cmd.Parameters.AddWithValue("@objek", txt_object.Text);
                cmd.Parameters.AddWithValue("@site_code", cb_project.SelectedValue);
                cmd.Parameters.AddWithValue("@dept_code", cb_cost_center.SelectedValue);
                cmd.Parameters.AddWithValue("@pay_to", txt_pay_to.Text);
                cmd.Parameters.AddWithValue("@description", txt_remark.Text);
                cmd.Parameters.AddWithValue("@amount", Convert.ToDouble(txt_amount.Text));
                cmd.Parameters.AddWithValue("@doc_date", string.Format("{0:dd-MM-yyyy}", dtp_doc.SelectedDate.Value));
                cmd.Parameters.AddWithValue("@exp_date", string.Format("{0:dd-MM-yyyy}", dtp_due_date.SelectedDate.Value));
                cmd.Parameters.AddWithValue("@doc_owner", public_str.user_id);
                cmd.Parameters.AddWithValue("@doc_status", rbl_status.SelectedValue);
                cmd.Parameters.AddWithValue("@created_by1", cb_request.SelectedValue);
                cmd.Parameters.AddWithValue("@created_by2", cb_request2.SelectedValue);
                cmd.Parameters.AddWithValue("@approved_by1", cb_approved.SelectedValue);
                cmd.Parameters.AddWithValue("@approved_by2", cb_approved2.SelectedValue);
                cmd.Parameters.AddWithValue("@pay_metod", txt_pay_methode.Text);
                cmd.Parameters.AddWithValue("@editBy", public_str.user_id);
                //cmd.Parameters.AddWithValue("@sts_note", string.Format("{0:yyyy-MM-dd}", dtp_approved_date.SelectedDate.Value));
                //cmd.Parameters.AddWithValue("@approval_date", string.Format("{0:yyyy-MM-dd}", dtp_approved_date.SelectedDate.Value));
                cmd.ExecuteNonQuery();
                                
                SqlCommand cmd1 = new SqlCommand();
                cmd1.Connection = con;
                cmd1.CommandType = CommandType.Text;
                cmd1.CommandText = "SELECT doc_no FROM acc01h05 WHERE objek = '" + txt_object.Text + "'";
                SqlDataReader dr;
                dr = cmd1.ExecuteReader();
                while (dr.Read())
                    txt_doc_number.Text = dr["doc_no"].ToString();
                dr.Close();

                con.Close();

                //txt_doc_number.Text = run;
                btnSave.Enabled = false;
                btnPrint.Enabled = true;
                btnPrint.ImageUrl = "~/Images/cetak.png";
                btnPrint.Attributes["OnClick"] = String.Format("return ShowPreview('{0}');", txt_doc_number.Text);
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Data Saved');", false);
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('" + ex + "');", true);
                con.Close();
            }
        }
        protected void btnPrint_Click(object sender, ImageClickEventArgs e)
        {
            btnPrint.Attributes["OnClick"] = String.Format("return ShowPreview('{0}');", txt_doc_number.Text);
        }

        #region Approval ManPower
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

        protected void cb_approved_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            cb_request.Text = "";
            LoadManPower(e.Text, cb_project.SelectedValue, (sender as RadComboBox));

        }
        protected void cb_approved_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }
        protected void cb_approved_DataBound(object sender, EventArgs e)
        {
            ((Literal)(sender as RadComboBox).Footer.FindControl("RadComboItemsCount")).Text = Convert.ToString((sender as RadComboBox).Items.Count);
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
                (sender as RadComboBox).SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }
        
        #endregion

        protected void  rbl_status_SelectedIndexChanged(object sender, EventArgs e)
        {
            //if (rbl_status.SelectedIndex.ToString() == "1")
            //{
            //    dtp_approved_date.Enabled = true;
            //}
            if (rbl_status.SelectedItem.Text=="Open")
            {
                dtp_approved_date.Enabled = false;
            }
            else if (rbl_status.SelectedItem.Text == "Approve")
            {
                dtp_approved_date.Enabled = true;
            }
            else
            {
                dtp_approved_date.Enabled = false;
            }
        }
    }
}