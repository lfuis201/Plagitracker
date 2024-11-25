// Ignore Spelling: Screenshot Dolos

using System.Net.Mail;
using System.Net;
using System.Text;
using PlagiTracker.Data.Entities;

namespace PlagiTracker.Services.EmailServices
{
    public class EmailSubmissionNotification : EmailService
    {
        public EmailSubmissionNotification(string password) : base(password)
        {
        }

        /// <summary>
        /// Email para notificar al estudiante que su tarea fue aceptada.
        /// </summary>
        /// <param name="toEmail"></param>
        /// <param name="displayName"></param>
        /// <param name="courseName"></param>
        /// <param name="assignmentTitle"></param>
        /// <param name="files"></param>
        public void SubmittedAssignmentEmail(string toEmail, string displayName, string courseName, string assignmentTitle, List<string> files)
        {
            var fromAddress = new MailAddress("daoblur.business@gmail.com", "PlagiTracker");
            var toAddress = new MailAddress(toEmail, toEmail);

            string subject = $"{courseName} - Submission";
            StringBuilder body = new();

            body.Append($"<p>{displayName}.Your <b>{assignmentTitle}</b> assignment <b>submission was accepted</b>.</p>");

            // Lista de los archivos enviados
            body.Append($"<p><b>Files:</b></p>");
            body.Append("<ul>");
            files.ForEach(file => body.Append($"<li>{file}</li>"));
            body.Append("</ul>");

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

            smtpClient.Send(mailMessage);
        }
    }
}