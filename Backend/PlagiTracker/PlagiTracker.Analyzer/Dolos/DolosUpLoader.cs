// Ignore Spelling: Dolos

using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;

namespace PlagiTracker.Analyzer.Dolos
{
    public class DolosUpLoader
    {
        public static async Task<string> UploadZipToDolos(string zipFilePath)
        {
            if (!File.Exists(zipFilePath))
            {
                throw new FileNotFoundException("The zip file does not exist.", zipFilePath);
            }

            using (var httpClient = new HttpClient())
            {
                using (var formData = new MultipartFormDataContent())
                {
                    formData.Add(new StringContent("Example"), "dataset[name]");
                    var fileContent = new ByteArrayContent(File.ReadAllBytes(zipFilePath));
                    fileContent.Headers.ContentType = MediaTypeHeaderValue.Parse("application/zip");
                    formData.Add(fileContent, "dataset[zipfile]", Path.GetFileName(zipFilePath));

                    try
                    {
                        var response = await httpClient.PostAsync("https://dolos.ugent.be/api/reports", formData);

                        if (!response.IsSuccessStatusCode)
                        {
                            throw new Exception("Network response was not ok");
                        }

                        var data = await response.Content.ReadAsStringAsync();
                        //Console.WriteLine("Report URL: " + data.html_url);
                        return data;
                    }
                    catch (Exception ex)
                    {
                        Console.Error.WriteLine("There was a problem with the fetch operation: " + ex.Message);
                        throw;
                    }
                }
            }
        }
    }
}
