// Ignore Spelling: Parametros Metodo Nombre Utils

namespace PlagiTracker.Data.Requests
{
    /// <remarks>
    /// No requiere BaseRequest
    /// </remarks>
    public class MethodRequest
    {
        public string? Name { get; set; }

        public string? Type { get; set; }

        public string? Description { get; set; }

        public List<ParameterRequest>? Parameters { get; set; }
        public List<VariableRequest>? Variables { get; set; }
    }
}