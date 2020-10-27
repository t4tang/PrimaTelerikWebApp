using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.ReportViewer.Html5.WebForms;

namespace TelerikWebApplication.Form.Preventive_maintenance.MaterialRequest
{
    public partial class inv01h02_ReportViewer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Title = Request.QueryString["sro_code"];
            this.ReportViewer_inv01h02.ViewMode = ViewMode.PrintPreview;
            inv01h02_slip._tr_code = Request.QueryString["sro_code"];
        }
    }
}