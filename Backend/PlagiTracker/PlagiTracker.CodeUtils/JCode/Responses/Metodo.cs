using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PlagiTracker.CodeUtils.JCode.Responses
{
    public class Metodo
    {
        public string MetodoNombre { get; set; }
        public List<Variable> Variables { get; set; }
        public List<Parametro> Parametros { get; set; }
    }
}
