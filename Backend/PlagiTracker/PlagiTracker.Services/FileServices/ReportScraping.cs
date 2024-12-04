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

            if (analysisResult == null && analysisResult!.Count <= 2)
            {
                return document;
            }

            HTML.Append("<html lang=\"en\">");

            HTML.Append("<head>");
            HTML.Append("<meta charset=\"UTF-8\">");
            HTML.Append("<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">");
            HTML.Append($"<style>{Resources.HtmlStyle}</style>");
            HTML.Append("</head>");
            
            HTML.Append("<body>");

            HTML.Append("<h1>Plagiarism Report</h1>");
            HTML.Append($"<h2><strong>Date and Time:</strong> {DateTime.Now.ToString("dd/MM/yyyy HH:mm")}</h2>");

            var unanalyzedStudents = analysisResult.Values.Where(studentSubmission => studentSubmission.State != StudentSubmission.UrlState.Ok).ToList();

            // Incluir las URLs que tuvieron errores
            if (unanalyzedStudents.Count > 0)
            {
                HTML.Append("<div class=\"errores\">");
                HTML.Append("<h2>Unanalyzed Students</h2>");

                HTML.Append("<ul>");
                foreach (var unanalyzedStudent in unanalyzedStudents)
                {
                    HTML.Append($"<li>{unanalyzedStudent.FirstName} {unanalyzedStudent.LastName}: {StudentSubmission.UrlStateToString(unanalyzedStudent.State)}</li>");
                }
                HTML.Append("</ul>");
                HTML.Append("</div>");
            }

            int student = 1;

            foreach (var studentSubmission in analysisResult.Values)
            {
                if(studentSubmission.Codes.Count <= 0 && studentSubmission.State != StudentSubmission.UrlState.Ok)
                {                     
                    continue;
                }

                HTML.Append($"<div class=\"student-section\">");
                HTML.Append($"<h2>Student: {studentSubmission.FirstName} {studentSubmission.LastName}</h2>");

                int row = 1;
                var groupByFile = studentSubmission.PlagiResults.OrderBy(plagiResult => plagiResult.FileName1).ToList();
                string currentFile = string.Empty;

                foreach(var plagiResult in groupByFile)
                {
                    if (plagiResult.FileName1 != currentFile)
                    {
                        if (currentFile != string.Empty)
                        {
                            HTML.Append("</tbody>");
                            HTML.Append("</table>");

                            currentFile = string.Empty;
                        }

                        currentFile = plagiResult.FileName1;
                        HTML.Append($"<h3>File: {currentFile}</h3>");

                        HTML.Append("<table>");
                        HTML.Append("<thead>");
                        HTML.Append("<tr>");
                        HTML.Append("<th>No</th>");
                        HTML.Append("<th>Student</th>");
                        HTML.Append("<th>Student File</th>");
                        HTML.Append("<th>Coincidences</th>");
                        HTML.Append("<th>Jaccard</th>");
                        HTML.Append("<th>Levenshtein</th>");
                        HTML.Append("<th>Semantic</th>");
                        HTML.Append("</tr>");
                        HTML.Append("</thead>");
                        HTML.Append("<tbody>");
                    }

                    HTML.Append("<tr>");
                    HTML.Append($"<td>{row++}</td>");
                    HTML.Append($"<td>{analysisResult[Guid.Parse(plagiResult.Usuario_Id2)].FirstName} {analysisResult[Guid.Parse(plagiResult.Usuario_Id2)].LastName}</td>");
                    HTML.Append($"<td>{plagiResult.FileName2}</td>");
                    HTML.Append($"<td>{plagiResult.Coincidences}</td>");
                    HTML.Append($"<td>{plagiResult.JaccardSimilitude}%</td>");
                    HTML.Append($"<td>{plagiResult.LevenshteinSimilitude}%</td>");
                    HTML.Append($"<td>{plagiResult.SemanticSimilitude}%</td>");
                    HTML.Append("</tr>");
                }

                student++;
                HTML.Append("</div>");
            }

            HTML.Append("</body>");
            HTML.Append("</html>");
            
            document.Close();

            document = PdfGenerator.GeneratePdf(HTML.ToString(), PdfSharpCore.PageSize.A0);

            return document;
        }
    }
}