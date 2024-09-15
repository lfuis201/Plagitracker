using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace PlagiTracker.Data.Entities
{
    /// <summary>
    /// Inscripción de un estudiante a un curso
    /// </summary>
    public class Enrollment
    {
        [Required]
        public Guid StudentId { get; set; }

        [Required]
        public Guid CourseId { get; set; }
    }
}