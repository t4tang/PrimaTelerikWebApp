using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

namespace TelerikWebApplication.Class
{
    class db_connection
    {        
        public static string koneksi = ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString;
        public SqlConnection kon = new SqlConnection(koneksi);
        public SqlTransaction transaksi;

        public void open_koneksi()
        {
            //kon.Close();
            kon.Open();
        }

        public void close_koneksi()
        {
            kon.Close();
        }

        public void error_koneksi()
        {
            transaksi.Rollback();
            kon.Close();
        }
    }
}
