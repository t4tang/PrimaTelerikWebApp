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

namespace TelerikWebApplication.Form.Fico.Cash.CashMutation
{
    public partial class acc01h02 : System.Web.UI.Page
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
                cb_cashmutation_prm.SelectedValue = public_str.site;

                Session["action"] = "new";
                RadGrid2.Enabled = false;
                dtp_exe.SelectedDate = DateTime.Now;
            }
        }

        private static DataTable GetCashCode(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT KoKas, NamKas FROM acc00h02 WHERE stEdit != 4 AND NamKas LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_cashmutation_prm_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetCashCode(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                cb_cashmutation_prm.Items.Add(new RadComboBoxItem(data.Rows[i]["NamKas"].ToString(), data.Rows[i]["NamKas"].ToString()));
            }
        }

        protected void cb_cashmutation_prm_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT KoKas FROM acc00h02 WHERE NamKas = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
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

        protected void RadAjaxManager1_AjaxRequest(object sender, Telerik.Web.UI.AjaxRequestEventArgs e)
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

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            RadGrid1.DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), cb_cashmutation_prm.SelectedValue);
            RadGrid1.DataBind();
        }
        protected void RadGrid1_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            (sender as RadGrid).DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), cb_cashmutation_prm.SelectedValue);
        }
        public DataTable GetDataTable(string fromDate, string toDate, string Cash)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_cashmutasiH";
            cmd.Parameters.AddWithValue("@date", fromDate);
            cmd.Parameters.AddWithValue("@todate", toDate);
            cmd.Parameters.AddWithValue("@Cash", Cash);
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

        protected void RadGrid1_DeleteCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            var NoBuk = ((GridDataItem)e.Item).GetDataKeyValue("NoBuk");
            try
            {
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "UPDATE acc01h02 SET Usr = @Usr, Stamp = GETDATE(), Batal = '1' WHERE (NoBuk = @NoBuk)";
                cmd.Parameters.AddWithValue("@KoKas", NoBuk);
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
                SqlCommand cmd = new SqlCommand("SELECT * FROM v_cashmutasi_list WHERE NoBuk = '" + item["NoBuk"].Text + "'", con);
                sdr = cmd.ExecuteReader();
                if (sdr.Read())
                {
                    txt_reg_no.Text = sdr["NoBuk"].ToString();
                    dtp_exe.SelectedDate = Convert.ToDateTime(sdr["Tgl"].ToString());
                    txt_NoCtrl.Text = sdr["NoCtrl"].ToString();
                    txt_NoRef.Text = sdr["NoRef"].ToString();
                    
                    if (sdr["KoTrans"].ToString() == "Penerimaan")
                    {
                        cb_trans.Text = "PENERIMAAN KAS";
                    }
                    else
                    {
                        cb_trans.Text = "PENGELUARAN KAS";
                    }
                    cb_project.Text = sdr["region_name"].ToString();
                    cb_cash.Text = sdr["KoKas"].ToString();
                    txt_cur_code.Text = sdr["cur_name"].ToString();
                    nu_kurs.Text = sdr["kurs"].ToString();
                    txt_remark.Text = sdr["Ket"].ToString();
                    txt_fromto.Text = sdr["Kontak"].ToString();
                    cb_prepare.Text = sdr["freby"].ToString();
                    cb_checked.Text = sdr["ordby"].ToString();
                    cb_aproval.Text = sdr["appby"].ToString();
                }
                con.Close();

                RadGrid2.DataSource = GetDataDetailTable(txt_reg_no.Text);
                RadGrid2.DataBind();
                Session["action"] = "edit";
                RadGrid2.Enabled = true;
            }
        }
        protected void RadGrid2_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            RadGrid2.DataSource = GetDataDetailTable("");
        }
        public DataTable GetDataDetailTable(string NoBuk)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_cashmutasiD";
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
            string trDate = string.Format("{0:dd/MM/yyyy}", dtp_exe.SelectedDate);

            try
            {
                if (Session["Proccess"].ToString() == "SesEdit")
                {
                    run = txt_reg_no.Text;
                }
                else
                {
                    con.Open();
                    SqlDataReader sdr;
                    cmd = new SqlCommand("SELECT ISNULL ( MAX ( RIGHT ( acc01h02.NoBuk , 4 ) ) , 0 ) + 1 AS maxNo " +
                        "FROM acc01h02 WHERE LEFT(acc01h02.NoBuk, 4) = '" + cb_cash.SelectedValue + "' + '" + cb_trans.SelectedValue + "' " +
                        "AND SUBSTRING(acc01h02.NoBuk, 5, 2) = SUBSTRING('" + trDate + "', 9, 2) " +
                        "AND SUBSTRING(acc01h02.NoBuk, 7, 2) = SUBSTRING('" + trDate + "', 4, 2) ", con);
                    sdr = cmd.ExecuteReader();
                    if (sdr.HasRows == false)
                    {
                        //throw new Exception();
                        run = cb_cash.SelectedValue + cb_trans.SelectedValue + dtp_exe.SelectedDate.Value.Year + dtp_exe.SelectedDate.Value.Month + "0001";
                    }
                    else if (sdr.Read())
                    {
                        maxNo = Convert.ToInt32(sdr[0].ToString());
                        run = cb_cash.SelectedValue + cb_trans.SelectedValue + (dtp_exe.SelectedDate.Value.Year.ToString()).Substring(dtp_exe.SelectedDate.Value.Year.ToString().Length - 2) +
                            ("0000" + dtp_exe.SelectedDate.Value.Month).Substring(("0000" + dtp_exe.SelectedDate.Value.Month).Length - 2, 2) +
                            ("0000" + maxNo).Substring(("0000" + maxNo).Length - 4, 4);
                    }
                    con.Close();
                }

                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_save_cashmutasiH";
                cmd.Parameters.AddWithValue("@Kode", "DB");
                cmd.Parameters.AddWithValue("@NoBuk", run);
                cmd.Parameters.AddWithValue("@Tgl", string.Format("{0:yyyy-MM-dd}", dtp_exe.SelectedDate.Value));
                cmd.Parameters.AddWithValue("@NoCtrl", txt_NoCtrl.Text);
                cmd.Parameters.AddWithValue("@NoRef", txt_NoRef.Text);
                cmd.Parameters.AddWithValue("@KoTrans", cb_trans.SelectedValue);
                cmd.Parameters.AddWithValue("@KoKas", cb_cash.SelectedValue);
                cmd.Parameters.AddWithValue("@cur_code", txt_cur_code.Text);
                cmd.Parameters.AddWithValue("@kurs", nu_kurs.Text);
                cmd.Parameters.AddWithValue("@Kontak", txt_fromto.Text);
                cmd.Parameters.AddWithValue("@region_code", public_str.site);
                cmd.Parameters.AddWithValue("@dept_code", public_str.site);
                cmd.Parameters.AddWithValue("@Ket", txt_remark.Text);
                cmd.Parameters.AddWithValue("@freby", cb_prepare.SelectedValue);
                //cmd.Parameters.AddWithValue("@OwnStamp", DateTime.Today);
                cmd.Parameters.AddWithValue("@ordby", cb_checked.SelectedValue);
                cmd.Parameters.AddWithValue("@appby", cb_aproval.SelectedValue);
                cmd.Parameters.AddWithValue("@Lvl", public_str.level);
                cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
                cmd.ExecuteNonQuery();

                Label lblsuccess = new Label();
                lblsuccess.Text = "Data saved successfully";
                lblsuccess.ForeColor = System.Drawing.Color.Blue;
                //RadGrid1.Controls.Add(lblsuccess);
                con.Close();

                txt_reg_no.Text = run;
                RadGrid2.Enabled = true;
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

        protected void cb_trans_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadComboBox).Text == "PENERIMAAN KAS")
            {
                (sender as RadComboBox).SelectedValue = "D";
            }
            else if ((sender as RadComboBox).Text == "PENGELUARAN KAS")
            {
                (sender as RadComboBox).SelectedValue = "K";
            }
        }

        protected void cb_trans_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Add("PENERIMAAN KAS");
            (sender as RadComboBox).Items.Add("PENGELUARAN KAS");
        }

        protected void cb_trans_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if ((sender as RadComboBox).Text == "PENERIMAAN KAS")
            {
                (sender as RadComboBox).SelectedValue = "D";
            }
            else if ((sender as RadComboBox).Text == "PENGELUARAN KAS")
            {
                (sender as RadComboBox).SelectedValue = "K";
            }
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

        protected void LoadCash(string name, string projectID, RadComboBox cb)
        {
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);

            SqlDataAdapter adapter = new SqlDataAdapter("SELECT upper(KoKas) as code,upper(NamKas) as name FROM acc00h02 " +
                "WHERE stEdit <> '4' AND region_code = @project AND NamKas LIKE @text + '%'", con);
            adapter.SelectCommand.Parameters.AddWithValue("@project", projectID);
            adapter.SelectCommand.Parameters.AddWithValue("@text", name);
            DataTable dt = new DataTable();
            adapter.Fill(dt);

            cb.DataTextField = "name";
            cb.DataValueField = "code";
            cb.DataSource = dt;
            cb.DataBind();
        }

        protected void cb_cash_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Text = "";
            LoadCash(e.Text, cb_project.SelectedValue, (sender as RadComboBox));
        }

        protected void cb_cash_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT acc00h02.*, acc00h04.cur_code,acc00h04.KursRun FROM acc00h02 CROSS JOIN acc00h04 where " +
            " acc00h04.tglKurs = (select MAX(acc00h04.tglKurs) from acc00h04) and NamkAS = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["KoKas"].ToString();
            dr.Close();


            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adapter.Fill(dt);
            foreach (DataRow dr1 in dt.Rows)
            {
                txt_cur_code.Text = dr1["cur_code"].ToString();
                nu_kurs.Text = dr1["KursRun"].ToString();
            }

            con.Close();
        }

        protected void cb_cash_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT KoKas FROM acc00h02 WHERE NamKas = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["KoKas"].ToString();
            dr.Close();
            con.Close();
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

        protected void cb_prepare_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            cb_prepare.Text = "";
            LoadManPower(e.Text, cb_project.SelectedValue, cb_prepare);
        }

        protected void cb_prepare_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + cb_prepare.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_prepare.SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_prepare_DataBound(object sender, EventArgs e)
        {
            ((Literal)cb_prepare.Footer.FindControl("RadComboItemsCount")).Text = Convert.ToString((sender as RadComboBox).Items.Count);
        }

        protected void cb_prepare_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + cb_prepare.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_prepare.SelectedValue = dr["nik"].ToString();
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

        protected void cb_aproval_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            cb_aproval.Text = "";
            LoadManPower(e.Text, cb_project.SelectedValue, cb_aproval);
        }

        protected void cb_aproval_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + cb_aproval.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_aproval.SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_aproval_DataBound(object sender, EventArgs e)
        {
            ((Literal)cb_aproval.Footer.FindControl("RadComboItemsCount")).Text = Convert.ToString((sender as RadComboBox).Items.Count);
        }

        protected void cb_aproval_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT nik FROM inv00h26 WHERE name = '" + cb_aproval.Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                cb_aproval.SelectedValue = dr["nik"].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_korek_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            string sql = "SELECT [accountno], [accountname] FROM [acc00h10]  WHERE stEdit != '4' AND accountname LIKE @accountname + '%'";
            SqlDataAdapter adapter = new SqlDataAdapter(sql,
                ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@accountname", e.Text);

            DataTable dt = new DataTable();
            adapter.Fill(dt);

            RadComboBox comboBox = (RadComboBox)sender;
            // Clear the default Item that has been re-created from ViewState at this point.
            comboBox.Items.Clear();

            foreach (DataRow row in dt.Rows)
            {
                RadComboBoxItem item = new RadComboBoxItem();
                item.Text = row["accountno"].ToString();
                item.Value = row["accountno"].ToString();
                item.Attributes.Add("accountname", row["accountname"].ToString());

                comboBox.Items.Add(item);

                item.DataBind();
            }
        }

        protected void cb_korek_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT accountno FROM acc00h10 WHERE accountname = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr[0].ToString();
            dr.Close();
            con.Close();
        }

        protected void cb_korek_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            Session["accountno"] = e.Value;

            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "SELECT accountname,cur_code FROM acc00h10 WHERE accountno = '" + (sender as RadComboBox).SelectedValue + "'";

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                foreach (DataRow dtr in dt.Rows)
                {
                    RadComboBox cb = (RadComboBox)sender;
                    GridEditableItem item = (GridEditableItem)cb.NamingContainer;
                    RadComboBox c_Mutasi = (RadComboBox)item.FindControl("cb_mutasi");
                    RadNumericTextBox t_KURS = (RadNumericTextBox)item.FindControl("txt_kurs");                    
                    RadComboBox c_Project = (RadComboBox)item.FindControl("cb_project1");

                    c_Mutasi.Text = cb_trans.SelectedValue; 
                    t_KURS.Text = nu_kurs.Text;                    
                    c_Project.Text = cb_project.SelectedValue;
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

        protected void cb_cost_center_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            string sql = "SELECT [CostCenter], [CostCenterName] FROM [inv00h11]  WHERE stEdit != '4' AND CostCenterName LIKE @CostCenterName + '%'";
            SqlDataAdapter adapter = new SqlDataAdapter(sql,
                ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@CostCenterName", e.Text);

            DataTable dt = new DataTable();
            adapter.Fill(dt);

            RadComboBox comboBox = (RadComboBox)sender;
            // Clear the default Item that has been re-created from ViewState at this point.
            comboBox.Items.Clear();

            foreach (DataRow row in dt.Rows)
            {
                RadComboBoxItem item = new RadComboBoxItem();
                item.Text = row["CostCenter"].ToString();
                item.Value = row["CostCenter"].ToString();
                item.Attributes.Add("CostCenterName", row["CostCenterName"].ToString());

                comboBox.Items.Add(item);

                item.DataBind();
            }

            //(sender as RadComboBox).Text = "";
            LoadCostCtr(e.Text, cb_project.SelectedValue, (sender as RadComboBox));
        }

        protected void cb_cost_center_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            Session["CostCenter"] = e.Value;

            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "SELECT CostCenter FROM inv00h11 WHERE CostCenterName = '" + (sender as RadComboBox).Text + "'";

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                foreach (DataRow dtr in dt.Rows)
                {
                    RadComboBox cb = (RadComboBox)sender;
                    GridEditableItem item = (GridEditableItem)cb.NamingContainer;
                    RadTextBox t_AccountName = (RadTextBox)item.FindControl("txt_CostCenterName");

                    t_AccountName.Text = dtr["CostCenterName"].ToString();


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

        protected void RadGrid2_save_handler(object sender, GridCommandEventArgs e)
        {
            try
            {
                GridEditableItem item = (GridEditableItem)e.Item;
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_save_cashmutasiD";
                cmd.Parameters.AddWithValue("@NoBuk", txt_reg_no.Text);
                cmd.Parameters.AddWithValue("@KoRek", (item.FindControl("cb_korek") as RadComboBox).Text);
                cmd.Parameters.AddWithValue("@Ket", (item.FindControl("txt_remark") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@Mutasi", (item.FindControl("cb_Mutasi") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@kurs", Convert.ToDouble((item.FindControl("txt_kurs") as RadNumericTextBox).Text));
                cmd.Parameters.AddWithValue("@Jumlah", Convert.ToDouble((item.FindControl("txt_amount") as RadNumericTextBox).Text));
                cmd.Parameters.AddWithValue("@region_code", (item.FindControl("cb_project1") as RadComboBox).Text);
                cmd.Parameters.AddWithValue("@dept_code", (item.FindControl("cb_cost_center") as RadComboBox).Text);
                cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
                cmd.Parameters.AddWithValue("@Owner", public_str.user_id);
                cmd.ExecuteNonQuery();
                con.Close();
                RadGrid2.DataBind();
                RadGrid2.Rebind();

                Label lblsuccess = new Label();
                lblsuccess.Text = "Data saved";
                lblsuccess.ForeColor = System.Drawing.Color.DarkGray;
                RadGrid2.Controls.Add(lblsuccess);
            }
            catch (Exception ex)
            {
                con.Close();
                Label lblError = new Label();
                lblError.Text = "Unable to insert data. Reason: " + ex.Message;
                lblError.ForeColor = System.Drawing.Color.Red;
                RadGrid2.Controls.Add(lblError);
                e.Canceled = true;
            }
        }

        protected void RadGrid2_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            var KoRek = ((GridDataItem)e.Item).GetDataKeyValue("KoRek");

            try
            {
                GridEditableItem item = (GridEditableItem)e.Item;
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "delete from acc01d02 where KoRek = @KoRek and NoBuk = @NoBuk";
                cmd.Parameters.AddWithValue("@NoBuk", txt_reg_no.Text);
                cmd.Parameters.AddWithValue("@KoRek", KoRek);
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

        protected void btnNew_Click(object sender, ImageClickEventArgs e)
        {
            Session["act"] = "new";
            btnSave.Enabled = false;
            clear_text(Page.Controls);
            RadGrid2.DataSource = new string[] { };
            RadGrid2.DataBind();
            RadGrid2.Enabled = false;
            set_info();
        }

        private void set_info()
        {
            txt_UId.Text = public_str.uid;
            txt_lastupdate.Text = string.Format("{0:dd/MM/yyyy}", DateTime.Now);
            txt_Owner.Text = public_str.uid;
            txt_Printed.Text = "0";
            txt_Edited.Text = "0";
        }

        protected void cb_project1_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            Session["region_code"] = e.Value;

            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "SELECT region_name FROM inv00h09 WHERE region_code = '" + (sender as RadComboBox).SelectedValue + "'";

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                foreach (DataRow dtr in dt.Rows)
                {
                    RadComboBox cb = (RadComboBox)sender;
                    GridEditableItem item = (GridEditableItem)cb.NamingContainer;
                    RadTextBox t_AccountName = (RadTextBox)item.FindControl("txt_region_name");

                    t_AccountName.Text = dtr["region_name"].ToString();
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

        protected void cb_project1_PreRender(object sender, EventArgs e)
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

        protected void cb_project1_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            string sql = "SELECT [region_code], [region_name] FROM [inv00h09]  WHERE stEdit != '4' AND region_name LIKE @region_name + '%'";
            SqlDataAdapter adapter = new SqlDataAdapter(sql,
                ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@region_name", e.Text);

            DataTable dt = new DataTable();
            adapter.Fill(dt);

            RadComboBox comboBox = (RadComboBox)sender;
            // Clear the default Item that has been re-created from ViewState at this point.
            comboBox.Items.Clear();

            foreach (DataRow row in dt.Rows)
            {
                RadComboBoxItem item = new RadComboBoxItem();
                item.Text = row["region_code"].ToString();
                item.Value = row["region_code"].ToString();
                item.Attributes.Add("region_name", row["region_name"].ToString());

                comboBox.Items.Add(item);

                item.DataBind();
            }
        }

        protected void cb_mutasi_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Add("D");
            (sender as RadComboBox).Items.Add("K");
        }

        protected void cb_mutasi_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if ((sender as RadComboBox).Text == "D")
            {
                (sender as RadComboBox).SelectedValue = "D";
            }
            else if ((sender as RadComboBox).Text == "K")
            {
                (sender as RadComboBox).SelectedValue = "K";
            }
        }

        protected void cb_mutasi_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadComboBox).Text == "D")
            {
                (sender as RadComboBox).SelectedValue = "D";
            }
            else if ((sender as RadComboBox).Text == "K")
            {
                (sender as RadComboBox).SelectedValue = "K";
            }
        }
    }
}