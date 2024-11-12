using PlagiTracker.Data.Entities;


namespace PlagiTracker.Data.Requests
{
    public class AssignmentRequest
    {
        public string? Description { get; set; }

        public string? Title { get; set; }

        public Guid CourseId { get; set; }

        public DateTime SubmissionDate { get; set; }

        public List<ExerciseRequest>? Exercises { get; set; }

        public static List<ClassRequest> ParseTextToClassRequests(string text)
        {
            var classRequests = new List<ClassRequest>();
            var tokens = text.Split(new[] { ' ', '{', '}', '(', ')', '[', ']', ';' }, StringSplitOptions.RemoveEmptyEntries);

            ClassRequest currentClass = null;
            FunctionRequest currentFunction = null;

            foreach (var token in tokens)
            {
                if (token == "class")
                {
                    if (currentClass != null)
                    {
                        classRequests.Add(currentClass);
                    }
                    currentClass = new ClassRequest
                    {
                        Functions = new List<FunctionRequest>()
                    };
                }
                else if (token == "void" || token == "int" || token == "String" || token == "Person")
                {
                    if (currentFunction != null)
                    {
                        currentClass.Functions.Add(currentFunction);
                    }
                    currentFunction = new FunctionRequest
                    {
                        Type = token,
                        Parameters = new List<ParameterRequest>()
                    };
                }
                else if (currentFunction != null && currentFunction.Name == null)
                {
                    currentFunction.Name = token;
                }
                else if (currentFunction != null)
                {
                    var parameter = new ParameterRequest
                    {
                        Type = currentFunction.Type,
                        Name = token
                    };
                    currentFunction.Parameters.Add(parameter);
                }
                else if (currentClass != null && currentClass.Name == null)
                {
                    currentClass.Name = token;
                }
            }

            if (currentClass != null)
            {
                classRequests.Add(currentClass);
            }

            return classRequests;
        }

    }

    public class ExerciseRequest
    {   
        public string? Name { get; set; }

        public string? Description { get; set; }

        public bool HaveBody { get; set; } = false;

        public List<ClassRequest>? Classes { get; set; }
    }

    public class ClassRequest
    {
        public string? Name { get; set; }

        public string? Description { get; set; }

        public List<ClassRequest>? ChildClasses { get; set; }

        public List<FunctionRequest>? Functions { get; set; }
    }

    public class FunctionRequest
    {
        public string? Name { get; set; }

        public string? Type { get; set; }

        public string? Description { get; set; }

        public List<ParameterRequest>? Parameters { get; set; }
    }

    public class ParameterRequest
    {
        public string? Name { get; set; }

        public string? Type { get; set; }

        public string? Description { get; set; }
    }
}