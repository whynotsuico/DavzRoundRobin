<%@ Application Language="C#" %>
<%@ Import Namespace="Microsoft.AspNet.SignalR" %>
<%@ Import Namespace="System.Net.Sockets" %>
<%@ Import Namespace="System.Threading" %>
<%@ Import Namespace="System.Text" %>
<%@ Import Namespace="System.Net" %>

<script RunAt="server">
    private static Thread udpListenerThread;
    private static UdpClient udpClient;

    void Application_Start(object sender, EventArgs e)
    {
        udpListenerThread = new Thread(StartUdpListener);
        udpListenerThread.IsBackground = true;
        udpListenerThread.Start();
    }

    private void StartUdpListener()
    {
        udpClient = new UdpClient(8080);
        IPEndPoint remoteIpEndPoint = new IPEndPoint(IPAddress.Any, 8080);

        while (true)
        {
            try
            {
                Byte[] receiveBytes = udpClient.Receive(ref remoteIpEndPoint);
                string receivedData = Encoding.ASCII.GetString(receiveBytes);

                // Send message to all connected clients via SignalR
                var context = GlobalHost.ConnectionManager.GetHubContext<MyHub>();
                context.Clients.All.receiveMessage(receivedData);
            }
            catch (Exception ex)
            {
                // Log exception or handle it
            }
        }
    }

    void Application_End(object sender, EventArgs e)
    {
        if (udpListenerThread != null && udpListenerThread.IsAlive)
        {
            udpListenerThread.Abort();
        }

        if (udpClient != null)
        {
            udpClient.Close();
        }
    }
</script>