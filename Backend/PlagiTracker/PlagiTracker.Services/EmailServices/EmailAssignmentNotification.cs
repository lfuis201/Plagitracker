// Ignore Spelling: Screenshot Dolos

using System.Net.Mail;
using System.Net;
using System.Text;

namespace PlagiTracker.Services.EmailServices
{
    public class EmailAssignmentNotification : EmailService
    {
        public EmailAssignmentNotification(string password) : base(password)
        {
        }

        private static readonly string PASSWORD = "kdntpikwwxpysmhx";

        public static void AssignmentDolosAnalysisEmail(string url, string toEmail, string displayName, string courseName, string assignmentTitle, byte[] screenshot)
        {
            var fromAddress = new MailAddress("daoblur.business@gmail.com", "PlagiTracker");
            var toAddress = new MailAddress(toEmail, displayName);
            //var toAddress = new MailAddress("daoblur.private@gmail.com", displayName);

            string subject = $"{courseName} - Assignment Analysis";
            StringBuilder body = new();
            body.Append($"Dear {displayName},\n\n");
            body.Append($"The analysis of the assignment {assignmentTitle} has been completed.\n\n");
            body.Append($"You can view the results at the following link: {url}\n\n");
            body.Append("Thank you, PlagiTracker.");

            var smtpClient = new SmtpClient
            {
                Host = "smtp.gmail.com",
                Port = 587,
                EnableSsl = true,
                DeliveryMethod = SmtpDeliveryMethod.Network,
                UseDefaultCredentials = false,
                Credentials = new NetworkCredential(fromAddress.Address, PASSWORD)
            };

            using var mailMessage = new MailMessage(fromAddress, toAddress)
            {
                Subject = subject,
                Body = body.ToString(),
            };

            if (screenshot != null && screenshot.Length > 0)
            {
                using var memoryStream = new MemoryStream(screenshot);
                var attachment = new Attachment(memoryStream, "screenshot.png", "image/png");
                mailMessage.Attachments.Add(attachment);

                // Enviar el correo electrónico
                smtpClient.Send(mailMessage);
            }
        }

        public void AssignmentDolosAnalysisEmail(string url, string toEmail, string courseName, string assignmentTitle, byte[] screenshot)
        {
            var fromAddress = new MailAddress("daoblur.business@gmail.com", "PlagiTracker");
            var toAddress = new MailAddress(toEmail, toEmail);

            string subject = $"{courseName} - Assignment Analysis";
            StringBuilder body = new();
            body.Append($"<p>Dear {toEmail}</p>");
            body.Append($"<p>The analysis of the assignment {assignmentTitle} has been completed.</p>");
            
            // iframe
            body.Append($"<iframe src=\"{url}\"></iframe>");

            body.Append($"<p>You can view the results at the following link: {url}. <b>This link expires in 30 days.</b></p>");
            body.Append("<p>Thank you, PlagiTracker.</p>");

            var smtpClient = new SmtpClient
            {
                Host = "smtp.gmail.com",
                Port = 587,
                EnableSsl = true,
                DeliveryMethod = SmtpDeliveryMethod.Network,
                UseDefaultCredentials = false,
                Credentials = new NetworkCredential(fromAddress.Address, Password)
            };

            using var mailMessage = new MailMessage(fromAddress, toAddress)
            {
                Subject = subject,
                Body = body.ToString(),
                IsBodyHtml = true
            };

            if (screenshot != null && screenshot.Length > 0)
            {
                using var memoryStream = new MemoryStream(screenshot);
                var attachment = new Attachment(memoryStream, "screenshot.png", "image/png");
                mailMessage.Attachments.Add(attachment);

                // Enviar el correo electrónico
                smtpClient.Send(mailMessage);
            }
        }
    }
}