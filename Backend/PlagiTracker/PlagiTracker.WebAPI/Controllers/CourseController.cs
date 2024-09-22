using Microsoft.AspNetCore.Mvc;
using PlagiTracker.Data.DataAccess;
using PlagiTracker.Data.Requests;
using PlagiTracker.Data.Entities;
using PlagiTracker.Data.Responses;
using Microsoft.EntityFrameworkCore;
using System.Security.Cryptography;
using System.Text;

namespace PlagiTracker.WebAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CourseController : ControllerBase
    {
        private readonly DataContext _context;

        public CourseController(DataContext context)
        {
            _context = context;
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
            var course = await _context!.Courses!.FindAsync(id);

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