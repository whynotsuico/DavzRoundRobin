<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ddlRegistration.DataSource = TournamentManager.ReadAllCategory();
            ddlRegistration.DataBind();
            ddlRegistration.Items.Insert(0, new ListItem("Select Category", "0"));
        }

    }

    protected void btnConfirm_Click(object sender, EventArgs e)
    {

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
</head>
<body>
    <div class="container">
        <form runat="server" id="form">
            <figure class="text-center">
                <blockquote class="blockquote">
                    <h3>Tournament Registration</h3>
                </blockquote>
                <figcaption class="blockquote-footer">DAVZ RACING 
                </figcaption>
            </figure>
            <br />
            <br />
            <div class="row g-3">
                <div class="col-md-12">
                    <div class="form-floating">
                        <asp:DropDownList runat="server" DataTextField="Name" DataValueField="ID" ID="ddlRegistration" CssClass="form-select need-validation" autocomplete="off" />
                        <label class="form-label"><b>Category</b></label>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="form-floating">
                        <asp:TextBox runat="server" CssClass="form-control js- need-validation" autocomplete="off" />
                        <label class="form-label"><b>Team Name</b></label>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="form-floating">
                        <asp:TextBox runat="server" CssClass="form-control js- need-validation" autocomplete="off" />
                        <label class="form-label"><b>Rider Name</b></label>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="form-floating">
                        <asp:TextBox runat="server" CssClass="form-control js- need-validation" autocomplete="off" />
                        <label class="form-label"><b>Bike Number</b></label>
                    </div>
                </div>
            </div>


            <br />
            <div class="form-footer d-flex">
                <button type="button" id="prevBtn">Submit</button>
                <button class="btn btn-success btn-block js-button-submit hide " type="button" disabled="disabled">
                    <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>
                    Loading...
                </button>
                <input type="button" class="btn btn-success btn-block hide" id="btnSubmitSampleApplication" value="Submit Application" />
            </div>

            <button type="button" class="btn btn-primary d-none js-btn-created" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
                Created
            </button>
            <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-body text-center">
                            <div class="alert alert-success">
                                Application Successfully Created!
                            </div>
                        </div>
                        <div class="modal-footer">
                            <asp:Button runat="server" ID="btnConfirm" CssClass="btn btn-dark btn-sm text-center" Text="Confirm" OnClick="btnConfirm_Click" />
                        </div>
                    </div>
                </div>
            </div>
            <br />
            <br />

        </form>

    </div>
</body>
</html>
