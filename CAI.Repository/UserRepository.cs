using CAI.Entities;
using CAI.Repository.Contracts;
using Dapper;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using static System.Data.CommandType;

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
                parameters.Add("@EmailId", user.EmailId);
                parameters.Add("@Password", user.Password);
                parameters.Add("@MobileNo", user.MobileNo);
                parameters.Add("@IsActivated", user.IsActivated);
                parameters.Add("@IsDeleted", user.IsDeleted);
                SqlMapper.Execute(con, "usp_AddUsers",  parameters, commandType:StoredProcedure);
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
            IList<UserEntity> userList = SqlMapper.Query<UserEntity>(con, "usp_UserSelectAll", commandType:StoredProcedure).ToList();
            return userList;
        }

        public UserEntity GetUserById(int userId)
        {
            try
            {
                DynamicParameters parameters = new DynamicParameters();
                parameters.Add("@Id", userId);
                return SqlMapper.Query<UserEntity>((SqlConnection)con, "usp_GetUserById", parameters, commandType:StoredProcedure).FirstOrDefault();
            }
            catch (Exception ex)
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
                parameters.Add("@UserName", user.EmailId); // for timebeing we are passing username & emailid would be same
                parameters.Add("@EmailId", user.EmailId);
                parameters.Add("@Password", user.Password);
                parameters.Add("@MobileNo", user.MobileNo);
                parameters.Add("@IsActivated", user.IsActivated);
                parameters.Add("@IsDeleted", user.IsDeleted);
                SqlMapper.Execute(con, "usp_UpdateUser",  parameters, commandType:StoredProcedure);
                return true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
