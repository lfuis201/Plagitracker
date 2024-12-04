// Ignore Spelling: Dolos

using Newtonsoft.Json;
using PlagiTracker.Data;
using PlagiTracker.Data.Entities;
using System.Net.Http.Headers;

namespace PlagiTracker.Analyzer.Dolos
{
    public class DolosUpLoader
    {
        public static async Task<Result<DolosResponse>> UploadZipToDolos(Assignment assignment, string zipFilePath)
        {
            if (!File.Exists(zipFilePath))
            {
                return new (false, $"The zip file {zipFilePath} does not exist.");
            }

            using (var httpClient = new HttpClient())
            {
                using (var formData = new MultipartFormDataContent())
                {
                    formData.Add(new StringContent($"{assignment.Course!.Name} - {assignment.Title}"), "dataset[name]");
                    var fileContent = new ByteArrayContent(File.ReadAllBytes(zipFilePath));
                    fileContent.Headers.ContentType = MediaTypeHeaderValue.Parse("application/zip");
                    formData.Add(fileContent, "dataset[zipfile]", Path.GetFileName(zipFilePath));

                    try
                    {
                        var response = await httpClient.PostAsync("https://dolos.ugent.be/api/reports", formData);

                        if (!response.IsSuccessStatusCode)
                        {
                            return new (false, "Network response was not ok");
                        }

                        var responseData = await response.Content.ReadAsStringAsync();
                        var dolosResponse = JsonConvert.DeserializeObject<DolosResponse>(responseData);

                        if (dolosResponse == null)
                        {
                            return new (false, "Dolos response is NULL");
                        }

                        return new (true, $"Success", dolosResponse);
                    }
                    catch (Exception ex)
                    {
                        return new (false, $"There was a problem with the fetch operation: {ex.Message}");
                    }
                }
            }
        }
    }
}