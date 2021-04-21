using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using Telerik.Web.UI.HtmlChart;
using Telerik.Web.UI.HtmlChart.Enums;

namespace TelerikWebApplication.Form.Reports
{
    public partial class ReportDashboard : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            //if (IsPostBack)
            //{
            int startAngleParsed = 0;
            Int32.TryParse("90", out startAngleParsed);
            PieSeries pieSeries = (PieSeries)PieChart1.PlotArea.Series[0];
            pieSeries.StartAngle = startAngleParsed;

            pieSeries.LabelsAppearance.Position =
                (Telerik.Web.UI.HtmlChart.PieAndDonutLabelsPosition)Enum.Parse(typeof(Telerik.Web.UI.HtmlChart.PieAndDonutLabelsPosition), "OutsideEnd");

            pieSeries.SeriesItems[0].Exploded = true;
            //}
            //else
            //{
            //    comboLabelsPositionChooser.DataSource = System.Enum.GetValues(typeof(Telerik.Web.UI.HtmlChart.PieAndDonutLabelsPosition));
            //    comboLabelsPositionChooser.DataBind();
            //    comboLabelsPositionChooser.SelectedIndex = 2;
            //}
            
        }
       
        protected void btn_prev_mtc_Click(object sender, ImageClickEventArgs e)
        {
            string script = " <script type=\"text/javascript\">  window.open('../Preventive_maintenance/Reports/dashboard.aspx');   </script> ";
            ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", script, false);
        }

        protected void btn_inventory_Click(object sender, ImageClickEventArgs e)
        {
            string script = " <script type=\"text/javascript\">  window.open('../Inventory/Reports/dashboard.aspx');   </script> ";
            ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", script, false);
        }

        protected void btn_purchase_Click(object sender, ImageClickEventArgs e)
        {
            string script = " <script type=\"text/javascript\">  window.open('../Purchase/Reports/dashboard.aspx');   </script> ";
            ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", script, false);
        }

        protected void btn_fico_Click(object sender, ImageClickEventArgs e)
        {
            string script = " <script type=\"text/javascript\">  window.open('../Fico/Reports/dashboard.aspx');   </script> ";
            ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", script, false);
        }

        protected void btn_production_Click(object sender, ImageClickEventArgs e)
        {
            string script = " <script type=\"text/javascript\">  window.open('../Production/Reports/dashboard.aspx');   </script> ";
            ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", script, false);
        }

        protected void btn_sales_Click(object sender, ImageClickEventArgs e)
        {
            string script = " <script type=\"text/javascript\">  window.open('../Sales/Reports/dashboard.aspx');   </script> ";
            ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", script, false);
        }

        protected void btn_home_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("Home.aspx");
        }
    }
}