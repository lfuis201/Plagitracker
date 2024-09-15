using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace PlagiTracker.Data.Entities
{
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

        [Required]
        public Guid StudentId { get; set; }
        [Required]
        public Guid AssignmentId { get; set; }
    }
}