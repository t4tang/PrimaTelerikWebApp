using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TelerikWebApplication.Class;
using System.Data.SqlClient;

namespace TelerikWebApplication
{
    public partial class Login : System.Web.UI.Page
    {
        user_class uc = new user_class();
        bool login_ok = false;
        SqlDataReader dr;
        public SqlConnection con = new SqlConnection(db_connection.koneksi);
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        void login()
        {
            uc.user_id = txt_uid.Text;
            uc.password = txt_pwd.Text;
            login_ok = uc.valid_reg_log_user();
            if (login_ok)
            {
                public_str.uid = uc.user_id;

                System.Data.SqlClient.SqlConnectionStringBuilder builder = new System.Data.SqlClient.SqlConnectionStringBuilder(db_connection.koneksi);
                public_str.server_ip = builder.DataSource;
                public_str.database_name = builder.InitialCatalog;
                public_str.database_uid = builder.UserID;
                public_str.database_pwd = builder.Password;
                public_str.login_time = DateTime.Now;

                con.Open();
                //SqlCommand cmd = new SqlCommand("SELECT USER_NAME, REGION_CODE, [LEVEL], sec_group FROM SEC_USER WHERE user_id='" + txt_uid.Text + "'", con);
                SqlCommand cmd = new SqlCommand("SELECT  A.USER_NAME, E.REGION_CODE, B.REGION_NAME, A.Level, A.sec_group, CONVERT(varchar, D.perstart, 103) perstart, " +
                    "CONVERT(varchar, D.perend, 103) perend, UPPER(D.company_name) as company, D.company_code, A.def_modul, UPPER(A.user_id) as user_id, " +
                    "CONVERT(varchar, D.Accstart, 103) Accstart, CONVERT(varchar, D.Accperend, 103) Accperend,  CONVERT(varchar, D.Fuelstart, 103) Fuelstart, " +
                    "CONVERT(varchar, D.Fuelend, 103) Fuelend FROM SEC_USER A, inv00h09 B, inv00h15 D, " +
                    "inv00h26 E WHERE A.user_id='" + txt_uid.Text + "' AND E.REGION_CODE=B.REGION_CODE AND A.user_id=E.NIK", con);

                dr = cmd.ExecuteReader();
                //if (dr.HasRows == false)
                //{
                //    throw new Exception();
                //}
                if (dr.Read())
                {
                    public_str.user_id = dr["user_id"].ToString();
                    public_str.user_name = dr[0].ToString();
                    public_str.site = dr[1].ToString();
                    public_str.sitename = dr[2].ToString();
                    public_str.level = dr[3].ToString();
                    public_str.sec_group = dr[4].ToString();
                    public_str.perstart = dr[5].ToString();
                    public_str.perend = dr[6].ToString();
                    public_str.company_name = dr[7].ToString();
                    public_str.company_code = dr[8].ToString();
                    public_str.modul = dr["def_modul"].ToString();
                    public_str.Accstart = dr["Accstart"].ToString();
                    public_str.Accperend = dr["Accperend"].ToString();
                    public_str.Fuelstart = dr["Fuelstart"].ToString();
                    public_str.Fuelend = dr["Fuelend"].ToString();
                    Session["UID"] = txt_uid.Text;
                    Response.Redirect("~/default.aspx");
                }
                else
                {
                    //lbl_error.Text = "Something wrong with your login";
                }
                con.Close();

            }

        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            login();
        }
    }
}