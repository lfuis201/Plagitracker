// Ignore Spelling: Codiva

using OpenQA.Selenium;
using PlagiTracker.Analyzer;
using Newtonsoft.Json;
using PlagiTracker.Services.FileServices;
using OpenQA.Selenium.Edge;
using OpenQA.Selenium.Chrome;
using OpenQA.Selenium.Firefox;
using PlagiTracker.Analyzer.PlagiDetector;
using PlagiTracker.Data.Entities;
using System.Collections.Generic;
using OpenQA.Selenium.DevTools;

namespace PlagiTracker.Services.SeleniumServices
{
    public class StudentSubmission
    {
        public Guid Id { get; set; }
        public string? FirstName { get; set; }
        public string? LastName { get; set; }
        public Guid SubmissionId { get; set; }
        public string? Url { get; set; }

        /// <summary>
        /// Dictionary<string, string> nombre del archivo y el codigo fuente
        /// </summary>
        public Dictionary<string, string> Codes { get; set; } = [];

        public UrlState State { get; set; }

        public List<PlagiResult> PlagiResults { get; set; } = [];

        public StudentSubmission(Submission submission)
        {
            if(submission == null)
            {
                Console.WriteLine($"Error ({nameof(StudentSubmission)}): The submission is null");
            }
            else
            {
                Id = submission.StudentId;
                FirstName = submission.Student!.FirstName;
                LastName = submission.Student!.LastName;
                SubmissionId = submission.Id;
                Url = submission.Url;
                Codes = [];
                PlagiResults = [];
            }
        }

        public enum UrlState
        {
            NullOrEmpty,
            Invalid,
            NotCodiva,
            Ok,
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

    public class WebScraping
    {
        private IWebDriver? Driver;

        public WebScraping()
        {
            bool isCreated = CreateFireFoxDriver();

            if (!isCreated)
            {
                isCreated = CreateEdgeDriver();

                if (!isCreated)
                {
                    isCreated = CreateChromeDriver();

                    if (!isCreated)
                    {
                        Console.WriteLine("Error: The driver could not be created");
                    }
                }
            }
        }

        private bool CreateFireFoxDriver()
        {
            bool result;
            try
            {
                var options = new FirefoxOptions();
                options.AddArgument("--headless");
                options.AddArgument("--disable-gpu");
                options.AddArgument("--enable-javascript");

                Driver = new FirefoxDriver(options);
                result = true;
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error: " + ex.Message);
                result = false;
            }

            return result;
        }

        private bool CreateEdgeDriver()
        {
            bool result;
            try
            {
                var options = new EdgeOptions();
                options.AddArgument("--headless");
                options.AddArgument("--disable-gpu");
                options.AddArgument("--enable-javascript");

                Driver = new EdgeDriver(options);
                result = true;
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error: " + ex.Message);
                result = false;
            }

            return result;
        }

        private bool CreateChromeDriver()
        {
            bool result;
            try
            {
                var options = new ChromeOptions();
                options.AddArgument("--headless");
                options.AddArgument("--disable-gpu");
                options.AddArgument("--enable-javascript");
                //options.AddArgument("--window-size=1920,1080");

                Driver = new ChromeDriver(options);
                result = true;
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error: " + ex.Message);
                result = false;
            }

            return result;
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
        /// true si la URL es de Codiva, false en caso contrario
        /// </summary>
        public static bool IsCodivaUrl(string url)
        {
            return url.Contains("codiva.io");
        }

        public async Task<Dictionary<Guid, StudentSubmission>> StartScraping(List<Submission> studentsSubmissions)
        {
            if (Driver == null)
            {
                Console.WriteLine("Error: Driver is NULL");
                return new();
            }

            Dictionary<Guid, StudentSubmission> StudentSubmissionResults = []; 
            PlagiaPythonResult analysis = new();
            var jsonData = new Dictionary<string, List<Dictionary<string, string>>>();
            
            var ignorePatterns = new List<string>
            {
                "System.out.println(\"Hello Codiva\");"
            };

            try
            {
                foreach (var studentsSubmission in studentsSubmissions)
                {
                    if(!StudentSubmissionResults.ContainsKey(studentsSubmission.StudentId))
                    {
                        StudentSubmissionResults[studentsSubmission.StudentId] = new StudentSubmission(studentsSubmission);
                    }

                    if(string.IsNullOrEmpty(studentsSubmission.Url))
                    {
                        StudentSubmissionResults[studentsSubmission.StudentId].State = StudentSubmission.UrlState.NullOrEmpty;
                        continue;
                    }
                    else if (!IsCodivaUrl(studentsSubmission.Url))
                    {
                        StudentSubmissionResults[studentsSubmission.StudentId].State = StudentSubmission.UrlState.NotCodiva;
                        continue;
                    }
                    else if (!await UrlExists(studentsSubmission.Url))
                    {
                        StudentSubmissionResults[studentsSubmission.StudentId].State = StudentSubmission.UrlState.Invalid;
                        continue;
                    }
                    else
                    {
                        StudentSubmissionResults[studentsSubmission.StudentId].State = StudentSubmission.UrlState.Ok;
                    }

                    Driver.Navigate().GoToUrl(studentsSubmission.Url);
                    Thread.Sleep(1000);

                    var labels = Driver.FindElements(By.XPath("//label[starts-with(@for, 'tab-java-')]"));

                    var studentFiles = new List<Dictionary<string, string>>();

                    foreach (var label in labels)
                    {
                        string className = label.GetAttribute("title");
                        var tabElement = Driver.FindElement(By.XPath($"//label[@title='{className}']"));
                        tabElement.Click();

                        Thread.Sleep(1000);

                        var codeElements = Driver.FindElements(By.XPath("//div[contains(@class,'CodeMirror-code')]//pre"));

                        string codeContent = string.Join("\n", codeElements.Select(e => e.Text).Select(c => c.Trim()));
                        
                        StudentSubmissionResults[studentsSubmission.StudentId].Codes.TryAdd(className, codeContent);
                        
                        // Ignorar archivos que contengan el código por dafult de Codiva
                        if (ignorePatterns.Any(pattern => codeContent.Contains(pattern)))
                        {
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
                        jsonData[studentsSubmission.StudentId.ToString()] = studentFiles;
                    }
                    else
                    {
                        StudentSubmissionResults[studentsSubmission.StudentId].State = StudentSubmission.UrlState.Invalid;
                    }
                }
                
                analysis = await Consumer.Execute(jsonData);
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error: " + ex.Message);
            }
            finally
            {
                Driver.Quit();
            }
            
            if(analysis != null && analysis.Comparaciones_Entre_Ids != null && analysis.Comparaciones_Entre_Ids.Count > 2)
            {
                foreach (var plagiaPythonResult in analysis.Comparaciones_Entre_Ids)
                {
                    if (StudentSubmissionResults.ContainsKey(Guid.Parse(plagiaPythonResult.UserId1)))
                    {
                        StudentSubmissionResults[Guid.Parse(plagiaPythonResult.UserId1)].PlagiResults.Add(plagiaPythonResult);
                    }
                }
            }

            return StudentSubmissionResults;
        }
    }
}