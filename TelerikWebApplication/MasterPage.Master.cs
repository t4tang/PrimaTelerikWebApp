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
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

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
                cmd.Parameters.AddWithValue("@modul", public_str.modul);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);

                DataSet links = new DataSet();

                sda.Fill(links);

                NavNode1.Text = public_str.user_name;
                //NavNode2.Text = public_str.selected_menu;

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