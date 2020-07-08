namespace TelerikWebApplication.Form.Purchase.Purchase_order
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Web;
    using System.Web.UI;
    using System.Web.UI.WebControls;
    using Telerik.ReportViewer.Html5.WebForms;
    using ReportLibrary.slip;
    public partial class reportViewer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Title = Request.QueryString["doc_code"];
            this.reportViewer1.ViewMode = ViewMode.PrintPreview;
            pur01h02_slip._tr_code = Request.QueryString["doc_code"];
        }
    }
}