<%@ Page Title="Category" Language="C#" MasterPageFile="main.master" %>

<%@ Import Namespace="System.Data" %>
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
            ddlAddEventCategory.DataSource = TournamentManager.ReadAllCategory();
            ddlAddEventCategory.DataBind();
            ddlAddEventCategory.Items.Insert(0, new ListItem("Select Category", ""));

            var lstEventCategory = TournamentManager.ReadAllRegistrationCategory(_Event.ID).ToList();

            ddlFilterCategory.DataSource = lstEventCategory;
            ddlFilterCategory.DataBind();
            ddlFilterCategory.Items.Insert(0, new ListItem("Select Category", "-1"));

            ddlCategory.DataSource = lstEventCategory;
            ddlCategory.DataBind();
            ddlCategory.Items.Insert(0, new ListItem("Select Category", ""));
        }
    }

    protected void Page_PrerenderComplete(object sender, EventArgs e)
    {
        rptEventCategory.DataSource = TournamentManager.GetAllRegistrationCategory(_Event.ID);
        rptEventCategory.DataBind();

        rptEntryList.DataSource = TournamentManager.GetAllRegistrationByEventID(_Event.ID, ddlFilterCategory.SelectedValue).Tables[0];
        rptEntryList.DataBind();

        categorynotfound.Visible = rptEventCategory.Items.Count == 0;
    }


    protected void btnCreateEntry_Click(object sender, EventArgs e)
    {
        Registration reg = TournamentManager.ReadBikeNumberByBikeNumber(txtBikeNumber.Text, ddlCategory.SelectedValue);

        if (reg != null)
        {
            pnlViewAlreadyExist.Visible = true;
            return;
        }

        Registration.Create(_Event.ID, txtRiderName.Text, txtBikeNumber.Text, ddlCategory.SelectedValue, txtTeamName.Text);


        Response.Redirect(Request.RawUrl);
    }

    protected void btnAddCategory_Click(object sender, EventArgs e)
    {
        RegistrationCategory.Create(ddlAddEventCategory.SelectedValue, _Event.ID);

        Response.Redirect(Request.RawUrl);
    }

    protected void DeleteEntry(object sender, CommandEventArgs e)
    {
        Registration.Delete(e.CommandArgument.ToString());
        Response.Redirect(Request.RawUrl);
    }

    protected void DeleteRegistrationCategoryEntry(object sender, CommandEventArgs e)
    {
        RegistrationCategory.Delete(e.CommandArgument.ToString());
        Response.Redirect(Request.RawUrl);
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href='<%=CommonLinks.DashBoard %>'>Home</a></li>
            <li class="breadcrumb-item active" aria-current="page">Event Detail</li>
        </ol>
    </nav>
    <asp:PlaceHolder runat="server" ID="pnlViewAlreadyExist" Visible="false">
        <div class="alert alert-danger" role="alert">
            A bike number that already exists cannot be created.
        </div>
    </asp:PlaceHolder>
    <div class="row">
        <div class="col col-md-8">
            <div class="card">
                <div class="card-header">
                    <b>Tools</b>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col col-md-6">
                            <a href="javascript:;" class="btn btn-primary text-white me-0" data-bs-toggle="modal" data-bs-target="#EntryModal"><i class="bx bx-add-to-queue"></i>&nbsp;New Entry</a>
                        </div>
                        <div class="col col-md-6">
                        </div>
                    </div>
                    <div class="modal fade" id="EntryModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="staticBackdropLabel">Add New Entry</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body entry-container-form">
                                    <div class="row g-3">
                                        <div class="col-md-12">
                                            <div class="form-floating">
                                                <asp:DropDownList runat="server" DataTextField="CategoryName" DataValueField="ID" ID="ddlCategory" CssClass="form-select need-validation" autocomplete="off" />
                                                <label class="form-label"><b>Category</b></label>
                                                <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlCategory" CssClass="d-none" ValidationGroup="CreateEntry" ErrorMessage="Required" />
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="form-floating">
                                                <asp:TextBox runat="server" type="text" CssClass="form-control need-validation" ID="txtTeamName" autocomplete="off" />
                                                <label class="form-label"><b>Team Name</b></label>
                                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtTeamName" CssClass="d-none" ValidationGroup="CreateEntry" ErrorMessage="Required" />
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="form-floating">
                                                <asp:TextBox runat="server" type="text" CssClass="form-control need-validation" ID="txtRiderName" autocomplete="off" />
                                                <label class="form-label"><b>Rider Name</b></label>
                                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtRiderName" CssClass="d-none" ValidationGroup="CreateEntry" ErrorMessage="Required" />
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="form-floating">
                                                <asp:TextBox runat="server" type="number" CssClass="form-control need-validation" ID="txtBikeNumber" autocomplete="off" />
                                                <label class="form-label"><b>Drag Bike Number</b></label>
                                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtBikeNumber" CssClass="d-none" ValidationGroup="CreateEntry" ErrorMessage="Required" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <asp:Button runat="server" ID="btnCreateEntry" CssClass="btn btn-primary btn-create-entry" OnClick="btnCreateEntry_Click" Text="Save" ValidationGroup="CreateEntry" CausesValidation="true" />
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <br />
            <div class="card">
                <div class="card-header">
                    <b>Filter</b>
                </div>
                <div class="card-body">
                    <div class="col-md-12">
                        <div class="form-floating">
                            <asp:DropDownList runat="server" DataTextField="CategoryName" DataValueField="ID" ID="ddlFilterCategory" CssClass="form-select event-detail-dropdown-category" autocomplete="off" AutoPostBack="true" />
                            <label class="form-label"><b>Category</b></label>
                        </div>
                    </div>
                </div>
            </div>
            <br />

            <asp:Repeater runat="server" ID="rptEntryList">
                <ItemTemplate>
                    <div class="card">
                        <div class="card-header">
                            <b><%# Eval("Tournament_Category_Name") %></b>
                            <a href='<%= CommonLinks.EventBracketByCategory %>?id=<%# _Event.ID %>&catid=<%# Eval("Registration_Category_ID") %>' class="btn btn-primary text-white me-0 float-end"><i class="bx bx-git-compare"></i>&nbsp;Bracket Category</a>
                        </div>
                        <div class="card-body">
                            <asp:Repeater runat="server" ID="rptItems" DataSource='<%#((DataRowView)Container.DataItem).CreateChildView("LineItems") %>'>
                                <HeaderTemplate>
                                    <table class="table table-sm table-hover table-striped" id="tbl-team-standing">
                                        <thead>
                                            <tr>
                                                <th class="text-center">Bike #</th>
                                                <th class="text-center">Rider Name</th>
                                                <th class="text-center">Team Name</th>
                                                <th class="text-center">Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <tr class="event-detail-entry-item-list">
                                        <td class="text-center"><%# Eval("Tournament_Registration_Drag_Bike_Number")%></td>
                                        <td class="text-center"><%# Eval("Tournament_Registration_Rider_Name")%></td>
                                        <td class="text-center"><%# Eval("Tournament_Registration_Team_Name") %></td>
                                        <td class="text-center">
                                            <asp:LinkButton runat="server" class="btn btn-sm btn-danger" OnClientClick="return confirmDelete();" OnCommand="DeleteEntry" CommandArgument='<%# Eval("Tournament_Registration_ID") %>'>
                                                        <i class="bx bx-trash-alt icon"></i>
                                            </asp:LinkButton></td>
                                    </tr>
                                </ItemTemplate>
                                <FooterTemplate>
                                    </tbody>
                                            <script type="text/javascript">
                                                function confirmDelete() {
                                                    return confirm("Are you sure you want to delete this Entry?");
                                                }

                                                function confirmRegistrationCategoryDelete() {
                                                    return confirm("Are you sure you want to delete this Registration Category?");
                                                }
                                            </script>
                                    </table>
                                </FooterTemplate>
                            </asp:Repeater>
                        </div>
                    </div>
                    <br />
                </ItemTemplate>
            </asp:Repeater>



        </div>
        <script>
            $(document).ready(function () {
                $('.btn-create-entry').click(function () {
                    if (!validateForm('entry-container-form')) return false;
                });
            });
        </script>
        <div class="col col-md-4">
            <div class="card">
                <div class="card-header">
                    <b>Event Category</b>
                    <a href="javascript:;" class="btn btn-primary text-white me-0 float-end" data-bs-toggle="modal" data-bs-target="#EventCategoryModal"><i class="bx bx-add-to-queue"></i>&nbsp;Add Category</a>
                </div>
                <div class="card-body">
                    <ul class="list-group list-group-flush">
                        <li runat="server" id="categorynotfound" class="list-group-item">No Category Found</li>
                        <asp:Repeater runat="server" ID="rptEventCategory">
                            <ItemTemplate>
                                <li class="list-group-item">
                                    <a href='javascript:;'><%# Eval("Tournament_Category_Name") %>
                                    </a>
                                    <asp:LinkButton runat="server" class="btn btn-sm btn-danger float-end text-white" OnClientClick="return confirmRegistrationCategoryDelete();" OnCommand="DeleteRegistrationCategoryEntry" CommandArgument='<%# Eval("Registration_Category_ID") %>'>
                                          <i class="bx bx-trash-alt icon"></i>
                                    </asp:LinkButton></td>
                                </li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>
            </div>
            <div class="modal fade" id="EventCategoryModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticEventCategoryModal" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="staticEventCategoryModal">Add Event Category</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body category-container-form">
                            <div class="row g-3">
                                <div class="col-md-12">
                                    <div class="form-floating">
                                        <asp:DropDownList runat="server" DataTextField="Name" DataValueField="ID" ID="ddlAddEventCategory" CssClass="form-select need-validation" autocomplete="off" />
                                        <label class="form-label"><b>Category</b></label>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlAddEventCategory" CssClass="d-none" ValidationGroup="CreateCategory" ErrorMessage="Required" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <asp:Button runat="server" ID="btnAddCategory" CssClass="btn btn-primary btn-create-category" OnClick="btnAddCategory_Click" Text="Save" ValidationGroup="CreateCategory" CausesValidation="true" />
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <script>
                                $(document).ready(function () {
                                    $('.btn-create-category').click(function () {
                                        if (!validateForm('category-container-form')) return false;
                                    });
                                });
                            </script>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

