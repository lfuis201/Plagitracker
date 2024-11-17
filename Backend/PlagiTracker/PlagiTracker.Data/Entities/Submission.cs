using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace PlagiTracker.Data.Entities
{
    /// <summary>
    /// Entrega del estudiante, con la url de la entrega
    /// </summary>
    public class Submission : BaseEntity
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public Guid Id { get; set; }

        /// <summary>
        /// Url de la entrega
        /// </summary>
        [Required]
        [StringLength(60)]
        [MinLength(60)]
        [MaxLength(60)]
        public string? Url { get; set; }

        /// <summary>
        /// Fecha y hora de la entrega
        /// </summary>
        [Required]
        public DateTime SubmissionDate { get; set; }

        [Range(0, 20)]
        public double Grade { get; set; }

        public UrlState UrlState { get; set; }

        [Required]
        public Guid StudentId { get; set; }

        [Required]
        public Guid AssignmentId { get; set; }


        [ForeignKey(nameof(StudentId))]
        public virtual Student? Student { get; set; }

        [ForeignKey(nameof(AssignmentId))]
        public virtual Assignment? Assignment { get; set; }
    }

    public enum UrlState
    {
        NullOrEmpty = 0,
        Invalid = 1,
        NotCodiva = 2,
        Ok = 3,
    }
}