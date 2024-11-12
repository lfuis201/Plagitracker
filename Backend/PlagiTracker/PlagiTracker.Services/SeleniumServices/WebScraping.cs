// Ignore Spelling: Codiva Replit

using OpenQA.Selenium;
using PlagiTracker.Analyzer;
using OpenQA.Selenium.Edge;
using OpenQA.Selenium.Chrome;
using OpenQA.Selenium.Firefox;
using PlagiTracker.Analyzer.PlagiDetector;
using PlagiTracker.Data.Entities;
using System.Collections.Generic;
using OpenQA.Selenium.DevTools;
using System.Reflection.Emit;
using PlagiTracker.Data;
using OpenQA.Selenium.Support.UI;
using SeleniumExtras.WaitHelpers;
using OpenQA.Selenium.Interactions;
using System.IO.Compression;

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

        private static readonly string DownloadPath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, @"Downloads\");

        //driver.Manage().Window.Size = new System.Drawing.Size(1500, 2000);
        public IWebDriver? Driver;

        public WebScraping()
        {
            bool isCreated = CreateChromeDriver();

            if (!isCreated)
            {
                isCreated = CreateChromeDriver();

                if (!isCreated)
                {
                    isCreated = CreateEdgeDriver();

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
                //options.AddArgument("--disable-gpu");
                options.AddArgument("--enable-javascript");
                options.SetPreference("browser.download.folderList", 2);

                // Obtener la ruta base del proyecto
                string baseDirectory = AppDomain.CurrentDomain.BaseDirectory;

                // Combinar la ruta base con la ruta relativa
                string downloadPath = Path.Combine(baseDirectory, @"Downloads\");

                options.SetPreference("browser.download.dir", downloadPath);
                options.SetPreference("browser.helperApps.neverAsk.saveToDisk", "application/zip");


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
                //options.AddArgument("--disable-gpu");
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
            PlagiaPythonResult1 analysis = new();
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
            
            if(analysis != null && analysis.comparaciones_por_nombre != null && analysis.comparaciones_por_nombre.Count > 0)
            {
                foreach (var plagiaPythonResult in analysis.comparaciones_por_nombre.Values)
                {
                    foreach (var plagiaPythonResult2 in plagiaPythonResult)
                    {
                            if (StudentSubmissionResults.ContainsKey(Guid.Parse(plagiaPythonResult2.UserId1)))
                            {
                                StudentSubmissionResults[Guid.Parse(plagiaPythonResult2.UserId1)].PlagiResults.Add(plagiaPythonResult2);
                            }
                    }
                }
            }

            return StudentSubmissionResults;
        }

        public (Result result, Dictionary<string, string>) ScrapeCodiva(string url)
        {
            Result result = new();
            Dictionary<string, string> codes = [];

            if (Driver == null)
            {
                result = new Result(false, "Error: Driver is NULL");
                return (result, codes);
            }
            
            WebDriverWait webDriverWait = new(Driver, TimeSpan.FromSeconds(10));
            Driver.Navigate().GoToUrl(url);

            //Thread.Sleep(1000);
            webDriverWait.Until(ExpectedConditions.ElementIsVisible(By.XPath("//label[starts-with(@for, 'tab-java-')]")));
            var labels = Driver.FindElements(By.XPath("//label[starts-with(@for, 'tab-java-')]"));

            var studentFiles = new List<Dictionary<string, string>>();

            foreach (var label in labels)
            {
                string className = label.GetAttribute("title");
                var tabElement = Driver.FindElement(By.XPath($"//label[@title='{className}']"));
                tabElement.Click();

                Thread.Sleep(100);
                webDriverWait.Until(driver => ExpectedConditions.ElementIsVisible(By.XPath("//div[contains(@class,'CodeMirror-code')]//pre")));
                var codeElements = Driver.FindElements(By.XPath("//div[contains(@class,'CodeMirror-code')]//pre"));

                string codeContent = string.Join("\n", codeElements.Select(e => e.Text).Select(c => c.Trim()));

                codes.TryAdd(className, codeContent);

                // Ignorar archivos que contengan el código por dafult de Codiva
                /*
                if (ignorePatterns.Any(pattern => codeContent.Contains(pattern)))
                {
                    continue;
                }
                */
                
                var fileData = new Dictionary<string, string>
                {
                    { "nombre", $"{className}" },
                    { "contenido", codeContent }
                };
                
                studentFiles.Add(fileData);
            }

            Driver.Quit();

            if (studentFiles.Count <= 0)
            {
                result = new Result(false, "Error: No files found");
            }

            Console.WriteLine($"Code Elements: {studentFiles.Count}");
            
            result = new Result(true, "Success");

            return (result, codes);
        }
    
        public Result ScrapeReplit(string url)
        {
            Result result = new();

            if (Driver == null)
            {
                result = new Result(false, "Error: Driver is NULL");
                return result;
            }

            WebDriverWait webDriverWait = new(Driver, TimeSpan.FromSeconds(10));
            Driver.Navigate().GoToUrl("https://replit.com");

            try
            {
                webDriverWait.Until(ExpectedConditions.ElementIsVisible(By.CssSelector(".css-12xd7j0")));
            }
            catch (WebDriverTimeoutException)
            {
                // Si el elemento no es visible, proceder con el inicio de sesión
                Driver.Navigate().GoToUrl("https://replit.com/login");

                try
                {
                    webDriverWait.Until(ExpectedConditions.ElementIsVisible(By.Id("username-:r0:")));
                }
                catch (WebDriverTimeoutException)
                {
                    // Continuar incluso si el elemento no aparece
                }

                Driver.FindElement(By.Id("username-:r0:")).SendKeys("plagitracker@protonmail.com");
                Driver.FindElement(By.Id("password-:r6:")).SendKeys("7SasF6B^X99db(VH");
                Driver.FindElement(By.CssSelector(".css-evt1a8")).Click();

                try
                {
                    webDriverWait.Until(ExpectedConditions.ElementIsVisible(By.CssSelector(".css-12xd7j0")));
                }
                catch (WebDriverTimeoutException)
                {
                    // Continuar incluso si el elemento no aparece
                }

                string userName = Driver.FindElement(By.CssSelector(".css-12xd7j0")).Text;

                if (userName != "plagitracker")
                {
                    result = new Result(false, "Error: LogIn failed");
                    return result;
                }
            }

            Console.WriteLine("Logged in");

            // Navegar a la URL de descarga con un CancellationToken
            var cts = new CancellationTokenSource(TimeSpan.FromSeconds(5)); // Ajusta el tiempo según sea necesario
            var navigateTask = Task.Run(() => Driver.Navigate().GoToUrl(url), cts.Token);

            try
            {
                do
                {
                    navigateTask.Wait(cts.Token);
                }
                while (!IsFileDownloaded(DownloadPath));
            }
            catch (OperationCanceledException)
            {
                result = new Result(false, "Error: Navigation to URL timed out");
                Driver.Quit();
            }
            finally
            {
                Driver.Dispose();
                if (IsFileDownloaded(DownloadPath))
                {
                    ExtractZipFile(DownloadPath, DownloadPath);
                    result = new Result(true, "File downloaded and extracted successfully");
                }
                else
                {
                    result = new Result(false, "File not found after download attempt");
                }
            }
            return result;
        }

        public static bool IsFileDownloaded(string filePath)
        {
            return File.Exists(filePath);
        }

        public static void ExtractZipFile(string zipFilePath, string extractPath)
        {
            if (!Directory.Exists(extractPath))
            {
                Directory.CreateDirectory(extractPath);
            }

            ZipFile.ExtractToDirectory(zipFilePath, extractPath);
        }
    }
}