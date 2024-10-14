using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace PlagiTracker.Data.Entities
{
    public class User
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public Guid Id { get; set; }

        [Required]
        [MinLength(1)]
        [MaxLength(40)]
        public string? FirstName { get; set; }

        [Required]
        [MinLength(1)]
        [MaxLength(40)]
        public string? LastName { get; set; }

        [Required]
        [MinLength(5)]
        [MaxLength(35)]
        public string? Email { get; set; }

        [Required]
        public byte[]? PasswordHash { get; set; }

        [Required]
        public int LogInAttempts { get; set; } = 0;

        [Required]
        public bool IsLocked { get; set; } = false;

        [Required]
        public DateTime UnlockDate { get; set; }

        [Range(10000000, 99999999)]
        public int VerificationCode { get; set; } = 0;

        public bool IsVerified { get; set; } = false;

        public DateTime VerificationCodeExpiration { get; set; } = DateTime.MinValue;
    }
}
