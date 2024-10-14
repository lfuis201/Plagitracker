namespace PlagiTracker.Data.Requests
{
    /// <summary>
    /// Petición para cambiar de contraseña
    /// </summary>
    public class ResetPasswordRequest
    {
        public string? Email { get; set; }

        public byte[]? NewPasswordHash { get; set; }

        public int VerificationCode { get; set; }
    }
}