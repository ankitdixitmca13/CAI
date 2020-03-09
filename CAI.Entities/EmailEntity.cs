using System.ComponentModel.DataAnnotations;

namespace CAI.Entities
{
    public class EmailEntity
    {
        [Required]
        public string EmailKey { get; set; }
    }
}
