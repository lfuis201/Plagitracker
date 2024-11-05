using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace PlagiTracker.Data.Entities
{
    public class Parameter
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public Guid Id { get; set; }

        [Required]
        [MaxLength(40)]
        public string? Name { get; set; }

        /// <summary>
        /// Tipo del parámetro
        /// </summary>
        [Required]
        public string? Type { get; set; }

        public string? Description { get; set; }

        /// <summary>
        /// </summary>
        [Required]
        public Guid FunctionId { get; set; }

        [ForeignKey(nameof(FunctionId))]
        public virtual Function? Function { get; set; }
    }
}