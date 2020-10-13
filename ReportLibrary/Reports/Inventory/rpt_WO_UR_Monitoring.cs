namespace ReportLibrary.Reports
{
    using System;
    using System.ComponentModel;
    using System.Drawing;
    using System.Windows.Forms;
    using Telerik.Reporting;
    using Telerik.Reporting.Drawing;

    /// <summary>
    /// Summary description for rpt_WO_UR_Monitoring.
    /// </summary>
    [Description("Display Work Order or User Request status in a given periode")]
    public partial class WorkOrderAndUserRequestMonitoring : Telerik.Reporting.Report
    {
        public static string _project;
        public static DateTime _firstDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
        public static DateTime _endDate = DateTime.Now;
        public static Double _tglawal;
        public static Double _tglakhir;
        public WorkOrderAndUserRequestMonitoring()
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

            //_tglawal = int.Parse(_firstDate.Year.ToString() + _firstDate.Month.ToString() + _firstDate.Day.ToString());
            //_tglakhir = int.Parse(_endDate.Year.ToString() + _endDate.Month.ToString() + _endDate.Day.ToString());

            sqlDataSourceWOURMonitoring.Parameters[0].Value = "=Parameters.tglawal.Value";
            sqlDataSourceWOURMonitoring.Parameters[1].Value = "=Parameters.tglakhir.Value";
            sqlDataSourceWOURMonitoring.Parameters[2].Value = "=Parameters.project.Value";
        }
    }
}