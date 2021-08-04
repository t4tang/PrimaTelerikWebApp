namespace ReportLibrary.Reports.Fico
{
    using System;
    using System.ComponentModel;
    using System.Drawing;
    using System.Windows.Forms;
    using Telerik.Reporting;
    using Telerik.Reporting.Drawing;

    /// <summary>
    /// Summary description for ActualVsBudget.
    /// </summary>
    [Description("Display the actual value compared to the budget in a given periode")]
    public partial class ActualVsBudget : Telerik.Reporting.Report
    {
        string currentYear = DateTime.Now.Year.ToString();
        string currentBulan = DateTime.Now.Month.ToString();
        public ActualVsBudget()
        {
            //
            // Required for telerik Reporting designer support
            //
            InitializeComponent();

            Telerik.Reporting.ReportParameter param1 = new ReportParameter();
            param1.Name = "Month";
            param1.Text = "Month";
            param1.Type = ReportParameterType.String;
            param1.AllowBlank = false;
            param1.AllowNull = false;
            param1.AvailableValues.DataSource = sds_month;
            param1.AvailableValues.DisplayMember = "Bulan";
            param1.AvailableValues.ValueMember = "Value";
            param1.Value = currentBulan;
            param1.Visible = true;
            param1.AutoRefresh = false;
            this.Report.ReportParameters.Add(param1);

            Telerik.Reporting.ReportParameter param2 = new ReportParameter();
            param2.Name = "Year";
            param2.Text = "Year";
            param2.Type = ReportParameterType.String;
            param2.AllowBlank = false;
            param2.AllowNull = false;
            param2.Value = currentYear;
            param2.Visible = true;
            param2.AutoRefresh = false;
            this.Report.ReportParameters.Add(param2);

            sqlDataSource1.Parameters[0].Value = "=Parameters.Month.Value";
            sqlDataSource1.Parameters[1].Value = "=Parameters.Year.Value";
        }
    }
}