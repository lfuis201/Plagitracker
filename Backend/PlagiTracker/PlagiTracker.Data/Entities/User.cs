using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace PlagiTracker.Data.Entities
{
    /// <summary>
    /// Clase para el usuario (profesor y estudiante)
    /// </summary>
    public class User : BaseEntity
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public Guid Id { get; set; }

        [Required]
        [MinLength(1)]
        [MaxLength(50)]
        public string? FirstName { get; set; }

        [Required]
        [MinLength(1)]
        [MaxLength(50)]
        public string? LastName { get; set; }

        [Required]
        [MinLength(5)]
        [MaxLength(50)]
        public string? Email { get; set; }

        [Required]
        public byte[]? PasswordHash { get; set; }

        /// <summary>
        /// Número de intentos de inicio de sesión
        /// </summary>
        [Required]
        public int LogInAttempts { get; set; } = 0;

        /// <summary>
        /// Booleano para saber si el usuario está bloqueado
        /// </summary>
        /// <value>value="True": Usuario bloqueado</value>
        [Required]
        public bool IsLocked { get; set; } = false;

        /// <summary>
        /// Fecha de desbloqueo
        /// </summary>
        [Required]
        public DateTime UnlockDate { get; set; }

        /// <summary>
        /// Código de verificación
        /// </summary>
        /// <remarks>Valor por Default = 10000000</remarks>
        [Range(10000000, 99999999)]
        public int VerificationCode { get; set; } = 10000000;

        /// <summary>
        /// </summary>
        public bool IsVerified { get; set; } = false;

        /// <summary>
        /// Fecha de expiración del código de verificación
        /// </summary>
        public DateTime VerificationCodeExpiration { get; set; } = DateTime.MinValue;

        /// <summary>
        /// Número de intentos de reseteo de contraseña
        /// </summary>
        [Required]
        public int ResetPasswordAttempts { get; set; } = 0;
    }
}