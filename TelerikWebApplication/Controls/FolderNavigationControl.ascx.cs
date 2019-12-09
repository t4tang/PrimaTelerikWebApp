using System;
using System.Data;
using System.Data.SqlClient;
using TelerikWebApplication.Class;

namespace TelerikWebApplication.Controls
{
    public partial class FolderNavigationControl : System.Web.UI.UserControl
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        protected void Page_Load(object sender, EventArgs e)
        {
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
        }
    }
}