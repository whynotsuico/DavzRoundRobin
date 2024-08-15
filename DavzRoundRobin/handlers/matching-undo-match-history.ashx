<%@ WebHandler Language="C#" Class="matching_undo_match_history" %>

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


public class matching_undo_match_history : IHttpHandler
{
    public void ProcessRequest(HttpContext context)
    {
        string s = string.Empty;

        Matching undoMatch = Matching.Read(context.Request["id"]);

        if (undoMatch != null)
        {
            undoMatch.IsDone = false;
            undoMatch.WinnerBikeNumber =string.Empty;
            undoMatch.LoserBikeNumber =string.Empty;
            undoMatch.Update();
        }

        s = JsonConvert.SerializeObject(undoMatch);

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