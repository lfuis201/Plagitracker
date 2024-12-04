using System.Net.Mail;
using System.Net;
using System.Text;

namespace PlagiTracker.Services.EmailServices
{
    public class EmailAuthenticator
    {
        private static readonly string PASSWORD = "kdntpikwwxpysmhx";

        public static void ResetPasswordEmail(string toEmail, string displayName, int code)
        {
            var fromAddress = new MailAddress("daoblur.business@gmail.com", "PlagiTracker");
            var toAddress = new MailAddress(toEmail, displayName);

            const string subject = "Password Reset Request";
            StringBuilder body = new();

            body.Append($"Dear {displayName},\n\n");
            body.Append("We received a request to reset the password for your account. Please use the verification code below to proceed with resetting your password:\n\n");
            body.Append($"Verification Code: {code}\n\n");
            body.Append("If you did not request a password reset, please ignore this email or contact our support team immediately.\n\n");
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
                Body = body.ToString()
            };

            smtpClient.Send(mailMessage);
        }

        public static void WelcomeStudentEmail(string toEmail, string displayName)
        {
            var fromAddress = new MailAddress("daoblur.business@gmail.com", "PlagiTracker");
            var toAddress = new MailAddress(toEmail, displayName);

            const string subject = "PlagiTracker to PlagiTracker";
            StringBuilder body = new();

            body.Append($"Dear {displayName},\n\n");
            body.Append($"Welcome aboard! We're thrilled to have you join us on PlagiTracker, your gateway to a world of knowledge and exciting learning experiences.\n\n");
            body.Append("Dive into your courses, connect with your peers and professors, and make the most of the resources available to you. If you ever need assistance, our support team is here to help.\n\n");
            body.Append("Happy learning!\n\n");
            body.Append("Best regards, The PlagiTracker Team");

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
                Body = body.ToString()
            };

            smtpClient.Send(mailMessage);
        }

        public static void WelcomeTeacherEmail(string toEmail, string displayName)
        {
            var fromAddress = new MailAddress("daoblur.business@gmail.com", "PlagiTracker");
            var toAddress = new MailAddress(toEmail, displayName);

            const string subject = "PlagiTracker to PlagiTracker";
            StringBuilder body = new();

            body.Append($"Dear {displayName},\n\n");
            body.Append("Welcome to PlagiTracker! We're excited to have you join our educational community where you can inspire and guide students on their academic journeys.\n\n");
            body.Append("Explore the platform, set up your courses, and connect with your students. Our support team is ready to assist you with any questions or needs you may have.\n\n");
            body.Append("Here's to a great semester ahead!\n\n");
            body.Append("Sincerely, The PlagiTracker Team");

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
                Body = body.ToString()
            };

            smtpClient.Send(mailMessage);
        }
    }
}