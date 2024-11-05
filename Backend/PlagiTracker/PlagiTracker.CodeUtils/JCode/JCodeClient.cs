using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;
using PlagiTracker.CodeUtils.JCode.Responses;

namespace PlagiTracker.CodeUtils.JCode
{
    public class JCodeClient
    {
        private const string URL_BASE = "http://127.0.0.1:8088";

        public static async Task<JCodeResponse> Execute(string code)
        {
            var client = new HttpClient();
            var request = new HttpRequestMessage(HttpMethod.Post, $"{URL_BASE}/analizar");
            var content = new StringContent(code, null, "application/json");
            request.Content = content;
            var response = await client.SendAsync(request);
            response.EnsureSuccessStatusCode();

            // Procesar la respuesta
            if (response.IsSuccessStatusCode)
            {
                string responseData = await response.Content.ReadAsStringAsync();

                var result = JsonConvert.DeserializeObject<JCodeResponse>(responseData);

                if (result == null)
                {
                    return new();
                }

                return result;
            }
            else
            {
                Console.WriteLine($"Error: {response.StatusCode}");
                return new();
            }
        }
    }
}