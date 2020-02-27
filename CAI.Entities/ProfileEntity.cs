using System;
using System.Collections.Generic;
using System.Text;

namespace CAI.Entities
{
    public class ProfileEntity
    {
        public int Id { get; set; }
        public int? UserId { get; set; }
        public string FirstName { get; set; }
        public string MiddleName { get; set; }
        public string LastName { get; set; }
        public string CountryCode { get; set; }
        public string PhoneNo { get; set; }
        public string AltPhoneNo { get; set; }
        public string PANNo { get; set; }
        public string UID { get; set; }
        public string IsResident { get; set; }
        public DateTime? TimeStamp { get; set; }

    }
}
