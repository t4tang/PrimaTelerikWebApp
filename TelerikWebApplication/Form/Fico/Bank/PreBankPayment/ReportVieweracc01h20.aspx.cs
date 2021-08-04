using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.ReportViewer.Html5.WebForms;
using Telerik.Web.UI;
using TelerikWebApplication.Class;

namespace TelerikWebApplication.Form.Fico.Bank.PreBankPayment
{
    public partial class ReportVieweracc01h20 : System.Web.UI.Page
    {
        string tr_code = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Title = Request.QueryString["slip_no"];
            tr_code = Request.QueryString["slip_no"];

            if (!IsPostBack)
            {
                this.Title = tr_code;
                this.reportViewer1.ViewMode = ViewMode.PrintPreview;
                acc01h20_slip._tr_code = Request.QueryString["slip_no"];
            }
        }
    }
}