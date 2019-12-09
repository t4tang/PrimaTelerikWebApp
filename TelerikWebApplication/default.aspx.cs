using System;
using System.Collections.Generic;
using System.Linq;
using Telerik.Web.UI;

namespace TelerikWebApplication
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //string[] folders = new string[] { "Inbox (5)", "Junk (0)", "Drafts (0)", "Deleted (0)", "NativeScript (3)", "Kendo UI (3)", "Sitefinity (7)" };

            //if (!IsPostBack)
            //{
            //    // Populate the Desktop TreeView control
            //    RadTreeView tree = (RadTreeView)FolderNavigationControl.FindControl("rtvFolders");

            //    foreach (string folder in folders)
            //    {
            //        tree.Nodes.Add(new RadTreeNode(folder));
            //    }

            //    // Populate the Mobile RadMenu control

            //    RadMenu menu = (RadMenu)MobileNavigation.FindControl("popupMenu");
            //    foreach (string folder in folders)
            //    {
            //        menu.Items.Add(new RadMenuItem(folder));
            //    }
            //}
        }

        protected void messages_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            string lorem = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

            DateTime date = DateTime.Now;
            List<Message> messagesList = new List<Message>();

            for (int i = 0; i < 30; i++)
            {
                Message msg = new Message()
                {
                    MessageID = i,
                    Body = lorem,
                    Received = i % 2 == 0 ? date : date.AddDays(2),
                    From = "John.Doe@telerik.com",
                    Subject = "Telerik WebMail"
                };

                messagesList.Add(msg);
            }

            //messages.DataSource = messagesList;
        }
    }

    public class Message
    {
        public int MessageID { get; set; }
        public string Body { get; set; }
        public string From { get; set; }
        public string Email { get; set; }
        public string Subject { get; set; }
        public DateTime Received { get; set; }
    }
}