using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace PlagiTracker.Data.Entities
{
    /// <summary>
    /// </summary>
    public class Exercise
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public Guid Id { get; set; }

        [Required]
        [MaxLength(50)]
        public string? Name { get; set; }

        [Required]
        public string? Description { get; set; } 
        
        /// <summary>
        /// </summary>
        [Required]
        public Guid AssignmentId { get; set; }

        [ForeignKey(nameof(AssignmentId))]
        public virtual Assignment? Assignment { get; set; }
    }
}