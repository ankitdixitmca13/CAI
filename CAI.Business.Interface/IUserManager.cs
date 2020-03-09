using CAI.Entities;
using System;
using System.Collections.Generic;
using System.Text;

namespace CAI.Business.Contracts
{
   public interface IUserManager
    {
        bool AddUser(UserEntity user);
        bool UpdateUser(UserEntity user);
        bool DeleteUser(int userId);
        IList<UserEntity> GetAllUser();
        UserEntity GetUserById(int userId);
        UserEntity AuthenticateUser(string username, string password);
        bool ConfirmEmail(EmailEntity emailModel);
        bool ConfirmPhoneNo(PhoneNoEntity phoneNoEntity);
    }
}
