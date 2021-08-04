using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using Telerik.Web.Device.Detection;
using Telerik.Web.UI;
using TelerikWebApplication.Class;

namespace TelerikWebApplication
{
    public partial class MasterPage : System.Web.UI.MasterPage
    {

        SqlConnection con = new SqlConnection(db_connection.koneksi);
        public static string modul = null;
        public static string uid = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                modul = public_str.modul;
                uid = public_str.user_id;

                string title = this.Page.Title;
                RadMenuItem item = verticalMenu.FindItemByText(title);
                if (item != null)
                {
                    item.Selected = true;
                }

                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "sp_get_user_menu_by_modul";
                cmd.Parameters.AddWithValue("@uid", public_str.user_id);
                cmd.Parameters.AddWithValue("@modul", modul);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);

                DataSet links = new DataSet();

                sda.Fill(links);

                NavNode1.Text = null;
                //NavNode2.Text = public_str.selected_menu;
                lblServer.Text = "Server: "+ public_str.server_ip;
                lblPeriode.Text = "Periode: " + public_str.perstart + " - " + public_str.perend;
                lblUserInfo.Text = "Username: " + public_str.user_name + "  |  Your login time: " + public_str.login_time;
            }
        }

        protected override void OnInit(EventArgs e)
        {
            DeviceScreenDimensions screenDimensions = Detector.GetScreenDimensions(Request.UserAgent);
            LoadMobile(screenDimensions);
        }

        private void LoadMobile(DeviceScreenDimensions screenDimensions)
        {
            // Desktop Browser Detected
            if (screenDimensions.Height == 0 && screenDimensions.Width == 0)
            {
                var mobileNavigation = FolderContent.FindControl("MobileNavigation");
                if (mobileNavigation != null)
                {
                    mobileNavigation.Visible = false;
                    nav.Value = "desktop";
                }
            }
            // Mobile Browser Detected
            else
            {
                this.form1.Attributes.Add("class", "mobile clear");
                var desktopNavigation = FolderContent.FindControl("FolderNavigationControl");
                if (desktopNavigation != null)
                {
                    desktopNavigation.Visible = false;
                    nav.Value = "mobile";
                }
            }
        }
    }
}