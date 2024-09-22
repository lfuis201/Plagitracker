using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace PlagiTracker.Data.Entities
{
    public class PlagiarismCode
    {
        [Required]
        public Guid PlagiarismId { get; set; }

        [Required]
        public Guid CodeId { get; set; }

        /// <summary>
        /// Código al que pertenece el fragmento
        /// </summary>
        public string? CodeSnippet { get; set; }

        [ForeignKey(nameof(PlagiarismId))]
        public virtual Plagiarism? Plagiarism { get; set; }

        [ForeignKey(nameof(CodeId))]
        public virtual Code? Code { get; set; }
    }
}