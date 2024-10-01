using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace PlagiTracker.Data.Entities
{
    /// <summary>
    /// Caso de plagio detectado
    /// </summary>
    public class Plagiarism
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public Guid Id { get; set; }

        /// <summary>
        /// Algoritmo de detección de plagio utilizado
        /// </summary>
        [Required]
        public PlagiarismDetector Detector { get; set; }

        /// <summary>
        /// Porcentaje de similitud entre los códigos, de 0 a 100
        /// </summary>
        [Required]
        [Range(100.00, 0.00)]
        public double Similarity { get; set; }

        public enum PlagiarismDetector
        {
            Jaccard,
            Levenshtein,
            Semantica
        }
    }
}