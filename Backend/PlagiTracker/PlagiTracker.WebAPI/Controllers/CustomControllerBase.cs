using Microsoft.AspNetCore.Mvc;
using PlagiTracker.Data;
using PlagiTracker.Data.DataAccess;
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

        protected async Task<Result> VerifyToken(BaseRequest baseRequest)
        {
            try
            {
                if(baseRequest == null)
                {
                    return new Result
                    {
                        Message = "The request is null",
                        Success = false
                    };
                }
                else if(baseRequest?.UserId == null)
                {
                    return new Result
                    {
                        Message = "The User Id is null",
                        Success = false
                    };
                }
                else if (_context == null)
                {
                    return new Result
                    {
                        Message = "Error: Error in Data Base connection",
                        Success = false
                    };
                }

                var user = await _context!.Users!.FindAsync(baseRequest.UserId);

                if(user == null)
                {
                    return new Result
                    {
                        Message = "User not found",
                        Success = false
                    };
                }

                return new Result
                {
                    Success = true
                };
            }
            catch (Exception ex)
            {
                return new Result
                {
                    Message = ex.Message,
                    Success = false
                }; ;
            }
        }
    }
}
