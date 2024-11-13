// Ignore Spelling: Metodos Nombre Clase Utils

namespace PlagiTracker.CodeUtils.JCode.Responses
{
    public class Clase
    {
        public string? ClaseNombre { get; set; }
        public List<Metodo>? Metodos { get; set; }

        public JCodeClass ToEnglish()
        {
            var jCodeClass = new JCodeClass
            {
                Name = ClaseNombre,
                Methods = Metodos?.Select(variable => variable.ToEnglish()).ToList(),
            };

            return jCodeClass;
        }
    }

    public class JCodeClass
    {
        public string? Name { get; set; }
        public List<JCodeMethod>? Methods { get; set; }
    }
}