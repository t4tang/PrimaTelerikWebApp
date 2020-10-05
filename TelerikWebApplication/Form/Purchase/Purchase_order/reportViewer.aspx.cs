namespace TelerikWebApplication.Form.Purchase.Purchase_order
{
    using Forms.Purchase.Purchase_order;
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Web;
    using System.Web.UI;
    using System.Web.UI.WebControls;
    using Telerik.ReportViewer.Html5.WebForms;
    public partial class reportViewer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Title = Request.QueryString["po_code"];
            this.reportViewer1.ViewMode = ViewMode.PrintPreview;
            pur01h02_slip._tr_code = Request.QueryString["po_code"];
            //pur01h02_slip._tr_code = "PO0318120289";
        }
    }
}