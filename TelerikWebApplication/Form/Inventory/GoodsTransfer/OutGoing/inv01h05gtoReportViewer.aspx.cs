using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.ReportViewer.Html5.WebForms;

namespace TelerikWebApplication.Form.Inventory.GoodsTransfer.OutGoing
{
    public partial class inv01h05gtoReportViewer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Title = Request.QueryString["do_code"];
            this.reportViewer_inv01h05gto.ViewMode = ViewMode.PrintPreview;
            inv01h05gto_slip._tr_code = Request.QueryString["do_code"];
        }
    }
}