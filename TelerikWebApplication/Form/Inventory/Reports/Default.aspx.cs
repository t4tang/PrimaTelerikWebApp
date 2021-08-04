using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
//using TelerikWebApplication.Reports;
using TelerikWebApplication.Class;
using ReportLibrary;

namespace TelerikWebApplication.Form.Inventory.Reports
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ReportManager._uid = public_str.user_id;
            ReportManager._mdl = "Inventory";
            //FPPMonitoring._uid = public_str.user_id;
            //FicoReportLibrary.
        }
    }
}