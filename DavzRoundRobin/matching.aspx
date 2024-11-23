<%@ Page Title="" Language="C#" %>

<%@ Import Namespace="System.Data" %>

<!DOCTYPE html>

<script runat="server">
    private MatchingBracket _MatchingBracket;
    private DavzSettings _DavzSettings;
    private int _SortNumber;
    private bool isShowTimer = false;

    protected void Page_PreRenderComplete(object sender, EventArgs e)
    {
        _MatchingBracket = MatchingBracket.Read(Request["bracketID"].ToString());
        _DavzSettings = DavzSettings.Read();

        if (_MatchingBracket != null)
        {
            _SortNumber = TournamentManager.ReadLastSortNumberByMatchingID(_MatchingBracket?.ID);

            var dt = TournamentManager.GetAllWinnersAndLosersByMatchingBracketID(_MatchingBracket?.ID);
            int existingRowCount = dt.Rows.Count;

            for (int i = existingRowCount; i < 10; i++)
            {
                DataRow newRow = dt.NewRow();
                dt.Rows.Add(newRow);
            }

            rptTeamStanding.DataSource = dt;
            rptTeamStanding.DataBind();

            rptMatchingNow.DataSource = TournamentManager.GetTop1MatchingByMatchingID(_MatchingBracket?.ID);
            rptMatchingNow.DataBind();

            rptNextMatch.DataSource = TournamentManager.GetTop3MatchingByMatchingID(_MatchingBracket?.ID);
            rptNextMatch.DataBind();
        }

        isShowTimer = DavzSettings.Read().ShowTimer;

        pnlViewNextMatch.Visible = Request["bracketID"].ToString() != "0";
        pnlViewPrintButtons.Visible = Request["bracketID"].ToString() == "0";

    }

    protected string getFontSize(int index)
    {
        string size = "";
        switch (index)
        {
            case 0:
                size = "style='font-size: 55px !important;width: 720px;margin: auto;'";
                break;
            case 1:
                size = "style='font-size: 40px !important;width: 620px;margin: auto;'";
                break;
            case 2:
                size = "style='font-size: 25px !important;width: 520px;margin: auto;'";
                break;

        }

        return size;
    }

    public string GetCleanString(string text)
    {
        if (text != string.Empty)
            return text;

        return "-";
    }
</script>

<html lang="en">

<head runat="server">
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Davz Racing Tournament System | Home </title>

    <link href="core/assets/images/icon.jpg" rel="shortcut icon" type="image/x-icon" />

    <link type="text/css" href="core/assets/css/bootstrap.min.css" rel="stylesheet">
    <link type="text/css" href="core/assets/css/custom.css?v=1" rel="stylesheet">
    <link type="text/css" href="core/assets/css/custom.matching.css" rel="stylesheet">
    <link type="text/css" href="core/assets/css/boxicons.min.css" rel="stylesheet">


    <script src="core/assets/js/popper.min.js" type="text/javascript"></script>
    <script src="core/assets/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="core/assets/js/jquery-3.7.1.min.js" type="text/javascript"></script>

    <script src="Scripts/jquery.signalR-2.4.3.min.js"></script>
    <script src="signalr/hubs"></script>

