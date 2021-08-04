using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using Telerik.Web.UI.Upload;
using TelerikWebApplication.Class;

namespace TelerikWebApplication.Form.Security.Posting.Inventory.Fluid
{
    public partial class acc01h07postFld : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lbl_form_name.Text = "INVENTORY POSTING (FLUID)";
                set_periode();
            }

            if (Request.Browser.Browser == "Safari")
            {
                var am = RadAjaxManager.GetCurrent(this);
                am.AjaxSettings.AddAjaxSetting(btnProcessing, RadProgressManager1);
            }
            if (!IsPostBack)
            {
                //Do not display SelectedFilesCount progress indicator.
                RadProgressArea1.ProgressIndicators &= ~ProgressIndicators.SelectedFilesCount;
            }

            RadProgressArea1.Localization.Uploaded = "Total Progress";
            RadProgressArea1.Localization.UploadedFiles = "Progress";
            RadProgressArea1.Localization.CurrentFileName = "Posting progress in action: ";
        }
        private void set_periode()
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("SELECT CONVERT(varchar, Fuelstart, 103) Fuelstart, CONVERT(varchar, Fuelend, 103) Fuelend FROM ms_company ", con);

            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            if (dr.Read())
            {                
                public_str.Fuelstart = dr["Fuelstart"].ToString();
                public_str.Fuelend = dr["Fuelend"].ToString();
            }
            
            con.Close();

            DateTime periode = DateTime.Parse(public_str.Fuelstart);

            cbMonth.Text = periode.ToString("MMMM");
            cbMonth.SelectedValue = periode.ToString("MM");
            cbYear.Text = periode.ToString("yyyy");

            txtPerStart.Text = public_str.Fuelstart;
            txtPerEnd.Text = public_str.Fuelend;

            //Label lbl = (Label)Master.FindControl("lblPeriode");
            //lbl.Text = "Periode: " + public_str.perstart + " - " + public_str.perend;
        }
        protected double CalculateMarkupSize(Telerik.Web.UI.RenderMode renderMode)
        {
            Page temporaryPage = new System.Web.UI.Page();
            RadProgressArea area = new RadProgressArea()

            {
                RenderMode = renderMode,
                RegisterWithScriptManager = false,
            };

            RadProgressManager manager = new RadProgressManager()
            {

                RenderMode = renderMode,
                RegisterWithScriptManager = false,
            };

            temporaryPage.Controls.Add(area);
            temporaryPage.Controls.Add(manager);

            StringWriter stringWriter = new StringWriter();
            HtmlTextWriter writer = new HtmlTextWriter(stringWriter);

            area.RenderControl(writer);
            manager.RenderControl(writer);
            return stringWriter.ToString().Length / 1024.0;
        }
        protected void cbMonth_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Add("Januari");
            (sender as RadComboBox).Items.Add("February");
            (sender as RadComboBox).Items.Add("March");
            (sender as RadComboBox).Items.Add("April");
            (sender as RadComboBox).Items.Add("May");
            (sender as RadComboBox).Items.Add("June");
            (sender as RadComboBox).Items.Add("July");
            (sender as RadComboBox).Items.Add("August");
            (sender as RadComboBox).Items.Add("September");
            (sender as RadComboBox).Items.Add("October");
            (sender as RadComboBox).Items.Add("November");
            (sender as RadComboBox).Items.Add("December");
        }
        protected void cbMonth_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if ((sender as RadComboBox).Text == "Januari")
            {
                (sender as RadComboBox).SelectedValue = "1";
            }
            else if ((sender as RadComboBox).Text == "February")
            {
                (sender as RadComboBox).SelectedValue = "2";
            }
            else if ((sender as RadComboBox).Text == "March")
            {
                (sender as RadComboBox).SelectedValue = "3";
            }
            else if ((sender as RadComboBox).Text == "April")
            {
                (sender as RadComboBox).SelectedValue = "4";
            }
            else if ((sender as RadComboBox).Text == "May")
            {
                (sender as RadComboBox).SelectedValue = "5";
            }
            else if ((sender as RadComboBox).Text == "June")
            {
                (sender as RadComboBox).SelectedValue = "6";
            }
            else if ((sender as RadComboBox).Text == "July")
            {
                (sender as RadComboBox).SelectedValue = "7";
            }
            else if ((sender as RadComboBox).Text == "August")
            {
                (sender as RadComboBox).SelectedValue = "8";
            }
            else if ((sender as RadComboBox).Text == "September")
            {
                (sender as RadComboBox).SelectedValue = "9";
            }
            else if ((sender as RadComboBox).Text == "October")
            {
                (sender as RadComboBox).SelectedValue = "10";
            }
            else if ((sender as RadComboBox).Text == "November")
            {
                (sender as RadComboBox).SelectedValue = "11";
            }
            else if ((sender as RadComboBox).Text == "December")
            {
                (sender as RadComboBox).SelectedValue = "12";
            }
        }
        protected void cbYear_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            int i = DateTime.Now.Year;
            for (i = i - 1; i <= DateTime.Now.Year + 3; i++)
                (sender as RadComboBox).Items.Add(Convert.ToString(i));
        }
        private void UpdateProgressContext()
        {
            const int Total = 100;

            RadProgressContext progress = RadProgressContext.Current;
            progress.Speed = "N/A";

            for (int i = 0; i < Total; i++)
            {
                progress.PrimaryTotal = 1;
                progress.PrimaryValue = 1;
                progress.PrimaryPercent = 100;

                progress.SecondaryTotal = Total;
                progress.SecondaryValue = i;
                progress.SecondaryPercent = i;

                progress.CurrentOperationText = "Step " + i.ToString();

                if (!Response.IsClientConnected)
                {
                    //Cancel button was clicked or the browser was closed, so stop processing
                    break;
                }

                progress.TimeEstimated = (Total - i) * 100;
                //Stall the current thread for 0.1 seconds
                System.Threading.Thread.Sleep(50);
            }
        }
        protected void btnProcessing_Click(object sender, EventArgs e)
        {
            if (rblPost.SelectedValue == "1")
            {
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_posting_inventory";
                cmd.Parameters.AddWithValue("@type", "1");
                cmd.Parameters.AddWithValue("@month", Convert.ToInt32(cbMonth.SelectedValue));
                cmd.Parameters.AddWithValue("@year", Convert.ToInt32(cbYear.Text));
                cmd.Parameters.AddWithValue("@uid", public_str.uid);
                try
                {
                    cmd.ExecuteNonQuery();
                    UpdateProgressContext();
                }
                catch (Exception ex)
                {
                    this.Page.ClientScript.RegisterStartupScript(this.GetType(), "ex", "alert('" + ex.Message + "');", true);
                }
                finally
                {
                    con.Close();
                    set_periode();
                }
            }
            else
            {
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_unposting_inventory";
                cmd.Parameters.AddWithValue("@type", "1");
                cmd.Parameters.AddWithValue("@month", Convert.ToInt32(cbMonth.SelectedValue));
                cmd.Parameters.AddWithValue("@year", Convert.ToInt32(cbYear.Text));
                cmd.Parameters.AddWithValue("@uid", public_str.uid);
                try
                {
                    cmd.ExecuteNonQuery();
                    UpdateProgressContext();
                }
                catch (Exception ex)
                {
                    this.Page.ClientScript.RegisterStartupScript(this.GetType(), "ex", "alert('" + ex.Message + "');", true);
                }
                finally
                {
                    con.Close();
                    set_periode();
                }
            }
            

        }
    }
}