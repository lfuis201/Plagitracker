namespace PlagiTracker.Data.Requests
{
    /// <summary>
    /// </summary>
    public class CourseRequest
    {
        public string? Name { get; set; }

        public Guid TeacherId { get; set; }
    }
}