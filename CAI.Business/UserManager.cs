﻿using CAI.Business.Contracts;
using CAI.Business.Contracts.Security;
using CAI.Entities;
using CAI.Repository.Contracts;
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
    public class UserManager : IUserManager
    {
        IUserRepository _userRepository;
        private readonly AppSettings _appSettings;
        IEncryptionManager _encryptionManager;
        IConfirmRegistrationEmailService _confirmRegistrationEmailService;
        public const string alphabets = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        public const string small_alphabets = "abcdefghijklmnopqrstuvwxyz";
        public const string numbers = "1234567890";
        public UserManager(IUserRepository userRepository, IOptions<AppSettings> appSettings, IEncryptionManager encryptionManager, IConfirmRegistrationEmailService confirmRegistrationEmailService)
        {
            _userRepository = userRepository;
            _appSettings = appSettings.Value;
            _encryptionManager = encryptionManager;
            _confirmRegistrationEmailService = confirmRegistrationEmailService;
        }
        public bool AddUser(UserEntity user)
        {
            var result = new bool();
            
            //validate user already exits
            var _users = _userRepository.GetAllUser();
            var _user = _users.SingleOrDefault(x => (x.EmailId == user.EmailId));
            if (object.ReferenceEquals(_user, null))
            {
                user.Password = _encryptionManager.EncryptValue(user.Password);
                result = _userRepository.AddUser(user);
                //TODO : Send registratation email 
                if (result)
                    _confirmRegistrationEmailService.SendRegistrationEmailAsync(0, user.EmailId, "", "");
                return result;
            }
            else
            {
                return false;
            }
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
            var user = _users.SingleOrDefault(x => (x.EmailId == username || x.MobileNo == username) && (_encryptionManager.DecryptValue(x.Password) == password));

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
        public bool ConfirmEmail(EmailEntity emailModel)
        {
            return _userRepository.ConfirmEmail(emailModel);
        }
        public bool ConfirmPhoneNo(PhoneNoEntity phoneNoEntity)
        {
            return _userRepository.ConfirmPhoneNo(phoneNoEntity);
        }
        public bool UpdatePanNo(PanNoEntity panNoEntity)
        {
            panNoEntity.PanNo = _encryptionManager.EncryptValue(panNoEntity.PanNo);
            return _userRepository.UpdatePanNo(panNoEntity);
        }
        public bool ValidateOtp(PhoneNoEntity phoneNoEntity)
        {
            return _userRepository.ValidateOtp(phoneNoEntity);
        }
        public bool GenerateOtp(int userId, string phoneNo)
        {
            string characters = numbers;
            string otp = string.Empty;
            for (int i = 0; i < 6; i++)
            {
                string character = string.Empty;
                do
                {
                    int index = new Random().Next(0, characters.Length);
                    character = characters.ToCharArray()[index].ToString();
                } while (otp.IndexOf(character) != -1);
                otp += character;
            }
            //store otp 
           return _userRepository.SaveOtp(userId, otp);
        }
    }
}
