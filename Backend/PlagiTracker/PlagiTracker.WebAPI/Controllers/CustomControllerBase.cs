using Microsoft.AspNetCore.Mvc;
using PlagiTracker.Data;
using PlagiTracker.Data.DataAccess;
using PlagiTracker.Data.Entities;
using PlagiTracker.Data.Requests;

namespace PlagiTracker.WebAPI.Controllers
{
    public abstract class CustomControllerBase : ControllerBase
    {
        protected readonly DataContext _context;

        public CustomControllerBase(DataContext context)
        {
            _context = context ?? throw new ArgumentNullException(nameof(context), "Error: Error in Data Base connection");
        }

        protected Result VerifyToken(string scopeClaim, string scopeClassName)
        {
            try
            {
                if (string.IsNullOrEmpty(scopeClaim))
                {
                    return new(false, "Error in Scope Token");
                }
                else if (scopeClaim != scopeClassName)
                {
                    return new(false, "Error in Scope Token");
                }

                return new(true, "Token Verified");
            }
            catch (Exception ex)
            {
                return new(false, $"Error: {ex.Message}");
            }
        }
    }
}
