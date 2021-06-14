namespace ReportLibrary.Reports.Inventory
{
    using System;
    using System.ComponentModel;
    using System.Drawing;
    using System.Windows.Forms;
    using Telerik.Reporting;
    using Telerik.Reporting.Drawing;

    /// <summary>
    /// Summary description for SummaryStockInOutReport.
    /// </summary>
    /// 
    [Description("Display Work Order or User Request status in a given periode")]
    public partial class SummaryStockInOut : Telerik.Reporting.Report
    {
        public static string _warehouse;
        public static DateTime _firstDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
        public static DateTime _endDate = DateTime.Now;

        public SummaryStockInOut()
        {
            //
            // Required for telerik Reporting designer support
            //
            InitializeComponent();

            //
            // TODO: Add any constructor code after InitializeComponent call
            //
            Telerik.Reporting.ReportParameter param1 = new ReportParameter();
            param1.Name = "tglawal";
            param1.Text = "Date :";
            param1.Type = ReportParameterType.DateTime;
            param1.AllowBlank = false;
            param1.AllowNull = false;
            param1.Value = string.Format("{0:yyyy-MM-dd}", _firstDate);
            param1.Visible = true;
            this.Report.ReportParameters.Add(param1);

            Telerik.Reporting.ReportParameter param2 = new ReportParameter();
            param2.Name = "tglakhir";
            param2.Text = "To Date :";
            param2.Type = ReportParameterType.DateTime;
            param2.AllowBlank = false;
            param2.AllowNull = false;
            //param2.Value = _tglawal;
            param2.Value = string.Format("{0:yyyy-MM-dd}", _endDate);
            param2.Visible = true;
            this.Report.ReportParameters.Add(param2);

            Telerik.Reporting.ReportParameter param3 = new ReportParameter();
            param3.Name = "warehouse";
            param3.Text = "Warehouse :";
            param3.Type = ReportParameterType.String;
            param3.AllowBlank = false;
            param3.AllowNull = false; param3.AvailableValues.DataSource = WareHouse;
            param3.AvailableValues.DisplayMember = "wh_name";
            param3.AvailableValues.ValueMember = "wh_code";
            param3.Value = _warehouse;
            param3.Visible = true;
            this.Report.ReportParameters.Add(param3);

            sqlSummaryStockInOutReport.Parameters[1].Value = "=Parameters.tglawal.Value";
            sqlSummaryStockInOutReport.Parameters[2].Value = "=Parameters.tglakhir.Value";
            sqlSummaryStockInOutReport.Parameters[0].Value = "=Parameters.warehouse.Value";
        }
    }
}