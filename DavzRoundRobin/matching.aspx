<%@ Page Title="" Language="C#" %>

<!DOCTYPE html>

<script runat="server">

    protected void Page_PreRenderComplete(object sender, EventArgs e)
    {
        rptListofMatches.DataSource = Enumerable.Range(1, 10);
        rptListofMatches.DataBind();
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
    <link type="text/css" href="core/assets/css/custom.css" rel="stylesheet">
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
            <div class="card full-height-container gradient-border">

                <div class="row">
                    <div class="col col-md-3 d-flex justify-content-center">
                        <script type="text/javascript">

                            $(document).ready(function () {
                                $('.standing-list li').each(function () {
                                    var delay = ($(this).index() / 4) + 's';
                                    $(this).css({
                                        webkitAnimationDelay: delay,
                                        mozAnimationDelay: delay,
                                        animationDelay: delay
                                    });
                                });
                            });
                        </script>
                        <ul class="standing-list">
                            <asp:Repeater runat="server" ID="rptListofMatches">
                                <ItemTemplate>
                                    <li>
                                        <span>Davz Racing Team</span>
                                    </li>
                                </ItemTemplate>
                            </asp:Repeater>
                        </ul>
                    </div>
                    <div class="col col-md-6">
                        <br />
                        <br />
                        <div class="wrapper">
                            <h1>Now Matching...</h1>
                        </div>
                        <div class="flex-main-screen">
                            <br />
                            <br />
                            <div class="flex-container text-center">
                                <div class="flex-item">
                                    <h5 class="main-identity">Left</h5>
                                </div>
                                <div class="flex-item">
                                </div>
                                <div class="flex-item">
                                    <h5 class="main-identity">Right</h5>
                                </div>
                            </div>
                            <br />
                            <br />
                            <div class="flex-container text-center">
                                <div class="flex-item">
                                    <h1 class="main-number">101</h1>
                                </div>
                                <div class="flex-item">
                                    <h1 class="animate-charcter main-vs">VS</h1>
                                </div>
                                <div class="flex-item">
                                    <h1 class="main-number">145</h1>
                                </div>
                            </div>
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


                        </div>
                    </div>
                    <%-- <div class="col col-md-3">
                    </div>--%>
                </div>

            </div>
            <br />
            <div class="container container-control">
                <div class="card">
                    <div class="card-header text-center">
                        <b>Tournament Controls</b>
                    </div>
                    <div class="card-body">
                        <div class="flex-container text-center">
                            <div class="flex-item">
                                <a href="#" class="btn btn-primary"><i class="bx bx-left-arrow-alt"></i>&nbsp;Left Win</a>
                            </div>
                            <div class="flex-item">
                                <a href="#" class="btn btn-primary"><i class="bx bx-x-circle"></i>&nbsp;Skip</a>
                            </div>
                            <div class="flex-item">
                                <a href="#" class="btn btn-primary"><i class="bx bx-right-arrow-alt"></i>&nbsp;Right Win</a>
                            </div>
                        </div>

                        <%--<script type="text/javascript">

                        $(document).ready(function () {
                            $('.list-group-flush li').each(function () {
                                var delay = ($(this).index() / 4) + 's';
                                $(this).css({
                                    webkitAnimationDelay: delay,
                                    mozAnimationDelay: delay,
                                    animationDelay: delay
                                });
                            });
                        });
                    </script>--%>
                        <%-- <ul class="list-group list-group-flush" id="myList">
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
    </form>
</body>
</html>

