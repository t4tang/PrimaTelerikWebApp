namespace TelerikWebApplication.Form.Purchase.Purchase_service
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
    using Class;

    /// <summary>
    /// Summary description for pur01h02srv_slip.
    /// </summary>
    public partial class pur01h02srv_slip : Telerik.Reporting.Report
    {
        public static string _tr_code;
        //public static string _tr_code = "PS0318000363";
        public static string _unit_code;
        public static double _tot_amount;

        public pur01h02srv_slip()
        {
            //
            // Required for telerik Reporting designer support
            //
            InitializeComponent();

            //
            // TODO: Add any constructor code after InitializeComponent call
            //
            Telerik.Reporting.ReportParameter param = new ReportParameter();
            param.Name = "po_code";
            param.Type = ReportParameterType.String;
            param.AllowBlank = false;
            param.AllowNull = false;
            param.Value = _tr_code;
            //param.Value = "PO0319110199";
            //param.Value = "PO0319110200";
            param.Visible = false;
            this.Report.ReportParameters.Add(param);

            sqlDataSource1.Parameters[0].Value = "=Parameters.po_code.Value";

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

            //string koneksi = ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString;
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);

            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT pur01h02.Net, pur01h01.unit_code FROM pur01h02 INNER JOIN pur01h01 ON pur01h02.no_ref = pur01h01.pr_code WHERE pur01h02.po_code = '" + _tr_code + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                _tot_amount = Convert.ToDouble(dr[0].ToString());
                _unit_code = dr[1].ToString();
            }
            dr.Close();
            con.Close();

            if (_tot_amount >= 50000000)
            {
                pnl_approval_besar.Visible = true;
                pnl_approval_kecil.Visible = false;
            }

            if (_tot_amount < 50000000)
            {
                pnl_approval_besar.Visible = false;
                pnl_approval_kecil.Visible = true;
            }
        }
    }
}