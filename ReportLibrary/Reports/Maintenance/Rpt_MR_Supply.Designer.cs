namespace ReportLibrary.Reports.Maintenance
{
    partial class Rpt_MR_Supply
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
            Telerik.Reporting.Group group3 = new Telerik.Reporting.Group();
            Telerik.Reporting.Drawing.StyleRule styleRule1 = new Telerik.Reporting.Drawing.StyleRule();
            this.groupFooterSection = new Telerik.Reporting.GroupFooterSection();
            this.textBox37 = new Telerik.Reporting.TextBox();
            this.textBox36 = new Telerik.Reporting.TextBox();
            this.groupHeaderSection = new Telerik.Reporting.GroupHeaderSection();
            this.textBox32 = new Telerik.Reporting.TextBox();
            this.groupFooterSection1 = new Telerik.Reporting.GroupFooterSection();
            this.textBox35 = new Telerik.Reporting.TextBox();
            this.textBox34 = new Telerik.Reporting.TextBox();
            this.groupHeaderSection1 = new Telerik.Reporting.GroupHeaderSection();
            this.textBox33 = new Telerik.Reporting.TextBox();
            this.pageHeaderSection1 = new Telerik.Reporting.PageHeaderSection();
            this.textBox23 = new Telerik.Reporting.TextBox();
            this.textBox21 = new Telerik.Reporting.TextBox();
            this.textBox26 = new Telerik.Reporting.TextBox();
            this.textBox29 = new Telerik.Reporting.TextBox();
            this.textBox2 = new Telerik.Reporting.TextBox();
            this.textBox3 = new Telerik.Reporting.TextBox();
            this.textBox4 = new Telerik.Reporting.TextBox();
            this.textBox5 = new Telerik.Reporting.TextBox();
            this.textBox6 = new Telerik.Reporting.TextBox();
            this.textBox13 = new Telerik.Reporting.TextBox();
            this.textBox14 = new Telerik.Reporting.TextBox();
            this.textBox15 = new Telerik.Reporting.TextBox();
            this.textBox1 = new Telerik.Reporting.TextBox();
            this.textBox7 = new Telerik.Reporting.TextBox();
            this.textBox8 = new Telerik.Reporting.TextBox();
            this.textBox9 = new Telerik.Reporting.TextBox();
            this.textBox17 = new Telerik.Reporting.TextBox();
            this.textBox10 = new Telerik.Reporting.TextBox();
            this.textBox40 = new Telerik.Reporting.TextBox();
            this.detail = new Telerik.Reporting.DetailSection();
            this.textBox12 = new Telerik.Reporting.TextBox();
            this.textBox16 = new Telerik.Reporting.TextBox();
            this.textBox22 = new Telerik.Reporting.TextBox();
            this.textBox28 = new Telerik.Reporting.TextBox();
            this.textBox30 = new Telerik.Reporting.TextBox();
            this.textBox31 = new Telerik.Reporting.TextBox();
            this.textBox20 = new Telerik.Reporting.TextBox();
            this.textBox24 = new Telerik.Reporting.TextBox();
            this.textBox11 = new Telerik.Reporting.TextBox();
            this.textBox27 = new Telerik.Reporting.TextBox();
            this.textBox18 = new Telerik.Reporting.TextBox();
            this.textBox25 = new Telerik.Reporting.TextBox();
            this.textBox19 = new Telerik.Reporting.TextBox();
            this.pageFooterSection1 = new Telerik.Reporting.PageFooterSection();
            this.textBox39 = new Telerik.Reporting.TextBox();
            this.textBox38 = new Telerik.Reporting.TextBox();
            this.sqlDataSource1 = new Telerik.Reporting.SqlDataSource();
            this.Jobsite = new Telerik.Reporting.SqlDataSource();
            this.groupHeaderSection2 = new Telerik.Reporting.GroupHeaderSection();
            this.groupFooterSection2 = new Telerik.Reporting.GroupFooterSection();
            ((System.ComponentModel.ISupportInitialize)(this)).BeginInit();
            // 
            // groupFooterSection
            // 
            this.groupFooterSection.Height = Telerik.Reporting.Drawing.Unit.Inch(0.20007896423339844D);
            this.groupFooterSection.Items.AddRange(new Telerik.Reporting.ReportItemBase[] {
            this.textBox37,
            this.textBox36});
            this.groupFooterSection.Name = "groupFooterSection";
            // 
            // textBox37
            // 
            this.textBox37.Format = "{0:N2}";
            this.textBox37.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(12.099998474121094D), Telerik.Reporting.Drawing.Unit.Inch(7.915496826171875E-05D));
            this.textBox37.Name = "textBox37";
            this.textBox37.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.700001060962677D), Telerik.Reporting.Drawing.Unit.Inch(0.19999980926513672D));
            this.textBox37.Style.BorderStyle.Top = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox37.Style.Font.Bold = true;
            this.textBox37.Style.LineStyle = Telerik.Reporting.Drawing.LineStyle.Solid;
            this.textBox37.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox37.Value = "= Sum(Fields.part_qty)";
            // 
            // textBox36
            // 
            this.textBox36.Format = "{0:N0}";
            this.textBox36.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(9.6999998092651367D), Telerik.Reporting.Drawing.Unit.Inch(7.915496826171875E-05D));
            this.textBox36.Name = "textBox36";
            this.textBox36.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(2.3999197483062744D), Telerik.Reporting.Drawing.Unit.Inch(0.19999980926513672D));
            this.textBox36.Style.BorderStyle.Top = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox36.Style.Font.Bold = true;
            this.textBox36.Style.LineStyle = Telerik.Reporting.Drawing.LineStyle.Solid;
            this.textBox36.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Right;
            this.textBox36.Value = "Total Group By Model :";
            // 
            // groupHeaderSection
            // 
            this.groupHeaderSection.Height = Telerik.Reporting.Drawing.Unit.Inch(0.20003922283649445D);
            this.groupHeaderSection.Items.AddRange(new Telerik.Reporting.ReportItemBase[] {
            this.textBox32});
            this.groupHeaderSection.Name = "groupHeaderSection";
            // 
            // textBox32
            // 
            this.textBox32.Format = "{0:N0}";
            this.textBox32.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0.30000004172325134D), Telerik.Reporting.Drawing.Unit.Inch(3.9418537198798731E-05D));
            this.textBox32.Name = "textBox32";
            this.textBox32.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(3.200000524520874D), Telerik.Reporting.Drawing.Unit.Inch(0.19999980926513672D));
            this.textBox32.Style.BackgroundColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(128)))), ((int)(((byte)(128)))));
            this.textBox32.Style.Font.Bold = true;
            this.textBox32.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Left;
            this.textBox32.Value = "= Fields.model_no";
            // 
            // groupFooterSection1
            // 
            this.groupFooterSection1.Height = Telerik.Reporting.Drawing.Unit.Inch(0.19999980926513672D);
            this.groupFooterSection1.Items.AddRange(new Telerik.Reporting.ReportItemBase[] {
            this.textBox35,
            this.textBox34});
            this.groupFooterSection1.Name = "groupFooterSection1";
            // 
            // textBox35
            // 
            this.textBox35.Format = "{0:N2}";
            this.textBox35.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(12.099998474121094D), Telerik.Reporting.Drawing.Unit.Inch(0D));
            this.textBox35.Name = "textBox35";
            this.textBox35.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.700001060962677D), Telerik.Reporting.Drawing.Unit.Inch(0.19999980926513672D));
            this.textBox35.Style.BorderStyle.Top = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox35.Style.Font.Bold = true;
            this.textBox35.Style.LineStyle = Telerik.Reporting.Drawing.LineStyle.Solid;
            this.textBox35.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox35.Value = "= Sum(Fields.part_qty)";
            // 
            // textBox34
            // 
            this.textBox34.Format = "{0:N0}";
            this.textBox34.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(9.6999998092651367D), Telerik.Reporting.Drawing.Unit.Inch(0D));
            this.textBox34.Name = "textBox34";
            this.textBox34.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(2.3999197483062744D), Telerik.Reporting.Drawing.Unit.Inch(0.19999980926513672D));
            this.textBox34.Style.BorderStyle.Top = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox34.Style.Font.Bold = true;
            this.textBox34.Style.LineStyle = Telerik.Reporting.Drawing.LineStyle.Solid;
            this.textBox34.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Right;
            this.textBox34.Value = "Total Group By Unit Code :";
            // 
            // groupHeaderSection1
            // 
            this.groupHeaderSection1.Height = Telerik.Reporting.Drawing.Unit.Inch(0.20007865130901337D);
            this.groupHeaderSection1.Items.AddRange(new Telerik.Reporting.ReportItemBase[] {
            this.textBox33});
            this.groupHeaderSection1.Name = "groupHeaderSection1";
            // 
            // textBox33
            // 
            this.textBox33.Format = "{0:N0}";
            this.textBox33.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0.49999985098838806D), Telerik.Reporting.Drawing.Unit.Inch(7.8837074397597462E-05D));
            this.textBox33.Name = "textBox33";
            this.textBox33.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(1.7000001668930054D), Telerik.Reporting.Drawing.Unit.Inch(0.19999980926513672D));
            this.textBox33.Style.Font.Bold = true;
            this.textBox33.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Left;
            this.textBox33.Value = "= Fields.unit_code";
            // 
            // pageHeaderSection1
            // 
            this.pageHeaderSection1.Height = Telerik.Reporting.Drawing.Unit.Inch(1.65354323387146D);
            this.pageHeaderSection1.Items.AddRange(new Telerik.Reporting.ReportItemBase[] {
            this.textBox23,
            this.textBox21,
            this.textBox26,
            this.textBox29,
            this.textBox2,
            this.textBox3,
            this.textBox4,
            this.textBox5,
            this.textBox6,
            this.textBox13,
            this.textBox14,
            this.textBox15,
            this.textBox1,
            this.textBox7,
            this.textBox8,
            this.textBox9,
            this.textBox10,
            this.textBox40});
            this.pageHeaderSection1.Name = "pageHeaderSection1";
            this.pageHeaderSection1.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Left;
            // 
            // textBox23
            // 
            this.textBox23.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0D), Telerik.Reporting.Drawing.Unit.Inch(3.9339065551757812E-05D));
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
            this.textBox21.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(13.099567413330078D), Telerik.Reporting.Drawing.Unit.Inch(3.9339065551757812E-05D));
            this.textBox21.Name = "textBox21";
            this.textBox21.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(3.500394344329834D), Telerik.Reporting.Drawing.Unit.Inch(0.33307099342346191D));
            this.textBox21.Style.BorderStyle.Bottom = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox21.Style.BorderWidth.Bottom = Telerik.Reporting.Drawing.Unit.Point(2D);
            this.textBox21.Style.Font.Bold = true;
            this.textBox21.Style.Font.Name = "Segoe UI Light";
            this.textBox21.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(16D);
            this.textBox21.Style.Padding.Left = Telerik.Reporting.Drawing.Unit.Point(0D);
            this.textBox21.Style.Padding.Right = Telerik.Reporting.Drawing.Unit.Point(0D);
            this.textBox21.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox21.StyleName = "Header";
            this.textBox21.Value = "MR Report Part Supplied Per Unit";
            // 
            // textBox26
            // 
            this.textBox26.Format = "{0:N0}";
            this.textBox26.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(15.300040245056152D), Telerik.Reporting.Drawing.Unit.Inch(0.97908806800842285D));
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
            this.textBox29.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(3.9418537198798731E-05D), Telerik.Reporting.Drawing.Unit.Inch(0.9998820424079895D));
            this.textBox29.Name = "textBox29";
            this.textBox29.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(1.499921441078186D), Telerik.Reporting.Drawing.Unit.Inch(0.19999980926513672D));
            this.textBox29.Style.Font.Bold = false;
            this.textBox29.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(8D);
            this.textBox29.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Left;
            this.textBox29.Value = "= Today()";
            // 
            // textBox2
            // 
            this.textBox2.CanGrow = false;
            this.textBox2.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0D), Telerik.Reporting.Drawing.Unit.Inch(1.1999999284744263D));
            this.textBox2.Name = "textBox2";
            this.textBox2.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.4999215304851532D), Telerik.Reporting.Drawing.Unit.Inch(0.39992141723632812D));
            this.textBox2.Style.BackgroundColor = System.Drawing.Color.Teal;
            this.textBox2.Style.BorderStyle.Default = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox2.Style.Color = System.Drawing.Color.White;
            this.textBox2.Style.Font.Bold = true;
            this.textBox2.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox2.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox2.Value = "No";
            // 
            // textBox3
            // 
            this.textBox3.CanGrow = false;
            this.textBox3.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0.49999985098838806D), Telerik.Reporting.Drawing.Unit.Inch(1.1999999284744263D));
            this.textBox3.Name = "textBox3";
            this.textBox3.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.99992138147354126D), Telerik.Reporting.Drawing.Unit.Inch(0.39992141723632812D));
            this.textBox3.Style.BackgroundColor = System.Drawing.Color.Teal;
            this.textBox3.Style.BorderStyle.Default = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox3.Style.Color = System.Drawing.Color.White;
            this.textBox3.Style.Font.Bold = true;
            this.textBox3.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox3.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox3.Value = "WO Date";
            // 
            // textBox4
            // 
            this.textBox4.CanGrow = false;
            this.textBox4.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(1.5D), Telerik.Reporting.Drawing.Unit.Inch(1.1999999284744263D));
            this.textBox4.Name = "textBox4";
            this.textBox4.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(1.0000001192092896D), Telerik.Reporting.Drawing.Unit.Inch(0.39992141723632812D));
            this.textBox4.Style.BackgroundColor = System.Drawing.Color.Teal;
            this.textBox4.Style.BorderStyle.Default = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox4.Style.Color = System.Drawing.Color.White;
            this.textBox4.Style.Font.Bold = true;
            this.textBox4.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox4.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox4.Value = "WO Code";
            // 
            // textBox5
            // 
            this.textBox5.CanGrow = false;
            this.textBox5.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(3.5000791549682617D), Telerik.Reporting.Drawing.Unit.Inch(1.1999999284744263D));
            this.textBox5.Name = "textBox5";
            this.textBox5.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(1.199842095375061D), Telerik.Reporting.Drawing.Unit.Inch(0.39992141723632812D));
            this.textBox5.Style.BackgroundColor = System.Drawing.Color.Teal;
            this.textBox5.Style.BorderStyle.Default = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox5.Style.Color = System.Drawing.Color.White;
            this.textBox5.Style.Font.Bold = true;
            this.textBox5.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox5.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox5.Value = "MR Code";
            // 
            // textBox6
            // 
            this.textBox6.CanGrow = false;
            this.textBox6.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(4.7000002861022949D), Telerik.Reporting.Drawing.Unit.Inch(1.1999607086181641D));
            this.textBox6.Name = "textBox6";
            this.textBox6.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(1.0001587867736816D), Telerik.Reporting.Drawing.Unit.Inch(0.39992141723632812D));
            this.textBox6.Style.BackgroundColor = System.Drawing.Color.Teal;
            this.textBox6.Style.BorderStyle.Default = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox6.Style.Color = System.Drawing.Color.White;
            this.textBox6.Style.Font.Bold = true;
            this.textBox6.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox6.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox6.Value = "Ref Code";
            // 
            // textBox13
            // 
            this.textBox13.CanGrow = false;
            this.textBox13.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(5.70023775100708D), Telerik.Reporting.Drawing.Unit.Inch(1.1999607086181641D));
            this.textBox13.Name = "textBox13";
            this.textBox13.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(2.2997620105743408D), Telerik.Reporting.Drawing.Unit.Inch(0.39992141723632812D));
            this.textBox13.Style.BackgroundColor = System.Drawing.Color.Teal;
            this.textBox13.Style.BorderStyle.Default = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox13.Style.Color = System.Drawing.Color.White;
            this.textBox13.Style.Font.Bold = true;
            this.textBox13.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox13.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox13.Value = "Part Code";
            // 
            // textBox14
            // 
            this.textBox14.CanGrow = false;
            this.textBox14.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(8.0000791549682617D), Telerik.Reporting.Drawing.Unit.Inch(1.2000390291213989D));
            this.textBox14.Name = "textBox14";
            this.textBox14.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(3.0997648239135742D), Telerik.Reporting.Drawing.Unit.Inch(0.39992141723632812D));
            this.textBox14.Style.BackgroundColor = System.Drawing.Color.Teal;
            this.textBox14.Style.BorderStyle.Default = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox14.Style.Color = System.Drawing.Color.White;
            this.textBox14.Style.Font.Bold = true;
            this.textBox14.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox14.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox14.Value = "Part Description";
            // 
            // textBox15
            // 
            this.textBox15.CanGrow = false;
            this.textBox15.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(11.099922180175781D), Telerik.Reporting.Drawing.Unit.Inch(1.1999607086181641D));
            this.textBox15.Name = "textBox15";
            this.textBox15.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.50007891654968262D), Telerik.Reporting.Drawing.Unit.Inch(0.39992141723632812D));
            this.textBox15.Style.BackgroundColor = System.Drawing.Color.Teal;
            this.textBox15.Style.BorderStyle.Default = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox15.Style.Color = System.Drawing.Color.White;
            this.textBox15.Style.Font.Bold = true;
            this.textBox15.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox15.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox15.Value = "FIG Image";
            // 
            // textBox1
            // 
            this.textBox1.CanGrow = false;
            this.textBox1.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(2.5000789165496826D), Telerik.Reporting.Drawing.Unit.Inch(1.1999605894088745D));
            this.textBox1.Name = "textBox1";
            this.textBox1.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.99992138147354126D), Telerik.Reporting.Drawing.Unit.Inch(0.39992141723632812D));
            this.textBox1.Style.BackgroundColor = System.Drawing.Color.Teal;
            this.textBox1.Style.BorderStyle.Default = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox1.Style.Color = System.Drawing.Color.White;
            this.textBox1.Style.Font.Bold = true;
            this.textBox1.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox1.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox1.Value = "MR Date";
            // 
            // textBox7
            // 
            this.textBox7.CanGrow = false;
            this.textBox7.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(12.700435638427734D), Telerik.Reporting.Drawing.Unit.Inch(1.1999605894088745D));
            this.textBox7.Name = "textBox7";
            this.textBox7.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.50007891654968262D), Telerik.Reporting.Drawing.Unit.Inch(0.39992141723632812D));
            this.textBox7.Style.BackgroundColor = System.Drawing.Color.Teal;
            this.textBox7.Style.BorderStyle.Default = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox7.Style.Color = System.Drawing.Color.White;
            this.textBox7.Style.Font.Bold = true;
            this.textBox7.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox7.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox7.Value = "Uom";
            // 
            // textBox8
            // 
            this.textBox8.CanGrow = false;
            this.textBox8.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(12.100237846374512D), Telerik.Reporting.Drawing.Unit.Inch(1.1999607086181641D));
            this.textBox8.Name = "textBox8";
            this.textBox8.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.60011869668960571D), Telerik.Reporting.Drawing.Unit.Inch(0.39992141723632812D));
            this.textBox8.Style.BackgroundColor = System.Drawing.Color.Teal;
            this.textBox8.Style.BorderStyle.Default = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox8.Style.Color = System.Drawing.Color.White;
            this.textBox8.Style.Font.Bold = true;
            this.textBox8.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox8.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox8.Value = "Qty Supply";
            // 
            // textBox9
            // 
            this.textBox9.CanGrow = false;
            this.textBox9.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(11.600079536437988D), Telerik.Reporting.Drawing.Unit.Inch(1.1999607086181641D));
            this.textBox9.Name = "textBox9";
            this.textBox9.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.50007891654968262D), Telerik.Reporting.Drawing.Unit.Inch(0.39992141723632812D));
            this.textBox9.Style.BackgroundColor = System.Drawing.Color.Teal;
            this.textBox9.Style.BorderStyle.Default = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox9.Style.Color = System.Drawing.Color.White;
            this.textBox9.Style.Font.Bold = true;
            this.textBox9.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox9.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox9.Value = "Item";
            // 
            // textBox17
            // 
            this.textBox17.Format = "{0:N0}";
            this.textBox17.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0D), Telerik.Reporting.Drawing.Unit.Inch(0D));
            this.textBox17.Name = "textBox17";
            this.textBox17.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(1.7000001668930054D), Telerik.Reporting.Drawing.Unit.Inch(0.19999980926513672D));
            this.textBox17.Style.Font.Bold = true;
            this.textBox17.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Left;
            this.textBox17.Value = "= Fields.region_name";
            // 
            // textBox10
            // 
            this.textBox10.CanGrow = false;
            this.textBox10.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(13.200592994689941D), Telerik.Reporting.Drawing.Unit.Inch(1.1999605894088745D));
            this.textBox10.Name = "textBox10";
            this.textBox10.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(3.3993699550628662D), Telerik.Reporting.Drawing.Unit.Inch(0.39992141723632812D));
            this.textBox10.Style.BackgroundColor = System.Drawing.Color.Teal;
            this.textBox10.Style.BorderStyle.Default = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox10.Style.Color = System.Drawing.Color.White;
            this.textBox10.Style.Font.Bold = true;
            this.textBox10.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox10.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox10.Value = "Remark";
            // 
            // textBox40
            // 
            this.textBox40.Format = "{0:d}";
            this.textBox40.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(8.49999713897705D), Telerik.Reporting.Drawing.Unit.Inch(0.33318901062011719D));
            this.textBox40.Name = "textBox40";
            this.textBox40.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(8.09996223449707D), Telerik.Reporting.Drawing.Unit.Inch(0.483858197927475D));
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
            // detail
            // 
            this.detail.Height = Telerik.Reporting.Drawing.Unit.Inch(0.40011820197105408D);
            this.detail.Items.AddRange(new Telerik.Reporting.ReportItemBase[] {
            this.textBox12,
            this.textBox16,
            this.textBox22,
            this.textBox28,
            this.textBox30,
            this.textBox31,
            this.textBox20,
            this.textBox24,
            this.textBox11,
            this.textBox27,
            this.textBox18,
            this.textBox25,
            this.textBox19});
            this.detail.Name = "detail";
            // 
            // textBox12
            // 
            this.textBox12.Format = "{0:N0}";
            this.textBox12.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0D), Telerik.Reporting.Drawing.Unit.Inch(3.9418537198798731E-05D));
            this.textBox12.Name = "textBox12";
            this.textBox12.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.49992147088050842D), Telerik.Reporting.Drawing.Unit.Inch(0.19999980926513672D));
            this.textBox12.Style.Font.Bold = false;
            this.textBox12.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox12.Value = "= RowNumber()";
            // 
            // textBox16
            // 
            this.textBox16.Format = "{0:N0}";
            this.textBox16.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(8.0000791549682617D), Telerik.Reporting.Drawing.Unit.Inch(3.9736431062920019E-05D));
            this.textBox16.Name = "textBox16";
            this.textBox16.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(3.0997641086578369D), Telerik.Reporting.Drawing.Unit.Inch(0.19999980926513672D));
            this.textBox16.Style.Font.Bold = false;
            this.textBox16.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Left;
            this.textBox16.Value = "= Fields.part_desc";
            // 
            // textBox22
            // 
            this.textBox22.Format = "{0:N0}";
            this.textBox22.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(5.7002387046813965D), Telerik.Reporting.Drawing.Unit.Inch(3.9418537198798731E-05D));
            this.textBox22.Name = "textBox22";
            this.textBox22.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(2.2997610569000244D), Telerik.Reporting.Drawing.Unit.Inch(0.19999980926513672D));
            this.textBox22.Style.Font.Bold = false;
            this.textBox22.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Left;
            this.textBox22.Value = "= Fields.part_code";
            // 
            // textBox28
            // 
            this.textBox28.Format = "{0:d}";
            this.textBox28.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0.49999985098838806D), Telerik.Reporting.Drawing.Unit.Inch(3.9736431062920019E-05D));
            this.textBox28.Name = "textBox28";
            this.textBox28.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.99992084503173828D), Telerik.Reporting.Drawing.Unit.Inch(0.19999980926513672D));
            this.textBox28.Style.Font.Bold = false;
            this.textBox28.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox28.Value = "= Fields.trans_date.Date.Date.Date";
            // 
            // textBox30
            // 
            this.textBox30.Format = "{0:N0}";
            this.textBox30.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(3.5000791549682617D), Telerik.Reporting.Drawing.Unit.Inch(3.9418537198798731E-05D));
            this.textBox30.Name = "textBox30";
            this.textBox30.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(1.199842095375061D), Telerik.Reporting.Drawing.Unit.Inch(0.19999980926513672D));
            this.textBox30.Style.Font.Bold = false;
            this.textBox30.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox30.Value = "= Fields.sro_code";
            // 
            // textBox31
            // 
            this.textBox31.Format = "{0:N0}";
            this.textBox31.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(1.5000792741775513D), Telerik.Reporting.Drawing.Unit.Inch(3.9736431062920019E-05D));
            this.textBox31.Name = "textBox31";
            this.textBox31.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.99992084503173828D), Telerik.Reporting.Drawing.Unit.Inch(0.19999980926513672D));
            this.textBox31.Style.Font.Bold = false;
            this.textBox31.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox31.Value = "= Fields.trans_id";
            // 
            // textBox20
            // 
            this.textBox20.Format = "{0:N0}";
            this.textBox20.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(11.099922180175781D), Telerik.Reporting.Drawing.Unit.Inch(3.9577484130859375E-05D));
            this.textBox20.Name = "textBox20";
            this.textBox20.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.50007849931716919D), Telerik.Reporting.Drawing.Unit.Inch(0.19999980926513672D));
            this.textBox20.Style.Font.Bold = false;
            this.textBox20.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox20.Value = "= Fields.fig_image";
            // 
            // textBox24
            // 
            this.textBox24.Format = "{0:N0}";
            this.textBox24.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(4.7000007629394531D), Telerik.Reporting.Drawing.Unit.Inch(3.9736431062920019E-05D));
            this.textBox24.Name = "textBox24";
            this.textBox24.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(1.0001586675643921D), Telerik.Reporting.Drawing.Unit.Inch(0.19999980926513672D));
            this.textBox24.Style.Font.Bold = false;
            this.textBox24.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox24.Value = "= Fields.ref_code";
            // 
            // textBox11
            // 
            this.textBox11.Format = "{0:d}";
            this.textBox11.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(2.5000793933868408D), Telerik.Reporting.Drawing.Unit.Inch(3.9736431062920019E-05D));
            this.textBox11.Name = "textBox11";
            this.textBox11.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.99992084503173828D), Telerik.Reporting.Drawing.Unit.Inch(0.19999980926513672D));
            this.textBox11.Style.Font.Bold = false;
            this.textBox11.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox11.Value = "= Fields.sro_date.Date.Date ";
            // 
            // textBox27
            // 
            this.textBox27.Format = "{0:N0}";
            this.textBox27.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(12.700435638427734D), Telerik.Reporting.Drawing.Unit.Inch(0D));
            this.textBox27.Name = "textBox27";
            this.textBox27.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.50007849931716919D), Telerik.Reporting.Drawing.Unit.Inch(0.19999980926513672D));
            this.textBox27.Style.Font.Bold = false;
            this.textBox27.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox27.Value = "= Fields.part_unit";
            // 
            // textBox18
            // 
            this.textBox18.Format = "{0:N0}";
            this.textBox18.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(11.600079536437988D), Telerik.Reporting.Drawing.Unit.Inch(3.9736431062920019E-05D));
            this.textBox18.Name = "textBox18";
            this.textBox18.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.50007849931716919D), Telerik.Reporting.Drawing.Unit.Inch(0.19999980926513672D));
            this.textBox18.Style.Font.Bold = false;
            this.textBox18.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox18.Value = "= Fields.item";
            // 
            // textBox25
            // 
            this.textBox25.Format = "{0:N2}";
            this.textBox25.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(12.100237846374512D), Telerik.Reporting.Drawing.Unit.Inch(3.9736431062920019E-05D));
            this.textBox25.Name = "textBox25";
            this.textBox25.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.60011893510818481D), Telerik.Reporting.Drawing.Unit.Inch(0.19999980926513672D));
            this.textBox25.Style.Font.Bold = false;
            this.textBox25.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Right;
            this.textBox25.Value = "= Fields.part_qty";
            // 
            // textBox19
            // 
            this.textBox19.Format = "{0:N0}";
            this.textBox19.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(13.200592994689941D), Telerik.Reporting.Drawing.Unit.Inch(0D));
            this.textBox19.Name = "textBox19";
            this.textBox19.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(3.3993680477142334D), Telerik.Reporting.Drawing.Unit.Inch(0.19999980926513672D));
            this.textBox19.Style.Font.Bold = false;
            this.textBox19.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Left;
            this.textBox19.Value = "= Fields.sro_remark";
            // 
            // pageFooterSection1
            // 
            this.pageFooterSection1.Height = Telerik.Reporting.Drawing.Unit.Inch(0.19999980926513672D);
            this.pageFooterSection1.Items.AddRange(new Telerik.Reporting.ReportItemBase[] {
            this.textBox39,
            this.textBox38});
            this.pageFooterSection1.Name = "pageFooterSection1";
            // 
            // textBox39
            // 
            this.textBox39.Format = "{0:N2}";
            this.textBox39.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(12.099998474121094D), Telerik.Reporting.Drawing.Unit.Inch(0D));
            this.textBox39.Name = "textBox39";
            this.textBox39.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.700001060962677D), Telerik.Reporting.Drawing.Unit.Inch(0.19999980926513672D));
            this.textBox39.Style.BorderStyle.Top = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox39.Style.Font.Bold = true;
            this.textBox39.Style.LineStyle = Telerik.Reporting.Drawing.LineStyle.Solid;
            this.textBox39.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox39.Value = "= Sum(Fields.part_qty)";
            // 
            // textBox38
            // 
            this.textBox38.Format = "{0:N0}";
            this.textBox38.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(9.6999998092651367D), Telerik.Reporting.Drawing.Unit.Inch(0D));
            this.textBox38.Name = "textBox38";
            this.textBox38.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(2.3999197483062744D), Telerik.Reporting.Drawing.Unit.Inch(0.19999980926513672D));
            this.textBox38.Style.BorderStyle.Top = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox38.Style.Font.Bold = true;
            this.textBox38.Style.LineStyle = Telerik.Reporting.Drawing.LineStyle.Solid;
            this.textBox38.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Right;
            this.textBox38.Value = "Total Group By Project Area :";
            // 
            // sqlDataSource1
            // 
            this.sqlDataSource1.ConnectionString = "ReportLibrary.Properties.Settings.DbConString";
            this.sqlDataSource1.Name = "sqlDataSource1";
            this.sqlDataSource1.Parameters.AddRange(new Telerik.Reporting.SqlDataSourceParameter[] {
            new Telerik.Reporting.SqlDataSourceParameter("@project", System.Data.DbType.AnsiString, "LHT"),
            new Telerik.Reporting.SqlDataSourceParameter("@tglawal", System.Data.DbType.DateTime, "2019-09-01"),
            new Telerik.Reporting.SqlDataSourceParameter("@tglakhir", System.Data.DbType.DateTime, "2019-10-17")});
            this.sqlDataSource1.SelectCommand = "dbo.spr_material_request_supply";
            this.sqlDataSource1.SelectCommandType = Telerik.Reporting.SqlDataSourceCommandType.StoredProcedure;
            // 
            // Jobsite
            // 
            this.Jobsite.ConnectionString = "ReportLibrary.Properties.Settings.DbConString";
            this.Jobsite.Name = "Jobsite";
            this.Jobsite.SelectCommand = "SELECT        region_code, region_name\r\nFROM            ms_jobsite\r\nWHERE        " +
    "(stEdit <> \'4\')\r\nUNION ALL\r\nSELECT        \'ALL\' AS region_code, \'ALL\' AS region_" +
    "name";
            // 
            // groupHeaderSection2
            // 
            this.groupHeaderSection2.Height = Telerik.Reporting.Drawing.Unit.Cm(0.52800029516220093D);
            this.groupHeaderSection2.Items.AddRange(new Telerik.Reporting.ReportItemBase[] {
            this.textBox17});
            this.groupHeaderSection2.Name = "groupHeaderSection2";
            // 
            // groupFooterSection2
            // 
            this.groupFooterSection2.Height = Telerik.Reporting.Drawing.Unit.Cm(0.52320080995559692D);
            this.groupFooterSection2.Name = "groupFooterSection2";
            // 
            // Rpt_MR_Supply
            // 
            this.DataSource = this.sqlDataSource1;
            group1.GroupFooter = this.groupFooterSection2;
            group1.GroupHeader = this.groupHeaderSection2;
            group1.Groupings.Add(new Telerik.Reporting.Grouping("= Fields.region_name"));
            group1.Name = "Project";
            group2.GroupFooter = this.groupFooterSection;
            group2.GroupHeader = this.groupHeaderSection;
            group2.Groupings.Add(new Telerik.Reporting.Grouping("= Fields.model_no"));
            group2.Name = "Model";
            group3.GroupFooter = this.groupFooterSection1;
            group3.GroupHeader = this.groupHeaderSection1;
            group3.Groupings.Add(new Telerik.Reporting.Grouping("= Fields.unit_code"));
            group3.Name = "Unit";
            this.Groups.AddRange(new Telerik.Reporting.Group[] {
            group1,
            group2,
            group3});
            this.Items.AddRange(new Telerik.Reporting.ReportItemBase[] {
            this.groupHeaderSection,
            this.groupFooterSection,
            this.groupHeaderSection1,
            this.groupFooterSection1,
            this.pageHeaderSection1,
            this.detail,
            this.pageFooterSection1,
            this.groupHeaderSection2,
            this.groupFooterSection2});
            this.Name = "Rpt_MR_Supply";
            this.PageSettings.Margins = new Telerik.Reporting.Drawing.MarginsU(Telerik.Reporting.Drawing.Unit.Inch(1D), Telerik.Reporting.Drawing.Unit.Inch(1D), Telerik.Reporting.Drawing.Unit.Inch(1D), Telerik.Reporting.Drawing.Unit.Inch(1D));
            this.PageSettings.PaperKind = System.Drawing.Printing.PaperKind.Letter;
            styleRule1.Selectors.AddRange(new Telerik.Reporting.Drawing.ISelector[] {
            new Telerik.Reporting.Drawing.TypeSelector(typeof(Telerik.Reporting.TextItemBase)),
            new Telerik.Reporting.Drawing.TypeSelector(typeof(Telerik.Reporting.HtmlTextBox))});
            styleRule1.Style.Padding.Left = Telerik.Reporting.Drawing.Unit.Point(2D);
            styleRule1.Style.Padding.Right = Telerik.Reporting.Drawing.Unit.Point(2D);
            this.StyleSheet.AddRange(new Telerik.Reporting.Drawing.StyleRule[] {
            styleRule1});
            this.Width = Telerik.Reporting.Drawing.Unit.Inch(16.600002288818359D);
            ((System.ComponentModel.ISupportInitialize)(this)).EndInit();

        }
        #endregion

        private Telerik.Reporting.PageHeaderSection pageHeaderSection1;
        private Telerik.Reporting.DetailSection detail;
        private Telerik.Reporting.PageFooterSection pageFooterSection1;
        private Telerik.Reporting.TextBox textBox23;
        private Telerik.Reporting.TextBox textBox21;
        private Telerik.Reporting.TextBox textBox26;
        private Telerik.Reporting.TextBox textBox29;
        private Telerik.Reporting.TextBox textBox2;
        private Telerik.Reporting.TextBox textBox3;
        private Telerik.Reporting.TextBox textBox4;
        private Telerik.Reporting.TextBox textBox5;
        private Telerik.Reporting.TextBox textBox6;
        private Telerik.Reporting.TextBox textBox13;
        private Telerik.Reporting.TextBox textBox14;
        private Telerik.Reporting.TextBox textBox15;
        private Telerik.Reporting.TextBox textBox1;
        private Telerik.Reporting.TextBox textBox7;
        private Telerik.Reporting.TextBox textBox8;
        private Telerik.Reporting.TextBox textBox9;
        private Telerik.Reporting.TextBox textBox17;
        private Telerik.Reporting.TextBox textBox10;
        private Telerik.Reporting.SqlDataSource sqlDataSource1;
        private Telerik.Reporting.TextBox textBox12;
        private Telerik.Reporting.TextBox textBox16;
        private Telerik.Reporting.TextBox textBox22;
        private Telerik.Reporting.TextBox textBox28;
        private Telerik.Reporting.TextBox textBox30;
        private Telerik.Reporting.TextBox textBox31;
        private Telerik.Reporting.TextBox textBox20;
        private Telerik.Reporting.TextBox textBox24;
        private Telerik.Reporting.TextBox textBox11;
        private Telerik.Reporting.TextBox textBox27;
        private Telerik.Reporting.TextBox textBox18;
        private Telerik.Reporting.TextBox textBox25;
        private Telerik.Reporting.TextBox textBox19;
        private Telerik.Reporting.GroupHeaderSection groupHeaderSection;
        private Telerik.Reporting.TextBox textBox32;
        private Telerik.Reporting.GroupFooterSection groupFooterSection;
        private Telerik.Reporting.GroupHeaderSection groupHeaderSection1;
        private Telerik.Reporting.TextBox textBox33;
        private Telerik.Reporting.GroupFooterSection groupFooterSection1;
        private Telerik.Reporting.TextBox textBox39;
        private Telerik.Reporting.TextBox textBox38;
        private Telerik.Reporting.TextBox textBox37;
        private Telerik.Reporting.TextBox textBox36;
        private Telerik.Reporting.TextBox textBox35;
        private Telerik.Reporting.TextBox textBox34;
        private Telerik.Reporting.SqlDataSource Jobsite;
        private Telerik.Reporting.TextBox textBox40;
        private Telerik.Reporting.GroupFooterSection groupFooterSection2;
        private Telerik.Reporting.GroupHeaderSection groupHeaderSection2;
    }
}