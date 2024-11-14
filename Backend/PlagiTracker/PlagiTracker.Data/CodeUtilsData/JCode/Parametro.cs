// Ignore Spelling: Parametro Nombre Tipo Utils

using PlagiTracker.Data.Requests;

namespace PlagiTracker.Data.CodeUtilsData.JCode
{
    public class Parametro
    {
        public string? ParametroNombre { get; set; }
        public string? ParametroTipo { get; set; }

        public ParameterRequest ToEnglish()
        {
            return new ParameterRequest
            {
                Name = ParametroNombre,
                Type = ParametroTipo
            };
        }
    }
}