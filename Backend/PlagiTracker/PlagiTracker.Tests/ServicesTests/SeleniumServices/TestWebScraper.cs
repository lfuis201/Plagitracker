// Ignore Spelling: Codiva Replit

using PlagiTracker.Data.Entities;
using PlagiTracker.Services.EmailServices;
using PlagiTracker.Services.FileServices.Replit;
using PlagiTracker.Services.SeleniumServices;

[assembly: Parallelize(Workers = 5, Scope = ExecutionScope.MethodLevel)]
namespace PlagiTracker.Tests.ServicesTests.SeleniumServices
{
    [TestClass]
    public class TestWebScraper
    {
        private WebScraping? WebScraping;

        [TestInitialize]
        public void Setup()
        {
            WebScraping = new();
        }

        [TestCleanup]
        public void Cleanup()
        {
            WebScraping!.Driver!.Dispose();
        }

        [TestMethod]
        [DataRow("https://www.codiva.io/p/0dc699a0-6033-4bb6-b46c-15d238277749", 1)]
        [DataRow("https://www.codiva.io/p/9f4e0e63-82d0-4241-b0bf-e12ae7a9b700", 3)]
        [DataRow("https://www.codiva.io/p/2e48c734-df91-4d02-b9d5-470c9302b6ee", 2)]
        [DataRow("https://www.codiva.io/p/e0f1785e-40a2-4174-a00d-e76fbcfc95f8", 2)]
        [DataRow("https://www.codiva.io/p/dbc162b6-5afe-46bf-b4b3-ee42f11c37c3", 6)]
        public void TestScrapeCodiva(string url, int expected)
        {
            /*try { 
                WebScraping webScraping = new();
                try
                {
                    var (result, data) = webScraping!.ScrapeCodiva(url);
                    Assert.AreEqual(expected, data.Count);
                }
                catch (Exception e)
                {
                    Assert.Fail(e.Message);
                }
                finally
                {
                    webScraping.Driver.Dispose();
                }
            }
            catch (Exception e)
            {
                Assert.Fail(e.Message);
            }*/
        }
        /*
        [TestMethod]
        public async Task TestScrapeCodiva2()
        {
            int resultsCount = 0;
            int maxConcurrency = Environment.ProcessorCount * 2;
            using SemaphoreSlim semaphore = new SemaphoreSlim(maxConcurrency);

            // Lista de URLs y valores esperados
            List<(string url, int expected)> values = new()
            {
                ("https://www.codiva.io/p/0dc699a0-6033-4bb6-b46c-15d238277749", 1),
                ("https://www.codiva.io/p/9f4e0e63-82d0-4241-b0bf-e12ae7a9b700", 3),
                ("https://www.codiva.io/p/2e48c734-df91-4d02-b9d5-470c9302b6ee", 2),
                ("https://www.codiva.io/p/e0f1785e-40a2-4174-a00d-e76fbcfc95f8", 2),
                ("https://www.codiva.io/p/dbc162b6-5afe-46bf-b4b3-ee42f11c37c3", 6),
                ("https://www.codiva.io/p/dbc162b6-5afe-46bf-b4b3-ee42f11c37c3", 6),
                ("https://www.codiva.io/p/dbc162b6-5afe-46bf-b4b3-ee42f11c37c3", 6),
                ("https://www.codiva.io/p/dbc162b6-5afe-46bf-b4b3-ee42f11c37c3", 6),
                ("https://www.codiva.io/p/0dc699a0-6033-4bb6-b46c-15d238277749", 1),
                ("https://www.codiva.io/p/9f4e0e63-82d0-4241-b0bf-e12ae7a9b700", 3),
                ("https://www.codiva.io/p/2e48c734-df91-4d02-b9d5-470c9302b6ee", 2),
                ("https://www.codiva.io/p/e0f1785e-40a2-4174-a00d-e76fbcfc95f8", 2),
                ("https://www.codiva.io/p/dbc162b6-5afe-46bf-b4b3-ee42f11c37c3", 6),
                ("https://www.codiva.io/p/dbc162b6-5afe-46bf-b4b3-ee42f11c37c3", 6),
                ("https://www.codiva.io/p/0dc699a0-6033-4bb6-b46c-15d238277749", 1),
                ("https://www.codiva.io/p/9f4e0e63-82d0-4241-b0bf-e12ae7a9b700", 3),
                ("https://www.codiva.io/p/2e48c734-df91-4d02-b9d5-470c9302b6ee", 2),
                ("https://www.codiva.io/p/e0f1785e-40a2-4174-a00d-e76fbcfc95f8", 2),
                ("https://www.codiva.io/p/dbc162b6-5afe-46bf-b4b3-ee42f11c37c3", 6),
                ("https://www.codiva.io/p/dbc162b6-5afe-46bf-b4b3-ee42f11c37c3", 6),
                ("https://www.codiva.io/p/dbc162b6-5afe-46bf-b4b3-ee42f11c37c3", 6),
                ("https://www.codiva.io/p/dbc162b6-5afe-46bf-b4b3-ee42f11c37c3", 6),
                ("https://www.codiva.io/p/0dc699a0-6033-4bb6-b46c-15d238277749", 1),
                ("https://www.codiva.io/p/9f4e0e63-82d0-4241-b0bf-e12ae7a9b700", 3),
                ("https://www.codiva.io/p/2e48c734-df91-4d02-b9d5-470c9302b6ee", 2),
                ("https://www.codiva.io/p/e0f1785e-40a2-4174-a00d-e76fbcfc95f8", 2),
                ("https://www.codiva.io/p/dbc162b6-5afe-46bf-b4b3-ee42f11c37c3", 6),
                ("https://www.codiva.io/p/dbc162b6-5afe-46bf-b4b3-ee42f11c37c3", 6),
            };

            List<Task> tasks = new();

            foreach (var value in values)
            {
                await semaphore.WaitAsync();
                tasks.Add(Task.Run(async () =>
                {
                    try
                    {
                        WebScraping webScraping = new();
                        try
                        {
                            var (result, data) = webScraping.ScrapeCodiva(value.url);
                            Assert.AreEqual(value.expected, data.Count);
                            if (value.expected == data.Count) resultsCount++;
                        }
                        catch (Exception e)
                        {
                            Assert.Fail(e.Message);
                        }
                        finally
                        {
                            webScraping!.Driver!.Dispose();
                        }
                    }
                    catch (Exception e)
                    {
                        Assert.Fail(e.Message);
                    }
                    finally
                    {
                        semaphore.Release();
                    }
                }));
            }

            await Task.WhenAll(tasks);

            Assert.AreEqual(values.Count, resultsCount);
        }
        */

