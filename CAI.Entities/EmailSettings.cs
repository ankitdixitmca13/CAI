using System;
using System.Collections.Generic;
using System.Text;

namespace CAI.Entities
{
    public class EmailSettings
    {
        public string FromEmail { get; set; }
        public string RegistrationURL { get; set; }
        public string MailServer { get; set; }
        public string MailServerPassword { get; set; }
        public int Port { get; set; }
        public string EmailTemplateURL { get; set; }
    }
}
