// Ignore Spelling: Dolos

using PlagiTracker.Analyzer.Dolos;
using PlagiTracker.Data;
using PlagiTracker.Data.Entities;
using System.IO.Compression;
using System.Text.RegularExpressions;

namespace PlagiTracker.Services.FileServices
{
    public class DolosZipGenerator
    {
        private static readonly string DownloadPath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, @"Dolos\");

        public static string SanitizeFolderName(string studentFullName)
        {
            // Obtener los caracteres inválidos para nombres de carpetas
            char[] invalidChars = Path.GetInvalidPathChars();

            // Reemplazar los caracteres inválidos con un guion bajo
            foreach (char invalidChar in invalidChars)
            {
                studentFullName = studentFullName.Replace(invalidChar, '_');
            }

            // Se usa un regex para eliminar cualquier otro carácter no deseado
            studentFullName = Regex.Replace(studentFullName, @"[^a-zA-Z0-9_\- ]", "_");

            return studentFullName;
        }

        public static async Task<Result<DolosResponse>> GenerateAssignmentFolder(Assignment assignment, Dictionary<string , List<(string fileName, string content)>> studentFiles)
        {
            try
            {
                string assignmentFolder = Path.Combine(DownloadPath, $"Assignment-{assignment.Id}");
                Directory.CreateDirectory(assignmentFolder);

                foreach (var student in studentFiles)
                {
                    string folderName = SanitizeFolderName(student.Key);
                    string studentFolder = Path.Combine(assignmentFolder, $"{folderName}");
                    Directory.CreateDirectory(studentFolder);

                    foreach (var file in student.Value)
                    {
                        string fileName = file.fileName;

                        if (!fileName.EndsWith(".java"))
                        {
                            fileName += ".java";
                        }

                        string filePath = Path.Combine(studentFolder, $"{fileName}");
                        File.WriteAllText(filePath, file.content);
                    }
                }

                string zipFilePath = Path.Combine(DownloadPath, $"Assignment-{assignment.Id}.zip");
                ZipFile.CreateFromDirectory(assignmentFolder, zipFilePath);

                var result = await DolosUpLoader.UploadZipToDolos(assignment, zipFilePath);
                
                // Elimina la carpeta y el archivo zip
                Directory.Delete(assignmentFolder, true);
                File.Delete(zipFilePath);

                if (result == null)
                {
                    return new(false, $"There was a problem with the fetch operation");
                }
                else if (!result.Success)
                {
                    return new(false, result.Message);
                }
                
                return result;
            }
            catch (Exception ex)
            {
                return new(false, $"There was a problem with the fetch operation: {ex.Message}");
            }
        }
    }
}