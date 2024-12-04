namespace PlagiTracker.Data.Requests
{
    // No usa BaseRequest
    public class StudentRequest
    {
        public string? FirstName { get; set; }

        public string? LastName { get; set; }

        public string? Email { get; set; }

        public byte[]? PasswordHash { get; set; }
    }
}
