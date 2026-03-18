<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageSkills.aspx.cs" Inherits="COOLPALS_MP_FinalProject.ManageSkills" %>
<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>PairEd - Manage Skills</title>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="https://fonts.googleapis.com/css2?family=Sora:wght@300;400;600;700;800&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet" />
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        html, body {
            height: 100%;
            font-family: 'DM Sans', sans-serif;
            background: #0D1B3E;
            color: #0D1B3E;
        }

        .nav {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 72px;
            height: 78px;
            background: #0D1B3E;
            border-bottom: 1px solid rgba(255,255,255,0.07);
        }
        .nav-brand {
            display: flex;
            align-items: center;
            gap: 16px;
        }
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

        .page-body {
            min-height: calc(100vh - 78px);
            background: #F5F4F0;
            padding: 52px 72px;
        }

        .page-header { margin-bottom: 36px; }
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
            margin-bottom: 6px;
        }
        .page-header p {
            font-size: 0.95rem;
            color: #8A8A8A;
            line-height: 1.65;
        }

        .divider {
            height: 1px;
            background: #E0DED8;
            margin-bottom: 32px;
        }

        .search-bar {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 24px;
            flex-wrap: wrap;
        }
        .search-label {
            font-family: 'Sora', sans-serif;
            font-size: 0.75rem;
            font-weight: 700;
            letter-spacing: 0.12em;
            text-transform: uppercase;
            color: #0D1B3E;
            white-space: nowrap;
        }
        .search-input, .form-input, .form-dropdown, .form-textarea {
            padding: 11px 16px;
            border: 1.5px solid #D5D0C8;
            border-radius: 10px;
            font-family: 'DM Sans', sans-serif;
            font-size: 0.95rem;
            color: #0D1B3E;
            background: #fff;
            outline: none;
            transition: border-color 0.2s, box-shadow 0.2s;
        }
        .search-input:focus, .form-input:focus, .form-dropdown:focus, .form-textarea:focus {
            border-color: #CC0000;
            box-shadow: 0 0 0 3px rgba(204,0,0,0.10);
        }
        .search-input { width: 260px; }
        .form-textarea { width: 100%; min-height: 90px; resize: vertical; }

        .btn-search, .btn-action {
            font-family: 'Sora', sans-serif;
            cursor: pointer;
            border: none;
            font-weight: 700;
            letter-spacing: 0.02em;
            border-radius: 10px;
            color: #fff;
            font-size: 0.92rem;
            padding: 11px 24px;
            white-space: nowrap;
        }
        .btn-search { background: #0D1B3E; }
        .btn-search:hover { background: #162348; }

        .btn-save { background: #CC0000; }
        .btn-save:hover { background: #A80000; }

        .btn-cancel { background: #777; }
        .btn-cancel:hover { background: #666; }

        .btn-grid {
            background: #0D1B3E;
            color: #fff;
            border: none;
            border-radius: 8px;
            padding: 8px 14px;
            cursor: pointer;
            font-family: 'Sora', sans-serif;
            font-size: 0.82rem;
            font-weight: 700;
            margin-right: 6px;
        }
        .btn-grid:hover { background: #162348; }

        .btn-delete {
            background: #CC0000;
        }
        .btn-delete:hover {
            background: #A80000;
        }

        .section-label {
            font-family: 'Sora', sans-serif;
            font-size: 0.72rem;
            font-weight: 700;
            color: #AEAAA3;
            text-transform: uppercase;
            letter-spacing: 0.12em;
            margin-bottom: 14px;
            display: block;
        }

        .form-card, .grid-wrap {
            background: #fff;
            border-radius: 14px;
            border: 1px solid #E0DED8;
            overflow: hidden;
            margin-bottom: 36px;
        }

        .form-card {
            padding: 24px;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 16px;
            margin-bottom: 16px;
        }

        .form-field {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .full-width {
            grid-column: 1 / -1;
        }

        .grid-wrap table {
            width: 100%;
            border-collapse: collapse;
            font-size: 0.93rem;
        }
        .grid-wrap table th {
            font-family: 'Sora', sans-serif;
            font-size: 0.70rem;
            font-weight: 700;
            letter-spacing: 0.12em;
            text-transform: uppercase;
            color: #AEAAA3;
            background: #F5F4F0;
            padding: 14px 20px;
            text-align: left;
            border-bottom: 1px solid #E0DED8;
        }
        .grid-wrap table td {
            padding: 14px 20px;
            color: #0D1B3E;
            border-bottom: 1px solid #F0EDE8;
            vertical-align: middle;
        }

        .nav-buttons {
            display: flex;
            gap: 12px;
        }
        .btn-primary, .btn-secondary {
            font-family: 'Sora', sans-serif;
            cursor: pointer;
            border: none;
            font-weight: 700;
            letter-spacing: 0.02em;
            border-radius: 10px;
            color: #fff;
            font-size: 0.95rem;
            padding: 13px 28px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            transition: background 0.2s;
        }
        .btn-primary {
            background: #CC0000;
            box-shadow: 0 4px 18px rgba(204,0,0,0.22);
        }
        .btn-primary:hover { background: #A80000; }

        .btn-secondary {
            background: #0D1B3E;
        }
        .btn-secondary:hover { background: #162348; }

        .status-message {
            display: block;
            margin-bottom: 18px;
            font-size: 0.95rem;
            font-weight: 600;
        }
    </style>
</head>
<body>
<form id="form1" runat="server">

    <div class="nav">
        <div class="nav-brand">
            <img src='../Images/PairEdLogo.png' alt="PairEd Logo" class="nav-logo" />
            <span class="nav-site-name">Pair<span>Ed</span></span>
        </div>
        <span class="nav-tag">Student Skill-Sharing Platform</span>
    </div>

    <div class="page-body">

        <div class="page-header">
            <div class="page-header-accent"></div>
            <h2>Manage Skills</h2>
            <p>Browse and manage the available skills catalog below.</p>
        </div>

        <div class="divider"></div>

        <asp:Label ID="lblMessage" runat="server" CssClass="status-message" />

        <asp:Panel ID="pnlAdminForm" runat="server" Visible="false">
            <span class="section-label">Skill Form</span>
            <div class="form-card">
                <asp:HiddenField ID="hfSkillID" runat="server" />

                <div class="form-grid">
                    <div class="form-field">
                        <label>Skill Name</label>
                        <asp:TextBox ID="txtSkillName" runat="server" CssClass="form-input" />
                    </div>

                    <div class="form-field">
                        <label>Category</label>
                        <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-dropdown" />
                    </div>

                    <div class="form-field full-width">
                        <label>Description</label>
                        <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" CssClass="form-textarea" />
                    </div>
                </div>

                <div class="nav-buttons">
                    <asp:Button ID="btnSaveSkill" runat="server" Text="Save Skill" CssClass="btn-action btn-save" OnClick="btnSaveSkill_Click" />
                    <asp:Button ID="btnCancelEdit" runat="server" Text="Cancel" CssClass="btn-action btn-cancel" OnClick="btnCancelEdit_Click" CausesValidation="false" />
                </div>
            </div>
        </asp:Panel>

        <div class="search-bar">
            <asp:Label ID="lblSearch" runat="server" Text="Search Skills:" CssClass="search-label" />
            <asp:TextBox ID="txtSearch" runat="server" CssClass="search-input" placeholder="e.g. Mathematics, Guitar..." />
            <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="SearchSkills" CssClass="btn-search" />
            <asp:Button ID="btnShowAddNew" runat="server" Text="Add New Skill" CssClass="btn-action btn-save" OnClick="btnShowAddNew_Click" Visible="false" />
        </div>

        <span class="section-label">Available Skills Catalog</span>
        <div class="grid-wrap">
            <asp:GridView ID="gvSkills" runat="server"
                AutoGenerateColumns="False"
                DataKeyNames="SkillID"
                OnRowCommand="gvSkills_RowCommand"
                GridLines="None">
                <Columns>
                    <asp:BoundField DataField="SkillName" HeaderText="Skill" />
                    <asp:BoundField DataField="CategoryName" HeaderText="Category" />
                    <asp:BoundField DataField="Description" HeaderText="Description" />

                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:Button ID="btnEdit" runat="server"
                                Text="Edit"
                                CommandName="EditSkill"
                                CommandArgument='<%# Eval("SkillID") %>'
                                CssClass="btn-grid"
                                Visible='<%# Session["Role"] != null && Session["Role"].ToString() == "Admin" %>' />

                            <asp:Button ID="btnDelete" runat="server"
                                Text="Delete"
                                CommandName="DeleteSkill"
                                CommandArgument='<%# Eval("SkillID") %>'
                                CssClass="btn-grid btn-delete"
                                OnClientClick="return confirm('Are you sure you want to delete this skill?');"
                                Visible='<%# Session["Role"] != null && Session["Role"].ToString() == "Admin" %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>

        <div class="nav-buttons">
            <asp:HyperLink ID="lnkBackProfile" runat="server"
                NavigateUrl="~/Pages/Profile.aspx"
                Text="← Back to My Profile"
                CssClass="btn-secondary" />
            <asp:HyperLink ID="lnkLogout" runat="server"
                NavigateUrl="~/Pages/Logout.aspx"
                Text="Logout"
                CssClass="btn-primary" />
        </div>

    </div>

</form>
</body>
</html>