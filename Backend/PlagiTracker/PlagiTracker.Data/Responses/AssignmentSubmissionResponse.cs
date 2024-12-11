namespace PlagiTracker.Data.Responses
{
    public class AssignmentSubmissionResponse
    {
        public AssignmentResponse? Assignment { get; set; }
        public SubmissionResponse? Submission { get; set; }

        public class AssignmentResponse
        {
            public Guid Id { get; set; }

            public string? Title { get; set; }

            public string? Description { get; set; }

            /// <summary>
            /// Fecha y hora límite de la entrega
            /// </summary>
            public DateTime SubmissionDate { get; set; }

            /// <summary>
            /// Fecha y hora de la realización del análisis de plagio
            /// </summary>
            public DateTime AnalysisDate { get; set; } = DateTime.MinValue;

            public bool IsAnalyzed { get; set; } = false;

            public DateTime CreatedAt { get; set; }

            public DateTime UpdatedAt { get; set; }

            public Guid CourseId { get; set; }
        }

        public class SubmissionResponse
        {
            public Guid Id { get; set; }

            /// <summary>
            /// Url de la entrega
            /// </summary>
            public string? Url { get; set; }

            /// <summary>
            /// Fecha y hora de la entrega
            /// </summary>
            public DateTime SubmissionDate { get; set; }

            public double Grade { get; set; } = 0;

            public DateTime UpdatedAt { get; set; }

            public Guid AssignmentId { get; set; }
        }
    }
}