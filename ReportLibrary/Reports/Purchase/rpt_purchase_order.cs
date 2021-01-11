namespace ReportLibrary.Reports
{
    using System;
    using System.ComponentModel;
    using System.Drawing;
    using System.Windows.Forms;
    using Telerik.Reporting;
    using Telerik.Reporting.Drawing;

    /// <summary>
    /// Summary description for rpt_purchase_order.
    /// </summary>
    public partial class PurchaseOrderReport : Telerik.Reporting.Report
    {
        public static string _project;
        public static DateTime _tglawal = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
        public static DateTime _tglakhir = DateTime.Now;
        public static bool TF; 
        //public static DateTime _tglawal ;
        //public static DateTime _tglakhir;
        public PurchaseOrderReport()
        {
            //
            // Required for telerik Reporting designer support
            //
            InitializeComponent();

            //
            // TODO: Add any constructor code after InitializeComponent call
            //
            Telerik.Reporting.ReportParameter prm_tgl1 = new ReportParameter();
            prm_tgl1.Name = "tglawal";
            prm_tgl1.Text = "Date";
            prm_tgl1.Type = ReportParameterType.DateTime;
            prm_tgl1.AllowBlank = false;
            prm_tgl1.AllowNull = false;
            prm_tgl1.Value = string.Format("{0:yyyy-MM-dd}", _tglawal);
            //prm_tgl1.Value = long.Parse(_tglawal.ToString("yyyyMMdd"));
            prm_tgl1.Visible = true;
            this.Report.ReportParameters.Add(prm_tgl1);

            Telerik.Reporting.ReportParameter prm_tgl2 = new ReportParameter();
            prm_tgl2.Name = "tglakhir";
            prm_tgl2.Text = "To Date";
            prm_tgl2.Type = ReportParameterType.DateTime;
            prm_tgl2.AllowBlank = false;
            prm_tgl2.AllowNull = false;
            prm_tgl2.Value = string.Format("{0:yyyy-MM-dd}", _tglakhir);
            //prm_tgl2.Value = long.Parse(_tglakhir.ToString("yyyyMMdd"));
            prm_tgl2.Visible = true;
            this.Report.ReportParameters.Add(prm_tgl2);

            Telerik.Reporting.ReportParameter prm_project = new ReportParameter();
            prm_project.Name = "project";
            prm_project.Text = "Project";
            prm_project.Type = ReportParameterType.String;
            prm_project.AllowBlank = false;
            prm_project.AllowNull = false;
            prm_project.AvailableValues.DataSource = sds_jobsite;
            prm_project.AvailableValues.DisplayMember = "region_name";
            prm_project.AvailableValues.ValueMember = "region_code";
            prm_project.Value = _project;
            prm_project.Visible = true;
            this.Report.ReportParameters.Add(prm_project);

            Telerik.Reporting.ReportParameter status_po = new ReportParameter();
            status_po.Name = "status_po";
            status_po.Text = "include cancel";
            status_po.Type = ReportParameterType.Boolean;
            status_po.AllowBlank = false;
            status_po.AllowNull = false;
            //status_po.Value = string.Format("{0:yyyy-MM-dd}", _tglakhir);
            //prm_tgl2.Value = long.Parse(_tglakhir.ToString("yyyyMMdd"));
            status_po.Value = false;
            status_po.Visible = true;
            this.Report.ReportParameters.Add(status_po);

            sqlDataSource1.Parameters[0].Value = "=Parameters.project.Value";
            sqlDataSource1.Parameters[1].Value = "=Parameters.tglawal.Value";
            sqlDataSource1.Parameters[2].Value = "=Parameters.tglakhir.Value";
            sqlDataSource1.Parameters[3].Value = "=Parameters.status_po.Value";

            txt_periode.Value = string.Format("{0:dd-MMM-yyyy}", "= Parameters.tglawal.Value");
            txt_periode2.Value = string.Format("{0:dd-MMM-yyyy}", "= Parameters.tglakhir.Value");

        }
    }
}