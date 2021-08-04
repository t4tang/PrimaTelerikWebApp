namespace ReportLibrary
{
    using System;
    using System.ComponentModel;
    using System.Drawing;
    using System.Windows.Forms;
    using Telerik.Reporting;
    using Telerik.Reporting.Drawing;


    /// <summary>
    /// Summary description for rpt_payment_request_monitoring.
    /// </summary>
    /// 
    [Description("Displays All Payment Requested for a Departement")]
    public partial class FPPMonitoring : Telerik.Reporting.Report
    {
        public static string _project;
        //public static string _uid;
        public FPPMonitoring()
        {
           
            //
            // Required for telerik Reporting designer support
            //
            InitializeComponent();

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
            param2.Name = "uid";
            param2.Type = ReportParameterType.String;
            param2.AllowBlank = false;
            param2.AllowNull = false;
            param2.Value = ReportManager._uid;
            param2.Visible = false;
            this.Report.ReportParameters.Add(param2);

            Telerik.Reporting.ReportParameter param3 = new ReportParameter();
            param3.Name = "Vendor";
            param3.Type = ReportParameterType.String;
            param3.AllowBlank = false;
            param3.AllowNull = true;
            param3.Value = " ";
            param3.Visible = false;
            this.Report.ReportParameters.Add(param3);

            fpp_monitoring.Parameters[0].Value = "=Parameters.project.Value";
            fpp_monitoring.Parameters[1].Value = "=Parameters.uid.Value";
            fpp_monitoring.Parameters[2].Value = "=Parameters.vendor.Value";
        }
    }
}