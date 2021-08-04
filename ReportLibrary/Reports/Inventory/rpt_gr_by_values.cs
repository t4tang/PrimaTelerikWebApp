namespace ReportLibrary.Reports.Inventory
{
    using System;
    using System.ComponentModel;
    using System.Drawing;
    using System.Windows.Forms;
    using Telerik.Reporting;
    using Telerik.Reporting.Drawing;

    /// <summary>
    /// Summary description for rpt_gr_by_values.
    /// </summary>
    [Description("Menampilkan seluruh transaksi Penerimaan Barang Per Transaksi sesuai project dan periode tertentu")]
    public partial class rpt_gr_by_values : Telerik.Reporting.Report
    {
        public static string _project;
        public static DateTime _tglawal = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
        public static DateTime _tglakhir = DateTime.Now;
        public rpt_gr_by_values()
        {
            //
            // Required for telerik Reporting designer support
            //
            InitializeComponent();

            //
            // TODO: Add any constructor code after InitializeComponent call
            //
            Telerik.Reporting.ReportParameter param1 = new ReportParameter();
            param1.Name = "project";
            param1.Text = "Project :";
            param1.Type = ReportParameterType.String;
            param1.AllowBlank = false;
            param1.AllowNull = false; param1.AvailableValues.DataSource = Jobsite;
            param1.AvailableValues.DisplayMember = "region_name";
            param1.AvailableValues.ValueMember = "region_code";
            param1.Value = _project;
            param1.Visible = true;
            this.Report.ReportParameters.Add(param1);

            Telerik.Reporting.ReportParameter param2 = new ReportParameter();
            param2.Name = "tglawal";
            param2.Text = "Date :";
            param2.Type = ReportParameterType.DateTime;
            param2.AllowBlank = false;
            param2.AllowNull = false;
            param2.Value = string.Format("{0:yyyy-MM-dd}", _tglawal);
            param2.Visible = true;
            this.Report.ReportParameters.Add(param2);

            Telerik.Reporting.ReportParameter param3 = new ReportParameter();
            param3.Name = "tglakhir";
            param3.Text = "To Date :";
            param3.Type = ReportParameterType.DateTime;
            param3.AllowBlank = false;
            param3.AllowNull = false;
            param3.Value = string.Format("{0:yyyy-MM-dd}", _tglakhir);
            param3.Visible = true;
            this.Report.ReportParameters.Add(param3);

            sqlDataSourceGRReport.Parameters[0].Value = "=Parameters.project.Value";
            sqlDataSourceGRReport.Parameters[1].Value = "=Parameters.tglawal.Value";
            sqlDataSourceGRReport.Parameters[2].Value = "=Parameters.tglakhir.Value";
        }
    }
}