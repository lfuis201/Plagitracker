namespace PlagiTracker.Data
{
    public class Result
    {
        public bool? Success { get; set; }
        
        public string? Message { get; set; }
        
        private object? _data;
        
        public object? Data 
        {
            get
            {
                if (_data != null && DataType != null)
                {
                    return Convert.ChangeType(_data, DataType);
                }
                return null;
            }
            set
            {
                if (value != null)
                {
                    _data = value;
                }
            }
        }
        
        public Type? DataType { get; set; }

        public Result(bool success, string? message, object? data = null, Type? dataType = null)
        {
            Success = success;
            Message = message;
            Data = data;
            DataType = dataType;
        }

        public Result()
        {
        }
    }
}