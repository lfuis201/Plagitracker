using Hangfire;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PlagiTracker.Data.DataAccess;
using PlagiTracker.Data.Entities;
using PlagiTracker.Data.Requests;
using PlagiTracker.Data.Responses;
using System.Security.Cryptography;
using System.Text;

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

        #region IUserController Implementation

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

                BackgroundJob.Schedule(() =>
                    Services.EmailServices.EmailAuthenticator.WelcomeTeacherEmail(signUpRequest.Email!, $"{signUpRequest.FirstName} {signUpRequest.LastName}"),
                    new DateTimeOffset(DateTime.UtcNow)
                );

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

                    if (logInRequest.PasswordHash == null || logInRequest.PasswordHash.Length == 0)
                    {
                        return BadRequest(new { message = "Password is required." });
                    }

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
                                    teacher.UnlockDate = DateTime.UtcNow.AddMinutes(IUserController.LOG_IN_UNLOCK_MINUTES);

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

        [HttpPost]
        [Route("SendResetPasswordEmail")]
        public async Task<ActionResult> SendResetPasswordEmail(string email)
        {
            try
            {
                var teacher = await _context!.Teachers!.FirstOrDefaultAsync(teacher => teacher.Email == email);

                if (teacher == null)
                {
                    return NotFound(new { message = "Account not found." });
                }

                teacher.VerificationCode = new Random().Next(IUserController.VERIFICATION_MIN_RANGE_VALUE, IUserController.VERIFICATION_MAX_RANGE_VALUE);
                teacher.VerificationCodeExpiration = DateTime.UtcNow.AddMinutes(IUserController.VERIFICATION_CODE_EXPIRED_MINUTES);
                teacher.IsVerified = false;

                await _context.SaveChangesAsync();

                BackgroundJob.Schedule(() =>
                    Services.EmailServices.EmailAuthenticator.ResetPasswordEmail(teacher.Email!, $"{teacher.FirstName} {teacher.LastName}", teacher.VerificationCode),
                    new DateTimeOffset(DateTime.UtcNow)
                );

                return Ok();
            }
            catch (Exception ex)
            {
                return BadRequest(ex.ToString());
            }
        }

        [HttpPost]
        [Route("ResetPasswordVerification")]
        public async Task<ActionResult> ResetPasswordVerification(string email, int code)
        {
            try
            {
                if (code < IUserController.VERIFICATION_MIN_RANGE_VALUE || code > IUserController.VERIFICATION_MAX_RANGE_VALUE)
                {
                    return BadRequest(new { message = "Invalid code." });
                }

                var user = await _context!.Teachers!.FirstOrDefaultAsync(user => user.Email == email);

                if (user == null)
                {
                    return NotFound(new { message = "Account not found." });
                }
                else if (user.VerificationCode != code)
                {
                    return BadRequest(new { message = "Invalid code." });
                }
                else if (user.VerificationCodeExpiration.ToUniversalTime() < DateTime.UtcNow)
                {
                    return BadRequest(new { message = "Code expired." });
                }

                user.IsVerified = true;

                await _context.SaveChangesAsync();

                return Ok();
            }
            catch (Exception ex)
            {
                return BadRequest(ex.ToString());
            }
        }

        [HttpPost]
        [Route("ResetPassword")]
        public async Task<ActionResult> ResetPassword(ResetPasswordRequest resetPasswordRequest)
        {
            try
            {
                if (resetPasswordRequest.NewPasswordHash == null || resetPasswordRequest.NewPasswordHash.Length == 0)
                {
                    return BadRequest(new { message = "New password is required." });
                }
                else if (resetPasswordRequest.VerificationCode < IUserController.VERIFICATION_MIN_RANGE_VALUE
                    || resetPasswordRequest.VerificationCode > IUserController.VERIFICATION_MAX_RANGE_VALUE)
                {
                    return BadRequest(new { message = "Invalid code." });
                }

                var user = await _context!.Teachers!.FirstOrDefaultAsync(user => user.Email == resetPasswordRequest.Email);

                if (user == null)
                {
                    return NotFound(new { message = "Account not found." });
                }
                else if (user.VerificationCode != resetPasswordRequest.VerificationCode)
                {
                    return BadRequest(new { message = "Invalid code." });
                }
                else if (user.VerificationCodeExpiration.ToUniversalTime() < DateTime.UtcNow)
                {
                    return BadRequest(new { message = "Code expired." });
                }
                else if (!user.IsVerified)
                {
                    return BadRequest(new { message = "Code not verified." });
                }

                bool isDiferent = false;

                //Comparando bytes de la contraseña actual y la nueva
                for (int i = 0; i < resetPasswordRequest.NewPasswordHash.Length; i++)
                {
                    if (user.PasswordHash![i] != resetPasswordRequest.NewPasswordHash[i])
                    {
                        isDiferent = true;
                        break;
                    }
                }

                if (!isDiferent)
                {
                    return BadRequest(new { message = "New password is the same as the current password." });
                }

                user.VerificationCode = IUserController.VERIFICATION_CODE_NULL_VALUE;
                user.VerificationCodeExpiration = DateTime.MinValue;
                user.IsVerified = false;
                user.PasswordHash = resetPasswordRequest.NewPasswordHash;

                await _context.SaveChangesAsync();

                return Ok();
            }
            catch (Exception ex)
            {
                return BadRequest(ex.ToString());
            }
        }

        #endregion

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