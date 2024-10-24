// Ignore Spelling: Codiva Replit Downloader

using PlagiTracker.Services.FileServices.Replit;
using PlagiTracker.Services.SeleniumServices;

//[assembly: Parallelize(Workers = 5, Scope = ExecutionScope.MethodLevel)]
namespace PlagiTracker.Tests.ServicesTests.FileServices.Replit
{
    [TestClass]
    public class TestReplitDownloader
    {

        [TestInitialize]
        public void Setup()
        {
        }

        [TestCleanup]
        public void Cleanup()
        {
        }

        [TestMethod]
        [DataRow("https://replit.com/@PrivateReplit/WebScrapping.zip", true)]
        public async Task TestScrapeCodiva(string url, bool expected)
        {
            try
            {
                bool result = await ReplitDownloader.DownloadAsync(url);
                Assert.AreEqual(expected, result);
            }
            catch (Exception e)
            {
                Assert.Fail(e.Message);
            }
            finally
            {
            }
        }
    }
}