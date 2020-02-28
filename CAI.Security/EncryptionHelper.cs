using System;
using System.IO;
using System.Security.Cryptography;

namespace CAI.Security
{
    public class EncryptionHelper
    {
        byte[] key;
        public EncryptionHelper()
        {
            key = System.Convert.FromBase64String("ayz9z/tkT8p5tK8FAq0N5RyiW9geL1B1gD13pjtSUhs=");
        }

        public EncryptionHelper(byte[] keyValue)
        {
            key = keyValue;
        }
        public EncryptionResult Encrypt(string input)
        {
            EncryptionResult result = new EncryptionResult();
            //return input;
            EncryptStringToBytes(input, key, result);
            return result;
        }

        void EncryptStringToBytes(string plainText, byte[] Key, EncryptionResult result)
        {
            // Check arguments.
            if (plainText == null || plainText.Length <= 0)
                throw new ArgumentNullException("plainText");
            if (Key == null || Key.Length <= 0)
                throw new ArgumentNullException("Key");
                     
            // Create an Rijndael object
            // with the specified key and IV.
            using (Rijndael rijAlg = Rijndael.Create())
            {
                //rijAlg.Padding = PaddingMode.PKCS7;
                rijAlg.Key = Key;
                //rijAlg.IV = IV;
                result.IV = rijAlg.IV;
                // Create a decrytor to perform the stream transform.
                ICryptoTransform encryptor = rijAlg.CreateEncryptor(rijAlg.Key, rijAlg.IV);

                // Create the streams used for encryption.
                using (MemoryStream msEncrypt = new MemoryStream())
                {
                    using (CryptoStream csEncrypt = new CryptoStream(msEncrypt, encryptor, CryptoStreamMode.Write))
                    {
                        using (StreamWriter swEncrypt = new StreamWriter(csEncrypt))
                        {

                            //Write all data to the stream.
                            swEncrypt.Write(plainText);
                        }
                        result.Cypher = msEncrypt.ToArray();
                    }
                }
            }

        }
        public string Decrypt(string input, string iv)
        {
            byte[] ivArray = System.Convert.FromBase64String(iv);
            return Decrypt(input, ivArray);
        }

        public string Decrypt(string input, byte[] iv)
        {
            string result = string.Empty;
            // return input;
            byte[] encrypted = System.Convert.FromBase64String(input);
            //// Decrypt the bytes to a string.
            result = DecryptStringFromBytes(encrypted, key, iv);
            return result;
        }
        string DecryptStringFromBytes(byte[] cipherText, byte[] Key, byte[] iv)
        {
            // Check arguments.
            if (cipherText == null || cipherText.Length <= 0)
                throw new ArgumentNullException("cipherText");
            if (Key == null || Key.Length <= 0)
                throw new ArgumentNullException("Key");
           
            string plaintext = null;

            // Create an Rijndael object
            // with the specified key and IV.
            using (Rijndael rijAlg = Rijndael.Create())
            {
                //rijAlg.Padding = PaddingMode.PKCS7;
                rijAlg.Key = Key;
                rijAlg.IV = iv;

                // Create a decrytor to perform the stream transform.
                ICryptoTransform decryptor = rijAlg.CreateDecryptor(rijAlg.Key, rijAlg.IV);
                // Create the streams used for decryption.
                using (MemoryStream msDecrypt = new MemoryStream(cipherText))
                {
                    using (CryptoStream csDecrypt = new CryptoStream(msDecrypt, decryptor, CryptoStreamMode.Read))
                    {
                        using (StreamReader srDecrypt = new StreamReader(csDecrypt))
                        {

                            // Read the decrypted bytes from the decrypting stream
                            // and place them in a string.
                            plaintext = srDecrypt.ReadToEnd();
                        }
                    }
                }

            }
            return plaintext;
        }
    }
    public class EncryptionResult
    {
        public byte[] Cypher { get; set; }
        public byte[] IV { get; set; }

        public string CypherText
        {
            get
            {
                return Convert.ToBase64String(Cypher);
            }
        }
        public string IVText
        {
            get
            {
                return Convert.ToBase64String(IV);
            }
        }

    }
}