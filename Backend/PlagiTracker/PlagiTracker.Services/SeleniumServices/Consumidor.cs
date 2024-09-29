using System;
using System.Net.Http;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;
using System.Collections.Generic;

namespace PlagiTracker
{
    public class Consumidor
    {
        public async Task<string> Ejecutar(Dictionary<string, List<Dictionary<string, string>>> studentFiles)
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
                string jsonData = JsonSerializer.Serialize(data);
                StringContent content = new StringContent(jsonData, Encoding.UTF8, "application/json");

                // Enviar la solicitud POST
                HttpResponseMessage response = await client.PostAsync("http://127.0.0.1:5000/comparar", content);

                // Procesar la respuesta
                if (response.IsSuccessStatusCode)
                {
                    string responseData = await response.Content.ReadAsStringAsync();
                    Console.WriteLine("Respuesta del servidor: " + responseData);

                    // Aquí puedes devolver la respuesta para procesarla en otro lugar
                    return responseData;
                }
                else
                {
                    Console.WriteLine($"Error en la solicitud: {response.StatusCode}");
                    return null;
                }
            }
        }
    }
}
