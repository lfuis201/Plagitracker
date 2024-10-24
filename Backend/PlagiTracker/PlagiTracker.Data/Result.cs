namespace PlagiTracker.Data
{
    public class Result
    {
        public bool Success { get; set; }
        public object? Data { get; set; } = null;
        public string? Message { get; set; }

        public Result(bool success, object data, string? message = null)
        {
            Success = success;
            Data = data;
            Message = message;
        }

        public Result(bool success, string? message = null)
        {
            Success = success;
            Data = null;
            Message = message;
        }

        public Result()
        {
        }
    }
}