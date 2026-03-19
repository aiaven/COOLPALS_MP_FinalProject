<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Logout.aspx.cs" Inherits="COOLPALS_MP_FinalProject.Logout" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <title>PairEd - Logout</title>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="https://fonts.googleapis.com/css2?family=Sora:wght@300;400;600;700;800&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet" />
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        html, body {
            height: 100%;
            font-family: 'DM Sans', sans-serif;
            background: #0D1B3E;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }

        body::before {
            content: '';
            position: fixed;
            inset: 0;
            background-image: radial-gradient(rgba(255,255,255,0.045) 1px, transparent 1px);
            background-size: 32px 32px;
            pointer-events: none;
        }

        .card {
            background: #F5F4F0;
            border-radius: 24px;
            padding: 72px 80px 64px;
            width: 100%;
            max-width: 560px;
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
            border: 1px solid #E0DED8;
            box-shadow: 0 24px 80px rgba(0,0,0,0.28);
            position: relative;
        }

        .card-accent {
            width: 52px;
            height: 4px;
            background: #CC0000;
            border-radius: 2px;
            margin-bottom: 28px;
        }

        .card-icon {
            width: 72px; height: 72px;
            border-radius: 50%;
            background: linear-gradient(135deg, #CC0000, #7A0000);
            display: flex; align-items: center; justify-content: center;
            font-size: 1.9rem;
            margin-bottom: 28px;
        }

        .card h2 {
            font-family: 'Sora', sans-serif;
            font-weight: 800;
            font-size: 2rem;
            color: #0D1B3E;
            letter-spacing: -0.8px;
            margin-bottom: 14px;
            line-height: 1.15;
        }

        .card p {
            font-size: 1.02rem;
            color: #8A8A8A;
            line-height: 1.75;
            margin-bottom: 40px;
            max-width: 360px;
        }

        .btn-row {
            display: flex;
            gap: 14px;
            width: 100%;
        }

        .btn-primary {
            font-family: 'Sora', sans-serif;
            cursor: pointer;
            border: none;
            flex: 1;
            display: block;
            font-weight: 700;
            letter-spacing: 0.02em;
            border-radius: 12px;
            background: #CC0000;
            color: #fff;
            font-size: 1.02rem;
            padding: 17px;
            box-shadow: 0 6px 22px rgba(204,0,0,0.30);
            transition: background 0.2s;
            text-align: center;
            text-decoration: none;
        }
        .btn-primary:hover { background: #A80000; }

        .btn-secondary {
            font-family: 'Sora', sans-serif;
            cursor: pointer;
            border: none;
            flex: 1;
            display: block;
            font-weight: 700;
            letter-spacing: 0.02em;
            border-radius: 12px;
            background: #0D1B3E;
            color: #fff;
            font-size: 1.02rem;
            padding: 17px;
            text-align: center;
            text-decoration: none;
            transition: background 0.2s;
        }
        .btn-secondary:hover { background: #162348; }

        .card-footer {
            margin-top: 40px;
            padding-top: 24px;
            border-top: 1px solid #E0DED8;
            width: 100%;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 8px;
        }
        .card-footer img { height: 32px; width: auto; opacity: 0.25; }
        .card-footer span {
            font-family: 'Sora', sans-serif;
            font-size: 0.70rem;
            color: #C0BEB9;
            text-align: center;
            line-height: 1.65;
        }
    </style>
</head>
<body>
<form id="form1" runat="server">

    <div class="card">
        <div class="card-accent"></div>
        <div class="card-icon">👋</div>

        <h2>You've been logged out successfully.</h2>
        <p>Thank you for using PairEd. Your session has ended safely. We hope to see you again soon!</p>

        <div class="btn-row">
            <asp:HyperLink ID="lnkLogin" runat="server"
                NavigateUrl="~/Pages/Login.aspx"
                Text="Log In Again"
                CssClass="btn-primary" />
            <asp:HyperLink ID="lnkHome" runat="server"
                NavigateUrl="~/Pages/LandingPage.aspx"
                Text="Return to Home"
                CssClass="btn-secondary" />
        </div>

        <div class="card-footer">
            <img src='<%= ResolveUrl("~/Images/PairEdLogo.png") %>' alt="PairEd" />
            <span>For enrolled students only · Safe &amp; school-monitored<br/>© 2025 PairEd · COOLPALS Final Project</span>
        </div>
    </div>

</form>
</body>
</html>