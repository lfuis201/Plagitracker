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
    public class StudentController : ControllerBase, IUserController
    {
        private readonly DataContext _context;

        public StudentController(DataContext context)
        {
            _context = context;
        }

        [HttpPost]
        [Route("SignUp")]
        public async Task<ActionResult> SignUp(SignUpRequest signUpRequest)
        {
            try
            {
                await _context!.Students!.AddAsync(new Student()
                {
                    Id = Guid.NewGuid(),
                    FirstName = signUpRequest.FirstName,
                    LastName = signUpRequest.LastName,
                    Email = signUpRequest.Email,
                    PasswordHash = signUpRequest.PasswordHash
                });

                await _context.SaveChangesAsync();
                return Ok();
            }
            catch (Exception ex)
            {
                if (
                    ex.InnerException != null 
                    && ex.InnerException.Message.Contains(IUserController.EMAIL_ALREADY_USED_EXCEPTION_MESSAGE_1) 
                    && ex.InnerException.Message.Contains(IUserController.EMAIL_ALREADY_USED_EXCEPTION_MESSAGE_2)
                )
                {
                        return Conflict(new { message = "Email already used." });
                }

                return BadRequest(ex.ToString());
            }
        }

        [HttpPost]
        [Route("LogIn")]
        public async Task<ActionResult> LogIn(LogInRequest logInRequest)
        {
            try
            {
                var student = await _context!.Students!.FirstOrDefaultAsync(s => s.Email == logInRequest.Email);

                if (student == null)
                {
                    return NotFound(new { message = "Account not found." });
                }
                else
                {
                    if (student.IsLocked && student.UnlockDate.ToUniversalTime() > DateTime.UtcNow)
                    {
                        return Unauthorized(new 
                        { 
                            message = "Account is locked.", 
                            unlockDate = student.UnlockDate.ToUniversalTime() 
                        });
                    }
                    else if (student.IsLocked && student.UnlockDate.ToUniversalTime() <= DateTime.UtcNow)
                    {
                        // Desbloqueando cuenta
                        student.IsLocked = false;
                        student.UnlockDate = DateTime.MinValue;
                        student.LogInAttempts = 0;
                    }

                    //Comparando bytes de la contraseña
                    using (SHA256 sha256Hash = SHA256.Create())
                    {
                        byte[] bytes = logInRequest.PasswordHash!;
                        for (int i = 0; i < bytes.Length; i++)
                        {
                            if (bytes[i] != student.PasswordHash![i])
                            {
                                student.LogInAttempts++;

                                // Bloqueando cuenta después de n intentos fallidos
                                if (student.LogInAttempts == IUserController.MAX_LOGIN_ATTEMPTS)
                                {
                                    student.IsLocked = true;
                                    student.UnlockDate = DateTime.UtcNow.AddMinutes(IUserController.UNLOCK_MINUTES);
                                    
                                    await _context.SaveChangesAsync();
                                    
                                    return Unauthorized(new
                                    {
                                        message = "Account is locked.",
                                        unlockDate = student.UnlockDate.ToUniversalTime()
                                    });
                                }

                                await _context.SaveChangesAsync();

                                return Unauthorized(new 
                                { 
                                    message = "Invalid password.", 
                                    remainingLogInAttempts = IUserController.MAX_LOGIN_ATTEMPTS - student.LogInAttempts 
                                });
                            }
                        }
                    }

                    await _context.SaveChangesAsync();

                    return Ok(new LogInResponse
                    {
                        Id = student.Id,
                        FirstName = student.FirstName,
                        LastName = student.LastName,
                        Email = student.Email
                    });
                }
            }
            catch (Exception ex)
            {
                return BadRequest(ex.ToString());
            }
        }

        [HttpGet]
        [Route("Get")]
        public async Task<ActionResult> Get(Guid id)
        {
            var student = await _context!.Students!.FindAsync(id);

            if (student == null)
            {
                return NotFound();
            }

            return Ok(new TeacherResponse()
            {
                Id = student.Id,
                FirstName = student.FirstName,
                LastName = student.LastName,
                Email = student.Email
            });
        }

        [HttpGet]
        [Route("GetAllByCourse")]
        public async Task<ActionResult> GetAllByCourse(Guid courseId)
        {
            var enrollments = await _context!.Enrollments!.Where(e => e.CourseId == courseId).ToListAsync();

            if (enrollments == null || enrollments.Count < 1)
            {
                return NotFound();
            }
            else
            {
                var students = new List<StudentResponse>();

                foreach (var enrollment in enrollments)
                {
                    var student = await _context!.Students!.FindAsync(enrollment.StudentId);
                    students.Add(new StudentResponse()
                    {
                        Id = student!.Id,
                        FirstName = student.FirstName,
                        LastName = student.LastName,
                        Email = student.Email
                    });
                }

                return Ok(students);
            }
        }

        [HttpPut]
        [Route("Update")]
        public async Task<ActionResult> Update(StudentUpdateRequest studentUpdateRequest)
        {
            var student = await _context!.Students!.FindAsync(studentUpdateRequest.Id);
            student!.FirstName = studentUpdateRequest.FirstName;
            student!.LastName = studentUpdateRequest.LastName;
            student!.Email = studentUpdateRequest.Email;

            await _context.SaveChangesAsync();
            return Ok();
        }

        [HttpDelete]
        [Route("Delete")]
        public async Task<ActionResult> Delete(Guid id)
        {
            var student = await _context!.Students!.FindAsync(id);
            _context.Students.Remove(student!);

            await _context.SaveChangesAsync();
            return Ok();
        }
    }
}