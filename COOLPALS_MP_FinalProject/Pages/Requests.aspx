<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Requests.aspx.cs" Inherits="COOLPALS_MP_FinalProject.Request" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>PairEd - Request Tutoring Session</title>
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
        .nav-logo { height: 52px; width: auto;}
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

        /* ── PAGE LAYOUT ── */
        .page {
            flex: 1;
            display: grid;
            grid-template-columns: 1fr 420px;
            overflow: hidden;
        }

        /* ── LEFT PANEL ── */
        .left {
            display: flex;
            flex-direction: column;
            justify-content: center;
            padding: 72px 110px;
            overflow-y: auto;
        }
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
            margin-bottom: 28px;
        }
        .badge-dot { width: 8px; height: 8px; border-radius: 50%; background: #CC0000; }
        .left h1 {
            font-family: 'Sora', sans-serif;
            font-weight: 800;
            font-size: clamp(2.4rem, 4vw, 3.8rem);
            color: #fff;
            line-height: 1.06;
            letter-spacing: -2px;
            margin-bottom: 16px;
        }
        .left h1 em { color: #CC0000; font-style: normal; }
        .left-desc {
            font-size: 1.05rem;
            color: rgba(255,255,255,0.55);
            line-height: 1.80;
            max-width: 480px;
        }

        /* ── RIGHT PANEL ── */
        .right {
            background: #F5F4F0;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 52px 48px;
            border-left: 1px solid #E0DED8;
            overflow-y: auto;
        }
        .right-inner { width: 100%; max-width: 340px; }
        .right-accent {
            width: 44px;
            height: 4px;
            background: #CC0000;
            border-radius: 2px;
            margin-bottom: 20px;
        }
        .right-heading {
            font-family: 'Sora', sans-serif;
            font-weight: 700;
            font-size: 1.55rem;
            color: #0D1B3E;
            margin-bottom: 6px;
            letter-spacing: -0.5px;
        }
        .right-sub {
            font-size: 0.88rem;
            color: #8A8A8A;
            margin-bottom: 28px;
            line-height: 1.65;
        }

        /* ── MESSAGE LABEL ── */
        .msg-label {
            display: block;
            font-family: 'Sora', sans-serif;
            font-size: 0.82rem;
            font-weight: 600;
            color: #CC0000;
            background: rgba(204,0,0,0.08);
            border: 1px solid rgba(204,0,0,0.25);
            border-radius: 8px;
            padding: 10px 14px;
            margin-bottom: 20px;
        }

        /* ── FORM FIELDS ── */
        .field { display: flex; flex-direction: column; gap: 6px; margin-bottom: 16px; }
        .field label {
            font-family: 'Sora', sans-serif;
            font-size: 0.72rem;
            font-weight: 700;
            color: #6B6B6B;
            text-transform: uppercase;
            letter-spacing: 0.10em;
        }
        .field input[type="text"],
        .field input[type="date"],
        .field input[type="time"],
        .field select,
        .field textarea {
            font-family: 'DM Sans', sans-serif;
            font-size: 0.95rem;
            color: #0D1B3E;
            background: #fff;
            border: 1px solid #D8D6D0;
            border-radius: 10px;
            padding: 11px 14px;
            width: 100%;
            outline: none;
            transition: border-color 0.2s;
            resize: none;
        }
        .field input[readonly] { background: #F0EFEB; color: #999; cursor: not-allowed; }
        .field input:focus,
        .field select:focus,
        .field textarea:focus { border-color: #CC0000; }
        .field select { appearance: none; background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='8' viewBox='0 0 12 8'%3E%3Cpath d='M1 1l5 5 5-5' stroke='%23999' stroke-width='1.5' fill='none' stroke-linecap='round'/%3E%3C/svg%3E"); background-repeat: no-repeat; background-position: right 14px center; }

        /* ── BUTTONS ── */
        .btn-block {
            display: block;
            width: 100%;
            padding: 14px;
            border: none;
            border-radius: 10px;
            font-family: 'Sora', sans-serif;
            font-weight: 700;
            font-size: 0.97rem;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
            letter-spacing: 0.02em;
            transition: background 0.2s;
        }
        .btn-red {
            background: #CC0000;
            color: #fff;
            box-shadow: 0 4px 18px rgba(204,0,0,0.28);
            margin-bottom: 10px;
        }
        .btn-red:hover { background: #A80000; }
        .btn-navy {
            background: #0D1B3E;
            color: #fff;
            margin-bottom: 10px;
        }
        .btn-navy:hover { background: #162348; }

        /* ── DIVIDER ── */
        .divider-line {
            display: flex;
            align-items: center;
            gap: 12px;
            margin: 4px 0 10px;
            color: #C0BEB9;
            font-size: 0.78rem;
        }
        .divider-line::before, .divider-line::after {
            content: ''; flex: 1;
            height: 1px; background: #E0DED8;
        }

        /* ── BOTTOM BRAND ── */
        .right-bottom-brand {
            margin-top: 28px;
            padding-top: 20px;
            border-top: 1px solid #E0DED8;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 6px;
        }
        .right-bottom-brand span {
            font-family: 'Sora', sans-serif;
            font-size: 0.68rem;
            color: #C0BEB9;
            text-align: center;
            line-height: 1.65;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">

        <%-- NAV --%>
        <nav class="nav">
            <div class="nav-brand">
                <img src='../Images/PairEdLogo.png' alt="PairEd Logo" class="nav-logo" />
                <span class="nav-site-name">Pair<span>Ed</span></span>
            </div>
            <span class="nav-tag">Student Skill-Sharing Platform</span>
        </nav>

        <%-- PAGE --%>
        <div class="page">

            <%-- LEFT: INFO --%>
            <div class="left">
                <div>
                    <div class="badge"><span class="badge-dot"></span> New Request</div>
                    <h1>Book a <em>Session</em></h1>
                    <p class="left-desc">
                        Fill out the form to request a peer tutoring session.
                        Your tutor will be notified and confirm the schedule.
                    </p>
                </div>
            </div>

            <%-- RIGHT: FORM --%>
            <div class="right">
                <div class="right-inner">

                    <div class="right-accent"></div>
                    <div class="right-heading">Session Details</div>
                    <div class="right-sub">All fields are required unless noted.</div>

                    <%-- MESSAGE --%>
                    <asp:Label ID="lblMessage" runat="server" CssClass="msg-label" />

                    <%-- TUTOR --%>
                    <div class="field">
                        <asp:Label ID="lblTutor" runat="server" Text="Tutor" AssociatedControlID="txtTutor" />
                        <asp:TextBox ID="txtTutor" runat="server" ReadOnly="true" />
                    </div>

                    <%-- SKILL --%>
                    <div class="field">
                        <asp:Label ID="lblSkill" runat="server" Text="Skill" AssociatedControlID="ddlSkill" />
                        <asp:DropDownList ID="ddlSkill" runat="server" />
                    </div>

                    <%-- DATE --%>
                    <div class="field">
                        <asp:Label ID="lblDate" runat="server" Text="Requested Date" AssociatedControlID="txtDate" />
                        <asp:TextBox ID="txtDate" runat="server" TextMode="Date" />
                    </div>

                    <%-- TIME --%>
                    <div class="field">
                        <asp:Label ID="lblTime" runat="server" Text="Requested Time" AssociatedControlID="txtTime" />
                        <asp:TextBox ID="txtTime" runat="server" TextMode="Time" />
                    </div>

                    <%-- NOTES --%>
                    <div class="field">
                        <asp:Label ID="lblNotes" runat="server" Text="Notes (optional)" AssociatedControlID="txtNotes" />
                        <asp:TextBox ID="txtNotes" runat="server" TextMode="MultiLine" Rows="4" />
                    </div>

                    <%-- SUBMIT --%>
                    <asp:Button ID="btnSubmit" runat="server" Text="Submit Request"
                        OnClick="SubmitRequest" CssClass="btn-block btn-red" />

                    <div class="divider-line">or</div>

                    <%-- BACK TO TUTORS --%>
                    <asp:HyperLink ID="lnkBackTutor" runat="server"
                        NavigateUrl="~/Pages/Tutors.aspx"
                        Text="← Back to Tutors"
                        CssClass="btn-block btn-navy" />

                    <%-- BACK TO HOME --%>
                    <asp:Button ID="btnBack" runat="server" Text="Go to Dashboard"
                        PostBackUrl="~/Pages/Default.aspx"
                        CssClass="btn-block btn-navy" />

                    <div class="right-bottom-brand">
                        <span>PairEd &mdash; Peer Tutoring Platform<br />Powered by COOLPALS</span>
                    </div>

                </div>
            </div>

        </div>
    </form>
</body>
</html>
