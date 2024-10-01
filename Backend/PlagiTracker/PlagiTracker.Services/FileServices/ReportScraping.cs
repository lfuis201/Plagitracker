using System;
using System.IO;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using HtmlRendererCore.PdfSharp;
using System.Net.Http;
using System.Security.Cryptography;

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

            string htmlContent = string.Empty;
            htmlContent += "<html> <body>";

            // Agregar contenido al PDF
            htmlContent += $"<h1>Reporte de Plagio<h1>";
            htmlContent += $"<h2>Fecha y Hora de Generación: { DateTime.Now.ToString("dd/MM/yyyy HH:mm")} <h2>";

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

                htmlContent += $"<p>Estudiante 1: {nombre1} (ID: {usuarioId1}) vs Estudiante 2: {nombre2} (ID: {usuarioId2})</p>";
                htmlContent += $"<p>Coincidencias: {coincidencias}</p>";
                htmlContent += $"<p>Similitud Jaccard: {similitudJaccard:F2}%</p>";
                htmlContent += $"<p>Similitud Levenshtein: {similitudLevenshtein:F2}</p>";
                htmlContent += $"<p>Similitud Semántica: {similitudSemantica:F2}%</p>";
                htmlContent += "<br>"; // Espacio en blanco
            }

            document.Close();

            document = PdfGenerator.GeneratePdf(htmlContent, PdfSharpCore.PageSize.A4);

            return document;
        }
    }
}