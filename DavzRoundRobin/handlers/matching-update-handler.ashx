<%@ WebHandler Language="C#" Class="matching_update_handler" %>

using System;
using System.Web;
using System.Threading.Tasks;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.IO;
using System.Text;
using Davz.Tournament;

public class matching_update_handler : IHttpHandler
{
    public void ProcessRequest(HttpContext context)
    {

        string winner = context.Request["winnerNumber"];
        string losser = context.Request["losserNumber"];
        string s = string.Empty;

        var matching = Matching.Read(context.Request["id"]);

        if (matching != null)
        {
            matching.WinnerBikeNumber =winner;
            matching.LoserBikeNumber = losser;
            matching.IsDone = true;

            matching.Update();

            s = "{\"status\": \"success\"}";
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