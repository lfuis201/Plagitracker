using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PlagiTracker.Data.DataAccess;
using PlagiTracker.Data.Entities;
using PlagiTracker.Data.Requests;
using PlagiTracker.Services.SeleniumServices;

namespace PlagiTracker.WebAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SubmissionController : ControllerBase
    {
        // Mensaje de excepción cuando el estudiante ya hizo una entrega para la misma asignación
        const string STUDENT_ALREADY_SUBMITTED_EXCEPTION_MESSAGE_1 = "23505: duplicate key value violates unique constraint";
        const string STUDENT_ALREADY_SUBMITTED_EXCEPTION_MESSAGE_2 = "IX_Submissions_StudentId_AssignmentId";
        
        // Mensaje de excepción cuando la URL ya fue usada
        const string URL_ALREADY_USED_EXCEPTION_MESSAGE_1 = "23505: duplicate key value violates unique constraint";
        const string URL_ALREADY_USED_EXCEPTION_MESSAGE_2 = "IX_Submissions_Url";

        private readonly DataContext _context;

        public SubmissionController(DataContext context)
        {
            _context = context ?? throw new ArgumentNullException(nameof(context), "Error: Data Base connection");
        }

        /// <summary>
        /// Crea una Entrega para una Asignación
        /// </summary>
        /// <remarks>
        /// Este EndPoint sólo lo usa el Estudiante
        /// </remarks>
        /// <param name="submissionRequest">
        /// Petición de Entrega.
        /// </param>
        /// <returns></returns>
        [HttpPost]
        [Route("Create")]
        public async Task<ActionResult> Create(SubmissionRequest submissionRequest)
        {
            try
            {
                // Buscando la Asignación
                var assignment = await _context!.Assignments!.FirstOrDefaultAsync(c => c.Id == submissionRequest.AssignmentId);

                if (assignment == null)
                {
                    return NotFound();
                }
                else if (string.IsNullOrEmpty(submissionRequest.Url))
                {
                    return BadRequest("The URL is required");
                }
                else if(!WebScraping.IsSupportedURL(submissionRequest.Compiler, submissionRequest.Url))
                {
                    return BadRequest("The URL is not supported");
                }
                else if(!await WebScraping.UrlExists(submissionRequest.Url))
                {
                    return BadRequest("The URL does not exist");
                }
                else
                {
                    if (assignment.SubmissionDate.ToUniversalTime() < submissionRequest.SubmissionDate.ToUniversalTime())
                    {
                        return UnprocessableEntity("The submit time has ended");
                    }

                    Submission submission = new()
                    {
                        Id = Guid.NewGuid(),
                        Url = submissionRequest.Url,
                        SubmissionDate = submissionRequest.SubmissionDate,
                        StudentId = submissionRequest.StudentId,
                        AssignmentId = submissionRequest.AssignmentId
                    };

                    var result= await new WebScraping().GetCodes(submission);

                    if(result == null)
                    {
                        return BadRequest("Error getting the codes");
                    }
                    else if (!result.Success)
                    {
                        return BadRequest(result.Message);
                    }

                    submission = result.Data.submission;
                    await _context!.Submissions!.AddAsync(submission);
                    
                    foreach (var code in result.Data.codes)
                    {
                        await _context!.Codes!.AddAsync(new Code
                        {
                            Id = Guid.NewGuid(),
                            SubmissionId = submission.Id,
                            FileName = code.Key,
                            Content = code.Value,
                        });
                    }

                    await _context.SaveChangesAsync();

                    return Ok(new
                    {
                        Message = "Success",
                        Data = result.Data.codes.Keys
                    });
                }
            }
            catch (Exception ex)
            {
                if (
                    ex.InnerException != null
                    && ex.InnerException.Message.Contains(STUDENT_ALREADY_SUBMITTED_EXCEPTION_MESSAGE_1)
                    && ex.InnerException.Message.Contains(STUDENT_ALREADY_SUBMITTED_EXCEPTION_MESSAGE_2)
                )
                {
                    return Conflict(new { message = "Student already submitted" });
                }
                else if (
                    ex.InnerException != null
                    && ex.InnerException.Message.Contains(URL_ALREADY_USED_EXCEPTION_MESSAGE_1)
                    && ex.InnerException.Message.Contains(URL_ALREADY_USED_EXCEPTION_MESSAGE_2)
                )
                {
                    return Conflict(new { message = "URL already used." });
                }

                return BadRequest(ex.ToString());
            }
        }

        [HttpGet]
        [Route("Get")]
        public async Task<ActionResult> Get(Guid id)
        {
            var submission = await _context!.Submissions!.FindAsync(id);

            if (submission == null)
            {
                return NotFound();
            }

            return Ok(new Submission()
            {
                Id = submission.Id,
                Url = submission.Url,
                StudentId = submission.StudentId,
                AssignmentId = submission.AssignmentId
            });
        }

        [HttpGet]
        [Route("GetAllByStudent")]
        public async Task<ActionResult> GetAllByStudent(Guid studentId)
        {
            var submissions = await _context!.Submissions!.Where(s => s.StudentId == studentId).ToListAsync();

            if (submissions == null)
            {
                return NotFound();
            }

            return Ok(submissions);
        }

        [HttpPut]
        [Route("Update")]
        public async Task<ActionResult> Update(SubmissionRequest submissionRequest)
        {
            try
            {
                var submission = await _context!.Submissions!.Where(submission => 
                    submission.AssignmentId == submissionRequest.AssignmentId
                    && submission.StudentId == submissionRequest.StudentId
                ).FirstOrDefaultAsync();

                if (submission == null)
                {
                    return NotFound();
                }

                var assignment = await _context!.Assignments!.FindAsync(submissionRequest.AssignmentId);

                if (assignment == null)
                {
                    return NotFound();
                }
                else
                {
                    if (assignment.SubmissionDate.ToUniversalTime() < submissionRequest.SubmissionDate.ToUniversalTime())
                    {
                        return UnprocessableEntity("The submit time has ended");
                    }
                }
                submission!.Url = submissionRequest.Url;
                await _context.SaveChangesAsync();
                return Ok();
            }
            catch (Exception ex)
            {
                if (
                    ex.InnerException != null
                    && ex.InnerException.Message.Contains(URL_ALREADY_USED_EXCEPTION_MESSAGE_1)
                    && ex.InnerException.Message.Contains(URL_ALREADY_USED_EXCEPTION_MESSAGE_2)
                )
                {
                    return Conflict(new { message = "URL already used." });
                }
                return BadRequest(ex.ToString());
            }
        }

        [HttpDelete]
        [Route("Delete")]
        public async Task<ActionResult> Delete(Guid id)
        {
            var submission = await _context!.Submissions!.FindAsync(id);
            _context.Submissions.Remove(submission!);

            await _context.SaveChangesAsync();
            return Ok();
        }

        [HttpGet]
        [Route("GetAllByAssignment")]
        public async Task<ActionResult> GetAllByAssignment(Guid assignmentId)
        {
            // Verificar si la asignación existe
            var assignment = await _context!.Assignments!.FindAsync(assignmentId);
            if (assignment == null)
            {
                return NotFound("Assignment not found.");
            }

            // Obtener todas las entregas asociadas a la asignación, incluyendo la información del estudiante
            var submissions = await _context!.Submissions!
                .Include(s => s.Student) // Incluir información del estudiante
                .Where(s => s.AssignmentId == assignmentId)
                .ToListAsync();

            // Verificar si hay entregas
            if (submissions == null || submissions.Count == 0)
            {
                return NotFound("No submissions found for this assignment.");
            }

            // Retornar las entregas junto con la información del estudiante
            return Ok(submissions.Select(s => new
            {
                SubmissionId = s.Id,
                Url = s.Url,
                SubmissionDate = s.SubmissionDate,
                Grade = s.Grade,
                StudentId = s.StudentId,
                StudentFirstName = s.Student!.FirstName,
                StudentLastName = s.Student.LastName,
                StudentEmail = s.Student.Email
            }));
        }
    }
}