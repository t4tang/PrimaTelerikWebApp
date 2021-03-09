namespace ReportLibrary.Reports.Purchase
{
    partial class rpt_PO_Remaining_ByProduct_SubGroupBySupplier
    {
        #region Component Designer generated code
        /// <summary>
        /// Required method for telerik Reporting designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            Telerik.Reporting.Drawing.StyleRule styleRule1 = new Telerik.Reporting.Drawing.StyleRule();
            this.pageHeaderSection1 = new Telerik.Reporting.PageHeaderSection();
            this.detail = new Telerik.Reporting.DetailSection();
            this.pageFooterSection1 = new Telerik.Reporting.PageFooterSection();
            this.textBox23 = new Telerik.Reporting.TextBox();
            this.textBox29 = new Telerik.Reporting.TextBox();
            this.textBox26 = new Telerik.Reporting.TextBox();
            this.textBox40 = new Telerik.Reporting.TextBox();
            this.textBox21 = new Telerik.Reporting.TextBox();
            this.textBox1 = new Telerik.Reporting.TextBox();
            this.textBox18 = new Telerik.Reporting.TextBox();
            this.textBox16 = new Telerik.Reporting.TextBox();
            this.textBox15 = new Telerik.Reporting.TextBox();
            this.textBox13 = new Telerik.Reporting.TextBox();
            ((System.ComponentModel.ISupportInitialize)(this)).BeginInit();
            // 
            // pageHeaderSection1
            // 
            this.pageHeaderSection1.Height = Telerik.Reporting.Drawing.Unit.Inch(2D);
            this.pageHeaderSection1.Items.AddRange(new Telerik.Reporting.ReportItemBase[] {
            this.textBox23,
            this.textBox21,
            this.textBox40,
            this.textBox26,
            this.textBox29,
            this.textBox1,
            this.textBox13,
            this.textBox15});
            this.pageHeaderSection1.Name = "pageHeaderSection1";
            // 
            // detail
            // 
            this.detail.Height = Telerik.Reporting.Drawing.Unit.Inch(2D);
            this.detail.Items.AddRange(new Telerik.Reporting.ReportItemBase[] {
            this.textBox18,
            this.textBox16});
            this.detail.Name = "detail";
            // 
            // pageFooterSection1
            // 
            this.pageFooterSection1.Height = Telerik.Reporting.Drawing.Unit.Inch(1D);
            this.pageFooterSection1.Name = "pageFooterSection1";
            // 
            // textBox23
            // 
            this.textBox23.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(3.9418537198798731E-05D), Telerik.Reporting.Drawing.Unit.Inch(3.9339065551757812E-05D));
            this.textBox23.Name = "textBox23";
            this.textBox23.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(3.1000001430511475D), Telerik.Reporting.Drawing.Unit.Inch(0.50007867813110352D));
            this.textBox23.Style.Font.Bold = false;
            this.textBox23.Style.Font.Name = "Segoe UI Light";
            this.textBox23.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(9D);
            this.textBox23.Value = "PT. Prima Sarana Gemilang\r\nWisma Indomobil 1 Lt. 4 \r\nJl. MT. Haryono Kav. 8, Jaka" +
    "rta Timur 13330 ";
            // 
            // textBox29
            // 
            this.textBox29.Format = "{0:d}";
            this.textBox29.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(-2.0001208782196045D), Telerik.Reporting.Drawing.Unit.Inch(1.5499805212020874D));
            this.textBox29.Name = "textBox29";
            this.textBox29.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(1.499921441078186D), Telerik.Reporting.Drawing.Unit.Inch(0.19999980926513672D));
            this.textBox29.Style.Font.Bold = false;
            this.textBox29.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(8D);
            this.textBox29.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Left;
            this.textBox29.Value = "= Today()";
            // 
            // textBox26
            // 
            this.textBox26.Format = "{0:N0}";
            this.textBox26.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(7.20020055770874D), Telerik.Reporting.Drawing.Unit.Inch(1.3000000715255737D));
            this.textBox26.Name = "textBox26";
            this.textBox26.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(1.2999206781387329D), Telerik.Reporting.Drawing.Unit.Inch(0.19999980926513672D));
            this.textBox26.Style.Font.Bold = false;
            this.textBox26.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(8D);
            this.textBox26.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Right;
            this.textBox26.Value = "= \'Page \' + PageNumber + \' of  \' + PageCount";
            // 
            // textBox40
            // 
            this.textBox40.Format = "{0:d}";
            this.textBox40.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0.40011978149414062D), Telerik.Reporting.Drawing.Unit.Inch(0.70007878541946411D));
            this.textBox40.Name = "textBox40";
            this.textBox40.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(8.09996223449707D), Telerik.Reporting.Drawing.Unit.Inch(0.38385820388793945D));
            this.textBox40.Style.BorderStyle.Top = Telerik.Reporting.Drawing.BorderType.None;
            this.textBox40.Style.BorderWidth.Top = Telerik.Reporting.Drawing.Unit.Pixel(1D);
            this.textBox40.Style.Font.Bold = false;
            this.textBox40.Style.Font.Name = "Segoe UI Light";
            this.textBox40.Style.Padding.Left = Telerik.Reporting.Drawing.Unit.Point(0D);
            this.textBox40.Style.Padding.Right = Telerik.Reporting.Drawing.Unit.Point(0D);
            this.textBox40.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Right;
            this.textBox40.Value = "Periode : From {Format(\"{{0:dd/MM/yyyy}}\",Parameters.tglawal.Value.Date)} To {For" +
    "mat(\"{{0:dd/MM/yyyy}}\",Parameters.tglakhir.Value.Date)}";
            // 
            // textBox21
            // 
            this.textBox21.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(5.100121021270752D), Telerik.Reporting.Drawing.Unit.Inch(3.9339065551757812E-05D));
            this.textBox21.Name = "textBox21";
            this.textBox21.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(3.3999998569488525D), Telerik.Reporting.Drawing.Unit.Inch(0.69996064901351929D));
            this.textBox21.Style.BorderStyle.Bottom = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox21.Style.BorderWidth.Bottom = Telerik.Reporting.Drawing.Unit.Point(2D);
            this.textBox21.Style.Font.Bold = true;
            this.textBox21.Style.Font.Name = "Segoe UI Light";
            this.textBox21.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(16D);
            this.textBox21.Style.Padding.Left = Telerik.Reporting.Drawing.Unit.Point(0D);
            this.textBox21.Style.Padding.Right = Telerik.Reporting.Drawing.Unit.Point(0D);
            this.textBox21.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Right;
            this.textBox21.StyleName = "Header";
            this.textBox21.Value = "Remaining PO Report By Product Sub Group By Supplier";
            // 
            // textBox1
            // 
            this.textBox1.Format = "{0:d}";
            this.textBox1.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(3.9418537198798731E-05D), Telerik.Reporting.Drawing.Unit.Inch(1.3000000715255737D));
            this.textBox1.Name = "textBox1";
            this.textBox1.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(1.499921441078186D), Telerik.Reporting.Drawing.Unit.Inch(0.19999980926513672D));
            this.textBox1.Style.Font.Bold = false;
            this.textBox1.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(8D);
            this.textBox1.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Left;
            this.textBox1.Value = "= Today()";
            // 
            // textBox18
            // 
            this.textBox18.Format = "{0:d}";
            this.textBox18.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0.75002020597457886D), Telerik.Reporting.Drawing.Unit.Inch(3.9418537198798731E-05D));
            this.textBox18.Name = "textBox18";
            this.textBox18.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(2.9921247959136963D), Telerik.Reporting.Drawing.Unit.Inch(0.19999980926513672D));
            this.textBox18.Style.Font.Bold = true;
            this.textBox18.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Left;
            this.textBox18.Value = "= Fields.vendor_name";
            // 
            // textBox16
            // 
            this.textBox16.Format = "{0:N0}";
            this.textBox16.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0D), Telerik.Reporting.Drawing.Unit.Inch(7.8837074397597462E-05D));
            this.textBox16.Name = "textBox16";
            this.textBox16.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.74994140863418579D), Telerik.Reporting.Drawing.Unit.Inch(0.19999980926513672D));
            this.textBox16.Style.Font.Bold = true;
            this.textBox16.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Right;
            this.textBox16.Value = "= Fields.vendor_code";
            // 
            // textBox15
            // 
            this.textBox15.CanGrow = false;
            this.textBox15.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0.75002032518386841D), Telerik.Reporting.Drawing.Unit.Inch(1.5000786781311035D));
            this.textBox15.Name = "textBox15";
            this.textBox15.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(2.9921245574951172D), Telerik.Reporting.Drawing.Unit.Inch(0.39992141723632812D));
            this.textBox15.Style.BackgroundColor = System.Drawing.Color.Teal;
            this.textBox15.Style.BorderStyle.Default = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox15.Style.Color = System.Drawing.Color.White;
            this.textBox15.Style.Font.Bold = true;
            this.textBox15.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox15.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox15.Value = "Supplier Name";
            // 
            // textBox13
            // 
            this.textBox13.CanGrow = false;
            this.textBox13.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(3.9418537198798731E-05D), Telerik.Reporting.Drawing.Unit.Inch(1.5000786781311035D));
            this.textBox13.Name = "textBox13";
            this.textBox13.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.749902069568634D), Telerik.Reporting.Drawing.Unit.Inch(0.39992141723632812D));
            this.textBox13.Style.BackgroundColor = System.Drawing.Color.Teal;
            this.textBox13.Style.BorderStyle.Default = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox13.Style.Color = System.Drawing.Color.White;
            this.textBox13.Style.Font.Bold = true;
            this.textBox13.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox13.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox13.Value = "Supplier Code";
            // 
            // rpt_PO_Remaining_ByProduct_SubGroupBySupplier
            // 
            this.Items.AddRange(new Telerik.Reporting.ReportItemBase[] {
            this.pageHeaderSection1,
            this.detail,
            this.pageFooterSection1});
            this.Name = "rpt_PO_Remaining_ByProduct_SubGroupBySupplier";
            this.PageSettings.Margins = new Telerik.Reporting.Drawing.MarginsU(Telerik.Reporting.Drawing.Unit.Inch(1D), Telerik.Reporting.Drawing.Unit.Inch(1D), Telerik.Reporting.Drawing.Unit.Inch(1D), Telerik.Reporting.Drawing.Unit.Inch(1D));
            this.PageSettings.PaperKind = System.Drawing.Printing.PaperKind.Letter;
            styleRule1.Selectors.AddRange(new Telerik.Reporting.Drawing.ISelector[] {
            new Telerik.Reporting.Drawing.TypeSelector(typeof(Telerik.Reporting.TextItemBase)),
            new Telerik.Reporting.Drawing.TypeSelector(typeof(Telerik.Reporting.HtmlTextBox))});
            styleRule1.Style.Padding.Left = Telerik.Reporting.Drawing.Unit.Point(2D);
            styleRule1.Style.Padding.Right = Telerik.Reporting.Drawing.Unit.Point(2D);
            this.StyleSheet.AddRange(new Telerik.Reporting.Drawing.StyleRule[] {
            styleRule1});
            this.Width = Telerik.Reporting.Drawing.Unit.Inch(8.5001211166381836D);
            ((System.ComponentModel.ISupportInitialize)(this)).EndInit();

        }
        #endregion

        private Telerik.Reporting.PageHeaderSection pageHeaderSection1;
        private Telerik.Reporting.DetailSection detail;
        private Telerik.Reporting.PageFooterSection pageFooterSection1;
        private Telerik.Reporting.TextBox textBox23;
        private Telerik.Reporting.TextBox textBox21;
        private Telerik.Reporting.TextBox textBox40;
        private Telerik.Reporting.TextBox textBox26;
        private Telerik.Reporting.TextBox textBox29;
        private Telerik.Reporting.TextBox textBox1;
        private Telerik.Reporting.TextBox textBox18;
        private Telerik.Reporting.TextBox textBox16;
        private Telerik.Reporting.TextBox textBox13;
        private Telerik.Reporting.TextBox textBox15;
    }
}