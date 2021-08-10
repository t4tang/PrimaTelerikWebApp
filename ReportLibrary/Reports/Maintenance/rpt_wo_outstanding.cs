namespace ReportLibrary.Reports.Maintenance.WO_Outstanding_Report
{
    using System;
    using System.ComponentModel;
    using System.Drawing;
    using System.Windows.Forms;
    using Telerik.Reporting;
    using Telerik.Reporting.Drawing;

    /// <summary>
    /// Summary description for rpt_wo_outstanding.
    /// </summary>
    public partial class rpt_wo_outstanding : Telerik.Reporting.Report
    {
        public static string _tr_code;
        public rpt_wo_outstanding()
        {

            //Required for telerik Reporting designer support


           InitializeComponent();


            //TODO: Add any constructor code after InitializeComponent call


            //Telerik.Reporting.ReportParameter param = new ReportParameter();
            //param.Name = "datenow";
            //param.Type = ReportParameterType.String;
            //param.AllowBlank = false;
            //param.AllowNull = false;
            //param.Value = _tr_code;
            //param.Visible = false;
            //this.Report.ReportParameters.Add(param);
            //sqlDataSource1.Parameters[0].Value = "=Parameters.datenow.Value";
        }
    }
}