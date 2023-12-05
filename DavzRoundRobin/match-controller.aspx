<%@ Page Title="Match Controller" Language="C#" MasterPageFile="main.master" %>

<script runat="server">
    private MatchingBracket _MatchingBracket;
    private Event _Event;

    protected void Page_Load(object sender, EventArgs e)
    {
        _MatchingBracket = MatchingBracket.Read(Request["id"].ToString());
        _Event = Event.Read(_MatchingBracket.EventID);
    }

    protected void Page_PreRenderComplete(object sender, EventArgs e)
    {
        rptMatchList.DataSource = TournamentManager.GetAllMatchingByMatchingIDIsDoneFalse(_MatchingBracket.ID);
        rptMatchList.DataBind();

        rptMatchingNow.DataSource = TournamentManager.GetTop1MatchingByMatchingID(_MatchingBracket.ID);
        rptMatchingNow.DataBind();

        rptHistory.DataSource = TournamentManager.GetAllMatchingByMatchingIDIsDoneTrue(_MatchingBracket.ID);
        rptHistory.DataBind();

        rptTeamStanding.DataSource = TournamentManager.GetAllWinnersAndLosersByMatchingBracketID(_MatchingBracket.ID); ;
        rptTeamStanding.DataBind();
    }

    protected void DeleteEntry(object sender, CommandEventArgs e)
    {
        string oldBracketCategoryID = _MatchingBracket.CategoryID;

        MatchingBracket.Delete(_MatchingBracket.ID);

        Response.Redirect($"{CommonLinks.EventBracketByCategory}?id={_Event.ID}&catid={oldBracketCategoryID}");
    }

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link type="text/css" href="core/assets/css/custom.matching.css" rel="stylesheet">

    <script src="Scripts/jquery.signalR-2.4.3.min.js"></script>
    <script src="signalr/hubs"></script>

    <style>

        .btn-control {
            padding: 22px;
            font-size: 1rem !important;
            font-weight: bold;
            text-transform: uppercase;
        }

        .flex-container .contoller-name {
            color: black !important;
        }

        .flex-container h1 {
            font-size: 7rem !important;
        }

        table {
            line-height: 20px !important;
            border-spacing: 0;
        }

        span.alert.alert-danger, span.alert.alert-success {
            padding: 4px 10px 4px 10px;
            border-radius: 0px !important;
            color: black !important;
        }

        .moda-loading-content {
            background: transparent !important;
            border: none !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href='<%=CommonLinks.DashBoard %>'>Home</a></li>
            <li class="breadcrumb-item"><a href='<%=CommonLinks.EventDetail %>?id=<%= _Event.ID %>'>Event Detail</a></li>
            <li class="breadcrumb-item"><a href='<%=CommonLinks.EventBracketByCategory %>?id=<%= _Event.ID %>&catid=<%= _MatchingBracket.CategoryID %>'>Category Detail</a></li>
            <li class="breadcrumb-item active" aria-current="page"><%= _MatchingBracket.BracketName %></li>
        </ol>
    </nav>
    <%-- <div class="alert alert-info" role="alert">
        <b>Please set up your matching user interface (see the instructions below) in order to use this match controller.</b>
        <ol>
            <li>Click "Matching UI" in the left sidebar.
            </li>
            <li>The URL "www.davztournamentsystem.com/matching.aspx?id=0" will take you to a different tabs of your browser.
            </li>
            <li>Replace the id (0) in the link with this ID: "(<b><%= _MatchingBracket.ID %></b>)".
            </li>
            <li>Await the full loading of the page.
            </li>
            <li>You're ready to go. "HAPPY RACING"
            </li>
        </ol>
    </div>--%>


    <div class="alert alert-info" role="alert">
        <b style="font-size: 14px;">Please set up your matching user interface (see the instructions below) in order to use this match controller.</b>
        <ol style="font-size: 13px;">
            <li>Click "Matching UI" in the left sidebar  
            </li>
            <li>Click Generate Matching UI. <a href="javascript:;" data-action-type="matchinguicontrol">[Generate Matching UI]</a>
            </li>
        </ol>
    </div>
    <div class="row">
        <div class="col col-md-7">
            <div class="card">
                <div class="card-header">
                    <b><%= _MatchingBracket.BracketName %> - Controller</b>
                    <a href="javascript:;" class="btn btn-primary text-white me-0 float-end" data-bs-toggle="modal" data-bs-target="#StandingModal"><i class="bx bx-user-check"></i>&nbsp;View Standing</a>
                </div>
                <div class="card-body">
                    <asp:Repeater runat="server" ID="rptMatchingNow">
                        <ItemTemplate>
                            <div class="flex-container text-center">
                                <div class="flex-item">
                                    <h1><%# Eval("Tournament_Matching_Left_Bike_Number") %></h1>
                                </div>
                                <div class="flex-item">
                                    <h2 class="animate-charcter">VS</h2>
                                </div>
                                <div class="flex-item">
                                    <h1><%# Eval("Tournament_Matching_Right_Bike_Number") %></h1>
                                </div>
                            </div>
                            <br />
                            <div class="flex-container text-center">
                                <div class="flex-item">
                                    <span class="contoller-name"><%# Eval("Tournament_Matching_Left_Team_Name") %></span>
                                </div>
                                <div class="flex-item">
                                </div>
                                <div class="flex-item">
                                    <span class="contoller-name"><%# Eval("Tournament_Matching_Right_Team_Name") %></span>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                    <br />
                    <div class="flex-container text-center">
                        <div class="flex-item">
                            <a href="javascript:;" class="btn btn-primary btn-control" data-action-type="winnerorlosserskip" data-type="left"><i class="bx bx-left-arrow-alt"></i>&nbsp;Left</a>
                        </div>
                        <div class="flex-item">
                            <a href="javascript:;" class="btn btn-primary btn-control" data-action-type="winnerorlosserskip" data-type="skip"><i class="bx bx-x-circle"></i>&nbsp;Skip</a>
                        </div>
                        <div class="flex-item">
                            <a href="javascript:;" class="btn btn-primary btn-control" data-action-type="winnerorlosserskip" data-type="right">Right&nbsp;<i class="bx bx-right-arrow-alt"></i></a>
                        </div>
                    </div>
                    <br />
                    <br />
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item text-center">
                            <b><span class="animate-charcter">Next Match</span></b>
                        </li>
                        <asp:Repeater runat="server" ID="rptMatchList">
                            <ItemTemplate>
                                <li class="list-group-item">
                                    <div class="flex-container text-center">
                                        <div class="flex-item">
                                            <span style="color: black !important;"><%# Eval("Tournament_Matching_Left_Bike_Number") %></span>
                                        </div>
                                        <div class="flex-item">
                                            <span style="color: black !important;">VS</span>
                                        </div>
                                        <div class="flex-item">
                                            <span style="color: black !important;"><%# Eval("Tournament_Matching_Right_Bike_Number") %></span>
                                        </div>
                                    </div>
                                </li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>
            </div>
        </div>
        <div class="col col-md-5">
            <script type="text/javascript">
                function confirmDelete() {
                    return confirm("Are you sure you want to delete this Bracket?");
                }
            </script>
            <div class="card">
                <div class="card-header">
                    <b>Match History</b>
                    <asp:LinkButton runat="server" class="btn btn-primary float-end" OnClientClick="return confirmDelete();" OnCommand="DeleteEntry">Delete Bracket
                    </asp:LinkButton>
                </div>
                <div class="card-body">
                    <ul class="list-group list-group-flush">
                        <asp:Repeater runat="server" ID="rptHistory">
                            <ItemTemplate>
                                <li class="list-group-item">
                                    <div class="row">
                                        <div class="col col-md-7">
                                            <div class="flex-container text-center">
                                                <div class="flex-item">
                                                    <span style="color: black !important;"><%# Eval("Tournament_Matching_Left_Bike_Number") %></span>
                                                </div>
                                                <div class="flex-item">
                                                    <span style="color: black !important;">VS</span>
                                                </div>
                                                <div class="flex-item">
                                                    <span style="color: black !important;"><%# Eval("Tournament_Matching_Right_Bike_Number") %></span>
                                                </div>
                                                <div class="flex-item">
                                                    <span style="color: black !important;"><%# bool.Parse(Eval("Tournament_Matching_Is_Done").ToString()) ? "<span class='alert alert-success'>Done</span>" : "" %></span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col col-md-3 text-right">
                                            W - [ <%# Eval("Tournament_Matching_Winner_Bike_Number") %> ]
                                        </div>
                                        <div class="col col-md-2">
                                            <a href="javascript:;" data-action-type="swapwinner" data-id="<%# Eval("Tournament_Matching_ID") %>" class="btn btn-primary btn-sm float-end"><i class="bx bx-street-view icon text-white"></i></a>
                                        </div>
                                    </div>

                                </li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>
            </div>
        </div>

        <div class="modal fade" id="StandingModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="staticBackdropLabel"><b>Team  Standing</b></h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <asp:Repeater runat="server" ID="rptTeamStanding">
                            <HeaderTemplate>
                                <table class="table table-light" id="tbl-team-standing">
                                    <thead>

                                        <tr>
                                            <th class="text-center">Rank</th>
                                            <th class="text-left">Team Name</th>
                                            <th class="text-center">Bike #</th>
                                            <th class="text-center">W</th>
                                            <th class="text-center">L</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>

                                    <td class="text-center"><%# Container.ItemIndex + 1%></td>
                                    <td class="text-left"><%#  Eval("TeamName").ToString() %></td>
                                    <td class="text-center"><%#  Eval("BikeNumber").ToString() %></td>
                                    <td class="text-center"><%#  Eval("Wins").ToString() %></td>
                                    <td class="text-center"><%#  Eval("Losses").ToString() %></td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                </tbody>
           </table>
                            </FooterTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>
        </div>
        <button type="button" class="btn btn-primary d-none js-btn-match-created" data-bs-toggle="modal" data-bs-target="#LoadingMatchController">
            Created
        </button>
        <div class="modal fade" id="LoadingMatchController" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content moda-loading-content">
                    <div class="modal-body">
                        <div class="text-center">
                            <div class="spinner-grow text-primary" role="status">
                                <span class="visually-hidden">Loading...</span>
                            </div>
                            <div class="spinner-grow text-secondary" role="status">
                                <span class="visually-hidden">Loading...</span>
                            </div>
                            <div class="spinner-grow text-success" role="status">
                                <span class="visually-hidden">Loading...</span>
                            </div>
                            <div class="spinner-grow text-danger" role="status">
                                <span class="visually-hidden">Loading...</span>
                            </div>
                            <div class="spinner-grow text-warning" role="status">
                                <span class="visually-hidden">Loading...</span>
                            </div>
                            <div class="spinner-grow text-info" role="status">
                                <span class="visually-hidden">Loading...</span>
                            </div>
                            <div class="spinner-grow text-light" role="status">
                                <span class="visually-hidden">Loading...</span>
                            </div>
                            <div class="spinner-grow text-dark" role="status">
                                <span class="visually-hidden">Loading...</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
    <script>
        $(function () {

            // Establish a connection to the SignalR hub
            var connection = $.hubConnection();
            var hub = connection.createHubProxy('myHub');

            hub.on('receiveMessage', function (user, message) {

                if (message == "reload")
                    location.reload(true);
            });

            // Start the SignalR connection
            connection.start().done(function () {
                console.log('Connection established');
            });

            $('[data-action-type="winnerorlosserskip"]').click(function () {
                var $sender = $(this);
                var type = $sender.data('type');

                var confirmed = confirm("Are you sure you want to perform this action?");

                if (confirmed) {

                    switch (type) {
                        case "right":
                            hub.invoke('send', "wilrey", "right");
                            break;
                        case "left":
                            hub.invoke('send', "wilrey", "left");
                            break;
                        case "skip":
                            hub.invoke('send', "wilrey", "skip");
                            break;
                    }

                    $('.js-btn-match-created').click();
                }

                return false;
            });

            $('[data-action-type="swapwinner"]').click(function () {
                var $sender = $(this);

                var confirmed = confirm("Are you sure you want to swap winner?");

                if (confirmed) {

                    $.get("/handlers/matching-swap-winner-handler.ashx", { id: $sender.data("id") })
                        .done(function (data) {
                            hub.invoke('send', "wilrey", "reload");
                            location.reload(true);
                        });
                }
            });

            $('[data-action-type="matchinguicontrol"]').click(function () {
                hub.invoke('send', <%= _MatchingBracket.ID%>, "redirect");
            });

        });

    </script>
</asp:Content>

