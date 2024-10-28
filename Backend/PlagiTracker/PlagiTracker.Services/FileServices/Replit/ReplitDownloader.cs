// Ignore Spelling: Replit Downloader

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PlagiTracker.Services.FileServices.Replit
{
    public class ReplitDownloader
    {


        public static async Task<bool> DownloadAsync(string url)
        {
            // Obtener la ruta base del proyecto
            string baseDirectory = AppDomain.CurrentDomain.BaseDirectory;

            // Combinar la ruta base con la ruta relativa
            string downloadPath = Path.Combine(baseDirectory, @"Downloads\file.zip");

            if(string.IsNullOrEmpty(downloadPath))
            {
                return false;
            }

            // Crear el directorio si no existe
            string directory = Path.GetDirectoryName(downloadPath);

            if (string.IsNullOrEmpty(directory) || !Directory.Exists(directory))
            {
                Directory.CreateDirectory(directory);
            }

            using HttpClient client = new ();
            using HttpResponseMessage response = await client.GetAsync(url);
            response.EnsureSuccessStatusCode();

            using Stream contentStream = await response.Content.ReadAsStreamAsync();
            using FileStream fileStream = new (downloadPath, FileMode.Create, FileAccess.Write, FileShare.None, 8192, true);
            await contentStream.CopyToAsync(fileStream);

            return true;
        }
    }
}