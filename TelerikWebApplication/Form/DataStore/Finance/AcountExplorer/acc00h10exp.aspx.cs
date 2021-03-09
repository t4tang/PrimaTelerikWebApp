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

namespace TelerikWebApplication.Form.DataStore.Finance.AcountExplorer
{
    public partial class acc00h10exp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(db_connection.koneksi);

            if (!Page.IsPostBack)
            {
                LoadRootNodes(RadTreeView1, TreeNodeExpandMode.ServerSideCallBack);
            }
        }

        private static void LoadRootNodes(RadTreeView treeView, TreeNodeExpandMode expandMode)
        {
            DataTable data = GetData(new SqlCommand("SELECT van1.acc_code, van1.acc_code +' - '+van1.acc_name as acc_name FROM v_account_number van1 WHERE van1.tLevel = 1"));

            foreach (DataRow row in data.Rows)
            {
                RadTreeNode node = new RadTreeNode();
                node.Text = row["acc_name"].ToString();
                node.Value = row["acc_code"].ToString();
                node.ExpandMode = expandMode;
                treeView.Nodes.Add(node);
            }
        }
        private static DataTable GetData(SqlCommand selectCommand)
        {
            selectCommand.Connection = new SqlConnection(
                ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            SqlDataAdapter adapter = new SqlDataAdapter(selectCommand);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void RadTreeView1_NodeExpand(object sender, RadTreeNodeEventArgs e)
        {
            PopulateNodeOnDemand(e, TreeNodeExpandMode.ServerSideCallBack);
        }

        private static void PopulateNodeOnDemand(RadTreeNodeEventArgs e, TreeNodeExpandMode expandMode)
        {
            DataTable data = GetChildNodes(e.Node.Value);

            foreach (DataRow row in data.Rows)
            {
                RadTreeNode node = new RadTreeNode();
                node.Text = row["acc_name"].ToString();
                node.Value = row["acc_code"].ToString();
                if (Convert.ToInt32(row["ChildrenCount"]) > 0)
                {
                    node.ExpandMode = expandMode;
                }
                e.Node.Nodes.Add(node);
            }

            e.Node.Expanded = true;
        }
        private static DataTable GetChildNodes(string parentId)
        {
            SqlCommand selectCommand = new SqlCommand(@"SELECT van1.acc_code, van1.acc_code +' - '+van1.acc_name as acc_name, ISNULL(van2.ChildrenCount, 0) as ChildrenCount
                                FROM v_account_number as van1 LEFT JOIN
                                 (
                                     SELECT   kdparent, COUNT(*) AS ChildrenCount
                                     FROM     v_account_number
                                     Group By (kdparent)
                                 ) as van2
                                ON van1.acc_code = van2.kdparent WHERE van1.kdparent = @kdparent");
            selectCommand.Parameters.AddWithValue("@kdparent", parentId);
            return GetData(selectCommand);
        }

        protected void btn_new_Click(object sender, EventArgs e)
        {
            //RadGrid1.MasterTableView.IsItemInserted = true;
            //RadGrid1.MasterTableView.Rebind();
        }
        //private static void BindToDataSet(RadTreeView treeView)
        //{
        //    SqlDataAdapter adapter = new SqlDataAdapter("SELECT acc_code, acc_name, kdparent FROM v_account_number",
        //            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);

        //    DataSet links = new DataSet();

        //    adapter.Fill(links);
        //    treeView.DataTextField = "acc_name";
        //    treeView.DataFieldID = "acc_code";
        //    treeView.DataFieldParentID = "kdparent";

        //    treeView.DataSource = links;
        //    treeView.DataBind();
        //}

        //private void populateNode(string parent, RadTreeView treeView)
        //{
        //    SqlDataAdapter adapter = new SqlDataAdapter("SELECT * FROM v_account_number WHERE v_account_number.kdParent = '" + parent + "'",
        //            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);

        //    DataSet links = new DataSet();

        //    adapter.Fill(links);
        //    treeView.DataTextField = "acc_name";
        //    treeView.DataFieldID = "acc_code";
        //    treeView.DataFieldParentID = "kdparent";

        //    treeView.DataSource = links;
        //    treeView.DataBind();

        //}

        //protected void RadTreeView1_NodeClick(object sender, RadTreeNodeEventArgs e)
        //{
        //    SqlDataAdapter adapter = new SqlDataAdapter("SELECT * FROM v_account_number WHERE v_account_number.kdParent = '01'",
        //            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);

        //    DataSet links = new DataSet();

        //    adapter.Fill(links);
        //    (sender as RadTreeView).DataTextField = "acc_name";
        //    (sender as RadTreeView).DataFieldID = "acc_code";
        //    (sender as RadTreeView).DataFieldParentID = "kdparent";

        //    (sender as RadTreeView).DataSource = links;
        //    (sender as RadTreeView).DataBind();
        //}
    }
}