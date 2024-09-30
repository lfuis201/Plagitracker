using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PlagiTracker.Tests
{
    public class StateTransition
    {
        private int attemptCount = 0;
        private const int MaxAttempts = 3;

        public string LogIn(string password, string correctPassword)
        {
            if (password == correctPassword)
            {
                attemptCount = 0;
                return "Access Accepted";
            }
            else
            {
                attemptCount++;
                if (attemptCount >= MaxAttempts)
                {
                    return "Account Blocked";
                }
                else
                {
                    return "Incorrect Password";
                }
            }
        }
    }
}
