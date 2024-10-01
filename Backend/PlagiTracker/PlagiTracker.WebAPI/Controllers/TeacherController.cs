using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PlagiTracker.Data.DataAccess;
using PlagiTracker.Data.Entities;
using PlagiTracker.Data.Requests;
using PlagiTracker.Data.Responses;
using System.Security.Cryptography;

namespace PlagiTracker.WebAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TeacherController : ControllerBase, IUserController
    {
        private readonly DataContext _context;

        public TeacherController(DataContext context)
        {
            _context = context;
        }

        [HttpPost]
        [Route("SignUp")]
        public async Task<ActionResult> SignUp(SignUpRequest signUpRequest)
        {
            try
            {
                await _context!.Teachers!.AddAsync(new Teacher()
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
                    && ex.InnerException.Message.Contains("23505: duplicate key value violates unique constraint")
                    && ex.InnerException.Message.Contains("IX_Users_Email")
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
                var teacher = await _context!.Teachers!.FirstOrDefaultAsync(s => s.Email == logInRequest.Email);

                if (teacher == null)
                {
                    return NotFound(new { message = "Account not found." });
                }
                else
                {
                    if (teacher.IsLocked && teacher.UnlockDate.ToUniversalTime() > DateTime.UtcNow)
                    {
                        return Unauthorized(new
                        {
                            message = "Account is locked.",
                            unlockDate = teacher.UnlockDate.ToUniversalTime()
                        });
                    }
                    else if (teacher.IsLocked && teacher.UnlockDate.ToUniversalTime() <= DateTime.UtcNow)
                    {
                        // Desbloqueando cuenta
                        teacher.IsLocked = false;
                        teacher.UnlockDate = DateTime.MinValue;
                        teacher.LogInAttempts = 0;
                    }

                    //Comparando bytes de la contraseña
                    using (SHA256 sha256Hash = SHA256.Create())
                    {
                        byte[] bytes = logInRequest.PasswordHash!;
                        for (int i = 0; i < bytes.Length; i++)
                        {
                            if (bytes[i] != teacher.PasswordHash![i])
                            {
                                teacher.LogInAttempts++;

                                // Bloqueando cuenta después de n intentos fallidos
                                if (teacher.LogInAttempts == IUserController.MAX_LOGIN_ATTEMPTS)
                                {
                                    teacher.IsLocked = true;
                                    teacher.UnlockDate = DateTime.UtcNow.AddMinutes(IUserController.UNLOCK_MINUTES);

                                    await _context.SaveChangesAsync();

                                    return Unauthorized(new
                                    {
                                        message = "Account is locked.",
                                        unlockDate = teacher.UnlockDate.ToUniversalTime()
                                    });
                                }

                                await _context.SaveChangesAsync();

                                return Unauthorized(new
                                {
                                    message = "Invalid password.",
                                    remainingLogInAttempts = IUserController.MAX_LOGIN_ATTEMPTS - teacher.LogInAttempts
                                });
                            }
                        }
                    }

                    await _context.SaveChangesAsync();

                    return Ok(new LogInResponse
                    {
                        Id = teacher.Id,
                        FirstName = teacher.FirstName,
                        LastName = teacher.LastName,
                        Email = teacher.Email
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
            var teacher = await _context!.Teachers!.FindAsync(id);

            if (teacher == null)
            {
                return NotFound();
            }

            return Ok(new TeacherResponse()
            {
                Id = teacher.Id,
                FirstName = teacher.FirstName,
                LastName = teacher.LastName,
                Email = teacher.Email
            });
        }


        [HttpPut]
        [Route("Update")]
        public async Task<ActionResult> Update(TeacherUpdateRequest teacherUpdateRequest)
        {
            var teacher = await _context!.Teachers!.FindAsync(teacherUpdateRequest.Id);
            teacher!.FirstName = teacherUpdateRequest.FirstName;
            teacher!.LastName = teacherUpdateRequest.LastName;
            teacher!.Email = teacherUpdateRequest.Email;

            await _context.SaveChangesAsync();
            return Ok();
        }

        [HttpDelete]
        [Route("Delete")]
        public async Task<ActionResult> Delete(Guid id)
        {
            var teacher = await _context!.Teachers!.FindAsync(id);
            _context.Teachers.Remove(teacher!);

            await _context.SaveChangesAsync();
            return Ok();
        }
    }
}