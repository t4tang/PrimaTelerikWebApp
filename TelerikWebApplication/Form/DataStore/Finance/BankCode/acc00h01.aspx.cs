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

namespace TelerikWebApplication.Form.DataStore.Finance.BankCode
{
    public partial class acc00h01 : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();
        private const int ItemsPerRequest = 10;
        protected void Page_Load(object sender, EventArgs e)
        {

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
            cmd.CommandText = "SELECT acc00h01.KoBank, acc00h01.NamBank, acc00h01.NamaRek, acc00h01.NoRek, acc00h01.status, acc00h01.KoRek, acc00h01.SAwal,acc00h01.SAValas, " +
            "acc00h01.Lvl, acc00h01.Stamp,acc00h01.Usr,acc00h01.Owner,acc00h01.LastUpdate ,acc00h01.stEdit, acc00h10.accountname,accountno +' '+ accountname as accountComb, " +
            "acc00h10.cur_code, (select region_name from inv00h09 where region_code = acc00h01.region_code ) as project_name, acc00h01.tLock " +
            "FROM acc00h01, acc00h10  WHERE(acc00h01.KoRek = acc00h10.accountno) and((acc00h01.stEdit = '0'))  ";
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

        protected void RadGrid1_ItemCreated(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridEditableItem & e.Item.IsInEditMode)
            {
                GridEditFormItem item = (GridEditFormItem)e.Item;
                RadTextBox txt = (item.FindControl("txt_Code") as RadTextBox);
                RadLabel lblLevel = (item.FindControl("") as RadLabel);
                RadTextBox txtLvl = (item.FindControl("txt_level") as RadTextBox);
                if (e.Item.OwnerTableView.IsItemInserted)
                {
                    txt.Enabled = true;
                    txtLvl.Text = public_str.level;
                    txtLvl.Visible = false;
                }
                else
                {
                    txt.Enabled = false;
                }
            }
        }

