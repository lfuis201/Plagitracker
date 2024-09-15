using Microsoft.EntityFrameworkCore;
using PlagiTracker.Data.Entities;

namespace PlagiTracker.Data.DataAccess
{
    public class DataContext(DbContextOptions<DataContext> options) : DbContext(options)
    {
        public DbSet<Teacher>? Teachers { get; set; }
        public DbSet<Student>? Students { get; set; }
        public DbSet<Course>? Courses { get; set; }
        public DbSet<Enrollment>? Enrollments { get; set; }
        public DbSet<Assignment>? Assignments { get; set; }
        public DbSet<Submission>? Submissions { get; set; }

        /// <summary>
        /// Configuraciones adicionales para la base de datos como columnas únicas
        /// </summary>
        /// <param name="modelBuilder"></param>
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            //Profesor
            modelBuilder.Entity<Teacher>().HasIndex(t => t.Email).IsUnique();

            //Estudiante
            modelBuilder.Entity<Student>().HasIndex(s => s.Email).IsUnique();
            modelBuilder.Entity<Student>().HasIndex(s => new { s.FirstName, s.LastName }).IsUnique();

            //Curso
            modelBuilder.Entity<Course>().HasIndex(c => c.Name).IsUnique();

            //Inscripción
            modelBuilder.Entity<Enrollment>().HasKey(e => new { e.StudentId, e.CourseId });

            //Tarea
            modelBuilder.Entity<Assignment>().HasIndex(a => a.Title).IsUnique();

            //Entrega
            modelBuilder.Entity<Submission>().HasIndex(s => s.Url).IsUnique();
        }
    }
}