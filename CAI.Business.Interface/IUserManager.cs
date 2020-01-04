using CAI.Entities;
using System;
using System.Collections.Generic;
using System.Text;

namespace CAI.Business.Interfaces
{
   public interface IUserManager
    {
        bool AddUser(UserEntity user);
        bool UpdateUser(UserEntity user);
        bool DeleteUser(int userId);
        IList<UserEntity> GetAllUser();
        UserEntity GetUserById(int userId);
    }
}
