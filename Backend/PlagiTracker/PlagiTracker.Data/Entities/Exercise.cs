using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace PlagiTracker.Data.Entities
{
    /// <summary>
    /// </summary>
    public class Exercise : BaseEntity
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public Guid Id { get; set; }

        [Required]
        [MinLength(10)]
        [MaxLength(50)]
        public string? Name { get; set; }

        [Required]
        public string? Description { get; set; }

        /// <summary>
        /// Propiedad para saber si el ejercicio tiene cuerpo (estructura)
        /// </summary>
        [Required]
        public bool HaveBody { get; set; } = false;

        /// <summary>
        /// </summary>
        [Required]
        public Guid AssignmentId { get; set; }

        [ForeignKey(nameof(AssignmentId))]
        public virtual Assignment? Assignment { get; set; }
    }
}