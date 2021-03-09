namespace ReportLibrary.Reports.Purchase
{
    partial class rpt_PO_Remaining_BySupllier_SubGroupDate
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
            this.textBox33 = new Telerik.Reporting.TextBox();
            this.textBox32 = new Telerik.Reporting.TextBox();
            this.textBox31 = new Telerik.Reporting.TextBox();
            this.textBox30 = new Telerik.Reporting.TextBox();
            this.groupHeaderSection = new Telerik.Reporting.GroupHeaderSection();
            this.textBox16 = new Telerik.Reporting.TextBox();
            this.textBox18 = new Telerik.Reporting.TextBox();
            this.textBox17 = new Telerik.Reporting.TextBox();
            this.groupFooterSection1 = new Telerik.Reporting.GroupFooterSection();
            this.textBox27 = new Telerik.Reporting.TextBox();
            this.textBox35 = new Telerik.Reporting.TextBox();
            this.textBox36 = new Telerik.Reporting.TextBox();
            this.textBox25 = new Telerik.Reporting.TextBox();
            this.groupHeaderSection1 = new Telerik.Reporting.GroupHeaderSection();
            this.textBox28 = new Telerik.Reporting.TextBox();
            this.pageHeaderSection1 = new Telerik.Reporting.PageHeaderSection();
            this.textBox23 = new Telerik.Reporting.TextBox();
            this.textBox21 = new Telerik.Reporting.TextBox();
            this.textBox40 = new Telerik.Reporting.TextBox();
            this.textBox26 = new Telerik.Reporting.TextBox();
            this.textBox29 = new Telerik.Reporting.TextBox();
            this.textBox13 = new Telerik.Reporting.TextBox();
            this.textBox15 = new Telerik.Reporting.TextBox();
            this.textBox8 = new Telerik.Reporting.TextBox();
            this.textBox9 = new Telerik.Reporting.TextBox();
            this.textBox1 = new Telerik.Reporting.TextBox();
            this.textBox2 = new Telerik.Reporting.TextBox();
            this.textBox3 = new Telerik.Reporting.TextBox();
            this.textBox12 = new Telerik.Reporting.TextBox();
            this.textBox5 = new Telerik.Reporting.TextBox();
            this.textBox6 = new Telerik.Reporting.TextBox();
            this.detail = new Telerik.Reporting.DetailSection();
            this.textBox14 = new Telerik.Reporting.TextBox();
            this.textBox7 = new Telerik.Reporting.TextBox();
            this.textBox10 = new Telerik.Reporting.TextBox();
            this.textBox11 = new Telerik.Reporting.TextBox();
            this.textBox4 = new Telerik.Reporting.TextBox();
            this.textBox24 = new Telerik.Reporting.TextBox();
            this.textBox19 = new Telerik.Reporting.TextBox();
            this.textBox20 = new Telerik.Reporting.TextBox();
            this.textBox22 = new Telerik.Reporting.TextBox();
            this.pageFooterSection1 = new Telerik.Reporting.PageFooterSection();
            this.textBox38 = new Telerik.Reporting.TextBox();
            this.textBox37 = new Telerik.Reporting.TextBox();
            this.textBox34 = new Telerik.Reporting.TextBox();
            this.textBox39 = new Telerik.Reporting.TextBox();
            this.sqlDataSource1 = new Telerik.Reporting.SqlDataSource();
            ((System.ComponentModel.ISupportInitialize)(this)).BeginInit();
            // 
            // groupFooterSection
            // 
            this.groupFooterSection.Height = Telerik.Reporting.Drawing.Unit.Inch(0.299999862909317D);
            this.groupFooterSection.Items.AddRange(new Telerik.Reporting.ReportItemBase[] {
            this.textBox33,
            this.textBox32,
            this.textBox31,
            this.textBox30});
            this.groupFooterSection.Name = "groupFooterSection";
            // 
            // textBox33
            // 
            this.textBox33.Format = "{0:N2}";
            this.textBox33.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(8.8999605178833D), Telerik.Reporting.Drawing.Unit.Inch(3.9418537198798731E-05D));
            this.textBox33.Name = "textBox33";
            this.textBox33.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.99936574697494507D), Telerik.Reporting.Drawing.Unit.Inch(0.19999980926513672D));
            this.textBox33.Style.BorderStyle.Top = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox33.Style.Font.Bold = true;
            this.textBox33.Style.LineStyle = Telerik.Reporting.Drawing.LineStyle.Solid;
            this.textBox33.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Right;
            this.textBox33.Value = "= Sum(Fields.qty_Supp)";
            // 
            // textBox32
            // 
            this.textBox32.Format = "{0:N2}";
            this.textBox32.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(7.8005948066711426D), Telerik.Reporting.Drawing.Unit.Inch(3.9418537198798731E-05D));
            this.textBox32.Name = "textBox32";
            this.textBox32.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(1.0992859601974487D), Telerik.Reporting.Drawing.Unit.Inch(0.19999980926513672D));
            this.textBox32.Style.BorderStyle.Top = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox32.Style.Font.Bold = true;
            this.textBox32.Style.LineStyle = Telerik.Reporting.Drawing.LineStyle.Solid;
            this.textBox32.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Right;
            this.textBox32.Value = "= Sum(Fields.qty)";
            // 
            // textBox31
            // 
            this.textBox31.Format = "{0:N0}";
            this.textBox31.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(6.1003937721252441D), Telerik.Reporting.Drawing.Unit.Inch(3.9418537198798731E-05D));
            this.textBox31.Name = "textBox31";
            this.textBox31.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(1.7001221179962158D), Telerik.Reporting.Drawing.Unit.Inch(0.20000012218952179D));
            this.textBox31.Style.BorderStyle.Top = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox31.Style.Font.Bold = true;
            this.textBox31.Style.LineStyle = Telerik.Reporting.Drawing.LineStyle.Solid;
            this.textBox31.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Right;
            this.textBox31.Value = "Sub Total Supplier=";
            // 
            // textBox30
            // 
            this.textBox30.Format = "{0:N2}";
            this.textBox30.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(9.8999605178833D), Telerik.Reporting.Drawing.Unit.Inch(3.9418537198798731E-05D));
            this.textBox30.Name = "textBox30";
            this.textBox30.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(1.1005557775497437D), Telerik.Reporting.Drawing.Unit.Inch(0.19999980926513672D));
            this.textBox30.Style.BorderStyle.Top = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox30.Style.Font.Bold = true;
            this.textBox30.Style.LineStyle = Telerik.Reporting.Drawing.LineStyle.Solid;
            this.textBox30.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Right;
            this.textBox30.Value = "= Sum(Fields.qty)";
            // 
            // groupHeaderSection
            // 
            this.groupHeaderSection.Height = Telerik.Reporting.Drawing.Unit.Inch(0.20007865130901337D);
            this.groupHeaderSection.Items.AddRange(new Telerik.Reporting.ReportItemBase[] {
            this.textBox16,
            this.textBox18,
            this.textBox17});
            this.groupHeaderSection.Name = "groupHeaderSection";
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
            // textBox18
            // 
            this.textBox18.Format = "{0:d}";
            this.textBox18.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0.85773772001266479D), Telerik.Reporting.Drawing.Unit.Inch(3.9418537198798731E-05D));
            this.textBox18.Name = "textBox18";
            this.textBox18.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(2.9921247959136963D), Telerik.Reporting.Drawing.Unit.Inch(0.19999980926513672D));
            this.textBox18.Style.Font.Bold = true;
            this.textBox18.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Left;
            this.textBox18.Value = "= Fields.vendor_name";
            // 
            // textBox17
            // 
            this.textBox17.Format = "{0:d}";
            this.textBox17.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0.75002002716064453D), Telerik.Reporting.Drawing.Unit.Inch(3.9418537198798731E-05D));
            this.textBox17.Name = "textBox17";
            this.textBox17.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.1076388955116272D), Telerik.Reporting.Drawing.Unit.Inch(0.19999980926513672D));
            this.textBox17.Style.Font.Bold = true;
            this.textBox17.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox17.Value = "-";
            // 
            // groupFooterSection1
            // 
            this.groupFooterSection1.Height = Telerik.Reporting.Drawing.Unit.Inch(0.299999862909317D);
            this.groupFooterSection1.Items.AddRange(new Telerik.Reporting.ReportItemBase[] {
            this.textBox27,
            this.textBox35,
            this.textBox36,
            this.textBox25});
            this.groupFooterSection1.Name = "groupFooterSection1";
            // 
            // textBox27
            // 
            this.textBox27.Format = "{0:N2}";
            this.textBox27.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(8.8999605178833D), Telerik.Reporting.Drawing.Unit.Inch(3.9418537198798731E-05D));
            this.textBox27.Name = "textBox27";
            this.textBox27.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.99936574697494507D), Telerik.Reporting.Drawing.Unit.Inch(0.19999980926513672D));
            this.textBox27.Style.BorderStyle.Top = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox27.Style.Font.Bold = true;
            this.textBox27.Style.LineStyle = Telerik.Reporting.Drawing.LineStyle.Solid;
            this.textBox27.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Right;
            this.textBox27.Value = "= Sum(Fields.qty_Supp)";
            // 
            // textBox35
            // 
            this.textBox35.Format = "{0:N2}";
            this.textBox35.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(7.8005948066711426D), Telerik.Reporting.Drawing.Unit.Inch(3.9418537198798731E-05D));
            this.textBox35.Name = "textBox35";
            this.textBox35.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(1.0992859601974487D), Telerik.Reporting.Drawing.Unit.Inch(0.19999980926513672D));
            this.textBox35.Style.BorderStyle.Top = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox35.Style.Font.Bold = true;
            this.textBox35.Style.LineStyle = Telerik.Reporting.Drawing.LineStyle.Solid;
            this.textBox35.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Right;
            this.textBox35.Value = "= Sum(Fields.qty)";
            // 
            // textBox36
            // 
            this.textBox36.Format = "{0:N0}";
            this.textBox36.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(6.6999239921569824D), Telerik.Reporting.Drawing.Unit.Inch(3.9418537198798731E-05D));
            this.textBox36.Name = "textBox36";
            this.textBox36.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(1.1005922555923462D), Telerik.Reporting.Drawing.Unit.Inch(0.20000012218952179D));
            this.textBox36.Style.BorderStyle.Top = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox36.Style.Font.Bold = true;
            this.textBox36.Style.LineStyle = Telerik.Reporting.Drawing.LineStyle.Solid;
            this.textBox36.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Right;
            this.textBox36.Value = "Sub Total =";
            // 
            // textBox25
            // 
            this.textBox25.Format = "{0:N2}";
            this.textBox25.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(9.8999605178833D), Telerik.Reporting.Drawing.Unit.Inch(3.9418537198798731E-05D));
            this.textBox25.Name = "textBox25";
            this.textBox25.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(1.1005557775497437D), Telerik.Reporting.Drawing.Unit.Inch(0.19999980926513672D));
            this.textBox25.Style.BorderStyle.Top = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox25.Style.Font.Bold = true;
            this.textBox25.Style.LineStyle = Telerik.Reporting.Drawing.LineStyle.Solid;
            this.textBox25.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Right;
            this.textBox25.Value = "= Sum(Fields.qty)";
            // 
            // groupHeaderSection1
            // 
            this.groupHeaderSection1.Height = Telerik.Reporting.Drawing.Unit.Inch(0.29992136359214783D);
            this.groupHeaderSection1.Items.AddRange(new Telerik.Reporting.ReportItemBase[] {
            this.textBox28});
            this.groupHeaderSection1.Name = "groupHeaderSection1";
            // 
            // textBox28
            // 
            this.textBox28.Format = "{0:d}";
            this.textBox28.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0.30000004172325134D), Telerik.Reporting.Drawing.Unit.Inch(7.8837074397597462E-05D));
            this.textBox28.Name = "textBox28";
            this.textBox28.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.89984261989593506D), Telerik.Reporting.Drawing.Unit.Inch(0.19999980926513672D));
            this.textBox28.Style.Font.Bold = true;
            this.textBox28.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox28.Value = "= Fields.Po_date.Date.Date.Date";
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
            this.textBox13,
            this.textBox15,
            this.textBox8,
            this.textBox9,
            this.textBox1,
            this.textBox2,
            this.textBox3,
            this.textBox12,
            this.textBox5,
            this.textBox6});
            this.pageHeaderSection1.Name = "pageHeaderSection1";
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
            // textBox21
            // 
            this.textBox21.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(7.149385929107666D), Telerik.Reporting.Drawing.Unit.Inch(3.9339065551757812E-05D));
            this.textBox21.Name = "textBox21";
            this.textBox21.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(3.8506143093109131D), Telerik.Reporting.Drawing.Unit.Inch(0.69996064901351929D));
            this.textBox21.Style.BorderStyle.Bottom = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox21.Style.BorderWidth.Bottom = Telerik.Reporting.Drawing.Unit.Point(2D);
            this.textBox21.Style.Font.Bold = true;
            this.textBox21.Style.Font.Name = "Segoe UI Light";
            this.textBox21.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(16D);
            this.textBox21.Style.Padding.Left = Telerik.Reporting.Drawing.Unit.Point(0D);
            this.textBox21.Style.Padding.Right = Telerik.Reporting.Drawing.Unit.Point(0D);
            this.textBox21.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Right;
            this.textBox21.StyleName = "Header";
            this.textBox21.Value = "Remaining PO Report By Supplier Sub Group By Date";
            // 
            // textBox40
            // 
            this.textBox40.Format = "{0:d}";
            this.textBox40.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(2.8999989032745361D), Telerik.Reporting.Drawing.Unit.Inch(0.70007866621017456D));
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
            // textBox26
            // 
            this.textBox26.Format = "{0:N0}";
            this.textBox26.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(9.7000799179077148D), Telerik.Reporting.Drawing.Unit.Inch(1.2999999523162842D));
            this.textBox26.Name = "textBox26";
            this.textBox26.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(1.2999206781387329D), Telerik.Reporting.Drawing.Unit.Inch(0.19999980926513672D));
            this.textBox26.Style.Font.Bold = false;
            this.textBox26.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(8D);
            this.textBox26.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Right;
            this.textBox26.Value = "= \'Page \' + PageNumber + \' of  \' + PageCount";
            // 
            // textBox29
            // 
            this.textBox29.Format = "{0:d}";
            this.textBox29.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(3.9418537198798731E-05D), Telerik.Reporting.Drawing.Unit.Inch(1.2999998331069946D));
            this.textBox29.Name = "textBox29";
            this.textBox29.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(1.499921441078186D), Telerik.Reporting.Drawing.Unit.Inch(0.19999980926513672D));
            this.textBox29.Style.Font.Bold = false;
            this.textBox29.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(8D);
            this.textBox29.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Left;
            this.textBox29.Value = "= Today()";
            // 
            // textBox13
            // 
            this.textBox13.CanGrow = false;
            this.textBox13.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(3.9418537198798731E-05D), Telerik.Reporting.Drawing.Unit.Inch(1.500078558921814D));
            this.textBox13.Name = "textBox13";
            this.textBox13.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(1.3000000715255737D), Telerik.Reporting.Drawing.Unit.Inch(0.39992141723632812D));
            this.textBox13.Style.BackgroundColor = System.Drawing.Color.Teal;
            this.textBox13.Style.BorderStyle.Default = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox13.Style.Color = System.Drawing.Color.White;
            this.textBox13.Style.Font.Bold = true;
            this.textBox13.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox13.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox13.Value = "PO No";
            // 
            // textBox15
            // 
            this.textBox15.CanGrow = false;
            this.textBox15.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(1.3001183271408081D), Telerik.Reporting.Drawing.Unit.Inch(1.5001177787780762D));
            this.textBox15.Name = "textBox15";
            this.textBox15.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(1.8995227813720703D), Telerik.Reporting.Drawing.Unit.Inch(0.39992141723632812D));
            this.textBox15.Style.BackgroundColor = System.Drawing.Color.Teal;
            this.textBox15.Style.BorderStyle.Default = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox15.Style.Color = System.Drawing.Color.White;
            this.textBox15.Style.Font.Bold = true;
            this.textBox15.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox15.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox15.Value = "Material Code";
            // 
            // textBox8
            // 
            this.textBox8.CanGrow = false;
            this.textBox8.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(5.8997993469238281D), Telerik.Reporting.Drawing.Unit.Inch(1.4999996423721314D));
            this.textBox8.Name = "textBox8";
            this.textBox8.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.58914828300476074D), Telerik.Reporting.Drawing.Unit.Inch(0.39992141723632812D));
            this.textBox8.Style.BackgroundColor = System.Drawing.Color.Teal;
            this.textBox8.Style.BorderStyle.Default = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox8.Style.Color = System.Drawing.Color.White;
            this.textBox8.Style.Font.Bold = true;
            this.textBox8.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox8.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox8.Value = "Project ";
            // 
            // textBox9
            // 
            this.textBox9.CanGrow = false;
            this.textBox9.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(3.1997196674346924D), Telerik.Reporting.Drawing.Unit.Inch(1.5001177787780762D));
            this.textBox9.Name = "textBox9";
            this.textBox9.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(2.700000524520874D), Telerik.Reporting.Drawing.Unit.Inch(0.39992141723632812D));
            this.textBox9.Style.BackgroundColor = System.Drawing.Color.Teal;
            this.textBox9.Style.BorderStyle.Default = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox9.Style.Color = System.Drawing.Color.White;
            this.textBox9.Style.Font.Bold = true;
            this.textBox9.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox9.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox9.Value = "Specification";
            // 
            // textBox1
            // 
            this.textBox1.CanGrow = false;
            this.textBox1.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(6.4994430541992188D), Telerik.Reporting.Drawing.Unit.Inch(1.4999996423721314D));
            this.textBox1.Name = "textBox1";
            this.textBox1.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.8016669750213623D), Telerik.Reporting.Drawing.Unit.Inch(0.39992141723632812D));
            this.textBox1.Style.BackgroundColor = System.Drawing.Color.Teal;
            this.textBox1.Style.BorderStyle.Default = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox1.Style.Color = System.Drawing.Color.White;
            this.textBox1.Style.Font.Bold = true;
            this.textBox1.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox1.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox1.Value = "Cost Center";
            // 
            // textBox2
            // 
            this.textBox2.CanGrow = false;
            this.textBox2.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(7.8005948066711426D), Telerik.Reporting.Drawing.Unit.Inch(1.7001575231552124D));
            this.textBox2.Name = "textBox2";
            this.textBox2.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(1.0992870330810547D), Telerik.Reporting.Drawing.Unit.Inch(0.19996070861816406D));
            this.textBox2.Style.BackgroundColor = System.Drawing.Color.Teal;
            this.textBox2.Style.BorderStyle.Default = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox2.Style.Color = System.Drawing.Color.White;
            this.textBox2.Style.Font.Bold = true;
            this.textBox2.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox2.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox2.Value = "Order";
            // 
            // textBox3
            // 
            this.textBox3.CanGrow = false;
            this.textBox3.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(8.8999605178833D), Telerik.Reporting.Drawing.Unit.Inch(1.7001575231552124D));
            this.textBox3.Name = "textBox3";
            this.textBox3.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.99992138147354126D), Telerik.Reporting.Drawing.Unit.Inch(0.19996070861816406D));
            this.textBox3.Style.BackgroundColor = System.Drawing.Color.Teal;
            this.textBox3.Style.BorderStyle.Default = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox3.Style.Color = System.Drawing.Color.White;
            this.textBox3.Style.Font.Bold = true;
            this.textBox3.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox3.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox3.Value = "Supply";
            // 
            // textBox12
            // 
            this.textBox12.CanGrow = false;
            this.textBox12.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(7.8005948066711426D), Telerik.Reporting.Drawing.Unit.Inch(1.4999996423721314D));
            this.textBox12.Name = "textBox12";
            this.textBox12.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(3.1994051933288574D), Telerik.Reporting.Drawing.Unit.Inch(0.19996070861816406D));
            this.textBox12.Style.BackgroundColor = System.Drawing.Color.Teal;
            this.textBox12.Style.BorderStyle.Default = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox12.Style.Color = System.Drawing.Color.White;
            this.textBox12.Style.Font.Bold = true;
            this.textBox12.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox12.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox12.Value = "PO ";
            // 
            // textBox5
            // 
            this.textBox5.CanGrow = false;
            this.textBox5.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(7.3011889457702637D), Telerik.Reporting.Drawing.Unit.Inch(1.500078558921814D));
            this.textBox5.Name = "textBox5";
            this.textBox5.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.49932804703712463D), Telerik.Reporting.Drawing.Unit.Inch(0.39992141723632812D));
            this.textBox5.Style.BackgroundColor = System.Drawing.Color.Teal;
            this.textBox5.Style.BorderStyle.Default = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox5.Style.Color = System.Drawing.Color.White;
            this.textBox5.Style.Font.Bold = true;
            this.textBox5.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox5.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox5.Value = "Uom";
            // 
            // textBox6
            // 
            this.textBox6.CanGrow = false;
            this.textBox6.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(9.8999605178833D), Telerik.Reporting.Drawing.Unit.Inch(1.700039267539978D));
            this.textBox6.Name = "textBox6";
            this.textBox6.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(1.1000406742095947D), Telerik.Reporting.Drawing.Unit.Inch(0.19996070861816406D));
            this.textBox6.Style.BackgroundColor = System.Drawing.Color.Teal;
            this.textBox6.Style.BorderStyle.Default = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox6.Style.Color = System.Drawing.Color.White;
            this.textBox6.Style.Font.Bold = true;
            this.textBox6.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox6.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox6.Value = "Remain";
            // 
            // detail
            // 
            this.detail.Height = Telerik.Reporting.Drawing.Unit.Inch(0.30000019073486328D);
            this.detail.Items.AddRange(new Telerik.Reporting.ReportItemBase[] {
            this.textBox14,
            this.textBox10,
            this.textBox11,
            this.textBox4,
            this.textBox24,
            this.textBox19,
            this.textBox20,
            this.textBox22,
            this.textBox7});
            this.detail.Name = "detail";
            // 
            // textBox14
            // 
            this.textBox14.Format = "{0:N0}";
            this.textBox14.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0D), Telerik.Reporting.Drawing.Unit.Inch(3.9418537198798731E-05D));
            this.textBox14.Name = "textBox14";
            this.textBox14.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(1.2999608516693115D), Telerik.Reporting.Drawing.Unit.Inch(0.19999980926513672D));
            this.textBox14.Style.Font.Bold = false;
            this.textBox14.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox14.Value = "= Fields.po_code";
            // 
            // textBox7
            // 
            this.textBox7.Format = "{0:N0}";
            this.textBox7.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(1.3001184463500977D), Telerik.Reporting.Drawing.Unit.Inch(3.9418537198798731E-05D));
            this.textBox7.Name = "textBox7";
            this.textBox7.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(1.9002370834350586D), Telerik.Reporting.Drawing.Unit.Inch(0.19999980926513672D));
            this.textBox7.Style.Font.Bold = false;
            this.textBox7.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Left;
            this.textBox7.Value = "= Fields.Prod_code";
            // 
            // textBox10
            // 
            this.textBox10.Format = "{0:N0}";
            this.textBox10.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(3.2004344463348389D), Telerik.Reporting.Drawing.Unit.Inch(3.9418537198798731E-05D));
            this.textBox10.Name = "textBox10";
            this.textBox10.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(2.6888697147369385D), Telerik.Reporting.Drawing.Unit.Inch(0.19999980926513672D));
            this.textBox10.Style.Font.Bold = false;
            this.textBox10.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Left;
            this.textBox10.Value = "= Fields.Spec";
            // 
            // textBox11
            // 
            this.textBox11.Format = "{0:N0}";
            this.textBox11.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(5.8893828392028809D), Telerik.Reporting.Drawing.Unit.Inch(3.9418537198798731E-05D));
            this.textBox11.Name = "textBox11";
            this.textBox11.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.59956508874893188D), Telerik.Reporting.Drawing.Unit.Inch(0.19999980926513672D));
            this.textBox11.Style.Font.Bold = false;
            this.textBox11.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox11.Value = "= Fields.plantcode";
            // 
            // textBox4
            // 
            this.textBox4.Format = "{0:N0}";
            this.textBox4.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(6.4890265464782715D), Telerik.Reporting.Drawing.Unit.Inch(3.9418537198798731E-05D));
            this.textBox4.Name = "textBox4";
            this.textBox4.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.81208324432373047D), Telerik.Reporting.Drawing.Unit.Inch(0.19999980926513672D));
            this.textBox4.Style.Font.Bold = false;
            this.textBox4.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox4.Value = "= Fields.dept_code";
            // 
            // textBox24
            // 
            this.textBox24.Format = "{0:N0}";
            this.textBox24.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(7.3018221855163574D), Telerik.Reporting.Drawing.Unit.Inch(0D));
            this.textBox24.Name = "textBox24";
            this.textBox24.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.49932822585105896D), Telerik.Reporting.Drawing.Unit.Inch(0.19999980926513672D));
            this.textBox24.Style.Font.Bold = false;
            this.textBox24.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Left;
            this.textBox24.Value = "= Fields.SatQty";
            // 
            // textBox19
            // 
            this.textBox19.Format = "{0:N2}";
            this.textBox19.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(7.8012294769287109D), Telerik.Reporting.Drawing.Unit.Inch(3.9418537198798731E-05D));
            this.textBox19.Name = "textBox19";
            this.textBox19.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(1.1004769802093506D), Telerik.Reporting.Drawing.Unit.Inch(0.19999980926513672D));
            this.textBox19.Style.Font.Bold = false;
            this.textBox19.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Right;
            this.textBox19.Value = "= Fields.qty";
            // 
            // textBox20
            // 
            this.textBox20.Format = "{0:N2}";
            this.textBox20.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(8.9017848968505859D), Telerik.Reporting.Drawing.Unit.Inch(3.9418537198798731E-05D));
            this.textBox20.Name = "textBox20";
            this.textBox20.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.99817568063735962D), Telerik.Reporting.Drawing.Unit.Inch(0.19999980926513672D));
            this.textBox20.Style.Font.Bold = false;
            this.textBox20.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Right;
            this.textBox20.Value = "= Fields.qty_Supp";
            // 
            // textBox22
            // 
            this.textBox22.Format = "{0:N2}";
            this.textBox22.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(9.9005947113037109D), Telerik.Reporting.Drawing.Unit.Inch(3.9418537198798731E-05D));
            this.textBox22.Name = "textBox22";
            this.textBox22.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(1.099406361579895D), Telerik.Reporting.Drawing.Unit.Inch(0.19999980926513672D));
            this.textBox22.Style.Font.Bold = false;
            this.textBox22.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Right;
            this.textBox22.Value = "= Fields.qty";
            // 
            // pageFooterSection1
            // 
            this.pageFooterSection1.Height = Telerik.Reporting.Drawing.Unit.Inch(0.20000012218952179D);
            this.pageFooterSection1.Items.AddRange(new Telerik.Reporting.ReportItemBase[] {
            this.textBox38,
            this.textBox37,
            this.textBox34,
            this.textBox39});
            this.pageFooterSection1.Name = "pageFooterSection1";
            // 
            // textBox38
            // 
            this.textBox38.Format = "{0:N2}";
            this.textBox38.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(7.8005948066711426D), Telerik.Reporting.Drawing.Unit.Inch(0D));
            this.textBox38.Name = "textBox38";
            this.textBox38.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(1.0992859601974487D), Telerik.Reporting.Drawing.Unit.Inch(0.19999980926513672D));
            this.textBox38.Style.BorderStyle.Top = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox38.Style.Font.Bold = true;
            this.textBox38.Style.LineStyle = Telerik.Reporting.Drawing.LineStyle.Solid;
            this.textBox38.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Right;
            this.textBox38.Value = "= Sum(Fields.qty)";
            // 
            // textBox37
            // 
            this.textBox37.Format = "{0:N0}";
            this.textBox37.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(3.9418537198798731E-05D), Telerik.Reporting.Drawing.Unit.Inch(0D));
            this.textBox37.Name = "textBox37";
            this.textBox37.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(7.8004765510559082D), Telerik.Reporting.Drawing.Unit.Inch(0.20000012218952179D));
            this.textBox37.Style.BorderStyle.Top = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox37.Style.Font.Bold = true;
            this.textBox37.Style.LineStyle = Telerik.Reporting.Drawing.LineStyle.Solid;
            this.textBox37.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Right;
            this.textBox37.Value = "Grand Total=";
            // 
            // textBox34
            // 
            this.textBox34.Format = "{0:N2}";
            this.textBox34.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(9.8999605178833D), Telerik.Reporting.Drawing.Unit.Inch(0D));
            this.textBox34.Name = "textBox34";
            this.textBox34.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(1.1005557775497437D), Telerik.Reporting.Drawing.Unit.Inch(0.19999980926513672D));
            this.textBox34.Style.BorderStyle.Top = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox34.Style.Font.Bold = true;
            this.textBox34.Style.LineStyle = Telerik.Reporting.Drawing.LineStyle.Solid;
            this.textBox34.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Right;
            this.textBox34.Value = "= Sum(Fields.qty)";
            // 
            // textBox39
            // 
            this.textBox39.Format = "{0:N2}";
            this.textBox39.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(8.8999605178833D), Telerik.Reporting.Drawing.Unit.Inch(0D));
            this.textBox39.Name = "textBox39";
            this.textBox39.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.99936574697494507D), Telerik.Reporting.Drawing.Unit.Inch(0.19999980926513672D));
            this.textBox39.Style.BorderStyle.Top = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox39.Style.Font.Bold = true;
            this.textBox39.Style.LineStyle = Telerik.Reporting.Drawing.LineStyle.Solid;
            this.textBox39.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Right;
            this.textBox39.Value = "= Sum(Fields.qty_Supp)";
            // 
            // sqlDataSource1
            // 
            this.sqlDataSource1.ConnectionString = "Data Source=192.168.1.252;Initial Catalog=PSG_DEV;User ID=IT;Password=PSGPRO";
            this.sqlDataSource1.Name = "sqlDataSource1";
            this.sqlDataSource1.Parameters.AddRange(new Telerik.Reporting.SqlDataSourceParameter[] {
            new Telerik.Reporting.SqlDataSourceParameter("@tglawal", System.Data.DbType.DateTime, "2018-09-01"),
            new Telerik.Reporting.SqlDataSourceParameter("@tglakhir", System.Data.DbType.DateTime, "2021-10-20")});
            this.sqlDataSource1.ProviderName = "System.Data.SqlClient";
            this.sqlDataSource1.SelectCommand = "dbo.spr_PO_remaining";
            this.sqlDataSource1.SelectCommandType = Telerik.Reporting.SqlDataSourceCommandType.StoredProcedure;
            // 
            // rpt_PO_Remaining_BySupllier_SubGroupDate
            // 
            this.DataSource = this.sqlDataSource1;
            group1.GroupFooter = this.groupFooterSection;
            group1.GroupHeader = this.groupHeaderSection;
            group1.Groupings.Add(new Telerik.Reporting.Grouping("= Fields.vendor_code"));
            group1.Name = "Supplier";
            group2.GroupFooter = this.groupFooterSection1;
            group2.GroupHeader = this.groupHeaderSection1;
            group2.Groupings.Add(new Telerik.Reporting.Grouping("= Fields.Po_date"));
            group2.Name = "date";
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
            this.pageFooterSection1});
            this.Name = "rpt_PO_Remaining_BySupllier_SubGroupDate";
            this.PageSettings.Margins = new Telerik.Reporting.Drawing.MarginsU(Telerik.Reporting.Drawing.Unit.Inch(1D), Telerik.Reporting.Drawing.Unit.Inch(1D), Telerik.Reporting.Drawing.Unit.Inch(1D), Telerik.Reporting.Drawing.Unit.Inch(1D));
            this.PageSettings.PaperKind = System.Drawing.Printing.PaperKind.Letter;
            styleRule1.Selectors.AddRange(new Telerik.Reporting.Drawing.ISelector[] {
            new Telerik.Reporting.Drawing.TypeSelector(typeof(Telerik.Reporting.TextItemBase)),
            new Telerik.Reporting.Drawing.TypeSelector(typeof(Telerik.Reporting.HtmlTextBox))});
            styleRule1.Style.Padding.Left = Telerik.Reporting.Drawing.Unit.Point(2D);
            styleRule1.Style.Padding.Right = Telerik.Reporting.Drawing.Unit.Point(2D);
            this.StyleSheet.AddRange(new Telerik.Reporting.Drawing.StyleRule[] {
            styleRule1});
            this.Width = Telerik.Reporting.Drawing.Unit.Inch(11.000515937805176D);
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
        private Telerik.Reporting.TextBox textBox13;
        private Telerik.Reporting.TextBox textBox15;
        private Telerik.Reporting.TextBox textBox8;
        private Telerik.Reporting.TextBox textBox9;
        private Telerik.Reporting.TextBox textBox1;
        private Telerik.Reporting.TextBox textBox2;
        private Telerik.Reporting.TextBox textBox3;
        private Telerik.Reporting.TextBox textBox12;
        private Telerik.Reporting.TextBox textBox5;
        private Telerik.Reporting.TextBox textBox6;
        private Telerik.Reporting.SqlDataSource sqlDataSource1;
        private Telerik.Reporting.GroupHeaderSection groupHeaderSection;
        private Telerik.Reporting.GroupFooterSection groupFooterSection;
        private Telerik.Reporting.GroupHeaderSection groupHeaderSection1;
        private Telerik.Reporting.GroupFooterSection groupFooterSection1;
        private Telerik.Reporting.TextBox textBox14;
        private Telerik.Reporting.TextBox textBox7;
        private Telerik.Reporting.TextBox textBox10;
        private Telerik.Reporting.TextBox textBox11;
        private Telerik.Reporting.TextBox textBox4;
        private Telerik.Reporting.TextBox textBox24;
        private Telerik.Reporting.TextBox textBox19;
        private Telerik.Reporting.TextBox textBox20;
        private Telerik.Reporting.TextBox textBox22;
        private Telerik.Reporting.TextBox textBox33;
        private Telerik.Reporting.TextBox textBox32;
        private Telerik.Reporting.TextBox textBox31;
        private Telerik.Reporting.TextBox textBox30;
        private Telerik.Reporting.TextBox textBox27;
        private Telerik.Reporting.TextBox textBox35;
        private Telerik.Reporting.TextBox textBox36;
        private Telerik.Reporting.TextBox textBox25;
        private Telerik.Reporting.TextBox textBox16;
        private Telerik.Reporting.TextBox textBox18;
        private Telerik.Reporting.TextBox textBox17;
        private Telerik.Reporting.TextBox textBox28;
        private Telerik.Reporting.TextBox textBox38;
        private Telerik.Reporting.TextBox textBox37;
        private Telerik.Reporting.TextBox textBox34;
        private Telerik.Reporting.TextBox textBox39;
    }
}