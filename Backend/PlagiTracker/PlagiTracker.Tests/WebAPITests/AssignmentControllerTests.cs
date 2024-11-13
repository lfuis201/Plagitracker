using Microsoft.AspNetCore.Mvc;
using PlagiTracker.Data.DataAccess;
using PlagiTracker.Data.Entities;
using PlagiTracker.Data.Requests;
using PlagiTracker.WebAPI.Controllers;
using System.Text;

namespace PlagiTracker.Tests.WebAPITests
{
    [TestClass]
    public class AssignmentControllerTests
    {
        private DataContext? _context;
        private AssignmentController? _controller;

        [TestInitialize]
        public void Setup()
        {
            _context = TestDbContextFactory.CreateInMemoryDbContext();
            _controller = new AssignmentController(_context);
        }

        [TestMethod]
        [DataRow("class Person { } class OuterClass { int x = 10; public void main(String[] args, int param, Person person) { x = 322; OuterClass myOuter = new OuterClass(); } class InnerClass { public InnerClass[] main2(String args, String abc) { OuterClass myOuter = new OuterClass(); } public void VoidMethod(String args, String abc) { OuterClass myOuter = new OuterClass(); } } private static char ToChar(String[] args, int param, Person person) { Integer x = 322; OuterClass myOuter = new OuterClass(); } private static void Print(String text) { Integer x = 322; OuterClass myOuter = new OuterClass(); } } public class Main { void main() { OuterClass myOuter = new OuterClass(); } }")]
        public async Task SignUp_ReturnsOkResult(string code)
        {
            // Act
            var result = await _controller?.ValidateAssignmentBodyST(new List<string> { code });

            Console.WriteLine($"-{result.ExecuteResult}-");
            // Assert
            Assert.IsInstanceOfType(result, typeof(OkResult));
        }
    }
}
