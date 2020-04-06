namespace TelerikWebApplication.Form.Inventory.UserRequest
{
    using System;
    using Telerik.ReportViewer.Html5.WebForms;

    public partial class reportViewer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (!IsPostBack)
            //{
                this.Title= Request.QueryString["doc_code"];
                this.reportViewer1.ViewMode = ViewMode.PrintPreview;
                inv01h01_slip._tr_code = Request.QueryString["doc_code"];
            //}
        }
    }
}