namespace ReportLibrary.Reports.Inventory
{
    partial class GoodIssuedReportByCustomer
    {
        #region Component Designer generated code
        /// <summary>
        /// Required method for telerik Reporting designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            Telerik.Reporting.Group group1 = new Telerik.Reporting.Group();
            Telerik.Reporting.Group group2 = new Telerik.Reporting.Group();
            Telerik.Reporting.Drawing.StyleRule styleRule1 = new Telerik.Reporting.Drawing.StyleRule();
            this.groupFooterSection = new Telerik.Reporting.GroupFooterSection();
            this.groupHeaderSection = new Telerik.Reporting.GroupHeaderSection();
            this.groupFooterSection1 = new Telerik.Reporting.GroupFooterSection();
            this.groupHeaderSection1 = new Telerik.Reporting.GroupHeaderSection();
            this.textBox11 = new Telerik.Reporting.TextBox();
            this.textBox12 = new Telerik.Reporting.TextBox();
            this.textBox13 = new Telerik.Reporting.TextBox();
            this.textBox14 = new Telerik.Reporting.TextBox();
            this.textBox15 = new Telerik.Reporting.TextBox();
            this.textBox16 = new Telerik.Reporting.TextBox();
            this.textBox17 = new Telerik.Reporting.TextBox();
            this.textBox18 = new Telerik.Reporting.TextBox();
            this.pageHeaderSection1 = new Telerik.Reporting.PageHeaderSection();
            this.textBox23 = new Telerik.Reporting.TextBox();
            this.textBox21 = new Telerik.Reporting.TextBox();
            this.textBox1 = new Telerik.Reporting.TextBox();
            this.textBox31 = new Telerik.Reporting.TextBox();
            this.textBox2 = new Telerik.Reporting.TextBox();
            this.textBox3 = new Telerik.Reporting.TextBox();
            this.textBox4 = new Telerik.Reporting.TextBox();
            this.textBox5 = new Telerik.Reporting.TextBox();
            this.textBox6 = new Telerik.Reporting.TextBox();
            this.textBox7 = new Telerik.Reporting.TextBox();
            this.textBox8 = new Telerik.Reporting.TextBox();
            this.textBox9 = new Telerik.Reporting.TextBox();
            this.textBox10 = new Telerik.Reporting.TextBox();
            this.detail = new Telerik.Reporting.DetailSection();
            this.sqlGoodIssuedReport = new Telerik.Reporting.SqlDataSource();
            this.JobSite = new Telerik.Reporting.SqlDataSource();
            this.reportFooterSection1 = new Telerik.Reporting.ReportFooterSection();
            this.textBox26 = new Telerik.Reporting.TextBox();
            this.textBox25 = new Telerik.Reporting.TextBox();
            this.textBox24 = new Telerik.Reporting.TextBox();
            this.textBox22 = new Telerik.Reporting.TextBox();
            this.textBox20 = new Telerik.Reporting.TextBox();
            this.textBox19 = new Telerik.Reporting.TextBox();
            this.textBox27 = new Telerik.Reporting.TextBox();
            this.shape1 = new Telerik.Reporting.Shape();
            this.textBox28 = new Telerik.Reporting.TextBox();
            ((System.ComponentModel.ISupportInitialize)(this)).BeginInit();
            // 
            // groupFooterSection
            // 
            this.groupFooterSection.Height = Telerik.Reporting.Drawing.Unit.Cm(0.29999873042106628D);
            this.groupFooterSection.Name = "groupFooterSection";
            // 
            // groupHeaderSection
            // 
            this.groupHeaderSection.Height = Telerik.Reporting.Drawing.Unit.Cm(0.80000042915344238D);
            this.groupHeaderSection.Items.AddRange(new Telerik.Reporting.ReportItemBase[] {
            this.textBox28});
            this.groupHeaderSection.Name = "groupHeaderSection";
            // 
            // groupFooterSection1
            // 
            this.groupFooterSection1.Height = Telerik.Reporting.Drawing.Unit.Cm(0.40000146627426147D);
            this.groupFooterSection1.Name = "groupFooterSection1";
            // 
            // groupHeaderSection1
            // 
            this.groupHeaderSection1.Height = Telerik.Reporting.Drawing.Unit.Cm(0.7000001072883606D);
            this.groupHeaderSection1.Items.AddRange(new Telerik.Reporting.ReportItemBase[] {
            this.textBox11,
            this.textBox12,
            this.textBox13,
            this.textBox14,
            this.textBox15,
            this.textBox16,
            this.textBox17,
            this.textBox18});
            this.groupHeaderSection1.Name = "groupHeaderSection1";
            // 
            // textBox11
            // 
            this.textBox11.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(0.099999949336051941D), Telerik.Reporting.Drawing.Unit.Cm(0.00010012308484874666D));
            this.textBox11.Name = "textBox11";
            this.textBox11.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(3.2998001575469971D), Telerik.Reporting.Drawing.Unit.Cm(0.59990042448043823D));
            this.textBox11.Value = "= Fields.prod_code";
            // 
            // textBox12
            // 
            this.textBox12.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(3.4000003337860107D), Telerik.Reporting.Drawing.Unit.Cm(0D));
            this.textBox12.Name = "textBox12";
            this.textBox12.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(6.7998003959655762D), Telerik.Reporting.Drawing.Unit.Cm(0.59990042448043823D));
            this.textBox12.Value = "= Fields.prod_spec";
            // 
            // textBox13
            // 
            this.textBox13.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(10.200000762939453D), Telerik.Reporting.Drawing.Unit.Cm(0.00010012308484874666D));
            this.textBox13.Name = "textBox13";
            this.textBox13.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(1.7995977401733398D), Telerik.Reporting.Drawing.Unit.Cm(0.59990042448043823D));
            this.textBox13.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox13.Value = "= Fields.unit_code";
            // 
            // textBox14
            // 
            this.textBox14.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(11.999798774719238D), Telerik.Reporting.Drawing.Unit.Cm(0.00010012308484874666D));
            this.textBox14.Name = "textBox14";
            this.textBox14.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(2.5006022453308105D), Telerik.Reporting.Drawing.Unit.Cm(0.59990042448043823D));
            this.textBox14.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Right;
            this.textBox14.Value = "= Fields.consignment";
            // 
            // textBox15
            // 
            this.textBox15.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(14.50059986114502D), Telerik.Reporting.Drawing.Unit.Cm(0D));
            this.textBox15.Name = "textBox15";
            this.textBox15.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(2.5008008480072021D), Telerik.Reporting.Drawing.Unit.Cm(0.59990042448043823D));
            this.textBox15.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Right;
            this.textBox15.Value = "= Fields.Assembly";
            // 
            // textBox16
            // 
            this.textBox16.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(17.001602172851562D), Telerik.Reporting.Drawing.Unit.Cm(0.00010012308484874666D));
            this.textBox16.Name = "textBox16";
            this.textBox16.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(2.5010027885437012D), Telerik.Reporting.Drawing.Unit.Cm(0.59990042448043823D));
            this.textBox16.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Right;
            this.textBox16.Value = "= Fields.qty_out";
            // 
            // textBox17
            // 
            this.textBox17.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(19.502803802490234D), Telerik.Reporting.Drawing.Unit.Cm(0.00010012308484874666D));
            this.textBox17.Name = "textBox17";
            this.textBox17.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(2.5012013912200928D), Telerik.Reporting.Drawing.Unit.Cm(0.59990042448043823D));
            this.textBox17.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Right;
            this.textBox17.Value = "= Fields.stock_take";
            // 
            // textBox18
            // 
            this.textBox18.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(22.004205703735352D), Telerik.Reporting.Drawing.Unit.Cm(0.00010012308484874666D));
            this.textBox18.Name = "textBox18";
            this.textBox18.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(2.5014030933380127D), Telerik.Reporting.Drawing.Unit.Cm(0.59990042448043823D));
            this.textBox18.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Right;
            this.textBox18.Value = "= Fields.retur";
            // 
            // pageHeaderSection1
            // 
            this.pageHeaderSection1.Height = Telerik.Reporting.Drawing.Unit.Cm(5.9000000953674316D);
            this.pageHeaderSection1.Items.AddRange(new Telerik.Reporting.ReportItemBase[] {
            this.textBox23,
            this.textBox21,
            this.textBox1,
            this.textBox31,
            this.textBox2,
            this.textBox3,
            this.textBox4,
            this.textBox5,
            this.textBox6,
            this.textBox7,
            this.textBox8,
            this.textBox9,
            this.textBox10});
            this.pageHeaderSection1.Name = "pageHeaderSection1";
            // 
            // textBox23
            // 
            this.textBox23.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0.039370059967041016D), Telerik.Reporting.Drawing.Unit.Inch(0.039370059967041016D));
            this.textBox23.Name = "textBox23";
            this.textBox23.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(2.6771657466888428D), Telerik.Reporting.Drawing.Unit.Inch(0.50007867813110352D));
            this.textBox23.Style.Font.Bold = false;
            this.textBox23.Style.Font.Name = "Segoe UI Light";
            this.textBox23.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(9D);
            this.textBox23.Value = "PT. Prima Sarana Gemilang\r\nWisma Indomobil 1 Lt. 4 \r\nJl. MT. Haryono Kav. 8, Jaka" +
    "rta Timur 13330 ";
            // 
            // textBox21
            // 
            this.textBox21.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(5.9864602088928223D), Telerik.Reporting.Drawing.Unit.Inch(0.039370059967041016D));
            this.textBox21.Name = "textBox21";
            this.textBox21.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(3.6614177227020264D), Telerik.Reporting.Drawing.Unit.Inch(0.39370083808898926D));
            this.textBox21.Style.BorderStyle.Bottom = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox21.Style.BorderWidth.Bottom = Telerik.Reporting.Drawing.Unit.Point(2D);
            this.textBox21.Style.Font.Bold = true;
            this.textBox21.Style.Font.Name = "Segoe UI Light";
            this.textBox21.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(18D);
            this.textBox21.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Right;
            this.textBox21.StyleName = "Header";
            this.textBox21.Value = "Good Issued Report By Customer";
            // 
            // textBox1
            // 
            this.textBox1.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(6.5666484832763672D), Telerik.Reporting.Drawing.Unit.Inch(0.47244095802307129D));
            this.textBox1.Name = "textBox1";
            this.textBox1.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(3.0812289714813232D), Telerik.Reporting.Drawing.Unit.Inch(0.31496062874794006D));
            this.textBox1.Style.BorderStyle.Bottom = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox1.Style.BorderStyle.Top = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox1.Style.BorderWidth.Bottom = Telerik.Reporting.Drawing.Unit.Point(2D);
            this.textBox1.Style.Font.Bold = true;
            this.textBox1.Style.Font.Name = "Segoe UI Light";
            this.textBox1.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(14D);
            this.textBox1.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Right;
            this.textBox1.StyleName = "Header";
            this.textBox1.Value = "Sub Group By Material";
            // 
            // textBox31
            // 
            this.textBox31.Format = "{0:d}";
            this.textBox31.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(6.5666484832763672D), Telerik.Reporting.Drawing.Unit.Inch(0.82677173614501953D));
            this.textBox31.Name = "textBox31";
            this.textBox31.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(3.0812292098999023D), Telerik.Reporting.Drawing.Unit.Inch(0.43299221992492676D));
            this.textBox31.Style.BorderStyle.Top = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox31.Style.BorderWidth.Top = Telerik.Reporting.Drawing.Unit.Pixel(1D);
            this.textBox31.Style.Font.Bold = false;
            this.textBox31.Style.Font.Name = "Segoe UI Light";
            this.textBox31.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Right;
            this.textBox31.Value = "Periode : From {Format(\"{{0:dd/MM/yyyy}}\",Parameters.tglawal.Value.Date)} To {For" +
    "mat(\"{{0:dd/MM/yyyy}}\",Parameters.tglakhir.Value.Date)}";
            // 
            // textBox2
            // 
            this.textBox2.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(0.099999949336051941D), Telerik.Reporting.Drawing.Unit.Cm(4.5999999046325684D));
            this.textBox2.Name = "textBox2";
            this.textBox2.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(3.2998001575469971D), Telerik.Reporting.Drawing.Unit.Cm(0.99999988079071045D));
            this.textBox2.Style.BackgroundColor = System.Drawing.Color.Teal;
            this.textBox2.Style.BorderStyle.Default = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox2.Style.BorderWidth.Default = Telerik.Reporting.Drawing.Unit.Pixel(1D);
            this.textBox2.Style.Font.Bold = true;
            this.textBox2.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox2.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox2.Value = "Material Code";
            // 
            // textBox3
            // 
            this.textBox3.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(3.4000003337860107D), Telerik.Reporting.Drawing.Unit.Cm(4.5999999046325684D));
            this.textBox3.Name = "textBox3";
            this.textBox3.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(6.79979944229126D), Telerik.Reporting.Drawing.Unit.Cm(0.99999988079071045D));
            this.textBox3.Style.BackgroundColor = System.Drawing.Color.Teal;
            this.textBox3.Style.BorderStyle.Default = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox3.Style.BorderWidth.Default = Telerik.Reporting.Drawing.Unit.Pixel(1D);
            this.textBox3.Style.Font.Bold = true;
            this.textBox3.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox3.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox3.Value = "Specification";
            // 
            // textBox4
            // 
            this.textBox4.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(10.199999809265137D), Telerik.Reporting.Drawing.Unit.Cm(4.5999999046325684D));
            this.textBox4.Name = "textBox4";
            this.textBox4.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(1.7995985746383667D), Telerik.Reporting.Drawing.Unit.Cm(1.0000003576278687D));
            this.textBox4.Style.BackgroundColor = System.Drawing.Color.Teal;
            this.textBox4.Style.BorderStyle.Default = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox4.Style.BorderWidth.Default = Telerik.Reporting.Drawing.Unit.Pixel(1D);
            this.textBox4.Style.Font.Bold = true;
            this.textBox4.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox4.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox4.Value = "UoM";
            // 
            // textBox5
            // 
            this.textBox5.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(11.999798774719238D), Telerik.Reporting.Drawing.Unit.Cm(5.0999999046325684D));
            this.textBox5.Name = "textBox5";
            this.textBox5.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(2.5006015300750732D), Telerik.Reporting.Drawing.Unit.Cm(0.500000536441803D));
            this.textBox5.Style.BackgroundColor = System.Drawing.Color.Teal;
            this.textBox5.Style.BorderStyle.Default = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox5.Style.BorderWidth.Default = Telerik.Reporting.Drawing.Unit.Pixel(1D);
            this.textBox5.Style.Font.Bold = true;
            this.textBox5.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox5.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox5.Value = "Consigment";
            // 
            // textBox6
            // 
            this.textBox6.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(14.50059986114502D), Telerik.Reporting.Drawing.Unit.Cm(5.0999999046325684D));
            this.textBox6.Name = "textBox6";
            this.textBox6.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(2.5008018016815186D), Telerik.Reporting.Drawing.Unit.Cm(0.4999997615814209D));
            this.textBox6.Style.BackgroundColor = System.Drawing.Color.Teal;
            this.textBox6.Style.BorderStyle.Default = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox6.Style.BorderWidth.Default = Telerik.Reporting.Drawing.Unit.Pixel(1D);
            this.textBox6.Style.Font.Bold = true;
            this.textBox6.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox6.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox6.Value = "Assembly";
            // 
            // textBox7
            // 
            this.textBox7.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(17.001602172851562D), Telerik.Reporting.Drawing.Unit.Cm(5.0999999046325684D));
            this.textBox7.Name = "textBox7";
            this.textBox7.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(2.5010020732879639D), Telerik.Reporting.Drawing.Unit.Cm(0.500000536441803D));
            this.textBox7.Style.BackgroundColor = System.Drawing.Color.Teal;
            this.textBox7.Style.BorderStyle.Default = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox7.Style.BorderWidth.Default = Telerik.Reporting.Drawing.Unit.Pixel(1D);
            this.textBox7.Style.Font.Bold = true;
            this.textBox7.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox7.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox7.Value = "Consumption";
            // 
            // textBox8
            // 
            this.textBox8.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(19.502803802490234D), Telerik.Reporting.Drawing.Unit.Cm(5.099998950958252D));
            this.textBox8.Name = "textBox8";
            this.textBox8.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(2.5012023448944092D), Telerik.Reporting.Drawing.Unit.Cm(0.500000536441803D));
            this.textBox8.Style.BackgroundColor = System.Drawing.Color.Teal;
            this.textBox8.Style.BorderStyle.Default = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox8.Style.BorderWidth.Default = Telerik.Reporting.Drawing.Unit.Pixel(1D);
            this.textBox8.Style.Font.Bold = true;
            this.textBox8.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox8.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox8.Value = "Stock Taking";
            // 
            // textBox9
            // 
            this.textBox9.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(22.004207611083984D), Telerik.Reporting.Drawing.Unit.Cm(5.1000008583068848D));
            this.textBox9.Name = "textBox9";
            this.textBox9.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(2.5014009475708008D), Telerik.Reporting.Drawing.Unit.Cm(0.4999997615814209D));
            this.textBox9.Style.BackgroundColor = System.Drawing.Color.Teal;
            this.textBox9.Style.BorderStyle.Default = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox9.Style.BorderWidth.Default = Telerik.Reporting.Drawing.Unit.Pixel(1D);
            this.textBox9.Style.Font.Bold = true;
            this.textBox9.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox9.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox9.Value = "Return";
            // 
            // textBox10
            // 
            this.textBox10.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(11.999799728393555D), Telerik.Reporting.Drawing.Unit.Cm(4.5997991561889648D));
            this.textBox10.Name = "textBox10";
            this.textBox10.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(12.505809783935547D), Telerik.Reporting.Drawing.Unit.Cm(0.500000536441803D));
            this.textBox10.Style.BackgroundColor = System.Drawing.Color.Teal;
            this.textBox10.Style.BorderStyle.Default = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox10.Style.BorderWidth.Default = Telerik.Reporting.Drawing.Unit.Pixel(1D);
            this.textBox10.Style.Font.Bold = true;
            this.textBox10.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox10.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox10.Value = "Quantity";
            // 
            // detail
            // 
            this.detail.Height = Telerik.Reporting.Drawing.Unit.Cm(0.39999988675117493D);
            this.detail.Name = "detail";
            // 
            // sqlGoodIssuedReport
            // 
            this.sqlGoodIssuedReport.ConnectionString = "ReportLibrary.Properties.Settings.DbConString";
            this.sqlGoodIssuedReport.Name = "sqlGoodIssuedReport";
            this.sqlGoodIssuedReport.Parameters.AddRange(new Telerik.Reporting.SqlDataSourceParameter[] {
            new Telerik.Reporting.SqlDataSourceParameter("@project", System.Data.DbType.AnsiString, null),
            new Telerik.Reporting.SqlDataSourceParameter("@tglawal", System.Data.DbType.DateTime, null),
            new Telerik.Reporting.SqlDataSourceParameter("@tglakhir", System.Data.DbType.DateTime, null)});
            this.sqlGoodIssuedReport.SelectCommand = "dbo.spr_goods_issued";
            this.sqlGoodIssuedReport.SelectCommandType = Telerik.Reporting.SqlDataSourceCommandType.StoredProcedure;
            // 
            // JobSite
            // 
            this.JobSite.ConnectionString = "ReportLibrary.Properties.Settings.DbConString";
            this.JobSite.Name = "JobSite";
            this.JobSite.SelectCommand = "SELECT        region_code, region_name\r\nFROM            ms_jobsite\r\nWHERE        " +
    "(stEdit <> \'4\')\r\nUNION ALL\r\nSELECT        \'ALL\' AS region_code, \'ALL\' AS region_" +
    "name";
            // 
            // reportFooterSection1
            // 
            this.reportFooterSection1.Height = Telerik.Reporting.Drawing.Unit.Cm(2.5D);
            this.reportFooterSection1.Items.AddRange(new Telerik.Reporting.ReportItemBase[] {
            this.textBox26,
            this.textBox25,
            this.textBox24,
            this.textBox22,
            this.textBox20,
            this.textBox19,
            this.textBox27,
            this.shape1});
            this.reportFooterSection1.Name = "reportFooterSection1";
            // 
            // textBox26
            // 
            this.textBox26.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(9.8000001907348633D), Telerik.Reporting.Drawing.Unit.Cm(0.30030062794685364D));
            this.textBox26.Name = "textBox26";
            this.textBox26.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(1.7995977401733398D), Telerik.Reporting.Drawing.Unit.Cm(0.599698543548584D));
            this.textBox26.Style.Font.Bold = true;
            this.textBox26.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox26.Value = "Total";
            // 
            // textBox25
            // 
            this.textBox25.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(11.999798774719238D), Telerik.Reporting.Drawing.Unit.Cm(0.30030062794685364D));
            this.textBox25.Name = "textBox25";
            this.textBox25.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(2.5006022453308105D), Telerik.Reporting.Drawing.Unit.Cm(0.599698543548584D));
            this.textBox25.Style.Font.Bold = true;
            this.textBox25.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Right;
            this.textBox25.Value = "= Sum(Fields.consignment)";
            // 
            // textBox24
            // 
            this.textBox24.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(14.50059986114502D), Telerik.Reporting.Drawing.Unit.Cm(0.300200492143631D));
            this.textBox24.Name = "textBox24";
            this.textBox24.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(2.5008008480072021D), Telerik.Reporting.Drawing.Unit.Cm(0.599698543548584D));
            this.textBox24.Style.Font.Bold = true;
            this.textBox24.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Right;
            this.textBox24.Value = "= Sum(Fields.Assembly)";
            // 
            // textBox22
            // 
            this.textBox22.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(17.001602172851562D), Telerik.Reporting.Drawing.Unit.Cm(0.30030062794685364D));
            this.textBox22.Name = "textBox22";
            this.textBox22.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(2.5010027885437012D), Telerik.Reporting.Drawing.Unit.Cm(0.599698543548584D));
            this.textBox22.Style.Font.Bold = true;
            this.textBox22.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Right;
            this.textBox22.Value = "= Sum(Fields.qty_out)";
            // 
            // textBox20
            // 
            this.textBox20.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(19.502803802490234D), Telerik.Reporting.Drawing.Unit.Cm(0.30030062794685364D));
            this.textBox20.Name = "textBox20";
            this.textBox20.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(2.5012013912200928D), Telerik.Reporting.Drawing.Unit.Cm(0.599698543548584D));
            this.textBox20.Style.Font.Bold = true;
            this.textBox20.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Right;
            this.textBox20.Value = "= Sum(Fields.stock_take)";
            // 
            // textBox19
            // 
            this.textBox19.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(22.004205703735352D), Telerik.Reporting.Drawing.Unit.Cm(0.30030062794685364D));
            this.textBox19.Name = "textBox19";
            this.textBox19.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(2.5014030933380127D), Telerik.Reporting.Drawing.Unit.Cm(0.599698543548584D));
            this.textBox19.Style.Font.Bold = true;
            this.textBox19.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Right;
            this.textBox19.Value = "= Sum(Fields.retur)";
            // 
            // textBox27
            // 
            this.textBox27.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(11.599798202514648D), Telerik.Reporting.Drawing.Unit.Cm(0.30030062794685364D));
            this.textBox27.Name = "textBox27";
            this.textBox27.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(0.30000025033950806D), Telerik.Reporting.Drawing.Unit.Cm(0.599999725818634D));
            this.textBox27.Style.Font.Bold = true;
            this.textBox27.Value = ":";
            // 
            // shape1
            // 
            this.shape1.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(0.10000277310609818D), Telerik.Reporting.Drawing.Unit.Cm(0.00010012308484874666D));
            this.shape1.Name = "shape1";
            this.shape1.ShapeType = new Telerik.Reporting.Drawing.Shapes.LineShape(Telerik.Reporting.Drawing.Shapes.LineDirection.EW);
            this.shape1.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(24.405607223510742D), Telerik.Reporting.Drawing.Unit.Cm(0.30000025033950806D));
            // 
            // textBox28
            // 
            this.textBox28.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(0.10000277310609818D), Telerik.Reporting.Drawing.Unit.Cm(0.00010012308484874666D));
            this.textBox28.Name = "textBox28";
            this.textBox28.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(4.4999971389770508D), Telerik.Reporting.Drawing.Unit.Cm(0.599999725818634D));
            this.textBox28.Style.Font.Bold = true;
            this.textBox28.Value = "= Fields.cust_name";
            // 
            // GoodIssuedReportByCustomer
            // 
            this.DataSource = this.sqlGoodIssuedReport;
            group1.GroupFooter = this.groupFooterSection;
            group1.GroupHeader = this.groupHeaderSection;
            group1.Groupings.Add(new Telerik.Reporting.Grouping("= Fields.cust_name"));
            group1.Name = "group";
            group2.GroupFooter = this.groupFooterSection1;
            group2.GroupHeader = this.groupHeaderSection1;
            group2.Groupings.Add(new Telerik.Reporting.Grouping("= Fields.prod_code"));
            group2.Name = "group1";
            this.Groups.AddRange(new Telerik.Reporting.Group[] {
            group1,
            group2});
            this.Items.AddRange(new Telerik.Reporting.ReportItemBase[] {
            this.groupHeaderSection,
            this.groupFooterSection,
            this.groupHeaderSection1,
            this.groupFooterSection1,
            this.pageHeaderSection1,
            this.detail,
            this.reportFooterSection1});
            this.Name = "GoodIssuedReportByCustomer";
            this.PageSettings.Margins = new Telerik.Reporting.Drawing.MarginsU(Telerik.Reporting.Drawing.Unit.Mm(20D), Telerik.Reporting.Drawing.Unit.Mm(20D), Telerik.Reporting.Drawing.Unit.Mm(20D), Telerik.Reporting.Drawing.Unit.Mm(20D));
            this.PageSettings.PaperKind = System.Drawing.Printing.PaperKind.A4;
            styleRule1.Selectors.AddRange(new Telerik.Reporting.Drawing.ISelector[] {
            new Telerik.Reporting.Drawing.TypeSelector(typeof(Telerik.Reporting.TextItemBase)),
            new Telerik.Reporting.Drawing.TypeSelector(typeof(Telerik.Reporting.HtmlTextBox))});
            styleRule1.Style.Padding.Left = Telerik.Reporting.Drawing.Unit.Point(2D);
            styleRule1.Style.Padding.Right = Telerik.Reporting.Drawing.Unit.Point(2D);
            this.StyleSheet.AddRange(new Telerik.Reporting.Drawing.StyleRule[] {
            styleRule1});
            this.Width = Telerik.Reporting.Drawing.Unit.Cm(24.600000381469727D);
            ((System.ComponentModel.ISupportInitialize)(this)).EndInit();

        }
        #endregion

        private Telerik.Reporting.PageHeaderSection pageHeaderSection1;
        private Telerik.Reporting.DetailSection detail;
        private Telerik.Reporting.TextBox textBox23;
        private Telerik.Reporting.TextBox textBox21;
        private Telerik.Reporting.TextBox textBox1;
        private Telerik.Reporting.TextBox textBox31;
        private Telerik.Reporting.TextBox textBox2;
        private Telerik.Reporting.TextBox textBox3;
        private Telerik.Reporting.TextBox textBox4;
        private Telerik.Reporting.TextBox textBox5;
        private Telerik.Reporting.TextBox textBox6;
        private Telerik.Reporting.TextBox textBox7;
        private Telerik.Reporting.TextBox textBox8;
        private Telerik.Reporting.TextBox textBox9;
        private Telerik.Reporting.TextBox textBox10;
        private Telerik.Reporting.SqlDataSource sqlGoodIssuedReport;
        private Telerik.Reporting.GroupHeaderSection groupHeaderSection;
        private Telerik.Reporting.GroupFooterSection groupFooterSection;
        private Telerik.Reporting.SqlDataSource JobSite;
        private Telerik.Reporting.ReportFooterSection reportFooterSection1;
        private Telerik.Reporting.Shape shape1;
        private Telerik.Reporting.TextBox textBox27;
        private Telerik.Reporting.TextBox textBox19;
        private Telerik.Reporting.TextBox textBox20;
        private Telerik.Reporting.TextBox textBox22;
        private Telerik.Reporting.TextBox textBox24;
        private Telerik.Reporting.TextBox textBox25;
        private Telerik.Reporting.TextBox textBox26;
        private Telerik.Reporting.GroupHeaderSection groupHeaderSection1;
        private Telerik.Reporting.GroupFooterSection groupFooterSection1;
        private Telerik.Reporting.TextBox textBox18;
        private Telerik.Reporting.TextBox textBox17;
        private Telerik.Reporting.TextBox textBox16;
        private Telerik.Reporting.TextBox textBox15;
        private Telerik.Reporting.TextBox textBox14;
        private Telerik.Reporting.TextBox textBox13;
        private Telerik.Reporting.TextBox textBox12;
        private Telerik.Reporting.TextBox textBox11;
        private Telerik.Reporting.TextBox textBox28;
    }
}