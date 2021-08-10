using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TelerikWebApplication.Class;
using ReportLibrary;

namespace TelerikWebApplication.Form.Purchase.Reports
{
    public partial class dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ReportManager._uid = public_str.user_id;
            ReportManager._mdl = "Purchase";
        }
    }
}