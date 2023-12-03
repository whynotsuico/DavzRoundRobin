<%@ WebHandler Language="C#" Class="event_update_handler" %>

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


public class event_update_handler : IHttpHandler
{
    public void ProcessRequest(HttpContext context)
    {
        string s = string.Empty;

        var eventR = Event.Read(context.Request["id"]);

        if (eventR != null)
        {
            eventR.IsActive = true;
            eventR.Update();

            s = JsonConvert.SerializeObject(eventR);
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