using OpenQA.Selenium.Firefox;
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
    public class Web_Scraping
    {
        private IWebDriver driver;

        /// <summary>
        /// Constructor de la clase Web_Scraping que inicializa el driver de Chrome con las opciones necesarias para el scraping
        /// </summary>
        public Web_Scraping()
        {
            //var chromeDriverService = FirefoxDriverService.CreateDefaultService(@"C:\Users\Luis\Downloads\Chrome Selenium\chromedriver-win64 (2)\chromedriver-win64");
            //chromeDriverService.HideCommandPromptWindow = false;
            var options = new FirefoxOptions();

            options.AddArgument("--disable-usb");
            options.AddArgument("--headless");

            options.AddArgument("--user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36");
            //options.AddExcludedArgument("enable-automation");
            options.AddAdditionalOption("useAutomationExtension", false);

            driver = new FirefoxDriver(options);
        }
        //Funcion que verifica si la url es valida para el scraping para evitar errores
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
        //Funcion que verifica si la url es de codiva
        public bool IsCodivaUrl(string url)
        {
            return url.Contains("codiva.io");
        }
        /// <summary>
        /// Funcion que inicia el scraping de las urls proporcionadas y guarda los datos en un archivo jsoN (Esto es de prueba solo para ver como bota el JSON)
        /// </summary>
        /// <param name="urls">asdasd</param>
        /// <returns>asdasdasd</returns>
        public async Task<Dictionary<string, List<Dictionary<string, string>>>> StartScraping(List<string> urls)
        {
            Stopwatch sw = new Stopwatch();
            sw.Start();

            var jsonData = new Dictionary<string, List<Dictionary<string, string>>>();

            // Contenidos que deseas ignorar (puedes ajustarlo si encuentras más casos similares)
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
                    string studentId = Guid.NewGuid().ToString(); // Usarás el identificador correcto para cada alumno

                    var studentFiles = new List<Dictionary<string, string>>();

                    foreach (var label in labels)
                    {
                        string className = label.GetAttribute("title");
                        var tabElement = driver.FindElement(By.XPath($"//label[@title='{className}']"));
                        tabElement.Click();

                        // Esperar un poco para asegurar que el contenido se haya actualizado
                        Thread.Sleep(1000);

                        var codeElements = driver.FindElements(By.XPath("//div[contains(@class,'CodeMirror-code')]//pre"));
                        string codeContent = string.Join("\n", codeElements.Select(e => e.Text).Select(c => c.Trim()));

                        // Comprobar si el contenido contiene patrones que debemos ignorar
                        bool containsIgnoredPattern = ignorePatterns.Any(pattern => codeContent.Contains(pattern));
                        if (containsIgnoredPattern)
                        {
                            Console.WriteLine($"Archivo {className}.java ignorado debido a contenido irrelevante.");
                            continue; // Omitir este archivo y continuar con el siguiente
                        }

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
                    //string jsonOutput = JsonConvert.SerializeObject(jsonData, Formatting.Indented);
                    //string jsonFilePath = @"D:\WS Text\Codigo\codigos.json";
                    //File.WriteAllText(jsonFilePath, jsonOutput);
                    //Console.WriteLine($"Datos guardados en formato JSON en: {jsonFilePath}");
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
            return jsonData;
        }


    }
    
    internal class Program
    {
        
        static async Task Main(string[] args)
        {
            //Falta solucionar que cuando encuentre una url que no es no genere su json vacio
            //Funcion que inicia el scraping de las urls proporcionadas y guarda los datos en un archivo jsoN (Esto es de prueba solo para ver como bota el JSON)
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
