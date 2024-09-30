using System;
using System.IO;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using iTextSharp.text;
using iTextSharp.text.pdf;

public class ReportGenerator
{
    public void GenerateReport(string jsonData)
    {
        // Asegúrate de que el directorio existe
        string directoryPath = @"D:\WS Text\Reportes";
        if (!Directory.Exists(directoryPath))
        {
            Directory.CreateDirectory(directoryPath);
        }

        // Procesar el JSON para extraer los datos necesarios
        JObject json;
        try
        {
            json = JObject.Parse(jsonData);
        }
        catch (Exception ex)
        {
            Console.WriteLine("Error al procesar JSON: " + ex.Message);
            return; // Salir si el JSON no es válido
        }

        // Asegúrate de que "comparaciones_entre_ids" no es nulo
        var comparaciones = json["comparaciones_entre_ids"];
        if (comparaciones == null)
        {
            Console.WriteLine("No se encontraron comparaciones en el JSON.");
            return; // Salir si no hay comparaciones
        }

        // Crear un documento PDF
        Document document = new Document();
        string pdfPath = Path.Combine(directoryPath, $"ReportePlagio_{DateTime.Now:yyyyMMdd_HHmmss}.pdf");

        using (FileStream stream = new FileStream(pdfPath, FileMode.Create))
        {
            PdfWriter.GetInstance(document, stream);
            document.Open();

            // Agregar contenido al PDF
            document.Add(new Paragraph("Reporte de Plagio", FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 16)));
            document.Add(new Paragraph("Fecha y Hora de Generación: " + DateTime.Now.ToString("dd/MM/yyyy HH:mm")));
            document.Add(new Paragraph(" ")); // Espacio en blanco

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
                document.Add(new Paragraph($"Estudiante 1: {nombre1} (ID: {usuarioId1}) vs Estudiante 2: {nombre2} (ID: {usuarioId2})"));
                document.Add(new Paragraph($"Coincidencias: {coincidencias}"));
                document.Add(new Paragraph($"Similitud Jaccard: {similitudJaccard:F2}%"));
                document.Add(new Paragraph($"Similitud Levenshtein: {similitudLevenshtein:F2}"));
                document.Add(new Paragraph($"Similitud Semántica: {similitudSemantica:F2}%"));
                document.Add(new Paragraph(" ")); // Espacio en blanco
            }

            document.Close();
        }
    }
}
