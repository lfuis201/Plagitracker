// Ignore Spelling: Dolos

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
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class AssignmentController(DataContext context) : CustomControllerBase(context)
    {
        // Mensaje de excepción de clave duplicada
        const string DUPLICATE_KEY_VALUE_EXCEPTION_MESSAGE = "23505: duplicate key value violates unique constraint";
        
        // Mensaje de excepción de título duplicado
        const string TITLE_ALREADY_USED_EXCEPTION_MESSAGE = "IX_Assignments_CourseId_Title";

        [AllowAnonymous]
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

        [AllowAnonymous]
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

        [AllowAnonymous]
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
        [AllowAnonymous]
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

        /// <summary>
        /// Crea una nueva asignación
        /// </summary>
        /// <param name="assignmentRequest"></param>
        /// <returns></returns>
        [HttpPost]
        [Route("Create")]
        public async Task<ActionResult> Create(AssignmentRequest assignmentRequest)
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

                // Crear una nueva asignación

                // Verificar que la fecha de entrega sea menor a la fecha actual
                if (assignmentRequest.SubmissionDate.ToUniversalTime() < DateTime.UtcNow)
                {
                    return BadRequest(new
                    {
                        Success = false,
                        Message = "The submission date must be greater than the current date"
                    });
                }

                var course = await _context!.Courses!.FindAsync(assignmentRequest.CourseId);
                
                // Verificar que el curso exista.
                if (course == null)
                {
                    return NotFound(new
                    {
                        Success = false,
                        Message = "The course not exist"
                    });
                }
                // Verificar que el curso no esté archivado.
                else if (course.IsArchived)
                {
                    return BadRequest(new {
                        Success = false,
                        Message = "The course is archived"
                    });
                }
                // Verificar que el usuario sea el profesor del curso
                else if (course.TeacherId != userIdClaim)
                {
                    return Unauthorized(new
                    {
                        Success = false,
                        Message = "You are not the teacher of this course"
                    });
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

                return Ok(new
                {
                    Success = true,
                    Message = "Assignment created",
                    Data = id
                });
            }
            catch(Exception ex)
            {
                if (
                    ex.InnerException != null
                    && ex.InnerException.Message.Contains(DUPLICATE_KEY_VALUE_EXCEPTION_MESSAGE)
                    && ex.InnerException.Message.Contains(TITLE_ALREADY_USED_EXCEPTION_MESSAGE)
                )
                {
                    return Conflict(new 
                    {
                        Success = false,
                        Message = "Title already used"
                    });
                }

                return BadRequest(new
                {
                    Success = false,
                    Message = ex.InnerException?.Message ?? ex.Message
                });
            }
        }

        // MEJORAR PARA JWT
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

        /// <summary>
        /// Análisis del plagio de una asignación usando Dolos. Se envía un correo al profesor.
        /// </summary>
        /// <param name="assignmentId">Id de la Asignación.</param>
        /// <returns></returns>
        [HttpPost]
        [Route("DolosAnalysis")]
        public async Task<ActionResult> DolosAnalysis(Guid assignmentId)
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

                // Analizar la asignación con Dolos

                var assignment = await _context!.Assignments!
                    .Include(a => a.Course)
                    .ThenInclude(c => c!.Teacher)
                    .FirstOrDefaultAsync(a => a.Id == assignmentId);

                // Verificar que la asignación exista
                if (assignment == null)
                {
                    return NotFound(new
                    {
                        Success = false,
                        Message = "The assignment not exist."
                    });
                }
                // Verificar que el usuario sea el profesor del curso
                else if (assignment.Course!.TeacherId != userIdClaim)
                {
                    return Unauthorized(new
                    {
                        Success = false,
                        Message = "You are not the teacher of this course."
                    });
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
                    return BadRequest(new
                    {
                        Success = false,
                        Message = "There are not enough submissions to analyze"
                    });
                }
                // Verificar que todos los Student no sean nulos
                else if (studentsSubmissions.Any(submission => submission.Student == null))
                {
                    return BadRequest(new
                    {
                        Success = false,
                        Message = "Error in DataBase"
                    });
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

                // Verificar que el resultado del análisis de Dolos no sea nulo
                if (result == null)
                {
                    return BadRequest(new
                    {
                        Success = false,
                        Message = "There was a problem with the fetch operation"
                    });
                }
                // Verificar que el resultado haya sido exitoso
                else if (!result.Success)
                {
                    return BadRequest(new
                    {
                        Success = false,
                        Message = result.Message!
                    });
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
            catch (Exception ex)
            {
                return BadRequest(new
                {
                    Success = false,
                    Message = ex.InnerException?.Message ?? ex.Message
                });
            }
        }

        //AÑADIR OPCIONES PARA ENVIAR ARCHIVOS, URLS (SIN ID DE ASIGNACIÓN)
        /// <summary>
        /// Análisis del plagio de una asignación usando Dolos. Se envía a un correo especificado.
        /// </summary>
        /// <param name="assignmentId">Id de la Asignación.</param>
        /// <param name="email">Dirección de email donde se envía la notificación.</param>
        /// <returns></returns>
        [AllowAnonymous]
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

        /// <summary>
        /// Obtiene todas las asignaciones de un curso para un profesor
        /// </summary>
        /// <param name="courseId"></param>
        /// <returns></returns>
        [HttpGet]
        [Route("GetAllByCourseForTeacher")]
        public async Task<ActionResult> GetAllByCourseForTeacher(Guid courseId)
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

                var course = await _context!.Courses!.FindAsync(courseId);

                // Verificar que el curso exista
                if (course == null)
                {
                    return NotFound(new
                    {
                        Success = false,
                        Message = "The course not exist"
                    });
                }
                // Verificar que el profesor sea el dueño del curso
                else if (course.TeacherId != userIdClaim)
                {
                    return Unauthorized(new
                    {
                        Success = false,
                        Message = "You are not the teacher of this course"
                    });
                }
                else
                {
                    var assignments = await _context!.Assignments!
                        .Where(assignment => assignment.CourseId == courseId)
                        .Select(assignment => new AssignmentResponse
                        {
                            Id = assignment.Id,
                            Description = assignment.Description,
                            Title = assignment.Title,
                            SubmissionDate = assignment.SubmissionDate,
                            AnalysisDate = assignment.AnalysisDate,
                            IsAnalyzed = assignment.IsAnalyzed,
                            DolosURLId = assignment.DolosURLId,
                            CreatedAt = assignment.CreatedAt,
                            UpdatedAt = assignment.UpdatedAt,
                            CourseId = assignment.CourseId,
                        })
                        .ToListAsync();

                    // Verificar que haya al menos una asignación
                    if (assignments == null || assignments.Count < 1)
                    {
                        return NotFound(new
                        {
                            Success = false,
                            Message = "There are not assignments in this course"
                        });
                    }

                    return Ok(new
                    {
                        Success = true,
                        Data = assignments
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
        /// Obtiene todas las asignaciones de un curso para un estudiante
        /// </summary>
        /// <param name="courseId"></param>
        /// <returns></returns>
        [HttpGet]
        [Route("GetAllByCourseForStudent")]
        public async Task<ActionResult> GetAllByCourseForStudent(Guid courseId)
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

                var course = await _context!.Courses!.FindAsync(courseId);

                // Verificar que el curso exista
                if (course == null)
                {
                    return NotFound(new
                    {
                        Success = false,
                        Message = "The course not exist"
                    });
                }

                var enrollment = await _context!.Enrollments!.FirstOrDefaultAsync(e => e.StudentId == userIdClaim && e.CourseId == courseId);
                
                // Verificar que el estudiante esté inscrito en el curso
                if (enrollment == null)
                {
                    return Unauthorized(new
                    {
                        Success = false,
                        Message = "You are not enrolled in this course"
                    });
                }

                var assignments = await _context!.Assignments!
                    .Where(a => a.CourseId == courseId)
                    .Select(a => new AssignmentSubmissionResponse.AssignmentResponse
                    {
                        Id = a.Id,
                        Title = a.Title,
                        Description = a.Description,
                        SubmissionDate = a.SubmissionDate,
                        AnalysisDate = a.AnalysisDate,
                        IsAnalyzed = a.IsAnalyzed,
                        CreatedAt = a.CreatedAt,
                        UpdatedAt = a.UpdatedAt,
                        CourseId = a.CourseId,
                    })
                    .ToListAsync();

                // Verificar que haya al menos una asignación
                if (assignments == null || assignments.Count < 1)
                {
                    return NotFound(new
                    {
                        Success = false,
                        Message = "There are not assignments in this course"
                    });
                }

                var submissions = await _context!.Submissions!
                    .Where(s => s.StudentId == userIdClaim && s.Assignment!.CourseId == courseId)
                    .Include(s => s.Assignment)
                    .Select(s => new AssignmentSubmissionResponse.SubmissionResponse
                    {
                        Id = s.Id,
                        Url = s.Url,
                        SubmissionDate = s.SubmissionDate,
                        Grade = s.Grade,
                        UpdatedAt = s.UpdatedAt,
                        AssignmentId = s.AssignmentId,
                    })
                    .ToListAsync();

                List<AssignmentSubmissionResponse> assignmentsSubmissions = [];

                foreach (var assignment in assignments)
                {
                    var submission = submissions.FirstOrDefault(s => s.AssignmentId == assignment.Id);
                    assignmentsSubmissions.Add(new AssignmentSubmissionResponse { Assignment = assignment, Submission = submission! });
                }

                return Ok(new
                {
                    Success = true,
                    Data = assignmentsSubmissions
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
        /// Actualiza una asignación
        /// </summary>
        /// <param name="assignmentUpdateRequest"></param>
        /// <returns></returns>
        [HttpPut]
        [Route("Update")]
        public async Task<ActionResult> Update(AssignmentUpdateRequest assignmentUpdateRequest)
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

                var assignment = await _context!.Assignments!.FindAsync(assignmentUpdateRequest.Id);

                // Verificar que la asignación exista
                if (assignment == null)
                {
                    return NotFound(new
                    {
                        Success = false,
                        Message = "Assignment not exist"
                    });
                }
                // Verificar que la fecha de entrega sea menor a la fecha actual, debe haber un margen de 2 minutos
                else if (assignmentUpdateRequest.SubmissionDate.ToUniversalTime() < DateTime.UtcNow.AddMinutes(2))
                {
                    return BadRequest(new
                    {
                        Success = false,
                        Message = "The submission date must be greater than the current date"
                    });
                }
                
                assignment.Title = assignmentUpdateRequest.Title;
                assignment.Description = assignmentUpdateRequest.Description;
                assignment.SubmissionDate = assignmentUpdateRequest.SubmissionDate;
                assignment.UpdatedAt = assignmentUpdateRequest.UpdateAt == DateTime.MinValue ? assignmentUpdateRequest.UpdateAt : DateTime.UtcNow;

                await _context.SaveChangesAsync();

                return Ok(new
                {
                    Success = true,
                    Message = "Assignment updated"
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

        [HttpDelete]
        [Route("Delete")]
        public async Task<ActionResult> Delete(Guid id)
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

                var assignment = await _context!.Assignments!
                    .Include(a => a.Course)
                    .FirstOrDefaultAsync(a => a.Id == id);

                // Verificar que la asignación exista
                if (assignment == null)
                {
                    return NotFound(new
                    {
                        Success = false,
                        Message = "Assignment not exist"
                    });
                }
                // Verificar que el usuario sea el profesor del curso
                else if (assignment.Course!.TeacherId != userIdClaim)
                {
                    return Unauthorized(new
                    {
                        Success = false,
                        Message = "You are not the teacher of this course"
                    });
                }
                // Verificar que la asignación no haya sido eliminada
                else if (!assignment.IsEnabled)
                {
                    return BadRequest(new
                    {
                        Success = false,
                        Message = "Assignment already deleted"
                    });
                }

                assignment.IsEnabled = false;
                assignment.UpdatedAt = DateTime.UtcNow;

                await _context.SaveChangesAsync();
                return Ok(new
                {
                    Success = true,
                    Message = "Assignment deleted"
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