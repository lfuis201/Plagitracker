namespace PlagiTracker.Data.Requests
{
    /// <summary>
    /// Perición para crear un curso.
    /// </summary>
    public class CourseRequest : BaseRequest
    {
        public string? Name { get; set; }

        public Guid TeacherId { get; set; }
    }
}