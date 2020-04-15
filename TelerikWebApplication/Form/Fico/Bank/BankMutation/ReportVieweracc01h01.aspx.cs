namespace TelerikWebApplication.Form.Fico.Bank.BankMutation
{
    using ReportLibrary.slip;
    using System;
    using Telerik.ReportViewer.Html5.WebForms;

    public partial class ReportVieweracc01h01 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                this.Title = Request.QueryString["NoBuk"];
                this.reportViewer1.ViewMode = ViewMode.PrintPreview;
                acc01h01_slip._tr_code = Request.QueryString["NoBuk"];
            }
        }
    }
}