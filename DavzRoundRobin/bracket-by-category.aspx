<%@ Page Title="Bracket By Category" Language="C#" MasterPageFile="main.master" %>

<script runat="server">
    private Event _Event;
    private RegistrationCategory _RegistrationCategory;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request["id"] != null)
            _Event = Event.Read(Request["id"].ToString());

        if (Request["id"] != null)
            _RegistrationCategory = RegistrationCategory.Read(Request["catid"].ToString());

        if (!IsPostBack)
        {
            ddlAutoGenerateBracket.DataSource = Enumerable.Range(4, 7);
            ddlAutoGenerateBracket.DataBind();
            ddlAutoGenerateBracket.Items.Insert(0, new ListItem("Select Number", "0"));

            ddlBracket.DataSource = TournamentManager.GetAllMatchingBracketByCategoryIDAndEventID(_RegistrationCategory.ID, _Event.ID);
            ddlBracket.DataBind();
            ddlBracket.Items.Insert(0, new ListItem("Select Category Bracket", "0"));
        }
    }

    protected void Page_PreRenderComplete(object sender, EventArgs e)
    {
        pnlViewMatchList.Visible = ddlBracket.SelectedValue != "0";

        rptCategoryItems.DataSource = TournamentManager.ReadAllRegistrationByCategoryAndEventID(_RegistrationCategory.ID, _Event.ID);
        rptCategoryItems.DataBind();

        rptMatchList.DataSource = TournamentManager.GetAllMatchingByMatchingID(ddlBracket.SelectedValue);
        rptMatchList.DataBind();
    }

    protected void btnAutoGenerateMatch_Click(object sender, EventArgs e)
    {
        List<string> bikernumbers = new List<string>();

        var registrations = TournamentManager.ReadAllRegistrationByCategoryAndEventID(_RegistrationCategory.ID, _Event.ID).Where(x => !x.IsAlreadyBracket);

        // Take a random set of registrations
        var randomRegistrations = registrations.OrderBy(x => Guid.NewGuid()).Take(int.Parse(ddlAutoGenerateBracket.SelectedValue));

        foreach (Registration reg in randomRegistrations)
        {
            bikernumbers.Add(reg.ID);
        }

        RoundRobin.GenerateMatchBracket(bikernumbers, _Event.ID, _RegistrationCategory.ID);

        Response.Redirect(Request.RawUrl);
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

        RoundRobin.GenerateMatchBracket(bikernumbers, _Event.ID, _RegistrationCategory.ID);

        Response.Redirect(Request.RawUrl);
    }

    protected void ddlBracket_SelectedIndexChanged(object sender, EventArgs e)
    {
        //Handled in Page_PreRenderComplete
    }

    protected void DeleteEntry(object sender, CommandEventArgs e)
    {
        MatchingBracket.Delete(ddlBracket.SelectedValue);
        Response.Redirect(Request.RawUrl);
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

        span.alert.alert-danger, span.alert.alert-success {
            padding: 4px 10px 4px 10px;
            border-radius: 0px !important;
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
                    <b><%= _RegistrationCategory.CategoryName    %></b>
                </div>
                <div class="card-body">
                    <asp:Repeater runat="server" ID="rptCategoryItems" ItemType="Davz.Tournament.Registration">
                        <HeaderTemplate>
                            <table class=" table table- table-sm table-hover table-striped" id="tbl-team-standing">
                                <thead>
                                    <tr>
                                        <th class="text-center">Select</th>
                                        <th class="text-center">Bike #</th>
                                        <th class="text-center">Rider Name</th>
                                        <th class="text-center">Team Name</th>
                                        <th class="text-center">Bracketed?</th>
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
                                <td class="text-center"><%#Item.DragBikeNumber %></td>
                                <td class="text-center"><%#Item.RiderName %></td>
                                <td class="text-center"><%#Item.TeamName %></td>
                                <td class="text-center"><span class='<%# Item.IsAlreadyBracket ? "alert alert-success" : "alert alert-danger" %>'><%#Item.IsAlreadyBracket ? "Yes" : "No" %></span></td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                            </tbody>
                 </table>
                        </FooterTemplate>
                    </asp:Repeater>
                </div>
                <div class="card-footer text-muted text-center">
                    <a href="javascript:;" class="btn btn-primary text-white me-0" data-bs-toggle="modal" data-bs-target="#EventGenerateBracket"><i class="bx bx-add-to-queue"></i>&nbsp;Auto Generate Bracket</a>

                    <asp:Button runat="server" CssClass="btn btn-primary" ID="btnGenerateBracket" OnClick="btnGenerateBracket_Click" Text="Generate Bracket" />
                </div>
            </div>

            <div class="modal fade" id="EventGenerateBracket" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticEventAutoGenerateModal" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="staticEventAutoGenerateModal">Auto Generate Bracket</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div class="row g-3">
                                <div class="col-md-12">
                                    <div class="form-floating">
                                        <asp:DropDownList runat="server" ID="ddlAutoGenerateBracket" CssClass="form-select" />
                                        <label class="form-label"><b>Number of Player</b></label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <asp:Button runat="server" CssClass="btn btn-primary" ID="btnAutoGenerateMatch" OnClick="btnAutoGenerateMatch_Click" Text="Generate Bracket" />
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col col-md-4">
            <div class="card">
                <div class="card-header">
                    <b>Bracket List</b>
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
            <asp:PlaceHolder runat="server" ID="pnlViewMatchList">
                <div class="card">
                    <div class="card-header">
                        <b>Match List</b>
                        <a href='<%= CommonLinks.Matching %>?bracketID=<%= ddlBracket.SelectedValue %>' target="_blank" class="btn btn-primary float-end">Go to Match UI</a>
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
                    <div class="card-footer text-center">

                        <asp:LinkButton runat="server" class="btn  btn-primary" OnClientClick="return confirmDelete();" OnCommand="DeleteEntry">Delete
                        </asp:LinkButton>
                    </div>
                    <script type="text/javascript">
                        function confirmDelete() {
                            return confirm("Are you sure you want to delete this Bracket?");
                        }
                    </script>
                </div>
            </asp:PlaceHolder>
        </div>
    </div>

</asp:Content>

