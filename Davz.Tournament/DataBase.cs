using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Davz.Tournament
{
    public class DataBase
    {
        static public string ConnectionString
        {
            get { return ConfigurationManager.AppSettings["DavzConnectionString"].ToString(); }
        }
    }
}
