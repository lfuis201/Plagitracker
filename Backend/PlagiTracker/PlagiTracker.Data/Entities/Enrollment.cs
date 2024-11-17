using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace PlagiTracker.Data.Entities
{
    /// <summary>
    /// Inscripción de un estudiante a un curso
    /// </summary>
    public class Enrollment : BaseEntity
    {
        [Required]
        public Guid StudentId { get; set; }

        [Required]
        public Guid CourseId { get; set; }

        [Range(0, 20)]
        public double Grade { get; set; } = 0;

        [ForeignKey(nameof(StudentId))]
        public virtual Student? Student { get; set; }

        [ForeignKey(nameof(CourseId))]
        public virtual Course? Course { get; set; }
    }
}