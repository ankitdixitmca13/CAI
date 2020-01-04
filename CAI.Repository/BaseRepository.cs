using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace CAI.Repository
{
    public class BaseRepository : IDisposable  
    {
        protected IDbConnection con;
        public BaseRepository()
        {
            string connectionString = @"Data Source=ANKIT\SQLEXPRESS;Initial Catalog=DataManagement;user id=sa;password=z;";
            con = new SqlConnection(connectionString);
        }
        public void Dispose()
        {
            //throw new NotImplementedException();  
        }
    }
}
