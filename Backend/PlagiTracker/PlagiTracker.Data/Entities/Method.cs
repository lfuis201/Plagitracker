using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace PlagiTracker.Data.Entities
{
    /// <summary>
    /// </summary>
    public class Method : BaseEntity
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public Guid Id { get; set; }

        [Required]
        [MaxLength(40)]
        public string? Name { get; set; }

        /// <summary>
        /// Tipo del método.
        /// </summary>
        [Required]
        public string? Type { get; set; } = "undefined";

        /// <summary>
        /// Tipos de los parámetros. Se concatenan los tipos de los parámetros separados por coma.
        /// Ejemplo 1: String,int
        /// Ejemplo 2: int,String
        /// </summary>
        [Required]
        public string? ParameterTypes { get; set; }

        public string? Description { get; set; }

        /// <summary>
        /// </summary>
        [Required]
        public Guid ClassId { get; set; }

        [ForeignKey(nameof(ClassId))]
        public virtual Class? Class { get; set; }
    }
}