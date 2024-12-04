using Hangfire;
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
    public class StudentController : ControllerBase, IUserController
    {
        private readonly DataContext _context;
        private readonly IConfiguration _configuration;

        public StudentController(DataContext context, IConfiguration configuration)
        {
            _context = context ?? throw new ArgumentNullException(nameof(context), "Error: Data Base connection");
            _configuration = configuration ?? throw new ArgumentNullException(nameof(configuration), "Error: Error in configuration");
        }

        #region IUserController Implementation

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

                BackgroundJob.Schedule(() =>
                    Services.EmailServices.EmailAuthenticator.WelcomeStudentEmail(signUpRequest.Email!, $"{signUpRequest.FirstName} {signUpRequest.LastName}"),
                    new DateTimeOffset(DateTime.UtcNow)
                );

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
                    if (logInRequest.PasswordHash == null || logInRequest.PasswordHash.Length == 0)
                    {
                        return BadRequest(new { message = "Password is required." });
                    }

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
                                    student.UnlockDate = DateTime.UtcNow.AddMinutes(IUserController.LOG_IN_UNLOCK_MINUTES);

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
                    string token = ((IUserController)this).GenerateJwtToken(_configuration, student.Id!, student.GetType());

                    if (string.IsNullOrEmpty(token))
                    {
                        return BadRequest(new { message = "Error generating token." });
                    }

                    return Ok(new LogInResponse
                    {
                        Id = student.Id,
                        FirstName = student.FirstName,
                        LastName = student.LastName,
                        Email = student.Email,
                        Token = token,
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
                var student = await _context!.Students!.FirstOrDefaultAsync(student => student.Email == email);

                if (student == null)
                {
                    return NotFound(new { message = "Account not found." });
                }

                student.VerificationCode = new Random().Next(IUserController.VERIFICATION_MIN_RANGE_VALUE, IUserController.VERIFICATION_MAX_RANGE_VALUE);
                student.VerificationCodeExpiration = DateTime.UtcNow.AddMinutes(IUserController.VERIFICATION_CODE_EXPIRED_MINUTES);
                student.IsVerified = false;

                await _context.SaveChangesAsync();

                BackgroundJob.Schedule(() =>
                    Services.EmailServices.EmailAuthenticator.ResetPasswordEmail(student.Email!, $"{student.FirstName} {student.LastName}", student.VerificationCode),
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
                if(code < IUserController.VERIFICATION_MIN_RANGE_VALUE || code > IUserController.VERIFICATION_MAX_RANGE_VALUE)
                {
                    return BadRequest(new { message = "Invalid code." });
                }

                var student = await _context!.Students!.FirstOrDefaultAsync(student => student.Email == email);

                if (student == null)
                {
                    return NotFound(new { message = "Account not found." });
                }
                else if (student.VerificationCode != code)
                {
                    return BadRequest(new { message = "Invalid code." });
                }
                else if (student.VerificationCodeExpiration.ToUniversalTime() < DateTime.UtcNow)
                {
                    return BadRequest(new { message = "Code expired." });
                }

                student.IsVerified = true;

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

                var student = await _context!.Students!.FirstOrDefaultAsync(student => student.Email == resetPasswordRequest.Email);

                if (student == null)
                {
                    return NotFound(new { message = "Account not found." });
                }
                else if (student.VerificationCode != resetPasswordRequest.VerificationCode)
                {
                    return BadRequest(new { message = "Invalid code." });
                }
                else if (student.VerificationCodeExpiration.ToUniversalTime() < DateTime.UtcNow)
                {
                    return BadRequest(new { message = "Code expired." });
                }
                else if (!student.IsVerified)
                {
                    return BadRequest(new { message = "Code not verified." });
                }

                bool isDiferent = false;

                //Comparando bytes de la contraseña actual y la nueva
                for (int i = 0; i < resetPasswordRequest.NewPasswordHash.Length; i++)
                {
                    if (student.PasswordHash![i] != resetPasswordRequest.NewPasswordHash[i])
                    {
                        isDiferent = true;
                        break;
                    }
                }

                if(!isDiferent)
                {
                    return BadRequest(new { message = "New password is the same as the current password." });
                }

                student.VerificationCode = IUserController.VERIFICATION_CODE_NULL_VALUE;
                student.VerificationCodeExpiration = DateTime.MinValue;
                student.IsVerified = false;
                student.PasswordHash = resetPasswordRequest.NewPasswordHash;

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