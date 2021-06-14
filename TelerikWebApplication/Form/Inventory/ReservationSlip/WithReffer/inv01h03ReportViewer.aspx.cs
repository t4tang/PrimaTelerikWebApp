namespace TelerikWebApplication.Form.Inventory.ReservationSlip.WithReffer
{
    using System;
    using Telerik.ReportViewer.Html5.WebForms;

    public partial class inv01h03mReportViewer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Title = Request.QueryString["doc_code"];
            this.ReportViewer1.ViewMode = ViewMode.PrintPreview;
            ReservationSlip.inv01h03_slip._tr_code = Request.QueryString["doc_code"];
        }
    }
}