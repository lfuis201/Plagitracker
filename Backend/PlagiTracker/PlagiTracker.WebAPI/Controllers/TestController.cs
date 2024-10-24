using Microsoft.AspNetCore.Mvc;
using PlagiTracker.Data.DataAccess;
using PlagiTracker.Data.Entities;
using PlagiTracker.Data.Requests;
using PlagiTracker.Services.SeleniumServices;
using System;

namespace PlagiTracker.WebAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TestController : ControllerBase
    {
        private readonly DataContext _context;

        public TestController(DataContext context)
        {
            _context = context;
        }

        [HttpPost]
        [Route("ScrapeReplit")]
        public async Task<ActionResult> ScrapeReplit()
        {
            string url = "https://replit.com/@PrivateReplit/WebScrapping.zip";
            try
            {
                WebScraping webScraping = new();
                try
                {
                    var result = webScraping!.ScrapeReplit(url);
                    return Ok(result);
                }
                catch (Exception e)
                {
                    return BadRequest(e.Message);
                }
                finally
                {
                    webScraping!.Driver!.Dispose();
                }
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }
    }
}