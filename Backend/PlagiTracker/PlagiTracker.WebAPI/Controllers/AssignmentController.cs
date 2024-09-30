﻿using Microsoft.AspNetCore.Mvc;
using PlagiTracker.Data.DataAccess;
using PlagiTracker.Data.Requests;
using PlagiTracker.Data.Entities;
using Microsoft.EntityFrameworkCore;
using PlagiTracker.Services.SeleniumServices;

namespace PlagiTracker.WebAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AssignmentController : ControllerBase
    {
        private readonly DataContext _context;

        public AssignmentController(DataContext context)
        {
            _context = context;
        }

        [HttpPost]
        [Route("Create")]
        public async Task<ActionResult> Create(AssignmentRequest assignmentRequest)
        {
            var id = Guid.NewGuid();
            await _context!.Assignments!.AddAsync(new Assignment()
            {
                Id = id,
                Description = assignmentRequest.Description,
                Title = assignmentRequest.Title,
                //Tiempo universal coordinado (UTC)
                SubmissionDate = DateTime.UtcNow,
                CourseId = assignmentRequest.CourseId
            });

            await _context.SaveChangesAsync();
            return Ok(id);
        }

        [HttpPost]
        [Route("Start")]
        public async Task<ActionResult> Start(List<string> urls)
        {
            PlagiTracker.Services.SeleniumServices.Web_Scraping scraper = new Web_Scraping();
            
            List<string> urls2 = new List<string>
            {
                "https://www.codiva.io/p/dbc162b6-5afe-46bf-b4b3-ee42f11c37c3",
                "https://www.invalid-url.com",
                "https://www.youtube.com/watch?v=TpNDSyDnUwc",
                "https://www.codiva.io/p/valid-url",
                "https://www.codiva.io/p/dbc162b6-5afe-46bf-b4b3-ee42f11c37c3",
                "https://www.codiva.io/p/dbc162b6-5afe-46bf-b4b3-ee42f11c37c3",
                "https://www.codiva.io/p/dbc162b6-5afe-46bf-b4b3-ee42f11c37c3",
                "https://www.codiva.io/p/dbc162b6-5afe-46bf-b4b3-ee42f11c37c3",
                "https://www.codiva.io/p/dbc162b6-5afe-46bf-b4b3-ee42f11c37c3",
                "https://www.codiva.io/p/dbc162b6-5afe-46bf-b4b3-ee42f11c37c3",
                "https://classroom.google.com/c/NzA0MDM0NzM0MzYy",
                "https://www.codiva.io/p/dbc162b6-5afe-46bf-b4b3-ee42f11c37c3",
                "https://www.codiva.io/p/dbc162b6-5afe-46bf-b4b3-ee42f11c37c3",
                "https://chatgpt.com/c/66e8b455-d26c-8005-90e1-7fbb273e3801",
                "https://classroom.google.com/c/NzA0MDM0NzM0MzYy",
                "https://www.fundeu.es/recomendacion/colaboracion-posible-alternativa-a-featuring/",

            };

            var data = await scraper.StartScraping(urls2);

            return Ok(data);
        }

        [HttpGet]
        [Route("GetAllByCourse")]
        public async Task<ActionResult> GetAllByCourse(Guid courseId)
        {
            var course = await _context!.Courses!.FindAsync(courseId);

            if (course == null)
            {
                return NotFound();
            }
            else
            {
                var assignments = await _context!.Assignments!.Where(a => a.CourseId == courseId).ToListAsync();

                if (assignments == null || assignments.Count < 1)
                {
                    return NotFound();
                }

                return Ok(assignments);
            }        
        }

        [HttpPut]
        [Route("Update")]
        public async Task<ActionResult> Update(AssignmentUpdateRequest assignmentUpdateRequest)
        {
            var assignment = await _context!.Assignments!.FindAsync(assignmentUpdateRequest.Id);
            assignment!.Description = assignmentUpdateRequest.Description;
            assignment!.Title = assignmentUpdateRequest.Title;

            await _context.SaveChangesAsync();
            return Ok();
        }

        [HttpDelete]
        [Route("Delete")]
        public async Task<ActionResult> Delete(Guid id)
        {
            var assignment = await _context!.Assignments!.FindAsync(id);
            _context.Assignments.Remove(assignment!);

            await _context.SaveChangesAsync();
            return Ok();
        }
    }
}