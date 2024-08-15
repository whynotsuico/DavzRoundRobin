<%@ Page Title="Match Timer" Language="C#" MasterPageFile="main.master" %>

<%@ Import Namespace="System.Net" %>
<%@ Import Namespace="System.Net.Sockets" %>
<%@ Import Namespace="System.Text" %>
<%@ Import Namespace="System.Threading" %>

<script runat="server">
    private static string LatestMessage = "Waiting for messages...";
    private static Thread udpListenerThread;
    private static UdpClient udpClient;

    private void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (udpListenerThread == null)
            {
                udpListenerThread = new Thread(new ThreadStart(StartUdpListener));
                udpListenerThread.IsBackground = true;
                udpListenerThread.Start();
            }
        }

        if (Request.HttpMethod == "POST")
        {
            string json = new System.IO.StreamReader(Request.InputStream).ReadToEnd();
            if (json.Contains("getLatestMessage"))
            {
                Response.Clear();
                Response.ContentType = "application/json; charset=utf-8";
                Response.Write("{\"d\":\"" + LatestMessage + "\"}");
                Response.End();
            }
        }
    }

    private void StartUdpListener()
    {
        udpClient = new UdpClient(8080);
        IPEndPoint RemoteIpEndPoint = new IPEndPoint(IPAddress.Any, 8080);

        while (true)
        {
            try
            {
                Byte[] receiveBytes = udpClient.Receive(ref RemoteIpEndPoint);
                string receivedData = Encoding.ASCII.GetString(receiveBytes);

                // Update the latest message
                LatestMessage = receivedData;
            }
            catch (Exception ex)
            {
                // Handle exceptions (optional)
            }
        }
    }

    private void Page_Unload(object sender, EventArgs e)
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
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
        $(document).ready(function () {
            // Periodically fetch the latest UDP message
            setInterval(function () {
                $.ajax({
                    type: "POST",
                    url: "match-timer.aspx",
                    data: "{ 'action': 'getLatestMessage' }",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        $('#udpMessages').text(response.d);
                    }
                });
            }, 1000); // Fetch every second
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <h2>Received UDP Messages:</h2>
    <div id="udpMessages" style="border: 1px solid black; padding: 10px; width: 300px; height: 150px; overflow-y: auto;">
        <%= LatestMessage %>
    </div>
</asp:Content>

