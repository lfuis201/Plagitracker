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
                    return NotFound("Course not found");
                }

                var student = await _context!.Students!.FirstOrDefaultAsync(s => s.Id == studentId);

                if (student == null)
                {
                    return NotFound("Student not found");
                }

                await _context!.Enrollments!.AddAsync(new Enrollment()
                {
                    CourseId = courseId,
                    StudentId = studentId
                });

                await _context.SaveChangesAsync();

                return Ok("Success");
            }
            catch (Exception ex)
            {
                if (
                    ex.InnerException != null
                    && ex.InnerException.Message.Contains("23505: duplicate key value violates unique constraint")
                )
                {
                    return Conflict(new
                    {
                        title = "Enrollment Failed",
                        message = "You are already enrolled in this course"
                    });
                }

                return BadRequest(ex.ToString());
            }
        }

        [HttpGet]
        [Route("Join/{invitationId}")]
        public async Task<ActionResult> JoinCourse(Guid invitationId, [FromQuery] Guid studentId)
        {
            try
            {
                // Buscar el curso por el identificador de invitación
                var course = await _context.Courses!.FirstOrDefaultAsync(c => c.InvitationId == invitationId);
                if (course == null)
                {
                    return NotFound("Invalid invitation link");
                }

                // Verificar si el estudiante existe
                var student = await _context.Students!.FindAsync(studentId);
                if (student == null)
                {
                    return NotFound("Student not found");
                }

                // Verificar si el estudiante ya está inscrito en el curso
                var enrollment = await _context.Enrollments!
                    .FirstOrDefaultAsync(e => e.CourseId == course.Id && e.StudentId == studentId);
                if (enrollment != null)
                {
                    return BadRequest("Student is already enrolled in the course");
                }

                // Inscribir al estudiante en el curso
                await _context.Enrollments!.AddAsync(new Enrollment
                {
                    CourseId = course.Id,
                    StudentId = studentId,
                });

                await _context.SaveChangesAsync();

                return Ok(new
                {
                    Message = "Successfully joined the course",
                });
            }
            catch (Exception ex)
            {
                if (
                    ex.InnerException != null
                    && ex.InnerException.Message.Contains("23505: duplicate key value violates unique constraint")
                )
                {
                    return Conflict(new
                    {
                        title = "Enrollment Failed",
                        message = "You are already enrolled in this course"
                    });
                }

                return BadRequest(ex.ToString());
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