namespace ReportLibrary.Reports.Fico
{
    using System;
    using System.ComponentModel;
    using System.Drawing;
    using System.Windows.Forms;
    using Telerik.Reporting;
    using Telerik.Reporting.Drawing;

    /// <summary>
    /// Summary description for rpt_AgingAP_Summary.
    /// </summary>
    public partial class AgingAPSummaryReport : Telerik.Reporting.Report
    {
        public static string _supplier;
        public static DateTime _tgl = DateTime.Now;
        public AgingAPSummaryReport()
        {
            InitializeComponent();

            Telerik.Reporting.ReportParameter param1 = new ReportParameter();
            param1.Name = "tgl";
            param1.Text = "Date :";
            param1.Type = ReportParameterType.DateTime;
            param1.AllowBlank = false;
            param1.AllowNull = false;
            param1.Value = string.Format("{0:yyyy-MM-dd}", _tgl);
            param1.Visible = true;
            this.Report.ReportParameters.Add(param1);

            Telerik.Reporting.ReportParameter param2 = new ReportParameter();
            param2.Name = "supplier_code";
            param2.Text = "Supplier :";
            param2.Type = ReportParameterType.String;
            param2.AllowBlank = false;
            param2.AllowNull = false; param2.AvailableValues.DataSource = Supplier;
            param2.AvailableValues.DisplayMember = "supplier_name";
            param2.AvailableValues.ValueMember = "supplier_code";
            param2.Value = _supplier;
            param2.Visible = true;
            this.Report.ReportParameters.Add(param2);

            sqlDataSource1.Parameters[0].Value = "=Parameters.tgl.Value";
            sqlDataSource1.Parameters[1].Value = "=Parameters.supplier_code.Value";
        }
    }
}