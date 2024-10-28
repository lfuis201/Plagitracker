using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
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
            /*
            if(analysisResult == null)
            {
                   return;
            }
            else if(analysisResult.Count == 0 || assignmentId == Guid.Empty || _context == null || _context.Assignments == null)
            {
                return;
            }
            */
            var assignment = await _context.Assignments!.FindAsync(assignmentId);

            if (assignment == null)
            {
                return;
            }

            StringBuilder data = new();
            StringBuilder data2 = new();

            bool codeValidator = false;
            bool plagiarismValidator = false;

            foreach (var studentSubmission in analysisResult.Values)
            {
                codeValidator = false;
                plagiarismValidator = false;

                if (studentSubmission.Codes == null || studentSubmission.Codes!.Count == 0)
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

                        data2.Append($"\n{CodeId} | {studentSubmission.SubmissionId} | {code.Key}");

                        GuidsForCodes.Add(code.Key, CodeId);
                    } 
                    catch (Exception e)
                    {
                        codeValidator = false;
                        Console.WriteLine($"Exception ({GetType().Name}): {e.Message}\n");
                    }
                }

                await _context.SaveChangesAsync();

                int count = await _context.Codes!.CountAsync(code => code.SubmissionId == studentSubmission.SubmissionId);
                /*
                if (GuidsForCodes == null || GuidsForCodes.Count == 0 || GuidsForCodes.Count != count)
                {
                    continue;
                }
                
                if(GuidsForCodes.Count == count)
                {
                    codeValidator = true;
                }
                */
                count = 0;
                var sortedStudentSubmission = studentSubmission.PlagiResults.OrderBy(plagiResult => plagiResult.FileName1).ToList();
                foreach (var plagiResult in sortedStudentSubmission)
                {
                    try
                    {
                        
                        var Jaccard = Guid.NewGuid();
                        var Levenshtein = Guid.NewGuid();
                        var Semantic = Guid.NewGuid();
                        var Coincidences = Guid.NewGuid();
                        
                        // Jaccard
                        await _context.Plagiarisms!.AddAsync(new Plagiarism
                        {
                            Id = Jaccard,
                            Similarity = plagiResult.JaccardSimilitude,
                            Algorithm = AlgorithmType.Jaccard,
                            CodeId = GuidsForCodes[plagiResult.FileName1]
                        });

                        data.Append($"\n{Jaccard} | {AlgorithmType.Jaccard} | {GuidsForCodes[plagiResult.FileName1]}");

                        // Levenshtein
                        await _context.Plagiarisms!.AddAsync(new Plagiarism
                        {
                            Id = Levenshtein,
                            Algorithm = AlgorithmType.Levenshtein,
                            Similarity = plagiResult.LevenshteinSimilitude,
                            CodeId = GuidsForCodes[plagiResult.FileName1]
                        });

                        data.Append($"\n{Levenshtein} | {AlgorithmType.Levenshtein} | {GuidsForCodes[plagiResult.FileName1]}");

                        // Semantic
                        await _context.Plagiarisms!.AddAsync(new Plagiarism
                        {
                            Id = Semantic,
                            Algorithm = AlgorithmType.Semantic,
                            Similarity = plagiResult.SemanticSimilitude,
                            CodeId = GuidsForCodes[plagiResult.FileName1]
                        });

                        data.Append($"\n{Semantic} | {AlgorithmType.Semantic} | {GuidsForCodes[plagiResult.FileName1]}");

                        // Coincidences
                        await _context.Plagiarisms!.AddAsync(new Plagiarism
                        {
                            Id = Coincidences,
                            Algorithm = AlgorithmType.Coincidences,
                            Coincidences = plagiResult.Coincidences,
                            CodeId = GuidsForCodes[plagiResult.FileName1]
                        });

                        count += 4;
                        data.Append($"\n{Coincidences} | {AlgorithmType.Coincidences} | {GuidsForCodes[plagiResult.FileName1]}");
                    }
                    catch (Exception e)
                    {
                        plagiarismValidator = false;
                        Console.WriteLine($"Exception ({GetType().Name}): {e.Message}\n");
                    }
                }

                await _context.SaveChangesAsync();

                int dbCount = 0;
                /*
                foreach (var code in GuidsForCodes)
                {
                    dbCount += await _context.Plagiarisms!.CountAsync(plagiarism => plagiarism.CodeId == code.Value);
                }

                if (count == dbCount)
                {
                    plagiarismValidator = true;
                }
                */
            }

            Console.WriteLine(data.ToString());

            if(codeValidator && plagiarismValidator)
            {
                assignment.IsAnalyzed = true;
                assignment.AnalysisDate = DateTime.UtcNow;

                await _context.SaveChangesAsync();
            }
        }
    }
}