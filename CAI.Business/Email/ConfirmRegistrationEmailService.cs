using CAI.Business.Contracts;
using CAI.Entities;
using Microsoft.Extensions.Options;
using System;
using System.Collections.Generic;
using System.Net.Mail;
using System.Threading.Tasks;

namespace CAI.Business.Email
{
    public class ConfirmRegistrationEmailService : IConfirmRegistrationEmailService
    {
        private readonly EmailSettings _emailSettings;
        public ConfirmRegistrationEmailService(IOptions<EmailSettings> emailSettings)
        {
            _emailSettings = emailSettings.Value;
        }
        public async Task<bool> SendRegistrationEmailAsync(int userId, string userName, string name, string registrationKey)
        {
            bool result = true;
            try
            {
                if (string.IsNullOrEmpty(registrationKey))
                {
                    registrationKey = Guid.NewGuid().ToString();
                }
                var emailTemplate = _emailSettings.EmailTemplateURL;
                // we have read the template 
                // wwe also generate confirm url
                emailTemplate = "for testing purpose";
                emailTemplate = emailTemplate.Replace("{confirmRegistrationUrl}", string.Format(_emailSettings.RegistrationURL, registrationKey));
                await SendMailAsync(new List<string>() { userName }, _emailSettings.FromEmail, "Verify your email address", emailTemplate, null);
            }
            catch (Exception x)
            {
                //TODO log the exception here.
                //if (loggingHelper != null)
                //{
                //    loggingHelper.LogError(x, x.Message);
                //}
                result = false;
            }
            return result;
        }
        public async Task<bool> SendMailAsync(IEnumerable<string> to, string from, string subject, string messageText, List<EmailAttachment> attachments = null)
        {
            var finalResult = true;
            foreach (var item in to)
            {
                //TODO : Add email functionality
                MailMessage mail = new MailMessage();
                SmtpClient SmtpServer = new SmtpClient(_emailSettings.MailServer);

                mail.From = new MailAddress(from);
                mail.To.Add(item.Split(';')[0]);
                mail.Subject = subject;
                mail.Body = messageText;

                SmtpServer.Port = 587;
                SmtpServer.Credentials = new System.Net.NetworkCredential(_emailSettings.FromEmail,_emailSettings.MailServerPassword);
                SmtpServer.EnableSsl = true;
                SmtpServer.Send(mail);
            }
            return finalResult;
        }
    }
}
