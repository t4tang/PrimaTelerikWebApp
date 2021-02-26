namespace ReportLibrary.Reports.Maintenance
{
    using System;
    using System.ComponentModel;
    using System.Drawing;
    using System.Windows.Forms;
    using Telerik.Reporting;
    using Telerik.Reporting.Drawing;

    /// <summary>
    /// Summary description for Rpt_MR_Supply.
    /// </summary>
    public partial class Rpt_MR_Supply : Telerik.Reporting.Report
    {

        public static string _project;
        public static DateTime _tglawal = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
        public static DateTime _tglakhir = DateTime.Now;
        public Rpt_MR_Supply()
        {
            InitializeComponent();

            Telerik.Reporting.ReportParameter param1 = new ReportParameter();
            param1.Name = "tglawal";
            param1.Text = "Date :";
            param1.Type = ReportParameterType.DateTime;
            param1.AllowBlank = false;
            param1.AllowNull = false;
            param1.Value = string.Format("{0:yyyy-MM-dd}", _tglawal);
            param1.Visible = true;
            this.Report.ReportParameters.Add(param1);

            Telerik.Reporting.ReportParameter param2 = new ReportParameter();
            param2.Name = "tglakhir";
            param2.Text = "To Date :";
            param2.Type = ReportParameterType.DateTime;
            param2.AllowBlank = false;
            param2.AllowNull = false;
            param2.Value = string.Format("{0:yyyy-MM-dd}", _tglakhir);
            param2.Visible = true;
            this.Report.ReportParameters.Add(param2);

            Telerik.Reporting.ReportParameter param3 = new ReportParameter();
            param3.Name = "project";
            param3.Text = "Project :";
            param3.Type = ReportParameterType.String;
            param3.AllowBlank = false;
            param3.AllowNull = false; param3.AvailableValues.DataSource = Jobsite;
            param3.AvailableValues.DisplayMember = "region_name";
            param3.AvailableValues.ValueMember = "region_code";
            param3.Value = _project;
            param3.Visible = true;
            this.Report.ReportParameters.Add(param3);

            sqlDataSource1.Parameters[1].Value = "=Parameters.tglawal.Value";
            sqlDataSource1.Parameters[2].Value = "=Parameters.tglakhir.Value";
            sqlDataSource1.Parameters[0].Value = "=Parameters.project.Value";
        }
    }
}