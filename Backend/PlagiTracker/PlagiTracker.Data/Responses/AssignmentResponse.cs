// Ignore Spelling: Dolos

namespace PlagiTracker.Data.Responses
{
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

        public string? DolosURLId { get; set; }

        public DateTime CreatedAt { get; set; }

        public DateTime UpdatedAt { get; set; }

        public Guid CourseId { get; set; }
    }
}