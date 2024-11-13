namespace PlagiTracker.Data.Requests
{
    /// <remarks>
    /// No requiere BaseRequest
    /// </remarks>
    public class ExerciseRequest
    {
        public string? Name { get; set; }

        public string? Description { get; set; }

        public bool HaveBody { get; set; } = false;

        public List<ClassRequest>? Classes { get; set; }
    }
}