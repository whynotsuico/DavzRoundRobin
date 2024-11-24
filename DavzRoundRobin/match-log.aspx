<%@ Page Title="Match Logs" Language="C#" MasterPageFile="main.master" %>

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
        rptPrintItems.DataSource = TournamentManager.GetAllMatchingByMatchingID(ddlBracket.SelectedValue);
        rptPrintItems.DataBind();
    }


</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <br />
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href='<%=CommonLinks.DashBoard %>'>Home</a></li>
            <li class="breadcrumb-item"><a href='<%=CommonLinks.Reports %>'>Reports</a></li>
            <li class="breadcrumb-item active" aria-current="page">Match Logs</li>
        </ol>
    </nav>

    <div class="row">
        <div class="col col-md-12">
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
                            <asp:DropDownList runat="server" ID="ddlBracket" DataValueField="ID" DataTextField="BracketName" CssClass="form-select" />
                            <label class="form-label"><b>Bracket Name</b></label>
                        </div>
                    </div>
                    <br />
                    <div class="col-md-12">
                        <div class="col-md-12 text-center">
                            <asp:Button runat="server" ID="btnGenerate" Text="Generate" CssClass="btn btn-primary text-white" OnClick="btnGenerate_Click" />
                        </div>
                    </div>
                    <br />
                    <asp:Repeater runat="server" ID="rptPrintItems">
                        <HeaderTemplate>
                            <table class="table table-sm  table-bordered" id="tbl-team-standing">
                                <thead>
                                    <tr>
                                        <td class="text-center">Match #</td>
                                        <td class="text-center" colspan="4">Left Team Details</td>
                                        <td class="text-center">VS</td>
                                        <td class="text-center" colspan="4">Right Team Details</td>
                                    </tr>
                                    <tr>
                                        <td class="text-center"></td>
                                        <td class="text-center">Team Name</td>
                                        <td class="text-center">Bike Number</td>
                                        <td class="text-center">Time</td>
                                        <td class="text-center">Top Speed</td>
                                        <td></td>
                                        <td class="text-center">Team Name</td>
                                        <td class="text-center">Bike Number</td>
                                        <td class="text-center">Time</td>
                                        <td class="text-center">Top Speed</td>
                                    </tr>
                                </thead>
                                <tbody>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr class="event-detail-entry-item-list">
                                <td class="text-center"><%# Container.ItemIndex + 1 %></td>
                                <td><%# Eval("[Tournament_Matching_Left_Team_Name]") %></td>
                                <td class="text-center"><%# Eval("[Tournament_Matching_Left_Bike_Number]") %></td>
                                <td class="text-center"><%# Eval("[Tournament_Matching_Left_Team_Time]") %></td>
                                <td class="text-center"><%# Eval("[Tournament_Matching_Left_Team_Top_Speed]") %>&nbsp;kph</td>
                                <td class="text-center">VS</td>
                                <td><%# Eval("[Tournament_Matching_Right_Team_Name]") %></td>
                                <td class="text-center"><%# Eval("[Tournament_Matching_Right_Bike_Number]") %></td>
                                <td class="text-center"><%# Eval("[Tournament_Matching_Right_Team_Time]") %></td>
                                <td class="text-center"><%# Eval("[Tournament_Matching_Right_Team_Top_Speed]") %>&nbsp;kph</td>
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

</asp:Content>

