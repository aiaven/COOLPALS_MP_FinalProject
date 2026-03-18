<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Tutors.aspx.cs" Inherits="COOLPALS_MP_FinalProject.Tutor" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>PairEd - Find a Tutor</title>
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
        .nav-logout a {
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
        .nav-logout a:hover { color: #fff; border-color: rgba(255,255,255,0.4); }

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
        .card-top {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 24px;
            flex-wrap: wrap;
            gap: 16px;
        }
        .card-title {
            font-family: 'Sora', sans-serif;
            font-weight: 700;
            font-size: 1.15rem;
            color: #0D1B3E;
            letter-spacing: -0.3px;
        }
        .card-accent {
            width: 36px; height: 3px;
            background: #CC0000;
            border-radius: 2px;
            margin-bottom: 14px;
        }

        /* ── SEARCH ROW ── */
        .search-row { display: flex; align-items: center; gap: 10px; }
        .search-label {
            font-family: 'Sora', sans-serif;
            font-size: 0.78rem;
            font-weight: 700;
            color: #6B6B6B;
            text-transform: uppercase;
            letter-spacing: 0.10em;
            white-space: nowrap;
        }
        .search-row input[type="text"] {
            font-family: 'DM Sans', sans-serif;
            font-size: 0.95rem;
            color: #0D1B3E;
            background: #fff;
            border: 1px solid #D8D6D0;
            border-radius: 10px;
            padding: 10px 14px;
            width: 240px;
            outline: none;
            transition: border-color 0.2s;
        }
        .search-row input[type="text"]:focus { border-color: #CC0000; }
        .btn-search {
            font-family: 'Sora', sans-serif;
            font-size: 0.85rem;
            font-weight: 700;
            color: #fff;
            background: #CC0000;
            border: none;
            border-radius: 10px;
            padding: 10px 22px;
            cursor: pointer;
            box-shadow: 0 4px 14px rgba(204,0,0,0.28);
            transition: background 0.2s;
        }
        .btn-search:hover { background: #A80000; }

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
        .grid-wrapper input[type="submit"] {
            font-family: 'Sora', sans-serif;
            font-size: 0.78rem;
            font-weight: 700;
            color: #fff;
            background: #CC0000;
            border: none;
            border-radius: 7px;
            padding: 7px 16px;
            cursor: pointer;
            box-shadow: 0 2px 8px rgba(204,0,0,0.22);
            transition: background 0.2s;
        }
        .grid-wrapper input[type="submit"]:hover { background: #A80000; }

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
            transition: background 0.2s;
        }
        .btn-back:hover { background: rgba(255,255,255,0.18); }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <nav class="nav">
            <div class="nav-brand">
                <img src="../Images/PairEdLogo.png" alt="PairEd Logo" class="nav-logo" />
                <span class="nav-site-name">Pair<span>Ed</span></span>
                <span class="nav-tag">Peer Tutoring</span>
            </div>
            <div class="nav-logout">
                <asp:HyperLink ID="lnkLogout" runat="server" NavigateUrl="~/Pages/Logout.aspx" Text="Logout" />
            </div>
        </nav>
        <div class="page-body">
            <div class="page-header">
                <div class="badge"><span class="badge-dot"></span> Tutor Directory</div>
                <h2>Find a <em>Tutor</em></h2>
                <p>Browse peer tutors by skill or search for the subject you need help with.</p>
            </div>
            <div class="card">
                <div class="card-accent"></div>
                <div class="card-top">
                    <span class="card-title">Available Tutors</span>
                    <div class="search-row">
                        <span class="search-label">
                            <asp:Label ID="lblSearch" runat="server" Text="Search by Skill:" />
                        </span>
                        <asp:TextBox ID="txtSearch" runat="server" placeholder="e.g. Mathematics, Python…" />
                        <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="SearchTutors" CssClass="btn-search" />
                    </div>
                </div>
                <div class="grid-wrapper">
                    <asp:GridView ID="gvTutors" runat="server" AutoGenerateColumns="False"
                        DataKeyNames="UserID,SkillID"
                        OnRowCommand="gvTutors_RowCommand"
                        GridLines="None">
                        <EmptyDataTemplate>
                            <div style="text-align:center; padding:48px 20px; color:#C0BEB9; font-style:italic;">
                                No tutors found. Try a different skill.
                            </div>
                        </EmptyDataTemplate>
                        <Columns>
                            <asp:BoundField DataField="FirstName"        HeaderText="First Name" />
                            <asp:BoundField DataField="LastName"         HeaderText="Last Name" />
                            <asp:BoundField DataField="Program"          HeaderText="Program" />
                            <asp:BoundField DataField="YearLevel"        HeaderText="Year Level" />
                            <asp:BoundField DataField="SkillName"        HeaderText="Skill" />
                            <asp:BoundField DataField="CategoryName"     HeaderText="Category" />
                            <asp:BoundField DataField="ProficiencyLevel" HeaderText="Proficiency" />
                            <asp:BoundField DataField="YearsExperience"  HeaderText="Yrs Exp." />
                            <asp:ButtonField Text="Request" CommandName="RequestTutor" ButtonType="Button" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
            <div class="footer-actions">
                <asp:Button ID="btnBack" runat="server" Text="← Back" PostBackUrl="~/Pages/Default.aspx" CssClass="btn-back" />
            </div>
        </div>
    </form>
</body>
</html>