<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<script runat="server">
    private Event _Event;

    protected void Page_Load(object sender, EventArgs e)
    {
        _Event = TournamentManager.GetEventIDByIsActive();

        if (_Event == null)
        {
            Response.Write("No Race Event: Please get in touch with the administrator.");
            Response.End();
        }

        var lstEventCategory = TournamentManager.ReadAllRegistrationCategory(_Event.ID).ToList();

        ddlFilterCategory.DataSource = lstEventCategory;
        ddlFilterCategory.DataBind();
        ddlFilterCategory.Items.Insert(0, new ListItem("Select Category", "-1"));
    }
    protected void Page_PrerenderComplete(object sender, EventArgs e)
    {
        rptEntryList.DataSource = TournamentManager.GetAllRegistrationByEventID(_Event.ID, ddlFilterCategory.SelectedValue).Tables[0];
        rptEntryList.DataBind();
    }

    protected void DeleteEntry(object sender, CommandEventArgs e)
    {
        Registration.Delete(e.CommandArgument.ToString());
        Response.Redirect(Request.RawUrl);
    }

</script>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>Davz Racing Tournament System | Home </title>

    <link href="core/assets/images/icon.jpg" rel="shortcut icon" type="image/x-icon" />

    <link type="text/css" href="core/assets/css/bootstrap.min.css" rel="stylesheet" />
    <link type="text/css" href="core/assets/css/custom.css" rel="stylesheet" />
    <link type="text/css" href="core/assets/css/boxicons.min.css" rel="stylesheet" />

    <script src="core/assets/js/popper.min.js" type="text/javascript"></script>
    <script src="core/assets/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="core/assets/js/jquery-3.7.1.min.js" type="text/javascript"></script>
    <script src="core/assets/js/customvalidation.js" type="text/javascript"></script>
</head>
<body>
    <div class="container container-records">
        <form runat="server" id="form">
            <figure class="text-center">
                <blockquote class="blockquote">
                    <h1 style="color: #e84a5f !important;"><b><%= _Event.Name %></b></h1>
                    <h4>Tournament Registration</h4>
                </blockquote>
                <figcaption class="blockquote-footer">DAVZ RACING 
                </figcaption>
            </figure>
            <br />
            <br />
            <div class="card">
                <div class="card-header">
                    <b>Filter</b>
                    <a href="registration.aspx" class="btn btn-primary btn-sm btn-primary text-white me-0 float-end"><i class="bx bx-add-to-queue"></i>&nbsp;New Entry</a>
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
                        </div>
                        <div class="card-body">
                            <asp:Repeater runat="server" ID="rptItems" DataSource='<%#((DataRowView)Container.DataItem).CreateChildView("LineItems") %>'>
                                <HeaderTemplate>
                                    <table class=" table table- table-sm table-hover table-striped" id="tbl-team-standing">
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
                                 </script>
                                    </table>
                                </FooterTemplate>
                            </asp:Repeater>
                        </div>
                    </div>
                    <br />
                </ItemTemplate>
            </asp:Repeater>
            <br />
            <br />
            <div class="text-center">
                <span>Powered By:</span>
                <br />
                <img src="core/assets/images/davz-logo.png" style="width: 150px;" />
            </div>
        </form>

    </div>
</body>
</html>
