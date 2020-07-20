namespace TelerikWebApplication.Form.Inventory.GoodsIssued
{
    using System;
    using Telerik.ReportViewer.Html5.WebForms;

    public partial class ReportViewer_inv01h05 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (!IsPostBack)
            //{
                this.Title = Request.QueryString["do_code"];
                this.reportViewer_inv01h05.ViewMode = ViewMode.PrintPreview;
                inv01h05_slip._tr_code = Request.QueryString["do_code"];
            //}
        }
    }
}