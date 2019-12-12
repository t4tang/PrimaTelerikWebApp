using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using TelerikWebApplication.Class;

namespace TelerikWebApplication.Form.Master_data.Material.Brand
{
    public partial class material_brand : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                RadGrid1.MasterTableView.EditMode = (GridEditMode)Enum.Parse(typeof(GridEditMode), "EditForms");

            }
        }

        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();
        public DataTable GetDataTable()
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "select * from ms_brand where stEdit != 4";
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

        protected void RadGrid1_UpdateCommand(object source, GridCommandEventArgs e)
        {
            UserControl userControl = (UserControl)e.Item.FindControl(GridEditFormItem.EditFormUserControlID);
            try
            {
                cmd = new SqlCommand("update ms_brand set brand_name = @brand_name, userid = @uid, lastupdate = @lastupdate " +
                    "where brand_code = @brand_code", con);
                con.Open();
                cmd.Parameters.AddWithValue("@brand_code", (userControl.FindControl("txt_brand_code") as TextBox).Text);
                cmd.Parameters.AddWithValue("@brand_name", (userControl.FindControl("txt_brand_name") as TextBox).Text);
                cmd.Parameters.AddWithValue("@uid", public_str.uid);
                cmd.Parameters.AddWithValue("@lastupdate", string.Format("{0:yyyy-MM-dd}", DateTime.Now));
                cmd.ExecuteNonQuery();
                con.Close();

                Label lblsuccess = new Label();
                lblsuccess.Text = "Data updated successfully";
                lblsuccess.ForeColor = System.Drawing.Color.Blue;                
                RadGrid1.Controls.Add(lblsuccess);
            }
            catch (Exception ex)
            {
                con.Close();
                Label lblError = new Label();
                lblError.Text = "Unable to update data. Reason: " + ex.Message;
                lblError.ForeColor = System.Drawing.Color.Red;
                RadGrid1.Controls.Add(lblError);
                e.Canceled = true;
            }
            

            //GridEditableItem editedItem = e.Item as GridEditableItem;
            //UserControl userControl = (UserControl)e.Item.FindControl(GridEditFormItem.EditFormUserControlID);

            ////Prepare new row to add it in the DataSource
            //DataRow[] changedRows = this.Master_Brand.Select("brand_code = '" + editedItem.OwnerTableView.DataKeyValues[editedItem.ItemIndex]["brand_code"] + "'");

            //if (changedRows.Length != 1)
            //{
            //    RadGrid1.Controls.Add(new LiteralControl("Unable to locate the transaction for updating."));
            //    e.Canceled = true;
            //    return;
            //}

            ////Update new values
            //Hashtable newValues = new Hashtable();

            //newValues["brand_code"] = (userControl.FindControl("txt_brand_code") as TextBox).Text;
            //newValues["brand_name"] = (userControl.FindControl("txt_brand_name") as TextBox).Text;
            //newValues["userid"] = public_str.uid.ToString();
            //newValues["lastupdate"] = string.Format("{0:yyyy-MM-dd}", DateTime.Now);
            ////newValues["stEdit"] = (userControl.FindControl("TextBox1") as TextBox).Text;

            //changedRows[0].BeginEdit();
            //try
            //{
            //    foreach (DictionaryEntry entry in newValues)
            //    {
            //        changedRows[0][(string)entry.Key] = entry.Value;
            //    }
            //    changedRows[0].EndEdit();
            //    this.Master_Brand.AcceptChanges();
            //}
            //catch (Exception ex)
            //{
            //    changedRows[0].CancelEdit();

            //    Label lblError = new Label();
            //    lblError.Text = "Unable to update data. Reason: " + ex.Message;
            //    lblError.ForeColor = System.Drawing.Color.Red;
            //    RadGrid1.Controls.Add(lblError);

            //    e.Canceled = true;
            //}
        }

        protected void RadGrid1_InsertCommand(object source, GridCommandEventArgs e)
        {
            UserControl userControl = (UserControl)e.Item.FindControl(GridEditFormItem.EditFormUserControlID);

            try
            {
                cmd = new SqlCommand("insert into ms_brand (brand_code, brand_name, lastupdate, userid, stEdit) values " +
                    "(@brand_code, @brand_name, @lastupdate, @uid, '0')", con);
                con.Open();
                cmd.Parameters.AddWithValue("@brand_code", (userControl.FindControl("txt_brand_code") as TextBox).Text);
                cmd.Parameters.AddWithValue("@brand_name", (userControl.FindControl("txt_brand_name") as TextBox).Text);
                cmd.Parameters.AddWithValue("@uid", public_str.uid);
                cmd.Parameters.AddWithValue("@lastupdate", string.Format("{0:yyyy-MM-dd}", DateTime.Now));
                cmd.ExecuteNonQuery();
                con.Close();

                Label lblsuccess = new Label();
                lblsuccess.Text = "Data inserted successfully";
                lblsuccess.ForeColor = System.Drawing.Color.Blue;
                RadGrid1.Controls.Add(lblsuccess);
            }
            catch (Exception ex)
            {
                con.Close();
                Label lblError = new Label();
                lblError.Text = "Unable to insert data. Reason: " + ex.Message;
                lblError.ForeColor = System.Drawing.Color.Red;
                RadGrid1.Controls.Add(lblError);
                e.Canceled = true;
            }

            ////Create new row in the DataSource
            //DataRow newRow = this.Master_Brand.NewRow();

            ////Insert new values
            //Hashtable newValues = new Hashtable();

            //newValues["brand_code"] = (userControl.FindControl("txt_brand_code") as TextBox).Text;
            //newValues["brand_name"] = (userControl.FindControl("txt_brand_name") as TextBox).Text;
            //newValues["userid"] = public_str.uid;
            //newValues["lastupdate"] = string.Format("{0:yyyy-MM-dd}", DateTime.Now);
            //newValues["stEdit"] = "0";

            ////make sure that unique primary key value is generated for the inserted row 
            ////newValues["brand_code"] = (int)this.Master_Brand.Rows[this.Master_Brand.Rows.Count - 1]["brand_code"] + 1;
            //try
            //{
            //    foreach (DictionaryEntry entry in newValues)
            //    {
            //        newRow[(string)entry.Key] = entry.Value;
            //    }
            //    this.Master_Brand.Rows.Add(newRow);
            //    this.Master_Brand.AcceptChanges();
            //}
            //catch (Exception ex)
            //{
            //    Label lblError = new Label();
            //    lblError.Text = "Unable to insert data. Reason: " + ex.Message;
            //    lblError.ForeColor = System.Drawing.Color.Red;
            //    RadGrid1.Controls.Add(lblError);

            //    e.Canceled = true;
            //}
        }

        protected void RadGrid1_DeleteCommand(object source, GridCommandEventArgs e)
        {
            UserControl userControl = (UserControl)e.Item.FindControl(GridEditFormItem.EditFormUserControlID);
            
            try
            {
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "update ms_brand set stEdit = 4 where brand_code = @brand_code";
                cmd.Parameters.AddWithValue("@brand_code", (RadGrid1.SelectedItems[0] as GridDataItem).GetDataKeyValue("brand_code").ToString());
                cmd.ExecuteNonQuery();
                con.Close();                    

            }
            catch (Exception ex)
            {
                con.Close();
                Label lblError = new Label();
                lblError.Text = "Unable to delete data. Reason: " + ex.Message;
                lblError.ForeColor = System.Drawing.Color.Red;
                RadGrid1.Controls.Add(lblError);
                e.Canceled = true;
            }
           
        }

        //protected void RadGrid1_PreRender(object sender, System.EventArgs e)
        //{
        //    if (!this.IsPostBack && this.RadGrid1.MasterTableView.Items.Count > 1)
        //    {
        //        this.RadGrid1.MasterTableView.Items[0].Edit = false;
        //        this.RadGrid1.MasterTableView.Rebind();
        //    }
        //}



        //private DataTable GetDataTable(string queryString)
        //{
        //    SqlConnection con = new SqlConnection(db_connection.koneksi);
        //    SqlDataAdapter sda = new SqlDataAdapter();
        //    SqlCommand cmd = new SqlCommand();

        //    con.Open();
        //    cmd = new SqlCommand();
        //    cmd.CommandType = CommandType.Text;
        //    cmd.Connection = con;
        //    cmd.CommandText = queryString;
        //    cmd.CommandTimeout = 0;
        //    cmd.ExecuteNonQuery();
        //    sda = new SqlDataAdapter(cmd);

        //    DataTable myDataTable = new DataTable();
        //    //con.Open();
        //    try
        //    {
        //        sda.Fill(myDataTable);
        //    }
        //    finally
        //    {
        //        con.Close();
        //    }

        //    return myDataTable;
        //}

        //private DataTable Master_Brand
        //{
        //    get
        //    {
        //        //object obj = this.Session["brand"];
        //        //if ((!(obj == null)))
        //        //{
        //        //    return ((DataTable)(obj));
        //        //}
        //        DataTable myDataTable = new DataTable();
        //        //myDataTable = GetDataTable("SELECT * FROM tr_purchaseH");
        //        myDataTable = GetDataTable("select * from ms_brand where stEdit != 4");
        //        //this.Session["brand"] = myDataTable;
        //        return myDataTable;
        //    }
        //}

        //protected void RadGrid1_NeedDataSource(object source, GridNeedDataSourceEventArgs e)
        //{
        //    //this.RadGrid1.DataSource = this.Master_Brand;
        //    //this.Master_Brand.PrimaryKey = new DataColumn[] { this.Master_Brand.Columns["brand_code"] };

        //}






    }
}