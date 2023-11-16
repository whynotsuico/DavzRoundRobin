using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Davz.Tournament
{
    public class database
    {
        public static string ConnectionString()
        {
             return ConfigurationManager.AppSettings["default"].ToString();
        }
    }
}
