using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace PlagiTracker.Data.Entities
{
    /// <summary>
    /// Archivo de código
    /// </summary>
    public class Code
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public Guid Id { get; set; }

        /// <summary>
        /// Id de la entrega a la que pertenece el código
        /// </summary>
        [Required]
        public Guid SubmissionId { get; set; }

        [Required]
        [MaxLength(50)]
        public string? FileName { get; set; }

        /// <summary>
        /// Contenido del archivo (código)
        /// </summary>
        [Required]
        public string? Content { get; set; }

        [ForeignKey(nameof(SubmissionId))]
        public virtual Submission? Submission { get; set; }
    }
}
