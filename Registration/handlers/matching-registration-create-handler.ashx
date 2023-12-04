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
        Registration reg = TournamentManager.ReadBikeNumberByBikeNumber(dragBikeNumber, categoryID);

        if (reg != null)
        {
            s = "failed";
        }
        else
        {
            var registration = Registration.Create(eventID, riderName, dragBikeNumber, categoryID, teamName);
            s = "success";
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