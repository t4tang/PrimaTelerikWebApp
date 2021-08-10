using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.ReportViewer.Html5.WebForms;

namespace TelerikWebApplication.Form.Purchase.Purchase_service
{
    public partial class pur01h02srvReportViewer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Title = Request.QueryString["po_code"];
            this.reportViewer_pur010h02srv.ViewMode = ViewMode.PrintPreview;
            pur01h02srv_slip._tr_code = Request.QueryString["po_code"];
        }
    }
}