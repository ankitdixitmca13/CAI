using CAI.Entities;
using System;
using System.Collections.Generic;
using System.Text;

namespace CAI.Repository.Interfaces
{
    public interface IUserRepository
    {
        bool AddUser(UserEntity user);
        bool UpdateUser(UserEntity user);
        bool DeleteUser(int userId);
        IList<UserEntity> GetAllUser();
        UserEntity GetUserById(int userId);
    }
}
