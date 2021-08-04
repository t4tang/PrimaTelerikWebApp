using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TelerikWebApplication.Form.Fico.Bank.BankReceipt
{
    using ReportLibrary.slip;
    using System;
    using Telerik.ReportViewer.Html5.WebForms;

    public partial class ReportVieweracc01h04 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (!IsPostBack)
            //{
                this.Title = Request.QueryString["slip_no"];
                this.reportViewer1.ViewMode = ViewMode.PrintPreview;
                acc01h04_slip._tr_code = Request.QueryString["slip_no"];
            //}
        }
    }
}