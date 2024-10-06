using System;
using System.IO;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using HtmlRendererCore.PdfSharp;
using System.Net.Http;
using System.Security.Cryptography;
using System.Text;

namespace PlagiTracker.Services.FileServices
{
    public class ReportGenerator
    {
        public static PdfSharpCore.Pdf.PdfDocument GenerateReport(string jsonData)
        {
            PdfSharpCore.Pdf.PdfDocument document = new();

            // Procesar el JSON para extraer los datos necesarios
            JObject json;
            try
            {
                json = JObject.Parse(jsonData);
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error al procesar JSON: " + ex.Message);
                return document; // Salir si el JSON no es válido
            }

            // Asegúrate de que "comparaciones_entre_ids" no es nulo
            var comparaciones = json["comparaciones_entre_ids"];
            if (comparaciones == null)
            {
                Console.WriteLine("No se encontraron comparaciones en el JSON.");
                return document; // Salir si no hay comparaciones
            }

            StringBuilder HTML = new StringBuilder();

            //
            HTML.Append("<!DOCTYPE html>");
            HTML.Append("<html lang=\"es\">");
            HTML.Append("<head>");
            HTML.Append("<meta charset=\"UTF-8\">");
            HTML.Append("<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">");
            HTML.Append($"<style>{ Resources.HtmlStyle }</style>");
            HTML.Append("</head>");
            
            HTML.Append("<body>");
            HTML.Append("<div class=\"container\">");
            HTML.Append("<h1>Reporte de Plagio</h1>");

            HTML.Append("<div class=\"header\">");
            HTML.Append($"<p><strong>Fecha y Hora de Generación:</strong> { DateTime.Now.ToString("dd/MM/yyyy HH:mm") }</p>");
            HTML.Append("</div>");

            foreach (var comparacion in comparaciones)
            {
                // Extraer los datos necesarios
                int coincidencias = (int)comparacion["coincidencias"];
                string nombre1 = comparacion["nombre1"].ToString();
                string nombre2 = comparacion["nombre2"].ToString();
                string usuarioId1 = comparacion["usuarioId1"].ToString();
                string usuarioId2 = comparacion["usuarioId2"].ToString();
                double similitudJaccard = (double)comparacion["jaccard"];
                double similitudLevenshtein = (double)comparacion["levenshtein"];
                double similitudSemantica = (double)comparacion["semantica"];

                // Agregar los datos al PDF
                HTML.Append("<div class=\"comparison\">");
                HTML.Append("<h2>Comparación entre Alumnos</h2>");
                HTML.Append($"<p><strong>Alumno 1:</strong> { nombre1 } vs <strong>Alumno 2:</strong> { nombre2 }</p>");
                HTML.Append("<table>");

                HTML.Append("<tr>");
                HTML.Append("<th>Archivos Comparados</th>");
                HTML.Append("<th>Coincidencias</th>");
                HTML.Append("<th>Similitud Jaccard (%)</th>");
                HTML.Append("<th>Similitud Levenshtein (%)</th>");
                HTML.Append("<th>Similitud Semántica (%)</th>");
                HTML.Append("</tr>");

                HTML.Append("<tr>");
                HTML.Append($"<td>{ nombre1 } vs { nombre2 }</td>");
                HTML.Append($"<td class=\"highlight\">{ coincidencias }</td>");
                HTML.Append($"<td class=\"percentage\">{ similitudJaccard }%</td>");
                HTML.Append($"<td class=\"percentage\">{ similitudLevenshtein }%</td>");
                HTML.Append($"<td class=\"percentage\">{ similitudSemantica }%</td>");
                HTML.Append("</tr>");

                HTML.Append("</table>");
                HTML.Append("</div>");
            }

            HTML.Append("</div>");
            HTML.Append("</body>");
            HTML.Append("</html>");

            document.Close();

            document = PdfGenerator.GeneratePdf(HTML.ToString(), PdfSharpCore.PageSize.A3);

            return document;
        }
    }
}