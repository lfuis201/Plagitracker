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
        [MinLength(35)]
        [MaxLength(60)]
        public string? Url { get; set; }

        /// <summary>
        /// Fecha y hora de la entrega
        /// </summary>
        [Required]
        public DateTime SubmissionDate { get; set; }

        [Range(0, 20)]
        public double Grade { get; set; } = 0;

        [Required]
        public UrlCompilerType Compiler { get; set; }

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

    /// <summary>
    /// Estado de la URL
    /// </summary>
    public enum UrlState
    {
        NullOrEmpty = 0,
        NotExists = 1,
        Invalid = 2,
        Ok = 3,
    }

    /// <summary>
    /// Tipo de compilador de URL
    /// </summary>
    public enum UrlCompilerType
    {
        Codiva = 0,
        OnlineGDB = 1,
        Replit = 2
    }
}