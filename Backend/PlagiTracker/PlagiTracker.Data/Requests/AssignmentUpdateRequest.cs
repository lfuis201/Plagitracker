namespace PlagiTracker.Data.Requests
{
    public class AssignmentUpdateRequest
    {
        public Guid Id { get; set; }
        public string? Description { get; set; }

        public string? Title { get; set; }
    }
}