using System;
using System.Collections.Generic;
using System.Text;

namespace CAI.Entities
{
    public class BankAccountEntity
    {
        public int Id { get; set; }
        public int? UserId { get; set; }
        public string BankName { get; set; }
        public string IFSC { get; set; }
        public string AccountNumber { get; set; }
        public string AccountTyepe { get; set; }
        public string IsPrimary { get; set; }
        public DateTime? TimeStamp { get; set; }

    }
}
