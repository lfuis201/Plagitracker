using Microsoft.AspNetCore.Mvc;
using PlagiTracker.Data.DataAccess;
using PlagiTracker.Data.Requests;
using PlagiTracker.Data.Entities;
using Microsoft.EntityFrameworkCore;

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
            var id = Guid.NewGuid();
            await _context!.Assignments!.AddAsync(new Assignment()
            {
                Id = id,
                Description = assignmentRequest.Description,
                Title = assignmentRequest.Title,
                //Tiempo universal coordinado (UTC)
                SubmissionDate = DateTime.UtcNow,
                CourseId = assignmentRequest.CourseId
            });

            await _context.SaveChangesAsync();
            return Ok(id);
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