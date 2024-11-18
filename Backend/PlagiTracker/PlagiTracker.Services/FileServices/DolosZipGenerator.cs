// Ignore Spelling: Dolos

using PlagiTracker.Analyzer.Dolos;
using System;
using System.Collections.Generic;
using System.IO.Compression;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PlagiTracker.Services.FileServices
{
    public class DolosZipGenerator
    {
        private static readonly string DownloadPath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, @"Dolos\");

        public static async Task<string> GenerateAssignmentFolder(Guid assignmentId, Dictionary<Guid, List<(string fileName, string content)>> studentFiles)
        {
            string assignmentFolder = Path.Combine(DownloadPath, $"Assignment-{assignmentId}");
            Directory.CreateDirectory(assignmentFolder);

            foreach (var student in studentFiles)
            {
                string studentFolder = Path.Combine(assignmentFolder, $"Student-{student.Key}");
                Directory.CreateDirectory(studentFolder);

                foreach (var file in student.Value)
                {
                    string filePath = Path.Combine(studentFolder, $"{file.fileName}");
                    File.WriteAllText(filePath, file.content);
                }
            }

            string zipFilePath = Path.Combine(DownloadPath, $"Assignment-{assignmentId}.zip");
            ZipFile.CreateFromDirectory(assignmentFolder, zipFilePath);

            return await DolosUpLoader.UploadZipToDolos(zipFilePath);

            // Optionally, delete the original folder after zipping
            //Directory.Delete(assignmentFolder, true);
        }
    }
}
