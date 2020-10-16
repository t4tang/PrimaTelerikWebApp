namespace ReportLibrary.Reports.Inventory
{
    using System;
    using System.ComponentModel;
    using System.Drawing;
    using System.Windows.Forms;
    using Telerik.Reporting;
    using Telerik.Reporting.Drawing;

    /// <summary>
    /// Summary description for rpt_goods_receive.
    /// </summary>
    [Description("Menampilkan seluruh transaksi Penerimaan Barang Per Transaksi sesuai project dan periode tertentu")]
    public partial class rpt_goods_receive : Telerik.Reporting.Report
    {
        public rpt_goods_receive()
        {
            //
            // Required for telerik Reporting designer support
            //
            InitializeComponent();

            //
            // TODO: Add any constructor code after InitializeComponent call
            //
        }
    }
}