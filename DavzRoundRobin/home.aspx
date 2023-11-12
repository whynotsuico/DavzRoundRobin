<%@ Page Title="" Language="C#" MasterPageFile="main.master" %>

<script runat="server">

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
                    <a class="nav-link" id="contact-tab" data-bs-toggle="tab" href="#demographics" role="tab" aria-selected="false">DemographicsTest</a>
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
    <div class="row">
        <div class="col col-md-8">
            <div class="card">
                <div class="card-header">
                    <b>Recent Racing Event</b>
                </div>
                <ul class="list-group list-group-flush">
                    <li class="list-group-item">
                        <a href="javascript:;">Speed Wards Event 1
                        <br />
                            <span>
                                <i class="bx bx-calendar"></i>&nbsp;December 9, 2020
                            </span>
                        </a>

                    </li>
                    <li class="list-group-item">
                        <a href="javascript:;">Speed Wards Event 2
                          <br />
                            <span>
                                <i class="bx bx-calendar"></i>&nbsp;September 9, 2021 - September 10, 2021
                            </span>
                        </a>

                    </li>
                    <li class="list-group-item">
                        <a href="javascript:;">Speed Wards Event 3
                          <br />
                            <span>
                                <i class="bx bx-calendar"></i>&nbsp;August 10, 2023 - August 13, 2023
                            </span>
                        </a>

                    </li>
                    <li class="list-group-item">
                        <a href="javascript:;">Speed Wards Event 4
                              <br />
                            <span>
                                <i class="bx bx-calendar"></i>&nbsp;August 10, 2023 - August 13, 2023
                            </span>
                        </a>

                    </li>
                    <li class="list-group-item">
                        <a href="javascript:;">Speed Wards Event 5
                             <br />
                            <span>
                                <i class="bx bx-calendar"></i>&nbsp;August 10, 2023 - August 13, 2023
                            </span>
                        </a>

                    </li>
                </ul>
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

