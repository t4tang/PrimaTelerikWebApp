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
            cmd.CommandText = "SELECT acc00h31.KoTrans, acc00h31.TransName, acc00h31.tStatus, acc00h31.Lvl, acc00h31.Stamp, acc00h31.Usr, " +                              "acc00h31.Owner, acc00h31.OwnStamp, acc00h31.status, acc00h31.stEdit, acc00h10.accountname, acc00h10.cur_code, " +
                              "acc00h10.accountno FROM acc00h31 INNER JOIN acc00h10 ON acc00h31.korek = acc00h10.accountno";
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
            cmd.CommandText = "INSERT INTO acc00h31 (KoTrans, TransName, korek, tStatus, Lvl, Stamp, Usr, Owner, OwnStamp, stEdit) " +
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
            cmd.CommandText = "UPDATE acc00h31 SET TransName = @TransName, korek = @korek, tStatus = @tStatus, Lvl = @Lvl, Stamp = getdate (), " +
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
            cmd.CommandText = "update pur00h03 set stEdit = 4, LastUpdate = getdate(), userid = @userid where KoTrans = @KoTrans";
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
            if ((sender as RadComboBox).Text == "A/P")
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
            if ((sender as RadComboBox).Text == "A/P")
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
            SqlDataAdapter adapter = new SqlDataAdapter("select accountno +' - '+ accountname as accountname from acc00h10 where stEdit != '4' " +
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
            cmd.CommandText = "SELECT accountno FROM acc00h10 WHERE accountname = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["accountno"].ToString();
            dr.Close();
            con.Close();
        }

        protected void txt_acc_ledger_PreRender(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT accountno FROM acc00h10 WHERE accountname = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
                (sender as RadComboBox).SelectedValue = dr["accountno"].ToString();
            dr.Close();
            con.Close();
        }

        //protected void txt_acc_name_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        //{
        //    con.Open();
        //    SqlCommand cmd = new SqlCommand();
        //    cmd.Connection = con;
        //    cmd.CommandType = CommandType.Text;
        //    cmd.CommandText = "SELECT accountno FROM acc00h10 WHERE accountname = '" + (sender as RadComboBox).Text + "'";
        //    SqlDataReader dr;
        //    dr = cmd.ExecuteReader();
        //    while (dr.Read())
        //        (sender as RadComboBox).SelectedValue = dr["accountno"].ToString();
        //    dr.Close();
        //    con.Close();
        //}
    }
}