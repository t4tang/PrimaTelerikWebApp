using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using Telerik.Web.UI.HtmlChart.Enums;
using TelerikWebApplication.Class;

namespace TelerikWebApplication
{
    public partial class Home : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();

        const string QUANTITY_FIELD = "yValue1";
        const string VALUE_FIELD = "yValue2";
        const string X_FIELD = "xValue";
        protected void Page_Load(object sender, EventArgs e)
        {
            //RadBaseTile tileToConfigure = RadTileList1.GetSelectedTiles()[0];
            //tileToConfigure.PeekTemplateSettings.Animation = (Telerik.Web.UI.PeekTemplateAnimation)Enum.Parse(
            //    typeof(Telerik.Web.UI.PeekTemplateAnimation), "Fade");
            //tileToConfigure.PeekTemplateSettings.AnimationDuration = Convert.ToInt32(5000);
            //tileToConfigure.PeekTemplateSettings.CloseDelay = Convert.ToInt32(10000);
            //tileToConfigure.PeekTemplateSettings.Easing = "easeLinear";
            //tileToConfigure.PeekTemplateSettings.HidePeekTemplateOnMouseOut = false;
            //tileToConfigure.PeekTemplateSettings.ShowInterval = Convert.ToInt32(2000);
            //tileToConfigure.PeekTemplateSettings.ShowPeekTemplateOnMouseOver = true;
            if (!Page.IsPostBack)
            {
                //StepChart.DataSource = GetData();
                //StepChart.DataBind();

                SplineChart.DataSource = GetData();
                SplineChart.DataBind();

                //ComboBoxStepLineSeries.DataSource = new List<string>() { "Line", "Area" };
                //ComboBoxStepLineSeries.DataBind();
                //ComboBoxStepLineSeries.SelectedIndex = 0;

                //ComboBoxSplineSeries.DataSource = new List<string>()
                //{
                //    "Line", "Area", "Polar Line", "Polar Area", "Radar Line", "Radar Area", "Scatter Line"
                //};
                //ComboBoxSplineSeries.DataBind();
                //ComboBoxSplineSeries.SelectedIndex = 0;
            }

            ApplyConfiguratorsSettings();

            foreach (RadBaseTile tile in RadTileList1.GetAllTiles())
            {
                tile.PeekContentContainer.Controls.Clear();
                string peekTemplateHtml = GetPeekTemplate(tile.PeekTemplateSettings.Animation.ToString(),
                                                        tile.PeekTemplateSettings.AnimationDuration.ToString(),
                                                        tile.PeekTemplateSettings.Easing);
                tile.PeekContentContainer.Controls.Add(new LiteralControl(peekTemplateHtml));
            }

        }
        private DataTable GetData()
        {
            DataTable table = new DataTable();
            table.Columns.Add(new DataColumn(QUANTITY_FIELD, typeof(int)));
            table.Columns.Add(new DataColumn(X_FIELD, typeof(int)));
            table.Columns.Add(new DataColumn(VALUE_FIELD, typeof(double)));
            table.Rows.Add(new object[] { 400, 25, 1.9, });
            table.Rows.Add(new object[] { 720, 50, 3.9, });
            table.Rows.Add(new object[] { 130, 75, 2.9, });
            table.Rows.Add(new object[] { 450, 100, 3.5, });
            table.Rows.Add(new object[] { 600, 125, 1.9, });
            table.Rows.Add(new object[] { 900, 138, 5.1, });
            table.Rows.Add(new object[] { 500, 152, 5.7, });
            table.Rows.Add(new object[] { 400, 166, 3.1, });
            table.Rows.Add(new object[] { 650, 180, 1.7, });
            table.Rows.Add(new object[] { 550, 194, 6.4, });
            table.Rows.Add(new object[] { 720, 208, 8.1, });
            table.Rows.Add(new object[] { 220, 222, 6.5, });
            table.Rows.Add(new object[] { 540, 235, 1.7, });
            table.Rows.Add(new object[] { 380, 249, 4.2, });
            table.Rows.Add(new object[] { 780, 263, 8.2, });
            table.Rows.Add(new object[] { 240, 277, 8.6, });
            table.Rows.Add(new object[] { 500, 291, 5.6, });
            table.Rows.Add(new object[] { 200, 305, 0.9, });
            table.Rows.Add(new object[] { 350, 355, 1.2, });
            return table;
        }
        private void CreateSplineLineSeries()
        {
            LineSeries line = new LineSeries();
            line.LineAppearance.LineStyle = ExtendedLineStyle.Smooth;
            line.DataFieldY = QUANTITY_FIELD;
            SplineChart.PlotArea.Series.Add(line);
        }
        private void ApplyConfiguratorsSettings()
        {
            ConfigureSplineChart();
            //ConfigureStepChart();
        }
        private void ConfigureSplineChart()
        {
            SplineChart.PlotArea.Series.Clear();
            SplineChart.PlotArea.XAxis.MinorGridLines.Visible = true;
            //switch (ComboBoxSplineSeries.SelectedIndex)
            //{
            //    case 0:
            //        {
            CreateSplineLineSeries();
            //break;
            //    }
            //case 1:
            //    {
            //        CreateSplineAreaSeries();
            //        break;
            //    }
            //case 2:
            //    {
            //        CreateSplinePolarLineSeries();
            //        break;
            //    }
            //case 3:
            //    {
            //        CreateSplinePolarAreaSeries();
            //        break;
            //    }
            //case 4:
            //    {
            //        CreateSplineRadarLineSeries();
            //        break;
            //    }
            //case 5:
            //    {
            //        CreateSplineRadarAreaSeries();
            //        break;
            //    }
            //case 6:
            //    {
            //        CreateSplineScatterLineSeries();
            //        break;
            //    }
            //default:
            //    CreateSplineLineSeries();
            //    break;
            //}
        }
        protected string GetPeekTemplate(string animation, string duration, string easing)
        {
            string templateHtml = "<div class='widePeek'>PeekTemplate configuration:<br />Animation: {0}<br />AnimationDuration: {1}<br />Easing: {2}</div>";
            return string.Format(templateHtml, animation, duration, easing == string.Empty ? "none" : easing);
        }

