namespace PlagiTracker.Data
{
    public class Result<T>
    {
        public bool Success { get; set; }

        public string? Message { get; set; }

        private T? _data;

        public T? Data
        {
            get => _data;
            set => _data = value;
        }

        public Result(bool success, string message, T data)
        {
            Success = success;
            Message = message;
            Data = data;
        }

        public Result()
        {
        }
    }

    public class Result
    {
        public bool Success { get; set; }

        public string? Message { get; set; }

        public Result(bool success)
        {
            Success = success;
        }

        public Result(bool success, string? message)
        {
            Success = success;
            Message = message;
        }

        public Result()
        {
        }
    }
}