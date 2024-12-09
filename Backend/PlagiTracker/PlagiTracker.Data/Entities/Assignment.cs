// Ignore Spelling: Dolos

using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace PlagiTracker.Data.Entities
{
    /// <summary>
    /// Asignación de un curso, puede ser una tarea, un examen, etc.
    /// </summary>
    public class Assignment : BaseEntity
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public Guid Id { get; set; }

        [Required]
        [MinLength(10)]
        [MaxLength(50)]
        public string? Title { get; set; }

        [MaxLength(250)]
        public string? Description { get; set; }

        /// <summary>
        /// Fecha y hora límite de la entrega
        /// </summary>
        [Required]
        public DateTime SubmissionDate { get; set; }

        /// <summary>
        /// Fecha y hora de la realización del análisis de plagio
        /// </summary>
        public DateTime AnalysisDate { get; set; } = DateTime.MinValue;

        public bool IsAnalyzed { get; set; } = false;

        [MinLength(15)]
        [MaxLength(20)]
        public string? DolosURLId { get; set; }

        [Required]
        public Guid CourseId { get; set; }

        [ForeignKey(nameof(CourseId))]
        public virtual Course? Course { get; set; }
    }
}