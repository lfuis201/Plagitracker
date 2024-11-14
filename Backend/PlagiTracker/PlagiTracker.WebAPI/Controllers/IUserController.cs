using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using PlagiTracker.Data.Requests;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace PlagiTracker.WebAPI.Controllers
{
    public interface IUserController
    {
        // Constantes para el bloqueo de usuario
        const int LOG_IN_UNLOCK_MINUTES = 10;
        const int MAX_LOGIN_ATTEMPTS = 3;

        // Constantes para el código de verificación
        const int VERIFICATION_CODE_EXPIRED_MINUTES = 5;
        const int VERIFICATION_MIN_RANGE_VALUE = 50000000;
        const int VERIFICATION_MAX_RANGE_VALUE = 99999999;
        const int VERIFICATION_CODE_NULL_VALUE = 10000000;
        const int RESET_PASSWORD_UNLOCK_MINUTES = 60;
        const int MAX_RESET_PASSWORD_ATTEMPTS = 3;

        // Constantes para las excepciones de email ya usado
        const string EMAIL_ALREADY_USED_EXCEPTION_MESSAGE_1 = "23505: duplicate key value violates unique constraint";
        const string EMAIL_ALREADY_USED_EXCEPTION_MESSAGE_2 = "IX_Users_Email";

        Task<ActionResult> SignUp(SignUpRequest signUpRequest);

        Task<ActionResult> LogIn(LogInRequest logInRequest);

        Task<ActionResult> SendResetPasswordEmail(string email);

        Task<ActionResult> ResetPasswordVerification(string email, int code);

        Task<ActionResult> ResetPassword(ResetPasswordRequest resetPasswordRequest);

        string GenerateJwtToken(IConfiguration _configuration, string email)
        {
            var jwtSettings = _configuration.GetSection("Jwt");
            var key = Encoding.UTF8.GetBytes(jwtSettings["Key"]!);

            var tokenHandler = new JwtSecurityTokenHandler();
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new[]
                {
                    // intentar con SID!!!
                    // usar Role !!
                    new Claim(ClaimTypes.Email, email)
                }),
                Expires = DateTime.UtcNow.AddMinutes(double.Parse(jwtSettings["ExpireMinutes"]!)),
                Issuer = jwtSettings["Issuer"],
                Audience = jwtSettings["Audience"],
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
            };

            var token = tokenHandler.CreateToken(tokenDescriptor);
            return tokenHandler.WriteToken(token);
        }
    }
}