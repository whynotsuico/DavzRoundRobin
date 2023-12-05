using Microsoft.AspNet.SignalR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

public class MyHub : Hub
{
    public void Send(string user, string message)
    {
        Clients.All.receiveMessage(user, message);
    }
}
