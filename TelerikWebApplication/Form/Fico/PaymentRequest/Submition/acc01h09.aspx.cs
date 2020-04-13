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

namespace TelerikWebApplication.Form.Fico.PaymentRequest.Submition
{
    public partial class acc01h09 : System.Web.UI.Page
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

                dtp_submit_date.SelectedDate = DateTime.Now;
                Session["action"] = "firstLoad";
                btnSave.Enabled = false;
                btnSave.ImageUrl = "~/Images/simpan-gray.png";
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
            set_info();
            //rbl_status.SelectedValue = "0";
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
            cmd.CommandText = "sp_get_payment_request_submit";
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
            var reg_no = ((GridDataItem)e.Item).GetDataKeyValue("reg_no");

            try
            {
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "UPDATE acc01h09 SET userid = @Usr, lastupdate = GETDATE(), st_edit = '4' WHERE (reg_no = @reg_no)";
                cmd.Parameters.AddWithValue("@reg_no", reg_no);
                cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
                cmd.ExecuteNonQuery();
                con.Close();

                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Data Deleted');", true);
            }
            catch (Exception ex)
            {
                con.Close();
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('" + ex + "');", true);
                e.Canceled = true;
            }
        }
        protected void btnOk_Click(object sender, EventArgs e)
        {
            foreach (GridDataItem item in RadGrid1.SelectedItems)
            {
                con.Open();
                SqlDataReader sdr;
                SqlCommand cmd = new SqlCommand("SELECT a.reg_no, a.reg_date,a.remark as note, b.*, c.Name as Receiver_name " +
                "FROM acc01h09 a, v_payment_requset_list b, inv00h26 c WHERE   a.received_by = c.Nik AND a.doc_no = b.doc_no AND reg_no = '" + item["reg_no"].Text + "'", con);
                sdr = cmd.ExecuteReader();
                if (sdr.Read())
                {
                    txt_reg_number.Text = sdr["reg_no"].ToString();
                    cb_doc_number.Text= sdr["doc_no"].ToString();
                    txt_note.Text= sdr["note"].ToString();
                    dtp_submit_date.SelectedDate = Convert.ToDateTime(sdr["reg_date"].ToString());
                    dtp_doc.SelectedDate = Convert.ToDateTime(sdr["doc_date"].ToString());
                    dtp_due_date.SelectedDate = Convert.ToDateTime(sdr["exp_date"].ToString());
                    txt_object.Text = sdr["objek"].ToString();
                    txt_amount.Value = Convert.ToDouble(sdr["amount"].ToString());
                    cb_project.Text = sdr["region_name"].ToString();
                    cb_cost_center.Text = sdr["dept_name"].ToString();
                    txt_pay_to.Text = sdr["pay_to"].ToString();
                    txt_remark.Text = sdr["description"].ToString();
                    txt_pay_methode.Text = sdr["pay_metod"].ToString();
                    //cb_request.Text = sdr["createBy1_name"].ToString();
                    //cb_request2.Text = sdr["createBy2_name"].ToString();
                    //cb_approved.Text = sdr["approveBy1_name"].ToString();
                    //cb_approved2.Text = sdr["approveBy2_name"].ToString();
                    txt_uid.Text = sdr["userid"].ToString();
                    txt_lastUpdate.Text = string.Format("{0:dd-MM-yyyy}", sdr["lastupdate"].ToString());
                    txt_owner.Text = sdr["doc_owner"].ToString();
                    txt_edited.Text = sdr["edited"].ToString();
                    //rbl_status.SelectedValue = sdr["doc_status"].ToString();
                    //if (sdr["doc_status"].ToString() == "1")
                    //{
                    //    dtp_approved_date.SelectedDate = Convert.ToDateTime(sdr["approval_date"].ToString());
                    //}
                    //else
                    //{
                    //    dtp_approved_date.Clear();
                    //}
                }
                con.Close();

                Session["action"] = "edit";
                btnSave.Enabled = true;
                btnSave.ImageUrl = "~/Images/simpan.png";
            }

        }

        protected void btnSave_Click(object sender, ImageClickEventArgs e)
        {
            //long maxNo;
            string run = "";
            string trDate = string.Format("{0:dd/MM/yyyy}", dtp_doc.SelectedDate);

            //if (txt_reg_number.Text != "")
            //{
            //    run = txt_reg_number.Text;
            //}
            //else
            //{
            //    run = "";
            //}

            try
            {
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_save_payment_request_submit";
                cmd.Parameters.AddWithValue("@reg_no", run);
                cmd.Parameters.AddWithValue("@reg_date", string.Format("{0:yyyy-MM-dd}", dtp_submit_date.SelectedDate.Value));
                cmd.Parameters.AddWithValue("@doc_no", cb_doc_number.Text);
                cmd.Parameters.AddWithValue("@remark", txt_note.Text);
                cmd.Parameters.AddWithValue("@received_by", public_str.user_id);
                cmd.Parameters.AddWithValue("@userid", public_str.user_id);
                cmd.ExecuteNonQuery();

                SqlCommand cmd1 = new SqlCommand();
                cmd1.Connection = con;
                cmd1.CommandType = CommandType.Text;
                cmd1.CommandText = "SELECT reg_no FROM acc01h09 WHERE doc_no = '" + cb_doc_number.Text + "'";
                SqlDataReader dr;
                dr = cmd1.ExecuteReader();
                while (dr.Read())
                    txt_reg_number.Text = dr["reg_no"].ToString();
                dr.Close();

                con.Close();
                
                btnSave.Enabled = false;
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Data Saved');", false);
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('" + ex + "');", true);
                con.Close();
            }
        }
                
        protected void cb_doc_number_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadDocNo(e.Text, (sender as RadComboBox));
        }
        protected void LoadDocNo(string text, RadComboBox cb)
        {
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);

            SqlDataAdapter adapter = new SqlDataAdapter("SELECT a.doc_no, a.amount FROM acc01h05 a where LEFT(a.doc_no,25)LIKE '%'  AND doc_status = 1 and stEdit <> 4 " +
                "AND a.doc_no NOT IN(SELECT doc_no FROM acc01h09 WHERE stEdit <> 4)", con);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text); 
            DataTable dt = new DataTable();
            adapter.Fill(dt);

            cb.DataTextField = "doc_no";
            cb.DataValueField = "doc_no";
            cb.DataSource = dt;
            cb.DataBind();
        }

        protected void cb_doc_number_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            //con.Open();
            //SqlDataReader sdr;
            //SqlCommand cmd = new SqlCommand("SELECT * FROM v_payment_requset_list WHERE doc_no = '" + cb_doc_number.Text + "'", con);
            //sdr = cmd.ExecuteReader();
            //while (sdr.Read())
            //{
            //    txt_reg_number.Text = sdr["doc_no"].ToString();
            //    dtp_doc.SelectedDate = Convert.ToDateTime(sdr["doc_date"].ToString());
            //    dtp_due_date.SelectedDate = Convert.ToDateTime(sdr["exp_date"].ToString());
            //    txt_object.Text = sdr["objek"].ToString();
            //    txt_amount.Value = Convert.ToDouble(sdr["amount"].ToString());
            //    cb_project.Text = sdr["region_name"].ToString();
            //    cb_cost_center.Text = sdr["dept_name"].ToString();
            //    txt_pay_to.Text = sdr["pay_to"].ToString();
            //    txt_remark.Text = sdr["description"].ToString();
            //    txt_pay_methode.Text = sdr["pay_metod"].ToString();
            //    txt_uid.Text = sdr["userid"].ToString();
            //    txt_lastUpdate.Text = string.Format("{0:dd-MM-yyyy}", sdr["lastupdate"].ToString());
            //    txt_owner.Text = sdr["doc_owner"].ToString();
            //    txt_edited.Text = sdr["edited"].ToString();
            //}
            //con.Close();

            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT * FROM v_payment_requset_list WHERE doc_no = '" + cb_doc_number.Text + "'";
            SqlDataReader sdr = cmd.ExecuteReader();
            if (sdr.Read())
            {
                //txt_reg_number.Text = sdr["doc_no"].ToString();
                dtp_doc.SelectedDate = Convert.ToDateTime(sdr["doc_date"].ToString());
                dtp_due_date.SelectedDate = Convert.ToDateTime(sdr["exp_date"].ToString());
                txt_object.Text = sdr["objek"].ToString();
                txt_amount.Value = Convert.ToDouble(sdr["amount"].ToString());
                cb_project.Text = sdr["region_name"].ToString();
                cb_cost_center.Text = sdr["dept_name"].ToString();
                txt_pay_to.Text = sdr["pay_to"].ToString();
                txt_remark.Text = sdr["description"].ToString();
                txt_pay_methode.Text = sdr["pay_metod"].ToString();
                txt_uid.Text = sdr["userid"].ToString();
                txt_lastUpdate.Text = string.Format("{0:dd-MM-yyyy}", sdr["lastupdate"].ToString());
                txt_owner.Text = sdr["doc_owner"].ToString();
                txt_edited.Text = sdr["edited"].ToString();
            }
                
            sdr.Close();
            con.Close();

        }
    }
}