using Newtonsoft.Json;
using PlagiTracker.Data;

namespace PlagiTracker.Services.GitHubServices
{
    public class GitHubCodeExtractor
    {
        public static async Task<Result<List<GitHubContent>>> GetCodes(string url)
        {
            string userAgent = "YourAppName"; // GitHub requiere un User-Agent válido
            using (HttpClient client = new HttpClient())
            {
                client.DefaultRequestHeaders.Add("User-Agent", userAgent);

                try
                {
                    if (url.Contains("/blob/"))
                    {
                        // Es un archivo único
                        string rawUrl = url.Replace("github.com", "raw.githubusercontent.com").Replace("/blob/", "/");
                        string fileContent = await client.GetStringAsync(rawUrl);
                        Console.WriteLine($"File: {rawUrl}");
                        Console.WriteLine(fileContent);
                        Console.WriteLine(new string('-', 80));
                        return new(true, "Success", [ new() ]);
                    }
                    else if (url.Contains("/tree/"))
                    {
                        // Es una carpeta
                        string apiUrl = url.Replace("github.com", "api.github.com/repos").Replace("/tree/", "/contents/");
                        
                        Console.WriteLine(apiUrl);
                        HttpResponseMessage response = await client.GetAsync(apiUrl);
                        response.EnsureSuccessStatusCode();
                        string content = await response.Content.ReadAsStringAsync();

                        List<GitHubContent> files = JsonConvert.DeserializeObject<List<GitHubContent>>(content)!;

                        foreach (var file in files)
                        {
                            if (file.Type == "file" /*&& file.Name.EndsWith(".cs")*/)
                            {
                                string fileContent = await client.GetStringAsync(file.DownloadUrl);
                                Console.WriteLine($"File: {file.Name}");
                                Console.WriteLine(fileContent);
                                Console.WriteLine(new string('-', 80));
                            }
                        }

                        return new(true, "Success", files);
                    }

                    return new(false, "Invalid URL");
                }
                catch (HttpRequestException e)
                {
                    return new(false, $"Request Error - {e.Message}");
                }
            }
        }
    }

    public class GitHubContent
    {
        public string Name { get; set; }
        public string Path { get; set; }
        public string Sha { get; set; }
        public int Size { get; set; }
        public string Url { get; set; }
        public string HtmlUrl { get; set; }
        public string GitUrl { get; set; }
        public string DownloadUrl { get; set; }
        public string Type { get; set; }
    }
}