</head>
<body>
    <form id="form1" runat="server">
        <br />
        <script type="text/javascript">
            var startTime;
            var leftTimerInterval;
            var rightTimerInterval;

            var leftTimerIsRunning = false;
            var rightTimerIsRunning = false;

            function startPlayerrsTimer() {
                leftTimerIsRunning = false;
                rightTimerIsRunning = false;

                if (!leftTimerIsRunning && !rightTimerIsRunning) {
                    startTime = new Date();
                    leftTimerIsRunning = true;
                    rightTimerIsRunning = true;

                    leftTimerInterval = setInterval(updateLeftTimerDisplay, 10); // Update every 10 milliseconds
                    rightTimerInterval = setInterval(updateRightTimerDisplay, 10); // Update every 10 milliseconds
                }
            }
            function stopLeftTimer() {
                if (leftTimerIsRunning) {
                    clearInterval(leftTimerInterval); // Stop the interval
                    leftTimerIsRunning = false;

                    var $leftTimerValue = $('#lefTimerDisplay').text().split(":");

                    var $val = (((parseInt(<%= _DavzSettings.RaceLength%>) / parseFloat($leftTimerValue[1])) * (3.6)) * 1.45);
                    $('#txtLeftStopSpeed').text($val.toFixed(2));

                }
            }

            function stopBothTimer() {
                if (leftTimerIsRunning && (rightTimerIsRunning)) {
                    clearInterval(leftTimerInterval); // Stop the interval
                    leftTimerIsRunning = false;

                    clearInterval(rightTimerInterval); // Stop the interval
                    rightTimerIsRunning = false;

                    var $leftTimerValue = $('#lefTimerDisplay').text().split(":");

                    var $val = (((parseInt(<%= _DavzSettings.RaceLength%>) / parseFloat($leftTimerValue[1])) * (3.6)) * 1.45);
                    $('#txtLeftStopSpeed').text($val.toFixed(2));

                    var $rightTimerValue = $('#rightTimerDisplay').text().split(":");

                    var $val = (((parseInt(<%= _DavzSettings.RaceLength%>) / parseFloat($rightTimerValue[1])) * (3.6)) * 1.45);
                    $('#txtRightStopSpeed').text($val.toFixed(2));

                }
            }


            function stopRightTimer() {
                if (rightTimerIsRunning) {
                    clearInterval(rightTimerInterval); // Stop the interval
                    rightTimerIsRunning = false;

                    var $rightTimerValue = $('#rightTimerDisplay').text().split(":");

                    var $val = (((parseInt(<%= _DavzSettings.RaceLength%>) / parseFloat($rightTimerValue[1])) * (3.6)) * 1.45);
                    $('#txtRightStopSpeed').text($val.toFixed(2));

                }
            }

            function updateLeftTimerDisplay() {
                var elapsedTime;
                if (leftTimerIsRunning) {
                    var currentTime = new Date();
                    elapsedTime = currentTime - startTime;
                } else {
                    elapsedTime = 0;
                }

                var hours = Math.floor(elapsedTime / 3600000);
                var minutes = Math.floor((elapsedTime % 3600000) / 60000);
                var seconds = Math.floor((elapsedTime % 60000) / 1000);
                var milliseconds = Math.floor((elapsedTime % 1000));

                // Stop the timer if seconds are 15 or more
                if (seconds >= <%= _DavzSettings.TimerSeconds %>) {
                    stopLeftTimer(); // Stop the timer and handle additional logic
                    return; // Exit the function to avoid further updates
                }

                var timerDisplay = document.getElementById("lefTimerDisplay");
                timerDisplay.innerText = ("0" + minutes).slice(-2) + ":" + ("0" + seconds).slice(-2) + "." + ("00" + milliseconds).slice(-3);
            }

            function updateRightTimerDisplay() {
                var elapsedTime;
                if (rightTimerIsRunning) {
                    var currentTime = new Date();
                    elapsedTime = currentTime - startTime;
                } else {
                    elapsedTime = 0;
                }

                var hours = Math.floor(elapsedTime / 3600000);
                var minutes = Math.floor((elapsedTime % 3600000) / 60000);
                var seconds = Math.floor((elapsedTime % 60000) / 1000);
                var milliseconds = Math.floor((elapsedTime % 1000));

                // Stop the timer if seconds are 15 or more
                if (seconds >= <%= _DavzSettings.TimerSeconds %>) {
                    stopRightTimer(); // Stop the timer and handle additional logic
                    return; // Exit the function to avoid further updates
                }

                var timerDisplay = document.getElementById("rightTimerDisplay");
                timerDisplay.innerText = ("0" + minutes).slice(-2) + ":" + ("0" + seconds).slice(-2) + "." + ("00" + milliseconds).slice(-3);


            }
        </script>
        <script>
            $(document).ready(function () {

                var isShowTimer = <%= isShowTimer.ToString().ToLower() %>;

                // Output the value to the console for debugging
                console.log(isShowTimer);

                // Check the value of isShowTimer and hide the element if false
                if (isShowTimer === false) {
                    $('.js-timer-view').hide();
                }

                $('#print-button-left').click(function () {
                    ShowPrintLayout($('#lefTimerDisplay').text(), $('#txtLeftStopSpeed').text());
                });

                $('#print-button-right').click(function () {
                    // Open the print layout page with the ID parameter
                    ShowPrintLayout($('#rightTimerDisplay').text(), $('#txtRightStopSpeed').text());
                });

                function ShowPrintLayout(timer, topseed) {
                    var printWindow = window.open('print-layout-single.aspx?time=' + timer + '&topspeed=' + topseed, 'PrintWindow', 'width=800,height=600');

                    // Ensure the window is fully loaded before triggering print
                    $(printWindow).on('load', function () {
                        printWindow.focus(); // Ensure the print window is focused
                        printWindow.print(); // Trigger the print dialog
                    });
                }
            });
