using OpenQA.Selenium.Chrome;
using OpenQA.Selenium;
using System.Diagnostics;
using PlagiTracker.Services.Reportes;
using System;
using System.Collections.Generic;
using System.IO;
using System.Net.Http;
using System.Threading;
using System.Threading.Tasks;
using Newtonsoft.Json;

namespace PlagiTracker.Services.SeleniumServices
{
    internal class Web_Scraping
    {
        private IWebDriver driver;

        public Web_Scraping()
        {
            var chromeDriverService = ChromeDriverService.CreateDefaultService(@"C:\Users\Luis\Downloads\Chrome Selenium\chromedriver-win64 (2)\chromedriver-win64");
            chromeDriverService.HideCommandPromptWindow = false;
            var options = new ChromeOptions();

            options.AddArgument("--disable-usb");
            options.AddArgument("--headless");

            options.AddArgument("--user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36");
            options.AddExcludedArgument("enable-automation");
            options.AddAdditionalOption("useAutomationExtension", false);

            driver = new ChromeDriver(chromeDriverService, options);
        }

        private async Task<bool> UrlExists(string url)
        {
            try
            {
                using (HttpClient client = new HttpClient())
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

        public bool IsCodivaUrl(string url)
        {
            // Verifica si la URL contiene "codiva.io"
            return url.Contains("codiva.io");
        }

        public async Task StartScraping(List<string> urls)
        {
            Stopwatch sw = new Stopwatch();
            sw.Start();

            var jsonData = new Dictionary<string, List<Dictionary<string, string>>>();

            try
            {
                foreach (var url in urls)
                {
                    if (!IsCodivaUrl(url))
                    {
                        Console.WriteLine($"La URL {url} no es de Codiva y se omitirá.");
                        continue;
                    }

                    bool urlValida = await UrlExists(url);

                    if (!urlValida)
                    {
                        Console.WriteLine($"La URL {url} no es válida. Se omitirá.");
                        continue;
                    }

                    // Si la URL es válida y es de Codiva, proceder con el scraping
                    driver.Navigate().GoToUrl(url);
                    Thread.Sleep(1400);

                    var labels = driver.FindElements(By.XPath("//label[starts-with(@for, 'tab-java-')]"));
                    string studentId =Guid.NewGuid().ToString(); 

                    var studentFiles = new List<Dictionary<string, string>>();

                    foreach (var label in labels)
                    {
                        string className = label.GetAttribute("title");
                        var tabElement = driver.FindElement(By.XPath($"//label[@title='{className}']"));
                        tabElement.Click();

                        var codeElements = driver.FindElements(By.XPath("//div[contains(@class,'CodeMirror-code')]//pre"));
                        string codeContent = string.Join("\n", codeElements.Select(e => e.Text));

                        var fileData = new Dictionary<string, string>
                {
                    { "nombre", $"{className}.java" },
                    { "contenido", codeContent }
                };

                        studentFiles.Add(fileData);
                        Console.WriteLine($"Scraping terminado para {className}");
                    }

                    // Añadir los datos solo si se obtuvieron archivos de código
                    if (studentFiles.Count > 0)
                    {
                        jsonData[studentId] = studentFiles;
                        Console.WriteLine($"Scraping completo para la URL: {url}");
                    }
                }

                if (jsonData.Count > 0)
                {
                    string jsonOutput = JsonConvert.SerializeObject(jsonData, Formatting.Indented);
                    string jsonFilePath = @"D:\WS Text\Codigo\codigos.json";
                    File.WriteAllText(jsonFilePath, jsonOutput);
                    Console.WriteLine($"Datos guardados en formato JSON en: {jsonFilePath}");
                }
                else
                {
                    Console.WriteLine("No se encontró código válido para las URLs proporcionadas.");
                }

                sw.Stop();
                Console.WriteLine("Tiempo transcurrido: {0}", sw.Elapsed.ToString("hh\\:mm\\:ss\\.fff"));
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error: " + ex.Message);
            }
            finally
            {
                driver.Quit();
            }
        }
    }

    internal class Program
    {
        static async Task Main(string[] args)
        {
            //Falta solucionar que cuando encuentre una url que no es no genere su json vacio
            Web_Scraping scraper = new Web_Scraping();
            List<string> urls = new List<string>
            {
                "https://www.codiva.io/p/dbc162b6-5afe-46bf-b4b3-ee42f11c37c3",
                "https://www.invalid-url.com",  
                "https://www.youtube.com/watch?v=TpNDSyDnUwc", 
                "https://www.codiva.io/p/valid-url", 
                "https://www.codiva.io/p/dbc162b6-5afe-46bf-b4b3-ee42f11c37c3",
                "https://www.codiva.io/p/dbc162b6-5afe-46bf-b4b3-ee42f11c37c3",
                "https://www.codiva.io/p/dbc162b6-5afe-46bf-b4b3-ee42f11c37c3",
                "https://www.codiva.io/p/dbc162b6-5afe-46bf-b4b3-ee42f11c37c3",
                "https://www.codiva.io/p/dbc162b6-5afe-46bf-b4b3-ee42f11c37c3",
                "https://www.codiva.io/p/dbc162b6-5afe-46bf-b4b3-ee42f11c37c3",
                "https://classroom.google.com/c/NzA0MDM0NzM0MzYy",
                "https://www.codiva.io/p/dbc162b6-5afe-46bf-b4b3-ee42f11c37c3",
                "https://www.codiva.io/p/dbc162b6-5afe-46bf-b4b3-ee42f11c37c3",
                "https://chatgpt.com/c/66e8b455-d26c-8005-90e1-7fbb273e3801",
                "https://classroom.google.com/c/NzA0MDM0NzM0MzYy",
                "https://www.fundeu.es/recomendacion/colaboracion-posible-alternativa-a-featuring/",

            };

            await scraper.StartScraping(urls);

            ReporteScraping reporte = new ReporteScraping();
          
        }
    }
}
