using CAI.Business.Interfaces;
using CAI.Entities;
using CAI.Repository.Interfaces;
using System;
using System.Collections.Generic;
using System.Text;

namespace CAI.Business
{
   public  class UserManager: IUserManager
    {
        IUserRepository _userRepository;
        public UserManager(IUserRepository userRepository)
        {
            _userRepository = userRepository;
        }
        public bool AddUser(UserEntity user)
        {
            return _userRepository.AddUser(user);
        }
        public bool DeleteUser(int userId)
        {
            return _userRepository.DeleteUser(userId);
        }
        public IList<UserEntity> GetAllUser()
        {
            return _userRepository.GetAllUser();
        }
        public UserEntity GetUserById(int userId)
        {
            return _userRepository.GetUserById(userId);
        }
        public bool UpdateUser(UserEntity user)
        {
            return _userRepository.UpdateUser(user);
        }
    }
}
