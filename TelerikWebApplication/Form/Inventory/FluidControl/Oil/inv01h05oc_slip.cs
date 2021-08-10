namespace TelerikWebApplication.Form.Inventory.FluidControl.Oil
{
    using System;
    using System.ComponentModel;
    using System.Drawing;
    using System.Windows.Forms;
    using Telerik.Reporting;
    using Telerik.Reporting.Drawing;

    /// <summary>
    /// Summary description for inv01h05oc_slip.
    /// </summary>
    public partial class inv01h05oc_slip : Telerik.Reporting.Report
    {
        public static string _tr_code;

        public inv01h05oc_slip()
        {
            //
            // Required for telerik Reporting designer support
            //
            InitializeComponent();

            //
            // TODO: Add any constructor code after InitializeComponent call
            //
            Telerik.Reporting.ReportParameter param = new ReportParameter();
            param.Name = "do_code";
            param.Type = ReportParameterType.String;
            param.AllowBlank = false;
            param.AllowNull = false;
            param.Value = _tr_code;
            param.Visible = false;
            this.Report.ReportParameters.Add(param);

            sqlOilConsumption.Parameters[0].Value = "=Parameters.do_code.Value";
        }
    }
}