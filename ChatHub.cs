using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.AspNet.SignalR;

namespace chat
{
    public class ChatHub : Hub
    {
        public void Send(string nome, string message) {
            Clients.All.broadcastMessage(nome, message);
        }
    }
}