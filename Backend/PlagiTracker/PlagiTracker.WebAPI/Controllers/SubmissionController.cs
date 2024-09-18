using Microsoft.AspNetCore.Mvc;
using PlagiTracker.Data.DataAccess;
using PlagiTracker.Data.Requests;
using PlagiTracker.Data.Entities;
using PlagiTracker.Data.Responses;
using Microsoft.EntityFrameworkCore;
using System.Security.Cryptography;
using System.Text;
using System;

namespace PlagiTracker.WebAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SubmissionController : ControllerBase
    {
        private readonly DataContext _context;

        public SubmissionController(DataContext context)
        {
            _context = context;
        }

        [HttpPost]
        [Route("Create")]
        public async Task<ActionResult> Create(SubmissionRequest submissionRequest)
        {
            try
            {
                //Buscando la asignación
                var assignment = await _context!.Assignments!.FirstOrDefaultAsync(c => c.Id == submissionRequest.AssignmentId);

                if (assignment == null)
                {
                    return NotFound();
                }
                else
                {
                    if (assignment.SubmissionDate.ToUniversalTime() < submissionRequest.SubmissionDate.ToUniversalTime())
                    {
                        return UnprocessableEntity("The submit time has ended");
                    }

                    await _context!.Submissions!.AddAsync(new Submission()
                    {
                        Id = Guid.NewGuid(),
                        Url = submissionRequest.Url,
                        StudentId = submissionRequest.StudentId,
                        AssignmentId = submissionRequest.AssignmentId
                    });

                    await _context.SaveChangesAsync();

                    return Ok();
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.ToString());
                return NotFound();
            }
        }

        [HttpGet]
        [Route("Get")]
        public async Task<ActionResult> Get(Guid id)
        {
            var submission = await _context!.Submissions!.FindAsync(id);

            if (submission == null)
            {
                return NotFound();
            }

            return Ok(new Submission()
            {
                Id = submission.Id,
                Url = submission.Url,
                StudentId = submission.StudentId,
                AssignmentId = submission.AssignmentId
            });
        }

        [HttpGet]
        [Route("GetAllByStudent")]
        public async Task<ActionResult> GetAllByStudent(Guid studentId)
        {
            var submissions = await _context!.Submissions!.Where(s => s.StudentId == studentId).ToListAsync();

            if (submissions == null)
            {
                return NotFound();
            }

            return Ok(submissions);
        }

        [HttpPut]
        [Route("Update")]
        public async Task<ActionResult> Update(Submission newSubmission, DateTime dateTime)
        {
            var assignment = await _context!.Assignments!.FindAsync(newSubmission.AssignmentId);

            if (assignment == null)
            {
                return NotFound();
            }
            else
            {
                if (assignment.SubmissionDate.ToUniversalTime() < dateTime.ToUniversalTime())
                {
                    return UnprocessableEntity("The submit time has ended");
                }
            }

            var submission = await _context!.Submissions!.FindAsync(newSubmission.Id);

            if(submission == null)
            {
                return NotFound();
            }

            submission!.Url = newSubmission.Url;
            await _context.SaveChangesAsync();
            return Ok();
        }

        [HttpDelete]
        [Route("Delete")]
        public async Task<ActionResult> Delete(Guid id)
        {
            var submission = await _context!.Submissions!.FindAsync(id);
            _context.Submissions.Remove(submission!);

            await _context.SaveChangesAsync();
            return Ok();
        }
    }
}