</script>
        <div class="matching-container container">
            <div class="row">

                <div class="col col-md-8">
                    <div class="pyro d-none">
                        <div class="before"></div>
                        <div class="after"></div>
                    </div>
                    <div class="card full-height-container gradient-border">
                        <div class="flex-main-screen">
                            <div class="word animate-charcter text-center">
                                NOW MATCHING
                                <br />
                                <%= _MatchingBracket?.BracketName  %>
                            </div>
                            <div class="flex-container text-center js-timer-view" style="margin-top: 20px; margin-bottom: 52px;">
                                <div class="left-time-text">
                                    TIMER
                                </div>
                                <div class="flex-item" style="border: 1px solid white; margin-left: 20px;">
                                    <div id="lefTimerDisplay" style="color: white; font-size: 60px !important;">00:00.000</div>
                                    <div class="top-speed-text">
                                        <span style="padding-top: 16px;">Top Speed</span>
                                        <span style="background-color: red; color: white !important"><b style="font-size: 25px !important;" id="txtLeftStopSpeed">0</b> <i>KPH</i></span>
                                    </div>
                                </div>
                                <div class="flex-item"></div>
                                <div class="flex-item" style="border: 1px solid white; margin-right: 20px;">
                                    <div id="rightTimerDisplay" style="color: white; font-size: 60px !important;">00:00.000</div>
                                    <div class="top-speed-text">
                                        <span style="padding-top: 16px;">Top Speed</span>
                                        <span style="background-color: red; color: white !important"><b style="font-size: 25px !important;" id="txtRightStopSpeed">0</b> <i>KPH</i></span>
                                    </div>
                                </div>
                            </div>
                            <asp:PlaceHolder runat="server" ID="pnlViewPrintButtons">
                                <div class="flex-container text-center" style="margin-top: 190px;">
                                    <div class="flex-item">
                                        <button class="btn btn-primary text-white me-0" id="print-button-left">Print</button>
                                    </div>
                                    <div class="flex-item"></div>
                                    <div class="flex-item">
                                        <button class="btn btn-primary text-white me-0" id="print-button-right">Print</button>
                                    </div>
                                </div>
                            </asp:PlaceHolder>

                            <asp:Repeater runat="server" ID="rptMatchingNow">
                                <ItemTemplate>
                                    <div class="flex-container">
                                        <span style="color: transparent !important;" class="js-matching-id"><%# Eval("Tournament_Matching_ID") %></span>
                                        <div class="flex-item">
                                            <h5 class="main-identity" style="margin-left: 100px;">Left Lane</h5>
                                        </div>
                                        <div class="flex-item">
                                        </div>
                                        <div class="flex-item">
                                            <h5 class="main-identity" style="float: right; margin-right: 100px;">Right Lane</h5>
                                        </div>
                                    </div>
                                    <br />
                                    <div class="flex-container text-center" style="margin-top: -19px;">
                                        <div class="flex-item">
                                            <h1 class="main-number js-left-winner-bike-number  cssanimation leFadeInLeft"><%# Eval("Tournament_Matching_Left_Bike_Number") %></h1>
                                        </div>
                                        <div class="flex-item">
                                            <%--  <h1 class="animate-charcter main-vs">VS</h1>--%>
                                        </div>
                                        <div class="flex-item">
                                            <h1 class="main-number js-right-winner-bike-number  cssanimation leFadeInRight"><%# Eval("Tournament_Matching_Right_Bike_Number") %></h1>
                                        </div>
                                    </div>
                                    <br />
                                    <br />
                                    <div class="flex-container text-center">
                                        <div class="flex-item">
                                            <h5 class="main-team-name js-left-team-name  cssanimation leFadeIn"><%# Eval("Tournament_Matching_Left_Team_Name") %></h5>
                                        </div>
                                        <div class="flex-item">
                                        </div>
                                        <div class="flex-item">
                                            <h5 class="main-team-name js-right-team-name  cssanimation leFadeIn"><%# Eval("Tournament_Matching_Right_Team_Name") %></h5>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                        <div class="up-next-section cssanimation leFadeInTop">
                            <asp:PlaceHolder runat="server" ID="pnlViewNextMatch">
                                <div class="upnext-text">
                                    NEXT MATCH
                                </div>
                            </asp:PlaceHolder>
                            <asp:Repeater runat="server" ID="rptNextMatch">
                                <ItemTemplate>
                                    <div class="flex-container gradient-upnext  next-match-div text-center " <%# getFontSize(Container.ItemIndex) %>>
                                        <div class="flex-item">
                                            <span><%# Eval("Tournament_Matching_Left_Bike_Number") %></span>
                                        </div>
                                        <div class="flex-item">
                                            <span style="font-size: 20px !important;">VS</span>
                                        </div>
                                        <div class="flex-item">
                                            <span><%# Eval("Tournament_Matching_Right_Bike_Number") %></span>
                                        </div>
                                    </div>
                                    <br />
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </div>
                </div>
                <div class="col col-md-4">
                    <asp:Repeater runat="server" ID="rptTeamStanding">
                        <HeaderTemplate>
                            <table class="list-group-flush table  matching-standing" id="tbl-team-standing">
                                <thead>
                                    <tr>
                                        <th colspan="5"><b><%= _MatchingBracket.BracketName %></b> Team Standing</th>
                                    </tr>
                                    <tr>
                                        <th class="list-group-flush text-center">Rank</th>
                                        <th class="list-group-flush text-left">Team Name</th>
                                        <th class="list-group-flush text-center">Bike #</th>
                                        <th class="list-group-flush text-center">W</th>
                                        <th class="list-group-flush text-center">L</th>
                                    </tr>
                                </thead>
                                <tbody>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>

                                <td class="list-group-flush text-center"><%# Container.ItemIndex + 1%></td>
                                <td class="list-group-flush text-left"><%#  Eval("TeamName").ToString() %></td>
                                <td class="list-group-flush text-center"><%#  Eval("BikeNumber").ToString() %></td>
                                <td class="list-group-flush text-center"><%#  Eval("Wins").ToString() %></td>
                                <td class="list-group-flush text-center"><%#  Eval("Losses").ToString() %></td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                            </tbody>
                            </table>
                        </FooterTemplate>
                    </asp:Repeater>
                    <br />
                    <div class="text-center">
                        <h5 style="text-transform: uppercase;">Powered By:</h5>
                        <img src="core/assets/images/davz-logo.png" style="width: 260px;" />
                        <img src="core/assets/images/team-mac.png" style="width: 260px;" />
                    </div>

                </div>
            </div>
            <style>
                .table > :not(caption) > * > * {
                    background: transparent !important;
                    color: white !important;
                }
            </style>

            <%-- <script>
                $(document).ready(function () {
                    setInterval(function () {
                        location.reload();
                    }, 3000); // 30000 milliseconds = 30 seconds
                });
    </script>--%>
            <script type="text/javascript">



                $(document).ready(function () {

                    $('#tbl-team-standing  td').each(function () {
                        var delay = ($(this).index() / 4) + 's';
                        $(this).css({
                            webkitAnimationDelay: delay,
                            mozAnimationDelay: delay,
                            animationDelay: delay
                        });
                    });
                });

                $(function () {

                    // Establish a connection to the SignalR hub
                    var connection = $.hubConnection();
                    var hub = connection.createHubProxy('myHub');

                    // Define a method to handle incoming messages
                    hub.on('receiveMessage', function (user, message) {

                        console.log(message);
                        switch (message) {
                            case "right":
                                UpdateMatch("right");
                                break;
                            case "left":
                                UpdateMatch("left");
                                break;
                            case "skip":
                                SkipMatch();
                                break;
                            case "reload":
                                location.reload(true);
                                break;
                            case "X":
                                startPlayerrsTimer();
                                break;
                            case "P":
                                stopRightTimer();
                                break;
                            case "M":
                                stopLeftTimer();
                            case "Q":
                                stopBothTimer();
                                break;
                            case "redirect":
                                const redirectURL = 'matching.aspx?bracketID=' + user;
                                // Redirect to the specified URL
                                window.location.href = redirectURL;
                                break;
                        }
                    });

                    // Start the SignalR connection
                    connection.start().done(function () {
                        console.log('Connection established');
                    });

                    function UpdateMatch(winnersender) {

                        var id = $('.js-matching-id').text();
                        var winnernumber = "";
                        var lossernumber = "";
                        var teamname = "";
                        var lefttime = "";
                        var rightime = "";
                        var lefttopspeed = "";
                        var righttopspeed = "";

                        switch (winnersender) {
                            case "left":
                                winnernumber = $('.js-left-winner-bike-number').text();
                                lossernumber = $('.js-right-winner-bike-number').text();
                                teamname = $('.js-left-team-name').text();
                                break;
                            case "right":
                                lossernumber = $('.js-left-winner-bike-number').text();
                                winnernumber = $('.js-right-winner-bike-number').text();
                                teamname = $('.js-right-team-name').text();
                                break;
                        }

                        rightime = $('#rightTimerDisplay').text();
                        righttopspeed = $('#txtRightStopSpeed').text();

                        lefttime = $('#lefTimerDisplay').text();
                        lefttopspeed = $('#txtLeftStopSpeed').text();

                        $.get("/handlers/matching-update-handler.ashx", {
                            id: id,
                            winnerNumber: winnernumber,
                            losserNumber: lossernumber,
                            lefttime: lefttime,
                            rightime: rightime,
                            lefttopspeed: lefttopspeed,
                            righttopspeed: righttopspeed
                        }).done(function (data) {
                            $('.js-btn-created').click();
                            $('.pyro').removeClass("d-none");;
                            $('.js-pop-up-number').text(winnernumber);
                            $('.js-pop-up-name').text(teamname);

                            hub.invoke('send', "wilrey", "reloadcontroller");

                            setTimeout(function () {
                                location.reload(true);
                            }, 2500); // 500 milliseconds = 0.5 seconds

                        });
                    }

                    function SkipMatch() {
                        var id = $('.js-matching-id').text();
                        $.get("/handlers/matching-skip-update-handler.ashx", { id: id, sortNumber: <%= _SortNumber %> })
                            .done(function (data) {

                                hub.invoke('send', "wilrey", "reloadcontroller");

                                location.reload(true);
                            });
                    }

                });

            </script>

            <button type="button" class="btn btn-primary d-none js-btn-created" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
                Created
            </button>
            <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content  modal-background-winner" style="width: 1200px !important;">
                        <div class="modal-body text-center">
                            <h1 class="winner-modal-h1 ">Winner</h1>
                            <h2 class="js-pop-up-number"></h2>
                            <h5 class="js-pop-up-name"></h5>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>

