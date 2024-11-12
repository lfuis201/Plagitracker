using PlagiTracker.Data.Entities;

namespace PlagiTracker.Data.Responses
{
    public class AssignmentSubmissionResponse
    {
        public Assignment? Assignment { get; set; }
        public Submission? Submission { get; set; }
    }
}