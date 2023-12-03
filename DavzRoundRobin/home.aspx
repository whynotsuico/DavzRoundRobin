<%@ Page Title="Dashboard" Language="C#" MasterPageFile="main.master" %>

<script runat="server">
    protected void Page_PrerenderComplete(object sender, EventArgs e)
    {
        rptCategoryList.DataSource = TournamentManager.ReadAllCategory();
        rptCategoryList.DataBind();

        rptEventList.DataSource = TournamentManager.ReadAllEvent();
        rptEventList.DataBind();

        notfoundlist.Visible = rptEventList.Items.Count == 0;
    }

    protected void btnCreateEvent_Click(object sender, EventArgs e)
    {
        var eventCreate = Event.Create(txtEventName.Text, DateTime.Now, DateTime.Parse(txtStartDate.Text), DateTime.Parse(txtEndDate.Text));

        Response.Redirect($"{CommonLinks.EventDetail}?id={eventCreate.ID}");
    }

    protected void DeleteEvent(object sender, CommandEventArgs e)
    {
        Event.Delete(e.CommandArgument.ToString());

        Response.Redirect(Request.RawUrl);
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <div class="home-tab">
        <div class="d-sm-flex align-items-center justify-content-between border-bottom">
            <ul class="nav nav-tabs" role="tablist">
                <li class="nav-item">
                    <a class="nav-link active ps-0" id="home-tab" data-bs-toggle="tab" href="#overview" role="tab" aria-controls="overview" aria-selected="true">Overview</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="profile-tab" data-bs-toggle="tab" href="#audiences" role="tab" aria-selected="false">Audiences</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="contact-tab" data-bs-toggle="tab" href="#demographics" role="tab" aria-selected="false">Demographics</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link border-0" id="more-tab" data-bs-toggle="tab" href="#more" role="tab" aria-selected="false">More</a>
                </li>
            </ul>
            <div>
                <div class="btn-wrapper">
                    <a href="javascript:;" class="btn btn-otline-dark align-items-center"><i class="bx bx-share-alt"></i>&nbsp;Share</a>
                    <a href="javascript:;" class="btn btn-otline-dark"><i class="bx bx-printer"></i>&nbsp;Print</a>
                    <a href="javascript:;" class="btn btn-primary text-white me-0"><i class="bx bx-export"></i>&nbsp;Export</a>
                </div>
            </div>
        </div>
    </div>
    <br />
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item active" aria-current="page">Home</li>
        </ol>
    </nav>
    <div class="row">
        <div class="col col-md-8">
            <div class="card">
                <div class="card-header">
                    <b>Recent Racing Event</b>
                    <a href="javascript:;" class="btn btn-primary text-white me-0 float-end" data-bs-toggle="modal" data-bs-target="#staticBackdrop"><i class="bx bx-add-to-queue"></i>&nbsp;Add Event</a>
                </div>
                <div class="card-body">
                    <ul class="list-group list-group-flush">
                        <li runat="server" id="notfoundlist" class="list-group-item">No Event Found</li>
                        <asp:Repeater runat="server" ID="rptEventList">
                            <ItemTemplate>
                                <li class="list-group-item list-group-item-action dashboard-event-list" onclick="location.href='<%# CommonLinks.EventDetail %>?id=<%# Eval("ID") %>'">
                                    <a><%# Eval("Name") %>
                                        <asp:LinkButton runat="server" class="btn btn-sm btn-danger float-end text-white" OnClientClick="return confirmDelete();" OnCommand="DeleteEvent" CommandArgument='<%# Eval("ID") %>'>
                                            <i class="bx bx-trash-alt icon"></i>
                                        </asp:LinkButton>
                                        <br />
                                        <span>
                                            <i class="bx bx-calendar"></i>&nbsp;<%# Eval("StartDate","{0:MMMM d, yyyy}") %> - <i class="bx bx-calendar"></i>&nbsp;<%# Eval("EndDate","{0:MMMM d, yyyy}") %>
                                        </span>
                                    </a>
                                </li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>

                <script type="text/javascript">
                    function confirmDelete() {
                        return confirm("Are you sure you want to delete this Event?");
                    }
                </script>

                <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="staticBackdropLabel">Add Racing Event</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <div class="row g-3">
                                    <div class="col-md-12">
                                        <div class="form-floating">
                                            <asp:TextBox runat="server" type="text" CssClass="form-control" ID="txtEventName" autocomplete="off" />
                                            <label class="form-label"><b>Event Name</b></label>
                                        </div>
                                    </div>
                                    <div class="col-md-12">
                                        <div class="form-floating">
                                            <asp:TextBox runat="server" type="date" CssClass="form-control" ID="txtStartDate" autocomplete="off" />
                                            <label class="form-label"><b>Event Start Date</b></label>
                                        </div>
                                    </div>
                                    <div class="col-md-12">
                                        <div class="form-floating">
                                            <asp:TextBox runat="server" type="date" CssClass="form-control" ID="txtEndDate" autocomplete="off" />
                                            <label class="form-label"><b>Event End Date</b></label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <asp:Button runat="server" ID="btnCreateEvent" CssClass="btn btn-primary" OnClick="btnCreateEvent_Click" Text="Save" />
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col col-md-4">
            <div class="card">
                <div class="card-header">
                    Categories
                </div>
                <div class="card-body">
                    <ul class="list-group list-group-flush list-group-numbered">
                        <asp:Repeater runat="server" ID="rptCategoryList">
                            <ItemTemplate>
                                <li class="list-group-item list-group-item-action">
                                    <a id='<%# Eval("ID") %>'><%# Eval("Name") %></a>
                                </li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>
            </div>
        </div>
    </div>


    <%--<div class="card text-center">
            <div class="card-header">
                Featured
            </div>
            <div class="card-body">
                <h5 class="card-title">Special title treatment</h5>
                <p class="card-text">With supporting text below as a natural lead-in to additional content.</p>
                <a href="#" class="btn btn-primary">Go somewhere</a>
            </div>
            <div class="card-footer text-muted">
                2 days ago
            </div>
        </div>--%>
</asp:Content>

