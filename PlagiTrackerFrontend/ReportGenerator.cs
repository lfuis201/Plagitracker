using HtmlRendererCore.PdfSharp;
using System.Text;
using PlagiTracker.Services.SeleniumServices;
using PdfSharpCore.Pdf;

namespace PlagiTracker.Services.FileServices
{
    public class ReportGenerator
    {
        public static PdfDocument GenerateReport(Dictionary<Guid, StudentSubmission> analysisResult)
        {
            PdfDocument document = new();
            StringBuilder HTML = new();

            if (analysisResult == null || analysisResult.Count <= 2)
            {
                return document;
            }

            // Empieza a construir el HTML
            HTML.Append("<!DOCTYPE html>");
            HTML.Append("<html lang=\"en\">");
            HTML.Append("<head>");
            HTML.Append("<meta charset=\"UTF-8\">");
            HTML.Append("<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">");
            HTML.Append("<title>PlagiTracker Report</title>");
            HTML.Append($"<style>{Resources.HtmlStyle}</style>");
            HTML.Append("</head>");
            HTML.Append("<body>");
            HTML.Append("<div class=\"report-container\">");

            // Header con información de la actividad
            HTML.Append("<div class=\"header\">");
            HTML.Append("<h1>PlagiTracker Report</h1>");
            HTML.Append("<div class=\"text-box-yellow\">");
            HTML.Append("<strong class=\"activity-tittle\">Activity:</strong>");
            HTML.Append("<div class=\"activity-info\">Examen Parcial</div>");
            HTML.Append("</div>");
            HTML.Append($"<div><strong>Date:</strong> {DateTime.Now.ToString("dd/MM/yyyy")}");
            HTML.Append($"<strong>N° Students:</strong> {analysisResult.Count}</div>");
            HTML.Append("</div>");

            // Sección para mostrar los métodos
            var methods = new[] { "Jaccard", "Levenshtein", "Semantic" };
            foreach (var method in methods)
            {
                HTML.Append("<div class=\"method-section\">");
                HTML.Append($"<h2>Method: {method}</h2>");
                HTML.Append("<div class=\"range\">");

                // Rango de similitud
                for (int range = 0; range <= 100; range += 20)
                {
                    string rangeClass = $"range-{range}-{range + 20}";
                    HTML.Append($"<div class=\"box {rangeClass}\">");
                    HTML.Append($"<strong>{range}% - {range + 20}%</strong>");
                    HTML.Append("<div class=\"text-box-white\">");

                    // Aquí es donde agregas la lógica para mostrar los estudiantes en cada rango
                    foreach (var student in analysisResult.Values)
                    {
                        HTML.Append($"{student.FirstName} {student.LastName} - {student.GetSimilitudePercentage(method)}%<br>");
                    }

                    HTML.Append("</div>");
                    HTML.Append("</div>");
                }

                HTML.Append("</div>");
                HTML.Append("</div>");
            }

            // Sección para estudiantes no analizados
            var unanalyzedStudents = analysisResult.Values
                .Where(student => student.State != StudentSubmission.UrlState.Ok).ToList();

            if (unanalyzedStudents.Any())
            {
                HTML.Append("<div class=\"unanalyzed-students\">");
                HTML.Append("<h2>Unanalyzed Students</h2>");
                HTML.Append("<div class=\"range\">");

                foreach (var student in unanalyzedStudents)
                {
                    string stateClass = student.State == StudentSubmission.UrlState.IncorrectUrl ? "incorrect-url" : "not-delivered";
                    HTML.Append($"<div class=\"box {stateClass}\">");
                    HTML.Append($"<strong>{StudentSubmission.UrlStateToString(student.State)}</strong><br>");
                    HTML.Append($"{student.FirstName} {student.LastName}<br>");
                    HTML.Append("</div>");
                }

                HTML.Append("</div>");
                HTML.Append("</div>");
            }

            HTML.Append("</div>");
            HTML.Append("</body>");
            HTML.Append("</html>");

            // Cerrar documento y generar PDF
            document.Close();
            document = PdfGenerator.GeneratePdf(HTML.ToString(), PdfSharpCore.PageSize.A4);

            return document;
        }
    }
}
