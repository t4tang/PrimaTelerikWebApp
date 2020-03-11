using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using TelerikWebApplication.Class;

namespace TelerikWebApplication.Form.Fico.Bank.BankPayment
{
    public partial class acc01h03 : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();
        private const int ItemsPerRequest = 10;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                dtp_from.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
                dtp_to.SelectedDate = DateTime.Now;
                cb_project_prm.SelectedValue = public_str.site;

                dtp_to.SelectedDate = DateTime.Now;
                ses_default();
            }
        }

        protected void RadAjaxManager1_AjaxRequest(object sender, Telerik.Web.UI.AjaxRequestEventArgs e)
        {

        }

        protected void cb_project_prm_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {

        }

        protected void cb_project_prm_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

        protected void btnFind_Click(object sender, EventArgs e)
        {

        }

        protected void RadGrid1_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {

        }

        protected void RadGrid1_DeleteCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {

        }
        #region sesi
        private void ses_default()
        {
            Session["Action"] = "default";
            control_status(Page.Controls, false);
            btnNew.Enabled = true;
            btnEdit.Enabled = false;
            btnSave.Enabled = false;
        }
        private void ses_detail()
        {
            Session["Action"] = "detail";
            control_status(Page.Controls, false);
            btnNew.Enabled = true;
            btnEdit.Enabled = true;
            btnSave.Enabled = false;
        }
        private void ses_new()
        {
            Session["Action"] = "new";
            control_status(Page.Controls, true);
            btnNew.Enabled = false;
            btnEdit.Enabled = false;
            btnSave.Enabled = true;
        }
        private void ses_edit()
        {
            Session["Action"] = "edit";
            control_status(Page.Controls, true);
            btnNew.Enabled = false;
            btnEdit.Enabled = false;
            btnSave.Enabled = true;
        }
        private void ses_save()
        {
            Session["Action"] = "save";
            control_status(Page.Controls, true);
            btnNew.Enabled = false;
            btnEdit.Enabled = false;
            btnSave.Enabled = false;
        }
        public void control_status(ControlCollection ctrls, bool state)
        {
            foreach (Control ctrl in ctrls)
            {
                if (ctrl is RadTextBox)
                    ((RadTextBox)ctrl).Enabled = state;
                if (ctrl is RadComboBox)
                    ((RadComboBox)ctrl).Enabled = state;
                else if (ctrl is DropDownList)
                    ((DropDownList)ctrl).Enabled = state;
                else if (ctrl is CheckBox)
                    ((CheckBox)ctrl).Enabled = state;
                else if (ctrl is RadDatePicker)
                    ((RadDatePicker)ctrl).Enabled = state;

                control_status(ctrl.Controls, state);
            }
        }

        private void clear_text(ControlCollection ctrls)
        {
            foreach (Control ctrl in ctrls)
            {
                if (ctrl is RadTextBox)
                {
                    ((RadTextBox)ctrl).Text = string.Empty;

                }
                if (ctrl is RadComboBox)
                    ((RadComboBox)ctrl).Text = string.Empty;
            }
        }

        protected void btnNew_Click(object sender, ImageClickEventArgs e)
        {

        }

        protected void btnEdit_Click(object sender, ImageClickEventArgs e)
        {

        }

        protected void btnSave_Click(object sender, ImageClickEventArgs e)
        {

        }

        protected void cb_project_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {

        }

        protected void cb_project_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

        protected void cb_project_PreRender(object sender, EventArgs e)
        {

        }

        protected void NoRef_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {

        }

        protected void NoRef_PreRender(object sender, EventArgs e)
        {

        }

        protected void cb_bank_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {

        }

        protected void cb_bank_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

        protected void cb_bank_PreRender(object sender, EventArgs e)
        {

        }
    }
}