namespace TelerikWebApplication.Form.Inventory.GoodsTransfer.InComing
{
    using System;
    using System.ComponentModel;
    using System.Drawing;
    using System.Windows.Forms;
    using Telerik.Reporting;
    using Telerik.Reporting.Drawing;

    /// <summary>
    /// Summary description for inv01h04gti_slip.
    /// </summary>
    public partial class inv01h04gti_slip : Telerik.Reporting.Report
    {
        public static string _tr_code;

        public inv01h04gti_slip()
        {
            //
            // Required for telerik Reporting designer support
            //
            InitializeComponent();

            //
            // TODO: Add any constructor code after InitializeComponent call
            //
            Telerik.Reporting.ReportParameter param = new ReportParameter();
            param.Name = "lbm_code";
            param.Type = ReportParameterType.String;
            param.AllowBlank = false;
            param.AllowNull = false;
            param.Value = "MT0319110048";
            param.Visible = false;
            this.Report.ReportParameters.Add(param);

            sqlDataSource1.Parameters[0].Value = "=Parameters.lbm_code.Value";
        }
    }
}