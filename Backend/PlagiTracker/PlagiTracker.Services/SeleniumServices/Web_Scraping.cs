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

        public void StartScraping()
        {
            try
            {
                // Generar una nueva carpeta con un nombre único basado en la fecha y hora actuales (modificar para que se ajuste a la distribucion de tus discos y carpetas)
                string baseDirectory = @"D:\WS Text\Codigo";
                string timestamp = DateTime.Now.ToString("yyyyMMdd_HHmmss");
                string newDirectory = Path.Combine(baseDirectory, $"Codigo_{timestamp}");

                //Nos aseguramos que la carpeta fue creada y existe
                Directory.CreateDirectory(newDirectory);

                Thread.Sleep(1000);
                driver.Navigate().GoToUrl("https://www.codiva.io/p/dbc162b6-5afe-46bf-b4b3-ee42f11c37c3");
                Thread.Sleep(1000);

                // Encuentra todos los elementos <label> con el título de la clase
                var labels = driver.FindElements(By.XPath("//label[starts-with(@for, 'tab-java-')]"));

                foreach (var label in labels)
                {
                    //Obtenemos el nombre de las "n" clases que hay en el compilador online codiva
                    string className = label.GetAttribute("title");

                    //Selecciona la clase por su nombre si es que hay más de una
                    var tabElement = driver.FindElement(By.XPath($"//label[@title='{className}']"));
                    tabElement.Click();
                    Thread.Sleep(1000);

                    //Chapa el codigo de la clase
                    var codeElements = driver.FindElements(By.XPath("//div[contains(@class, 'CodeMirror-code')]//pre"));

                    //Genera una ruta de archivo única dentro de la nueva carpeta con la extensión .txt
                    string filePath = Path.Combine(newDirectory, $"{className}.txt");

                    //Con StreamWriter se escribe el texto de cada elemento en el archivo que llevara el nombre de la clase que se chapo antes con Selenium
                    using (StreamWriter writer = new StreamWriter(filePath))
                    {
                        foreach (var codeElement in codeElements)
                        {
                            writer.WriteLine(codeElement.Text); //Escribre el texto de cada elemento en el archivo que llevara el nombre de la clase que se chapo antes con Selenium
                        }
                    }

                    Console.WriteLine($"Scraping terminado y código guardado en el archivo: {filePath}");
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
            scraper.StartScraping();
            Console.WriteLine("Scraping Terminado.");
        }
    }
}
