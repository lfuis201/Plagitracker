﻿using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

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
