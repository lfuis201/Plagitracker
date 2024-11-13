namespace PlagiTracker.CodeUtils.JCode.Responses
{
    public class Variable
    {
        public string VariableNombre { get; set; }
        public string VariableTipo { get; set; }

        public JCodeVariable ToEnglish()
        {
            return new JCodeVariable
            {
                Name = VariableNombre,
                Type = VariableTipo
            };
        }
    }

    public class JCodeVariable
    {
        public string? Name { get; set; }
        public string? Type { get; set; }
    }
}