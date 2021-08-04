using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace TelerikWebApplication
{
    public partial class Calendar : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string[] folders = new string[] { "Personal (1)", "Work (5)", "Development (0)", "Design (2)", "Marketing (2)" };

            if (!IsPostBack)
            {
                // Populate the Desktop TreeView control
                RadTreeView tree = (RadTreeView)FolderNavigationControl.FindControl("rtvFolders");

                foreach (string folder in folders)
                {
                    tree.Nodes.Add(new RadTreeNode(folder));
                }

                // Populate the Mobile RadMenu control

                RadMenu menu = (RadMenu)MobileNavigation.FindControl("popupMenu");
                foreach (string folder in folders)
                {
                    menu.Items.Add(new RadMenuItem(folder));
                }
            }

            // Hide Calendar for Mobile Devices
            if ((this.Master.FindControl("nav") as HiddenField).Value == "mobile")
                RadCalendar1.Visible = false;
        }
    }
}