using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace PlagiTracker.Data.Entities
{
    /// <summary>
    /// </summary>
    public class Function : BaseEntity
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public Guid Id { get; set; }

        [Required]
        [MaxLength(40)]
        public string? Name { get; set; }

        [Required]
        public int Parameters { get; set; }

        /// <summary>
        /// Tipo de la función
        /// </summary>
        [Required]
        public string? Type { get; set; }

        public string? Description { get; set; }

        /// <summary>
        /// </summary>
        [Required]
        public Guid ClassId { get; set; }

        [ForeignKey(nameof(ClassId))]
        public virtual Class? Class { get; set; }
    }
}