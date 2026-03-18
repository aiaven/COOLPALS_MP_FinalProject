<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="COOLPALS_MP_FinalProject.Default" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <title>PairEd - Dashboard</title>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="https://fonts.googleapis.com/css2?family=Sora:wght@300;400;600;700;800&family=DM+Sans:wght@300;400;500;600&display=swap" rel="stylesheet" />
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        html, body {
            height: 100%;
            font-family: 'DM Sans', sans-serif;
            background: #0D1B3E;
            overflow: hidden;
        }

        /* NAV */
        .nav {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 56px;
            height: 72px;
            background: #0D1B3E;
            border-bottom: 1px solid rgba(255,255,255,0.07);
            flex-shrink: 0;
            position: relative;
            z-index: 10;
        }
        .nav-brand { display: flex; align-items: center; gap: 14px; }
        .nav-logo  { height: 46px; width: auto; }
        .nav-site-name {
            font-family: 'Sora', sans-serif;
            font-weight: 800;
            font-size: 1.45rem;
            color: #fff;
            letter-spacing: -0.5px;
        }
        .nav-site-name span { color: #C0392B; }
        .nav-right {
            font-family: 'Sora', sans-serif;
            font-size: 0.72rem;
            color: rgba(255,255,255,0.28);
            letter-spacing: 0.14em;
            text-transform: uppercase;
        }

        /* SHELL */
        .shell {
            display: grid;
            grid-template-columns: 300px 1fr;
            height: calc(100vh - 72px);
            overflow: hidden;
        }

        /* SIDEBAR */
        .sidebar {
            background: #0D1B3E;
            border-right: 1px solid rgba(255,255,255,0.08);
            display: flex;
            flex-direction: column;
            height: 100%;
            overflow: hidden;
            padding: 36px 0 28px;
            position: relative;
        }
        .sidebar::before {
            content: '';
            position: absolute;
            inset: 0;
            background: repeating-linear-gradient(
                135deg, transparent, transparent 44px,
                rgba(255,255,255,0.012) 44px, rgba(255,255,255,0.012) 45px
            );
            pointer-events: none;
        }
        .sidebar-avatar-block {
            padding: 0 28px 24px;
            border-bottom: 1px solid rgba(255,255,255,0.07);
            margin-bottom: 20px;
        }
        .sidebar-avatar {
            width: 56px; height: 56px;
            border-radius: 50%;
            background: linear-gradient(135deg, #C0392B, #7B241C);
            display: flex; align-items: center; justify-content: center;
            font-family: 'Sora', sans-serif;
            font-weight: 800;
            font-size: 1.2rem;
            color: #fff;
            margin-bottom: 12px;
        }
        .sidebar-username {
            font-family: 'Sora', sans-serif;
            font-weight: 700;
            font-size: 1rem;
            color: #fff;
            margin-bottom: 3px;
        }
        .sidebar-role { font-size: 0.78rem; color: rgba(255,255,255,0.32); }

        .sidebar-nav-label {
            font-family: 'Sora', sans-serif;
            font-size: 0.60rem;
            font-weight: 700;
            color: rgba(255,255,255,0.22);
            text-transform: uppercase;
            letter-spacing: 0.16em;
            padding: 0 28px;
            margin-bottom: 8px;
        }

        input[type="submit"] {
            font-family: 'Sora', sans-serif !important;
            cursor: pointer; border: none; display: block; font-weight: 700;
        }
        .aspx-navlink {
            background: transparent !important;
            color: rgba(255,255,255,0.50) !important;
            font-size: 1rem !important;
            font-weight: 700 !important;
            padding: 14px 28px !important;
            text-align: left !important;
            width: 100% !important;
            border-left: 3px solid transparent !important;
            border-radius: 0 !important;
            margin: 0 !important;
            box-shadow: none !important;
            letter-spacing: 0.01em !important;
            transition: color 0.18s, background 0.18s, border-color 0.18s, padding-left 0.18s !important;
            position: relative; z-index: 1;
        }
        .aspx-navlink:hover {
            background: rgba(255,255,255,0.07) !important;
            color: #fff !important;
            border-left-color: #C0392B !important;
            padding-left: 36px !important;
        }

        /* MAIN */
        .main {
            background: #F0EFEB;
            display: flex;
            flex-direction: column;
            height: 100%;
            overflow: hidden;
        }

        /* HERO */
        .hero {
            padding: 36px 60px 28px;
            border-bottom: 1px solid #E2E0DA;
            flex-shrink: 0;
        }
        .hero-eyebrow {
            font-family: 'Sora', sans-serif;
            font-size: 0.68rem;
            font-weight: 700;
            color: #C0392B;
            letter-spacing: 0.18em;
            text-transform: uppercase;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .hero-eyebrow::before {
            content: '';
            display: inline-block;
            width: 28px; height: 3px;
            background: #C0392B;
            border-radius: 2px;
        }
        .hero-message {
            font-family: 'Sora', sans-serif;
            font-weight: 800;
            font-size: 2.2rem;
            color: #0D1B3E;
            letter-spacing: -1.5px;
            line-height: 1.1;
            display: block;
            margin-bottom: 10px;
        }
        .hero-sub {
            font-size: 0.92rem;
            color: #999;
            line-height: 1.6;
            max-width: 520px;
        }

        /* GUEST BTNS */
        .btn-row { display: flex; gap: 14px; margin-top: 22px; }
        .aspx-primary {
            background: #C0392B !important;
            color: #fff !important;
            font-size: 0.95rem !important;
            font-weight: 700 !important;
            padding: 14px 36px !important;
            border-radius: 12px !important;
            box-shadow: 0 4px 16px rgba(192,57,43,0.22) !important;
            flex: 1 !important; margin: 0 !important;
            transition: background 0.2s !important;
        }
        .aspx-primary:hover { background: #A93226 !important; }
        .aspx-secondary {
            background: #0D1B3E !important;
            color: #fff !important;
            font-size: 0.95rem !important;
            font-weight: 700 !important;
            padding: 14px 36px !important;
            border-radius: 12px !important;
            flex: 1 !important; margin: 0 !important;
            transition: background 0.2s !important;
        }
        .aspx-secondary:hover { background: #162348 !important; }

        /* CONTENT */
        .content {
            padding: 28px 60px 32px;
            flex: 1;
            overflow: hidden;
            display: flex;
            flex-direction: column;
        }
        .section-label {
            font-family: 'Sora', sans-serif;
            font-size: 0.66rem;
            font-weight: 700;
            color: #AEAAA3;
            text-transform: uppercase;
            letter-spacing: 0.14em;
            margin-bottom: 14px;
            display: block;
            flex-shrink: 0;
        }

        .returning-wrap {
            display: flex;
            flex-direction: column;
            flex: 1;
            overflow: hidden;
            min-height: 0;
        }

        /* 3-card layout: Profile full-width top, Tutors+Requests bottom row */
        .big-nav-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            grid-template-rows: 1fr 1fr;
            gap: 12px;
            flex: 1;
            width: 100%;
            min-height: 0;
        }
        .big-nav-card.span-full { grid-column: span 2; }

        .big-nav-card {
            background: #fff;
            border: 1.5px solid #E0DED8;
            border-radius: 16px;
            padding: 24px 28px;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 20px;
            transition: box-shadow 0.2s, border-color 0.2s, transform 0.15s;
            position: relative;
            overflow: hidden;
            width: 100%;
            height: 100%;
        }
        .big-nav-card::after {
            content: '';
            position: absolute;
            left: 0; top: 0; bottom: 0;
            width: 4px;
            background: transparent;
            border-radius: 16px 0 0 16px;
            transition: background 0.2s;
        }
        .big-nav-card:hover {
            box-shadow: 0 8px 28px rgba(13,27,62,0.10);
            border-color: #0D1B3E;
            transform: translateY(-2px);
        }
        .big-nav-card:hover::after { background: #C0392B; }

        /* softer accent card — muted navy-slate instead of harsh red */
        .big-nav-card.card-accent {
            background: #3A5BA0;  /* change this */
            border-color: #3A5BA0; /* and this to match */
        }
            .big-nav-card.card-accent:hover {
                background: #162550; /* change this too, make it slightly darker than your chosen color */
                border-color: #162550;
                transform: translateY(-2px);
            }
                .big-nav-card.card-accent::after { background: transparent; }

        .bnc-icon {
            width: 52px; height: 52px;
            border-radius: 13px;
            background: #F5F4F0;
            display: flex; align-items: center; justify-content: center;
            font-size: 1.5rem;
            flex-shrink: 0;
        }
        .big-nav-card.card-accent .bnc-icon { background: rgba(255,255,255,0.12); }

        .bnc-body { display: flex; flex-direction: column; gap: 4px; flex: 1; }
        .bnc-title {
            font-family: 'Sora', sans-serif;
            font-weight: 800;
            font-size: 1.08rem;
            color: #0D1B3E;
            letter-spacing: -0.3px;
        }
        .big-nav-card.card-accent .bnc-title { color: #fff; }
        .bnc-desc { font-size: 0.86rem; color: #999; line-height: 1.5; }
        .big-nav-card.card-accent .bnc-desc { color: rgba(255,255,255,0.65); }
        .bnc-arrow {
            margin-top: 8px;
            font-family: 'Sora', sans-serif;
            font-weight: 700;
            font-size: 0.80rem;
            color: #C0392B;
        }
        .big-nav-card.card-accent .bnc-arrow { color: rgba(255,255,255,0.75); }

        /* INFO STRIP */
        .info-strip {
            display: flex;
            gap: 0;
            margin-top: 16px;
            flex-shrink: 0;
        }
        .info-item { flex: 1; padding-top: 12px; border-top: 2px solid #E0DED8; transition: border-color 0.2s; }
        .info-item + .info-item { margin-left: 32px; }
        .info-item:hover { border-top-color: #C0392B; }
        .info-label {
            font-family: 'Sora', sans-serif;
            font-size: 0.58rem; font-weight: 700;
            color: #C0BEB9; text-transform: uppercase;
            letter-spacing: 0.12em; margin-bottom: 3px;
        }
        .info-val { font-family: 'Sora', sans-serif; font-size: 0.86rem; font-weight: 700; color: #0D1B3E; }
    </style>
</head>
<body>
<form id="form1" runat="server">

    <!-- NAV -->
    <div class="nav">
        <div class="nav-brand">
            <img src='<%= ResolveUrl("~/Images/PairEdLogo.png") %>' alt="PairEd" class="nav-logo" />
            <span class="nav-site-name">Pair<span>Ed</span></span>
        </div>
        <span class="nav-right">Student Skill-Sharing Platform</span>
    </div>

    <div class="shell">

        <!-- SIDEBAR -->
        <div class="sidebar">
            <div class="sidebar-avatar-block">
                <div class="sidebar-avatar">P</div>
                <div class="sidebar-username">PairEd Dashboard</div>
                <div class="sidebar-role">Student Skill-Sharing</div>
            </div>
            <div class="sidebar-nav-label">Navigation</div>
            <asp:Button ID="btnAddSkills" runat="server" Text="🎯  My Skills"
                CssClass="aspx-navlink" PostBackUrl="~/Pages/ManageSkills.aspx" Visible="false" />
            <asp:Button ID="btnProfile" runat="server" Text="👤  Profile"
                CssClass="aspx-navlink" PostBackUrl="~/Pages/Profile.aspx" Visible="false" />
            <asp:Button ID="btnTutors" runat="server" Text="🔍  Find Tutors"
                CssClass="aspx-navlink" PostBackUrl="~/Pages/Tutors.aspx" Visible="false" />
            <asp:Button ID="btnRequests" runat="server" Text="📋  Requests"
                CssClass="aspx-navlink" PostBackUrl="~/Pages/Requests.aspx" Visible="false" />
        </div>

        <!-- MAIN -->
        <div class="main">

            <div class="hero">
                <div class="hero-eyebrow">Dashboard</div>
                <asp:Label ID="lblMessage" runat="server"
                    Text="Welcome to PairEd!"
                    CssClass="hero-message" />
                <p class="hero-sub">
                    Manage your skills, find tutors, and track your learning sessions — all in one place.
                </p>
                <div id="divBtnRow" runat="server" class="btn-row">
                    <asp:Button ID="btnRegister" runat="server" Text="Create Account"
                        CssClass="aspx-primary" OnClick="RegisterUser" Visible="true" />
                    <asp:Button ID="btnLogin" runat="server" Text="Log In"
                        CssClass="aspx-secondary" OnClick="LoginUser" Visible="true" />
                </div>
            </div>

            <div class="content">

                <div id="divNewUserCard" runat="server" visible="false">
                    <a href='<%= ResolveUrl("~/Pages/ManageSkills.aspx") %>'
                       style="display:inline-flex;align-items:center;gap:8px;
                              background:#C0392B;color:#fff;
                              font-family:'Sora',sans-serif;font-weight:700;font-size:0.93rem;
                              padding:14px 30px;border-radius:12px;text-decoration:none;
                              box-shadow:0 4px 14px rgba(192,57,43,0.22);">
                        🎯 &nbsp;Add My First Skill
                    </a>
                </div>

                <div id="divReturningCard" runat="server" class="returning-wrap" visible="false">
                    <span class="section-label">Quick Access</span>
                    <div class="big-nav-grid">

                        <!-- Row 1: My Profile full width -->
                        <a href='<%= ResolveUrl("~/Pages/Profile.aspx") %>' class="big-nav-card span-full">
                            <div class="bnc-icon">👤</div>
                            <div class="bnc-body">
                                <div class="bnc-title">My Profile</div>
                                <div class="bnc-desc">View and update your personal details, bio, and contact info.</div>
                                <div class="bnc-arrow">Go to Profile →</div>
                            </div>
                        </a>

                        <!-- Row 2: Find Tutors (accent) | Requests -->
                        <a href='<%= ResolveUrl("~/Pages/Tutors.aspx") %>' class="big-nav-card card-accent">
                            <div class="bnc-icon">🔍</div>
                            <div class="bnc-body">
                                <div class="bnc-title">Find Tutors</div>
                                <div class="bnc-desc">Browse students available to help you right now.</div>
                                <div class="bnc-arrow">Browse Tutors →</div>
                            </div>
                        </a>

                        <a href='<%= ResolveUrl("~/Pages/IncomingRequests.aspx") %>' class="big-nav-card">
                            <div class="bnc-icon">📋</div>
                            <div class="bnc-body">
                                <div class="bnc-title">Requests</div>
                                <div class="bnc-desc">Check and respond to incoming and outgoing tutoring requests.</div>
                                <div class="bnc-arrow">View Requests →</div>
                            </div>
                        </a>

                    </div>

                    <div class="info-strip">
                        <div class="info-item"><div class="info-label">Platform</div><div class="info-val">Student-to-Student</div></div>
                        <div class="info-item"><div class="info-label">Access</div><div class="info-val">School Network Only</div></div>
                        <div class="info-item"><div class="info-label">Cost</div><div class="info-val">Free for All Students</div></div>
                    </div>
                </div>

            </div>
        </div>

    </div>

</form>
</body>
</html>