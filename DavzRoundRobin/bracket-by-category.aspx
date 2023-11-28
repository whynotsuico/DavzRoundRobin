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
            ddlFilterCategory.DataSource = TournamentManager.ReadAllRegistrationCategory(_Event.ID).ToList(); ;
            ddlFilterCategory.DataBind();
            ddlFilterCategory.Items.Insert(0, new ListItem("Select Category", "0"));


            //ddlBracketList.DataSource = TournamentManager.ReadAllRegistrationCategory(_Event.ID).ToList(); ;
            //ddlBracketList.DataBind();
            ddlBracketList.Items.Insert(0, new ListItem("Select Category Bracket", "0"));
        }

    }

    protected void Page_PreRenderComplete(object sender, EventArgs e)
    {

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

    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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
                </div>
                <div class="card-footer text-muted text-center">
                    <asp:Button runat="server" CssClass="btn  btn-primary" ID="btnAutoGenerateMatch" OnClick="btnAutoGenerateMatch_Click" Text="Auto Generate Bracket" />
                    <asp:Button runat="server" CssClass="btn  btn-primary" ID="btnGenerateBracket" OnClick="btnGenerateBracket_Click" Text="Generate Bracket" />
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
                            <asp:DropDownList runat="server" ID="ddlBracketList" CssClass="form-select" autocomplete="off" AutoPostBack="true" />
                            <label class="form-label"><b>Category</b></label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


</asp:Content>

