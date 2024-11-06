// Ignore Spelling: Unarchive

using Hangfire;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PlagiTracker.Data.DataAccess;
using PlagiTracker.Data.Entities;
using PlagiTracker.Data.Requests;
using System.Transactions;

namespace PlagiTracker.WebAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CourseController : ControllerBase
    {
        private readonly DataContext _context;

        public CourseController(DataContext context)
        {
            _context = context ?? throw new ArgumentNullException(nameof(context), "Error: Data Base connection");
        }

        [HttpPost]
        [Route("Create")]
        public async Task<ActionResult> Create(CourseRequest courseRequest)
        {
            await _context!.Courses!.AddAsync(new Course()
            {
                Id = Guid.NewGuid(),
                Name = courseRequest.Name,
                TeacherId = courseRequest.TeacherId
            });

            await _context.SaveChangesAsync();
            return Ok();
        }

        [HttpGet]
        [Route("GetById")]
        public async Task<ActionResult> GetById(Guid id)
        {
            var course = await _context!.Courses!
                .FirstOrDefaultAsync(c => c.Id == id);

            if (course == null)
            {
                return NotFound();
            }

            return Ok(new Course
            {
                Id = course.Id,
                Name = course.Name,
                TeacherId = course.TeacherId
            });
        }


        [HttpGet]
        [Route("GetAllByAssignment")]
        public async Task<ActionResult> GetAllByAssignment(Guid assignmentId)
        {
            // Verificar si la asignación existe
            var assignment = await _context!.Assignments!.FindAsync(assignmentId);
            if (assignment == null)
            {
                return NotFound("Assignment not found.");
            }

            // Obtener todas las entregas asociadas a la asignación, incluyendo la información del estudiante
            var submissions = await _context!.Submissions!
                .Include(s => s.Student) // Incluir información del estudiante
                .Where(s => s.AssignmentId == assignmentId)
                .ToListAsync();

            // Verificar si hay entregas
            if (submissions == null || submissions.Count == 0)
            {
                return NotFound("No submissions found for this assignment.");
            }

            // Retornar las entregas junto con la información del estudiante
            return Ok(submissions.Select(s => new
            {
                SubmissionId = s.Id,
                Url = s.Url,
                SubmissionDate = s.SubmissionDate,
                Grade = s.Grade,
                StudentId = s.StudentId,
                StudentFirstName = s!.Student!.FirstName,
                StudentLastName = s.Student.LastName,
                StudentEmail = s.Student.Email
            }));
        }


        [HttpGet]
        [Route("GetByName")]
        public async Task<ActionResult> GetByName(string name)
        {
            var course = await _context!.Courses!.FirstOrDefaultAsync(c => c.Name == name);

            if (course == null)
            {
                return NotFound();
            }

            return Ok(new Course()
            {
                Id = course.Id,
                Name = course.Name,
                TeacherId = course.TeacherId
            });
        }

        [HttpGet]
        [Route("GetAllByStudent")]
        public async Task<ActionResult> GetAllByStudent(Guid studentId, bool archived)
        {
            try
            {
                var enrollments = await _context!.Enrollments!
                    .Where(e => e.StudentId == studentId && e.Course != null && e.Course.IsArchived == archived)
                    .Include(e => e.Course)
                    .ThenInclude(c => c.Teacher)
                    .Include(e => e.Course)
                    .Select(e => new
                    {
                        e.Grade,
                        Course = new
                        {
                            e.Course!.Id,
                            e.Course.Name,
                            e.Course.TeacherId,
                            Teacher = new
                            {
                                e.Course.Teacher!.Id,
                                e.Course.Teacher.FirstName,
                                e.Course.Teacher.LastName,
                                e.Course.Teacher.Email,
                            },
                        }
                    })
                    .ToListAsync();

                if (enrollments == null || enrollments.Count < 1)
                {
                    return NotFound();
                }
                else
                {
                    return Ok(enrollments);
                }
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpGet]
        [Route("GetAllByTeacher")]
        public async Task<ActionResult<List<Course>>> GetAllByTeacher(Guid teacherId)
        {
            try
            {
                var courses = await _context!.Courses!.Where(c => c.TeacherId == teacherId && !c.IsArchived).ToListAsync();

                // Verificar si no se encontraron cursos
                if (courses == null || courses.Count < 1)
                {
                    return NotFound();
                }

                return Ok(courses);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpGet]
        [Route("GetAllArchivedByTeacher")]
        public async Task<ActionResult<List<Course>>> GetAllArchivedByTeacher(Guid teacherId)
        {
            try
            {
                var courses = await _context!.Courses!.Where(c => c.TeacherId == teacherId && c.IsArchived).ToListAsync();

                // Verificar si no se encontraron cursos
                if (courses == null || courses.Count < 1)
                {
                    return NotFound();
                }

                return Ok(courses);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpPut]
        [Route("Update")]
        public async Task<ActionResult> Update(CourseUpdateRequest courseUpdateRequest)
        {
            var course = await _context!.Courses!.FindAsync(courseUpdateRequest.Id);
            course!.Name = courseUpdateRequest.Name;

            await _context.SaveChangesAsync();
            return Ok();
        }

        [HttpDelete]
        [Route("Delete")]
        public async Task<ActionResult> Delete(Guid id)
        {
            try
            {
                var assignment = await _context!.Courses!.FindAsync(id);

                if (assignment == null)
                {
                    return NotFound("Course not exist");
                }

                assignment.IsEnabled = false;

                await _context.SaveChangesAsync();
                return Ok();
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpDelete]
        [Route("Archive")]
        public async Task<ActionResult> Archive(Guid id)
        {
            try
            {
                var course = await _context!.Courses!.Include(c => c.Teacher).FirstOrDefaultAsync(c => c.Id == id);

                if (course == null)
                {
                    return NotFound("Course not exist");
                }

                var enrollments = await _context.Enrollments!
                    .Where(e => e.CourseId == id)
                    .Include(e => e.Student)
                    .Select(e => new
                    {
                        toEmail = e.Student!.Email,
                        displayName = $"{e.Student.FirstName} {e.Student.LastName}"
                    })
                    .ToListAsync();

                course.IsArchived = true;
                await _context.SaveChangesAsync();

                var recipientList = enrollments.Select(e => (e.toEmail, e.displayName)).ToList();


                BackgroundJob.Schedule(() =>
                    Services.EmailServices.EmailCourseNotifications.ArchivedCourse(
                        recipientList!, 
                        $"{course.Teacher!.FirstName} {course.Teacher!.LastName}",
                        course.Name!
                        ),
                    new DateTimeOffset(DateTime.UtcNow)
                );

                return Ok();
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpDelete]
        [Route("Unarchive")]
        public async Task<ActionResult> Unarchive(Guid id)
        {
            try
            {
                var assignment = await _context!.Courses!.FindAsync(id);

                if (assignment == null)
                {
                    return NotFound("Course not exist");
                }

                assignment.IsArchived = false;

                await _context.SaveChangesAsync();
                return Ok();
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
    }
}