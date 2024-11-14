namespace PlagiTracker.Data.Requests
{
    /// <remarks>
    /// No requiere BaseRequest
    /// </remarks>
    public class CourseUpdateRequest : CourseRequest
    {
        /// <summary>
        /// Id del curso.
        /// </summary>
        public Guid Id { get; set; }
    }
}