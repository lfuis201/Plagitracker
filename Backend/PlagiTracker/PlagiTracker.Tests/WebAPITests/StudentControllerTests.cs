using Microsoft.AspNetCore.Mvc;
using PlagiTracker.Data.DataAccess;
using PlagiTracker.Data.Entities;
using PlagiTracker.Data.Requests;
using PlagiTracker.WebAPI.Controllers;
using System.Text;

namespace PlagiTracker.Tests.WebAPITests
{
    [TestClass]
    public class StudentControllerTests
    {
        private DataContext _context;
        private StudentController _controller;

        [TestInitialize]
        public void Setup()
        {
            _context = TestDbContextFactory.CreateInMemoryDbContext();
            _controller = new StudentController(_context);
        }

        [TestMethod]
        public async Task SignUp_ReturnsOkResult()
        {
            // Arrange
            var signUpRequest = new SignUpRequest
            {
                FirstName = "John",
                LastName = "Doe",
                Email = "john.doe@example.com",
                PasswordHash = Encoding.UTF8.GetBytes("password")
            };

            // Act
            var result = await _controller.SignUp(signUpRequest);

            // Assert
            Assert.IsInstanceOfType(result, typeof(OkResult));
        }

        [TestMethod]
        public async Task SignUp_ReturnsConflict_WhenEmailAlreadyUsed()
        {
            // Arrange
            var existingStudent = new Student
            {
                Id = Guid.NewGuid(),
                FirstName = "Jane",
                LastName = "Doe",
                Email = "jane.doe@example.com",
                PasswordHash = Encoding.UTF8.GetBytes("password")
            };
            await _context.Students.AddAsync(existingStudent);
            await _context.SaveChangesAsync();

            var signUpRequest = new SignUpRequest
            {
                FirstName = "John",
                LastName = "Doe",
                Email = "jane.doe@example.com", // Same email as existing student
                PasswordHash = Encoding.UTF8.GetBytes("password")
            };

            // Act
            var result = await _controller.SignUp(signUpRequest);

            // Assert
            Assert.IsInstanceOfType(result, typeof(ConflictObjectResult));
        }

        [TestMethod]
        public async Task LogIn_ReturnsNotFound_WhenAccountNotFound()
        {
            // Arrange
            var logInRequest = new LogInRequest
            {
                Email = "nonexistent@example.com",
                PasswordHash = Encoding.UTF8.GetBytes("password")
            };

            // Act
            var result = await _controller.LogIn(logInRequest);

            // Assert
            Assert.IsInstanceOfType(result, typeof(NotFoundObjectResult));
        }

        [TestMethod]
        public async Task LogIn_ReturnsUnauthorized_WhenAccountIsLocked()
        {
            // Arrange
            var student = new Student
            {
                Id = Guid.NewGuid(),
                FirstName = "Jane",
                LastName = "Doe",
                Email = "jane.doe@example.com",
                PasswordHash = Encoding.UTF8.GetBytes("password"),
                IsLocked = true,
                UnlockDate = DateTime.UtcNow.AddMinutes(10)
            };
            await _context.Students.AddAsync(student);
            await _context.SaveChangesAsync();

            var logInRequest = new LogInRequest
            {
                Email = "jane.doe@example.com",
                PasswordHash = Encoding.UTF8.GetBytes("password")
            };

            // Act
            var result = await _controller.LogIn(logInRequest);

            // Assert
            Assert.IsInstanceOfType(result, typeof(UnauthorizedObjectResult));
        }

        [TestMethod]
        public async Task LogIn_ReturnsUnauthorized_WhenPasswordIsInvalid()
        {
            // Arrange
            var student = new Student
            {
                Id = Guid.NewGuid(),
                FirstName = "Jane",
                LastName = "Doe",
                Email = "jane.doe@example.com",
                PasswordHash = Encoding.UTF8.GetBytes("password"),
                IsLocked = false,
                LogInAttempts = 0
            };
            await _context.Students.AddAsync(student);
            await _context.SaveChangesAsync();

            var logInRequest = new LogInRequest
            {
                Email = "jane.doe@example.com",
                PasswordHash = Encoding.UTF8.GetBytes("wrongpassword")
            };

            // Act
            var result = await _controller.LogIn(logInRequest);

            // Assert
            Assert.IsInstanceOfType(result, typeof(UnauthorizedObjectResult));
        }

        [TestMethod]
        public async Task LogIn_ReturnsOk_WhenLogInIsSuccessful()
        {
            // Arrange
            var student = new Student
            {
                Id = Guid.NewGuid(),
                FirstName = "Jane",
                LastName = "Doe",
                Email = "jane.doe@example.com",
                PasswordHash = Encoding.UTF8.GetBytes("password"),
                IsLocked = false,
                LogInAttempts = 0
            };
            await _context.Students.AddAsync(student);
            await _context.SaveChangesAsync();

            var logInRequest = new LogInRequest
            {
                Email = "jane.doe@example.com",
                PasswordHash = Encoding.UTF8.GetBytes("password")
            };

            // Act
            var result = await _controller.LogIn(logInRequest);

            // Assert
            Assert.IsInstanceOfType(result, typeof(OkObjectResult));
        }
    }
}
