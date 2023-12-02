<%@ WebHandler Language="C#" Class="matching_registration_create_handler" %>

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

public class matching_registration_create_handler : IHttpHandler
{
    public void ProcessRequest(HttpContext context)
    {
        string eventID = context.Request["eventID"];
        string riderName = context.Request["riderName"];
        string dragBikeNumber = context.Request["dragBikeNumber"];
        string categoryID = context.Request["categoryID"];
        string teamName = context.Request["teamName"];

        string s = string.Empty;

        var registration = Registration.Create(eventID, riderName, dragBikeNumber, categoryID, teamName);

        if (registration != null)
            s = JsonConvert.SerializeObject(registration);

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