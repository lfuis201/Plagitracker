using Hangfire;
using Hangfire.PostgreSql;
using Microsoft.EntityFrameworkCore;
using PlagiTracker.WebAPI.HangFire;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

// Load configuration from appsettings.json
builder.Configuration.AddJsonFile("appsettings.json", optional: false, reloadOnChange: true);

builder.Services.AddControllers();

builder.Services.AddDbContext<PlagiTracker.Data.DataAccess.DataContext>(opt =>
{
    opt.UseNpgsql(builder.Configuration.GetConnectionString("DatabaseConnection"));
});

builder.Services.AddScoped<HangFireServices>();

// Add CORS policy
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAllOrigins", builder =>
        {
            builder.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader();
        });
});

// Add Hangfire
builder.Services.AddHangfire(config =>
{
    config.SetDataCompatibilityLevel(CompatibilityLevel.Version_180)
        .UseSimpleAssemblyNameTypeSerializer()
        .UseRecommendedSerializerSettings()
        .UsePostgreSqlStorage(options => options.UseNpgsqlConnection(builder.Configuration.GetConnectionString("DatabaseConnection")));
});

builder.Services.AddHangfireServer();

// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

// Enable CORS
app.UseCors("AllowAllOrigins");

// Enable Hangfire Dashboard
app.MapHangfireDashboard();

app.UseHttpsRedirection();
app.UseAuthorization();
app.MapControllers();
app.Run();