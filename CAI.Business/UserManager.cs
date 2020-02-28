using CAI.Business.Contracts.Security;
using CAI.Business.Interfaces;
using CAI.Entities;
using CAI.Repository.Interfaces;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using WebApi.Helpers;

namespace CAI.Business
{
    public  class UserManager: IUserManager
    {
        IUserRepository _userRepository;
        private readonly AppSettings _appSettings;
        IEncryptionManager encryptionManager;
        //public UserManager(IUserRepository userRepository, IOptions<AppSettings> appSettings, IEncryptionManager _encryptionManager)
        public UserManager(IUserRepository userRepository, IOptions<AppSettings> appSettings)
        {
            _userRepository = userRepository;
            _appSettings = appSettings.Value;
            //encryptionManager = _encryptionManager;
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
            //encrypt the password before send to db
            //user.Password = encryptionManager.EncryptValue(user.Password);
            return _userRepository.UpdateUser(user);
        }
        public UserEntity AuthenticateUser(string username, string password)
        {
            var _users = _userRepository.GetAllUser();
            //string decryptPassword = encryptionManager.DecryptValue(password);
            //var user = _users.SingleOrDefault(x => (x.EmailId==username || x.MobileNo==username) && (x.Password == decryptPassword));

            var user = _users.SingleOrDefault(x => (x.EmailId == username || x.MobileNo == username) && (x.Password == password));

            // return null if user not found
            if (user == null)
                return null;

            // authentication successful so generate jwt token
            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes(_appSettings.Secret);
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new Claim[]
                {
                    new Claim(ClaimTypes.Name, user.Id.ToString())
                }),
                Expires = DateTime.UtcNow.AddDays(7),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
            };
            var token = tokenHandler.CreateToken(tokenDescriptor);
            user.Token = tokenHandler.WriteToken(token);

            return user.WithoutPassword();
        }
    }
}
