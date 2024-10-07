using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Internal;
using PdfSharpCore.Pdf;
using PlagiTracker.Data.DataAccess;
using PlagiTracker.Data.Entities;
using PlagiTracker.Data.Requests;
using PlagiTracker.Services.SeleniumServices;
using static System.Net.WebRequestMethods;
using System.Linq;

namespace PlagiTracker.WebAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AssignmentController : ControllerBase
    {
        private readonly DataContext _context;

        public AssignmentController(DataContext context)
        {
            _context = context;
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

            var studentsSubmissions = (await _context!.Submissions!
            .Where(submission => submission.AssignmentId == assignmentId)
            .Join(
                _context.Students!,
                submission => submission.StudentId,
                student => student.Id,
                (submission, student) => new { Student = student, Submission = submission }
            ).ToListAsync())
            .Select(data => (data.Student, data.Submission))
            .ToList();

            if (studentsSubmissions == null || studentsSubmissions.Count < 2)
            {
                return BadRequest("There are not enough submissions to analyze.");
            }

            WebScraping scraper = new();
            /*
            BackgroundJob.Schedule(() => 
                new HangFire.HangFireServices().SavePlagiarismReport(urls2), 
                new DateTimeOffset(DateTime.UtcNow.AddMinutes(1))
            );
            */

            var data = await scraper.StartScraping(studentsSubmissions);

            if(data == null)
            {
                return BadRequest();
            }

            // Convertir el PDF a un array de bytes
            using (var memoryStream = new MemoryStream())
            {
                data.Save(memoryStream);
                var pdfBytes = memoryStream.ToArray();

                return File(pdfBytes, "application/pdf", $"PlagiarismReport-{Guid.NewGuid()}.pdf");
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
            assignment!.Description = assignmentUpdateRequest.Description;
            assignment!.Title = assignmentUpdateRequest.Title;

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
    }
}