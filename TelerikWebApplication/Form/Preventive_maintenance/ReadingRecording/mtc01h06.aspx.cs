﻿using System;
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

namespace TelerikWebApplication.Form.Preventive_maintenance.ReadingRecording
{
    public partial class mtc01h06 : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();

        public static string unit_code = null;
        public static string tr_name { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                lbl_form_name.Text = "Equipment Reading Recording";
                dtp_from.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
                dtp_to.SelectedDate = DateTime.Now;
            }
        }
        protected void RadGrid1_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            RadGrid1.DataSource = GetDataTable(public_str.site);
        }
        public DataTable GetDataTable(string project)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            if(project != "HOF")
                cmd.CommandText = "SELECT mtc00h16.unit_code, mtc00h16.model_no, mtc00h16.key_no, mtc00h16.region_code, inv00h09.region_name " +
                "FROM mtc00h16 INNER JOIN inv00h09 ON mtc00h16.region_code = inv00h09.region_code WHERE mtc00h16.active = '1' AND mtc00h16.region_code = @region_code";
            else
                cmd.CommandText = "SELECT mtc00h16.unit_code, mtc00h16.model_no, mtc00h16.key_no, mtc00h16.region_code, inv00h09.region_name " +
                "FROM mtc00h16 INNER JOIN inv00h09 ON mtc00h16.region_code = inv00h09.region_code WHERE mtc00h16.active = '1'";
            
            cmd.Parameters.AddWithValue("@region_code", project);
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

        protected void RadGrid1_SelectedIndexChanged(object sender, EventArgs e)
        {
            foreach (GridDataItem item in RadGrid1.SelectedItems)
            {
                unit_code = item["unit_code"].Text;
            }
        }
        protected void RadAjaxManager1_AjaxRequest(object sender, AjaxRequestEventArgs e)
        {
            //if (e.Argument == "Rebind")
            //{
            //    RadGrid1.MasterTableView.SortExpressions.Clear();
            //    RadGrid1.MasterTableView.GroupByExpressions.Clear();
            //    RadGrid1.Rebind(); /* Kemudian RadGrid1 akan sorting data by lastupdate (lihat sp_get_purchase_requestH*/

            //    RadGrid1.MasterTableView.Items[0].Selected = true;

            //    //RadGrid2.DataSource = GetDataDetailTable(tr_code);
            //    //RadGrid2.Rebind();
            //}
            //else if (e.Argument == "RebindAndNavigate")
            //{
            //    RadGrid1.MasterTableView.SortExpressions.Clear();
            //    RadGrid1.MasterTableView.GroupByExpressions.Clear();
            //    //RadGrid1.DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), selected_project);
            //    RadGrid1.DataBind();
            //    //RadGrid1.MasterTableView.CurrentPageIndex = RadGrid1.MasterTableView.PageCount - 1;
            //    //RadGrid1.MasterTableView.Items[RadGrid1.Items.Count - 1].Selected = true;
            //    RadGrid1.MasterTableView.Items[0].Selected = true;
            //    //RadGrid2.DataSource = GetDataDetailTable(tr_code);
            //    //RadGrid2.Rebind();
            //    Session["action"] = "list";
            //}


        }

        protected void RadGrid2_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            (sender as RadGrid).DataSource = new string[] { };
        }
        public DataTable GetDataReading(string unit)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT mtc01h06.unit_code, mtc01h06.reading_date, mtc01h06.reading_amount3, mtc01h06.reading_amount1, mtc01h06.unit_code, mtc01h06.wh, mtc01h06.broken_hm, " +
            "mtc01h06.region_code, mtc01h06.reading_date2, mtc01h06.reading_amount2, mtc01h06.reading_km1, mtc01h06.reading_km2 " +
            "FROM mtc01h06 WHERE mtc01h06.unit_code = @unit_code AND mtc01h06.reading_date between @start_date AND @end_date ORDER BY mtc01h06.reading_date Desc";
            cmd.Parameters.AddWithValue("@unit_code", unit);
            cmd.Parameters.AddWithValue("@start_date", dtp_from.SelectedDate);
            cmd.Parameters.AddWithValue("@end_date", dtp_to.SelectedDate);
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

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            RadGrid2.DataSource = GetDataReading(unit_code);
            RadGrid2.DataBind();
        }

        protected void btnSave_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_save_reading_recording";
                cmd.Parameters.AddWithValue("@unit_code", cb_unit.Text);
                cmd.Parameters.AddWithValue("@region_code", cb_project.SelectedValue);
                cmd.Parameters.AddWithValue("@reading_amount1", txt_HM.Value);
                cmd.Parameters.AddWithValue("@last_reading", txt_last_HM_KM.Value);
                cmd.Parameters.AddWithValue("@reading_date", dtp_current_date.SelectedDate);
                cmd.Parameters.AddWithValue("@reading_amount3", txt_HM.Value);
                if (chk_breakdown.Checked == true)
                {
                    cmd.Parameters.AddWithValue("@broken_hm", "1");
                }
                else
                {
                    cmd.Parameters.AddWithValue("@broken_hm", "0");
                }
                cmd.ExecuteNonQuery();                             

                con.Close();

            }
            catch (Exception ex)
            {
                con.Close();
                Response.Write("<font color='red'>" + ex.Message + "</font>");
            }
            finally
            {
                get_last_reading(cb_unit.Text);
                txt_HM.Value = 0;
            }
        }
        
        void get_last_reading(string unit)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT mtc01h06.unit_code, mtc01h06.region_code, inv00h09.region_name, mtc01h06.reading_date2, mtc01h06.reading_amount1, mtc01h06.reading_amount2, " +
            "mtc01h06.wh, mtc01h06.reading_km1, mtc01h06.reading_km2, mtc01h06.reading_date, mtc01h06.broken_hm, mtc01h06.reading_amount3, mtc01h06.lastupdate " +
            "FROM mtc01h06 INNER JOIN inv00h09 ON mtc01h06.region_code = inv00h09.region_code WHERE(mtc01h06.unit_code = '" + unit + "') " +
            "AND(mtc01h06.reading_date = (SELECT MAX(reading_date) AS Expr1 FROM mtc01h06 AS mtc01h06_1 WHERE(unit_code = '" + unit + "'))) ";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                cb_project.SelectedValue = dr[1].ToString();
                cb_project.Text = dr["region_name"].ToString();
                cb_unit.Text = unit;
                txt_type.Text = "Hours";
                dtp_last_reading_date.SelectedDate = Convert.ToDateTime(dr["reading_date"].ToString());
                txt_last_HM_KM.Value = Convert.ToDouble(dr["reading_amount1"].ToString());
                txt_last_HM_KM_accum.Value = Convert.ToDouble(dr["reading_amount3"].ToString());
                dtp_current_date.SelectedDate = DateTime.Now;
            }
            dr.Close();
            con.Close();
        }
        protected void btnNew_Click(object sender, ImageClickEventArgs e)
        {

            string selected_unit = null;
            foreach (GridDataItem item in RadGrid1.SelectedItems)
            {
                selected_unit = item["unit_code"].Text;
            }

            if(selected_unit != null)
            {
                get_last_reading(selected_unit);

                txt_HM.Value = 0;
                btnSave.Enabled = true;
                btnSave.ImageUrl = "~/Images/simpan.png";
            }
            else
            {
                cb_project.SelectedValue = null;
                cb_project.Text = string.Empty;
                cb_unit.Text = string.Empty;
                txt_type.Text = "Hours";
                dtp_last_reading_date.SelectedDate = null;
                txt_last_HM_KM.Value = 0;
                txt_last_HM_KM_accum.Value = 0;
                dtp_current_date.SelectedDate = DateTime.Now;

                btnSave.Enabled = false;
                btnSave.ImageUrl = "~/Images/simpan-gray.png";
            }
            
        }
    }
}