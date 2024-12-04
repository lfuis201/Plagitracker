namespace PlagiTracker.Data.Requests
{
    /// <summary>
    /// Puede ser una petición del estudiante o del profesor
    /// </summary>
    /// <remarks>
    /// No requiere BaseRequest
    /// </remarks>
    public class LogInRequest
    {
        public string? Email { get; set; }

        public byte[]? PasswordHash { get; set; }
    }
}