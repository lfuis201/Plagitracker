using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PlagiTracker.Tests.ServicesTests
{
    [TestClass]
    public class StateTransitionTests
    {
        private StateTransition stateMachine;

        [TestInitialize]
        public void Setup()
        {
            stateMachine = new StateTransition();
        }

        [DataTestMethod]
        [DynamicData(nameof(GetTestCases), DynamicDataSourceType.Method)]
        public void TestLogin(string id, string password, string correctPassword, string expected)
        {
            Assert.AreEqual(expected, stateMachine.LogIn(password, correctPassword));
        }

        public static IEnumerable<object[]> GetTestCases()
        {
            var path = Path.Combine(Directory.GetCurrentDirectory(), "TestCases", "LoginStateTestCases.csv");
            foreach (var line in File.ReadLines(path).Skip(1))
            {
                Console.WriteLine(line);
                var parts = line.Split(';');
                yield return new object[] { parts[0], parts[1], parts[2], parts[3] };
            }
        }
    }
}
