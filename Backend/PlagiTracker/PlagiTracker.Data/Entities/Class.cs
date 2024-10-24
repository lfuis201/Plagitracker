using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace PlagiTracker.Data.Entities
{
    /// <summary>
    /// </summary>
    public class Class
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public Guid Id { get; set; }

        [Required]
        [MaxLength(40)]
        public string? Name { get; set; }

        public string? Description { get; set; } 

        /// <summary>
        /// </summary>
        [Required]
        public Guid ExerciseId { get; set; }

        [ForeignKey(nameof(ExerciseId))]
        public virtual Exercise? Exercise { get; set; }

        /// <summary>
        /// </summary>
        public Guid ParentClassId { get; set; }

        [ForeignKey(nameof(ParentClassId))]
        public virtual Class? ParentClass { get; set; }
    }
}