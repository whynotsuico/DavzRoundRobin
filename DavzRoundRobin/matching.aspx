<%@ Page Title="" Language="C#" %>

<!DOCTYPE html>

<script runat="server">

    protected void Page_PreRenderComplete(object sender, EventArgs e)
    {
        rptTeamStanding.DataSource = Enumerable.Range(1, 10);
        rptTeamStanding.DataBind();
        //testasdasd
        rptMatchingNow.DataSource = TournamentManager.GetTop1MatchingByMatchingID(Request["bracketID"].ToString());
        rptMatchingNow.DataBind();
        
        rptNextMatch.DataSource = TournamentManager.GetTop3MatchingByMatchingID(Request["bracketID"].ToString());
        rptNextMatch.DataBind();
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
                                            <h1 class="main-number"><%# Eval("Tournament_Matching_Left_Bike_Number") %></h1>
                                        </div>
                                        <div class="flex-item">
                                            <%--  <h1 class="animate-charcter main-vs">VS</h1>--%>
                                        </div>
                                        <div class="flex-item">
                                            <h1 class="main-number"><%# Eval("Tournament_Matching_Right_Bike_Number") %></h1>
                                        </div>
                                    </div>
                                    <br />
                                    <div class="flex-container text-center">
                                        <div class="flex-item">
                                            <h5 class="main-team-name">Davz Racing Team</h5>
                                        </div>
                                        <div class="flex-item">
                                        </div>
                                        <div class="flex-item">
                                            <h5 class="main-team-name">Team Mac</h5>
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
                                <td class="list-group-flush text-center"><%# Container.DataItem %></td>
                                <td class="list-group-flush text-center">Davz Racing Team</td>
                                <td class="list-group-flush text-center">01</td>
                                <td class="list-group-flush text-center">10</td>
                                <td class="list-group-flush text-center">0</td>
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
                                    <a href="#" class="btn btn-primary"><i class="bx bx-left-arrow-alt"></i>Left</a>
                                </div>
                                <div class="flex-item">
                                    <a href="#" class="btn btn-primary"><i class="bx bx-x-circle"></i>Skip</a>
                                </div>
                                <div class="flex-item">
                                    <a href="#" class="btn btn-primary"><i class="bx bx-right-arrow-alt"></i>Right</a>
                                </div>
                            </div>

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
                            </script>
                            <%--  <ul class="list-group list-group-flush" id="myList">
                                    <asp:Repeater runat="server" ID="rptListofMatches">
                                        <ItemTemplate>
                                            <li>
                                                <div class="flex-container text-center">
                                                    <div class="flex-item">
                                                        <span>102</span>
                                                    </div>
                                                    <div class="flex-item">
                                                        <span>VS</span>
                                                    </div>
                                                    <div class="flex-item">
                                                        <span>143</span>
                                                    </div>
                                                </div>
                                            </li>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </ul>--%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>

