using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;

namespace TelerikWebApplication.Class
{    
    public class sql_helper
    {
        SqlConnection cn;
        public sql_helper (string connectionString)
        {
            cn = new SqlConnection(connectionString);
        }

        public bool isConnection
        {
            get
            {
                if (cn.State == System.Data.ConnectionState.Closed)
                  cn.Open();
                return true;               
            }
        }
    }
}
