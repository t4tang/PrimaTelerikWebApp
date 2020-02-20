using System;
using System.Data;
using System.Data.SqlClient;
using Telerik.Web.UI;
using TelerikWebApplication.Class;

namespace TelerikWebApplication.Controls
{
    public partial class FolderNavigationControl : System.Web.UI.UserControl
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                lbl_modul_name.Text = public_str.modul;

                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "sp_get_user_menu_by_modul";
                cmd.Parameters.AddWithValue("@uid", public_str.user_id);
                cmd.Parameters.AddWithValue("@modul", public_str.modul);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);

                DataSet links = new DataSet();

                sda.Fill(links);
                RadPanelBar1.DataTextField = "menu_description";
                RadPanelBar1.DataNavigateUrlField = "menu_url";
                RadPanelBar1.DataFieldID = "menu_id";
                RadPanelBar1.DataFieldParentID = "Parent_menu_id";


                RadPanelBar1.DataSource = links;
                RadPanelBar1.DataBind();
                RadPanelBar1.ExpandMode = Telerik.Web.UI.PanelBarExpandMode.SingleExpandedItem;

                //RadMenu1.DataTextField = "menu_description";
                //RadMenu1.DataNavigateUrlField = "menu_url";
                //RadMenu1.DataFieldID = "menu_id";
                //RadMenu1.DataFieldParentID = "Parent_menu_id";


                //RadMenu1.DataSource = links;
                //RadMenu1.DataBind();
            }


        }

        protected void RadPanelBar1_ItemClick(object sender, Telerik.Web.UI.RadPanelBarEventArgs e)
        {
            foreach (RadPanelItem item in RadPanelBar1.Items)
            {
                item.Expanded = false;
            }
            RadPanelBar1.Items[0].Expanded = true;
        }
    }
}