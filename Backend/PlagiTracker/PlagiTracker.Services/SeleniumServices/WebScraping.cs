﻿// Ignore Spelling: Codiva Replit ONLINE GDB Screenshot

using OpenQA.Selenium;
using PlagiTracker.Analyzer;
using OpenQA.Selenium.Edge;
using OpenQA.Selenium.Chrome;
using OpenQA.Selenium.Firefox;
using PlagiTracker.Analyzer.PlagiDetector;
using PlagiTracker.Data.Entities;
using PlagiTracker.Data;
using System.IO.Compression;
using System.Reflection.Emit;
using System.Text.RegularExpressions;

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

    public partial class WebScraping
    {
        private static readonly string DownloadPath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, @"Downloads\");

        //driver.Manage().Window.Size = new System.Drawing.Size(1500, 2000);
        public IWebDriver? Driver;

        public const string CODIVA_PATTERN = @"^https:\/\/www\.codiva\.io\/p\/[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$";
        public const string ONLINE_GDB_PATTERN = @"^https:\/\/www\.onlinegdb\.com\/[a-zA-Z0-9_-]+$";
        public const string ONLINE_GDB_PATTERN2 = @"^https:\/\/onlinegdb\.com\/[a-zA-Z0-9_-]+$";

        public WebScraping()
        {
            bool isCreated = CreateFireFoxDriver();

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
        /// Verifica si la URL es de Codiva, OnlineGDB o Replit
        /// </summary>
        public static bool IsSupportedURL(UrlCompilerType urlCompilerType, string url)
        {
            if (!Regex.IsMatch(url, CODIVA_PATTERN) && !Regex.IsMatch(url, ONLINE_GDB_PATTERN)
                && !Regex.IsMatch(url, ONLINE_GDB_PATTERN2) //&& !url.Contains("replit.com")
                )
            {
                return false;
            }
            return true;
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
                    else if (!IsSupportedURL(studentsSubmission.Compiler, studentsSubmission.Url))
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

        /// <summary>
        /// Obtiene el código de la Entrega de un estudiante. Usa Selenium para navegar a la URL de Codiva y obtener el código fuente.
        /// </summary>
        /// <param name="submission">
        /// Entrega del estudiante
        /// </param>
        /// <returns></returns>
        public async Task<Result<(Submission submission, Dictionary<string, string> codes)>> GetCodes(Submission submission)
        {
            // Verificar si la URL es válida
            if(string.IsNullOrEmpty(submission.Url))
            {                 
                return new(false, "The URL is null or empty");
            }
            else if (!await UrlExists(submission.Url))
            {
                return new(false, "The URL does not exist");
            }

            if(Regex.IsMatch(submission.Url, CODIVA_PATTERN))
            {
                return await GetCodesForCodiva(submission);
            }
            else if(Regex.IsMatch(submission.Url, ONLINE_GDB_PATTERN) || Regex.IsMatch(submission.Url, ONLINE_GDB_PATTERN2))
            {
                return await GetCodesForOnlineGDB(submission);
            }
            else
            {
                return new(false, "The URL is not supported");
            }
        }

        public async Task<Result<(Submission submission, Dictionary<string, string> codes)>> GetCodesForCodiva(Submission submission)
        {
            Submission newSubmission = submission;
            Dictionary<string, string> codes = [];
            
            if (Driver == null)
            {
                return new(false, "Error: Driver is NULL", (newSubmission, codes));
            }

            var ignorePatterns = new List<string>
            {
                "System.out.println(\"Hello Codiva\");"
            };

            try
            {
                if (string.IsNullOrEmpty(submission.Url))
                {
                    newSubmission.UrlState = UrlState.NullOrEmpty;
                    return new (false, "Error: The URL is null or empty", (newSubmission, codes));
                }
                else if (!IsSupportedURL(submission.Compiler, submission.Url))
                {
                    newSubmission.UrlState = UrlState.Invalid;
                    return new (false, "Error: The URL is Invalid", (newSubmission, codes));
                }
                else if (!await UrlExists(submission.Url))
                {
                    newSubmission.UrlState = UrlState.NotExists;
                    return new (false, "Error: The URL does not exist", (newSubmission, codes));
                }

                newSubmission.UrlState = UrlState.Ok;

                Driver.Navigate().GoToUrl(newSubmission.Url);
                Thread.Sleep(1000);

                var labels = Driver.FindElements(By.XPath("//label[starts-with(@for, 'tab-java-')]"));

                foreach (var label in labels)
                {
                    string className = label.GetAttribute("title");
                    var tabElement = Driver.FindElement(By.XPath($"//label[@title='{className}']"));
                    tabElement.Click();

                    Thread.Sleep(1000);

                    var codeElements = Driver.FindElements(By.XPath("//div[contains(@class,'CodeMirror-code')]//pre"));

                    string codeContent = string.Join("\n", codeElements.Select(e => e.Text).Select(c => c.Trim()));

                    codes.TryAdd(className, codeContent);
                }
            }
            catch (Exception ex)
            {
                return new (false, $"Error: {ex.Message}", (newSubmission, codes));
            }
            finally
            {
                Driver.Quit();
            }

            return new (true, "Success", (newSubmission, codes));
        }

        public async Task<Result<(Submission submission, Dictionary<string, string> codes)>> GetCodesForOnlineGDB(Submission submission)
        {
            Submission newSubmission = submission;
            Dictionary<string, string> codes = [];

            if (Driver == null)
            {
                return new(false, "Error: Driver is NULL", (newSubmission, codes));
            }

            var ignorePatterns = new List<string>
            {
                "System.out.println(\"Hello Codiva\");"
            };

            try
            {
                if (string.IsNullOrEmpty(submission.Url))
                {
                    newSubmission.UrlState = UrlState.NullOrEmpty;
                    return new(false, "Error: The URL is null or empty", (newSubmission, codes));
                }
                /*else if (!IsCodivaUrl(submission.Url))
                {
                    newSubmission.UrlState = UrlState.NotCodiva;
                    return new(false, "Error: The URL is not from Codiva", (newSubmission, codes));
                }*/
                else if (!await UrlExists(submission.Url))
                {
                    newSubmission.UrlState = UrlState.Invalid;
                    return new(false, "Error: The URL does not exist", (newSubmission, codes));
                }

                newSubmission.UrlState = UrlState.Ok;
                
                Driver.Navigate().GoToUrl(newSubmission.Url);
                Thread.Sleep(1000);
                Console.WriteLine("GetCodes2");
                //var labels = Driver.FindElements(By.XPath("//label[starts-with(@for, 'tab-java-')]"));
                var labels = Driver.FindElements(By.XPath("//span[contains(@class,'filename')]"));
                //
                Console.WriteLine($"Labels: {labels.Count}");

                int count = 1;
                foreach (var label in labels)
                {
                    Console.WriteLine($"Label: {label.Text}");
                    string className = label.Text;
                    var tabElement = Driver.FindElement(By.XPath($"//*[@id=\"multi_editor_container\"]/div[1]/ul/li[{count}]/a"));
                    tabElement.Click();
                    // //*[@id="editor_2"]/div[2]/div/div[3]/div[1]
                    Thread.Sleep(1000);

                    var codeElements = Driver.FindElements(By.XPath($"//*[@id=\"editor_{count}\"]/div[2]/div/div[3]/div"));

                    string codeContent = string.Join("\n", codeElements.Select(e => e.Text).Select(c => c.Trim()));

                    codes.TryAdd(className, codeContent);
                    count++;
                }
            }
            catch (Exception ex)
            {
                return new(false, $"Error: {ex.Message}", (newSubmission, codes));
            }
            finally
            {
                Driver.Quit();
            }

            return new(true, "Success", (newSubmission, codes));
        }

        public async Task<Result<byte[]>> TakeScreenshot(string url)
        {
            if (Driver == null)
            {
                return new (false, "Driver is NULL");
            }

            Screenshot screenshot;

            try
            {
                Driver.Navigate().GoToUrl(url);

                Thread.Sleep(5000);

                ITakesScreenshot? screenshotDriver = Driver as ITakesScreenshot;

                if (screenshotDriver == null)
                {
                    return new (false, "Screenshot driver is NULL");
                }

                screenshot = screenshotDriver.GetScreenshot();
            }
            catch (Exception ex)
            {
                return new (false, ex.Message);
            }
            finally
            {
                Driver.Quit();
            }
            
            return new (true, "Success", screenshot.AsByteArray);
        }

        /*
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
        /*
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
*/

        /*
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
        */
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