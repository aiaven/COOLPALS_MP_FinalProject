<%@ Page Language="C#" AutoEventWireup="false" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <title>PairEd - Welcome</title>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="https://fonts.googleapis.com/css2?family=Sora:wght@300;400;600;700;800&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet" />
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        html, body { height: 100%; overflow: hidden; }
        body {
            font-family: 'DM Sans', sans-serif;
            background: #0D1B3E;
            display: flex;
            flex-direction: column;
        }
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
        .page {
            flex: 1;
            display: grid;
            grid-template-columns: 70% 30%;
            overflow: hidden;
        }
        .left {
            position: relative;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            padding: 72px 110px 48px 110px;
            overflow: hidden;
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
        }
        .left-overlay {
            position: absolute;
            inset: 0;
            background: linear-gradient(140deg, rgba(13,27,62,0.82) 0%, rgba(13,27,62,0.55) 60%, rgba(13,27,62,0.38) 100%);
            z-index: 1;
        }
        .left-content { position: relative; z-index: 2; max-width: 780px; }
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
            font-size: clamp(3rem, 5vw, 4.8rem);
            color: #fff;
            line-height: 1.06;
            letter-spacing: -3px;
            margin-bottom: 26px;
        }
        .left h1 em { color: #CC0000; font-style: normal; }
        .left-content p {
            font-size: 1.18rem;
            color: rgba(255,255,255,0.82);
            line-height: 1.80;
            max-width: 580px;
            margin-bottom: 40px;
        }
        .skills-row { display: flex; flex-wrap: wrap; gap: 11px; margin-bottom: 40px; }
        .skill-pill {
            background: rgba(255,255,255,0.10);
            border: 1px solid rgba(255,255,255,0.22);
            color: rgba(255,255,255,0.88);
            font-size: 0.92rem;
            font-weight: 500;
            padding: 9px 20px;
            border-radius: 99px;
        }
        .about-strip {
            position: relative;
            z-index: 2;
            display: flex;
            align-items: center;
            background: rgba(255,255,255,0.06);
            border-top: 1px solid rgba(255,255,255,0.10);
            margin: 0 -110px -48px -110px;
            padding: 28px 110px;
        }
        .about-item { display: flex; flex-direction: column; flex: 1; }
        .about-item + .about-item { padding-left: 48px; border-left: 1px solid rgba(255,255,255,0.12); }
        .about-label {
            font-family: 'Sora', sans-serif;
            font-size: 0.72rem;
            font-weight: 600;
            color: rgba(255,255,255,0.40);
            text-transform: uppercase;
            letter-spacing: 0.12em;
            margin-bottom: 5px;
        }
        .about-val {
            font-family: 'Sora', sans-serif;
            font-size: 1.05rem;
            font-weight: 700;
            color: rgba(255,255,255,0.88);
        }
        .right {
            background: #F5F4F0;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 52px 48px;
            border-left: 1px solid #E0DED8;
        }
        .right-inner { width: 100%; max-width: 340px; }
        .right-accent {
            width: 44px; height: 4px;
            background: #CC0000;
            border-radius: 2px;
            margin-bottom: 20px;
        }
        .right-heading {
            font-family: 'Sora', sans-serif;
            font-weight: 700;
            font-size: 1.65rem;
            color: #0D1B3E;
            margin-bottom: 6px;
            letter-spacing: -0.5px;
        }
        .right-sub {
            font-size: 0.92rem;
            color: #8A8A8A;
            margin-bottom: 32px;
            line-height: 1.65;
        }
        .btn-block {
            display: block;
            width: 100%;
            padding: 16px;
            border: none;
            border-radius: 10px;
            font-family: 'Sora', sans-serif;
            font-weight: 700;
            font-size: 1.02rem;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
            letter-spacing: 0.02em;
        }
        .btn-red {
            background: #CC0000;
            color: #fff;
            box-shadow: 0 4px 18px rgba(204,0,0,0.28);
            margin-bottom: 12px;
        }
        .btn-red:hover { background: #A80000; }
        .btn-navy {
            background: #0D1B3E;
            color: #fff;
        }
        .btn-navy:hover { background: #162348; }
        .divider-line {
            display: flex;
            align-items: center;
            gap: 12px;
            margin: 2px 0 14px;
            color: #C0BEB9;
            font-size: 0.80rem;
        }
        .divider-line::before, .divider-line::after {
            content: ''; flex: 1;
            height: 1px; background: #E0DED8;
        }
        .right-bottom-brand {
            margin-top: 36px;
            padding-top: 22px;
            border-top: 1px solid #E0DED8;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 8px;
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
    <!-- NAV -->
    <div class="nav">
        <div class="nav-brand">
            <img src='<%= ResolveUrl("~/Images/PairEdLogo.png") %>' alt="PairEd Logo" class="nav-logo" />
            <span class="nav-site-name">Pair<span>Ed</span></span>
        </div>
        <span class="nav-tag">Student Skill-Sharing Platform</span>
    </div>

    <div class="page">
        <div class="left" style='background-image: url("<%= ResolveUrl("~/Images/backphoto.jpg") %>"); background-size: cover; background-position: center;'>
            <div class="left-overlay"></div>
            <div class="left-content">
                <div class="badge"><span class="badge-dot"></span>School-Based · Free to Use</div>
                <h1>Learn from peers.<br/>Teach what you <em>know.</em></h1>
                <p>PairEd connects students inside your school to share skills — from calculus and coding to guitar, public speaking, and design. Peer learning, redefined.</p>
                <div class="skills-row">
                    <span class="skill-pill">📐 Mathematics</span>
                    <span class="skill-pill">💻 Programming</span>
                    <span class="skill-pill">🎸 Guitar</span>
                    <span class="skill-pill">🎤 Public Speaking</span>
                    <span class="skill-pill">🎨 Graphic Design</span>
                    <span class="skill-pill">+ more</span>
                </div>
            </div>
            <div class="about-strip">
                <div class="about-item">
                    <span class="about-label">Platform</span>
                    <span class="about-val">Student-to-Student</span>
                </div>
                <div class="about-item">
                    <span class="about-label">Access</span>
                    <span class="about-val">School Network Only</span>
                </div>
                <div class="about-item">
                    <span class="about-label">Cost</span>
                    <span class="about-val">Free for All Students</span>
                </div>
            </div>
        </div>

        <div class="right">
            <div class="right-inner">
                <div class="right-accent"></div>
                <p class="right-heading">Get Started</p>
                <p class="right-sub">Join your school's skill network. Register a new account or log in to continue.</p>
                <a href="Register.aspx" class="btn-block btn-red">Create Account</a>
                <div class="divider-line">or</div>
                <a href="Login.aspx" class="btn-block btn-navy">Log In</a>
                <div class="right-bottom-brand">
                    <img src='<%= ResolveUrl("~/Images/PairEdLogo.png") %>' alt="PairEd" />
                    <span>For enrolled students only · Safe &amp; school-monitored<br/>© 2025 PairEd · COOLPALS Final Project</span>
                </div>
            </div>
        </div>
    </div>
</body>
</html>