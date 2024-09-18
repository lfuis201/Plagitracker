using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace PlagiTracker.Data.Entities
{
    /// <summary>
    /// Entrega del estudiante, con la url de la entrega
    /// </summary>
    public  class Submission
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public Guid Id { get; set; }

        /// <summary>
        /// Url de la entrega
        /// </summary>
        [Required]
        public string? Url { get; set; }

        /// <summary>
        /// Fecha y hora de la entrega
        /// </summary>
        [Required]
        public DateTime SubmissionDate { get; set; }

        [Required]
        public Guid StudentId { get; set; }

        [Required]
        public Guid AssignmentId { get; set; }
    }
}