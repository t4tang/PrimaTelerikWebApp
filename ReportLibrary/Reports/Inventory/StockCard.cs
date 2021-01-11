namespace ReportLibrary.Reports.Inventory
{
    using System;
    using System.ComponentModel;
    using System.Drawing;
    using System.Windows.Forms;
    using Telerik.Reporting;
    using Telerik.Reporting.Drawing;

    /// <summary>
    /// Summary description for StockCard.
    /// </summary>
    [Description("Menampilkan seluruh transaksi Penerimaan Barang Per Transaksi sesuai project dan periode tertentu")]
    public partial class StockCard : Telerik.Reporting.Report
    { 
        
        public static DateTime _tglawal = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
        public static DateTime _tglakhir = DateTime.Now;
        public static string _material;
        public static string _project;
        public static string _storage;

        public StockCard()
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
            param2.Value = string.Format("{0:yyyy-MM-dd}", _tglakhir);
            param2.Visible = true;
            this.Report.ReportParameters.Add(param2);

            Telerik.Reporting.ReportParameter param3 = new ReportParameter();
            param3.Name = "material";
            param3.Text = "Material :";
            param3.Type = ReportParameterType.String;
            param3.AllowBlank = false;
            param3.AllowNull = false; param3.AvailableValues.DataSource = material;
            param3.AvailableValues.DisplayMember = "spec";
            param3.AvailableValues.ValueMember = "prod_code";
            param3.Value = _material;
            param3.Visible = true;
            this.Report.ReportParameters.Add(param3);

            Telerik.Reporting.ReportParameter param4 = new ReportParameter();
            param4.Name = "project";
            param4.Text = "Project  :";
            param4.Type = ReportParameterType.String;
            param4.AllowBlank = false;
            param4.AllowNull = false; param4.AvailableValues.DataSource = project;
            param4.AvailableValues.DisplayMember = "region_name";
            param4.AvailableValues.ValueMember = "region_code";
            param4.Value = _project;
            param4.Visible = true;
            this.Report.ReportParameters.Add(param4);

            Telerik.Reporting.ReportParameter param5 = new ReportParameter();
            param5.Name = "storage";
            param5.Text = "Storage  :";
            param5.Type = ReportParameterType.String;
            param5.AllowBlank = false;
            param5.AllowNull = false; param5.AvailableValues.DataSource = storage;
            param5.AvailableValues.DisplayMember = "wh_name";
            param5.AvailableValues.ValueMember = "wh_code";
            param5.Value = _storage;
            param5.Visible = true;
            this.Report.ReportParameters.Add(param5);

            sds_stockcard.Parameters[0].Value = "=Parameters.tglawal.Value";
            sds_stockcard.Parameters[1].Value = "=Parameters.tglakhir.Value";
            sds_stockcard.Parameters[2].Value = "=Parameters.material.Value";
            //sds_stockcard.Parameters[3].Value = "=Parameters.project.Value";
            sds_stockcard.Parameters[3].Value = "=Parameters.storage.Value";
        }
    }
}