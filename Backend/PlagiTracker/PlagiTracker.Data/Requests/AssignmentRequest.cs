﻿namespace PlagiTracker.Data.Requests
{
    public class AssignmentRequest
    {
        public string? Description { get; set; }

        public string? Title { get; set; }

        public Guid CourseId { get; set; }

        public DateTime SubmissionDate { get; set; }

        public List<ExerciseRequest>? Exercises { get; set; }
    }
}