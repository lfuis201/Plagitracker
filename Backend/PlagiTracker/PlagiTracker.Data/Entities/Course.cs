using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace PlagiTracker.Data.Entities
{
    public class Course
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public Guid Id { get; set; }

        [Required]
        [MinLength(1)]
        [MaxLength(80)]
        public string? Name { get; set; }

        [Required]
        public Guid TeacherId { get; set; }
    }
}