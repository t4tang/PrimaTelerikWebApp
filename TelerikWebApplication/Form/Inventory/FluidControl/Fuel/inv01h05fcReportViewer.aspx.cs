using ReportLibrary.slip;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.ReportViewer.Html5.WebForms;

namespace TelerikWebApplication.Form.Inventory.FluidControl.Fuel
{
    public partial class inv01h05fcReportViewer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Title = Request.QueryString["do_code"];
            this.reportViewer_inv01h05fc.ViewMode = ViewMode.PrintPreview;
            inv01h05fc_slip._tr_code = Request.QueryString["do_code"]; 
        }
    }
}