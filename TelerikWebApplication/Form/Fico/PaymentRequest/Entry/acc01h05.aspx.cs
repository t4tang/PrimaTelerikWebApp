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

                set_info();
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
            Session["action"] = "new";
            btnSave.Enabled = true;
            btnSave.ImageUrl = "~/Images/simpan.png";
            btnPrint.Enabled = false;
            btnPrint.ImageUrl = "~/Images/cetak-gray.png";
            if (Session["action"].ToString() != "firstLoad")
            {
                clear_text(Page.Controls);
            }
            set_info();
        }
        private void clear_text(ControlCollection ctrls)
        {
            foreach (Control ctrl in ctrls)
            {
                if (ctrl is RadTextBox)
                {
                    ((RadTextBox)ctrl).Text = "";
                }
                else if (ctrl is RadComboBox)
                    ((RadComboBox)ctrl).Text = "";

                clear_text(ctrl.Controls);

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
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT region_code, region_name FROM inv00h09 WHERE stEdit != 4 AND region_name LIKE @text + '%' UNION SELECT 'ALL','ALL'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
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
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT region_code, region_name FROM inv00h09 WHERE stEdit != 4 AND region_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
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
            long maxNo;
            string run = null;
            string trDate = string.Format("{0:dd/MM/yyyy}", dtp_doc.SelectedDate);

            try
            {
                if (Session["action"].ToString() == "edit")
                {
                    run = txt_doc_number.Text;
                }
                //else
                //{
                //    con.Open();
                //    SqlDataReader sdr;
                //    cmd = new SqlCommand("SELECT ISNULL ( MAX ( RIGHT ( inv01h01.doc_code , 4 ) ) , 0 ) + 1 AS maxNo " +
                //        "FROM inv01h01 WHERE LEFT(inv01h01.doc_code, 4) = 'UR01' " +
                //        "AND SUBSTRING(inv01h01.doc_code, 5, 2) = SUBSTRING('" + trDate + "', 9, 2) " +
                //        "AND SUBSTRING(inv01h01.doc_code, 7, 2) = SUBSTRING('" + trDate + "', 4, 2) ", con);
                //    sdr = cmd.ExecuteReader();
                //    if (sdr.HasRows == false)
                //    {
                //        //throw new Exception();
                //        run = "UR01" + dtp_ur.SelectedDate.Value.Year + dtp_ur.SelectedDate.Value.Month + "0001";
                //    }
                //    else if (sdr.Read())
                //    {
                //        maxNo = Convert.ToInt32(sdr[0].ToString());
                //        run = "UR01" + (dtp_ur.SelectedDate.Value.Year.ToString()).Substring(dtp_ur.SelectedDate.Value.Year.ToString().Length - 2) +
                //            ("0000" + dtp_ur.SelectedDate.Value.Month).Substring(("0000" + dtp_ur.SelectedDate.Value.Month).Length - 2, 2) +
                //            ("0000" + maxNo).Substring(("0000" + maxNo).Length - 4, 4);
                //    }
                //    con.Close();
                //}


                //con.Open();
                //cmd = new SqlCommand();
                //cmd.CommandType = CommandType.StoredProcedure;
                //cmd.Connection = con;
                //cmd.CommandText = "sp_save_urH";
                //cmd.Parameters.AddWithValue("@doc_code", run);
                //cmd.Parameters.AddWithValue("@doc_date", string.Format("{0:yyyy-MM-dd}", dtp_ur.SelectedDate.Value));
                //cmd.Parameters.AddWithValue("@trans_status", cb_ur_status.SelectedValue);
                //cmd.Parameters.AddWithValue("@date_exec", string.Format("{0:yyyy-MM-dd}", dtp_exe.SelectedDate.Value));
                //cmd.Parameters.AddWithValue("@receive_by", cb_request.SelectedValue);
                //cmd.Parameters.AddWithValue("@aprove_by", cb_approved.SelectedValue);
                //cmd.Parameters.AddWithValue("@doc_remark", txt_remark.Text);
                //cmd.Parameters.AddWithValue("@userid", txt_uid.Text);
                //cmd.Parameters.AddWithValue("@lastupdate", DateTime.Today);
                //cmd.Parameters.AddWithValue("@region_code", public_str.site);
                //cmd.Parameters.AddWithValue("@dept_code", cb_cost_center.SelectedValue);
                //cmd.Parameters.AddWithValue("@priority_code", cb_priority.SelectedValue);
                //cmd.Parameters.AddWithValue("@Owner", public_str.user_id);
                //cmd.Parameters.AddWithValue("@OwnStamp", DateTime.Today);
                //cmd.Parameters.AddWithValue("@Printed", txt_printed.Text);
                //cmd.Parameters.AddWithValue("@Edited", txt_edited.Text);
                //cmd.Parameters.AddWithValue("@Lvl", public_str.level);
                //cmd.ExecuteNonQuery();

                
                con.Close();

                txt_doc_number.Text = run;
                btnSave.Enabled = false;
                btnPrint.Enabled = true;
                btnPrint.ImageUrl = "~/Images/cetak.png";
                btnPrint.Attributes["OnClick"] = String.Format("return ShowPreview('{0}');", txt_doc_number.Text);
            }
            catch (Exception ex)
            {
                con.Close();
                //lbl_result.Text = "Unable to save data. Reason: " + ex.Message;
                //lbl_result.ForeColor = System.Drawing.Color.Red;
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


        //protected void cb_approved_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        //{
        //    cb_approved.Text = "";
        //    LoadManPower(e.Text, cb_project.SelectedValue, cb_approved);
        //}
        //protected void cb_approved_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        //{
        //    con.Open();
        //    SqlCommand cmd = new SqlCommand();
        //    cmd.Connection = con;
        //    cmd.CommandType = CommandType.Text;
        //    cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + cb_approved.Text + "'";
        //    SqlDataReader dr;
        //    dr = cmd.ExecuteReader();
        //    while (dr.Read())
        //        cb_approved.SelectedValue = dr["nik"].ToString();
        //    dr.Close();
        //    con.Close();
        //}

        //protected void cb_approved_DataBound(object sender, EventArgs e)
        //{
        //    ((Literal)cb_approved.Footer.FindControl("RadComboItemsCount")).Text = Convert.ToString((sender as RadComboBox).Items.Count);
        //}


        //protected void cb_approved_PreRender(object sender, EventArgs e)
        //{
        //    con.Open();
        //    SqlCommand cmd = new SqlCommand();
        //    cmd.Connection = con;
        //    cmd.CommandType = CommandType.Text;
        //    cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + cb_approved.Text + "'";
        //    SqlDataReader dr;
        //    dr = cmd.ExecuteReader();
        //    while (dr.Read())
        //        cb_approved.SelectedValue = dr["nik"].ToString();
        //    dr.Close();
        //    con.Close();
        //}
        #endregion
    }
}