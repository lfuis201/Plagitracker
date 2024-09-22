namespace PlagiTracker.Data.Requests
{
    public class EnrollmentRequest
    {
        public Guid StudentId { get; set; }

        public Guid CourseId { get; set; }
    }
}