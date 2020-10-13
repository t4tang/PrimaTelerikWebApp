namespace FicoReportLibrary
{
    using System;
    using System.ComponentModel;
    using System.Drawing;
    using System.Windows.Forms;
    using Telerik.Reporting;
    using Telerik.Reporting.Drawing;

    /// <summary>
    /// Summary description for rpt_cash_bank_mutation.
    /// </summary>
    [Description("Show all transactions that occur on a Bank or Petty Cash Account in a certain period")]
    public partial class CashAndBankMutation : Telerik.Reporting.Report
    {
        //public static string _bank;
        public static DateTime _tglawal = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
        public static DateTime _tglakhir = DateTime.Now;

        public CashAndBankMutation()
        {
            //
            // Required for telerik Reporting designer support
            //
            InitializeComponent();

            //
            // TODO: Add any constructor code after InitializeComponent call
            //
            Telerik.Reporting.ReportParameter param1 = new ReportParameter();
            param1.Name = "tglawal";
            param1.Text = "Date :";
            param1.Type = ReportParameterType.DateTime;
            param1.AllowBlank = false;
            param1.AllowNull = false;
            param1.Value = string.Format("{0:yyyy-MM-dd}", _tglawal);
            param1.Visible = true;
            this.Report.ReportParameters.Add(param1);

            Telerik.Reporting.ReportParameter param2 = new ReportParameter();
            param2.Name = "tglakhir";
            param2.Text = "To Date :";
            param2.Type = ReportParameterType.DateTime;
            param2.AllowBlank = false;
            param2.AllowNull = false;
            //param2.Value = _tglawal;
            param2.Value = string.Format("{0:yyyy-MM-dd}", _tglakhir);
            param2.Visible = true;
            this.Report.ReportParameters.Add(param2);

            sqlDataSourceCashBankMutation.Parameters[0].Value = "=Parameters.tglawal.Value";
            sqlDataSourceCashBankMutation.Parameters[1].Value = "=Parameters.tglakhir.Value";
        }
    }
}