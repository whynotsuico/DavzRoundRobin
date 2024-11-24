<%@ Page Title="Best Time By Category" Language="C#" MasterPageFile="main.master" %>

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

        }
    }


    protected void btnGenerate_Click(object sender, EventArgs e)
    {
        rptPrintItems.DataSource = TournamentManager.GetBestTeamTimeTournamentMatchingByCategoryID(ddlFilterCategory.SelectedValue);
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
            <li class="breadcrumb-item active" aria-current="page">Best Time By Category</li>
        </ol>
    </nav>

    <div class="row">
        <div class="col col-md-6">
            <div class="card">
                <div class="card-header">
                    <b>Filter</b>
                </div>
                <div class="card-body">
                    <div class="col-md-12">
                        <div class="form-floating">
                            <asp:DropDownList runat="server" DataTextField="CategoryName" DataValueField="ID" ID="ddlFilterCategory" CssClass="form-select event-detail-dropdown-category" />
                            <label class="form-label"><b>Category</b></label>
                        </div>
                    </div>

                    <br />
                    <div class="col-md-12">
                        <div class="col-md-12 text-center">
                            <asp:Button runat="server" ID="btnGenerate" Text="Generate" CssClass="btn btn-primary text-white" OnClick="btnGenerate_Click" />
                        </div>
                    </div>

                </div>
            </div>
        </div>
        <div class="col col-md-6">
            <div class="card">
                <div class="card-header">
                    <b>Results</b>
                </div>
                <div class="card-body">
                    <asp:Repeater runat="server" ID="rptPrintItems">
                        <HeaderTemplate>
                            <table class="table table-sm  table-bordered" id="tbl-team-standing">
                                <thead>
                                    <tr>
                                        <td class="text-center">Rank</td>
                                        <td class="text-center">Team</td>
                                        <td class="text-center">Time</td>
                                    </tr>
                                </thead>
                                <tbody>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr class="event-detail-entry-item-list">
                                <td class="text-center"><%# Container.ItemIndex + 1 %></td>
                                <td class="text-center"><%# Eval("[Team_Name]") %></td>
                                <td class="text-center"><%# Eval("[Team_Time]") %></td>
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

