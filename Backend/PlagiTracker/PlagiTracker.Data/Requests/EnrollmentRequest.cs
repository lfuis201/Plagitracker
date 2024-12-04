namespace PlagiTracker.Data.Requests
{
    public class EnrollmentRequest : BaseRequest
    {
        public Guid StudentId { get; set; }

        public Guid CourseId { get; set; }
    }
}