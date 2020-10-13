namespace FicoReportLibrary
{
    using System;
    using System.ComponentModel;
    using System.Drawing;
    using System.Windows.Forms;
    using Telerik.Reporting;
    using Telerik.Reporting.Drawing;

    /// <summary>
    /// Summary description for rpt_bank_mutation.
    /// </summary>
    /// 
    [Description("Show all transactions that occur on a bank account in a certain period")]
    public partial class BankMutation : Telerik.Reporting.Report
    {
        public static string _bank = "B05";
        public static DateTime _tglawal = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
        public static DateTime _tglakhir = DateTime.Now;

        public BankMutation()
        {
            //
            // Required for telerik Reporting designer support
            //
            InitializeComponent();


            ////
            //// TODO: Add any constructor code after InitializeComponent call
            ////
            Telerik.Reporting.ReportParameter param1 = new ReportParameter();
            param1.Name = "tglawal";
            param1.Text = "Date";
            param1.Type = ReportParameterType.DateTime;
            param1.AllowBlank = false;
            param1.AllowNull = false;
            param1.Value = string.Format("{0:yyyy-MM-dd}", _tglawal);
            param1.Visible = true;
            this.Report.ReportParameters.Add(param1);

            Telerik.Reporting.ReportParameter param2 = new ReportParameter();
            param2.Name = "tglakhir";
            param2.Text = "To Date";
            param2.Type = ReportParameterType.DateTime;
            param2.AllowBlank = false;
            param2.AllowNull = false;
            param2.Value = string.Format("{0:yyyy-MM-dd}", _tglakhir);
            param2.Visible = true;
            this.Report.ReportParameters.Add(param2);

            Telerik.Reporting.ReportParameter param3 = new ReportParameter();
            param3.Name = "bank";
            param3.Text = "Bank";
            param3.Type = ReportParameterType.String;
            param3.AllowBlank = false;
            param3.AllowNull = false;
            param3.AvailableValues.DataSource = sds_bank;
            param3.AvailableValues.DisplayMember = "NamBank";
            param3.AvailableValues.ValueMember = "KoBank";
            param3.Value = _bank;
            param3.Visible = true;
            this.Report.ReportParameters.Add(param3);

            sds_bank_mutation.Parameters[0].Value = "=Parameters.tglawal.Value";
            sds_bank_mutation.Parameters[1].Value = "=Parameters.tglakhir.Value";
            sds_bank_mutation.Parameters[2].Value = "=Parameters.bank.Value";
        }
    }
}