using Microsoft.AspNetCore.Mvc.RazorPages;
using Newtonsoft.Json;
using PlagiTracker.Analyzer.PlagiDetector;
using PlagiTracker.Data.DataAccess;
using PlagiTracker.Data.Entities;
using PlagiTracker.Services.SeleniumServices;
using System.Text;
using static PlagiTracker.Data.Entities.Plagiarism;

namespace PlagiTracker.WebAPI.HangFire
{
    public class HangFireServices
    {
        private readonly DataContext _context;

        public HangFireServices(DataContext context)
        {
            _context = context;
        }

        public async Task SavePlagiarismReport(Guid assignmentId, string analysisResultJson, Dictionary<Guid, StudentSubmission> analysisResult)
        {
            if (string.IsNullOrEmpty(analysisResultJson))
            {
                return;
            }

            var analysisResult2 = JsonConvert.DeserializeObject<Dictionary<Guid, StudentSubmission>>(analysisResultJson);

            if(analysisResult == null)
            {
                   return;
            }
            else if(analysisResult.Count == 0 || assignmentId == Guid.Empty || _context == null || _context.Assignments == null)
            {
                return;
            }

            var assignment = await _context.Assignments.FindAsync(assignmentId);

            if (assignment == null)
            {
                return;
            }

            StringBuilder data = new();

            foreach (var studentSubmission in analysisResult.Values)
            {
                if(studentSubmission.Codes == null || studentSubmission.Codes!.Count == 0)
                {
                    continue;
                }
                
                // File name, id
                Dictionary<string, Guid> GuidsForCodes = [];
                
                foreach (var code in studentSubmission.Codes)
                {
                    try {
                        Guid CodeId = Guid.NewGuid();

                        await _context.Codes!.AddAsync(new Code 
                        {
                            Id = CodeId,
                            SubmissionId = studentSubmission.SubmissionId,
                            FileName = code.Key,
                            Content = code.Value 
                        });

                        GuidsForCodes.Add(code.Key, CodeId);
                    } 
                    catch (Exception e)
                    {
                        Console.WriteLine($"Exception ({GetType().Name}): {e.Message}\n");
                    }
                }

                if(GuidsForCodes.Count == 0 || GuidsForCodes == null)
                {
                    continue;
                }

                var sortedStudentSubmission = studentSubmission.PlagiResults.OrderBy(plagiResult => plagiResult.FileName1).ToList();
                foreach (var plagiResult in sortedStudentSubmission)
                {
                    try
                    {
                        /*
                        var Jaccard = Guid.NewGuid();
                        var Levenshtein = Guid.NewGuid();
                        var Semantic = Guid.NewGuid();
                        var Coincidences = Guid.NewGuid();
                        */
                        // Jaccard
                        await _context.Plagiarisms!.AddAsync(new Plagiarism
                        {
                            //Id = Jaccard,
                            Id = Guid.NewGuid(),
                            Similarity = plagiResult.JaccardSimilitude,
                            Algorithm = AlgorithmType.Jaccard,
                            CodeId = GuidsForCodes[plagiResult.FileName1]
                        });

                        //data.Append($"\n{Jaccard} | {AlgorithmType.Jaccard} | {GuidsForCodes[plagiResult.FileName1]}");

                        // Levenshtein
                        await _context.Plagiarisms!.AddAsync(new Plagiarism
                        {
                            //Id = Levenshtein,
                            Id = Guid.NewGuid(),
                            Algorithm = AlgorithmType.Levenshtein,
                            Similarity = plagiResult.LevenshteinSimilitude,
                            CodeId = GuidsForCodes[plagiResult.FileName1]
                        });

                       // data.Append($"\n{Jaccard} | {AlgorithmType.Levenshtein} | {GuidsForCodes[plagiResult.FileName1]}");

                        // Semantic
                        await _context.Plagiarisms!.AddAsync(new Plagiarism
                        {
                           // Id = Semantic,
                           Id = Guid.NewGuid(),
                            Algorithm = AlgorithmType.Semantic,
                            Similarity = plagiResult.SemanticSimilitude,
                            CodeId = GuidsForCodes[plagiResult.FileName1]
                        });

                        //data.Append($"\n{Jaccard} | {AlgorithmType.Semantic} | {GuidsForCodes[plagiResult.FileName1]}");

                        // Coincidences
                        await _context.Plagiarisms!.AddAsync(new Plagiarism
                        {
                            //Id = Coincidences,
                            Id = Guid.NewGuid(),
                            Algorithm = AlgorithmType.Coincidences,
                            Coincidences = plagiResult.Coincidences,
                            CodeId = GuidsForCodes[plagiResult.FileName1]
                        });

                        //data.Append($"\n{Jaccard} | {AlgorithmType.Coincidences} | {GuidsForCodes[plagiResult.FileName1]}");
                    }
                    catch (Exception e)
                    {
                        Console.WriteLine($"Exception ({GetType().Name}): {e.Message}\n");
                    }
                }
            }

            Console.WriteLine(data.ToString());

            assignment.IsAnalyzed = true;
            assignment.AnalysisDate = DateTime.UtcNow;

            await _context.SaveChangesAsync();
        }
    }
}