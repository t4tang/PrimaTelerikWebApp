using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.ReportViewer.Html5.WebForms;

namespace TelerikWebApplication.Form.Purchase.PurchaseExpenses
{
    public partial class acc01h13ReportViewer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Title = Request.QueryString["NoBuk"];
            this.reportViewer_acc01h13.ViewMode = ViewMode.PrintPreview;
            acc01h13_slip._tr_code = Request.QueryString["NoBuk"];
        }
    }
}