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

namespace TelerikWebApplication.Form.DataStore.Finance.OtherARAP
{
    public partial class acc00h31 : System.Web.UI.Page
    {
        public static string koneksi = ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString;
        SqlConnection con = new SqlConnection(koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();
        private const int ItemsPerRequest = 10;
        //private RadComboBox sender;

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
            cmd.CommandText = "SELECT ms_other_apar.KoTrans, ms_other_apar.TransName, CASE (ms_other_apar.tStatus) WHEN 'R' THEN 'A/R' WHEN 'P' THEN 'A/P' " +
                              "ELSE 'Both' END AS tStatus, ms_other_apar.Lvl, ms_other_apar.Stamp, ms_other_apar.Usr, ms_other_apar.Owner, ms_other_apar.OwnStamp, " +
                              "ms_other_apar.status, ms_other_apar.stEdit, gl_account.accountname, gl_account.cur_code, " +
                              "gl_account.accountno +' - '+ gl_account.accountname as accountComb, gl_account.accountno FROM ms_other_apar INNER JOIN " +
                              "gl_account ON ms_other_apar.korek = gl_account.accountno WHERE ms_other_apar.stEdit !='4'";
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

        protected void RadGrid1_InsertCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            GridEditableItem item = (GridEditableItem)e.Item;
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "INSERT INTO ms_other_apar (KoTrans, TransName, korek, tStatus, Lvl, Stamp, Usr, Owner, OwnStamp, stEdit) " +
                              "VALUES (@KoTrans, @TransName, @korek, @tStatus, @Lvl, getdate(), @Usr, @Owner, getdate(), '0')";
            cmd.Parameters.AddWithValue("@KoTrans", (item.FindControl("txt_code") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@TransName", (item.FindControl("txt_name") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@korek", (item.FindControl("txt_acc_ledger") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@tStatus", (item.FindControl("cb_display") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@Lvl", public_str.level);
            cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
            cmd.Parameters.AddWithValue("@Owner", public_str.user_id);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void RadGrid1_UpdateCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            GridEditableItem item = (GridEditableItem)e.Item;
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "UPDATE ms_other_apar SET TransName = @TransName, korek = @korek, tStatus = @tStatus, Lvl = @Lvl, Stamp = getdate(), " +
                              "Usr = @Usr WHERE KoTrans = @KoTrans";
            cmd.Parameters.AddWithValue("@KoTrans", (item.FindControl("txt_code") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@TransName", (item.FindControl("txt_name") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@korek", (item.FindControl("txt_acc_ledger") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@tStatus", (item.FindControl("cb_display") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@Lvl", public_str.level);
            cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void RadGrid1_DeleteCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            var KoTrans = ((GridDataItem)e.Item).GetDataKeyValue("KoTrans");

            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "update ms_other_apar set stEdit = '4', Stamp = getdate(), Usr = @Usr where KoTrans = @KoTrans";
            cmd.Parameters.AddWithValue("@KoTrans", KoTrans);
            cmd.Parameters.AddWithValue("@Usr", public_str.user_id);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void RadGrid1_ItemCreated(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
            if (e.Item is GridEditableItem & e.Item.IsInEditMode)
            {
                GridEditFormItem item = (GridEditFormItem)e.Item;
                RadTextBox txt = (item.FindControl("txt_code") as RadTextBox);
                if (e.Item.OwnerTableView.IsItemInserted)
                    txt.Enabled = true;
                else
                    txt.Enabled = false;
            }
        }

        protected void cb_display_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Add("A/R");
            (sender as RadComboBox).Items.Add("A/P");
            (sender as RadComboBox).Items.Add("Both");
        }

        protected void cb_display_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if ((sender as RadComboBox).Text == "A/R")
            {
                (sender as RadComboBox).SelectedValue = "R";
            }
            else if ((sender as RadComboBox).Text == "A/P")
            {
                (sender as RadComboBox).SelectedValue = "P";
            }
            else
            {
                (sender as RadComboBox).SelectedValue = "B";
            }
        }

        protected void cb_display_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadComboBox).Text == "A/R")
            {
                (sender as RadComboBox).SelectedValue = "R";
            }
            else if ((sender as RadComboBox).Text == "A/P")
            {
                (sender as RadComboBox).SelectedValue = "P";
            }
            else
            {
                (sender as RadComboBox).SelectedValue = "B";
            }
        }

        public DataTable Get_acc_no(string Text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("select accountno +' - '+ accountname as accountname from gl_account where stEdit != '4' " +
                                                        "AND accountno +' - '+ accountname LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", Text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void txt_acc_ledger_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = Get_acc_no(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["accountname"].ToString(), data.Rows[i]["accountname"].ToString()));
            }

            e.Message = GetStatusMessage(endOffset, data.Rows.Count);
        }

        protected void txt_acc_ledger_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT * FROM gl_account WHERE accountno +' - '+ accountname = '" + (sender as RadComboBox).Text + "'";
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
                RadTextBox txt_curr = (RadTextBox)item.FindControl("txt_curr");
                //RadTextBox txtCurr = item.FindControl("txt_cur") as RadTextBox;
                txt_curr.Text = dr1["cur_code"].ToString();
            }
            con.Close();
        }

        protected void txt_acc_ledger_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT accountno FROM gl_account WHERE accountno +' - '+ accountname = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["accountno"].ToString();
            dr.Close();
            con.Close();
        }

        protected void btn_new_Click(object sender, EventArgs e)
        {
            RadGrid1.MasterTableView.IsItemInserted = true;
            RadGrid1.MasterTableView.Rebind();
        }

        //private void getAccInfo(string accNo)
        //{
        //    con.Open();
        //    SqlCommand cmd = new SqlCommand();
        //    cmd.Connection = con;
        //    cmd.CommandType = CommandType.Text;
        //    cmd.CommandText = "SELECT * FROM gl_account WHERE accountno +' '+ accountname = '" + (sender as RadComboBox).Text + "'";
        //    SqlDataReader dr;
        //    dr = cmd.ExecuteReader();
        //    while (dr.Read())
        //        (sender as RadComboBox).SelectedValue = dr["accountno"].ToString();
        //    dr.Close();

        //    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
        //    DataTable dt = new DataTable();
        //    adapter.Fill(dt);
        //    foreach (DataRow dr1 in dt.Rows)
        //    {
        //        RadComboBox cb = (RadComboBox)sender;
        //        GridEditableItem item = (GridEditableItem)cb.NamingContainer;
        //        RadTextBox txtCurr = (RadTextBox)item.FindControl("txt_curr");
        //        //RadTextBox txtCurr = item.FindControl("txt_cur") as RadTextBox;
        //        txtCurr.Text = dr1["cur_code"].ToString();
        //    }
        //    con.Close();
        //}
    }
}