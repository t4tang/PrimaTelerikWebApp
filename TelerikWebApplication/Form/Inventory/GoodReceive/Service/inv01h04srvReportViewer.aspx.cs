using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TelerikWebApplication.Form.Inventory.GoodReceive.Service
{
    using ReportLibrary.slip;
    using System;
    using Telerik.ReportViewer.Html5.WebForms;
    public partial class inv01h04srvReportViewer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Title = Request.QueryString["lbm_code"];
            this.reportViewer_inv01h04.ViewMode = ViewMode.PrintPreview;
            inv01h04srv_slip._tr_code = Request.QueryString["lbm_code"];
        }
    }
}