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
    public class TeacherController : ControllerBase
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

        [HttpPost]
        [Route("LogIn")]
        public async Task<ActionResult> LogIn(LogInRequest logInRequest)
        {
            try
            {
                var teacher = await _context!.Teachers!.FirstOrDefaultAsync(t => t.Email == logInRequest.Email);

                if (teacher == null)
                {
                    return NotFound();
                }
                else
                {
                    using (SHA256 sha256Hash = SHA256.Create())
                    {
                        byte[] bytes = logInRequest.PasswordHash!;
                        for (int i = 0; i < bytes.Length; i++)
                        {
                            if (bytes[i] != teacher.PasswordHash![i])
                            {
                                return Unauthorized();
                            }
                        }
                    }

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
                Console.WriteLine(ex.ToString());
                return NotFound();
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