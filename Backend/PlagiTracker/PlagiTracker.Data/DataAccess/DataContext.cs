using Microsoft.EntityFrameworkCore;
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
        public DbSet<PlagiarismCode>? PlagiarismCodes { get; set; }

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
                builder.HasKey(enrollment => new { enrollment.StudentId, enrollment.CourseId });

                // Configura la columna como decimal con 2 valores enteros y con 2 decimales
                builder.Property(enrollment => enrollment.Grade).HasColumnType("decimal(4, 2)");
            });

            //Tarea
            modelBuilder.Entity<Assignment>().HasIndex(a => a.Title).IsUnique();

            //Entrega
            modelBuilder.Entity<Submission>(builder =>
            {
                builder.HasIndex(s => s.Url).IsUnique();
                // Configura la columna como decimal con 2 valores enteros y con 2 decimales
                builder.Property(s => s.Grade).HasColumnType("decimal(4, 2)");
            });

            //Plagio
            modelBuilder.Entity<Plagiarism>(builder =>
            {
                // Configura la columna como decimal con 3 valores enteros y con 2 decimales
                builder.Property(p => p.Similarity).HasColumnType("decimal(5, 2)");
            });

            //Códgio Plagiado
            modelBuilder.Entity<PlagiarismCode>(builder =>
            {
                builder.HasKey(plagiarismCode => new
                {
                    plagiarismCode.PlagiarismId,
                    plagiarismCode.CodeId
                });
            });
        }
    }
}