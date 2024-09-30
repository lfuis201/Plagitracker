using System;
using System.Net.Http;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;
using System.Collections.Generic;
using PlagiTracker.Analyzer.PlaginDetector;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace PlagiTracker.Analyzer
{
    public class Consumidor
    {
        public async Task<(int coincidencias, string nombre1, string nombre2, string usuarioId1, string usuarioId2, double jaccard, double levenshtein, double semantica)> Ejecutar(Dictionary<string, List<Dictionary<string, string>>> studentFiles)
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

                    // Deserializar la respuesta JSON a un diccionario
                    var opcionesJson = new JsonSerializerOptions { PropertyNameCaseInsensitive = true };
                    var resultado = JsonSerializer.Deserialize<Dictionary<string, object>>(responseData, opcionesJson);

                    // Extraer los datos que necesitamos
                    int coincidencias = Convert.ToInt32(resultado["coincidencias"]);
                    string nombre1 = resultado["nombre1"].ToString();
                    string nombre2 = resultado["nombre2"].ToString();
                    string usuarioId1 = resultado["usuario_id1"].ToString();
                    string usuarioId2 = resultado["usuario_id2"].ToString();
                    double similitudJaccard = Convert.ToDouble(resultado["similitud_jaccard"]);
                    double similitudLevenshtein = Convert.ToDouble(resultado["similitud_levenshtein"]);
                    double similitudSemantica = Convert.ToDouble(resultado["similitud_semantica"]);

                    // Crear y retornar un objeto de Detector y extraer los resultados formateados
                    Detector detector = new Detector(similitudJaccard, similitudLevenshtein, similitudSemantica);

                    // Devolver los valores de los algoritmos procesados y los otros datos
                    return (
                        coincidencias,
                        nombre1,
                        nombre2,
                        usuarioId1,
                        usuarioId2,
                        detector.Jaccard.Jaccard,
                        detector.Levenshtein.Levenshtein,
                        detector.Semantica.Semantica
                    );
                }
                else
                {
                    Console.WriteLine($"Error en la solicitud: {response.StatusCode}");
                    return (0, null, null, null, null, 0, 0, 0);
                }
            }
        }
    }
}
