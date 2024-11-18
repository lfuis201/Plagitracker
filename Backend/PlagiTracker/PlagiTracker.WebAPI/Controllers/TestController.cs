// Ignore Spelling: Replit

using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PlagiTracker.Data.DataAccess;
using PlagiTracker.Data.Entities;
using PlagiTracker.Data.Requests;
using PlagiTracker.Services.SeleniumServices;

namespace PlagiTracker.WebAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TestController : CustomControllerBase
    {
        public TestController(DataContext context) : base(context)
        {
        }
        /*
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
        */
        [HttpPost]
        [Route("DataBaseError")]
        public async Task<ActionResult> DataBaseError(Guid studentId)
        {
            try
            {
                if (studentId == Guid.Empty)
                {
                    return BadRequest("StudentId is empty");
                }
                else if (_context == null)
                {
                    return BadRequest("Context is null");
                }

                var student = await _context!.Students!.FindAsync(studentId);
                
                if(student == null)
                {
                    return NotFound();
                }

                return Ok(student);
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        [HttpPost]
        [Route("Create")]
        public async Task<ActionResult> Create(string url)
        {
            try
            {
                if (string.IsNullOrEmpty(url))
                {
                    return BadRequest("The URL is required");
                }
                /*else if(!WebScraping.IsCodivaUrl(submissionRequest.Url))
                {
                    return BadRequest("The URL is not from Codiva");
                }*/
                else if (!await WebScraping.UrlExists(url))
                {
                    return BadRequest("The URL does not exist");
                }
                else
                {
                    Submission submission = new()
                    {
                        Url = url,
                    };

                    var result = await new WebScraping().GetCodes(submission);

                    if (result == null)
                    {
                        return BadRequest("Error getting the codes");
                    }
                    else if (!result.Success)
                    {
                        return BadRequest(result.Message);
                    }

                    return Ok(new
                    {
                        Message = "Success",
                        Data = result.Data.codes,
                    });
                }
            }
            catch (Exception ex)
            {
                return BadRequest(ex.ToString());
            }
        }
    }
}