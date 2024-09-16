using OpenQA.Selenium.Chrome;
using OpenQA.Selenium;

namespace PlagiTracker.Services.SeleniumServices
{
    internal class Web_Scraping
    {
        private IWebDriver driver;
        private int folderCounter = 1;


        public Web_Scraping()
        {
            //Esta parte se tiene que modificar dependiendo de la ubicación del chromedriver y dependiendo de la versión de Chrome que tengas instalada (en mi caso es el 128) 
            var chromeDriverService = ChromeDriverService.CreateDefaultService(@"C:\Users\Luis\Downloads\Chrome Selenium\chromedriver-win64 (2)\chromedriver-win64");
            chromeDriverService.HideCommandPromptWindow = false;

            var options = new ChromeOptions();
            options.AddArgument("--disable-usb");
            options.AddArgument("--user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36");  // User-Agent
            options.AddExcludedArgument("enable-automation");
            options.AddAdditionalOption("useAutomationExtension", false);

            driver = new ChromeDriver(chromeDriverService, options);
        }

        public void StartScraping(List<string> urls)
        {
            try
            {
                foreach (var url in urls)
                {
                    // Generar una nueva carpeta para cada URL con un nombre único
                    string baseDirectory = @"D:\WS Text\Codigo";
                    string timestamp = DateTime.Now.ToString("yyyyMMdd_HHmmss");
                    string newDirectory = Path.Combine(baseDirectory, $"Codigo_{timestamp}");

                    // Nos aseguramos de que la carpeta fue creada
                    Directory.CreateDirectory(newDirectory);

                    
                    driver.Navigate().GoToUrl(url);
                    Thread.Sleep(800);

                    // Encuentra todos los elementos <label> con el título de la clase
                    var labels = driver.FindElements(By.XPath("//label[starts-with(@for, 'tab-java-')]"));

                    foreach (var label in labels)
                    {
                        // Obtenemos el nombre de las clases
                        string className = label.GetAttribute("title");

                        // Selecciona la clase por su nombre
                        var tabElement = driver.FindElement(By.XPath($"//label[@title='{className}']"));
                        tabElement.Click();

                        // Extrae el código de la clase
                        var codeElements = driver.FindElements(By.XPath("//div[contains(@class, 'CodeMirror-code')]//pre"));

                        // Genera una ruta de archivo única dentro de la nueva carpeta
                        string filePath = Path.Combine(newDirectory, $"{className}.txt");

                        // Escribe el código en el archivo
                        using (StreamWriter writer = new StreamWriter(filePath))
                        {
                            foreach (var codeElement in codeElements)
                            {
                                writer.WriteLine(codeElement.Text);
                            }
                        }

                        Console.WriteLine($"Scraping terminado para {className} y código guardado en el archivo: {filePath}");
                    }

                    Console.WriteLine($"Scraping completo para la URL: {url}");
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
        }
    }

    internal class Program
    {
        static void Main(string[] args)
        {
            Web_Scraping scraper = new Web_Scraping();
            List<string> urls = new List<string>
            {
                "https://www.codiva.io/p/dbc162b6-5afe-46bf-b4b3-ee42f11c37c3",
                "https://www.codiva.io/p/20816608-16ad-45ca-b812-9406105efbc3",
                                "https://www.codiva.io/p/dbc162b6-5afe-46bf-b4b3-ee42f11c37c3",
                "https://www.codiva.io/p/20816608-16ad-45ca-b812-9406105efbc3",
                "https://www.codiva.io/p/dbc162b6-5afe-46bf-b4b3-ee42f11c37c3",
                "https://www.codiva.io/p/20816608-16ad-45ca-b812-9406105efbc3"

                // Agrega más URLs si es necesario
            };

            // Llamas al método StartScraping pasándole la lista de URLs
            scraper.StartScraping(urls);
        }
    }
}
