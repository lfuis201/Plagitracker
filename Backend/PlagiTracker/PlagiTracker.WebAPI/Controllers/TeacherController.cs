using Hangfire;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PlagiTracker.Data.DataAccess;
using PlagiTracker.Data.Entities;
using PlagiTracker.Data.Requests;
using PlagiTracker.Data.Responses;
using System.Security.Cryptography;

namespace PlagiTracker.WebAPI.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class TeacherController : CustomControllerBase, IUserController
    {
        private readonly IConfiguration _configuration;

        public TeacherController(DataContext context, IConfiguration configuration) : base(context)
        {
            _configuration = configuration ?? throw new ArgumentNullException(nameof(configuration), "Error: Error in configuration");
        }

        #region IUserController Implementation

        [AllowAnonymous]
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

        [AllowAnonymous]
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

                    string token = ((IUserController)this).GenerateJwtToken(_configuration, teacher.Id!, teacher.GetType());

                    if (string.IsNullOrEmpty(token))
                    {
                        return BadRequest(new { message = "Error generating token." });
                    }

                    return Ok(new LogInResponse
                    {
                        Id = teacher.Id,
                        FirstName = teacher.FirstName,
                        LastName = teacher.LastName,
                        Email = teacher.Email,
                        Token = token,
                    });
                }
            }
            catch (Exception ex)
            {
                return BadRequest(ex.ToString());
            }
        }

        [AllowAnonymous]
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

        [AllowAnonymous]
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

        [AllowAnonymous]
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

        /// <summary>
        /// Obtener la información de un profesor
        /// </summary>
        /// <param name="id">Id del profesor</param>
        /// <returns></returns>
        [HttpGet]
        [Route("Get")]
        public async Task<ActionResult> Get(Guid id)
        {
            try
            {
                // Verificar scope token
                string? scopeClaim = User.FindFirst("Scope")?.Value;

                var verifyTokenResult = VerifyToken(scopeClaim!, typeof(Teacher).Name);

                if (!verifyTokenResult.Success)
                {
                    return Unauthorized(verifyTokenResult.Message);
                }

                // Verificar si el id del token es un usuario
                string userIdClaim = User.FindFirst("Id")?.Value!;

                var user = await _context!.Users!.FindAsync(userIdClaim);

                if (user == null)
                {
                    return Unauthorized("Invalid token id");
                }
                else if (!user.IsEnabled)
                {
                    return Unauthorized("Account is deleted");
                }

                // Obtener y retornar información del profesor
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
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        /// <summary>
        /// Obteniendo información privada del profesor
        /// </summary>
        /// <remarks>Solo accesible por el profesor</remarks>
        /// <returns></returns>
        [HttpGet]
        [Route("GetPrivateInfo")]
        public async Task<ActionResult> GetPrivateInfo()
        {
            try
            {
                // Verificar scope token
                string? scopeClaim = User.FindFirst("Scope")?.Value;

                var verifyTokenResult = VerifyToken(scopeClaim!, typeof(Teacher).Name);

                if (!verifyTokenResult.Success)
                {
                    return Unauthorized(verifyTokenResult.Message);
                }

                // Verificar si el id del token es un usuario
                Guid userIdClaim = Guid.Parse(User.FindFirst("Id")?.Value!);

                var user = await _context!.Users!.FindAsync(userIdClaim);

                if (user == null)
                {
                    return Unauthorized("Invalid token id");
                }
                else if (!user.IsEnabled)
                {
                    return Unauthorized("Account is deleted");
                }

                // Obtener y retornar información del profesor
                var teacher = await _context!.Teachers!.FindAsync(user.Id);

                if (teacher == null)
                {
                    return NotFound();
                }

                int activeCourse = await _context.Courses!
                    .CountAsync(course => course.TeacherId == teacher.Id && course.IsEnabled && !course.IsArchived);

                int archivedCourse = await _context.Courses!
                    .CountAsync(course => course.TeacherId == teacher.Id && course.IsEnabled && course.IsArchived);

                return Ok(new
                {
                    Id = teacher.Id!,
                    FirstName = teacher.FirstName!,
                    LastName = teacher.LastName!,
                    Email = teacher.Email!,
                    CreatedAt = teacher.CreatedAt!,
                    ActiveCourse = activeCourse,
                    ArchivedCourse = archivedCourse,
                });
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpPut]
        [Route("Update")]
        public async Task<ActionResult> Update(TeacherUpdateRequest teacherUpdateRequest)
        {
            try
            {
                // Verificar scope token
                string? scopeClaim = User.FindFirst("Scope")?.Value;

                var verifyTokenResult = VerifyToken(scopeClaim!, typeof(Teacher).Name);

                if (!verifyTokenResult.Success)
                {
                    return Unauthorized(verifyTokenResult.Message);
                }

                // Verificar si el id del token es un usuario
                string userIdClaim = User.FindFirst("Id")?.Value!;

                var user = await _context!.Users!.FindAsync(userIdClaim);

                if (user == null)
                {
                    return Unauthorized("Invalid token id");
                }
                else if (!user.IsEnabled)
                {
                    return Unauthorized("Account is deleted");
                }

                // Actualizar información del profesor
                var teacher = await _context!.Teachers!.FindAsync(user.Id);

                teacher!.FirstName = teacherUpdateRequest.FirstName;
                teacher!.LastName = teacherUpdateRequest.LastName;
                teacher!.Email = teacherUpdateRequest.Email;
                teacher!.UpdatedAt = DateTime.UtcNow;

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

                return BadRequest(ex.Message);
            }
        }

        [HttpDelete]
        [Route("Delete")]
        public async Task<ActionResult> Delete()
        {
            try
            {
                // Verificar scope token
                string? scopeClaim = User.FindFirst("Scope")?.Value;

                var verifyTokenResult = VerifyToken(scopeClaim!, typeof(Teacher).Name);

                if (!verifyTokenResult.Success)
                {
                    return Unauthorized(verifyTokenResult.Message);
                }

                // Verificar si el id del token es un usuario
                Guid userIdClaim = Guid.Parse(User.FindFirst("Id")?.Value!);

                var user = await _context!.Users!.FindAsync(userIdClaim);

                if (user == null)
                {
                    return Unauthorized("Invalid token id");
                }
                else if (!user.IsEnabled)
                {
                    return BadRequest("Account is already deleted");
                }

                // Eliminar profesor (desactivar)
                var teacher = await _context!.Teachers!.FindAsync(user.Id);
                
                if (teacher == null)
                {
                    return NotFound();
                }

                teacher!.IsEnabled = false;

                await _context.SaveChangesAsync();

                return Ok();
            }
            catch (Exception ex)
            {
                return BadRequest($"Error: {ex.Message}");
            }
        }
    }
}