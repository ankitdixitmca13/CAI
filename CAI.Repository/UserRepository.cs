using CAI.Entities;
using CAI.Repository.Interfaces;
using Dapper;
using System;
using System.Collections.Generic;
using System.Text;
using System.Data.SqlClient;
using System.Linq;
using static System.Data.CommandType;
using System.Data;

namespace CAI.Repository
{
    public class UserRepository : BaseRepository, IUserRepository
    {
    
        public bool AddUser(UserEntity user)
        {
            try
            {
                DynamicParameters parameters = new DynamicParameters();
                parameters.Add("@UserName", user.UserName);
                parameters.Add("@Emaild", user.EmailId);
                parameters.Add("@UserEmail", user.Password);
                parameters.Add("@IsActivated", user.IsActivated);
                parameters.Add("@IsDeleted", user.IsDeleted);
                //conn.Execute("AddUser", parameters, commandType: CommandType.StoredProcedure);
                //return true;
                SqlMapper.Execute(con, "AddUser",  parameters, commandType:StoredProcedure);
                return true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool DeleteUser(int userId)
        {
            throw new NotImplementedException();
        }

        public IList<UserEntity> GetAllUser()
        {
            IList<UserEntity> userList = SqlMapper.Query<UserEntity>(con, "GetAllUsers", commandType:StoredProcedure).ToList();
            return userList;
            throw new NotImplementedException();
        }

        public UserEntity GetUserById(int userId)
        {
            try
            {
                DynamicParameters parameters = new DynamicParameters();
                parameters.Add("@CustomerID", userId);
                return SqlMapper.Query<UserEntity>((SqlConnection)con, "GetUserById", parameters, commandType:StoredProcedure).FirstOrDefault();
            }
            catch (Exception)
            {
                throw;
            }
        }

        public bool UpdateUser(UserEntity user)
        {
            try
            {
                DynamicParameters parameters = new DynamicParameters();
                parameters.Add("@Id", user.Id);
                parameters.Add("@UserName", user.UserName);
                parameters.Add("@EmailId", user.EmailId);
                parameters.Add("@Password", user.Password);
                parameters.Add("@IsActivated", user.IsActivated);
                parameters.Add("@IsDeleted", user.IsDeleted);
                SqlMapper.Execute(con, "UpdateUser",  parameters, commandType:StoredProcedure);
                return true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
