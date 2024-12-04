namespace PlagiTracker.Services.EmailServices
{
    public abstract class EmailService
    {
        protected readonly string Password;

        public EmailService(string password)
        {
            Password = password;
        }
    }
}