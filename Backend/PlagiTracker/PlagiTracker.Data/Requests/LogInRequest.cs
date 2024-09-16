namespace PlagiTracker.Data.Requests
{
    /// <summary>
    /// Puede ser una petición para el estudiante o el profesor
    /// </summary>
    public class LogInRequest
    {
        public string? Email { get; set; }

        public byte[]? PasswordHash { get; set; }
    }
}