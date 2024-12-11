using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PlagiTracker.Data.DataAccess;
using PlagiTracker.Data.Entities;
using PlagiTracker.Data.Requests;

namespace PlagiTracker.WebAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class EnrollmentController(DataContext context) : CustomControllerBase(context)
    {
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

        /// <summary>
        /// Inscribe a un estudiante en un curso
        /// </summary>
        /// <remarks>
        /// Sólo los estudiantes pueden inscribirse en un curso
        /// </remarks>
        /// <param name="invitationId"></param>
        /// <returns></returns>
        [HttpGet]
        [Route("Join/{invitationId}")]
        public async Task<ActionResult> JoinCourse(Guid invitationId)
        {
            try
            {
                #region Token Verification
                string? scopeClaim = User.FindFirst("Scope")?.Value;

                // Verificar scope token
                var verifyTokenResult = VerifyToken(scopeClaim!, typeof(Student).Name);
                if (!verifyTokenResult.Success)
                {
                    return Unauthorized(new
                    {
                        Success = false,
                        Message = verifyTokenResult.Message!
                    });
                }

                Guid userIdClaim = Guid.Parse(User.FindFirst("Id")?.Value!);
                var user = await _context!.Users!.FindAsync(userIdClaim);

                // Verificar si el id del token pertenece a un usuario
                if (user == null)
                {
                    return Unauthorized(new
                    {
                        Success = false,
                        Message = "Invalid token id"
                    });
                }
                // Verificar si el usuario no está eliminado
                else if (!user.IsEnabled)
                {
                    return Unauthorized(new
                    {
                        Success = false,
                        Message = "Account is deleted"
                    });
                }
                #endregion

                // Buscar el curso por el identificador de invitación
                var course = await _context.Courses!.FirstOrDefaultAsync(c => c.InvitationId == invitationId);
                if (course == null)
                {
                    return NotFound("Invalid invitation link");
                }

                // Verificar si el estudiante existe
                var student = await _context.Students!.FindAsync(user.Id);
                if (student == null)
                {
                    return NotFound("Student not found");
                }

                // Verificar si el estudiante ya está inscrito en el curso
                var enrollment = await _context.Enrollments!
                    .FirstOrDefaultAsync(e => e.CourseId == course.Id && e.StudentId == user.Id);
                if (enrollment != null)
                {
                    return BadRequest("Student is already enrolled in the course");
                }

                // Inscribir al estudiante en el curso
                await _context.Enrollments!.AddAsync(new Enrollment
                {
                    CourseId = course.Id,
                    StudentId = user.Id,
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
                        Success = false,
                        Title = "Enrollment Failed",
                        Message = "You are already enrolled in this course"
                    });
                }

                return BadRequest(ex.ToString());
            }
        }

        /// <summary>
        /// Obtiene todas las inscripciones de un estudiante
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        [Route("GetAllByStudent")]
        public async Task<ActionResult> GetAllByStudent()
        {
            try
            {
                #region Token Verification
                string? scopeClaim = User.FindFirst("Scope")?.Value;

                // Verificar scope token
                var verifyTokenResult = VerifyToken(scopeClaim!, typeof(Student).Name);
                if (!verifyTokenResult.Success)
                {
                    return Unauthorized(new
                    {
                        Success = false,
                        Message = verifyTokenResult.Message!
                    });
                }

                Guid userIdClaim = Guid.Parse(User.FindFirst("Id")?.Value!);
                var user = await _context!.Users!.FindAsync(userIdClaim);

                // Verificar si el id del token pertenece a un usuario
                if (user == null)
                {
                    return Unauthorized(new
                    {
                        Success = false,
                        Message = "Invalid token id"
                    });
                }
                // Verificar si el usuario no está eliminado
                else if (!user.IsEnabled)
                {
                    return Unauthorized(new
                    {
                        Success = false,
                        Message = "Account is deleted"
                    });
                }
                #endregion

                var enrollments = await _context!.Enrollments!
                    .Where(e => e.StudentId == user.Id)
                    .ToListAsync();

                // Verificar si el estudiante no está inscrito en ningún curso
                if (enrollments == null || enrollments.Count < 1)
                {
                    return NotFound(new
                    {
                        Message = "No enrollments found"
                    });
                }

                return Ok(new
                {
                    Success = true,
                    Message = "Enrollments found",
                    Data = enrollments
                });
            }
            catch (Exception ex)
            {
                return BadRequest(new
                {
                    Success = false,
                    Message = ex.InnerException?.Message ?? ex.Message
                });
            }
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