using System;
using System.Collections.Generic;
using System.Text;

namespace CAI.Entities
{
   public class UserEntity
    {
        public int Id { get; set; }
        public string UserName { get; set; }
        public string EmailId { get; set; }
        public string Password { get; set; }
        public string MobileNo { get; set; }
        public bool IsActivated { get; set; }
        public string Token { get; set; }
        public bool IsEmailVerified { get; set; }
        public DateTime EmailVerifiedDate { get; set; }
        public bool IsMobileNoVerified { get; set; }
        public DateTime MobileNoVerifiedDate { get; set; }
        public bool IsPanNoVerified { get; set; }
        public DateTime PanNoVerifiedDate { get; set; }
        public bool IsDeleted { get; set; }
    }
}
