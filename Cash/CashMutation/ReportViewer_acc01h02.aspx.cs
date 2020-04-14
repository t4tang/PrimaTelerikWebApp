namespace TelerikWebApplication.Form.Fico.Cash.CashMutation
{
   
    using System;
    using Telerik.ReportViewer.Html5.WebForms;

    public partial class ReportViewer_acc01h02 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                this.Title = Request.QueryString["NoBuk"];
                this.reportViewer1.ViewMode = ViewMode.PrintPreview;
                acc01h02_slip._tr_code = Request.QueryString["NoBuk"];
            }
        }
    }
}