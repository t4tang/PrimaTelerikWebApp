namespace ReportLibrary.Reports.Fico
{
    using System;
    using System.ComponentModel;
    using System.Drawing;
    using System.Windows.Forms;
    using Telerik.Reporting;
    using Telerik.Reporting.Drawing;

    /// <summary>
    /// Summary description for Report1.
    /// </summary>
    [Description("Display the actual value compared to the budget in a specific year")]
    public partial class ActualVsBudgetYTD : Telerik.Reporting.Report
    {
        string currentYear = DateTime.Now.Year.ToString();
        public ActualVsBudgetYTD()
        {
            //
            // Required for telerik Reporting designer support
            //
            InitializeComponent();


            Telerik.Reporting.ReportParameter param1 = new ReportParameter();
            param1.Name = "Year";
            param1.Text = "Year";
            param1.Type = ReportParameterType.String;
            param1.AllowBlank = false;
            param1.AllowNull = false;
            param1.Value = currentYear;
            param1.Visible = true;
            param1.AutoRefresh = false;
            this.Report.ReportParameters.Add(param1);

            sqlDataSource1.Parameters[0].Value = "=Parameters.Year.Value";
        }
    }
}