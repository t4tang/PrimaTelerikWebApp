namespace TelerikWebApplication.Forms.Purchase.Purchase_order
{
    using System;
    using System.ComponentModel;
    using System.Drawing;
    using System.Windows.Forms;
    using Telerik.Reporting;
    using Telerik.Reporting.Drawing;
    using System.Configuration;
    using System.Data;
    using System.Data.SqlClient;

    /// <summary>
    /// Summary description for pur01h02.
    /// </summary>
    public partial class pur01h02_slip : Telerik.Reporting.Report
    {
        public static string _tr_code;
        public static string _unit_code;
        public static double _tot_amount;

        public pur01h02_slip()
        {
            //
            // Required for telerik Reporting designer support
            //
            InitializeComponent();
            
            Telerik.Reporting.ReportParameter param = new ReportParameter();
            param.Name = "doc_no";
            param.Type = ReportParameterType.String;
            param.AllowBlank = false;
            param.AllowNull = false;
            param.Value = _tr_code;
            param.Visible = false;
            this.Report.ReportParameters.Add(param);

            sqlDataSource1.Parameters[0].Value = "=Parameters.doc_no.Value";

            if (_unit_code == string.Empty)
            {                
                pnl_po_unit.Visible = true;
                txt_engine_no.Visible = false;
                txt_engine_no_label.Visible = false;
                txt_hm.Visible = false;
                txt_hm_label.Visible = false;
                txt_mr_no_label.Value = "Printed";
                txt_print.Visible = false;
                txt_print_label.Visible = false;
                txt_sn.Visible = false;
                txt_sn_label.Visible = false;
                txt_unit_code.Visible = false;
                txt_unit_code_label.Visible = false;
                txt_mr_no.Value = "=Fields.printed";
            }
            

            if (_tot_amount >= 50000001)
            {
                //pnl_approval_besar.Visible = true;
                pnl_approval_kecil.Visible = false;
            }
            else
            {
                pnl_approval_besar.Visible = false;
                pnl_approval_kecil.Visible = true;
            }
        }
    }
}