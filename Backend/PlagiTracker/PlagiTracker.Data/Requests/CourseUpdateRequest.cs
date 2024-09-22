namespace PlagiTracker.Data.Requests
{
    public class CourseUpdateRequest
    {
        public Guid Id { get; set; }

        public string? Name { get; set; }
    }
}