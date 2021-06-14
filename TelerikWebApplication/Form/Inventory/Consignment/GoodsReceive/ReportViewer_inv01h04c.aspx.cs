namespace TelerikWebApplication.Form.Inventory.Consignment.GoodsReceive
{
    using System;
    using Telerik.ReportViewer.Html5.WebForms;

    public partial class ReportViewer_inv01h04c : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (!IsPostBack)
            //{
            this.Title = Request.QueryString["lbm_code"];
            inv01h04c_slip._tr_code = Request.QueryString["lbm_code"];
            //}
        }
    }
}