<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="IncomingRequests.aspx.cs" Inherits="COOLPALS_MP_FinalProject.Pages.IncomingRequests" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>PairEd - Incoming Requests</title>
    <link href="https://fonts.googleapis.com/css2?family=Sora:wght@400;500;600;700;800&family=DM+Sans:wght@400;500;600&display=swap" rel="stylesheet" />
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        html, body { height: 100%; }

        body {
            font-family: 'DM Sans', sans-serif;
            background: #0D1B3E;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        /* NAV */
        .nav {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 72px;
            height: 78px;
            background: #0D1B3E;
            border-bottom: 1px solid rgba(255,255,255,0.07);
            flex-shrink: 0;
        }
        .nav-brand { display: flex; align-items: center; gap: 16px; }
        .nav-logo { height: 52px; width: auto; }
        .nav-site-name {
            font-family: 'Sora', sans-serif;
            font-weight: 700;
            font-size: 1.55rem;
            color: #fff;
            letter-spacing: -0.3px;
        }
        .nav-site-name span { color: #CC0000; }
        .nav-tag {
            font-family: 'Sora', sans-serif;
            font-size: 0.82rem;
            color: rgba(255,255,255,0.32);
            letter-spacing: 0.12em;
            text-transform: uppercase;
            font-weight: 500;
        }
        .nav-right a {
            font-family: 'Sora', sans-serif;
            font-size: 0.88rem;
            font-weight: 600;
            color: rgba(255,255,255,0.55);
            text-decoration: none;
            border: 1px solid rgba(255,255,255,0.15);
            padding: 8px 20px;
            border-radius: 8px;
            transition: all 0.2s;
        }
        .nav-right a:hover { color: #fff; border-color: rgba(255,255,255,0.4); }

        /* PAGE BODY */
        .page-body { flex: 1; padding: 52px 72px; overflow-y: auto; }

        /* PAGE HEADER */
        .page-header { margin-bottom: 36px; }
        .badge {
            display: inline-flex;
            align-items: center;
            gap: 9px;
            background: rgba(204,0,0,0.18);
            border: 1px solid rgba(204,0,0,0.40);
            color: #FF8080;
            font-family: 'Sora', sans-serif;
            font-size: 0.78rem;
            font-weight: 700;
            letter-spacing: 0.14em;
            text-transform: uppercase;
            padding: 7px 18px;
            border-radius: 99px;
            margin-bottom: 18px;
        }
        .badge-dot { width: 8px; height: 8px; border-radius: 50%; background: #CC0000; }
        .page-header h2 {
            font-family: 'Sora', sans-serif;
            font-weight: 800;
            font-size: 2.6rem;
            color: #fff;
            letter-spacing: -1.5px;
            line-height: 1.1;
            margin-bottom: 10px;
        }
        .page-header h2 em { color: #CC0000; font-style: normal; }
        .page-header p {
            font-size: 1rem;
            color: rgba(255,255,255,0.55);
            line-height: 1.7;
        }

        /* MESSAGE LABEL */
        .msg-label {
            display: block;
            font-family: 'Sora', sans-serif;
            font-size: 0.82rem;
            font-weight: 600;
            color: #1a7a3c;
            background: rgba(26,122,60,0.08);
            border: 1px solid rgba(26,122,60,0.22);
            border-radius: 10px;
            padding: 12px 18px;
            margin-bottom: 24px;
            line-height: 1.55;
        }

        /* SECTION CARDS */
        .section-card {
            background: #F5F4F0;
            border-radius: 18px;
            border: 1px solid #E0DED8;
            padding: 32px 36px;
            margin-bottom: 28px;
        }
        .card-accent {
            width: 44px; height: 4px;
            background: #CC0000;
            border-radius: 2px;
            margin-bottom: 14px;
        }
        .card-title {
            font-family: 'Sora', sans-serif;
            font-weight: 700;
            font-size: 1.15rem;
            color: #0D1B3E;
            letter-spacing: -0.3px;
            margin-bottom: 20px;
        }

        /* GRID TABLE */
        .grid-wrap {
            background: #fff;
            border: 1px solid #E0DED8;
            border-radius: 12px;
            overflow: hidden;
        }
        .grid-wrap table { width: 100%; border-collapse: collapse; font-size: 0.90rem; }
        .grid-wrap th {
            font-family: 'Sora', sans-serif;
            font-size: 0.68rem;
            font-weight: 700;
            color: #AEAAA3;
            text-transform: uppercase;
            letter-spacing: 0.12em;
            padding: 14px 18px;
            background: #F9F8F6;
            border-bottom: 1px solid #E0DED8;
            text-align: left;
            white-space: nowrap;
        }
        .grid-wrap td {
            padding: 13px 18px;
            color: #0D1B3E;
            border-bottom: 1px solid #F0EDE8;
            vertical-align: middle;
        }
        .grid-wrap tr:last-child td { border-bottom: none; }
        .grid-wrap tr:hover td { background: #FAF9F7; }

        /* EMPTY DATA */
        .empty-msg {
            text-align: center;
            padding: 40px 20px;
            color: #C0BEB9;
            font-style: italic;
            font-size: 0.92rem;
        }

        /* ACTION BUTTONS IN GRID */
        .grid-wrap input[type="submit"] {
            font-family: 'Sora', sans-serif;
            font-size: 0.78rem;
            font-weight: 700;
            border-radius: 7px;
            padding: 7px 14px;
            cursor: pointer;
            transition: background 0.2s;
            margin-right: 4px;
        }
        /* Accept — green */
        .btn-accept {
            background: rgba(26,122,60,0.10);
            color: #1a7a3c;
            border: 1px solid rgba(26,122,60,0.28) !important;
        }
        .btn-accept:hover { background: rgba(26,122,60,0.20) !important; }

        /* Decline — red */
        .btn-decline {
            background: rgba(204,0,0,0.10);
            color: #CC0000;
            border: 1px solid rgba(204,0,0,0.28) !important;
        }
        .btn-decline:hover { background: rgba(204,0,0,0.20) !important; }

        /* Complete — blue */
        .btn-complete {
            background: rgba(13,27,62,0.08);
            color: #0D1B3E;
            border: 1px solid rgba(13,27,62,0.20) !important;
        }
        .btn-complete:hover { background: rgba(13,27,62,0.16) !important; }

        /* Cancel — grey */
        .btn-cancel {
            background: rgba(174,170,163,0.15);
            color: #8A8A8A;
            border: 1px solid rgba(174,170,163,0.30) !important;
        }
        .btn-cancel:hover { background: rgba(174,170,163,0.28) !important; }

        /* FOOTER */
        .footer-actions { display: flex; align-items: center; gap: 14px; }
        .btn-back {
            font-family: 'Sora', sans-serif;
            font-size: 0.90rem;
            font-weight: 700;
            color: #fff;
            background: rgba(255,255,255,0.10);
            border: 1px solid rgba(255,255,255,0.18);
            border-radius: 10px;
            padding: 12px 28px;
            cursor: pointer;
            text-decoration: none;
            transition: background 0.2s;
        }
        .btn-back:hover { background: rgba(255,255,255,0.18); }
    </style>
</head>
<body>
    <form id="form1" runat="server">

        <!-- NAV -->
        <nav class="nav">
            <div class="nav-brand">
                <img src='../Images/PairEdLogo.png' alt="PairEd Logo" class="nav-logo" />
                <span class="nav-site-name">Pair<span>Ed</span></span>
            </div>
            <div class="nav-right">
                <asp:HyperLink ID="lnkBackHome" runat="server" NavigateUrl="~/Pages/Default.aspx" Text="← Back to Home" />
            </div>
        </nav>

        <!-- PAGE BODY -->
        <div class="page-body">

            <!-- HEADER -->
            <div class="page-header">
                <div class="badge"><span class="badge-dot"></span> Tutor Dashboard</div>
                <h2>Incoming <em>Requests</em></h2>
                <p>Review and manage session requests from learners.</p>
            </div>

            <!-- MESSAGE -->
            <asp:Label ID="lblMessage" runat="server" CssClass="msg-label" Visible="false" />

            <!-- CURRENT REQUESTS -->
            <div class="section-card">
                <div class="card-accent"></div>
                <div class="card-title">Current Requests</div>
                <div class="grid-wrap">
                    <asp:GridView ID="gvIncomingRequests" runat="server"
                        AutoGenerateColumns="False"
                        DataKeyNames="RequestID,Status"
                        OnRowCommand="gvIncomingRequests_RowCommand"
                        GridLines="None">
                        <EmptyDataTemplate>
                            <div class="empty-msg">No incoming requests at the moment.</div>
                        </EmptyDataTemplate>
                        <Columns>
                            <asp:BoundField DataField="RequestID"   HeaderText="ID" />
                            <asp:BoundField DataField="LearnerName" HeaderText="Learner" />
                            <asp:BoundField DataField="SkillName"   HeaderText="Skill" />
                            <asp:BoundField DataField="Message"     HeaderText="Message" />
                            <asp:BoundField DataField="Availability" HeaderText="Availability" />
                            <asp:BoundField DataField="Status"      HeaderText="Status" />
                            <asp:BoundField DataField="RequestDate" HeaderText="Requested On" DataFormatString="{0:yyyy-MM-dd HH:mm}" />
                            <asp:TemplateField HeaderText="Actions">
                                <ItemTemplate>
                                    <asp:Button ID="btnAccept" runat="server" Text="Accept"
                                        CssClass="btn-accept"
                                        CommandName="AcceptRequest"
                                        CommandArgument='<%# Container.DataItemIndex %>'
                                        Visible='<%# Eval("Status").ToString() == "Pending" %>' />
                                    <asp:Button ID="btnDecline" runat="server" Text="Decline"
                                        CssClass="btn-decline"
                                        CommandName="DeclineRequest"
                                        CommandArgument='<%# Container.DataItemIndex %>'
                                        Visible='<%# Eval("Status").ToString() == "Pending" %>' />
                                    <asp:Button ID="btnComplete" runat="server" Text="Complete"
                                        CssClass="btn-complete"
                                        CommandName="CompleteRequest"
                                        CommandArgument='<%# Container.DataItemIndex %>'
                                        Visible='<%# Eval("Status").ToString() == "Accepted" %>' />
                                    <asp:Button ID="btnCancel" runat="server" Text="Cancel"
                                        CssClass="btn-cancel"
                                        CommandName="CancelRequest"
                                        CommandArgument='<%# Container.DataItemIndex %>'
                                        Visible='<%# Eval("Status").ToString() == "Accepted" %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>

            <!-- REQUEST HISTORY -->
            <div class="section-card">
                <div class="card-accent"></div>
                <div class="card-title">Request History</div>
                <div class="grid-wrap">
                    <asp:GridView ID="gvRequestHistory" runat="server"
                        AutoGenerateColumns="False"
                        DataKeyNames="RequestID"
                        GridLines="None">
                        <EmptyDataTemplate>
                            <div class="empty-msg">No request history found.</div>
                        </EmptyDataTemplate>
                        <Columns>
                            <asp:BoundField DataField="LearnerName"  HeaderText="Learner" />
                            <asp:BoundField DataField="SkillName"    HeaderText="Skill" />
                            <asp:BoundField DataField="Message"      HeaderText="Message" />
                            <asp:BoundField DataField="Availability" HeaderText="Availability" />
                            <asp:BoundField DataField="Status"       HeaderText="Status" />
                            <asp:BoundField DataField="RequestDate"  HeaderText="Request Date" DataFormatString="{0:yyyy-MM-dd HH:mm}" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>

            <!-- FOOTER -->
            <div class="footer-actions">
                <asp:HyperLink ID="lnkBackHomeFooter" runat="server"
                    NavigateUrl="~/Pages/Default.aspx"
                    Text="← Back to Home"
                    CssClass="btn-back" />
            </div>

        </div>
    </form>
</body>
</html>