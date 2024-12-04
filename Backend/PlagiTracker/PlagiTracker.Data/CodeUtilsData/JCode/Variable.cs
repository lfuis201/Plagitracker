// Ignore Spelling: Utils Nombre Tipo

using PlagiTracker.Data.Requests;

namespace PlagiTracker.Data.CodeUtilsData.JCode
{
    public class Variable
    {
        public string? VariableNombre { get; set; }
        public string? VariableTipo { get; set; }

        public VariableRequest ToEnglish()
        {
            return new VariableRequest
            {
                Name = VariableNombre,
                Type = VariableTipo
            };
        }
    }
}