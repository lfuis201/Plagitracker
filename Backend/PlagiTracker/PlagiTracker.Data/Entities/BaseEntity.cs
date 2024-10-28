using System.ComponentModel.DataAnnotations;

namespace PlagiTracker.Data.Entities
{
    public abstract class BaseEntity
    {
        [Required]
        public bool IsEnabled { get; set; } = true;

        [Required]
        public DateTime CreatedAt { get; set; } = DateTime.Now.ToUniversalTime();

        public DateTime UpdatedAt { get; set; }
    }
}