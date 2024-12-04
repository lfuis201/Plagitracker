namespace PlagiTracker.Data.Requests
{
    /// <summary>
    /// Puede ser una petición del estudiante o del profesor
    /// </summary>
    /// <remarks>
    /// No requiere BaseRequest
    /// </remarks>
    public class SignUpRequest
    {
        public string? FirstName { get; set; }

        public string? LastName { get; set; }

        public string? Email { get; set; }

        public byte[]? PasswordHash { get; set; }
    }
}