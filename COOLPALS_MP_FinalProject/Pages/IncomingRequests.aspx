<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="IncomingRequests.aspx.cs" Inherits="COOLPALS_MP_FinalProject.Pages.IncomingRequests" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>PairEd - Incoming Requests</title>
    <link href="https://fonts.googleapis.com/css2?family=Sora:wght@400;500;600;700;800&family=DM+Sans:wght@400;500;600&display=swap" rel="stylesheet" />
    <style>
        /* ── RESET ── */
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        html, body { height: 100%; }

        /* ── BASE ── */
        body {
            font-family: 'DM Sans', sans-serif;
            background: #0D1B3E;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        /* ── NAV ── */
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

        /* ── PAGE BODY ── */
        .page-body { flex: 1; padding: 52px 72px; overflow-y: auto; }

        /* ── PAGE HEADER ── */
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

        /* ── MESSAGE LABEL ── */
        .msg-label {
            display: block;
            font-family: 'Sora', sans-serif;
            font-size: 0.82rem;
            font-weight: 600;
            color: #22c55e;
            background: rgba(34,197,94,0.08);
            border: 1px solid rgba(34,197,94,0.25);
            border-radius: 8px;
            padding: 10px 14px;
            margin-bottom: 24px;
        }

        /* ── GRID ── */
        .grid-wrapper {
            background: rgba(255,255,255,0.04);
            border: 1px solid rgba(255,255,255,0.09);
            border-radius: 16px;
            overflow: hidden;
            margin-bottom: 32px;
        }
        .grid-wrapper table { width: 100%; border-collapse: collapse; font-size: 0.93rem; }
        .grid-wrapper th {
            font-family: 'Sora', sans-serif;
            font-size: 0.72rem;
            font-weight: 700;
            color: rgba(255,255,255,0.40);
            text-transform: uppercase;
            letter-spacing: 0.12em;
            padding: 16px 20px;
            background: rgba(255,255,255,0.03);
            border-bottom: 1px solid rgba(255,255,255,0.08);
            text-align: left;
            white-space: nowrap;
        }
        .grid-wrapper td {
            padding: 14px 20px;
            color: rgba(255,255,255,0.80);
            border-bottom: 1px solid rgba(255,255,255,0.06);
            vertical-align: middle;
        }
        .grid-wrapper tr:last-child td { border-bottom: none; }
        .grid-wrapper tr:hover td { background: rgba(255,255,255,0.04); }

        /* ── ACTION BUTTONS IN GRID ── */
        .grid-wrapper input[type="submit"] {
            font-family: 'Sora', sans-serif;
            font-size: 0.78rem;
            font-weight: 700;
            border: none;
            border-radius: 7px;
            padding: 7px 16px;
            cursor: pointer;
            transition: background 0.2s;
            margin-right: 4px;
        }

        /* Accept — green */
        .grid-wrapper td:nth-child(8) input[type="submit"] {
            background: rgba(34,197,94,0.15);
            color: #22c55e;
            border: 1px solid rgba(34,197,94,0.30);
        }
        .grid-wrapper td:nth-child(8) input[type="submit"]:hover {
            background: rgba(34,197,94,0.28);
        }

        /* Decline — red */
        .grid-wrapper td:nth-child(9) input[type="submit"] {
            background: rgba(204,0,0,0.15);
            color: #FF8080;
            border: 1px solid rgba(204,0,0,0.30);
        }
        .grid-wrapper td:nth-child(9) input[type="submit"]:hover {
            background: rgba(204,0,0,0.28);
        }

        /* Complete — blue */
        .grid-wrapper td:nth-child(10) input[type="submit"] {
            background: rgba(59,130,246,0.15);
            color: #93c5fd;
            border: 1px solid rgba(59,130,246,0.30);
        }
        .grid-wrapper td:nth-child(10) input[type="submit"]:hover {
            background: rgba(59,130,246,0.28);
        }

        /* ── FOOTER ACTIONS ── */
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

        <%-- NAV --%>
        <nav class="nav">
            <div class="nav-brand">
                <span class="nav-site-name">Pair<span>Ed</span></span>
                <span class="nav-tag">Peer Tutoring</span>
            </div>
            <div class="nav-right">
                <asp:HyperLink ID="lnkBackHome" runat="server" NavigateUrl="~/Pages/Default.aspx" Text="← Back to Home" />
            </div>
        </nav>

        <%-- PAGE BODY --%>
        <div class="page-body">

            <%-- HEADER --%>
            <div class="page-header">
                <div class="badge"><span class="badge-dot"></span> Tutor Dashboard</div>
                <h2>Incoming <em>Requests</em></h2>
                <p>Review and manage session requests from learners.</p>
            </div>

            <%-- MESSAGE --%>
            <asp:Label ID="lblMessage" runat="server" CssClass="msg-label" />

            <%-- GRID --%>
            <div class="grid-wrapper">
                <h2>Current Requests</h2>
                <asp:GridView ID="gvIncomingRequests" runat="server" AutoGenerateColumns="False"
                    DataKeyNames="RequestID,Status"
                    OnRowCommand="gvIncomingRequests_RowCommand">
                    <EmptyDataTemplate>
                        <div style="text-align:center; padding:48px 20px; color:rgba(255,255,255,0.28); font-style:italic;">
                            No incoming requests at the moment.
                        </div>
                    </EmptyDataTemplate>
                    <Columns>
                        <asp:BoundField DataField="RequestID" HeaderText="ID" />
                        <asp:BoundField DataField="LearnerName" HeaderText="Learner" />
                        <asp:BoundField DataField="SkillName" HeaderText="Skill" />
                        <asp:BoundField DataField="Message" HeaderText="Message" />
                        <asp:BoundField DataField="Availability" HeaderText="Availability" />
                        <asp:BoundField DataField="Status" HeaderText="Status" />
                        <asp:BoundField DataField="RequestDate" HeaderText="Requested On" DataFormatString="{0:yyyy-MM-dd HH:mm}" />

                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>

                                <!-- Accept -->
                                <asp:Button ID="btnAccept" runat="server" Text="Accept"
                                    CommandName="AcceptRequest"
                                    CommandArgument='<%# Container.DataItemIndex %>'
                                    Visible='<%# Eval("Status").ToString() == "Pending" %>' />

                                <!-- Decline -->
                                <asp:Button ID="btnDecline" runat="server" Text="Decline"
                                    CommandName="DeclineRequest"
                                    CommandArgument='<%# Container.DataItemIndex %>'
                                    Visible='<%# Eval("Status").ToString() == "Pending" %>' />

                                <!-- Complete -->
                                <asp:Button ID="btnComplete" runat="server" Text="Complete"
                                    CommandName="CompleteRequest"
                                    CommandArgument='<%# Container.DataItemIndex %>'
                                    Visible='<%# Eval("Status").ToString() == "Accepted" %>' />

                                <!-- Cancel -->
                                <asp:Button ID="btnCancel" runat="server" Text="Cancel"
                                    CommandName="CancelRequest"
                                    CommandArgument='<%# Container.DataItemIndex %>'
                                    Visible='<%# Eval("Status").ToString() == "Accepted" %>' />

                            </ItemTemplate>
                        </asp:TemplateField>

                </Columns>
            </asp:GridView>

                <h2>Request History</h2>
                <asp:GridView ID="gvRequestHistory" runat="server"
                    AutoGenerateColumns="False"
                    DataKeyNames="RequestID">
                    <Columns>
                        <asp:BoundField DataField="LearnerName" HeaderText="Learner" />
                        <asp:BoundField DataField="SkillName" HeaderText="Skill" />
                        <asp:BoundField DataField="Message" HeaderText="Message" />
                        <asp:BoundField DataField="Availability" HeaderText="Availability" />
                        <asp:BoundField DataField="Status" HeaderText="Status" />
                        <asp:BoundField DataField="RequestDate" HeaderText="Request Date" DataFormatString="{0:yyyy-MM-dd HH:mm}" />
                    </Columns>
                </asp:GridView>

            </div>

            <%-- FOOTER --%>
            <div class="footer-actions">
                <asp:HyperLink ID="lnkBackHomeFooter" runat="server" NavigateUrl="~/Pages/Default.aspx" Text="← Back to Home" CssClass="btn-back" />
            </div>

        </div>
    </form>
</body>
</html>
