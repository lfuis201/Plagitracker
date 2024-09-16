namespace PlagiTracker.Data.Requests
{
    public class CourseRequest
    {
        public string? Name { get; set; }

        public Guid TeacherId { get; set; }
    }
}