using Microsoft.EntityFrameworkCore;
using PlagiTracker.Data.DataAccess;

namespace PlagiTracker.WebAPI.HangFire
{
    public class HangFireServices
    {
        private readonly DataContext _context;

        public HangFireServices(DataContext context)
        {
            _context = context;
        }

        public async Task SavePlagiarismReport(List<string> plagiarismReport)
        {
            var report = new Data.Entities.Plagiarism
            {
                Id = Guid.NewGuid(),
                Similarity = 3.22,
            };

            await _context!.Plagiarisms!.AddAsync(report);
            await _context.SaveChangesAsync();
        }
    }
}
