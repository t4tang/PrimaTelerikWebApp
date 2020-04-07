namespace ReportLibrary
{
    using System;
    using System.ComponentModel;
    using System.Data.SqlClient;
    using System.Drawing;
    using System.Windows.Forms;
    using Telerik.Reporting;
    using Telerik.Reporting.Drawing;

    /// <summary>
    /// Summary description for payment_request_slip.
    /// </summary>
    public partial class acc01h05_slip : Telerik.Reporting.Report
	{        
        //SqlDataAdapter sda = new SqlDataAdapter();
        //SqlCommand cmd = new SqlCommand();
        public static string _tr_code;

        public acc01h05_slip()
		{
			//
			// Required for telerik Reporting designer support
			//
			InitializeComponent();

            //
            // TODO: Add any constructor code after InitializeComponent call
            //
            Telerik.Reporting.ReportParameter param = new ReportParameter();
            param.Name = "doc_no";
            param.Type = ReportParameterType.String;
            param.AllowBlank = false;
            param.AllowNull = false;
            param.Value = _tr_code;
            param.Visible = false;
            this.Report.ReportParameters.Add(param);

            sqlDataSource1.Parameters[0].Value = "=Parameters.doc_no.Value";
        }
	}
}