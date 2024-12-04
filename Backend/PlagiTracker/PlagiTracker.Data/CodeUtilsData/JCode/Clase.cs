// Ignore Spelling: Metodos Nombre Clase Utils

using PlagiTracker.Data.Requests;

namespace PlagiTracker.Data.CodeUtilsData.JCode
{
    public class Clase
    {
        public string? ClaseNombre { get; set; }
        public List<Metodo>? Metodos { get; set; }

        public ClassRequest ToEnglish()
        {
            var jCodeClass = new ClassRequest
            {
                Name = ClaseNombre,
                Methods = Metodos?.Select(variable => variable.ToEnglish()).ToList(),
            };

            return jCodeClass;
        }
    }
}