        protected void RadGrid1_InsertCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                GridEditableItem item = (GridEditableItem)e.Item;
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "INSERT INTO acc00h01(KoBank, NamBank, NamaRek, NoRek, KoRek, Lvl, Stamp, Usr, Owner, LastUpdate, status, stEdit, region_code, tLock) " +
                "VALUES (@KoBank,@NamBank,@NamaRek,@NoRek,@KoRek,@Lvl, GETDATE(),@Usr,@Owner, GETDATE(), @status, '0',@region_code, @tLock)";
                cmd.Parameters.AddWithValue("@KoBank", (item.FindControl("txt_code") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@NamBank", (item.FindControl("txt_BankName") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@NamaRek", (item.FindControl("txt_nama_rek") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@NoRek", (item.FindControl("txt_account_no") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@KoRek", (item.FindControl("cb_koRek") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
                cmd.Parameters.AddWithValue("@Owner", public_str.user_id);
                cmd.Parameters.AddWithValue("@status", (item.FindControl("chk_active") as CheckBox).Checked ? 1 : 0);
                cmd.Parameters.AddWithValue("@Lvl", public_str.level);
                cmd.Parameters.AddWithValue("@region_code", (item.FindControl("cb_project") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@tLock", (item.FindControl("chk_unlock") as CheckBox).Checked ? 1 : 0);
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
                lblError.Text = "Unable to insert data. Reason: " + ex.Message;
                lblError.ForeColor = System.Drawing.Color.Red;
                RadGrid1.Controls.Add(lblError);
                e.Canceled = true;
            }

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

                        cmd = new SqlCommand("UPDATE acc00h01 SET NamBank = @NamBank, NamaRek = @NamaRek, NoRek = @NoRek, KoRek = @KoRek, Lvl = @Lvl, Stamp = GETDATE(),  " +
                                "Usr = @Usr, [Owner] = @Owner, LastUpdate = GETDATE(), [status] = @status, stEdit = '0', region_code = @region_code, tLock = @tLock WHERE KoBank = @KoBank", con);
                        con.Open();
                        cmd.Parameters.AddWithValue("@KoBank", (item.FindControl("txt_code") as RadTextBox).Text);
                        cmd.Parameters.AddWithValue("@NamBank", (item.FindControl("txt_BankName") as RadTextBox).Text);
                        cmd.Parameters.AddWithValue("@NamaRek", (item.FindControl("txt_nama_rek") as RadTextBox).Text);
                        cmd.Parameters.AddWithValue("@NoRek", (item.FindControl("txt_account_no") as RadTextBox).Text);
                        cmd.Parameters.AddWithValue("@KoRek", (item.FindControl("cb_koRek") as RadComboBox).SelectedValue);
                        cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
                        cmd.Parameters.AddWithValue("@Owner", public_str.user_id);
                        cmd.Parameters.AddWithValue("@status", (item.FindControl("chk_active") as CheckBox).Checked ? 1 : 0);
                        cmd.Parameters.AddWithValue("@Lvl", public_str.level);
                        cmd.Parameters.AddWithValue("@region_code", (item.FindControl("cb_project") as RadComboBox).SelectedValue);
                        cmd.Parameters.AddWithValue("@tLock", (item.FindControl("chk_unlock") as CheckBox).Checked ? 1 : 0);
                        cmd.ExecuteNonQuery();
                        con.Close();
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

        protected void RadGrid1_DeleteCommand(object source, GridCommandEventArgs e)
        {
            var KoBank = ((GridDataItem)e.Item).GetDataKeyValue("KoBank");

            try
            {
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "UPDATE acc00h01 SET Usr = @Usr, LastUpdate = GETDATE(), stEdit = '4' WHERE (KoBank = @KoBank)";
                cmd.Parameters.AddWithValue("@KoBank", KoBank);
                cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
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
        public static DataTable GetProject(string Text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select region_name, region_code from inv00h09 where stEdit != 4 AND region_name LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", Text);

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
            e.Message = GetStatusMessage(endOffset, data.Rows.Count);
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
                (sender as RadComboBox).SelectedValue = dr["region_code"].ToString();
            dr.Close();
            con.Close();
        }
        protected void cb_project_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT region_code FROM inv00h09 WHERE region_name = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["region_code"].ToString();
            dr.Close();
            con.Close();
        }
        public static DataTable GetAccount(string Text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select accountno +' '+ accountname as accountname from acc00h10 where stEdit != 4 " +
                " AND accountno +' '+ accountname LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", Text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_nama_rek_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetAccount(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["accountname"].ToString(), data.Rows[i]["accountname"].ToString()));

            }
            e.Message = GetStatusMessage(endOffset, data.Rows.Count);
        }

        protected void cb_nama_rek_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT accountno FROM acc00h10 WHERE accountno +' '+ accountname = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["accountno"].ToString();
            dr.Close();
            con.Close();
        }

        private void getAccInfo(string accNo)
        {
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);

            SqlDataAdapter adapter = new SqlDataAdapter("SELECT * FROM acc00h10 WHERE accountno = @accountno", con);
            adapter.SelectCommand.Parameters.AddWithValue("@accountno", accNo);



            DataTable dt = new DataTable();
            adapter.Fill(dt);
            foreach (DataRow dr in dt.Rows)
            {
                //GridEditableItem item = RadGrid1.EditItems;
                foreach (GridEditableItem item in RadGrid1.EditItems)
                {
                    RadTextBox txtCurr = item.FindControl("txt_cur") as RadTextBox;
                    //txtCurr.Text = dr["cur_code"].ToString();
                    txtCurr.Text = "Tess";
                }
                
            }
        }

        protected void cb_koRek_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT * FROM acc00h10 WHERE accountno +' '+ accountname = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["accountno"].ToString();
            dr.Close();

            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adapter.Fill(dt);
            foreach (DataRow dr1 in dt.Rows)
            {
                RadComboBox cb = (RadComboBox)sender;
                GridEditableItem item = (GridEditableItem)cb.NamingContainer;
                RadTextBox txtCurr = (RadTextBox)item.FindControl("txt_cur");
                //RadTextBox txtCurr = item.FindControl("txt_cur") as RadTextBox;
                txtCurr.Text = dr1["cur_code"].ToString();
            }
            con.Close();
        }

        protected void btn_new_Click(object sender, EventArgs e)
        {
            RadGrid1.MasterTableView.IsItemInserted = true;
            RadGrid1.MasterTableView.Rebind();
        }
    }
}