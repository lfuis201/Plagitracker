﻿using Antlr4.Runtime;
using Antlr4.Runtime.Tree;
using Hangfire;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using PlagiTracker.CodeUtils.GrammarFiles;
using PlagiTracker.Data.DataAccess;
using PlagiTracker.Data.Entities;
using PlagiTracker.Data.Requests;
using PlagiTracker.Services.FileServices;
using PlagiTracker.Services.SeleniumServices;
using PlagiTracker.WebAPI.HangFire;
using System.Text;

namespace PlagiTracker.WebAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AssignmentController : ControllerBase
    {
        private readonly DataContext _context;

        public AssignmentController(DataContext context)
        {
            _context = context ?? throw new ArgumentNullException(nameof(context), "Error: Data Base connection");
        }

        [HttpPost]
        [Route("ValidateAssignmentBody")]
        public async Task<ActionResult> ValidateAssignmentBody(List<string> codes)
        {
            if (codes == null || codes.Count < 1)
            {
                return BadRequest("There are not enough codes to analyze.");
            }

            List<bool> results = [];

            foreach (var code in codes)
            {
                try
                {
                    AntlrInputStream inputStream = new (code);
                    JavaLexer lexer = new (inputStream);
                    CommonTokenStream commonTokenStream = new (lexer);
                    JavaParser parser = new (commonTokenStream);
                    parser.BuildParseTree = true;
                    IParseTree tree = parser.compilationUnit();

                    results.Add(parser.NumberOfSyntaxErrors == 0);
                }
                catch (Exception)
                {
                    results.Add(false);
                }
            }
            
            return Ok(results);
        }

        [HttpPost]
        [Route("Create")]
        public async Task<ActionResult> Create(AssignmentRequest assignmentRequest)
        {
            if(assignmentRequest.SubmissionDate.ToUniversalTime() < DateTime.UtcNow)
            {
                return BadRequest("The submission date must be greater than the current date.");
            }

            var id = Guid.NewGuid();
            await _context!.Assignments!.AddAsync(new Assignment()
            {
                Id = id,
                Description = assignmentRequest.Description,
                Title = assignmentRequest.Title,
                //Tiempo universal coordinado (UTC)
                SubmissionDate = assignmentRequest.SubmissionDate,
                CourseId = assignmentRequest.CourseId
            });

            await _context.SaveChangesAsync();
            return Ok(id);
        }

        [HttpPost]
        [Route("Analyze")]
        public async Task<ActionResult> Analyze(Guid assignmentId)
        {
            var assignment = await _context!.Assignments!.FindAsync(assignmentId);

            if (assignment == null)
            {
                return NotFound("The assignment not exist.");
            }

            var studentsSubmissions = await _context!.Submissions!
                .Where(submission => submission.AssignmentId == assignmentId)
                .Include(submission => submission.Student)
                .Select(submission => new Submission
                {
                    Id = submission.Id,
                    Url = submission.Url,
                    SubmissionDate = submission.SubmissionDate,
                    StudentId = submission.StudentId,
                    Student = new Student { 
                        FirstName = submission.Student!.FirstName,
                        LastName = submission.Student!.LastName
                    },
                })
                .ToListAsync();
            
            // Verificar que haya al menos 2 entregas
            if (studentsSubmissions == null || studentsSubmissions.Count < 2)
            {
                return BadRequest("There are not enough submissions to analyze.");
            }

            // Verificar que todos los Student no sean nulos
            if (studentsSubmissions.Any(submission => submission.Student == null))
            {
                return BadRequest("Error in DataBase");
            }
            
            WebScraping scraper = new();

            Dictionary<Guid, StudentSubmission> analysisResult = await scraper.StartScraping(studentsSubmissions);
            
            if(analysisResult == null || analysisResult.Count <= 0)
            {
                return BadRequest("Error in scraping");
            }

            string analysisResultJson = JsonConvert.SerializeObject(analysisResult);

            if(!assignment.IsAnalyzed && assignment.AnalysisDate == DateTime.MinValue)
            {
                BackgroundJob.Schedule(() =>
                    HttpContext.RequestServices
                        .GetRequiredService<HangFireServices>()
                        .SavePlagiarismReport(assignmentId, new string(analysisResultJson), new Dictionary<Guid, StudentSubmission>(analysisResult)),
                    new DateTimeOffset(DateTime.UtcNow)
                );
            }

            var document = ReportGenerator.GenerateReport(analysisResult);
            
            // Convertir el PDF a un array de bytes
            using (var memoryStream = new MemoryStream())
            {
                document.Save(memoryStream);
                var pdfBytes = memoryStream.ToArray();

                return File(pdfBytes, "application/pdf", $"PlagiarismReport-{assignmentId}.pdf");
            }
        }

        [HttpGet]
        [Route("GetAllByCourse")]
        public async Task<ActionResult> GetAllByCourse(Guid courseId)
        {
            var course = await _context!.Courses!.FindAsync(courseId);

            if (course == null)
            {
                return NotFound();
            }
            else
            {
                var assignments = await _context!.Assignments!.Where(a => a.CourseId == courseId).ToListAsync();

                if (assignments == null || assignments.Count < 1)
                {
                    return NotFound();
                }

                return Ok(assignments);
            }
        }

        [HttpPut]
        [Route("Update")]
        public async Task<ActionResult> Update(AssignmentUpdateRequest assignmentUpdateRequest)
        {
            var assignment = await _context!.Assignments!.FindAsync(assignmentUpdateRequest.Id);

            if (assignment == null)
            {
                return NotFound();
            }

            assignment.Description = assignmentUpdateRequest.Description;
            assignment.Title = assignmentUpdateRequest.Title;
            assignment.SubmissionDate = assignmentUpdateRequest.SubmissionDate;

            await _context.SaveChangesAsync();
            return Ok();
        }

        [HttpDelete]
        [Route("Delete")]
        public async Task<ActionResult> Delete(Guid id)
        {
            var assignment = await _context!.Assignments!.FindAsync(id);
            _context.Assignments.Remove(assignment!);

            await _context.SaveChangesAsync();
            return Ok();
        }
        
        [HttpGet]
        [Route("GetById")]
        public async Task<ActionResult> GetById(Guid id)
        {
            var assignment = await _context!.Assignments!.FindAsync(id);

            if (assignment == null)
            {
                return NotFound();
            }

            return Ok(new Assignment()
            {
                Id = assignment.Id,
                Title = assignment.Title,
                Description = assignment.Description,
                SubmissionDate = assignment.SubmissionDate,
                CourseId = assignment.CourseId
            });
        }
    }
}