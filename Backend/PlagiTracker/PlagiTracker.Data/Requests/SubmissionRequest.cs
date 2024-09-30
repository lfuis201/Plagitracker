﻿

namespace PlagiTracker.Data.Requests
{
    public class SubmissionRequest
    {
        public string? Url { get; set; }

        public Guid StudentId { get; set; }

        public Guid AssignmentId { get; set; }

        public DateTime SubmissionDate { get; set; }
    }
}