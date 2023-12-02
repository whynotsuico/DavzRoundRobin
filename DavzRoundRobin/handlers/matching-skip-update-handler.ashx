<%@ WebHandler Language="C#" Class="matching_skip_update_handler" %>

using System;
using System.Web;
using System.Threading.Tasks;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.IO;
using System.Text;
using Davz.Tournament;
using Newtonsoft.Json;


public class matching_skip_update_handler : IHttpHandler
{
    public void ProcessRequest(HttpContext context)
    {
        string s = string.Empty;

        var matching = Matching.Read(context.Request["id"]);

        if (matching != null)
        {
            matching.SortNumber = (int.Parse(context.Request["sortNumber"])+1).ToString();

            matching.Update();

            s = JsonConvert.SerializeObject(matching);
        }

        context.Response.Write(s);
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}