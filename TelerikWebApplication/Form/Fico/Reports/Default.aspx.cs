using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ReportLibrary;
using TelerikWebApplication.Class;

namespace TelerikWebApplication.Form.Fico.Reports
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ReportManager._uid = public_str.user_id;
            ReportManager._mdl = "Fico";
            //FPPMonitoring._uid = public_str.user_id;
            //FicoReportLibrary.
        }
    }
}