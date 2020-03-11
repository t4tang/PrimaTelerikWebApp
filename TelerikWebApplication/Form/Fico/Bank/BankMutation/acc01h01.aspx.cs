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

namespace TelerikWebApplication.Form.Fico.Bank.BankMutation
{
    public partial class acc01h01 : System.Web.UI.Page
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
                cb_bank_prm.SelectedValue = public_str.site;

                Session["Proccess"] = "SesNew";
                dtp_bm.SelectedDate = DateTime.Now;
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
        private static DataTable GetProject(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select region_code,region_name from inv00h09 where stEdit != 4 " +
                " AND region_name LIKE @text + '%'",
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
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select region_code from inv00h09 WHERE region_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["region_code"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_project_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select region_code from inv00h09 WHERE region_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["region_code"].ToString();
            dr.Close();
            con.Close();
        }

        private static DataTable GetBank(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT KoBank, NamBank FROM acc00h01 WHERE stEdit != 4 AND NamBank LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            RadGrid1.DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), cb_bank_prm.SelectedValue);
            RadGrid1.DataBind();
        }
        protected void RadGrid1_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            (sender as RadGrid).DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), cb_bank_prm.SelectedValue);
        }

        public DataTable GetDataTable(string fromDate, string toDate, string Bank)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_BankMutationH";
            cmd.Parameters.AddWithValue("@date", fromDate);
            cmd.Parameters.AddWithValue("@todate", toDate);
            cmd.Parameters.AddWithValue("@bank", Bank);
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
            var NoBuk = ((GridDataItem)e.Item).GetDataKeyValue("NoBuk");

            try
            {
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "UPDATE acc01h01 SET userid = @Usr, LastUpdate = GETDATE(), Batal = '1' WHERE (NoBuk = @NoBuk)";
                cmd.Parameters.AddWithValue("@NoBuk", NoBuk);
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
                //txt_NoBuk.Text = item["NoBuk"].Text;
                //dtp_bm.SelectedDate = Convert.ToDateTime(item["doc_date"].Text);

                con.Open();
                SqlDataReader sdr;
                SqlCommand cmd = new SqlCommand("SELECT * FROM v_bankmutation_list WHERE NoBuk = '" + item["NoBuk"].Text + "'", con);
                sdr = cmd.ExecuteReader();
                if (sdr.Read())
                {
                    txt_NoBuk.Text = sdr["NoBuk"].ToString();
                    dtp_bm.SelectedDate = Convert.ToDateTime(sdr["Tgl"].ToString());
                    txt_NoCtrl.Text = sdr["NoCtrl"].ToString();
                    txt_NoRef.Text = sdr["NoRef"].ToString();
                    cb_bank.Text = sdr["NamBank"].ToString();
                    cb_project.Text = sdr["region_name"].ToString();
                    //cb_cost_center.Text = sdr["CostCenterName"].ToString();
                    cb_prepared.Text = sdr["PreparedBy"].ToString();
                    cb_checked.Text = sdr["CheckedBy"].ToString();
                    cb_approved.Text = sdr["ApprovalBy"].ToString();
                    txt_Ket.Text = sdr["Ket"].ToString();
                    txt_Kontak.Text = sdr["Kontak"].ToString();
                    txt_cur_code.Text = sdr["cur_code"].ToString();
                    txt_kurs.Text = sdr["kurs"].ToString();
                    txt_uid.Text = sdr["Usr"].ToString();
                    txt_LastUpdate.Text = string.Format("{0:dd/MM/yyyy}", sdr["LastUpdate"].ToString());
                    txt_owner.Text = sdr["Owner"].ToString();
                    txt_printed.Text = sdr["Printed"].ToString();
                    txt_edited.Text = sdr["Edited"].ToString();
                }
                con.Close();

                RadGrid2.DataSource = GetDataDetailTable(txt_NoBuk.Text);
                RadGrid2.DataBind();
                Session["Proccess"] = "SesEdit";
            }

        }

        protected void RadGrid2_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            RadGrid2.DataSource = GetDataDetailTable("");
        }
        public DataTable GetDataDetailTable(string NoBuk)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_BankMutationD";
            cmd.Parameters.AddWithValue("@NoBuk", NoBuk);
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

        protected void btnSave_Click(object sender, ImageClickEventArgs e)
        {
            long maxNo;
            string run = null;
            string trDate = string.Format("{0:dd/MM/yyyy}", dtp_bm.SelectedDate);

            try
            {
                if (Session["Proccess"].ToString() == "SesEdit")
                {
                    run = txt_NoBuk.Text;
                }
                else
                {
                    con.Open();
                    SqlDataReader sdr;
                    cmd = new SqlCommand("SELECT ISNULL ( MAX ( RIGHT ( acc01h01.NoBuk , 4 ) ) , 0 ) + 1 AS maxNo " +
                        "FROM acc01h01 WHERE LEFT(acc01h01.NoBuk, 4) = cb_bank + cb_KoTrans " +
                        "AND SUBSTRING(acc01h01.doc_code, 5, 2) = SUBSTRING('" + trDate + "', 9, 2) " +
                        "AND SUBSTRING(acc01h01.doc_code, 7, 2) = SUBSTRING('" + trDate + "', 4, 2) ", con);
                    sdr = cmd.ExecuteReader();
                    if (sdr.HasRows == false)
                    {
                        //throw new Exception();
                        run = "UR01" + dtp_bm.SelectedDate.Value.Year + dtp_bm.SelectedDate.Value.Month + "0001";
                    }
                    else if (sdr.Read())
                    {
                        maxNo = Convert.ToInt32(sdr[0].ToString());
                        run = "UR01" + (dtp_bm.SelectedDate.Value.Year.ToString()).Substring(dtp_bm.SelectedDate.Value.Year.ToString().Length - 2) +
                            ("0000" + dtp_bm.SelectedDate.Value.Month).Substring(("0000" + dtp_bm.SelectedDate.Value.Month).Length - 2, 2) +
                            ("0000" + maxNo).Substring(("0000" + maxNo).Length - 4, 4);
                    }
                    con.Close();
                }


                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_save_BankMutationH";
                cmd.Parameters.AddWithValue("@NoBuk", run);
                cmd.Parameters.AddWithValue("@Tgl", string.Format("{0:yyyy-MM-dd}", dtp_bm.SelectedDate.Value));
                cmd.Parameters.AddWithValue("@KoBank", cb_bank.SelectedValue);
                cmd.Parameters.AddWithValue("@NoCtrl", txt_NoCtrl.Text);
                cmd.Parameters.AddWithValue("@NoRef", txt_NoRef.Text);
                cmd.Parameters.AddWithValue("@KoTrans", cb_KoTrans.SelectedValue);
                cmd.Parameters.AddWithValue("@freby", cb_prepared.SelectedValue);
                cmd.Parameters.AddWithValue("@ordby", cb_checked.SelectedValue);
                cmd.Parameters.AddWithValue("@appby", cb_approved.SelectedValue);
                cmd.Parameters.AddWithValue("@Ket", txt_Ket.Text);
                cmd.Parameters.AddWithValue("@Kontak", txt_Kontak.Text);
                cmd.Parameters.AddWithValue("@cur_code", txt_cur_code.Text);
                cmd.Parameters.AddWithValue("@kurs", txt_kurs.Text);
                cmd.Parameters.AddWithValue("@userid", txt_uid.Text);
                cmd.Parameters.AddWithValue("@lastupdate", DateTime.Today);
                cmd.Parameters.AddWithValue("@region_code", public_str.site);
                //cmd.Parameters.AddWithValue("@dept_code", cb_cost_center.SelectedValue);    
                cmd.Parameters.AddWithValue("@Owner", public_str.user_id);
                cmd.Parameters.AddWithValue("@OwnStamp", DateTime.Today);
                cmd.Parameters.AddWithValue("@Printed", txt_printed.Text);
                cmd.Parameters.AddWithValue("@Edited", txt_edited.Text);
                cmd.Parameters.AddWithValue("@Lvl", public_str.level);
                cmd.ExecuteNonQuery();

                Label lblsuccess = new Label();
                lblsuccess.Text = "Data saved successfully";
                lblsuccess.ForeColor = System.Drawing.Color.Blue;
                //RadGrid1.Controls.Add(lblsuccess);
                con.Close();
            }
            catch (Exception ex)
            {
                con.Close();
                Label lblError = new Label();
                lblError.Text = "Unable to save data. Reason: " + ex.Message;
                lblError.ForeColor = System.Drawing.Color.Red;
                //RadGrid1.Controls.Add(lblError);
                throw;
            }
        }

        protected void cb_KoTrans_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Add("PENERIMAAN BANK");
            (sender as RadComboBox).Items.Add("PENGELUARAN BANK");
        }

        protected void cb_KoTrans_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadComboBox).Text == "PENERIMAAN BANK")
            {
                (sender as RadComboBox).SelectedValue = "D";
            }
            else if ((sender as RadComboBox).Text == "PENGELUARAN BANK")
            {
                (sender as RadComboBox).SelectedValue = "K";
            }
        }

        protected void cb_KoTrans_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if ((sender as RadComboBox).Text == "PENERIMAAN BANK")
            {
                (sender as RadComboBox).SelectedValue = "D";
            }
            else if ((sender as RadComboBox).Text == "PENGELUARAN BANK")
            {
                (sender as RadComboBox).SelectedValue = "K";
            }
        }
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

       

        protected void cb_prepared_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            cb_prepared.Text = "";
            LoadManPower(e.Text, cb_project.SelectedValue, cb_prepared);
        }

        protected void cb_prepared_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + cb_prepared.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_prepared.SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_prepared_DataBound(object sender, EventArgs e)
        {
            ((Literal)cb_prepared.Footer.FindControl("RadComboItemsCount")).Text = Convert.ToString((sender as RadComboBox).Items.Count);
        }
        protected void cb_prepared_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + cb_prepared.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_prepared.SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_checked_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            cb_checked.Text = "";
            LoadManPower(e.Text, cb_project.SelectedValue, cb_checked);
        }

        protected void cb_checked_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + cb_checked.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_checked.SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_checked_DataBound(object sender, EventArgs e)
        {
            ((Literal)cb_checked.Footer.FindControl("RadComboItemsCount")).Text = Convert.ToString((sender as RadComboBox).Items.Count);
        }
        protected void cb_checked_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + cb_checked.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_checked.SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_approved_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            cb_approved.Text = "";
            LoadManPower(e.Text, cb_project.SelectedValue, cb_approved);
        }

        protected void cb_approved_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + cb_approved.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_approved.SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_approved_DataBound(object sender, EventArgs e)
        {
            ((Literal)cb_approved.Footer.FindControl("RadComboItemsCount")).Text = Convert.ToString((sender as RadComboBox).Items.Count);
        }
        protected void cb_approved_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + cb_approved.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_approved.SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }

        protected void LoadBank(string name, string projectID, RadComboBox cb)
        {
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);

            SqlDataAdapter adapter = new SqlDataAdapter("SELECT upper(KoBank) as code,upper(NamBank) as name FROM acc00h01 " +
                "WHERE stEdit <> '4' AND region_code = @project AND NamBank LIKE @text + '%'", con);
            adapter.SelectCommand.Parameters.AddWithValue("@project", projectID);
            adapter.SelectCommand.Parameters.AddWithValue("@text", name);
            DataTable dt = new DataTable();
            adapter.Fill(dt);

            cb.DataTextField = "name";
            cb.DataValueField = "code";
            cb.DataSource = dt;
            cb.DataBind();
        }
        protected void cb_bank_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadBank(e.Text, cb_project.SelectedValue, (sender as RadComboBox));
        }

        protected void cb_bank_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT acc00h01.*, acc00h04.cur_code,acc00h04.KursRun FROM acc00h01 CROSS JOIN acc00h04 where " +
            " acc00h04.tglKurs = (select MAX(acc00h04.tglKurs) from acc00h04) and NamBank = '" + cb_bank.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["KoBank"].ToString();
            dr.Close();

            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adapter.Fill(dt);
            foreach (DataRow dr1 in dt.Rows)
            {


                txt_cur_code.Text = dr1["cur_code"].ToString();
                txt_kurs.Text = dr1["KursRun"].ToString();
               
            }
            con.Close();
        }

        protected void cb_bank_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT KoBank FROM acc00h01 WHERE NamBank = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["KoBank"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_bank_prm_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetBank(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                cb_bank_prm.Items.Add(new RadComboBoxItem(data.Rows[i]["NamBank"].ToString(), data.Rows[i]["NamBank"].ToString()));
                //cb_bank.Items.Add(new RadComboBoxItem(data.Rows[i]["NamBank"].ToString(), data.Rows[i]["NamBank"].ToString()));
            }
        }

        protected void cb_bank_prm_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT KoBank FROM acc00h01 WHERE NamBank = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }
    }
    
}