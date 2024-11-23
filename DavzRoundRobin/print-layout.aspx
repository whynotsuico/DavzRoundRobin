<%@ Page Language="C#" %>

<script runat="server">
    private string _CategoryName;
    private string _TeamName;

    protected void Page_PreRenderComplete(object sender, EventArgs e)
    {

        _CategoryName = Request["categoryname"];
        _TeamName = Request["teamname"];

        rptRecieptItems.DataSource = TournamentManager.PrintTimeByMatchingBracketID(Request["bracketid"], Request["bikenumber"]);
        rptRecieptItems.DataBind();
    }
</script>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Receipt Example</title>
    <script src="core/assets/js/qrcode.min.js"></script>
    <link href="core/assets/images/icon.jpg" rel="shortcut icon" type="image/x-icon" />

    <style>
        @media print {
            /* Remove default margins and padding for printing */
            body, html {
                margin: 0;
                padding: 0;
                width: 58mm; /* Set to the width of the thermal printer */
                height: auto; /* Allow height to fit content */
                overflow: visible; /* Ensure content fits within printable area */
            }

            /* Hide any elements not needed in the printout */
            .hidden-print, .hidden-print * {
                display: none;
            }
        }

        /* Basic styles for screen display */
        body {
            font-size: 12px;
            width: 58mm; /* Set to the width of the thermal printer */
            margin: 0;
            padding: 0;
            text-align: center;
            font-family: arial;
        }

        .ticket {
            width: 100%; /* Full width for the ticket */
            margin: 0;
            padding: 0;
        }

        img {
            width: 100%;
            height: auto;
        }

        .centered {
            text-align: center;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 0;
            padding: 0;
        }

        td, th {
            border-top: 1px solid black;
            border-bottom: 1px solid black;
            padding: 2px;
        }

        #qrcode {
            margin-top: 20px;
            width: 75px;
            margin: auto;
        }
    </style>


</head>
<body>
    <form runat="server">
        <div class="ticket">
            <img src="core/assets/images/davz-logo.png" alt="Logo" style="width: 170px;">
            <h3>SMART PORTATREE</h3>
            <p class="centered">
                Timer Receipt<br>
                <%= DateTime.Now.ToLongDateString() %>
                <br />
                <br />
                <%= _CategoryName %>
                <br />
                <%= _TeamName %>
            </p>
            <asp:Repeater runat="server" ID="rptRecieptItems">
                <HeaderTemplate>
                    <table>
                        <thead>
                            <tr>
                                <th class="quantity">#</th>
                                <th class="description">Time</th>
                                <th class="price">Top Speed</th>
                            </tr>
                        </thead>
                        <tbody>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td class="quantity"><%# Container.ItemIndex + 1%></td>
                        <td class="description"><%# Eval("Time").ToString() == DBNull.Value.ToString() ? "00.000" : Eval("Time")%></td>
                        <td class="price"><%# Eval("Top_Speed").ToString() == DBNull.Value.ToString() ? "0" : Eval("Top_Speed") %> KPH</td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </tbody>
            </table>
                </FooterTemplate>
            </asp:Repeater>
            <p class="centered">
                <span style="letter-spacing: 2px;">Thanks for your using</span><br />
                <b>SMART PORTATREE</b>
            </p>
            <div id="qrcode"></div>

            <script type="text/javascript">
                var qrcode = new QRCode(document.getElementById("qrcode"), {
                    text: "https://www.facebook.com/DavzRacingph/",
                    width: 128,
                    height: 128,
                    colorDark: "#000000",
                    colorLight: "#ffffff",
                    correctLevel: QRCode.CorrectLevel.H
                });
            </script>

        </div>
        <br />
        <button id="btnPrint" class="hidden-print">Print</button>

        <script>
            document.getElementById('btnPrint').addEventListener('click', function () {
                window.print();
            });
        </script>
    </form>
</body>
</html>
