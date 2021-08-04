namespace TelerikWebApplication.Form.Inventory.ReservationSlip.WithReff
{
    using System;
    using Telerik.ReportViewer.Html5.WebForms;

    public partial class ReportViewer_inv01h03 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Title = Request.QueryString["doc_code"];
            this.reportViewer_inv01h03.ViewMode = ViewMode.PrintPreview;
            inv01h03_slip._tr_code = Request.QueryString["doc_code"];
        }
    }
}