﻿using OpenQA.Selenium;
using PlagiTracker.Analyzer;
using Newtonsoft.Json;
using PlagiTracker.Services.FileServices;
using OpenQA.Selenium.Firefox;


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

        public async Task<bool> UrlExists(string url)
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
            return url.Contains("codiva.io");
        }

        public async Task<PdfSharpCore.Pdf.PdfDocument> StartScraping(List<string> urls)
        {

            PdfSharpCore.Pdf.PdfDocument document = null;
            var jsonData = new Dictionary<string, List<Dictionary<string, string>>>();
            var allResults = new List<(int coincidencias, string nombre1, string nombre2, string usuarioId1, string usuarioId2, double jaccard, double levenshtein, double semantica)>();

            var ignorePatterns = new List<string>
            {
                "System.out.println(\"Hello Codiva\");"
            };

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

                    driver.Navigate().GoToUrl(url);
                    Thread.Sleep(1000);

                    var labels = driver.FindElements(By.XPath("//label[starts-with(@for, 'tab-java-')]"));
                    string studentId = Guid.NewGuid().ToString();

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
                        Console.WriteLine($"Scraping terminado para {className}");
                    }

                    if (studentFiles.Count > 0)
                    {
                        jsonData[studentId] = studentFiles;
                        Console.WriteLine($"Scraping completo para la URL: {url}");

                        // Procesar los resultados
                        Consumidor consumidor = new Consumidor();
                        var resultados = await consumidor.Ejecutar(jsonData);

                        // Agregar los resultados a la lista
                        allResults.AddRange(resultados);
                    }
                }

                // Ahora procesamos todos los resultados
                if (allResults.Count > 0)
                {
                    foreach (var resultado in allResults)
                    {
                        // Imprimir los resultados individualmente
                        Console.WriteLine($"Respuesta del servidor:");
                        Console.WriteLine($"Coincidencias: {resultado.coincidencias}");
                        Console.WriteLine($"Estudiante 1: {resultado.nombre1}");
                        Console.WriteLine($"Estudiante 2: {resultado.nombre2}");
                        Console.WriteLine($"Usuario ID 1: {resultado.usuarioId1}");
                        Console.WriteLine($"Usuario ID 2: {resultado.usuarioId2}");
                        Console.WriteLine($"Similitud Jaccard: {resultado.jaccard}%");
                        Console.WriteLine($"Similitud Levenshtein: {resultado.levenshtein}");
                        Console.WriteLine($"Similitud Semántica: {resultado.semantica}%");
                    }

                    var reportData = new
                    {
                        comparaciones_entre_ids = allResults.Select(r => new
                        {
                            r.usuarioId1,
                            r.usuarioId2,
                            r.coincidencias,
                            r.jaccard,
                            r.levenshtein,
                            r.semantica,
                            r.nombre1,
                            r.nombre2
                        }).ToArray()
                    };

                    string jsonResponse = JsonConvert.SerializeObject(reportData);
                    Console.WriteLine("JSON Generado: " + jsonResponse); // Imprimir el JSON para revisar la estructura

                    document = ReportGenerator.GenerateReport(jsonResponse); // Llamada para generar el PDF
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
    }

    internal class Program
    {
        static async Task Main(string[] args)
        {
            WebScraping scraper = new WebScraping();
            List<string> urls = new List<string>
            {
                "https://www.codiva.io/p/dbc162b6-5afe-46bf-b4b3-ee42f11c37c3",
                "https://www.codiva.io/p/valid-url",
                "https://www.codiva.io/p/dbc162b6-5afe-46bf-b4b3-ee42f11c37c3",
                "https://www.codiva.io/p/dbc162b6-5afe-46bf-b4b3-ee42f11c37c3",
                "https://www.codiva.io/p/dbc162b6-5afe-46bf-b4b3-ee42f11c37c3",
            };

            await scraper.StartScraping(urls); // Llama al método sin asignar a una variable
            Console.WriteLine("Resultado del análisis:");

            // Generar el reporte
            ReportGenerator reportGenerator = new ReportGenerator();

            Console.WriteLine("Scraping completado y reporte generado.");
            // Aquí puedes manejar los resultados de la tupla si es necesario
        }
    }
}