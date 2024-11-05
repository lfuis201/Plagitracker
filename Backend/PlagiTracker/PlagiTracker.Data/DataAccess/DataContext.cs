﻿using Microsoft.EntityFrameworkCore;
using PlagiTracker.Data.Entities;

namespace PlagiTracker.Data.DataAccess
{
    public class DataContext(DbContextOptions<DataContext> options) : DbContext(options)
    {
        public DbSet<User>? Users { get; set; }
        public DbSet<Teacher>? Teachers { get; set; }
        public DbSet<Student>? Students { get; set; }
        public DbSet<Course>? Courses { get; set; }
        public DbSet<Enrollment>? Enrollments { get; set; }
        public DbSet<Assignment>? Assignments { get; set; }
        public DbSet<Submission>? Submissions { get; set; }
        public DbSet<Plagiarism>? Plagiarisms { get; set; }
        public DbSet<Code>? Codes { get; set; }
        public DbSet<Exercise>? Exercises { get; set; }
        public DbSet<Class>? Classes { get; set; }
        public DbSet<Function>? Functions { get; set; }

        /// <summary>
        /// Configuraciones adicionales para la base de datos como columnas únicas
        /// </summary>
        /// <param name="modelBuilder"></param>
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            //Usuario
            //El email debe ser único
            modelBuilder.Entity<User>().HasIndex(u => u.Email).IsUnique();

            //Configuracón para que el nombre completo sea único
            //modelBuilder.Entity<Student>().HasIndex(u => new { u.FirstName, u.LastName }).IsUnique();

            //Profesor
            modelBuilder.Entity<Teacher>(builder =>
            {
                builder.ToTable("Teachers");
            });

            //Estudiante
            modelBuilder.Entity<Student>(builder =>
            {
                builder.ToTable("Students");
            });

            //Inscripción
            modelBuilder.Entity<Enrollment>(builder =>
            {
                builder.HasKey(enrollment => new 
                { 
                    enrollment.StudentId, 
                    enrollment.CourseId,
                });

                // Configura la columna como decimal con 2 valores enteros y con 2 decimales
                builder.Property(enrollment => enrollment.Grade).HasColumnType("decimal(4, 2)");
            });

            //Tarea
            modelBuilder.Entity<Assignment>().HasIndex(a => a.Title).IsUnique();

            //Entrega
            modelBuilder.Entity<Submission>(builder =>
            {
                // Configura la concatenación del Id del Estudiante y el Id de la Asignación como única
                builder.HasIndex(s => new 
                {
                    s.StudentId, 
                    s.AssignmentId,
                }).IsUnique();

                // Configura la Url como única 
                builder.HasIndex(s => s.Url).IsUnique();
                
                // Configura la columna como decimal con 2 valores enteros y con 2 decimales
                builder.Property(s => s.Grade).HasColumnType("decimal(4, 2)");
            });
            
            //Código
            modelBuilder.Entity<Code>(builder =>
            {
                // Configura la concatenación del Id de la Entrega y el Nombre del Archivo como única
                builder.HasIndex(code => new
                {
                    code.SubmissionId,
                    code.FileName,
                }).IsUnique();
            });

            //Plagio
            modelBuilder.Entity<Plagiarism>(builder =>
            {
                // Configura la concatenación del Id del Estudiante y el Id de la Asignación como única
                builder.HasIndex(plagiarism => new 
                { 
                    plagiarism.Id,
                    plagiarism.CodeId, 
                    plagiarism.Algorithm,
                }).IsUnique();

                // Configura la columna como decimal con 3 valores enteros y con 2 decimales
                builder.Property(p => p.Similarity).HasColumnType("decimal(5, 2)");
            });

            // Ejercicio
            modelBuilder.Entity<Exercise>(builder =>
            {
                builder.HasIndex(exercise => new
                {
                    exercise.AssignmentId,
                    exercise.Name,
                }).IsUnique();
            });

            // Clase
            modelBuilder.Entity<Class>(builder =>
            {
                builder.HasIndex(classEntity => new
                {
                    classEntity.ExerciseId,
                    classEntity.Name,
                }).IsUnique();
            });

            // Función
            modelBuilder.Entity<Function>(builder =>
            {
                builder.HasIndex(function => new
                {
                    function.ClassId,
                    function.Name,
                    function.Type,
                    function.ParameterTypes,
                }).IsUnique();
            });

            // Parámetro
            modelBuilder.Entity<Parameter>(builder =>
            {
                builder.HasIndex(parameter => new
                {
                    parameter.FunctionId,
                    parameter.Name,
                    parameter.Type,
                }).IsUnique();
            });
        }
    }
}