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
            //string connectionString = @"Data Source=208.91.198.196;Initial Catalog=caiavt6l;user id=caiavt6l;password=@#aVISHAKE23;";
            string connectionString = @"Data Source=Ram\Ram;Initial Catalog=DB_CAI;user id=sa;password=ssms;";
            con = new SqlConnection(connectionString);
        }
        public void Dispose()
        {
            //throw new NotImplementedException();  
        }
    }
}
