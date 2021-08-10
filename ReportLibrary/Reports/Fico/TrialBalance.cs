namespace FicoReportLibrary
{
    using System;
    using System.ComponentModel;
    using System.Drawing;
    using System.Windows.Forms;
    using Telerik.Reporting;
    using Telerik.Reporting.Drawing;

    /// <summary>
    /// Summary description for TrialBalance.
    /// </summary>
    [Description("Displays the balance of each account, including the initial balance, movements, and ending balance of the specified period")]
    public partial class TrialBalance : Telerik.Reporting.Report
	{
        string currentYear = DateTime.Now.Year.ToString();
        string currentBulan = DateTime.Now.Month.ToString();
        //string currentYear ="2019";
        //string currentBulan = "11";
        public TrialBalance()
		{
			//
			// Required for telerik Reporting designer support
			//
			InitializeComponent();

            //
            // TODO: Add any constructor code after InitializeComponent call
            //
            
            Telerik.Reporting.ReportParameter param1 = new ReportParameter();
            param1.Name = "Month";
            param1.Text = "Month";
            param1.Type = ReportParameterType.String;
            param1.AllowBlank = false;
            param1.AllowNull = false;
            param1.AvailableValues.DataSource = sds_month;
            param1.AvailableValues.DisplayMember = "Bulan";
            param1.AvailableValues.ValueMember = "ID";
            param1.Value = currentBulan;
            param1.Visible = true;
            param1.AutoRefresh = true;
            this.Report.ReportParameters.Add(param1);

            Telerik.Reporting.ReportParameter param2 = new ReportParameter();
            param2.Name = "Year";
            param2.Text = "Year";
            param2.Type = ReportParameterType.String;
            param2.AllowBlank = false;
            param2.AllowNull = false;
            param2.Value = currentYear;
            param2.Visible = true;
            param2.AutoRefresh = true;
            this.Report.ReportParameters.Add(param2);

            sqlDataSource1.Parameters[0].Value = "=Parameters.Month.Value";
            sqlDataSource1.Parameters[1].Value = "=Parameters.Year.Value";
        }
	}
}