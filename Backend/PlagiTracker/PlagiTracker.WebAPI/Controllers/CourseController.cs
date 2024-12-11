// Ignore Spelling: Unarchive

using Hangfire;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PlagiTracker.Data.DataAccess;
using PlagiTracker.Data.Entities;
using PlagiTracker.Data.Requests;

namespace PlagiTracker.WebAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CourseController(DataContext context) : CustomControllerBase(context)
    {
        [HttpPost]
        [Route("Create")]
        public async Task<ActionResult> Create(CourseRequest courseRequest)
        {
            await _context!.Courses!.AddAsync(new Course()
            {
                Id = Guid.NewGuid(),
                InvitationId = Guid.NewGuid(),
                Name = courseRequest.Name,
                TeacherId = courseRequest.TeacherId
            });

            await _context.SaveChangesAsync();
            return Ok();
        }

        /// <summary>
        /// Obtiene un curso por su id. Puede ser usado por el estudiante y el profesor
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpGet]
        [Route("GetById")]
        public async Task<ActionResult> GetById(Guid id)
        {
            try
            {
                #region Token Verification
                string? scopeClaim = User.FindFirst("Scope")?.Value;

                // Verificar scope token
                var verifyTokenResult_1 = VerifyToken(scopeClaim!, typeof(Student).Name);
                var verifyTokenResult_2 = VerifyToken(scopeClaim!, typeof(Teacher).Name);

                if (!verifyTokenResult_1.Success && !verifyTokenResult_2.Success)
                {
                    return Unauthorized(new
                    {
                        Success = false,
                        Message = verifyTokenResult_1.Message!
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

                var course = await _context!.Courses!
                    .Include(course => course.Teacher)
                    .FirstOrDefaultAsync(course => course.Id == id);

                if (course == null)
                {
                    return NotFound();
                }

                return Ok(new
                {
                    Success = true,
                    Mesasse = "Course found",
                    Data = course
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

        /// <summary>
        /// Obtiene un curso por su nombre
        /// </summary>
        /// <remarks>
        /// Puede ser usado por el estudiante y el profesor
        /// </remarks>
        /// <param name="name"></param>
        /// <returns></returns>
        [HttpGet]
        [Route("GetByName")]
        public async Task<ActionResult> GetByName(string name)
        {
            try
            {
                #region Token Verification
                string? scopeClaim = User.FindFirst("Scope")?.Value;

                // Verificar scope token
                var verifyTokenResult_1 = VerifyToken(scopeClaim!, typeof(Student).Name);
                var verifyTokenResult_2 = VerifyToken(scopeClaim!, typeof(Teacher).Name);

                if (!verifyTokenResult_1.Success && !verifyTokenResult_2.Success)
                {
                    return Unauthorized(new
                    {
                        Success = false,
                        Message = verifyTokenResult_1.Message!
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

                var course = await _context!.Courses!.FirstOrDefaultAsync(c => c.Name == name);

                // Verificar si no se encontró el curso
                if (course == null)
                {
                    return NotFound(new
                    {
                        Success = false,
                        Message = "Course not found"
                    });
                }

                return Ok(new
                {
                    Success = true,
                    Message = "Course found",
                    Data = new Course()
                    {
                        Id = course.Id,
                        Name = course.Name,
                        TeacherId = course.TeacherId
                    }
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

        /// <summary>
        /// Obtiene todos los cursos del estudiante
        /// </summary>
        /// <param name="archived"></param>
        /// <returns></returns>
        [HttpGet]
        [Route("GetAllByStudent")]
        public async Task<ActionResult> GetAllByStudent(bool archived)
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
                    .Where(e => e.StudentId == userIdClaim && e.Course != null && e.Course.IsArchived == archived)
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

                if (enrollments == null)
                {
                    return NotFound(new
                    {
                        Success = false,
                        Message = "No courses found"
                    });
                }
                else if (enrollments.Count < 1)
                {
                    return NotFound(new
                    {
                        Success = true,
                        Message = "No courses found"
                    });
                }
                else
                {
                    return Ok(new
                    {
                        Success = true,
                        Message = "Courses found",
                        Data = enrollments
                    });
                }
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

        /// <summary>
        /// Obtiene todos los cursos del profesor
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        [Route("GetAllByTeacher")]
        public async Task<ActionResult<List<Course>>> GetAllByTeacher()
        {
            try
            {
                #region Token Verification
                string? scopeClaim = User.FindFirst("Scope")?.Value;

                // Verificar scope token
                var verifyTokenResult = VerifyToken(scopeClaim!, typeof(Teacher).Name);
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

                var courses = await _context!.Courses!
                    .Where(c => c.TeacherId == userIdClaim && !c.IsArchived)
                    .ToListAsync();

                // Verificar si no se encontraron cursos
                if (courses == null)
                {
                    return NotFound(new
                    {
                        Success = false,
                        Message = "No courses found"
                    });
                }
                else if (courses.Count < 1)
                {
                    return NotFound(new
                    {
                        Success = true,
                        Message = "No courses found"
                    });
                }

                return Ok(new
                {
                    Success = true,
                    Message = "Courses found",
                    Data = courses
                });
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        /// <summary>
        /// Obtiene todos los cursos archivados del profesor
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        [Route("GetAllArchivedByTeacher")]
        public async Task<ActionResult<List<Course>>> GetAllArchivedByTeacher()
        {
            try
            {
                #region Token Verification
                string? scopeClaim = User.FindFirst("Scope")?.Value;

                // Verificar scope token
                var verifyTokenResult = VerifyToken(scopeClaim!, typeof(Teacher).Name);
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

                var courses = await _context!.Courses!
                    .Where(c => c.TeacherId == userIdClaim && c.IsArchived)
                    .ToListAsync();

                // Verificar si no se encontraron cursos
                if (courses == null || courses.Count < 1)
                {
                    return NotFound(new
                    {
                        Success = false,
                        Message = "No archived courses found"
                    });
                }

                return Ok(new
                {
                    Success = true,
                    Message = "Archived courses found",
                    Data = courses
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

        [HttpPut]
        [Route("Update")]
        public async Task<ActionResult> Update(CourseUpdateRequest courseUpdateRequest)
        {
            var course = await _context!.Courses!.FindAsync(courseUpdateRequest.Id);
            course!.Name = courseUpdateRequest.Name;

            await _context.SaveChangesAsync();
            return Ok();
        }

        /// <summary>
        /// Actualiza el enlace de invitación de un curso
        /// </summary>
        /// <param name="courseId">
        /// Identificador del curso
        /// </param>
        /// <returns>
        /// Enlace de invitación actualizado
        /// </returns>
        [HttpPost]
        [Route("UpdateInvitationLink")]
        public async Task<ActionResult<string>> UpdateInvitationLink(Guid courseId)
        {
            try
            {
                var course = await _context!.Courses!.FindAsync(courseId);

                if (course == null)
                {
                    return NotFound("Course not found");
                }

                // Generar un nuevo identificador de invitación
                course.InvitationId = Guid.NewGuid();

                // Guardar los cambios en la base de datos
                _context.Courses.Update(course);
                await _context.SaveChangesAsync();

                // Construir el enlace de invitación
                //var invitationLink = $"{Request.Scheme}://{Request.Host}/api/Course/Join/{course.InvitationId}";
                var invitationLink = $"http://127.0.0.1:5713/InvitationLink/{course.InvitationId}";

                return Ok(invitationLink);
            }
            catch(Exception ex)
            {
                return BadRequest($"Error: {ex.Message}");
            }
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