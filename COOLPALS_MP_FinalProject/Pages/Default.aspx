<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="COOLPALS_MP_FinalProject.Default" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <title>PairEd - Dashboard</title>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="https://fonts.googleapis.com/css2?family=Sora:wght@300;400;600;700;800&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet" />
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        html, body { height: 100%; overflow: hidden; }
        body {
            font-family: 'DM Sans', sans-serif;
            background: #F0EFEB;
            display: flex;
            flex-direction: column;
        }

        /* NAV */
        .nav {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 56px;
            height: 68px;
            background: #0D1B3E;
            border-bottom: 1px solid rgba(255,255,255,0.07);
            flex-shrink: 0;
        }
        .nav-brand { display: flex; align-items: center; gap: 14px; }
        .nav-logo { height: 42px; width: auto; }
        .nav-site-name {
            font-family: 'Sora', sans-serif;
            font-weight: 700;
            font-size: 1.25rem;
            color: #fff;
            letter-spacing: -0.3px;
        }
        .nav-site-name span { color: #CC0000; }
        .nav-right {
            font-family: 'Sora', sans-serif;
            font-size: 0.75rem;
            color: rgba(255,255,255,0.30);
            letter-spacing: 0.1em;
            text-transform: uppercase;
        }

        /* SHELL */
        .shell {
            flex: 1;
            display: grid;
            grid-template-columns: 240px 1fr;
            overflow: hidden;
        }

        /* SIDEBAR */
        .sidebar {
            background: #0D1B3E;
            border-right: 1px solid rgba(255,255,255,0.06);
            display: flex;
            flex-direction: column;
            padding: 32px 0 24px 0;
        }
        .sidebar-top {
            padding: 0 24px 24px 24px;
            border-bottom: 1px solid rgba(255,255,255,0.07);
            margin-bottom: 20px;
        }
        .sidebar-top-label {
            font-family: 'Sora', sans-serif;
            font-size: 0.60rem;
            font-weight: 700;
            color: rgba(255,255,255,0.25);
            text-transform: uppercase;
            letter-spacing: 0.14em;
            margin-bottom: 6px;
        }
        .sidebar-top-title {
            font-family: 'Sora', sans-serif;
            font-weight: 700;
            font-size: 0.95rem;
            color: #fff;
        }
        .sidebar-nav-label {
            font-family: 'Sora', sans-serif;
            font-size: 0.60rem;
            font-weight: 700;
            color: rgba(255,255,255,0.22);
            text-transform: uppercase;
            letter-spacing: 0.14em;
            padding: 0 24px;
            margin-bottom: 6px;
        }

        /* sidebar buttons */
        input[type="submit"] {
            font-family: 'Sora', sans-serif !important;
            cursor: pointer;
            border: none;
            display: block;
            font-weight: 600;
        }
        .aspx-navlink {
            background: transparent !important;
            color: rgba(255,255,255,0.48) !important;
            font-size: 0.86rem !important;
            padding: 11px 24px !important;
            text-align: left !important;
            width: 100% !important;
            border-left: 3px solid transparent !important;
            border-radius: 0 !important;
            margin: 0 !important;
            box-shadow: none !important;
            letter-spacing: 0.01em !important;
        }
        .aspx-navlink:hover {
            background: rgba(255,255,255,0.05) !important;
            color: #fff !important;
        }

        /* MAIN */
        .main {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 52px 72px;
            overflow-y: auto;
        }
        .main-inner {
            width: 100%;
            max-width: 520px;
        }

        /* STATE CARD */
        .state-card {
            background: #fff;
            border-radius: 16px;
            border: 1px solid #E0DED8;
            padding: 42px 44px;
            margin-bottom: 16px;
        }
        .state-accent {
            width: 38px; height: 4px;
            background: #CC0000;
            border-radius: 2px;
            margin-bottom: 16px;
        }
        .state-title {
            font-family: 'Sora', sans-serif;
            font-weight: 800;
            font-size: 1.45rem;
            color: #0D1B3E;
            letter-spacing: -0.8px;
            margin-bottom: 4px;
        }
        .state-title em { color: #CC0000; font-style: normal; }

        /* MESSAGE */
        .msg-text {
            font-family: 'Sora', sans-serif;
            font-size: 0.86rem;
            font-weight: 600;
            color: #CC0000;
            display: block;
            margin-top: 10px;
            line-height: 1.6;
        }

        /* GUEST — side by side buttons */
        .btn-row {
            display: flex;
            gap: 12px;
            margin-top: 22px;
        }
        .aspx-primary {
            background: #CC0000 !important;
            color: #fff !important;
            font-size: 0.93rem !important;
            padding: 14px 20px !important;
            border-radius: 10px !important;
            box-shadow: 0 4px 14px rgba(204,0,0,0.24) !important;
            flex: 1 !important;
            margin: 0 !important;
        }
        .aspx-primary:hover { background: #A80000 !important; }

        .aspx-secondary {
            background: #0D1B3E !important;
            color: #fff !important;
            font-size: 0.93rem !important;
            padding: 14px 20px !important;
            border-radius: 10px !important;
            flex: 1 !important;
            margin: 0 !important;
        }
        .aspx-secondary:hover { background: #162348 !important; }

        /* NEW USER */
        .aspx-newuser {
            background: #CC0000 !important;
            color: #fff !important;
            font-size: 0.93rem !important;
            padding: 14px 20px !important;
            border-radius: 10px !important;
            box-shadow: 0 4px 14px rgba(204,0,0,0.24) !important;
            margin-top: 22px !important;
            width: 100% !important;
        }
        .aspx-newuser:hover { background: #A80000 !important; }

        /* RETURNING USER */
        .nav-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 10px;
            margin-top: 22px;
        }
        .aspx-ghost {
            background: #F5F4F0 !important;
            color: #0D1B3E !important;
            font-size: 0.86rem !important;
            padding: 13px 10px !important;
            border: 1px solid #E0DED8 !important;
            border-radius: 10px !important;
            margin: 0 !important;
            box-shadow: none !important;
            text-align: center !important;
        }
        .aspx-ghost:hover { border-color: #0D1B3E !important; background: #ECEAE4 !important; }
        .span2 { grid-column: span 2; }

        /* INFO STRIP */
        .info-card {
            background: #fff;
            border-radius: 16px;
            border: 1px solid #E0DED8;
            padding: 22px 44px;
            display: flex;
            gap: 0;
        }
        .info-item { flex: 1; display: flex; flex-direction: column; }
        .info-item + .info-item {
            padding-left: 28px;
            border-left: 1px solid #E0DED8;
        }
        .info-label {
            font-family: 'Sora', sans-serif;
            font-size: 0.60rem;
            font-weight: 700;
            color: #C0BEB9;
            text-transform: uppercase;
            letter-spacing: 0.1em;
            margin-bottom: 4px;
        }
        .info-val {
            font-family: 'Sora', sans-serif;
            font-size: 0.86rem;
            font-weight: 700;
            color: #0D1B3E;
        }
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

        <!-- SIDEBAR — same IDs as cs -->
        <div class="sidebar">
            <div class="sidebar-top">
                <div class="sidebar-top-label">Platform</div>
                <div class="sidebar-top-title">PairEd Dashboard</div>
            </div>

            <div class="sidebar-nav-label">Navigation</div>

            <asp:Button ID="btnProfile" runat="server" Text="👤  Profile"
                CssClass="aspx-navlink" PostBackUrl="~/Pages/Profile.aspx" Visible="false" />

            <asp:Button ID="btnTutors" runat="server" Text="🔍  Find Tutors"
                CssClass="aspx-navlink" PostBackUrl="~/Pages/Tutors.aspx" Visible="false" />

            <asp:Button ID="btnRequests" runat="server" Text="📋  Requests"
                CssClass="aspx-navlink" PostBackUrl="~/Pages/Requests.aspx" Visible="false" />
        </div>


        <!-- MAIN -->
        <div class="main">
            <div class="main-inner">

                <div class="state-card">
                    <div class="state-accent"></div>
                    <div class="state-title">Welcome to <em>PairEd</em></div>

                    <!-- lblMessage — used by all 3 states in cs, no changes -->
                    <asp:Label ID="lblMessage" runat="server" CssClass="msg-text" Text=""></asp:Label>

                    <!-- GUEST: btnRegister + btnLogin side by side -->
                    <div id="divBtnRow" runat="server" class="btn-row">
                        <asp:Button ID="btnRegister" runat="server" Text="Create Account"
                            CssClass="aspx-primary" OnClick="RegisterUser" Visible="true" />
                        <asp:Button ID="btnLogin" runat="server" Text="Log In"
                            CssClass="aspx-secondary" OnClick="LoginUser" Visible="true" />
                    </div>

                    <div id="divNewUserCard" runat="server" style="margin-top:22px;" visible="false">
                        <a href='<%= ResolveUrl("~/Pages/Profile.aspx") %>'
                           style="display:block;width:100%;padding:14px 20px;background:#CC0000;color:#fff;
                                  font-family:'Sora',sans-serif;font-weight:700;font-size:0.93rem;
                                  border-radius:10px;text-align:center;text-decoration:none;
                                  box-shadow:0 4px 14px rgba(204,0,0,0.24);">
                            👤  Complete My Profile
                        </a>
                    </div>

                    <!-- RETURNING USER: nav grid in main card -->
                    <div id="divReturningCard" runat="server" class="nav-grid" style="display:none;">
                        <a href='<%= ResolveUrl("~/Pages/Profile.aspx") %>'
                           style="display:block;padding:13px 10px;background:#F5F4F0;color:#0D1B3E;
                                  font-family:'Sora',sans-serif;font-weight:600;font-size:0.86rem;
                                  border:1px solid #E0DED8;border-radius:10px;text-align:center;
                                  text-decoration:none;">
                            👤  Profile
                        </a>
                        <a href='<%= ResolveUrl("~/Pages/Tutors.aspx") %>'
                           style="display:block;padding:13px 10px;background:#F5F4F0;color:#0D1B3E;
                                  font-family:'Sora',sans-serif;font-weight:600;font-size:0.86rem;
                                  border:1px solid #E0DED8;border-radius:10px;text-align:center;
                                  text-decoration:none;">
                            🔍  Find Tutors
                        </a>
                        <a href='<%= ResolveUrl("~/Pages/Requests.aspx") %>'
                           style="display:block;padding:13px 10px;background:#F5F4F0;color:#0D1B3E;
                                  font-family:'Sora',sans-serif;font-weight:600;font-size:0.86rem;
                                  border:1px solid #E0DED8;border-radius:10px;text-align:center;
                                  text-decoration:none;grid-column:span 2;">
                            📋  Requests
                        </a>
                    </div>

                </div>

                <!-- INFO STRIP -->
                <div class="info-card">
                    <div class="info-item">
                        <span class="info-label">Platform</span>
                        <span class="info-val">Student-to-Student</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Access</span>
                        <span class="info-val">School Network Only</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Cost</span>
                        <span class="info-val">Free for All Students</span>
                    </div>
                </div>

            </div>
        </div>
    </div>

</form>
</body>
</html>