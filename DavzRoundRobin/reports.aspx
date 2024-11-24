<%@ Page Title="Reports" Language="C#" MasterPageFile="main.master" %>

<script runat="server">


</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <br />
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href='<%=CommonLinks.DashBoard %>'>Home</a></li>
            <li class="breadcrumb-item active" aria-current="page">Reports</li>
        </ol>
    </nav>
    <div class="row">
        <div class="col col-md-12">
            <div class="card">
                <div class="card-header">
                    <b>Reports</b>
                </div>
                <div class="card-body">
                    <div class="col col-md-12">
                        <a href='<%= CommonLinks.MatchLogs %>'>
                            <i class="bx bxs-report icon"></i>
                            <span class="text nav-text">Match Logs</span>
                        </a>
                    </div>
                    <div class="col col-md-12">
                        <a href='<%= CommonLinks.BestTimeByCategory %>'>
                            <i class="bx bxs-report icon"></i>
                            <span class="text nav-text">Best Time By Category</span>
                        </a>
                    </div>
                </div>
            </div>
        </div>

    </div>

</asp:Content>

