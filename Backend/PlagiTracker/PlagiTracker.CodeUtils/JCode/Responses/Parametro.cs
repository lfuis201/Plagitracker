namespace PlagiTracker.CodeUtils.JCode.Responses
{
    public class Parametro
    {
        public string ParametroNombre { get; set; }
        public string ParametroTipo { get; set; }

        public JCodeParameter ToEnglish()
        {
            return new JCodeParameter
            {
                Name = ParametroNombre,
                Type = ParametroTipo
            };
        }
    }

    public class JCodeParameter
    {
        public string? Name { get; set; }
        public string? Type { get; set; }
    }
}