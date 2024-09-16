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
        public async Task<ActionResult<LogInResponse>> LogIn(LogInRequest logInRequest)
        {
            try
            {
                var clientUser = await _context!.Teachers!.FirstOrDefaultAsync(t => t.Email == logInRequest.Email);

                if (clientUser == null)
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
                            if (bytes[i] != clientUser.PasswordHash![i])
                            {
                                return Unauthorized();
                            }
                        }
                    }

                    return Ok(new LogInResponse
                    {
                        Id = clientUser.Id,
                        FirstName = clientUser.FirstName,
                        LastName = clientUser.LastName,
                        Email = clientUser.Email
                    });
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.ToString());
                return NotFound();
            }
        }

        /*
         * password = "XohImNooBHFR0OVvjcYpJ3NgPQ1qq73WKhHvch0VQtg="
         * 123456789 = "FeKw08M4keuw8e9gnsQZQgwg4yDOlMZfvIwzEkSOsiU="
        {
          "firstName": "Pepe",
          "lastName": "Malgesto",
          "email": "pmalgesto@gmail.com",
          "passwordHash":
        }
        */
        /*
        [HttpGet]
        [Route("GetAll")]
        public async Task<ActionResult<IEnumerable<Genre>>> GetAll()
        {
            var genres = await _context!.Genres!.ToListAsync();
            return Ok(genres);
        }

        [HttpGet]
        [Route("Get")]
        public async Task<IActionResult> Get(int id)
        {
            var genre = await _context!.Genres!.FindAsync(id);

            if (genre == null)
            {
                return NotFound();
            }

            return Ok(genre);
        }

        [HttpPut]
        [Route("Update")]
        public async Task<IActionResult> Update(int id, Genre genre)
        {
            var getGenre = await _context!.Genres!.FindAsync(id);
            getGenre!.Name = genre.Name;
            await _context.SaveChangesAsync();

            return Ok();
        }

        [HttpDelete]
        [Route("Delete")]
        public async Task<IActionResult> Delete(int id)
        {
            var genre = await _context!.Genres!.FindAsync(id);
            _context.Genres.Remove(genre!);

            await _context.SaveChangesAsync();

            return Ok();
        }
        */
    }
}