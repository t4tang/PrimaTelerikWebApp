using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace TelerikWebApplication
{
    public partial class Contacts : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string[] folders = new string[] { "All (9)", "Favorites (0)", "Friends (0)", "Work (0)" };

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
        }
    }
}