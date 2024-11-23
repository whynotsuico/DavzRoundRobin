<%@ Page Language="C#" %>

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

        if (!IsPostBack)
        {
            ddlRegistration.DataSource = TournamentManager.ReadAllRegistrationCategory(_Event.ID);
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
    <script src="core/assets/js/customvalidation.js" type="text/javascript"></script>
</head>
<body>
    <div class="container">
        <form runat="server" id="form" class="register-container-form">
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
            <div class="row g-3">
                <div class="col-md-12">
                    <div class="form-floating">
                        <asp:DropDownList runat="server" DataTextField="CategoryName" DataValueField="ID" ID="ddlRegistration" CssClass="form-select js-category need-validation" autocomplete="off" />
                        <label class="form-label"><b>Category</b></label>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="form-floating">
                        <asp:TextBox runat="server" CssClass="form-control js-team-name need-validation" autocomplete="off" />
                        <label class="form-label"><b>Team Name</b></label>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="form-floating">
                        <asp:TextBox runat="server" CssClass="form-control js-rider-name need-validation" autocomplete="off" />
                        <label class="form-label"><b>Rider Name</b></label>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="form-floating">
                        <asp:TextBox runat="server" type="number" CssClass="form-control js-bike-number need-validation" autocomplete="off" />
                        <label class="form-label"><b>Bike Number</b></label>
                    </div>
                </div>
            </div>
            <br />
            <div class="form-footer d-flex flex-column">
                <button type="button" class="btn-submit-registration"><b>Submit</b></button>
                <button class="btn btn-success btn-block js-button-submit d-none" type="button" disabled="disabled">
                    <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>
                    Loading...
                </button>
                <button type="button" class="btn-view" onclick="location.href='registration-records.aspx'" style="background-color: #ffc107 !important; border: 1px solid #ffc107 !important; color: #000 !important;"><b>View Records</b></button>
            </div>
            <button type="button" class="btn btn-primary d-none js-btn-created" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
                Created
            </button>
            <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-body text-center">
                            <div class="alert alert-success d-none success" role="alert">
                                Successfully Added!
                            </div>
                            <div class="alert alert-danger d-none failed" role="alert">
                                A bike number that already exists cannot be created.

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
            <div class="text-center">
                <span>Powered By:</span>
                <br />
                <img src="core/assets/images/davz-logo.png" style="width: 150px;" />
            </div>
            <script>
                $(document).ready(function () {
                    $('.btn-submit-registration').click(function () {
                        $sender = $(this);

                        if (!validateForm('register-container-form')) return false;

                        $sender.hide();
                        $('.js-button-submit').removeClass("d-none");

                        $.get("/handlers/matching-registration-create-handler.ashx", {
                            eventID: <%= _Event.ID %>,
                            riderName: $('.js-rider-name').val(),
                            dragBikeNumber: $('.js-bike-number').val(),
                            teamName: $('.js-team-name').val(),
                            categoryID: $('.js-category').val()
                        }).done(function (data) {
                            if (data === "failed") {
                                $('.failed').removeClass("d-none");
                            } else {
                                $('.success').removeClass("d-none");
                            }
                            $('.js-button-submit').addClass("d-none");
                            $sender.show();
                            $('.js-btn-created').click();

                            $('.js-rider-name').val("");
                            $('.js-bike-number').val("")
                            $('.js-team-name').val("");
                        });
                        return false;
                    });
                });
            </script>
        </form>

    </div>
</body>
</html>