using ReportLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TelerikWebApplication.Class;
//using TelerikWebApplication.Reports;

namespace TelerikWebApplication.Form.Purchase.Reports
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ReportManager._uid = public_str.user_id;
            ReportManager._mdl = "Purchase";
            //FPPMonitoring._uid = public_str.user_id;
            //FicoReportLibrary.
        }
    }
}