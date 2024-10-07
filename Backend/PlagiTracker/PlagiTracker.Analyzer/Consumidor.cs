using System.Text;
using System.Text.Json;
using Newtonsoft.Json;
using PlagiTracker.Analyzer.PlagiDetector;

namespace PlagiTracker.Analyzer
{
    public class Consumidor
    {
        public async Task<PlagiaPythonResult> Ejecutar(Dictionary<string, List<Dictionary<string, string>>> studentFiles)
        {
            using (HttpClient client = new HttpClient())
            {
                // Convertir los datos de scraping a JSON
                
                var data = new Dictionary<string, object>();

                foreach (var student in studentFiles)
                {
                    data[student.Key] = student.Value;
                }
                
                // Serializar el JSON
                string jsonData = System.Text.Json.JsonSerializer.Serialize(data);
                StringContent content = new StringContent(jsonData, Encoding.UTF8, "application/json");

                // Enviar la solicitud POST
                HttpResponseMessage response = await client.PostAsync("http://127.0.0.1:9500/comparar", content);

                // Procesar la respuesta
                if (response.IsSuccessStatusCode)
                {
                    string responseData = await response.Content.ReadAsStringAsync();
                    
                    var result = JsonConvert.DeserializeObject<PlagiaPythonResult>(responseData);

                    if(result == null)
                    {
                        return new();
                    }

                    return result;
                }
                else
                {
                    Console.WriteLine($"Error en la solicitud: { response.StatusCode }");
                    return new();
                }
            }
        }
    }
}