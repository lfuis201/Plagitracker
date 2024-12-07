﻿// Ignore Spelling: Dolos

using Antlr4.Runtime;
using Antlr4.Runtime.Tree;
using Hangfire;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using PlagiTracker.CodeUtils.GrammarFiles;
using PlagiTracker.CodeUtils.JavaUtils;
using PlagiTracker.Data;
using PlagiTracker.Data.CodeUtilsData.JCode;
using PlagiTracker.Data.DataAccess;
using PlagiTracker.Data.Entities;
using PlagiTracker.Data.Requests;
using PlagiTracker.Data.Responses;
using PlagiTracker.Services.EmailServices;
using PlagiTracker.Services.FileServices;
using PlagiTracker.Services.SeleniumServices;
using PlagiTracker.WebAPI.HangFire;
using System;
using System.Text;

namespace PlagiTracker.WebAPI.Controllers
{
    //[Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class AssignmentController(DataContext context) : CustomControllerBase(context)
    {
        //[AllowAnonymous]
        [HttpPost]
        [Route("JCode")]
        public async Task<ActionResult> JCode([FromBody] string code)
        {
            if (string.IsNullOrEmpty(code))
            {
                return BadRequest("The code is empty.");
            }

            JCodeResponse result;

            try
            {
                result = await CodeUtils.JCode.JCodeClient.Execute(code);

                if (result == null || result.Clases == null)
                {
                    return BadRequest("Error in JCode");
                }

                // Convertir el resultado a inglés y eliminar las variables
                result.ToEnglish();
                result.IgnoreVariables();

                return Ok(result.Classes);
            }
            catch (Exception ex)
            {
                return BadRequest($"Error: JCode - {ex.Message}");
            }
        }

        //[AllowAnonymous]
        [HttpPost]
        [Route("JCodeForFiles")]
        public async Task<ActionResult> JCodeForFiles(IFormFileCollection files)
        {
            if (files == null || files.Count < 1)
            {
                return BadRequest("No files uploaded.");
            }

            StringBuilder filesContent = new();

            foreach (var file in files)
            {
                if (file.Length > 0)
                {
                    using (var reader = new StreamReader(file.OpenReadStream()))
                    {
                        filesContent.AppendLine(await reader.ReadToEndAsync());
                    }
                }
            }

            JCodeResponse result;

            try
            {
                result = await CodeUtils.JCode.JCodeClient.Execute(filesContent.ToString());

                if (result == null || result.Clases == null)
                {
                    return BadRequest("Error in JCode");
                }

                // Convertir el resultado a inglés y eliminar las variables
                result.ToEnglish();
                result.IgnoreVariables();

                return Ok(result.Classes);
            }
            catch (Exception ex)
            {
                return BadRequest($"Error: JCode - {ex.Message}");
            }
        }

        //[AllowAnonymous]
        [HttpPost]
        [Route("ValidateAssignmentBodyST")]
        public async Task<ActionResult> ValidateAssignmentBodyST(List<string> codes)
        {
            if (codes == null || codes.Count < 1)
            {
                return BadRequest("There are not enough codes to analyze.");
            }

            //List<bool> results = [];
            var results = new List<object>();

            foreach (var code in codes)
            {
                try
                {
                    AntlrInputStream inputStream = new(code);
                    JavaLexer lexer = new(inputStream);
                    CommonTokenStream commonTokenStream = new(lexer);
                    JavaParser parser = new(commonTokenStream);
                    parser.BuildParseTree = true;
                    IParseTree tree = parser.compilationUnit();

                    // Obtener los tokens
                    var tokens = commonTokenStream.GetTokens();

                    // Verificar si hay errores de sintaxis
                    bool isValid = parser.NumberOfSyntaxErrors == 0;

                    // Crear un resultado con el árbol de sintaxis y los tokens
                    var result = new
                    {
                        IsValid = isValid,
                        //Tree = tree,
                        SyntaxTree = tree.ToStringTree(parser),
                        //Tokens = tokens,
                        /*
                        TokensInfo = tokens.Select(t => new TokenInfo
                        {
                            Text = t.Text,
                            Type = t.Type,
                            Line = t.Line,
                            Column = t.Column
                        }).ToList(),
                        
                        Body = BodyGenerator.GenerateBody(tokens.Select(t => new TokenInfo
                        {
                            Text = t.Text,
                            Type = t.Type,
                            Line = t.Line,
                            Column = t.Column
                        }).ToList())*/
                        Body = BodyGenerator.ParseSyntaxTree(tree),
                        BodyJson = BodyGenerator.ParseClassInput(BodyGenerator.ParseSyntaxTree(tree)),
                    };
                    //Console.WriteLine(result.SyntaxTree);
                    Console.WriteLine(result.Body);
                    //Console.WriteLine(JsonConvert.SerializeObject(result.BodyJson));
                    results.Add(result);
                }
                catch (Exception) 
                {
                    results.Add(false);
                }
            }

            //return Ok(results);

            return Ok(results);
        }

        /// <summary>
        /// Valida el código Java con un parser personalizado
        /// </summary>
        /// <param name="codes"></param>
        /// <returns></returns>
        [HttpPost]
        [Route("ValidateJavaCodeWithCustomParser")]
        public ActionResult ValidateJavaCode(List<string> codes)
        {
            if (codes == null || codes.Count < 1)
            {
                return BadRequest("There are not enough codes to analyze.");
            }

            List<Result<object[]>> results = [];

            foreach (var code in codes)
            {
                try
                {
                    AntlrInputStream inputStream = new(code);
                    JavaLexer lexer = new(inputStream);
                    CommonTokenStream commonTokenStream = new(lexer);
                    JavaParser parser = new(commonTokenStream)
                    {
                        BuildParseTree = true
                    };

                    // Crear y agregar el ErrorListener personalizado
                    CustomErrorListener.LexerErrorListener lexerErrorListener = new();
                    CustomErrorListener.ParserErrorListener parserErrorListener = new();
                    lexer.RemoveErrorListeners();
                    lexer.AddErrorListener(lexerErrorListener);
                    parser.RemoveErrorListeners();
                    parser.AddErrorListener(parserErrorListener);

                    IParseTree tree = parser.compilationUnit();

                    // Verificar si hay errores de sintaxis
                    bool isValid = parser.NumberOfSyntaxErrors == 0;

                    if(isValid)
                    {
                        // Crear un resultado con el árbol de sintaxis
                        results.Add(new 
                        (
                            true,
                            "Success",
                            new object[]
                            {
                                tree.ToStringTree(parser),
                                BodyGenerator.ParseSyntaxTree(tree),
                                BodyGenerator.ParseClassInput(BodyGenerator.ParseSyntaxTree(tree))
                            }
                        ));
                    }
                    else
                    {
                        if(lexerErrorListener.Errors.Count > 0 && parserErrorListener.Errors.Count > 0)
                        {
                            results.Add(new
                            (
                                false, 
                                "Error: Lexer and Parser errors", 
                                [lexerErrorListener.Errors, parserErrorListener.Errors]
                            ));
                        }
                        else if(lexerErrorListener.Errors.Count > 0)
                        {
                            results.Add(new
                            (
                                false, 
                                "Error: Lexer errors", 
                                [lexerErrorListener.Errors])
                            );
                        }
                        else if(parserErrorListener.Errors.Count > 0)
                        {
                            results.Add(new
                            (
                                false, 
                                "Error: Parser errors", 
                                [parserErrorListener.Errors])
                            );
                        }
                    }
                }
                catch (Exception ex)
                {
                    results.Add(new 
                    (
                        false,
                        $"Error: {ex.Message}",
                        []
                    ));
                }
            }

            return Ok(results);
        }

        [HttpPost]
        [Route("Create")]
        public async Task<ActionResult> Create(AssignmentRequest assignmentRequest)
        {
            try
            {
                if(assignmentRequest.SubmissionDate.ToUniversalTime() < DateTime.UtcNow)
                {
                    return BadRequest("The submission date must be greater than the current date.");
                }

                var id = Guid.NewGuid();
                await _context!.Assignments!.AddAsync(new Assignment()
                {
                    Id = id,
                    Description = assignmentRequest.Description,
                    Title = assignmentRequest.Title,
                    //Tiempo universal coordinado (UTC)
                    SubmissionDate = assignmentRequest.SubmissionDate.ToUniversalTime(),
                    CourseId = assignmentRequest.CourseId
                });

                await _context.SaveChangesAsync();
                return Ok(id);
            }
            catch(Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        /// <summary>
        /// Analiza el código de una asignación
        /// </summary>
        /// <param name="baseRequest"></param>
        /// <param name="assignmentId"></param>
        /// <returns></returns>
        [HttpPost]
        [Route("Analyze")]
        public async Task<ActionResult> Analyze(Guid assignmentId)
        {
            var assignment = await _context!.Assignments!.FindAsync(assignmentId);

            if (assignment == null)
            {
                return NotFound("The assignment not exist.");
            }

            var studentsSubmissions = await _context!.Submissions!
                .Where(submission => submission.AssignmentId == assignmentId)
                .Include(submission => submission.Student)
                .Select(submission => new Submission
                {
                    Id = submission.Id,
                    Url = submission.Url,
                    SubmissionDate = submission.SubmissionDate,
                    StudentId = submission.StudentId,
                    Student = new Student { 
                        FirstName = submission.Student!.FirstName,
                        LastName = submission.Student!.LastName
                    },
                })
                .ToListAsync();
            
            // Verificar que haya al menos 2 entregas
            if (studentsSubmissions == null || studentsSubmissions.Count < 2)
            {
                return BadRequest("There are not enough submissions to analyze.");
            }

            // Verificar que todos los Student no sean nulos
            if (studentsSubmissions.Any(submission => submission.Student == null))
            {
                return BadRequest("Error in DataBase");
            }
            
            WebScraping scraper = new();

            Dictionary<Guid, StudentSubmission> analysisResult = await scraper.StartScraping(studentsSubmissions);
            
            if(analysisResult == null || analysisResult.Count <= 0)
            {
                return BadRequest("Error in scraping");
            }

            string analysisResultJson = JsonConvert.SerializeObject(analysisResult);

            if(!assignment.IsAnalyzed && assignment.AnalysisDate == DateTime.MinValue)
            {
                BackgroundJob.Schedule(() =>
                    HttpContext.RequestServices
                        .GetRequiredService<HangFireServices>()
                        .SavePlagiarismReport(assignmentId, new string(analysisResultJson), new Dictionary<Guid, StudentSubmission>(analysisResult)),
                    new DateTimeOffset(DateTime.UtcNow)
                );
            }

            var document = ReportGenerator.GenerateReport(analysisResult);
            
            // Convertir el PDF a un array de bytes
            using (var memoryStream = new MemoryStream())
            {
                document.Save(memoryStream);
                var pdfBytes = memoryStream.ToArray();

                return File(pdfBytes, "application/pdf", $"PlagiarismReport-{assignmentId}.pdf");
            }
        }

        [HttpPost]
        [Route("DolosAnalysis")]
        public async Task<ActionResult> DolosAnalysis(Guid assignmentId)
        {
            var assignment = await _context!.Assignments!
                .Include(a => a.Course)
                .ThenInclude(c => c!.Teacher)
                .FirstOrDefaultAsync(a => a.Id == assignmentId);


            if (assignment == null)
            {
                return NotFound("The assignment not exist.");
            }

            var studentsSubmissions = await _context!.Submissions!
                .Where(submission => submission.AssignmentId == assignmentId)
                .Include(submission => submission.Student)
                .Select(submission => new Submission
                {
                    Id = submission.Id,
                    Url = submission.Url,
                    SubmissionDate = submission.SubmissionDate,
                    StudentId = submission.StudentId,
                    Student = new Student
                    {
                        FirstName = submission.Student!.FirstName,
                        LastName = submission.Student!.LastName
                    },
                })
                .ToListAsync();

            // Verificar que haya al menos 2 entregas
            if (studentsSubmissions == null || studentsSubmissions.Count < 2)
            {
                return BadRequest("There are not enough submissions to analyze.");
            }

            // Verificar que todos los Student no sean nulos
            if (studentsSubmissions.Any(submission => submission.Student == null))
            {
                return BadRequest("Error in DataBase");
            }

            Dictionary<string, List<(string fileName, string content)>> studentFiles = [];

            foreach (var studentsSubmission in studentsSubmissions)
            {
                var codes = await _context!.Codes!
                    .Where(code => code.SubmissionId == studentsSubmission.Id)
                    .Select(code => new Code
                    {
                        FileName = code.FileName,
                        Content = code.Content
                    })
                    .ToListAsync();

                studentFiles.Add(
                    $"{studentsSubmission.SubmissionDate:yyyy-MM-dd-HH-mm}_{studentsSubmission.Student!.FirstName}-{studentsSubmission.Student.LastName}",
                    new List<(string fileName, string content)>
                    (
                        codes.Select(code => (code.FileName, code.Content)).ToList()!
                    )
                );
            }

            var result = await DolosZipGenerator.GenerateAssignmentFolder(assignment, studentFiles);

            if (result == null)
            {
                return BadRequest("Error: There was a problem with the fetch operation");
            }
            else if (!result.Success)
            {
                return BadRequest($"Error: {result.Message}");
            }

            assignment.DolosURLId = result.Data!.Id;

            await _context.SaveChangesAsync();

            BackgroundJob.Schedule(() =>
                    HttpContext.RequestServices
                        .GetRequiredService<HangFireServices>()
                        .AssignmentDolosAnalysisEmail(
                        result.Data.HTML_URL!, 
                        assignment.Course!.Teacher!.Email!, 
                        $"{assignment.Course!.Teacher!.FirstName} {assignment.Course.Teacher.LastName}",
                        assignment.Course!.Name!,
                        assignment.Title!
                    ),
                    new DateTimeOffset(DateTime.UtcNow)
                );

            return Ok(result);
        }

        /// <summary>
        /// Análisis del plagio de una asignación usando Dolos. Se envía a un correo especificado.
        /// </summary>
        /// <param name="assignmentId">Id de la Asignación.</param>
        /// <param name="email">Dirección de email donde se envía la notificación.</param>
        /// <returns></returns>
        [HttpPost]
        [Route("DolosAnalysisCustomEmail")]
        public async Task<ActionResult> DolosAnalysisCustomEmail(Guid assignmentId, string email)
        {
            var assignment = await _context!.Assignments!
                .Include(a => a.Course)
                .FirstOrDefaultAsync(a => a.Id == assignmentId);


            if (assignment == null)
            {
                return NotFound("The assignment not exist.");
            }

            var studentsSubmissions = await _context!.Submissions!
                .Where(submission => submission.AssignmentId == assignmentId)
                .Include(submission => submission.Student)
                .Select(submission => new Submission
                {
                    Id = submission.Id,
                    Url = submission.Url,
                    SubmissionDate = submission.SubmissionDate,
                    StudentId = submission.StudentId,
                    Student = new Student
                    {
                        FirstName = submission.Student!.FirstName,
                        LastName = submission.Student!.LastName
                    },
                })
                .ToListAsync();

            // Verificar que haya al menos 2 entregas
            if (studentsSubmissions == null || studentsSubmissions.Count < 2)
            {
                return BadRequest("There are not enough submissions to analyze.");
            }

            // Verificar que todos los Student no sean nulos
            if (studentsSubmissions.Any(submission => submission.Student == null))
            {
                return BadRequest("Error in DataBase");
            }

            Dictionary<string, List<(string fileName, string content)>> studentFiles = [];

            foreach (var studentsSubmission in studentsSubmissions)
            {
                var codes = await _context!.Codes!
                    .Where(code => code.SubmissionId == studentsSubmission.Id)
                    .Select(code => new Code
                    {
                        FileName = code.FileName,
                        Content = code.Content
                    })
                    .ToListAsync();

                studentFiles.Add(
                    $"{studentsSubmission.SubmissionDate:yyyy-MM-dd-HH-mm}_{studentsSubmission.Student!.FirstName}-{studentsSubmission.Student.LastName}",
                    new List<(string fileName, string content)>
                    (
                        codes.Select(code => (code.FileName, code.Content)).ToList()!
                    )
                );
            }

            var result = await DolosZipGenerator.GenerateAssignmentFolder(assignment, studentFiles);

            if (result == null)
            {
                return BadRequest("Error: There was a problem with the fetch operation");
            }
            else if (!result.Success)
            {
                return BadRequest($"Error: {result.Message}");
            }

            assignment.DolosURLId = result.Data!.Id;

            await _context.SaveChangesAsync();
            BackgroundJob.Schedule(() =>
                HttpContext.RequestServices
                .GetRequiredService<HangFireServices>()
                .AssignmentDolosAnalysisEmail
                (
                    result.Data.HTML_URL!,
                    email,
                    assignment.Course!.Name!,
                    assignment.Title!
                ),
                new DateTimeOffset(DateTime.UtcNow)
            );

            return Ok(result);
        }

        [HttpGet]
        [Route("GetAllByCourse")]
        public async Task<ActionResult> GetAllByCourse(Guid courseId)
        {
            try
            {
                var verifyTokenResult = VerifyToken(User.FindFirst("Scope")?.Value! , typeof(Teacher).Name);

                if (!verifyTokenResult.Success)
                {
                    return Unauthorized(verifyTokenResult.Message);
                }

                var userIdClaim = User.FindFirst("Id")?.Value;

                var course = await _context!.Courses!.FindAsync(courseId);
                if (course == null)
                {
                    return NotFound();
                }
                else
                {
                    var assignments = await _context!.Assignments!.Where(a => a.CourseId == courseId).ToListAsync();
                    if (assignments == null || assignments.Count < 1)
                    {
                        return NotFound("There are not assignments in this course.");
                    }

                    return Ok(assignments);
                }
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpGet]
        [Route("GetAllByCourseForStudent")]
        public async Task<ActionResult> GetAllByCourseForStudent(Guid studentId, Guid courseId)
        {
            try
            {
                var student = await _context!.Students!.FindAsync(studentId);
                if (student == null)
                {
                    return NotFound("Student not exist");
                }
                var course = await _context!.Courses!.FindAsync(courseId);
                if (course == null)
                {
                    return NotFound("Course not exist");
                }
                var assignments = await _context!.Assignments!
                    .Where(a => a.CourseId == courseId)
                    .Select(a => new Assignment
                    {
                        Id = a.Id,
                        Title = a.Title,
                        Description = a.Description,
                        SubmissionDate = a.SubmissionDate,
                    })
                    .ToListAsync();

                if (assignments == null || assignments.Count < 1)
                {
                    return NotFound("There are not assignments in this course.");
                }

                var submissions = await _context!.Submissions!
                    .Where(s => s.StudentId == studentId && s.Assignment!.CourseId == courseId)
                    .Include(s => s.Assignment)
                    .Select(s => new Submission
                    {
                        Id = s.Id,
                        Url = s.Url,
                        SubmissionDate = s.SubmissionDate,
                        Grade = s.Grade,
                        AssignmentId = s.AssignmentId,
                    })
                    .ToListAsync();
                var assignmentsSubmissions = new List<AssignmentSubmissionResponse>();
                foreach (var assignment in assignments)
                {
                    var submission = submissions.FirstOrDefault(s => s.AssignmentId == assignment.Id);
                    assignmentsSubmissions.Add(new AssignmentSubmissionResponse { Assignment = assignment, Submission = submission! });
                }
                var response = assignmentsSubmissions as object;
                return Ok(response);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpPut]
        [Route("Update")]
        public async Task<ActionResult> Update(AssignmentUpdateRequest assignmentUpdateRequest)
        {
            var assignment = await _context!.Assignments!.FindAsync(assignmentUpdateRequest.Id);

            if (assignment == null)
            {
                return NotFound();
            }

            assignment.Description = assignmentUpdateRequest.Description;
            assignment.Title = assignmentUpdateRequest.Title;
            assignment.SubmissionDate = assignmentUpdateRequest.SubmissionDate;

            await _context.SaveChangesAsync();
            return Ok();
        }

        [HttpDelete]
        [Route("Delete")]
        public async Task<ActionResult> Delete(Guid id)
        {
            try
            {
                var assignment = await _context!.Assignments!.FindAsync(id);

                if (assignment == null)
                {
                    return NotFound("Assignment not exist");
                }

                var course = await _context!.Courses!.FindAsync(assignment.CourseId);

                if (course != null && course.IsArchived)
                {
                    return BadRequest("The course is archived");
                }

                _context.Assignments.Remove(assignment!);

                await _context.SaveChangesAsync();
                return Ok();
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        
        [HttpGet]
        [Route("GetById")]
        public async Task<ActionResult> GetById(Guid id)
        {
            var assignment = await _context!.Assignments!.FindAsync(id);

            if (assignment == null)
            {
                return NotFound();
            }

            return Ok(new Assignment()
            {
                Id = assignment.Id,
                Title = assignment.Title,
                Description = assignment.Description,
                SubmissionDate = assignment.SubmissionDate,
                CourseId = assignment.CourseId
            });
        }
    }
}