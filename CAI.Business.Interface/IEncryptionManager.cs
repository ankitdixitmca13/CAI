namespace CAI.Business.Contracts.Security
{
    public interface IEncryptionManager
    {
        string EncryptValue(string inputValue);
        string DecryptValue(string inputValue);
    }
}
