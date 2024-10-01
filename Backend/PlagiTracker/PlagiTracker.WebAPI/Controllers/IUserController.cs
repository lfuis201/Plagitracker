using Microsoft.AspNetCore.Mvc;
using PlagiTracker.Data.Requests;

namespace PlagiTracker.WebAPI.Controllers
{
    public interface IUserController 
    {
        const int UNLOCK_MINUTES = 10;
        const int MAX_LOGIN_ATTEMPTS = 3;
        const string EMAIL_ALREADY_USED_EXCEPTION_MESSAGE_1 = "23505: duplicate key value violates unique constraint";
        const string EMAIL_ALREADY_USED_EXCEPTION_MESSAGE_2 = "IX_Users_Email";

        Task<ActionResult> SignUp(SignUpRequest signUpRequest);

        Task<ActionResult> LogIn(LogInRequest logInRequest);
    }
}