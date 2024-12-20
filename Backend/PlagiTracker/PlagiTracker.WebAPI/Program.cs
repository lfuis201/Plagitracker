using Hangfire;
using Hangfire.PostgreSql;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using PlagiTracker.Services.EmailServices;
using PlagiTracker.WebAPI.Extensions;
using PlagiTracker.WebAPI.HangFire;
using System.Text;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddSwaggerGenWithAuth();

// Add services to the container.

// Load configuration from appsettings.json
builder.Configuration.AddJsonFile("appsettings.json", optional: false, reloadOnChange: true);

// Configurar la autenticación JWT
var jwtSettings = builder.Configuration.GetSection("Jwt");
var key = Encoding.UTF8.GetBytes(jwtSettings["Key"]!);

builder.Services.AddAuthorization();
builder.Services.AddAuthentication(options =>
{
    options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
    options.DefaultScheme = JwtBearerDefaults.AuthenticationScheme;
})
.AddJwtBearer(options =>
{
    options.RequireHttpsMetadata = false;
    options.TokenValidationParameters = new TokenValidationParameters
    {
        ValidateIssuer = true,
        ValidateAudience = true,
        ValidateLifetime = true,
        ValidateIssuerSigningKey = true,
        ValidIssuer = jwtSettings["Issuer"],
        ValidAudience = jwtSettings["Audience"],
        IssuerSigningKey = new SymmetricSecurityKey(key)
    };
});

// Añadir los controladores
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

// Registrar EmailService
var emailPassword = builder.Configuration["EmailSettings:Password"];
builder.Services.AddSingleton(new EmailAssignmentNotification(emailPassword!));
builder.Services.AddSingleton(new EmailSubmissionNotification(emailPassword!));

// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
    // JWT
    app.UseDeveloperExceptionPage();
}

app.UseRouting();

// Enable CORS
app.UseCors("AllowAllOrigins");

// Enable Hangfire Dashboard
app.MapHangfireDashboard();

app.UseHttpsRedirection();

// Habilitar autenticación y autorización
app.UseAuthentication();


app.UseAuthorization();

app.MapGet("/public", () => "Hello Public World!");
app.MapGet("/protected", () => "Hello Protected World!").RequireAuthorization();

app.MapControllers();

// Verificar y aplicar migraciones
using (var scope = app.Services.CreateScope())
{
    var dbContext = scope.ServiceProvider.GetRequiredService<PlagiTracker.Data.DataAccess.DataContext>();
    dbContext.Database.Migrate();
}

app.Run();
