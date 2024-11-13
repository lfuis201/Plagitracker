// Ignore Spelling: Parametros Metodo Nombre Utils

using PlagiTracker.Data.Requests;

namespace PlagiTracker.Data.CodeUtilsData.JCode
{
    public class Metodo
    {
        public string? MetodoNombre { get; set; }
        public List<Variable>? Variables { get; set; }
        public List<Parametro>? Parametros { get; set; }

        public MethodRequest ToEnglish()
        {
            var jCodeMethod = new MethodRequest
            {
                Name = MetodoNombre,
                Variables = Variables?.Select(variable => variable.ToEnglish()).ToList(),
                Parameters = Parametros?.Select(parametro => parametro.ToEnglish()).ToList(),
            };

            return jCodeMethod;
        }
    }
}