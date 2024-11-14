// Ignore Spelling: Utils Clases

using PlagiTracker.Data.Requests;

namespace PlagiTracker.Data.CodeUtilsData.JCode
{
    public class JCodeResponse
    {
        public List<Clase>? Clases { get; set; }

        public List<ClassRequest>? Classes { get; set; }

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