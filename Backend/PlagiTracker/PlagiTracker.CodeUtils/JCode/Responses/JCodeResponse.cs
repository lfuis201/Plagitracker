// Ignore Spelling: Utils Clases

namespace PlagiTracker.CodeUtils.JCode.Responses
{
    public class JCodeResponse
    {
        public List<Clase>? Clases { get; set; }

        public List<JCodeClass>? Classes { get; set; }

        public void ToEnglish()
        {
            if (Clases == null)
            {
                return;
            }

            Classes = Clases.Select(clase => clase.ToEnglish()).ToList();
        }

        public void IgnoreVariables()
        {
            if (Classes == null)
            {
                return;
            }

            Classes.ForEach(clase => clase.Methods?.ForEach(method => method.Variables = null));
        }
    }
}