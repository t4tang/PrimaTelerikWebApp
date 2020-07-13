namespace TelerikWebApplication.Form.Purchase.PurchaseReq
{
    using System;
    using System.ComponentModel;
    using System.Drawing;
    using System.Windows.Forms;
    using Telerik.Reporting;
    using Telerik.Reporting.Drawing;

    /// <summary>
    /// Summary description for pur01h01a_slip.
    /// </summary>
    public partial class pur01h01typeA_slip : Telerik.Reporting.Report
    {
        public static string _tr_code = null;
        public pur01h01typeA_slip()
        {
            //
            // Required for telerik Reporting designer support
            //
            InitializeComponent();
            Telerik.Reporting.ReportParameter param = new ReportParameter();
            param.Name = "doc_no";
            param.Type = ReportParameterType.String;
            param.AllowBlank = false;
            param.AllowNull = false;
            param.Value = _tr_code;
            param.Visible = false;
            this.Report.ReportParameters.Add(param);

            sqlDataSource1.Parameters[0].Value = "=Parameters.doc_no.Value";
            //
            // TODO: Add any constructor code after InitializeComponent call
            //
        }
    }
}