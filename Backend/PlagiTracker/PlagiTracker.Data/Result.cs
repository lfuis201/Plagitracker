namespace PlagiTracker.Data
{
    public class Result
    {
        private bool dataIsCollection = false;

        public bool Success { get; set; }
        
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
                return _data;
            }
            set
            {
                if (value != null)
                {
                    _data = value;
                }
            }
        }
        
        private Type? DataType { get; set; }
        
        public Result(bool success)
        {
            Success = success;
        }

        public Result(bool success, string? message = null)
        {
            Success = success;
            Message = message;
        }
        public Result(bool success, string? message = null, object? data = null, Type? dataType = null)
        {
            Success = success;
            Message = message;
            Data = data;
            DataType = dataType;
        }

        public Result(bool success, string? message = null, object[]? data = null, Type? dataType = null)
        {
            Success = success;
            Message = message;

            if(data != null && data.Length > 0)
            {
                Data = data;
                dataIsCollection = true;
            }

            DataType = dataType;
        }
        /*
        public Result(bool success, string? message = null, (object data, Type dataType)[]? values = null)
        {
            Success = success;
            Message = message;
            Data = values;
        verificar que los count sean iguales
        }
        */

        public Result()
        {
        }
    }
}