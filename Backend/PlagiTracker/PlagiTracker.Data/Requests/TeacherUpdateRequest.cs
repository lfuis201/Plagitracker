namespace PlagiTracker.Data.Requests
{
    public class TeacherUpdateRequest : BaseRequest
    {
        public string? FirstName { get; set; }

        public string? LastName { get; set; }

        public string? Email { get; set; }
    }
}