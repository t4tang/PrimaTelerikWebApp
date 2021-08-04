namespace TelerikWebApplication.Form.Fico.PaymentRequest.Entry
{
    using ReportLibrary;
    using ReportLibrary.slip;
    using System;
    using Telerik.ReportViewer.Html5.WebForms;

    public partial class reportViewer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                this.Title = Request.QueryString["doc_no"];
                this.reportViewer1.ViewMode = ViewMode.PrintPreview;
                acc01h05_slip._tr_code = Request.QueryString["doc_no"];
            }
        }
    }
}