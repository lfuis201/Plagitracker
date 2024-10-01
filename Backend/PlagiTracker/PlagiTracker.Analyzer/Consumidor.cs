using System;
using System.Net.Http;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;
using System.Collections.Generic;
using PlagiTracker.Analyzer.PlaginDetector;

namespace PlagiTracker.Analyzer
{
    public class Consumidor
    {
        public async Task<List<(int coincidencias, string nombre1, string nombre2, string usuarioId1, string usuarioId2, double jaccard, double levenshtein, double semantica)>> Ejecutar(Dictionary<string, List<Dictionary<string, string>>> studentFiles)
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
                    var resultado = JsonSerializer.Deserialize<Dictionary<string, List<Dictionary<string, JsonElement>>>>(responseData, opcionesJson);

                    // Lista para almacenar todos los resultados
                    var resultados = new List<(int coincidencias, string nombre1, string nombre2, string usuarioId1, string usuarioId2, double jaccard, double levenshtein, double semantica)>();

                    // Verificar que contenga la clave 'comparaciones_entre_ids'
                    if (resultado.TryGetValue("comparaciones_entre_ids", out var comparaciones) && comparaciones.Count > 0)
                    {
                        // Iterar sobre todas las comparaciones
                        foreach (var comparacion in comparaciones)
                        {
                            // Extraer los datos necesarios
                            int coincidencias = comparacion["coincidencias"].GetInt32();
                            string nombre1 = comparacion["nombre1"].GetString();
                            string nombre2 = comparacion["nombre2"].GetString();
                            string usuarioId1 = comparacion["usuario_id1"].GetString();
                            string usuarioId2 = comparacion["usuario_id2"].GetString();
                            double similitudJaccard = comparacion["similitud_jaccard"].GetDouble();
                            double similitudLevenshtein = comparacion["similitud_levenshtein"].GetDouble();
                            double similitudSemantica = comparacion["similitud_semantica"].GetDouble();

                            // Aplicar los detectores
                            Detector detector = new Detector(similitudJaccard, similitudLevenshtein, similitudSemantica);

                            // Añadir el resultado a la lista
                            resultados.Add((
                                coincidencias,
                                nombre1,
                                nombre2,
                                usuarioId1,
                                usuarioId2,
                                detector.Jaccard.Jaccard,
                                detector.Levenshtein.Levenshtein,
                                detector.Semantica.Semantica
                            ));
                        }

                        // Retornar la lista de resultados
                        return resultados;
                    }
                    else
                    {
                        Console.WriteLine("No se encontraron comparaciones en la respuesta.");
                        return new List<(int, string, string, string, string, double, double, double)>();
                    }
                }
                else
                {
                    Console.WriteLine($"Error en la solicitud: {response.StatusCode}");
                    return new List<(int, string, string, string, string, double, double, double)>();
                }
            }
        }
    }
}