namespace ReportLibrary
{
	partial class payment_request_slip
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
            this.sqlDataSource1 = new Telerik.Reporting.SqlDataSource();
            this.textBox2 = new Telerik.Reporting.TextBox();
            this.textBox1 = new Telerik.Reporting.TextBox();
            this.textBox23 = new Telerik.Reporting.TextBox();
            this.textBox22 = new Telerik.Reporting.TextBox();
            this.textBox11 = new Telerik.Reporting.TextBox();
            this.textBox7 = new Telerik.Reporting.TextBox();
            this.textBox5 = new Telerik.Reporting.TextBox();
            this.textBox4 = new Telerik.Reporting.TextBox();
            ((System.ComponentModel.ISupportInitialize)(this)).BeginInit();
            // 
            // pageHeaderSection1
            // 
            this.pageHeaderSection1.Height = Telerik.Reporting.Drawing.Unit.Cm(5.1000003814697266D);
            this.pageHeaderSection1.Items.AddRange(new Telerik.Reporting.ReportItemBase[] {
            this.textBox1,
            this.textBox2,
            this.textBox22,
            this.textBox23,
            this.textBox4,
            this.textBox5,
            this.textBox7,
            this.textBox11});
            this.pageHeaderSection1.Name = "pageHeaderSection1";
            // 
            // detail
            // 
            this.detail.Height = Telerik.Reporting.Drawing.Unit.Cm(5D);
            this.detail.Name = "detail";
            // 
            // pageFooterSection1
            // 
            this.pageFooterSection1.Height = Telerik.Reporting.Drawing.Unit.Cm(2.5D);
            this.pageFooterSection1.Name = "pageFooterSection1";
            // 
            // sqlDataSource1
            // 
            this.sqlDataSource1.ConnectionString = "ReportLibrary.Properties.Settings.DbConString";
            this.sqlDataSource1.Name = "sqlDataSource1";
            this.sqlDataSource1.Parameters.AddRange(new Telerik.Reporting.SqlDataSourceParameter[] {
            new Telerik.Reporting.SqlDataSourceParameter("@doc_no", System.Data.DbType.String, null)});
            this.sqlDataSource1.SelectCommand = "SELECT v_payment_requset_list.*, doc_no AS Expr1\r\nFROM     v_payment_requset_list" +
    "\r\nWHERE  (doc_no = @doc_no)";
            // 
            // textBox2
            // 
            this.textBox2.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(0.20000006258487701D), Telerik.Reporting.Drawing.Unit.Cm(1.8000000715255737D));
            this.textBox2.Name = "textBox2";
            this.textBox2.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(10.899898529052734D), Telerik.Reporting.Drawing.Unit.Cm(1D));
            this.textBox2.Style.Font.Name = "Century Gothic";
            this.textBox2.Value = "= Fields.address1";
            // 
            // textBox1
            // 
            this.textBox1.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(0.20000006258487701D), Telerik.Reporting.Drawing.Unit.Cm(1.1000000238418579D));
            this.textBox1.Name = "textBox1";
            this.textBox1.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(7.0998997688293457D), Telerik.Reporting.Drawing.Unit.Cm(0.60000002384185791D));
            this.textBox1.Style.Font.Bold = true;
            this.textBox1.Style.Font.Name = "Century Gothic";
            this.textBox1.Value = "= Fields.company_name";
            // 
            // textBox23
            // 
            this.textBox23.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(0.19999997317790985D), Telerik.Reporting.Drawing.Unit.Cm(3.6425328254699707D));
            this.textBox23.Name = "textBox23";
            this.textBox23.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(7.1000003814697266D), Telerik.Reporting.Drawing.Unit.Cm(0.39999914169311523D));
            this.textBox23.Style.Font.Bold = true;
            this.textBox23.Value = "= \"Department : \" + Fields.dept_name";
            // 
            // textBox22
            // 
            this.textBox22.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(0.20010018348693848D), Telerik.Reporting.Drawing.Unit.Cm(3.1999993324279785D));
            this.textBox22.Name = "textBox22";
            this.textBox22.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(7.0999002456665039D), Telerik.Reporting.Drawing.Unit.Cm(0.39999979734420776D));
            this.textBox22.Style.Font.Bold = true;
            this.textBox22.Value = "= \"Project : \" + Fields.region_name";
            // 
            // textBox11
            // 
            this.textBox11.Format = "{0:d}";
            this.textBox11.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(14.700200080871582D), Telerik.Reporting.Drawing.Unit.Cm(3.4425315856933594D));
            this.textBox11.Name = "textBox11";
            this.textBox11.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(4.9997992515563965D), Telerik.Reporting.Drawing.Unit.Cm(0.60000020265579224D));
            this.textBox11.Style.BorderColor.Bottom = System.Drawing.Color.FromArgb(((int)(((byte)(15)))), ((int)(((byte)(36)))), ((int)(((byte)(62)))));
            this.textBox11.Style.BorderColor.Left = System.Drawing.Color.FromArgb(((int)(((byte)(15)))), ((int)(((byte)(36)))), ((int)(((byte)(62)))));
            this.textBox11.Style.BorderColor.Right = System.Drawing.Color.FromArgb(((int)(((byte)(15)))), ((int)(((byte)(36)))), ((int)(((byte)(62)))));
            this.textBox11.Style.BorderColor.Top = System.Drawing.Color.FromArgb(((int)(((byte)(15)))), ((int)(((byte)(36)))), ((int)(((byte)(62)))));
            this.textBox11.Style.BorderStyle.Bottom = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox11.Style.BorderStyle.Left = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox11.Style.BorderStyle.Right = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox11.Style.BorderStyle.Top = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox11.Style.BorderWidth.Bottom = Telerik.Reporting.Drawing.Unit.Pixel(1D);
            this.textBox11.Style.BorderWidth.Default = Telerik.Reporting.Drawing.Unit.Pixel(1D);
            this.textBox11.Style.BorderWidth.Left = Telerik.Reporting.Drawing.Unit.Pixel(1D);
            this.textBox11.Style.BorderWidth.Right = Telerik.Reporting.Drawing.Unit.Pixel(1D);
            this.textBox11.Style.BorderWidth.Top = Telerik.Reporting.Drawing.Unit.Pixel(1D);
            this.textBox11.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox11.Value = "= Fields.doc_date";
            // 
            // textBox7
            // 
            this.textBox7.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(12.499998092651367D), Telerik.Reporting.Drawing.Unit.Cm(3.4425315856933594D));
            this.textBox7.Name = "textBox7";
            this.textBox7.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(2.2000045776367188D), Telerik.Reporting.Drawing.Unit.Cm(0.60000020265579224D));
            this.textBox7.Style.BorderColor.Bottom = System.Drawing.Color.FromArgb(((int)(((byte)(15)))), ((int)(((byte)(36)))), ((int)(((byte)(62)))));
            this.textBox7.Style.BorderColor.Left = System.Drawing.Color.FromArgb(((int)(((byte)(15)))), ((int)(((byte)(36)))), ((int)(((byte)(62)))));
            this.textBox7.Style.BorderColor.Right = System.Drawing.Color.FromArgb(((int)(((byte)(15)))), ((int)(((byte)(36)))), ((int)(((byte)(62)))));
            this.textBox7.Style.BorderColor.Top = System.Drawing.Color.FromArgb(((int)(((byte)(15)))), ((int)(((byte)(36)))), ((int)(((byte)(62)))));
            this.textBox7.Style.BorderStyle.Bottom = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox7.Style.BorderStyle.Left = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox7.Style.BorderStyle.Right = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox7.Style.BorderStyle.Top = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox7.Style.BorderWidth.Bottom = Telerik.Reporting.Drawing.Unit.Pixel(1D);
            this.textBox7.Style.BorderWidth.Default = Telerik.Reporting.Drawing.Unit.Pixel(1D);
            this.textBox7.Style.BorderWidth.Left = Telerik.Reporting.Drawing.Unit.Pixel(1D);
            this.textBox7.Style.BorderWidth.Right = Telerik.Reporting.Drawing.Unit.Pixel(1D);
            this.textBox7.Style.BorderWidth.Top = Telerik.Reporting.Drawing.Unit.Pixel(1D);
            this.textBox7.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox7.Value = "Doc Date";
            // 
            // textBox5
            // 
            this.textBox5.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(12.499998092651367D), Telerik.Reporting.Drawing.Unit.Cm(2.7999999523162842D));
            this.textBox5.Name = "textBox5";
            this.textBox5.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(2.2000031471252441D), Telerik.Reporting.Drawing.Unit.Cm(0.60000020265579224D));
            this.textBox5.Style.BorderColor.Bottom = System.Drawing.Color.FromArgb(((int)(((byte)(15)))), ((int)(((byte)(36)))), ((int)(((byte)(62)))));
            this.textBox5.Style.BorderColor.Left = System.Drawing.Color.FromArgb(((int)(((byte)(15)))), ((int)(((byte)(36)))), ((int)(((byte)(62)))));
            this.textBox5.Style.BorderColor.Right = System.Drawing.Color.FromArgb(((int)(((byte)(15)))), ((int)(((byte)(36)))), ((int)(((byte)(62)))));
            this.textBox5.Style.BorderColor.Top = System.Drawing.Color.FromArgb(((int)(((byte)(15)))), ((int)(((byte)(36)))), ((int)(((byte)(62)))));
            this.textBox5.Style.BorderStyle.Bottom = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox5.Style.BorderStyle.Left = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox5.Style.BorderStyle.Right = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox5.Style.BorderStyle.Top = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox5.Style.BorderWidth.Bottom = Telerik.Reporting.Drawing.Unit.Pixel(1D);
            this.textBox5.Style.BorderWidth.Default = Telerik.Reporting.Drawing.Unit.Pixel(1D);
            this.textBox5.Style.BorderWidth.Left = Telerik.Reporting.Drawing.Unit.Pixel(1D);
            this.textBox5.Style.BorderWidth.Right = Telerik.Reporting.Drawing.Unit.Pixel(1D);
            this.textBox5.Style.BorderWidth.Top = Telerik.Reporting.Drawing.Unit.Pixel(1D);
            this.textBox5.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox5.Value = "Doc Number";
            // 
            // textBox4
            // 
            this.textBox4.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(14.700200080871582D), Telerik.Reporting.Drawing.Unit.Cm(2.7999999523162842D));
            this.textBox4.Name = "textBox4";
            this.textBox4.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(4.9997992515563965D), Telerik.Reporting.Drawing.Unit.Cm(0.59999984502792358D));
            this.textBox4.Style.BorderColor.Bottom = System.Drawing.Color.FromArgb(((int)(((byte)(15)))), ((int)(((byte)(36)))), ((int)(((byte)(62)))));
            this.textBox4.Style.BorderColor.Left = System.Drawing.Color.FromArgb(((int)(((byte)(15)))), ((int)(((byte)(36)))), ((int)(((byte)(62)))));
            this.textBox4.Style.BorderColor.Right = System.Drawing.Color.FromArgb(((int)(((byte)(15)))), ((int)(((byte)(36)))), ((int)(((byte)(62)))));
            this.textBox4.Style.BorderColor.Top = System.Drawing.Color.FromArgb(((int)(((byte)(15)))), ((int)(((byte)(36)))), ((int)(((byte)(62)))));
            this.textBox4.Style.BorderStyle.Bottom = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox4.Style.BorderStyle.Left = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox4.Style.BorderStyle.Right = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox4.Style.BorderStyle.Top = Telerik.Reporting.Drawing.BorderType.Solid;
            this.textBox4.Style.BorderWidth.Bottom = Telerik.Reporting.Drawing.Unit.Pixel(1D);
            this.textBox4.Style.BorderWidth.Default = Telerik.Reporting.Drawing.Unit.Pixel(1D);
            this.textBox4.Style.BorderWidth.Left = Telerik.Reporting.Drawing.Unit.Pixel(1D);
            this.textBox4.Style.BorderWidth.Right = Telerik.Reporting.Drawing.Unit.Pixel(1D);
            this.textBox4.Style.BorderWidth.Top = Telerik.Reporting.Drawing.Unit.Pixel(1D);
            this.textBox4.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox4.Value = "= Fields.doc_code";
            // 
            // payment_request_slip
            // 
            this.DataSource = this.sqlDataSource1;
            this.Items.AddRange(new Telerik.Reporting.ReportItemBase[] {
            this.pageHeaderSection1,
            this.detail,
            this.pageFooterSection1});
            this.Name = "payment_request_slip";
            this.PageSettings.Margins = new Telerik.Reporting.Drawing.MarginsU(Telerik.Reporting.Drawing.Unit.Mm(20D), Telerik.Reporting.Drawing.Unit.Mm(20D), Telerik.Reporting.Drawing.Unit.Mm(20D), Telerik.Reporting.Drawing.Unit.Mm(20D));
            this.PageSettings.PaperKind = System.Drawing.Printing.PaperKind.A4;
            styleRule1.Selectors.AddRange(new Telerik.Reporting.Drawing.ISelector[] {
            new Telerik.Reporting.Drawing.TypeSelector(typeof(Telerik.Reporting.TextItemBase)),
            new Telerik.Reporting.Drawing.TypeSelector(typeof(Telerik.Reporting.HtmlTextBox))});
            styleRule1.Style.Padding.Left = Telerik.Reporting.Drawing.Unit.Point(2D);
            styleRule1.Style.Padding.Right = Telerik.Reporting.Drawing.Unit.Point(2D);
            this.StyleSheet.AddRange(new Telerik.Reporting.Drawing.StyleRule[] {
            styleRule1});
            this.Width = Telerik.Reporting.Drawing.Unit.Cm(20D);
            ((System.ComponentModel.ISupportInitialize)(this)).EndInit();

            }
		#endregion
		
		private Telerik.Reporting.PageHeaderSection pageHeaderSection1;
		private Telerik.Reporting.DetailSection detail;
		private Telerik.Reporting.PageFooterSection pageFooterSection1;
        private Telerik.Reporting.SqlDataSource sqlDataSource1;
        private Telerik.Reporting.TextBox textBox1;
        private Telerik.Reporting.TextBox textBox2;
        private Telerik.Reporting.TextBox textBox22;
        private Telerik.Reporting.TextBox textBox23;
        private Telerik.Reporting.TextBox textBox4;
        private Telerik.Reporting.TextBox textBox5;
        private Telerik.Reporting.TextBox textBox7;
        private Telerik.Reporting.TextBox textBox11;
    }
}