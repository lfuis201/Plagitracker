using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PlagiTracker.Data.DataAccess;
using PlagiTracker.Data.Entities;
using PlagiTracker.Data.Requests;

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
        public async Task<ActionResult> GetAllByStudent(Guid studentId)
        {
            var enrollments = await _context!.Enrollments!.Where(e => e.StudentId == studentId).ToListAsync();

            if (enrollments == null || enrollments.Count < 1)
            {
                return NotFound();
            }
            else
            {
                var courses = new List<Course>();

                foreach (var enrollment in enrollments)
                {
                    var course = await _context!.Courses!.FindAsync(enrollment.CourseId);
                    courses.Add(new Course()
                    {
                        Id = course!.Id,
                        Name = course.Name,
                        TeacherId = course.TeacherId
                    });
                }

                return Ok(courses);
            }
        }

        [HttpGet]
        [Route("GetAllByTeacher")]
        public async Task<ActionResult<List<Course>>> GetAllByTeacher(Guid teacherId)
        {
            var courses = await _context!.Courses!.Where(c => c.TeacherId == teacherId).ToListAsync();

            // Verificar si no se encontraron cursos
            if (courses == null || courses.Count < 1)
            {
                return NotFound();
            }

            return Ok(courses);
        }

        [HttpGet]
        [Route("GetAllCourses")]
        public async Task<ActionResult<List<Course>>> GetAllCourses()
        {
            // Verificar si _context.Courses es nulo antes de usarlo
            if (_context.Courses == null)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, "Database not initialized.");
            }

            // Obtener todos los cursos de la base de datos
            var courses = await _context.Courses.ToListAsync();

            // Verificar si no hay cursos disponibles
            if (courses.Count == 0)
            {
                return NotFound("No courses found.");
            }

            return Ok(courses);
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
            var course = await _context!.Courses!.FindAsync(id);
            _context.Courses.Remove(course!);

            await _context.SaveChangesAsync();
            return Ok();
        }
    }
}