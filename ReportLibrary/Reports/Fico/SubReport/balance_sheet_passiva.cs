namespace ReportLibrary.Reports.Fico.SubReport
{
    using System;
    using System.ComponentModel;
    using System.Drawing;
    using System.Windows.Forms;
    using Telerik.Reporting;
    using Telerik.Reporting.Drawing;

    [Browsable(false)]
    /// <summary>
    /// Summary description for balance_sheet_activa.
    /// </summary>
    public partial class balance_sheet_passiva : Telerik.Reporting.Report
    {
        //public static string currentBulan = "1";
        //public static string currentYear="2019";

        public balance_sheet_passiva()
        {
            //
            // Required for telerik Reporting designer support
            //
            InitializeComponent();

            //Telerik.Reporting.ReportParameter param1 = new ReportParameter();
            //param1.Name = "Month";
            //param1.Text = "Month";
            //param1.Type = ReportParameterType.String;
            //param1.AllowBlank = false;
            //param1.AllowNull = false;
            //param1.AvailableValues.DataSource = sds_month;
            //param1.AvailableValues.DisplayMember = "Bulan";
            //param1.AvailableValues.ValueMember = "ID";
            //param1.Value = currentBulan;
            //param1.Visible = true;
            //param1.AutoRefresh = true;
            //this.Report.ReportParameters.Add(param1);

            //Telerik.Reporting.ReportParameter param2 = new ReportParameter();
            //param2.Name = "Year";
            //param2.Text = "Year";
            //param2.Type = ReportParameterType.String;
            //param2.AllowBlank = false;
            //param2.AllowNull = false;
            //param2.Value = currentYear;
            //param2.Visible = true;
            //param2.AutoRefresh = true;
            //this.Report.ReportParameters.Add(param2);

            //Telerik.Reporting.ReportParameter param3 = new ReportParameter();
            //param3.Name = "Type";
            //param3.Type = ReportParameterType.String;
            //param3.AllowBlank = false;
            //param3.AllowNull = false;
            //param3.Value = "P";
            //param3.Visible = false;
            //param3.AutoRefresh = true;
            //this.Report.ReportParameters.Add(param3);

            //sqlDataSource1.Parameters[0].Value = "=Parameters.Month.Value";
            //sqlDataSource1.Parameters[1].Value = "=Parameters.Year.Value";
            //sqlDataSource1.Parameters[2].Value = "=Parameters.Type.Value";
        }
    }
}