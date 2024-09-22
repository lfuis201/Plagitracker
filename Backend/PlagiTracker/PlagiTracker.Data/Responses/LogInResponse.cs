namespace PlagiTracker.Data.Responses
{
    /// <summary>
    /// Puede ser la respuesta para el estudiante o el profesor
    /// </summary>
    public class LogInResponse
    {
        /// <summary>
        /// Puede ser el Id del estudiante o del profesor
        /// </summary>
        public Guid Id { get; set; }

        public string? FirstName { get; set; }

        public string? LastName { get; set; }

        public string? Email { get; set; }
    }
}