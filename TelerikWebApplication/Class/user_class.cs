using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace TelerikWebApplication.Class
{
    class user_class:db_connection
    {
        public string user_id { get; set; }
        public string password{get; set;}

        public bool valid_reg_log_user()
        {
            bool is_valid = false;
            using (SqlCommand cmd = new SqlCommand())
            {
                open_koneksi();
                cmd.Connection = kon;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "select * from sec_user where user_id=@uid and pass=(select convert(varchar(50),Hashbytes('MD5',@pass),2))";
                cmd.Parameters.Add("@uid", SqlDbType.VarChar).Value = user_id;
                cmd.Parameters.Add("@pass", SqlDbType.VarChar).Value = password;

                SqlDataReader dr;
                dr = null;

                try
                {
                    dr = cmd.ExecuteReader();
                    while (dr.Read())
                    {
                        is_valid = true;
                    }
                }
                catch (Exception ex)
                {
                    error_koneksi();
                    throw new ApplicationException("Something wrong with your login module", ex);
                }
                return is_valid;
            }
        }

    }
}
