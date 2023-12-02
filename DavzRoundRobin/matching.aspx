<%@ Page Title="" Language="C#" %>

<%@ Import Namespace="System.Data" %>

<!DOCTYPE html>

<script runat="server">
    private int _SortNumber;

    protected void Page_PreRenderComplete(object sender, EventArgs e)
    {
        string matchingBracketID = Request["bracketID"].ToString();

        _SortNumber = TournamentManager.ReadLastSortNumberByMatchingID(matchingBracketID);

        var dt = TournamentManager.GetAllWinnersAndLosersByMatchingBracketID(matchingBracketID);
        int existingRowCount = dt.Rows.Count;

        for (int i = existingRowCount; i < 10; i++)
        {
            DataRow newRow = dt.NewRow();
            dt.Rows.Add(newRow);
        }

        rptTeamStanding.DataSource = dt;
        rptTeamStanding.DataBind();

        rptMatchingNow.DataSource = TournamentManager.GetTop1MatchingByMatchingID(matchingBracketID);
        rptMatchingNow.DataBind();

        rptNextMatch.DataSource = TournamentManager.GetTop3MatchingByMatchingID(matchingBracketID);
        rptNextMatch.DataBind();

        rptMatchList.DataSource = TournamentManager.GetAllMatchingByMatchingIDIsDoneFalse(matchingBracketID);
        rptMatchList.DataBind();
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
    <style>
      
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <br />
        <div class="matching-container container">
            <script type="text/javascript">

                $(document).ready(function () {
                    var words = ['NOW MATCHING...', 'RIDERS READY!'],
                        part,
                        i = 0,
                        offset = 0,
                        len = words.length,
                        forwards = true,
                        skip_count = 0,
                        skip_delay = 15,
                        speed = 70;
                    var wordflick = function () {
                        setInterval(function () {
                            if (forwards) {
                                if (offset >= words[i].length) {
                                    ++skip_count;
                                    if (skip_count == skip_delay) {
                                        forwards = false;
                                        skip_count = 0;
                                    }
                                }
                            }
                            else {
                                if (offset == 0) {
                                    forwards = true;
                                    i++;
                                    offset = 0;
                                    if (i >= len) {
                                        i = 0;
                                    }
                                }
                            }
                            part = words[i].substr(0, offset);
                            if (skip_count == 0) {
                                if (forwards) {
                                    offset++;
                                }
                                else {
                                    offset--;
                                }
                            }
                            $('.word').text(part);
                        }, speed);
                    };

                    $(document).ready(function () {
                        wordflick();
                    });
                });
            </script>
            <div class="row">
                <div class="col col-md-7">
                    <div class="card full-height-container gradient-border  ">
                        <div class="flex-main-screen  ">
                            <div class="word"></div>
                            <asp:Repeater runat="server" ID="rptMatchingNow">
                                <ItemTemplate>
                                    <div class="flex-container text-center">
                                        <span style="color: transparent !important;" class="js-matching-id"><%# Eval("Tournament_Matching_ID") %></span>
                                        <div class="flex-item">
                                            <h5 class="main-identity">Left Lane</h5>
                                        </div>
                                        <div class="flex-item">
                                        </div>
                                        <div class="flex-item">
                                            <h5 class="main-identity">Right Lane</h5>
                                        </div>
                                    </div>
                                    <br />
                                    <div class="flex-container text-center">
                                        <div class="flex-item">
                                            <h1 class="main-number js-left-winner-bike-number"><%# Eval("Tournament_Matching_Left_Bike_Number") %></h1>
                                        </div>
                                        <div class="flex-item">
                                            <%--  <h1 class="animate-charcter main-vs">VS</h1>--%>
                                        </div>
                                        <div class="flex-item">
                                            <h1 class="main-number js-right-winner-bike-number"><%# Eval("Tournament_Matching_Right_Bike_Number") %></h1>
                                        </div>
                                    </div>
                                    <br />
                                    <div class="flex-container text-center">
                                        <div class="flex-item">
                                            <h5 class="main-team-name js-left-team-name"><%# Eval("Tournament_Matching_Left_Team_Name") %></h5>
                                        </div>
                                        <div class="flex-item">
                                        </div>
                                        <div class="flex-item">
                                            <h5 class="main-team-name js-right-team-name"><%# Eval("Tournament_Matching_Right_Team_Name") %></h5>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                        <div class="up-next-section">
                            <div class="upnext-text">
                                NEXT MATCH
                            </div>
                            <asp:Repeater runat="server" ID="rptNextMatch">
                                <ItemTemplate>
                                    <div class="flex-container gradient-upnext  next-match-div text-center" <%# getFontSize(Container.ItemIndex) %>>
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
                <div class="col col-md-3">
                    <asp:Repeater runat="server" ID="rptTeamStanding">
                        <HeaderTemplate>
                            <table class="list-group-flush table table-striped table-dark" id="tbl-team-standing">
                                <thead>
                                    <tr>
                                        <th colspan="5">Team Standing</th>
                                    </tr>
                                    <tr>
                                        <th class="list-group-flush text-center">Rank</th>
                                        <th class="list-group-flush text-center">Team Name</th>
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
                                <td class="list-group-flush text-center"><%# GetCleanString(Eval("TeamName").ToString()) %></td>
                                <td class="list-group-flush text-center"><%#  GetCleanString(Eval("BikeNumber").ToString()) %></td>
                                <td class="list-group-flush text-center"><%#  GetCleanString(Eval("Wins").ToString()) %></td>
                                <td class="list-group-flush text-center"><%#  GetCleanString(Eval("Losses").ToString()) %></td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                            </tbody>
                            </table>
                        </FooterTemplate>
                    </asp:Repeater>
                    <br />
                    <div class="text-center">
                        <h3 style="text-transform: uppercase;">Powered By:</h3>
                        <img src="core/assets/images/davz-logo.png" style="width: 260px;" />
                    </div>
                </div>
                <div class="col col-md-2">
                    <div class="card">
                        <div class="card-header text-center">
                            <b>Tournament Controls</b>
                        </div>
                        <div class="card-body">
                            <div class="flex-container text-center">
                                <div class="flex-item">
                                    <a href="javascript:;" class="btn btn-primary" data-action-type="winnerorlosser" data-type="left"><i class="bx bx-left-arrow-alt"></i>Left</a>
                                </div>
                                <div class="flex-item">
                                    <a href="javascript:;" class="btn btn-primary" data-action-type="skipmatch"><i class="bx bx-x-circle"></i>Skip</a>
                                </div>
                                <div class="flex-item">
                                    <a href="javascript:;" class="btn btn-primary" data-action-type="winnerorlosser" data-type="right"><i class="bx bx-right-arrow-alt"></i>Right</a>
                                </div>
                            </div>
                            <br />
                            <ul class="list-group list-group-flush">
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
                                    $('[data-action-type="winnerorlosser"]').click(function () {
                                        var $sender = $(this);
                                        var type = $sender.data('type');

                                        var id = $('.js-matching-id').text();
                                        var winnernumber = "";
                                        var lossernumber = "";
                                        var teamname = "";

                                        switch (type) {
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

                                        $.get("/handlers/matching-update-handler.ashx", { id: id, winnerNumber: winnernumber, losserNumber: lossernumber })
                                            .done(function (data) {
                                                $('.js-btn-created').click();

                                                $('.js-pop-up-number').text(winnernumber);
                                                $('.js-pop-up-name').text(teamname);

                                                setTimeout(function () {
                                                    location.reload(true);
                                                }, 1500); // 500 milliseconds = 0.5 seconds

                                            });
                                        return false;
                                    });


                                    $('[data-action-type="skipmatch"]').click(function () {
                                        var $sender = $(this);
                                        var type = $sender.data('type');

                                        var id = $('.js-matching-id').text();

                                        $.get("/handlers/matching-skip-update-handler.ashx", { id: id, sortNumber: <%= _SortNumber %> })
                                            .done(function (data) {
                                                location.reload(true);
                                            });
                                        return false;
                                    });
                                });

                            </script>
                        </div>
                    </div>
                </div>
            </div>

            <button type="button" class="btn btn-primary d-none js-btn-created" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
                Created
            </button>
            <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-body text-center">
                            <h1>Winner</h1>
                            <h2 class="js-pop-up-number"></h2>
                            <br />
                            <h5 class="js-pop-up-name"></h5>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>

