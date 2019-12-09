using TelerikWebApplication.Class;
using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace TelerikWebApplication
{
    public partial class Notes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                RadGrid1.MasterTableView.EditMode = (GridEditMode)Enum.Parse(typeof(GridEditMode), "EditForms");
            }


            //string[] folders = new string[] { "All (14)", "Personal (0)", "Work (0)" };

            //// Populate the Desktop TreeView control
            //RadTreeView tree = (RadTreeView)FolderNavigationControl.FindControl("rtvFolders");

            //foreach (string folder in folders)
            //{
            //    tree.Nodes.Add(new RadTreeNode(folder));
            //}

            //// Populate the Mobile RadMenu control

            //RadMenu menu = (RadMenu)MobileNavigation.FindControl("popupMenu");
            //foreach (string folder in folders)
            //{
            //    menu.Items.Add(new RadMenuItem(folder));
            //}
        }

        protected void RadGrid1_PreRender(object sender, System.EventArgs e)
        {
            if (!this.IsPostBack && this.RadGrid1.MasterTableView.Items.Count > 1)
            {
                this.RadGrid1.MasterTableView.Items[0].Edit = false;
                this.RadGrid1.MasterTableView.Rebind();
            }
        }
        private static DataTable GetDataTable(string queryString)
        {
            SqlConnection con = new SqlConnection(db_connection.koneksi);
            SqlDataAdapter sda = new SqlDataAdapter();
            SqlCommand cmd = new SqlCommand();
            //sda.SelectCommand = new SqlCommand(queryString, con);

            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = queryString;
            cmd.Parameters.AddWithValue("@date", "01/02/2018");
            cmd.Parameters.AddWithValue("@todate", "02/02/2018");
            cmd.Parameters.AddWithValue("@project", "SMB");
            cmd.CommandTimeout = 0;
            cmd.ExecuteNonQuery();
            sda = new SqlDataAdapter(cmd);

            //dt = new DataTable();

            DataTable myDataTable = new DataTable();
            //con.Open();
            try
            {
                sda.Fill(myDataTable);
            }
            finally
            {
                con.Close();
            }

            return myDataTable;
        }

        private DataTable Purchase_H
        {
            get
            {
                object obj = this.Session["po_h"];
                if ((!(obj == null)))
                {
                    return ((DataTable)(obj));
                }
                DataTable myDataTable = new DataTable();
                //myDataTable = GetDataTable("SELECT * FROM tr_purchaseH");
                myDataTable = GetDataTable("sp_get_purchase_order");
                this.Session["po_h"] = myDataTable;
                return myDataTable;
            }
        }

        protected void RadGrid1_NeedDataSource(object source, GridNeedDataSourceEventArgs e)
        {
            this.RadGrid1.DataSource = this.Purchase_H;
            this.Purchase_H.PrimaryKey = new DataColumn[] { this.Purchase_H.Columns["po_code"] };
        }

        protected void RadGrid1_UpdateCommand(object source, GridCommandEventArgs e)
        {
            GridEditableItem editedItem = e.Item as GridEditableItem;
            UserControl userControl = (UserControl)e.Item.FindControl(GridEditFormItem.EditFormUserControlID);

            //Prepare new row to add it in the DataSource
            DataRow[] changedRows = this.Purchase_H.Select("po_code = " + editedItem.OwnerTableView.DataKeyValues[editedItem.ItemIndex]["po_code"]);

            if (changedRows.Length != 1)
            {
                RadGrid1.Controls.Add(new LiteralControl("Unable to locate the transaction for updating."));
                e.Canceled = true;
                return;
            }

            //Update new values
            Hashtable newValues = new Hashtable();

            newValues["Country"] = (userControl.FindControl("TextBox7") as TextBox).Text;
            newValues["City"] = (userControl.FindControl("TextBox8") as TextBox).Text;
            newValues["Region"] = (userControl.FindControl("TextBox9") as TextBox).Text;
            newValues["HomePhone"] = (userControl.FindControl("HomePhoneBox") as RadMaskedTextBox).Text;
            newValues["BirthDate"] = (userControl.FindControl("BirthDatePicker") as RadDatePicker).SelectedDate.ToString();
            newValues["TitleOfCourtesy"] = (userControl.FindControl("ddlTOC") as DropDownList).SelectedItem.Value;

            newValues["Notes"] = (userControl.FindControl("TextBox1") as TextBox).Text;
            newValues["Address"] = (userControl.FindControl("TextBox6") as TextBox).Text;
            newValues["FirstName"] = (userControl.FindControl("TextBox2") as TextBox).Text;
            newValues["LastName"] = (userControl.FindControl("TextBox3") as TextBox).Text;
            newValues["HireDate"] = (userControl.FindControl("HireDatePicker") as RadDatePicker).SelectedDate.ToString();
            newValues["Title"] = (userControl.FindControl("TextBox4") as TextBox).Text;

            changedRows[0].BeginEdit();
            try
            {
                foreach (DictionaryEntry entry in newValues)
                {
                    changedRows[0][(string)entry.Key] = entry.Value;
                }
                changedRows[0].EndEdit();
                this.Purchase_H.AcceptChanges();
            }
            catch (Exception ex)
            {
                changedRows[0].CancelEdit();

                Label lblError = new Label();
                lblError.Text = "Unable to update Employees. Reason: " + ex.Message;
                lblError.ForeColor = System.Drawing.Color.Red;
                RadGrid1.Controls.Add(lblError);

                e.Canceled = true;
            }
        }

        protected void RadGrid1_InsertCommand(object source, GridCommandEventArgs e)
        {
            UserControl userControl = (UserControl)e.Item.FindControl(GridEditFormItem.EditFormUserControlID);

            //Create new row in the DataSource
            DataRow newRow = this.Purchase_H.NewRow();

            //Insert new values
            Hashtable newValues = new Hashtable();

            newValues["Country"] = (userControl.FindControl("TextBox7") as TextBox).Text;
            newValues["City"] = (userControl.FindControl("TextBox8") as TextBox).Text;
            newValues["Region"] = (userControl.FindControl("TextBox9") as TextBox).Text;
            newValues["HomePhone"] = (userControl.FindControl("HomePhoneBox") as RadMaskedTextBox).Text;
            newValues["BirthDate"] = (userControl.FindControl("BirthDatePicker") as RadDatePicker).SelectedDate.ToString();
            newValues["TitleOfCourtesy"] = (userControl.FindControl("ddlTOC") as DropDownList).SelectedItem.Value;

            newValues["Notes"] = (userControl.FindControl("TextBox1") as TextBox).Text;
            newValues["Address"] = (userControl.FindControl("TextBox6") as TextBox).Text;
            newValues["FirstName"] = (userControl.FindControl("TextBox2") as TextBox).Text;
            newValues["LastName"] = (userControl.FindControl("TextBox3") as TextBox).Text;
            newValues["HireDate"] = (userControl.FindControl("HireDatePicker") as RadDatePicker).SelectedDate.ToString();
            newValues["Title"] = (userControl.FindControl("TextBox4") as TextBox).Text;

            //make sure that unique primary key value is generated for the inserted row 
            newValues["po_code"] = (int)this.Purchase_H.Rows[this.Purchase_H.Rows.Count - 1]["po_code"] + 1;
            try
            {
                foreach (DictionaryEntry entry in newValues)
                {
                    newRow[(string)entry.Key] = entry.Value;
                }
                this.Purchase_H.Rows.Add(newRow);
                this.Purchase_H.AcceptChanges();
            }
            catch (Exception ex)
            {
                Label lblError = new Label();
                lblError.Text = "Unable to insert data. Reason: " + ex.Message;
                lblError.ForeColor = System.Drawing.Color.Red;
                RadGrid1.Controls.Add(lblError);

                e.Canceled = true;
            }
        }
        protected void RadGrid1_DeleteCommand(object source, GridCommandEventArgs e)
        {
            string ID = (e.Item as GridDataItem).OwnerTableView.DataKeyValues[e.Item.ItemIndex]["po_code"].ToString();
            DataTable employeeTable = this.Purchase_H;
            if (employeeTable.Rows.Find(ID) != null)
            {
                employeeTable.Rows.Find(ID).Delete();
                employeeTable.AcceptChanges();
            }
        }
    }
}