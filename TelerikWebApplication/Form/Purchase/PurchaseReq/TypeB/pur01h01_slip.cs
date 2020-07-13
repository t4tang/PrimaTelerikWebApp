namespace TelerikWebApplication.Form.Purchase.PurchaseReq
{
    using System;
    using System.ComponentModel;
    using System.Drawing;
    using System.Windows.Forms;
    using Telerik.Reporting;
    using Telerik.Reporting.Drawing;

    /// <summary>
    /// Summary description for pur01h01_slip.
    /// </summary>
    public partial class pur01h01_slip : Telerik.Reporting.Report
    {
        public static string _tr_code;

        public pur01h01_slip()
        {
            //
            // Required for telerik Reporting designer support
            //
            InitializeComponent();

            //
            // TODO: Add any constructor code after InitializeComponent call
            //

            Telerik.Reporting.ReportParameter param = new ReportParameter();
            param.Name = "pr_code";
            param.Type = ReportParameterType.String;
            param.AllowBlank = false;
            param.AllowNull = false;
            param.Value = _tr_code;
            param.Visible = false;
            this.Report.ReportParameters.Add(param);

            sqlDataSource2.Parameters[0].Value = "=Parameters.pr_code.Value";
        }
    }
}