<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SessionHistory.aspx.cs" Inherits="COOLPALS_MP_FinalProject.SessionHistory" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>PairEd - Session History</title>
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

        /* ── WHITE CARD ── */
        .card {
            background: #F5F4F0;
            border-radius: 18px;
            border: 1px solid #E0DED8;
            padding: 36px 40px;
            margin-bottom: 24px;
        }
        .card-accent {
            width: 36px; height: 3px;
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
            margin-bottom: 24px;
        }

        /* ── GRID ── */
        .grid-wrapper {
            background: #fff;
            border: 1px solid #E0DED8;
            border-radius: 12px;
            overflow: hidden;
        }
        .grid-wrapper table { width: 100%; border-collapse: collapse; font-size: 0.90rem; }
        .grid-wrapper th {
            font-family: 'Sora', sans-serif;
            font-size: 0.68rem;
            font-weight: 700;
            color: #9A9A9A;
            text-transform: uppercase;
            letter-spacing: 0.12em;
            padding: 14px 18px;
            background: #F9F8F6;
            border-bottom: 1px solid #E0DED8;
            text-align: left;
            white-space: nowrap;
        }
        .grid-wrapper td {
            padding: 13px 18px;
            color: #2C2C2C;
            border-bottom: 1px solid #F0EFEB;
            vertical-align: middle;
        }
        .grid-wrapper tr:last-child td { border-bottom: none; }
        .grid-wrapper tr:hover td { background: #F9F8F6; }

        /* ── FOOTER ── */
        .footer-actions { display: flex; align-items: center; gap: 12px; }
        .btn-back {
            font-family: 'Sora', sans-serif;
            font-size: 0.88rem;
            font-weight: 700;
            color: #fff;
            background: rgba(255,255,255,0.10);
            border: 1px solid rgba(255,255,255,0.18);
            border-radius: 10px;
            padding: 11px 26px;
            cursor: pointer;
            text-decoration: none;
            transition: background 0.2s;
        }
        .btn-back:hover { background: rgba(255,255,255,0.18); }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <nav class="nav">
            <div class="nav-brand">
                <img src='../Images/PairEdLogo.png' alt="PairEd Logo" class="nav-logo" />
                <span class="nav-site-name">Pair<span>Ed</span></span>
            </div>
            <div class="nav-right">
                <asp:HyperLink ID="lnkBackHome" runat="server" NavigateUrl="~/Pages/Default.aspx" Text="← Back to Home" />
            </div>
        </nav>
        <div class="page-body">
            <div class="page-header">
                <div class="badge"><span class="badge-dot"></span> My Activity</div>
                <h2>Session <em>History</em></h2>
                <p>A full log of your tutoring requests and their current status.</p>
            </div>
            <div class="card">
                <div class="card-accent"></div>
                <div class="card-title">My Requests</div>
                <div class="grid-wrapper">
                    <asp:GridView ID="gvHistory" runat="server" AutoGenerateColumns="False" GridLines="None"
                        DataKeyNames="RequestID"
                        OnRowCommand="gvHistory_RowCommand">
                        <EmptyDataTemplate>
                            <div style="text-align:center; padding:48px 20px; color:#C0BEB9; font-style:italic;">
                                No session history found.
                            </div>
                        </EmptyDataTemplate>
                        <Columns>
                            <asp:BoundField DataField="TutorName"     HeaderText="Tutor" />
                            <asp:BoundField DataField="SkillName"     HeaderText="Skill" />
                            <asp:BoundField DataField="Message"       HeaderText="Message" />
                            <asp:BoundField DataField="Availability"  HeaderText="Availability" />
                            <asp:BoundField DataField="Status"        HeaderText="Status" />
                            <asp:BoundField DataField="RequestDate"   HeaderText="Requested On"  DataFormatString="{0:yyyy-MM-dd HH:mm}" />
                            <asp:BoundField DataField="ResponseDate"  HeaderText="Responded On"  DataFormatString="{0:yyyy-MM-dd HH:mm}" />
                            <asp:BoundField DataField="CompletedDate" HeaderText="Completed On"  DataFormatString="{0:yyyy-MM-dd HH:mm}" />
                            <asp:BoundField DataField="CancelledDate" HeaderText="Cancelled On"  DataFormatString="{0:yyyy-MM-dd HH:mm}" />
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <asp:Button 
                                    ID="btnCancel" 
                                    runat="server" 
                                    Text="Cancel"
                                    CommandName="CancelRequest"
                                    CommandArgument='<%# Container.DataItemIndex %>'
                                    Visible='<%# Eval("Status").ToString() == "Pending" || Eval("Status").ToString() == "Accepted" %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
            <div class="footer-actions">
                <asp:HyperLink ID="lnkBackHomeFooter" runat="server" NavigateUrl="~/Pages/Default.aspx" Text="← Back to Home" CssClass="btn-back" />
            </div>
        </div>
    </form>
</body>
</html>
