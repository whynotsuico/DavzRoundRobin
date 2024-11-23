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
using Newtonsoft.Json;


public class matching_update_handler : IHttpHandler
{
    public void ProcessRequest(HttpContext context)
    {

        string winner = context.Request["winnerNumber"];
        string losser = context.Request["losserNumber"];
        string leftTime = context.Request["lefttime"];
        string rightTime = context.Request["rightime"];
        string leftTopSpeed = context.Request["lefttopspeed"];
        string rightTopSpeed = context.Request["righttopspeed"];
        string s = string.Empty;

        var matching = Matching.Read(context.Request["id"]);

        if (matching != null)
        {
            matching.WinnerBikeNumber = winner;
            matching.LoserBikeNumber = losser;
            matching.LeftTime = leftTime;
            matching.RightTime = rightTime;
            matching.LeftTopSpeed = leftTopSpeed;
            matching.RightTopSpeed = rightTopSpeed;
            matching.IsDone = true;

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