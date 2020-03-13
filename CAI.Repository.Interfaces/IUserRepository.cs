using CAI.Entities;
using System;
using System.Collections.Generic;
using System.Text;

namespace CAI.Repository.Contracts
{
    public interface IUserRepository
    {
        bool AddUser(UserEntity user);
        bool UpdateUser(UserEntity user);
        bool DeleteUser(int userId);
        IList<UserEntity> GetAllUser();
        UserEntity GetUserById(int userId);
        bool ConfirmEmail(EmailEntity emailModel);
        bool ConfirmPhoneNo(PhoneNoEntity phoneNoEntity);
        bool SaveOtp(int userId, string otp);
        bool UpdatePanNo(PanNoEntity panNoEntity);
        bool ValidateOtp(PhoneNoEntity phoneNoEntity);
    }
}
