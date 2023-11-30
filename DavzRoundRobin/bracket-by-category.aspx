<%@ Page Title="Bracket By Category" Language="C#" MasterPageFile="main.master" %>

<script runat="server">
    private Event _Event;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request["id"] != null)
        {
            _Event = Event.Read(Request["id"].ToString());
        }

        if (!IsPostBack)
        {
            ddlFilterCategory.DataSource = TournamentManager.ReadAllRegistrationCategory(_Event.ID);
            ddlFilterCategory.DataBind();
            ddlFilterCategory.Items.Insert(0, new ListItem("Select Category", "0"));



        }

    }

    protected void Page_PreRenderComplete(object sender, EventArgs e)
    {
        ddlBracket.DataSource = TournamentManager.GetAllMatchingBracketByCategoryIDAndEventID(ddlFilterCategory.SelectedValue, _Event.ID);
        ddlBracket.DataBind();
        ddlBracket.Items.Insert(0, new ListItem("Select Category Bracket", "0"));

        rptCategoryItems.DataSource = TournamentManager.ReadAllRegistrationByCategoryAndEventID(ddlFilterCategory.SelectedValue, _Event.ID);
        rptCategoryItems.DataBind();

    }

    protected void btnCreateCategory_Click(object sender, EventArgs e)
    {

    }

    protected void DeleteCategory(object sender, CommandEventArgs e)
    {

    }

    protected void btnAutoGenerateMatch_Click(object sender, EventArgs e)
    {

    }

    protected void btnGenerateBracket_Click(object sender, EventArgs e)
    {
        List<string> bikernumbers = new List<string>();

        foreach (RepeaterItem item in rptCategoryItems.Items)
        {

            HiddenField hfID = (HiddenField)item.FindControl("hfID");
            CheckBox tsSelectPlayer = (CheckBox)item.FindControl("tsSelectPlayer");

            if (tsSelectPlayer.Checked)
                bikernumbers.Add(hfID.Value);
        }

        RoundRobin.GenerateMatchBracket(bikernumbers, _Event.ID, ddlFilterCategory.SelectedValue);
    }

    protected void ddlBracket_SelectedIndexChanged(object sender, EventArgs e)
    {
        rptMatchList.DataSource = TournamentManager.GetAllMatchingByMatchingID(ddlBracket.SelectedValue);
        rptMatchList.DataBind();
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .flex-main-screen {
            display: flex;
            flex-direction: column; /* Stack the flex containers vertically */
            justify-content: center; /* Center the flex containers vertically */
            height: 55vh; /* Set the height to the full viewport height */
        }

        .flex-container {
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .container-control {
            width: 800px !important;
        }

        .flex-item {
            flex: 1;
            max-width: 50%; /* to ensure items take up half the width */
        }

            .flex-item span {
                font-weight: bold;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href='<%=CommonLinks.DashBoard %>'>Home</a></li>
            <li class="breadcrumb-item"><a href='<%=CommonLinks.EventDetail %>?id=<%= _Event.ID %>'>Event Detail</a></li>
            <li class="breadcrumb-item active" aria-current="page">Bracket By Category</li>
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
                            <asp:DropDownList runat="server" DataTextField="CategoryName" DataValueField="ID" ID="ddlFilterCategory" CssClass="form-select" autocomplete="off" AutoPostBack="true" />
                            <label class="form-label"><b>Category</b></label>
                        </div>
                    </div>
                </div>
            </div>
            <br />
            <div class="card">
                <div class="card-header">
                    <b><%= ddlFilterCategory.SelectedValue == "0" ? "" : $"{ddlFilterCategory.SelectedItem.Text}"    %> Entry List </b>
                </div>
                <div class="card-body">
                    <asp:Repeater runat="server" ID="rptCategoryItems" ItemType="Davz.Tournament.Registration">
                        <HeaderTemplate>
                            <table class=" table table- table-sm table-hover table-striped" id="tbl-team-standing">
                                <thead>
                                    <tr>
                                        <th class="text-center">Select</th>
                                        <th class="text-center">Team Name</th>
                                        <th class="text-center">Rider Name</th>
                                        <th class="text-center">Bike #</th>
                                    </tr>
                                </thead>
                                <tbody>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td class="text-center">
                                    <asp:CheckBox runat="server" ID="tsSelectPlayer" />
                                    <asp:HiddenField runat="server" ID="hfID" Value='<%# Item.ID %>' />
                                </td>
                                <td class="text-center"><%#Item.TeamName %></td>
                                <td class="text-center"><%#Item.RiderName %></td>
                                <td class="text-center"><%#Item.DragBikeNumber %></td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                            </tbody>
                 </table>
                        </FooterTemplate>
                    </asp:Repeater>
                </div>
                <div class="card-footer text-muted text-center">
                    <asp:Button runat="server" CssClass="btn btn-primary" ID="btnAutoGenerateMatch" OnClick="btnAutoGenerateMatch_Click" Text="Auto Generate Bracket" />
                    <asp:Button runat="server" CssClass="btn btn-primary" ID="btnGenerateBracket" OnClick="btnGenerateBracket_Click" Text="Generate Bracket" />
                </div>
            </div>
        </div>

        <div class="col col-md-4">
            <div class="card">
                <div class="card-header">
                    Bracket List
                </div>
                <div class="card-body">
                    <div class="col-md-12">
                        <div class="form-floating">
                            <asp:DropDownList runat="server" ID="ddlBracket" DataValueField="ID" DataTextField="BracketName" OnSelectedIndexChanged="ddlBracket_SelectedIndexChanged" CssClass="form-select" AutoPostBack="true" />
                            <label class="form-label"><b>Bracket Name</b></label>
                        </div>
                    </div>
                </div>
            </div>
            <br />
            <div class="card">
                <div class="card-header">
                    <b>Match List</b>
                    <a href='<%= CommonLinks.Matching %>?eventID=<%= _Event.ID %>' class="btn btn-primary float-end">Go to Match UI</a>
                </div>
                <div class="card-body">
                    <ul class="list-group list-group-flush">
                        <asp:Repeater runat="server" ID="rptMatchList">
                            <ItemTemplate>
                                <li class="list-group-item">
                                    <div class="flex-container text-center">
                                        <div class="flex-item">
                                            <span class="main-number"><%# Eval("Tournament_Matching_Left_Bike_Number") %></span>
                                        </div>
                                        <div class="flex-item">
                                            <span class="animate-charcter main-vs">VS</span>
                                        </div>
                                        <div class="flex-item">
                                            <span class="main-number"><%# Eval("Tournament_Matching_Right_Bike_Number") %></span>
                                        </div>
                                    </div>
                                </li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>
            </div>
        </div>
    </div>

</asp:Content>