        protected void chk_all_CheckedChanged(object sender, EventArgs e)
        {
            //(sender as CheckBox).Checked = false;
            RadGrid1.DataSource = GetDataTable();
            RadGrid1.DataBind();
        }

        public DataTable GetDataTable()
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sp_get_transaction_review_list";
            cmd.Parameters.AddWithValue("@uid", public_str.uid);
            cmd.Parameters.AddWithValue("@include_closed", chk_all.Checked);
            cmd.CommandTimeout = 0;
            cmd.ExecuteNonQuery();
            sda = new SqlDataAdapter(cmd);

            DataTable DT = new DataTable();

            try
            {
                sda.Fill(DT);
            }
            finally
            {
                con.Close();
            }

            return DT;
        }
        protected void RadGrid1_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            (sender as RadGrid).DataSource = GetDataTable();
        }

        protected void RadGrid1_ItemCreated(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                ImageButton imgLink = (ImageButton)e.Item.FindControl("ViewLink");
                imgLink.Attributes["href"] = "javascript:void(0);";
                if (e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["kode"].ToString() == "PO")
                {
                    imgLink.Attributes["onclick"] = String.Format("return ShowPOPreview('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["tr_no"], e.Item.ItemIndex);
                }
                else if (e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["kode"].ToString() == "GR")
                {
                    imgLink.Attributes["onclick"] = String.Format("return ShowGRPreview('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["tr_no"], e.Item.ItemIndex);
                }
                else if (e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["kode"].ToString() == "RV")
                {
                    imgLink.Attributes["onclick"] = String.Format("return ShowGRPreview('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["tr_no"], e.Item.ItemIndex);
                }
                else if (e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["kode"].ToString() == "UR")
                {
                    imgLink.Attributes["onclick"] = String.Format("return ShowURPreview('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["tr_no"], e.Item.ItemIndex);
                }
            }
        }
    }
}