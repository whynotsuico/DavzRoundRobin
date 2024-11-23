<%@ Application Language="C#" %>
<%@ Import Namespace="Microsoft.AspNet.SignalR" %>
<%@ Import Namespace="System.Net.Sockets" %>
<%@ Import Namespace="System.Threading" %>
<%@ Import Namespace="System.Text" %>
<%@ Import Namespace="System.Net" %>

<script RunAt="server">
    private static Thread udpListenerThread;
    private static UdpClient udpClient;
    private static bool keepListening = true;

    public static void Application_Start(object sender, EventArgs e)
    {
        udpListenerThread = new Thread(StartUdpListener);
        udpListenerThread.IsBackground = true;
        udpListenerThread.Start();
    }

    private static void StartUdpListener()
    {
        int port = 8080;
        if (!TryCreateUdpClient(port))
        {
            udpClient = null;
            udpClient.Dispose();
        }

        IPEndPoint remoteIpEndPoint = new IPEndPoint(IPAddress.Any, port);

        while (keepListening)
        {
            try
            {
                Byte[] receiveBytes = udpClient.Receive(ref remoteIpEndPoint);
                string receivedData = Encoding.ASCII.GetString(receiveBytes);

                // Send message to all connected clients via SignalR
                var context = GlobalHost.ConnectionManager.GetHubContext<MyHub>();
                context.Clients.All.receiveMessage("wilrey",receivedData);
            }
            catch (Exception ex)
            {
                // Log exception or handle it
                System.Diagnostics.Trace.WriteLine("UDP Listener Error: " + ex.Message);
            }
        }
    }

    private static bool TryCreateUdpClient(int port)
    {
        try
        {
            // Attempt to create and bind a new UdpClient
            udpClient = new UdpClient(port);
            return true;
        }
        catch (SocketException ex)
        {
            // Log exception if needed
            System.Diagnostics.Trace.WriteLine($"Failed to create UdpClient on port {port}: {ex.Message}");
            return false;
        }
    }

    public static void Application_End(object sender, EventArgs e)
    {
        keepListening = false;

        if (udpListenerThread != null && udpListenerThread.IsAlive)
        {
            udpListenerThread.Join(); // Wait for the thread to complete
        }

        if (udpClient != null)
        {
            udpClient.Close();
            udpClient = null; // Set to null to ensure proper cleanup
        }
    }</script>
