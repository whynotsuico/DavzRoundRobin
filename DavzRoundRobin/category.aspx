<%@ Page Title="Category" Language="C#" MasterPageFile="main.master" %>

<script runat="server">
    protected void Page_PreRenderComplete(object sender, EventArgs e)
    {
        rptCategoryList.DataSource = TournamentManager.ReadAllCategory();
        rptCategoryList.DataBind();

        notfoundlist.Visible = rptCategoryList.Items.Count == 0;
    }

    protected void btnCreateCategory_Click(object sender, EventArgs e)
    {
        Category.Create(txtCategoryName.Text);

        Response.Redirect(Request.RawUrl);
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="row">
        <div class="col col-md-8">
            <div class="card">
                <div class="card-header">
                    <b>Recent Racing Category</b>
                    <a href="javascript:;" class="btn btn-primary text-white me-0 float-end" data-bs-toggle="modal" data-bs-target="#staticBackdrop"><i class="bx bx-add-to-queue"></i>&nbsp;Add Category</a>
                </div>
                <ul class="list-group list-group-flush">
                    <li runat="server" id="notfoundlist" class="list-group-item">Not Category Found</li>
                    <asp:Repeater runat="server" ID="rptCategoryList">
                        <ItemTemplate>
                            <li class="list-group-item">
                                <a href="javascript:;"><%# Eval("Name") %>
                                    <br />
                                </a>
                            </li>
                        </ItemTemplate>
                    </asp:Repeater>
                </ul>

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
                                            <asp:TextBox runat="server" type="text" CssClass="form-control" ID="txtCategoryName" autocomplete="off" />
                                            <label class="form-label"><b>Category Name</b></label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <asp:Button runat="server" ID="btnCreateCategory" CssClass="btn btn-primary" OnClick="btnCreateCategory_Click" Text="Save" />
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
            </div>
        </div>
    </div>


</asp:Content>

