<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Requests.aspx.cs" Inherits="COOLPALS_MP_FinalProject.Request" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>PairEd - Request Tutoring Session</title>
    <link href="https://fonts.googleapis.com/css2?family=Sora:wght@400;500;600;700;800&family=DM+Sans:wght@400;500;600&display=swap" rel="stylesheet" />
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        html, body { height: 100%; overflow: hidden; }

        body {
            font-family: 'DM Sans', sans-serif;
            background: #0D1B3E;
            display: flex;
            flex-direction: column;
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
            position: relative;
            z-index: 10;
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

        /* PAGE */
        .page {
            flex: 1;
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            height: calc(100vh - 78px);
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
        }
        .page-overlay {
            position: absolute;
            inset: 0;
            background: linear-gradient(140deg, rgba(13,27,62,0.88) 0%, rgba(13,27,62,0.65) 60%, rgba(13,27,62,0.50) 100%);
            z-index: 0;
        }

        /* CENTERED INNER */
        .page-inner {
            position: relative;
            z-index: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            width: 100%;
        }

        /* FLOATING CARD */
        .card {
            background: #F5F4F0;
            border-radius: 20px;
            padding: 36px 48px;
            width: 100%;
            max-width: 640px;
            border: 1px solid #E0DED8;
            box-shadow: 0 24px 80px rgba(0,0,0,0.35), 0 8px 24px rgba(0,0,0,0.18);
            overflow: visible;
        }

        /* CARD HEADER */
        .right-accent {
            width: 44px;
            height: 4px;
            background: #CC0000;
            border-radius: 2px;
            margin-bottom: 16px;
        }
        .right-heading {
            font-family: 'Sora', sans-serif;
            font-weight: 700;
            font-size: 1.65rem;
            color: #0D1B3E;
            margin-bottom: 4px;
            letter-spacing: -0.5px;
        }
        .right-sub {
            font-size: 0.92rem;
            color: #8A8A8A;
            margin-bottom: 20px;
            line-height: 1.65;
        }

        /* MESSAGE LABEL */
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
            margin-bottom: 16px;
        }

        /* TWO-COLUMN FIELDS */
        .fields-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 14px;
        }
        .field-full { grid-column: span 2; }

        /* FORM FIELDS */
        .field { display: flex; flex-direction: column; gap: 6px; }
        .field label {
            font-family: 'Sora', sans-serif;
            font-size: 0.68rem;
            font-weight: 700;
            color: #0D1B3E;
            text-transform: uppercase;
            letter-spacing: 0.12em;
        }
        .field input[type="text"],
        .field input[type="date"],
        .field input[type="time"],
        .field select,
        .field textarea {
            font-family: 'DM Sans', sans-serif;
            font-size: 0.93rem;
            color: #0D1B3E;
            background: #fff;
            border: 1.5px solid #D5D0C8;
            border-radius: 10px;
            padding: 11px 14px;
            width: 100%;
            outline: none;
            transition: border-color 0.2s, box-shadow 0.2s;
            resize: none;
        }
        .field input[readonly] { background: #F5F4F0; color: #AEAAA3; cursor: not-allowed; }
        .field input:focus,
        .field select:focus,
        .field textarea:focus {
            border-color: #CC0000;
            box-shadow: 0 0 0 3px rgba(204,0,0,0.10);
        }
        .field select {
            appearance: none;
            -webkit-appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='8' viewBox='0 0 12 8'%3E%3Cpath d='M1 1l5 5 5-5' stroke='%23999' stroke-width='1.5' fill='none' stroke-linecap='round'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 14px center;
        }

        /* BUTTONS */
        .btn-block {
            display: block;
            width: 100%;
            padding: 14px;
            border: none;
            border-radius: 10px;
            font-family: 'Sora', sans-serif;
            font-weight: 700;
            font-size: 1.02rem;
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
        }
        .btn-red:hover { background: #A80000; }
        .btn-navy {
            background: #0D1B3E;
            color: #fff;
        }
        .btn-navy:hover { background: #162348; }

        .btn-row-full { margin-top: 16px; }
        .btn-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 10px;
            margin-top: 10px;
        }

        /* DIVIDER */
        .divider-line {
            display: flex;
            align-items: center;
            gap: 12px;
            margin: 14px 0 0;
            color: #C0BEB9;
            font-size: 0.80rem;
        }
        .divider-line::before, .divider-line::after {
            content: ''; flex: 1;
            height: 1px; background: #E0DED8;
        }

        /* BOTTOM BRAND */
        .right-bottom-brand {
            margin-top: 20px;
            padding-top: 16px;
            border-top: 1px solid #E0DED8;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 6px;
        }
        .right-bottom-brand img { height: 28px; width: auto; opacity: 0.28; }
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

        <!-- NAV -->
        <nav class="nav">
            <div class="nav-brand">
                <img src='../Images/PairEdLogo.png' alt="PairEd Logo" class="nav-logo" />
                <span class="nav-site-name">Pair<span>Ed</span></span>
            </div>
            <span class="nav-tag">Student Skill-Sharing Platform</span>
        </nav>

        <!-- PAGE -->
        <div class="page" style='background-image: url("<%= ResolveUrl("~/Images/backphoto.jpg") %>"); background-size: cover; background-position: center;'>
            <div class="page-overlay"></div>

            <div class="page-inner">

                <!-- FLOATING CARD -->
                <div class="card">
                    <div class="right-accent"></div>
                    <div class="right-heading">Session Details</div>
                    <div class="right-sub">All fields are required unless noted.</div>

                    <!-- MESSAGE -->
                    <asp:Label ID="lblMessage" runat="server" CssClass="msg-label" />

                    <!-- TWO-COLUMN FIELDS GRID -->
                    <div class="fields-grid">

                        <!-- TUTOR -->
                        <div class="field field-full">
                            <asp:Label ID="lblTutor" runat="server" Text="Tutor" AssociatedControlID="txtTutor" />
                            <asp:TextBox ID="txtTutor" runat="server" ReadOnly="true" />
                        </div>

                        <!-- SKILL -->
                        <div class="field field-full">
                            <asp:Label ID="lblSkill" runat="server" Text="Skill" AssociatedControlID="ddlSkill" />
                            <asp:DropDownList ID="ddlSkill" runat="server" />
                        </div>

                        <!-- DATE -->
                        <div class="field">
                            <asp:Label ID="lblDate" runat="server" Text="Requested Date" AssociatedControlID="txtDate" />
                            <asp:TextBox ID="txtDate" runat="server" TextMode="Date"
                                AutoPostBack="true"
                                OnTextChanged="txtDate_TextChanged" />
                            <asp:Label ID="lblDateError" runat="server" ForeColor="Red" />
                        </div>

                        <!-- TIME -->
                        <div class="field">
                            <asp:Label ID="lblTime" runat="server" Text="Requested Time" />

                            <div style="display:flex; gap:8px;">
                                <asp:DropDownList ID="ddlHour" runat="server" style="flex:1;" />
                                <asp:DropDownList ID="ddlMinute" runat="server" style="flex:1;" />
                                <asp:DropDownList ID="ddlPeriod" runat="server" style="flex:1;" />
                            </div>

                            <asp:Label ID="lblTimeError" runat="server" ForeColor="Red" />
                        </div>

                        <!-- NOTES -->
                        <div class="field field-full">
                            <asp:Label ID="lblNotes" runat="server" Text="Notes (optional)" AssociatedControlID="txtNotes" />
                            <asp:TextBox ID="txtNotes" runat="server" TextMode="MultiLine" Rows="2" />
                        </div>

                    </div>

                    <!-- SUBMIT -->
                    <div class="btn-row-full">
                        <asp:Button ID="btnSubmit" runat="server" Text="Submit Request"
                            OnClick="SubmitRequest" CssClass="btn-block btn-red" />
                    </div>

                    <div class="divider-line">or</div>

                    <!-- BOTTOM BUTTONS -->
                    <div class="btn-row">
                        <asp:HyperLink ID="lnkBackTutor" runat="server"
                            NavigateUrl="~/Pages/Tutors.aspx"
                            Text="View Tutors"
                            CssClass="btn-block btn-navy" />
                        <asp:Button ID="btnBack" runat="server" Text="Go to Dashboard"
                            PostBackUrl="~/Pages/Default.aspx"
                            CssClass="btn-block btn-navy" />
                    </div>

                    <div class="right-bottom-brand">
                        <img src='<%= ResolveUrl("~/Images/PairEdLogo.png") %>' alt="PairEd" />
                        <span>For enrolled students only · Safe &amp; school-monitored · © 2025 PairEd · COOLPALS Final Project</span>
                    </div>
                </div>

            </div>
        </div>

    </form>
</body>
</html>