namespace TelerikWebApplication.Form.Inventory.GoodReceive
{
    using Class;
    using System;
    using System.ComponentModel;
    using System.Data.SqlClient;
    using System.Drawing;
    using Telerik.Reporting;
    using Telerik.Reporting.Drawing;

    /// <summary>
    /// Summary description for inv01h04_slip.
    /// </summary>
    public partial class inv01h04_slip : Telerik.Reporting.Report
    {
        public static string _tr_code;
        public inv01h04_slip()
        {
            //
            // Required for telerik Reporting designer support
            //
            InitializeComponent();
             //
            // TODO: Add any constructor code after InitializeComponent call
            //
            Telerik.Reporting.ReportParameter param = new ReportParameter();
            param.Name = "doc_code";
            param.Type = ReportParameterType.String;
            param.AllowBlank = false;
            param.AllowNull = false;
            param.Value = _tr_code;
            param.Visible = false;
            this.Report.ReportParameters.Add(param);

            sqlDataSource1.Parameters[0].Value = "=Parameters.doc_code.Value";

        }
    }
}