        [TestMethod]
        //[DataRow("https://www.codiva.io/p/a8dca7f2-31b9-4550-9a1d-c92f4ba76fff", 1)]
        [DataRow("https://www.onlinegdb.com/cky2lPU84", 3)]
        public async Task TestGetCodes(string url, int expected)
        {
            try
            {
                WebScraping webScraping = new();
                try
                {
                    var submission = new Submission()
                    {
                        Url = url,
                    };
                    var result = await webScraping!.GetCodes(submission);
                    Assert.AreEqual(expected, result.Data.codes.Count);
                }
                catch (Exception e)
                {
                    Console.WriteLine($"Error in Test: {e.Message}");
                    Assert.Fail(e.Message);
                }
                finally
                {
                    webScraping!.Driver!.Dispose();
                }
            }
            catch (Exception e)
            { 
                Console.WriteLine($"Error in Test: {e.Message}");
                Assert.Fail(e.Message);
            }
        }

        [TestMethod]
        [DataRow("https://dolos.ugent.be/server/#/share/1304387187490617071", 3)]
        public async Task TestDolosEmail(string url, int expected)
        {
            try
            {
                WebScraping webScraping = new();
                try
                {
                    var result = await webScraping!.TakeScreenshot(url);

                    if (!result.Success || result.Data == null)
                    {
                        Assert.Fail(result.Message);
                    }

                    //EmailAssignmentNotification.AssignmentDolosAnalysisEmail("asd", "asd", "asd",result.Data);

                    Assert.AreEqual(expected, 1);
                }
                catch (Exception e)
                {
                    Console.WriteLine($"Error in Test: {e.Message}");
                    Assert.Fail(e.Message);
                }
                finally
                {
                    webScraping!.Driver!.Dispose();
                }
            }
            catch (Exception e)
            {
                Console.WriteLine($"Error in Test: {e.Message}");
                Assert.Fail(e.Message);
            }
        }

        /*
        [TestMethod]
        [DataRow("https://replit.com/@PrivateReplit/WebScrapping.zip", false)]
        public void TestScrapeReplit(string url, bool expected)
        {
            try
            {
                WebScraping webScraping = new();
                try
                {
                    var result = webScraping!.ScrapeReplit(url);
                    Assert.AreEqual(expected, result.Success);
                }
                catch (Exception e)
                {
                    Assert.Fail(e.Message);
                }
                finally
                {
                    webScraping!.Driver!.Dispose();
                }
            }
            catch (Exception e)
            {
                Assert.Fail(e.Message);
            }
        }
        */
    }
}
