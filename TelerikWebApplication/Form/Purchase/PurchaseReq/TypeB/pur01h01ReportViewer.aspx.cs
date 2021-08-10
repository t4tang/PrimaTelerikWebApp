using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.ReportViewer.Html5.WebForms;

namespace TelerikWebApplication.Form.Purchase.PurchaseReq
{
    public partial class pur01h01ReportViewer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Title = Request.QueryString["pr_code"];
            this.reportViewer_pur01h01.ViewMode = ViewMode.PrintPreview;
            pur01h01_slip._tr_code = Request.QueryString["pr_code"];
        }
    }
}