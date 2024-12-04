namespace PlagiTracker.Data.Requests
{
    public class AssignmentUpdateRequest : BaseRequest
    {
        public Guid Id { get; set; }
        public string? Description { get; set; }

        public string? Title { get; set; }

        public DateTime SubmissionDate { get; set; } 

    }
}