using System.Threading.Tasks;

namespace CAI.Business.Contracts
{
    public interface IConfirmRegistrationEmailService
    {
        Task<bool> SendRegistrationEmailAsync(int userId, string userName, string name, string registrationKey);
    }
}
