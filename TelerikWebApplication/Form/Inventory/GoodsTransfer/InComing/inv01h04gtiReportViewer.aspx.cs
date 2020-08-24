using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.ReportViewer.Html5.WebForms;

namespace TelerikWebApplication.Form.Inventory.GoodsTransfer.InComing
{
    public partial class inv01h04gtiReportViewer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Title = Request.QueryString["lbm_code"];
            this.reportViewer_inv01h04gti.ViewMode = ViewMode.PrintPreview;
            inv01h04gti_slip._tr_code = Request.QueryString["lbm_code"];
        }
    }
}