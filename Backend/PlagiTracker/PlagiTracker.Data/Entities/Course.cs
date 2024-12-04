using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace PlagiTracker.Data.Entities
{
    public class Course : BaseEntity
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public Guid Id { get; set; }

        
        /// <summary>
        /// Id de invitación al curso, este puede cambiar, el profesor puede cambiarlo. Es único
        /// </summary>
        [Required]
        public Guid? InvitationId { get; set; }
        
        [Required]
        [MinLength(1)]
        [MaxLength(80)]
        public string? Name { get; set; }

        [Required]
        public bool IsArchived { get; set; } = false;

        [Required]
        public Guid TeacherId { get; set; }

        [ForeignKey(nameof(TeacherId))]
        public virtual Teacher? Teacher { get; set; }
    }
}