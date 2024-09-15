using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace PlagiTracker.Data.Entities
{
    /// <summary>
    /// Asignación de un curso, puede ser una tarea, un examen, etc.
    /// </summary>
    public class Assignment
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public Guid Id { get; set; }

        [MaxLength(250)]
        public string? Description { get; set; }

        [Required]
        [MinLength(10)]
        [MaxLength(50)]
        public string? Title { get; set; }

        /// <summary>
        /// Fecha y hora límite de la entrega
        /// </summary>
        [Required]
        public DateTime? SubmissionDate { get; set; }

        [Required]
        public Guid CourseId { get; set; }
    }
}