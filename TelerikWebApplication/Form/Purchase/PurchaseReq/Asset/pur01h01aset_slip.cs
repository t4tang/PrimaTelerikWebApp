namespace TelerikWebApplication.Form.Purchase.PurchaseReq.Asset
{
    using System;
    using System.ComponentModel;
    using System.Drawing;
    using System.Windows.Forms;
    using Telerik.Reporting;
    using Telerik.Reporting.Drawing;

    /// <summary>
    /// Summary description for pur01h01aset_slip.
    /// </summary>
    public partial class pur01h01aset_slip : Telerik.Reporting.Report
    {
        public static string _tr_code;

        public pur01h01aset_slip()
        {
            //
            // Required for telerik Reporting designer support
            //
            InitializeComponent();
            Telerik.Reporting.ReportParameter param = new ReportParameter();
            param.Name = "pr_code";
            param.Type = ReportParameterType.String;
            param.AllowBlank = false;
            param.AllowNull = false;
            param.Value = "PR0121030007";
            param.Visible = false;
            this.Report.ReportParameters.Add(param);

            sqlPR_Asset.Parameters[0].Value = "=Parameters.pr_code.Value";

            //
            // TODO: Add any constructor code after InitializeComponent call
            //
        }
    }
}