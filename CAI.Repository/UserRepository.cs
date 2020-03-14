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
    public class UserRepository : IUserRepository
    {
        private readonly IBaseConnectionFactory _connectionFactory;
        public UserRepository(IBaseConnectionFactory connectionFactory)
        {
            _connectionFactory = connectionFactory;
        }
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
                SqlMapper.Execute(_connectionFactory.GetConnection, "usp_AddUsers",  parameters, commandType:StoredProcedure);
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
            IList<UserEntity> userList = SqlMapper.Query<UserEntity>(_connectionFactory.GetConnection, "usp_UserSelectAll", commandType:StoredProcedure).ToList();
            return userList;
        }

        public UserEntity GetUserById(int userId)
        {
            try
            {
                DynamicParameters parameters = new DynamicParameters();
                parameters.Add("@Id", userId);
                return SqlMapper.Query<UserEntity>((SqlConnection)_connectionFactory.GetConnection, "usp_GetUserById", parameters, commandType:StoredProcedure).FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw;
            }
        }
        public bool ConfirmEmail(EmailEntity emailEntity)
        {
            try
            {
                DynamicParameters parameters = new DynamicParameters();
                parameters.Add("@EmailId", emailEntity.EmailKey);
                SqlMapper.Execute(_connectionFactory.GetConnection, "usp_UpdateEmailConfirmation", parameters, commandType: StoredProcedure);
                return true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public bool ConfirmPhoneNo(PhoneNoEntity phoneNoEntity)
        {
            try
            {
                DynamicParameters parameters = new DynamicParameters();
                parameters.Add("@MobileNo", phoneNoEntity.PhoneNo);
                SqlMapper.Execute(_connectionFactory.GetConnection, "usp_UpdateMobileConfirmation", parameters, commandType: StoredProcedure);
                return true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public bool ValidateOtp(PhoneNoEntity phoneNoEntity)
        {
            try
            {
                DynamicParameters parameters = new DynamicParameters();
                parameters.Add("@UserId", phoneNoEntity.UserId);
                parameters.Add("@MobileNo", phoneNoEntity.PhoneNo);
                parameters.Add("@Otp", phoneNoEntity.Otp);
                return SqlMapper.Query<bool>((SqlConnection)_connectionFactory.GetConnection, "usp_ValidateOtp", parameters, commandType: StoredProcedure).FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public bool UpdatePanNo(PanNoEntity panNoEntity)
        {
            try
            {
                DynamicParameters parameters = new DynamicParameters();
                parameters.Add("@UserId", panNoEntity.UserId);
                parameters.Add("@PanNo", panNoEntity.PanNo);
                SqlMapper.Execute(_connectionFactory.GetConnection, "usp_UpdatePanNo", parameters, commandType: StoredProcedure);
                return true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public bool SaveOtp(int userId,string otp)
        {
            try
            {
                DynamicParameters parameters = new DynamicParameters();
                parameters.Add("@UserId", userId);
                parameters.Add("@Otp", otp);
                SqlMapper.Execute(_connectionFactory.GetConnection, "usp_UpdateOtp", parameters, commandType: StoredProcedure);
                return true;
            }
            catch (Exception ex)
            {
                throw ex;
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
                SqlMapper.Execute(_connectionFactory.GetConnection, "usp_UpdateUser",  parameters, commandType:StoredProcedure);
                return true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
