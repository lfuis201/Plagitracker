// Ignore Spelling: Metodos Nombre Clase Utils

namespace PlagiTracker.Data.Requests
{
    /// <remarks>
    /// No requiere BaseRequest
    /// </remarks>
    public class ClassRequest
    {
        public string? Name { get; set; }

        public string? Description { get; set; }

        public List<ClassRequest>? ChildClasses { get; set; }

        public List<MethodRequest>? Methods { get; set; }
    }
}