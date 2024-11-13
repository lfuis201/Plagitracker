// Ignore Spelling: Parametros Metodo Nombre

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PlagiTracker.CodeUtils.JCode.Responses
{
    public class Metodo
    {
        public string? MetodoNombre { get; set; }
        public List<Variable>? Variables { get; set; }
        public List<Parametro>? Parametros { get; set; }

        public JCodeMethod ToEnglish()
        {
            var jCodeMethod = new JCodeMethod
            {
                Name = MetodoNombre,
                Variables = Variables?.Select(variable => variable.ToEnglish()).ToList(),
                Parameters = Parametros?.Select(parametro => parametro.ToEnglish()).ToList(),
            };

            return jCodeMethod;
        }
    }

    public class JCodeMethod
    {
        public string? Name { get; set; }
        public List<JCodeVariable>? Variables { get; set; }
        public List<JCodeParameter>? Parameters { get; set; }
    }
}
