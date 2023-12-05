<%@ WebHandler Language="C#" Class="matching_swap_winner_handler" %>

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


public class matching_swap_winner_handler : IHttpHandler
{
    public void ProcessRequest(HttpContext context)
    {
        string s = string.Empty;

        Matching oldMatching = Matching.Read(context.Request["id"]);

        if (oldMatching != null)
        {
            Matching swapMatching = Matching.Read(oldMatching.ID);

            swapMatching.LeftBikeNumber = oldMatching.RightBikeNumber;
            swapMatching.LeftTeamName = oldMatching.RightTeamName;
            swapMatching.LeftRiderName = oldMatching.RightRiderName;

            swapMatching.RightBikeNumber = oldMatching.LeftBikeNumber;
            swapMatching.RightTeamName = oldMatching.LeftTeamName;
            swapMatching.RightRiderName = oldMatching.LeftRiderName;

            swapMatching.WinnerBikeNumber = oldMatching.LoserBikeNumber;
            swapMatching.LoserBikeNumber = oldMatching.WinnerBikeNumber;

            swapMatching.Update();

            s = JsonConvert.SerializeObject(oldMatching);
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