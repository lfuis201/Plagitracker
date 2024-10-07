using System;
using System.IO;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using HtmlRendererCore.PdfSharp;
using System.Net.Http;
using System.Security.Cryptography;
using System.Text;
using PlagiTracker.Analyzer.PlagiDetector;
using PlagiTracker.Data.Entities;
using static PlagiTracker.Services.SeleniumServices.WebScraping;
using PlagiTracker.Services.SeleniumServices;

namespace PlagiTracker.Services.FileServices
{
    public class ReportGenerator
    {
        public static PdfSharpCore.Pdf.PdfDocument GenerateReport(Dictionary<string, Student> analyzedStudents, List<(Student, UrlState)> unanalyzedStudents, List<PlagiResult> plagiResults)
        {
            PdfSharpCore.Pdf.PdfDocument document = new();

            var groupedResults = PlagiResultGrouper.GroupByUserId1(plagiResults);


            StringBuilder HTML = new StringBuilder();

            //HTML.Append(Resources.HtmlStyle);
            
            HTML.Append("<html lang=\"en\">");

            HTML.Append("<head>");
            HTML.Append("<meta charset=\"UTF-8\">");
            HTML.Append("<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">");
            HTML.Append($"<style>{Resources.HtmlStyle}</style>");
            HTML.Append("</head>");
            
            HTML.Append("<body>");

            HTML.Append("<h1>Plagiarism Report</h1>");
            HTML.Append($"<h2><strong>Date and Time:</strong> {DateTime.Now.ToString("dd/MM/yyyy HH:mm")}</h2>");

            // Incluir las URLs que tuvieron errores
            if (unanalyzedStudents != null && unanalyzedStudents.Count != 0)
            {
                HTML.Append("<div class=\"errores\">");
                HTML.Append("<h2>Unanalyzed Students</h2>");

                HTML.Append("<ul>");
                foreach (var unanalyzedAtudent in unanalyzedStudents)
                {
                    HTML.Append($"<li>{unanalyzedAtudent.Item1.FirstName} {unanalyzedAtudent.Item1.LastName}: {WebScraping.UrlStateToString(unanalyzedAtudent.Item2)}</li>");
                }
                HTML.Append("</ul>");
                HTML.Append("</div>");
            }

            int student = 1;

            foreach (var groupResult in groupedResults.Values)
            {
                HTML.Append($"<div class=\"student-section\">");


                var id = groupResult.Values.ToList()[0].UserId1;
                HTML.Append($"<h2>Student: {analyzedStudents[id].FirstName} {analyzedStudents[id].LastName}</h2>");

                int row = 1;
                var groupByFile = groupResult.Values.OrderBy(plagiResult => plagiResult.FileName1).ToList();
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
                    HTML.Append($"<td>{analyzedStudents[plagiResult.Usuario_Id2].FirstName} {analyzedStudents[plagiResult.Usuario_Id2].LastName}</td>");
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