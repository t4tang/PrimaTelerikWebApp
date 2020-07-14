using ReportLibrary.slip;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.ReportViewer.Html5.WebForms;

namespace TelerikWebApplication.Form.Purchase.PurchaseReq
{
    public partial class pur01h01aReportViewer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Title = Request.QueryString["doc_code"];
            this.reportViewer1.ViewMode = ViewMode.PrintPreview;
            pur01h01typeA_slip._tr_code = Request.QueryString["doc_code"];
        }
    }
}