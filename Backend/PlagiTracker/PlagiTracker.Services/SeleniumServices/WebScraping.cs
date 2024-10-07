// Ignore Spelling: Codiva

using OpenQA.Selenium;
using PlagiTracker.Analyzer;
using Newtonsoft.Json;
using PlagiTracker.Services.FileServices;
using OpenQA.Selenium.Firefox;
using PlagiTracker.Analyzer.PlagiDetector;
using PlagiTracker.Data.Entities;


namespace PlagiTracker.Services.SeleniumServices
{
    public class WebScraping
    {
        private IWebDriver driver;

        public WebScraping()
        {
            var options = new FirefoxOptions();

            options.AddArgument("--disable-usb");
            options.AddArgument("--headless");

            options.AddArgument("--user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36");
            //options.AddExcludedArgument("enable-automation");
            options.AddAdditionalOption("useAutomationExtension", false);

            driver = new FirefoxDriver(options);
        }

        public static async Task<bool> UrlExists(string url)
        {
            try
            {
                using (HttpClient client = new())
                {
                    HttpResponseMessage response = await client.SendAsync(new HttpRequestMessage(HttpMethod.Head, url));
                    return response.IsSuccessStatusCode;
                }
            }
            catch
            {
                return false;
            }
        }

        /// <summary>
        /// true si la URL es de Codiva,
        /// false en caso contrario
        /// </summary>
        /// <param name="url"></param>
        /// <returns></returns>
        public static bool IsCodivaUrl(string url)
        {
            return url.Contains("codiva.io");
        }

        public async Task<PdfSharpCore.Pdf.PdfDocument> StartScraping(List<(Student, Submission)> studentsSubmissions)
        {

            PdfSharpCore.Pdf.PdfDocument document = null;
            var jsonData = new Dictionary<string, List<Dictionary<string, string>>>();
            var allResults = new PlagiaPythonResult();

            var ignorePatterns = new List<string>
            {
                "System.out.println(\"Hello Codiva\");"
            };

            List<(Student, UrlState)> unanalyzedStudents = new();

            Dictionary<string, Student> analyzedAtudents = new();

            try
            {
                foreach (var studentsSubmission in studentsSubmissions)
                {
                    if(string.IsNullOrEmpty(studentsSubmission.Item2.Url))
                    {
                        unanalyzedStudents.Add((studentsSubmission.Item1, UrlState.NullOrEmpty));
                        continue;
                    }
                    else if (!IsCodivaUrl(studentsSubmission.Item2.Url))
                    {
                        unanalyzedStudents.Add((studentsSubmission.Item1, UrlState.NotCodiva));
                        continue;
                    }
                    else if (!await UrlExists(studentsSubmission.Item2.Url))
                    {
                        unanalyzedStudents.Add((studentsSubmission.Item1, UrlState.Invalid));
                        continue;
                    }

                    driver.Navigate().GoToUrl(studentsSubmission.Item2.Url);
                    Thread.Sleep(1000);

                    var labels = driver.FindElements(By.XPath("//label[starts-with(@for, 'tab-java-')]"));

                    var studentFiles = new List<Dictionary<string, string>>();

                    foreach (var label in labels)
                    {
                        string className = label.GetAttribute("title");
                        var tabElement = driver.FindElement(By.XPath($"//label[@title='{className}']"));
                        tabElement.Click();

                        Thread.Sleep(1000);

                        var codeElements = driver.FindElements(By.XPath("//div[contains(@class,'CodeMirror-code')]//pre"));
                        string codeContent = string.Join("\n", codeElements.Select(e => e.Text).Select(c => c.Trim()));

                        bool containsIgnoredPattern = ignorePatterns.Any(pattern => codeContent.Contains(pattern));
                        if (containsIgnoredPattern)
                        {
                            Console.WriteLine($"Archivo {className}.java ignorado debido a contenido irrelevante.");
                            continue;
                        }

                        var fileData = new Dictionary<string, string>
                        {
                            { "nombre", $"{className}" },
                            { "contenido", codeContent }
                        };

                        studentFiles.Add(fileData);
                    }

                    if (studentFiles.Count > 0)
                    {
                        analyzedAtudents.Add(studentsSubmission.Item1.Id.ToString(), studentsSubmission.Item1);
                        jsonData[studentsSubmission.Item1.Id.ToString()] = studentFiles;
                    }
                }
                
                Consumidor consumidor = new Consumidor();
                allResults = await consumidor.Ejecutar(jsonData);

                // Ahora procesamos todos los resultados
                if (allResults.Comparaciones_Entre_Ids.Count > 0)
                {
                    document = ReportGenerator.GenerateReport(analyzedAtudents, unanalyzedStudents, allResults.Comparaciones_Entre_Ids); // Llamada para generar el PDF
                }
                else
                {
                    Console.WriteLine("No se encontró código válido para las URLs proporcionadas.");
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error: " + ex.Message);
            }
            finally
            {
                driver.Quit();
            }
            
            return document!;
        }

        public enum UrlState
        {
            NullOrEmpty,
            Invalid,
            NotCodiva
        }
        public static string UrlStateToString(UrlState urlState)
        {
            return urlState switch
            {
                UrlState.NullOrEmpty => "The URL is null or empty",
                UrlState.Invalid => "The URL does not exist",
                UrlState.NotCodiva => "The URL is not from Codiva",
                _ => "Unknown"
            };
        }
    }
}