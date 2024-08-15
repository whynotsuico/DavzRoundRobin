<%@ Page Language="C#" AutoEventWireup="true" CodeFile="timer.aspx.cs" Inherits="timer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Timer App</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <style>
        #timerDisplay {
            font-size: 24px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Button ID="startButton" runat="server" Text="Start" CssClass="btn" OnClientClick="startTimer(); return false;" />
            <asp:Button ID="stopButton" runat="server" Text="Stop" CssClass="btn" OnClientClick="stopTimer(); return false;" />
            <asp:Button ID="resetButton" runat="server" Text="Reset" CssClass="btn" OnClientClick="resetTimer(); return false;" />
            <div id="timerDisplay" runat="server">00:00:00.000</div>
        </div>
    </form>
    <script>
        var startTime;
        var timerInterval;
        var isRunning = false;

        function startTimer() {
            if (!isRunning) {
                startTime = new Date();
                isRunning = true;
                timerInterval = setInterval(updateTimerDisplay, 10); // Update every 10 milliseconds
            }
        }

        function stopTimer() {
            if (isRunning) {
                clearInterval(timerInterval); // Stop the interval
                isRunning = false;
            }
        }

        function resetTimer() {
            clearInterval(timerInterval); // Stop the interval
            isRunning = false;
            document.getElementById("timerDisplay").innerText = "00:00:00.000";
        }

        function updateTimerDisplay() {
            var elapsedTime;
            if (isRunning) {
                var currentTime = new Date();
                elapsedTime = currentTime - startTime;
            } else {
                elapsedTime = 0;
            }

            var hours = Math.floor(elapsedTime / 3600000);
            var minutes = Math.floor((elapsedTime % 3600000) / 60000);
            var seconds = Math.floor((elapsedTime % 60000) / 1000);
            var milliseconds = Math.floor((elapsedTime % 1000));

            var timerDisplay = document.getElementById("timerDisplay");
            timerDisplay.innerText = ("0" + hours).slice(-2) + ":" + ("0" + minutes).slice(-2) + ":" + ("0" + seconds).slice(-2) + "." + ("00" + milliseconds).slice(-3);
        }
    </script>

     <script>
         $(document).ready(function () {
             // Connect to WebSocket server
             const socket = new WebSocket('ws://localhost:8081');

             // Handle incoming messages
             socket.onmessage = function (event) {
                 const message = event.data;
                 console.log("Received: " + message);
                 $('#output').append('<p>' + message + '</p>');
             };

             socket.onerror = function (event) {
                 console.error("WebSocket error observed:", event);
             };
         });
    </script>
</body>
</html>
