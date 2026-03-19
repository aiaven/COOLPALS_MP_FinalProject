<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="COOLPALS_MP_FinalProject.Profile" %>
<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>PairEd - Student Profile</title>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="https://fonts.googleapis.com/css2?family=Sora:wght@300;400;600;700;800&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet" />
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        html, body {
            font-family: 'DM Sans', sans-serif;
            background: #0D1B3E;
            color: #0D1B3E;
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
            position: sticky;
            top: 0;
            z-index: 100;
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

        /* PAGE BODY */
        .page-body {
            min-height: calc(100vh - 78px);
            background: #F5F4F0;
            padding: 52px 72px;
        }

        /* PAGE HEADER */
        .page-header { margin-bottom: 32px; }
        .page-header-accent {
            width: 44px;
            height: 4px;
            background: #CC0000;
            border-radius: 2px;
            margin-bottom: 16px;
        }
        .page-header h2 {
            font-family: 'Sora', sans-serif;
            font-weight: 800;
            font-size: 2rem;
            color: #0D1B3E;
            letter-spacing: -0.5px;
        }

        .divider {
            height: 1px;
            background: #E0DED8;
            margin-bottom: 36px;
        }

        /* MESSAGE */
        .msg-text {
            font-family: 'Sora', sans-serif;
            font-size: 0.88rem;
            font-weight: 600;
            color: #1a7a3c;
            background: rgba(26,122,60,0.08);
            border: 1px solid rgba(26,122,60,0.22);
            border-radius: 10px;
            padding: 12px 18px;
            display: block;
            margin-bottom: 28px;
            line-height: 1.55;
        }

        /* TWO-COLUMN LAYOUT */
        .profile-grid {
            display: grid;
            grid-template-columns: 230px 1fr;
            gap: 28px;
            align-items: start;
            margin-bottom: 28px;
        }

        /* PROFILE PICTURE CARD */
        .pic-card {
            background: #fff;
            border-radius: 14px;
            border: 1px solid #E0DED8;
            padding: 32px 24px;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 14px;
            text-align: center;
        }
        .pic-card img {
            width: 110px;
            height: 110px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid #E0DED8;
        }
        .pic-upload-label {
            font-family: 'Sora', sans-serif;
            font-size: 0.68rem;
            font-weight: 700;
            letter-spacing: 0.12em;
            text-transform: uppercase;
            color: #AEAAA3;
            display: block;
        }
        .pic-card input[type="file"] {
            font-size: 0.80rem;
            color: #8A8A8A;
            width: 100%;
        }
        .btn-upload {
            font-family: 'Sora', sans-serif;
            cursor: pointer;
            border: none;
            width: 100%;
            font-weight: 700;
            border-radius: 10px;
            background: #0D1B3E;
            color: #fff;
            font-size: 0.85rem;
            padding: 11px;
            transition: background 0.2s;
        }
        .btn-upload:hover { background: #162348; }

        /* INFO CARD */
        .info-card {
            background: #fff;
            border-radius: 14px;
            border: 1px solid #E0DED8;
            padding: 32px 36px;
        }

        .section-label {
            font-family: 'Sora', sans-serif;
            font-size: 0.68rem;
            font-weight: 700;
            color: #AEAAA3;
            text-transform: uppercase;
            letter-spacing: 0.12em;
            margin-bottom: 20px;
            display: block;
        }

        .field-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 16px;
            margin-bottom: 16px;
        }
        .field-group { margin-bottom: 16px; }

        .field-label {
            display: block;
            font-family: 'Sora', sans-serif;
            font-size: 0.68rem;
            font-weight: 700;
            letter-spacing: 0.12em;
            text-transform: uppercase;
            color: #0D1B3E;
            margin-bottom: 7px;
        }

        /* INPUTS */
        .field-input,
        .field-textarea {
            width: 100%;
            padding: 11px 14px;
            border: 1.5px solid #D5D0C8;
            border-radius: 10px;
            font-family: 'DM Sans', sans-serif;
            font-size: 0.93rem;
            color: #0D1B3E;
            background: #fff;
            outline: none;
            transition: border-color 0.2s, box-shadow 0.2s;
            appearance: none;
            -webkit-appearance: none;
        }
        .field-input:focus,
        .field-textarea:focus {
            border-color: #CC0000;
            box-shadow: 0 0 0 3px rgba(204,0,0,0.10);
        }
        .field-input[readonly] {
            background: #F5F4F0;
            color: #AEAAA3;
            cursor: not-allowed;
        }
        .field-textarea {
            resize: vertical;
            min-height: 100px;
        }

        /* SELECT WRAPPER */
        .select-wrapper {
            position: relative;
            width: 100%;
        }
        .select-wrapper::after {
            content: '';
            position: absolute;
            right: 14px;
            top: 50%;
            transform: translateY(-50%);
            width: 0;
            height: 0;
            border-left: 5px solid transparent;
            border-right: 5px solid transparent;
            border-top: 6px solid #AEAAA3;
            pointer-events: none;
        }
        .select-wrapper select {
            width: 100% !important;
            padding: 11px 36px 11px 14px !important;
            border: 1.5px solid #D5D0C8 !important;
            border-radius: 10px !important;
            font-family: 'DM Sans', sans-serif !important;
            font-size: 0.93rem !important;
            color: #0D1B3E !important;
            background: #fff !important;
            outline: none !important;
            appearance: none !important;
            -webkit-appearance: none !important;
            -moz-appearance: none !important;
            cursor: pointer !important;
            display: block !important;
            transition: border-color 0.2s, box-shadow 0.2s !important;
        }
        .select-wrapper select:focus {
            border-color: #CC0000 !important;
            box-shadow: 0 0 0 3px rgba(204,0,0,0.10) !important;
        }

        /* SKILLS CARD */
        .skills-card {
            background: #fff;
            border-radius: 14px;
            border: 1px solid #E0DED8;
            padding: 32px 36px;
            margin-bottom: 28px;
        }

        /* GRID TABLE */
        .grid-wrap {
            border-radius: 10px;
            border: 1px solid #E0DED8;
            overflow: hidden;
            margin-bottom: 24px;
        }
        .grid-wrap table {
            width: 100%;
            border-collapse: collapse;
            font-size: 0.93rem;
        }
        .grid-wrap table th {
            font-family: 'Sora', sans-serif;
            font-size: 0.68rem;
            font-weight: 700;
            letter-spacing: 0.12em;
            text-transform: uppercase;
            color: #AEAAA3;
            background: #F5F4F0;
            padding: 13px 18px;
            text-align: left;
            border-bottom: 1px solid #E0DED8;
        }
        .grid-wrap table td {
            padding: 13px 18px;
            color: #0D1B3E;
            border-bottom: 1px solid #F0EDE8;
            vertical-align: middle;
        }
        .grid-wrap table tr:last-child td { border-bottom: none; }
        .grid-wrap table tr:hover td { background: #FAF9F7; }

        /* ADD SKILL ROW */
        .add-skill-row {
            display: flex;
            flex-wrap: wrap;
            gap: 12px;
            align-items: flex-end;
            padding-top: 20px;
            border-top: 1px solid #E0DED8;
        }
        .add-skill-row .field-group { margin-bottom: 0; flex: 1; min-width: 130px; }
        .add-skill-row .checkbox-group {
            display: flex;
            align-items: center;
            gap: 8px;
            padding-bottom: 6px;
        }
        .add-skill-row .checkbox-group label {
            font-family: 'Sora', sans-serif;
            font-size: 0.82rem;
            font-weight: 600;
            color: #0D1B3E;
            white-space: nowrap;
        }
        .btn-add-skill {
            font-family: 'Sora', sans-serif;
            cursor: pointer;
            border: none;
            font-weight: 700;
            border-radius: 10px;
            background: #0D1B3E;
            color: #fff;
            font-size: 0.88rem;
            padding: 11px 22px;
            transition: background 0.2s;
            white-space: nowrap;
            align-self: flex-end;
        }
        .btn-add-skill:hover { background: #162348; }

        /* ACTION ROW */
        .action-row {
            display: flex;
            gap: 12px;
            align-items: center;
            flex-wrap: wrap;
        }

        /* BUTTONS */
        .btn-primary {
            font-family: 'Sora', sans-serif;
            cursor: pointer;
            border: none;
            font-weight: 700;
            letter-spacing: 0.02em;
            border-radius: 10px;
            background: #CC0000;
            color: #fff;
            font-size: 0.95rem;
            padding: 13px 28px;
            box-shadow: 0 4px 18px rgba(204,0,0,0.22);
            transition: background 0.2s;
            text-decoration: none;
            display: inline-block;
            text-align: center;
        }
        .btn-primary:hover { background: #A80000; }

        .btn-secondary {
            font-family: 'Sora', sans-serif;
            cursor: pointer;
            border: none;
            font-weight: 700;
            letter-spacing: 0.02em;
            border-radius: 10px;
            background: #0D1B3E;
            color: #fff;
            font-size: 0.95rem;
            padding: 13px 28px;
            transition: background 0.2s;
            text-decoration: none;
            display: inline-block;
            text-align: center;
        }
        .btn-secondary:hover { background: #162348; }

        .btn-ghost {
            font-family: 'Sora', sans-serif;
            cursor: pointer;
            font-weight: 700;
            letter-spacing: 0.02em;
            border-radius: 10px;
            background: #fff;
            color: #0D1B3E;
            font-size: 0.95rem;
            padding: 12px 28px;
            border: 1.5px solid #E0DED8;
            transition: border-color 0.2s;
            text-decoration: none;
            display: inline-block;
            text-align: center;
        }
        .btn-ghost:hover { border-color: #0D1B3E; }
    </style>
</head>
<body>
<form id="form1" runat="server">

    <!-- NAV -->
    <div class="nav">
        <div class="nav-brand">
            <img src='../Images/PairEdLogo.png' alt="PairEd Logo" class="nav-logo" />
            <span class="nav-site-name">Pair<span>Ed</span></span>
        </div>
        <span class="nav-tag">Student Skill-Sharing Platform</span>
    </div>

    <div class="page-body">

        <!-- PAGE HEADER -->
        <div class="page-header">
            <div class="page-header-accent"></div>
            <h2>My Profile</h2>
        </div>

        <div class="divider"></div>

        <!-- MESSAGE -->
        <asp:Label ID="lblMessage" runat="server" CssClass="msg-text" Text="" Visible="false" />

        <!-- PROFILE PICTURE + BASIC INFO -->
        <div class="profile-grid">

            <!-- LEFT: Profile Picture -->
            <div class="pic-card">
                <asp:Image ID="imgProfile" runat="server"
                    Width="110px" Height="110px"
                    AlternateText="Profile Picture"
                    style="border-radius:50%; object-fit:cover; border:3px solid #E0DED8;" />
                <span class="pic-upload-label">Profile Picture</span>
                <asp:FileUpload ID="fuProfilePic" runat="server" />
                <asp:Button ID="btnUploadPic" runat="server" Text="Upload Picture"
                    OnClick="UploadProfilePic" CssClass="btn-upload" />
            </div>

            <!-- RIGHT: Info Fields -->
            <div class="info-card">
                <span class="section-label">Basic Information</span>

                <div class="field-row">
                    <div class="field-group">
                        <asp:Label ID="lblFirstName" runat="server" Text="First Name" CssClass="field-label" />
                        <asp:TextBox ID="txtFirstName" runat="server" CssClass="field-input" />
                    </div>
                    <div class="field-group">
                        <asp:Label ID="lblLastName" runat="server" Text="Last Name" CssClass="field-label" />
                        <asp:TextBox ID="txtLastName" runat="server" CssClass="field-input" />
                    </div>
                </div>

                <div class="field-row">
                    <div class="field-group">
                        <asp:Label ID="lblEmail" runat="server" Text="Email" CssClass="field-label" />
                        <asp:TextBox ID="txtEmail" runat="server" ReadOnly="true" CssClass="field-input" />
                    </div>
                    <div class="field-group">
                        <asp:Label ID="lblProgram" runat="server" Text="Program" CssClass="field-label" />
                        <asp:TextBox ID="txtProgram" runat="server" CssClass="field-input" />
                    </div>
                </div>

                <div class="field-row">
                    <div class="field-group">
                        <asp:Label ID="lblYearLevel" runat="server" Text="Year Level" CssClass="field-label" />
                        <div class="select-wrapper">
                            <asp:DropDownList ID="ddlYearLevel" runat="server">
                                <asp:ListItem Text="1" Value="1" />
                                <asp:ListItem Text="2" Value="2" />
                                <asp:ListItem Text="3" Value="3" />
                                <asp:ListItem Text="4" Value="4" />
                            </asp:DropDownList>
                        </div>
                    </div>
                </div>

                <div class="field-group">
                    <asp:Label ID="lblBio" runat="server" Text="Bio" CssClass="field-label" />
                    <asp:TextBox ID="txtBio" runat="server" TextMode="MultiLine" Rows="4"
                        CssClass="field-textarea" />
                </div>
            </div>
        </div>

        <!-- SKILLS SECTION -->
        <div class="skills-card">
            <span class="section-label">My Skills</span>

            <div class="grid-wrap">
                <asp:GridView ID="gvUserSkills" runat="server"
                    AutoGenerateColumns="False"
                    DataKeyNames="UserSkillID"
                    OnRowEditing="EditSkill"
                    OnRowUpdating="UpdateSkill"
                    OnRowCancelingEdit="CancelEdit"
                    OnRowDeleting="DeleteSkill"
                    GridLines="None">
                    <Columns>
                        <asp:BoundField DataField="UserSkillID"      HeaderText="ID"                  ReadOnly="true" Visible="false" />
                        <asp:BoundField DataField="SkillName"        HeaderText="Skill"               ReadOnly="true" />
                        <asp:BoundField DataField="ProficiencyLevel" HeaderText="Proficiency" />
                        <asp:BoundField DataField="YearsExperience"  HeaderText="Years of Experience" />
                        <asp:CheckBoxField DataField="CanTutor"      HeaderText="Tutor Availability" />
                        <asp:CommandField ShowEditButton="true" ShowDeleteButton="true" />
                    </Columns>
                </asp:GridView>
            </div>

            <!-- ADD SKILL -->
            <div class="add-skill-row">
                <div class="field-group">
                    <label class="field-label">Skill</label>
                    <div class="select-wrapper">
                        <asp:DropDownList ID="ddlAvailableSkills" runat="server" />
                    </div>
                </div>
                <div class="field-group">
                    <label class="field-label">Proficiency</label>
                    <div class="select-wrapper">
                        <asp:DropDownList ID="ddlProficiency" runat="server">
                            <asp:ListItem Text="Beginner"     Value="Beginner" />
                            <asp:ListItem Text="Intermediate" Value="Intermediate" />
                            <asp:ListItem Text="Advanced"     Value="Advanced" />
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="field-group">
                    <label class="field-label">Years of Experience</label>
                    <asp:TextBox ID="txtYearsExperience" runat="server"
                        CssClass="field-input" placeholder="e.g. 2" />
                </div>
                <div class="checkbox-group">
                    <asp:CheckBox ID="chkCanTutor" runat="server" />
                    <label>Can Tutor?</label>
                </div>
                <asp:Button ID="btnAddSkill" runat="server" Text="+ Add Skill"
                    OnClick="AddSkill" CssClass="btn-add-skill" />
            </div>
        </div>

        <!-- ACTION BUTTONS -->
        <div class="action-row">
            <asp:Button ID="btnEditProfile" runat="server" Text="Edit Profile"
                OnClick="EditProfile" CssClass="btn-secondary" />
            <asp:Button ID="btnSave" runat="server" Text="Save Changes"
                OnClick="SaveProfile" CssClass="btn-primary" Visible="false" />
            <asp:Button ID="btnCancelEdit" runat="server" Text="Cancel"
                OnClick="CancelProfileEdit" CssClass="btn-ghost" Visible="false" />
            <asp:Button ID="btnBack" runat="server" Text="← Back"
                PostBackUrl="~/Pages/Default.aspx" CssClass="btn-ghost" />
            <asp:HyperLink ID="lnkLogout" runat="server"
                NavigateUrl="~/Pages/Logout.aspx"
                Text="Logout"
                CssClass="btn-secondary" />
        </div>

    </div>

</form>
</body>
</html>