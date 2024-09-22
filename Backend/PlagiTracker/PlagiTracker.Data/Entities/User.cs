using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

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
    }
}
