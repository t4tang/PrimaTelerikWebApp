using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.ReportViewer.Html5.WebForms;

namespace TelerikWebApplication.Form.Preventive_maintenance.MechanicActivity
{
    public partial class reportViewer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Title = Request.QueryString["jobno"];
            this.reportViewer1.ViewMode = ViewMode.PrintPreview;
            mtc01h02_slip._tr_code = Request.QueryString["jobno"];
        }
    }
}