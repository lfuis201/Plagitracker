using System;
using System.IO;
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
        JObject json = JObject.Parse(jsonData);
        var comparisons = json["comparaciones_entre_ids"];

        // Crear un documento PDF
        Document document = new Document();
        // Incluir la fecha y hora en el nombre del archivo
        string pdfPath = Path.Combine(directoryPath, $"ReportePlagio_{DateTime.Now:yyyyMMdd_HHmmss}.pdf");

        using (FileStream stream = new FileStream(pdfPath, FileMode.Create))
        {
            PdfWriter.GetInstance(document, stream);
            document.Open();

            // Agregar contenido al PDF
            document.Add(new Paragraph("Reporte de Plagio", FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 16)));
            document.Add(new Paragraph("Fecha y Hora de Generación: " + DateTime.Now.ToString("dd/MM/yyyy HH:mm")));
            document.Add(new Paragraph(" ")); // Espacio en blanco

            foreach (var comparison in comparisons)
            {
                string usuarioId1 = comparison["usuario_id1"].ToString();
                string usuarioId2 = comparison["usuario_id2"].ToString();
                int coincidencias = (int)comparison["coincidencias"];
                float similitudJaccard = (float)comparison["similitud_jaccard"];
                float similitudLevenshtein = (float)comparison["similitud_levenshtein"];
                float similitudSemantica = (float)comparison["similitud_semantica"];
                string nombre1 = comparison["nombre1"].ToString();
                string nombre2 = comparison["nombre2"].ToString();

                document.Add(new Paragraph($"Usuario 1: {usuarioId1} vs Usuario 2: {usuarioId2}"));
                document.Add(new Paragraph($"Archivos Comparados: {nombre1} y {nombre2}"));
                document.Add(new Paragraph($"Coincidencias: {coincidencias}"));
                document.Add(new Paragraph($"Similitud Jaccard: {similitudJaccard:F2}"));
                document.Add(new Paragraph($"Similitud Levenshtein: {similitudLevenshtein:F2}"));
                document.Add(new Paragraph($"Similitud Semántica: {similitudSemantica:F2}"));
                document.Add(new Paragraph(" ")); // Espacio en blanco
            }

            document.Close();
        }
    }
}
