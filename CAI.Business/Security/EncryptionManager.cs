using CAI.Business.Contracts.Security;
using CAI.Security;

namespace CAI.Business.Security
{
    public class EncryptionManager: IEncryptionManager
    {
        readonly string key;
        public EncryptionManager(string key)
        {
            this.key = key;
        }
        private EncryptionHelper fixture;
        // Encrypt Method - input parameter is string
        public string EncryptValue(string input)
        {
            if (string.IsNullOrEmpty(input))
            {
                return "";
            }
            fixture = new EncryptionHelper();
            var encryptedValue= fixture.Encrypt(input);
            return encryptedValue.CypherText + encryptedValue.IVText;
        }
        // Decrypt Method - input parameter is string
        //Decrypt first to last but 24 chars is the cyper and the rest of the part is the iv (last 24 chars) (that’s how is officially done).
        public string DecryptValue(string input)
        {
            if (string.IsNullOrEmpty(input))
            {
                return "";
            }
            if (input.Length < 24)
            {
                throw new System.Exception("Input needs to have at least 24 characters");
            }
           
            fixture = new EncryptionHelper();
            var encryptedValue = input;
            var encryptedCypherValue = encryptedValue.Substring(0, (encryptedValue.Length - 24));
            var encryptedIVValue = encryptedValue.Substring((encryptedValue.Length - 24), 24);
            return fixture.Decrypt(encryptedCypherValue, encryptedIVValue);
        }
    }
}
