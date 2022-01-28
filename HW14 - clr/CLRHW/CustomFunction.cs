using System;
using System.Collections.Generic;
using System.Data.SqlTypes;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using Microsoft.SqlServer.Server;

namespace CLRHW
{
    public class CustomFunction
    {
        [SqlFunction(IsDeterministic = true)]
        public static SqlInt32 IpChecker (SqlString input)
        {
            if (input == SqlString.Null)
            {
                return new SqlInt32(0);
            }

            Regex regex = new Regex(@"(\d+)\.(\d+)\.(\d+)\.(\d+)");
            if (regex.IsMatch(input.Value))
            {
                MatchCollection matches = regex.Matches(input.Value);
                bool isCorrect = true;
                int test;
                for (int i = 1; i <= 4; i++)
                {
                    test = int.Parse(matches[0].Groups[i].Value);
                    if (test > 255 || test < 0)
                    {
                        isCorrect = false;
                    }
                }

                if (isCorrect)
                {
                    return new SqlInt32(1);
                }
            }

            
            return new SqlInt32(0);
        }
    }
}
