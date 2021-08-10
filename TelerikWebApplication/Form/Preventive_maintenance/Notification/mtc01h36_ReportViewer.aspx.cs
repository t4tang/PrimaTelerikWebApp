using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.ReportViewer.Html5.WebForms;

namespace TelerikWebApplication.Form.Preventive_maintenance.Notification
{
    public partial class mtc01h36_ReportViewer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Title = Request.QueryString["PM_id"];
            this.ReportViewer_mtc01h36.ViewMode = ViewMode.PrintPreview;
            mtc01h36_slip._tr_code = Request.QueryString["PM_id"];
        }
    }
}