using System;

namespace CAI.Entities
{
    public class EmailAttachment
    {

        public EmailAttachment(byte[] fileContent, string filename, string contentType)
        {
            FileType = contentType;
            FileName = filename;
            Data = Convert.ToBase64String(fileContent);
        }

        /// <summary>
        /// Name of file to present to email recipient.
        /// </summary>
        public string FileName { get; set; }
        /// <summary>
        /// The type of file (eg pdf, jpg, zip).
        /// </summary>
        public string FileType { get; set; }
        /// <summary>
        /// Base64Encoded string containing the data of the attached file.
        /// </summary>
        public string Data { get; set; }
    }
}
