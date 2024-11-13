﻿using PlagiTracker.Data.Entities;


namespace PlagiTracker.Data.Requests
{
    public class AssignmentRequest
    {
        public string? Description { get; set; }

        public string? Title { get; set; }

        public Guid CourseId { get; set; }

        public DateTime SubmissionDate { get; set; }

        public List<ExerciseRequest>? Exercises { get; set; }
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