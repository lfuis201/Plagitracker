using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PlagiTracker.Data.DataAccess;
using PlagiTracker.Data.Entities;
using PlagiTracker.Data.Requests;

namespace PlagiTracker.WebAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class EnrollmentController : ControllerBase
    {
        private readonly DataContext _context;

        public EnrollmentController(DataContext context)
        {
            _context = context ?? throw new ArgumentNullException(nameof(context), "Error: Data Base connection");
        }

        [HttpPost]
        [Route("Create")]
        public async Task<ActionResult> Create(Guid courseId, Guid studentId)
        {
            try
            {
                //Buscando el curso
                var course = await _context!.Courses!.FirstOrDefaultAsync(c => c.Id == courseId);

                if (course == null)
                {
                    return NotFound();
                }
                else
                {
                    await _context!.Enrollments!.AddAsync(new Enrollment()
                    {
                        CourseId = courseId,
                        StudentId = studentId
                    });

                    await _context.SaveChangesAsync();

                    return Ok("Success");
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
            var enrollment = await _context!.Enrollments!.FindAsync(id);

            if (enrollment == null)
            {
                return NotFound();
            }

            return Ok(new Enrollment()
            {
                StudentId = enrollment.StudentId,
                CourseId = enrollment.CourseId
            });
        }

        [HttpGet]
        [Route("GetAllByStudent")]
        public async Task<ActionResult> GetAllByStudent(Guid studentId)
        {
            var enrollments = await _context!.Enrollments!.Where(e => e.StudentId == studentId).ToListAsync();

            if (enrollments == null || enrollments.Count < 1)
            {
                return NotFound();
            }

            return Ok(enrollments);
        }

        [HttpDelete]
        [Route("Delete")]
        public async Task<ActionResult> Delete(EnrollmentRequest enrollmentRequest)
        {
            var enrollment = await _context!.Enrollments!.FirstOrDefaultAsync(e => e.CourseId == enrollmentRequest.CourseId && e.StudentId == enrollmentRequest.StudentId);

            if (enrollment == null)
            {
                return NotFound();
            }

            _context.Enrollments!.Remove(enrollment!);

            await _context.SaveChangesAsync();
            return Ok("Success");
        }
    }
}