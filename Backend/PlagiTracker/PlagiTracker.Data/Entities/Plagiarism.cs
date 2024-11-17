using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace PlagiTracker.Data.Entities
{
    /// <summary>
    /// Caso de plagio detectado
    /// </summary>
    public class Plagiarism : BaseEntity
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public Guid Id { get; set; }

        /// <summary>
        /// Porcentaje de similitud entre los códigos, de 0 a 100
        /// </summary>
        [Range(100.00, 0.00)]
        public double Similarity { get; set; } = 0.00;

        /// <summary>
        /// Número de coincidencias encontradas, sólo para el algoritmo de COINCIDENCIAS
        /// </summary>
        public int Coincidences { get; set; } = 0;

        /// <summary>
        /// Código al que pertenece el fragmento
        /// </summary>
        public string? CodeSnippet { get; set; } = string.Empty;
        
        /// <summary>
        /// Id del código al que pertenece el análisis de plagio
        /// </summary>
        [Required]
        public Guid CodeId { get; set; }

        [ForeignKey(nameof(CodeId))]
        public virtual Code? Code { get; set; }

        /// <summary>
        /// Algoritmo de detección de plagio utilizado
        /// </summary>
        [Required]
        public AlgorithmType Algorithm { get; set; }

        public enum AlgorithmType
        {
            Jaccard = 0,
            Levenshtein = 1,
            Semantic = 2,
            Coincidences = 3,
        }
    }
}