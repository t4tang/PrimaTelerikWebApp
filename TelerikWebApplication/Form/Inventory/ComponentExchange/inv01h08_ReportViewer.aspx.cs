using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.ReportViewer.Html5.WebForms;

namespace TelerikWebApplication.Form.Inventory.ComponentExchange
{
    public partial class inv01h08_ReportViewer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Title = Request.QueryString["wip_code"];
            this.ReportViewer_inv01h08.ViewMode = ViewMode.PrintPreview;
            inv01h08_slip._tr_code = Request.QueryString["wip_code"];
        }
    }
}