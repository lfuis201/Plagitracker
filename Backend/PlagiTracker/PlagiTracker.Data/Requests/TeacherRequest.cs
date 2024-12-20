﻿namespace PlagiTracker.Data.Requests
{
    /// <remarks>
    /// No usa BaseRequest
    /// </remarks>
    public class TeacherRequest
    {
        public string? FirstName { get; set; }

        public string? LastName { get; set; }

        public string? Email { get; set; }

        public byte[]? PasswordHash { get; set; }
    }
}