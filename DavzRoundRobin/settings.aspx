<%@ Page Title="Settings" Language="C#" MasterPageFile="main.master" %>

<script runat="server">
    private DavzSettings _DavzSettings;

    protected void Page_Load(object sender, EventArgs e)
    {
        _DavzSettings = DavzSettings.Read();
    }

    protected void Page_PrerenderComplete(object sender, EventArgs e)
    {
        _DavzSettings = DavzSettings.Read();
        pnlView.DataBind();
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        _DavzSettings = DavzSettings.Read();

        _DavzSettings.RaceLength = txtRaceLength.Text;
        _DavzSettings.PrinterName = txtPrinterName.Text;
        _DavzSettings.ShowTimer = tsShowTimer.Checked;
        _DavzSettings.TimerSeconds = int.Parse(txtTimerSeconds.Text);

        _DavzSettings.Update();
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <br />
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item active" aria-current="page">Settings</li>
        </ol>
    </nav>

    <asp:PlaceHolder runat="server" ID="pnlView">
        <div class="row">
            <div class="col col-md-8">
                <div class="card">
                    <div class="card-header">
                        <b>Settings</b>
                        <asp:Button runat="server" ID="btnUpdate" Text="Update" CssClass="btn btn-primary text-white me-0 float-end" OnClick="btnUpdate_Click" />
                    </div>
                    <div class="card-body">
                        <div class="col-md-6">
                            <div class="form-floating">
                                <asp:TextBox runat="server" ID="txtRaceLength" CssClass="form-control" Text='<%# _DavzSettings.RaceLength %>' />
                                <label class="form-label"><b>Race Length</b></label>
                            </div>
                        </div>
                        <br />
                        <div class="col-md-6">
                            <div class="form-floating">
                                <asp:TextBox runat="server" ID="txtPrinterName" CssClass="form-control" Text='<%# _DavzSettings.PrinterName %>' />
                                <label class="form-label"><b>Printer Name</b></label>
                            </div>
                        </div>
                        <br />
                        <div class="col-md-6">
                            <div class="form-floating">
                                <asp:TextBox runat="server" ID="txtTimerSeconds" CssClass="form-control" Text='<%# _DavzSettings.TimerSeconds %>' />
                                <label class="form-label"><b>End Timer Seconds</b></label>
                            </div>
                        </div>
                        <br />
                        <div class="col-md-6">
                            <div class="form-check form-switch">
                                <asp:CheckBox CssClass="" ID="tsShowTimer" runat="server" Checked='<%# _DavzSettings.ShowTimer %>' />
                                <label class="form-check-label" for="tsShowTimer">Show Timer</label>
                            </div>
                        </div>
                    </div>
                </div>
                <br />
            </div>
        </div>
    </asp:PlaceHolder>

</asp:Content>

