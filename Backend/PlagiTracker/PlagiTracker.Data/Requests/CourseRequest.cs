namespace PlagiTracker.Data.Requests
{
    /// <summary>
    /// - Name
    /// - TeacherId
    /// </summary>
    public class CourseRequest
    {
        public string? Name { get; set; }

        public Guid TeacherId { get; set; }
    }
}