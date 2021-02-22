namespace ReportLibrary.Reports.Maintenance.Machine_Condition
{
    using System;
    using System.ComponentModel;
    using System.Drawing;
    using System.Windows.Forms;
    using Telerik.Reporting;
    using Telerik.Reporting.Drawing;

    /// <summary>
    /// Summary description for MachineConditionReport.
    /// </summary>
    public partial class MachineConditionReport : Telerik.Reporting.Report
    {
        public static string _trans_id;
        public MachineConditionReport()
        {
            //
            // Required for telerik Reporting designer support
            //
            InitializeComponent();

            //
            // TODO: Add any constructor code after InitializeComponent call
            //
            Telerik.Reporting.ReportParameter param = new ReportParameter();
            param.Name = "transID";
            param.Type = ReportParameterType.String;
            param.AllowBlank = false;
            param.AllowNull = false;
            param.Value = _trans_id;
            param.Visible = false;
            this.Report.ReportParameters.Add(param);
            sqlDataSource1.Parameters[0].Value = "=Parameters.transID.Value";
        }
    }
}