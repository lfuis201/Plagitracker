using Antlr4.Runtime.Misc;
using Microsoft.AspNetCore.Mvc;
using PlagiTracker.Data;
using PlagiTracker.Data.DataAccess;

namespace PlagiTracker.WebAPI.Controllers
{
    public abstract class CustomControllerBase : ControllerBase
    {
        protected readonly DataContext _context;

        public CustomControllerBase(DataContext context)
        {
            _context = context ?? throw new ArgumentNullException(nameof(context), "Error: Error in Data Base connection");
        }

        /// <summary>
        /// Verifica el token de acceso
        /// </summary>
        /// <param name="scopeClaim">Alcance del token</param>
        /// <param name="scopeClassName">Alcance esperado del token</param>
        /// <returns></returns>
        protected Result<NullableAttribute> VerifyToken(string scopeClaim, string scopeClassName)
        {
            try
            {
                if (string.IsNullOrEmpty(scopeClaim))
                {
                    return new(false, "Scope token is null or empty");
                }
                else if (scopeClaim != scopeClassName)
                {
                    return new(false, "Invalid scope token");
                }

                return new(true, "Token verified");
            }
            catch (Exception ex)
            {
                return new(false, $"{ex.Message}");
            }
        }
    }
}