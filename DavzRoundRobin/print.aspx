<%@ Page Title="Print" Language="C#" MasterPageFile="main.master" %>

<script runat="server">
    private DavzSettings _DavzSettings;
    private Event _Event;

    protected void Page_Load(object sender, EventArgs e)
    {
        _DavzSettings = DavzSettings.Read();

        _Event = TournamentManager.GetEventIDByIsActive();

        if (_Event == null)
        {
            Response.Write("No Race Event: Please get in touch with the administrator.");
            Response.End();
        }

        if (!IsPostBack)
        {
            ddlFilterCategory.DataSource = TournamentManager.ReadAllRegistrationCategory(_Event.ID);
            ddlFilterCategory.DataBind();
            ddlFilterCategory.Items.Insert(0, new ListItem("Select Category", "-1"));

            ddlFilterCategory_SelectedIndexChanged(sender, e);
        }
    }

    protected void ddlFilterCategory_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlBracket.DataSource = TournamentManager.GetAllMatchingBracketByCategoryIDAndEventID(ddlFilterCategory.SelectedValue, _Event.ID);
        ddlBracket.DataBind();
        ddlBracket.Items.Insert(0, new ListItem("Select Category Bracket", "0"));
    }

    protected void btnGenerate_Click(object sender, EventArgs e)
    {
        rptPrintItems.DataSource = TournamentManager.PrintTimeByMatchingBracketID(ddlBracket.SelectedValue, ddlBikeNumber.SelectedValue);
        rptPrintItems.DataBind();
    }

    protected void btnPrint_Click(object sender, EventArgs e)
    {
        Response.Redirect($"print-layout.aspx?bracketid={ddlBracket.SelectedValue}&bikenumber={ddlBikeNumber.SelectedValue}");
    }

    protected void ddlBracket_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlBikeNumber.Items.Clear();
        ddlBikeNumber.Items.Insert(0, new ListItem("Select Team Bike Number", "0"));

        foreach (System.Data.DataRow dr in TournamentManager.GetTournamentMatchingBikeNumbersByBracketID(ddlBracket.SelectedValue).Rows)
        {
            ddlBikeNumber.Items.Add(new ListItem($"{dr["Team_Name"].ToString()} - {dr["Bike_Number"].ToString()}", $"{dr["Bike_Number"].ToString()}"));
        }

        ddlBikeNumber.DataBind();
    }


</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <br />
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item active" aria-current="page">Print</li>
        </ol>
    </nav>

    <div class="row">
        <div class="col col-md-8">
            <div class="card">
                <div class="card-header">
                    <b>Filter</b>
                </div>
                <div class="card-body">
                    <div class="col-md-12">
                        <div class="form-floating">
                            <asp:DropDownList runat="server" DataTextField="CategoryName" DataValueField="ID" ID="ddlFilterCategory" CssClass="form-select event-detail-dropdown-category" OnSelectedIndexChanged="ddlFilterCategory_SelectedIndexChanged" autocomplete="off" AutoPostBack="true" />
                            <label class="form-label"><b>Category</b></label>
                        </div>
                    </div>

                    <br />
                    <div class="col-md-12">
                        <div class="form-floating">
                            <asp:DropDownList runat="server" ID="ddlBracket" DataValueField="ID" DataTextField="BracketName" CssClass="form-select" OnSelectedIndexChanged="ddlBracket_SelectedIndexChanged" AutoPostBack="true" />
                            <label class="form-label"><b>Bracket Name</b></label>
                        </div>
                    </div>
                    <br />
                    <div class="col-md-12">
                        <div class="form-floating">
                            <asp:DropDownList runat="server" DataValueField="ID" ID="ddlBikeNumber" CssClass="form-select event-detail-dropdown-category" autocomplete="off" />
                            <label class="form-label"><b>Bike Number</b></label>
                        </div>
                        <br />
                        <div class="col-md-12 text-center">
                            <asp:Button runat="server" ID="btnGenerate" Text="Generate" CssClass="btn btn-primary text-white" OnClick="btnGenerate_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col col-md-4">
            <div class="card">
                <div class="card-header">
                    <b>Result</b>
                    <%--<asp:Button runat="server" ID="btnPrint" Text="Print" CssClass="btn btn-primary text-white me-0 float-end" OnClick="btnPrint_Click" />--%>
                    <button class="btn btn-primary text-white me-0 float-end" id="print-button">Print</button>
                </div>
                <ul class="list-group list-group-flush">
                    <asp:Repeater runat="server" ID="rptPrintItems">
                        <HeaderTemplate>
                            <table class="table table-sm table-hover table-striped" id="tbl-team-standing">
                                <thead>
                                    <tr>
                                        <th class="text-center">Run #</th>
                                        <th class="text-center">Time</th>
                                        <th class="text-center">Top Speed</th>
                                    </tr>
                                </thead>
                                <tbody>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr class="event-detail-entry-item-list">
                                <td class="text-center"><%# Container.ItemIndex + 1%></td>
                                <td class="text-center"><%# Eval("Time").ToString() == DBNull.Value.ToString() ? "00.000" : Eval("Time")%></td>
                                <td class="text-center"><%# Eval("Top_Speed").ToString() == DBNull.Value.ToString() ? "0" : Eval("Top_Speed") %> KPH</td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                            </tbody>
                  
          </table>
                        </FooterTemplate>
                    </asp:Repeater>
                </ul>
            </div>

            <script>
                $(document).ready(function () {
                    $('#print-button').click(function () {
                        // Get the ID from the button's data attribute
                        var bracketID = $('#<%= ddlBracket.ClientID %>').val();
                        var bikeNumber = $('#<%= ddlBikeNumber.ClientID %>').val();
                        var categoryname = $('#<%= ddlFilterCategory.ClientID %> option:selected').text();
                        var teamname = $('#<%= ddlBikeNumber.ClientID %> option:selected').text();

                        // Open the print layout page with the ID parameter
                        var printWindow = window.open('print-layout.aspx?bracketid=' + bracketID + '&bikenumber=' + bikeNumber + '&categoryname=' + categoryname + '&teamname=' + teamname, 'PrintWindow', 'width=800,height=600');

                        // Ensure the window is fully loaded before triggering print
                        $(printWindow).on('load', function () {
                            printWindow.focus(); // Ensure the print window is focused
                            printWindow.print(); // Trigger the print dialog
                        });
                    });
                });
    </script>
        </div>

    </div>

</asp:Content>

