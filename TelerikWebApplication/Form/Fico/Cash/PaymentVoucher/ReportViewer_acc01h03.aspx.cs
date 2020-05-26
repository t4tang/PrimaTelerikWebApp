namespace TelerikWebApplication.Form.Fico.Cash.PaymentVoucher
{
    using ReportLibrary;
    using ReportLibrary.slip;
    using System;
    using Telerik.ReportViewer.Html5.WebForms;

    public partial class ReportViewer_acc01h03 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                this.Title = Request.QueryString["slip_no"];
                //this.reportViewer1.ViewMode = ViewMode.PrintPreview;
                acc01h03_slip._tr_code = Request.QueryString["slip_no"];
            }
        }
    }
}