using System.Net.Mail;
using System.Net;
using System.Text;

namespace PlagiTracker.Services.EmailServices
{
    public class EmailCourseNotifications
    {
        private static readonly string PASSWORD = "kdntpikwwxpysmhx";

        public static void ArchivedCourse(List<(string toEmail, string displayName)> recipients, string teacherName, string courseName)
        {
            var fromAddress = new MailAddress("daoblur.business@gmail.com", "PlagiTracker");

            const string subject = "Archived Course";

            var smtpClient = new SmtpClient
            {
                Host = "smtp.gmail.com",
                Port = 587,
                EnableSsl = true,
                DeliveryMethod = SmtpDeliveryMethod.Network,
                UseDefaultCredentials = false,
                Credentials = new NetworkCredential(fromAddress.Address, PASSWORD)
            };

            foreach (var recipient in recipients)
            {
                var toAddress = new MailAddress(recipient.toEmail, recipient.displayName);

                StringBuilder body = new();
                body.Append($"Dear {recipient.displayName},\n\n");
                body.Append($"Teacher {teacherName} has archived the {courseName} course.\n\n");
                body.Append("Thank you, PlagiTracker.");

                using var mailMessage = new MailMessage(fromAddress, toAddress)
                {
                    Subject = subject,
                    Body = body.ToString()
                };

                smtpClient.Send(mailMessage);
            }
        }
    }
}
