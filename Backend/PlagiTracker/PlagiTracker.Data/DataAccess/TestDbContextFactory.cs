using Microsoft.EntityFrameworkCore;

namespace PlagiTracker.Data.DataAccess
{
    public class TestDbContextFactory
    {
        public static DataContext CreateInMemoryDbContext()
        {
            var options = new DbContextOptionsBuilder<DataContext>()
                .UseInMemoryDatabase(databaseName: "TestDatabase")
                .Options;

            var context = new DataContext(options);
            context.Database.EnsureCreated();
            return context;
        }
    }
}
