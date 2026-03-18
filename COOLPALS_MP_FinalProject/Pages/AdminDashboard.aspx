<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="COOLPALS_MP_FinalProject.AdminDashboard" %>
<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>PairEd - Admin Dashboard</title>
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
        .page-header h1 {
            font-family: 'Sora', sans-serif;
            font-weight: 800;
            font-size: 2rem;
            color: #0D1B3E;
            letter-spacing: -0.5px;
        }

        .divider {
            height: 1px;
            background: #E0DED8;
            margin-bottom: 32px;
        }

        /* MESSAGE */
        .msg-success {
            font-family: 'Sora', sans-serif;
            font-size: 0.88rem;
            font-weight: 600;
            color: #1a7a3c;
            background: rgba(26,122,60,0.08);
            border: 1px solid rgba(26,122,60,0.22);
            border-radius: 10px;
            padding: 12px 18px;
            display: block;
            margin-bottom: 24px;
            line-height: 1.55;
        }
        .msg-error {
            font-family: 'Sora', sans-serif;
            font-size: 0.88rem;
            font-weight: 600;
            color: #CC0000;
            background: rgba(204,0,0,0.08);
            border: 1px solid rgba(204,0,0,0.22);
            border-radius: 10px;
            padding: 12px 18px;
            display: block;
            margin-bottom: 24px;
            line-height: 1.55;
        }

        /* TAB BUTTONS */
        .tabs {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            margin-bottom: 32px;
        }
        .tab-btn {
            font-family: 'Sora', sans-serif;
            font-weight: 700;
            font-size: 0.88rem;
            padding: 11px 24px;
            border: none;
            border-radius: 10px;
            background: #0D1B3E;
            color: #fff;
            cursor: pointer;
            letter-spacing: 0.02em;
            transition: background 0.2s;
            text-decoration: none;
            display: inline-block;
        }
        .tab-btn:hover { background: #162348; }
        .tab-btn-link {
            font-family: 'Sora', sans-serif;
            font-weight: 700;
            font-size: 0.88rem;
            padding: 11px 24px;
            border: none;
            border-radius: 10px;
            background: #0D1B3E;
            color: #fff;
            cursor: pointer;
            letter-spacing: 0.02em;
            transition: background 0.2s;
            text-decoration: none;
            display: inline-block;
        }
        .tab-btn-link:hover { background: #162348; }

        /* SECTION CARD */
        .section-card {
            background: #fff;
            border-radius: 14px;
            border: 1px solid #E0DED8;
            padding: 32px 36px;
            margin-bottom: 28px;
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
        .section-card h2 {
            font-family: 'Sora', sans-serif;
            font-weight: 700;
            font-size: 1.25rem;
            color: #0D1B3E;
            letter-spacing: -0.3px;
            margin-bottom: 24px;
        }

        /* FORM ROW */
        .form-row { margin-bottom: 16px; }
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
        .field-input {
            width: 100%;
            max-width: 400px;
            padding: 11px 14px;
            border: 1.5px solid #D5D0C8;
            border-radius: 10px;
            font-family: 'DM Sans', sans-serif;
            font-size: 0.93rem;
            color: #0D1B3E;
            background: #fff;
            outline: none;
            transition: border-color 0.2s, box-shadow 0.2s;
        }
        .field-input:focus {
            border-color: #CC0000;
            box-shadow: 0 0 0 3px rgba(204,0,0,0.10);
        }

        /* ADD BUTTON */
        .btn-add {
            font-family: 'Sora', sans-serif;
            cursor: pointer;
            border: none;
            font-weight: 700;
            border-radius: 10px;
            background: #CC0000;
            color: #fff;
            font-size: 0.88rem;
            padding: 11px 24px;
            box-shadow: 0 4px 18px rgba(204,0,0,0.22);
            transition: background 0.2s;
        }
        .btn-add:hover { background: #A80000; }

        /* GRID TABLE */
        .grid-wrap {
            border-radius: 10px;
            border: 1px solid #E0DED8;
            overflow: hidden;
            margin-top: 24px;
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

        /* LOGOUT BUTTON */
        .btn-logout {
            font-family: 'Sora', sans-serif;
            cursor: pointer;
            border: none;
            font-weight: 700;
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
        .btn-logout:hover { background: #A80000; }
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
        <span class="nav-tag">Admin Dashboard</span>
    </div>

    <div class="page-body">

        <!-- PAGE HEADER -->
        <div class="page-header">
            <div class="page-header-accent"></div>
            <h1>Admin Dashboard</h1>
        </div>

        <div class="divider"></div>

        <!-- MESSAGE -->
        <asp:Label ID="lblMessage" runat="server" CssClass="msg-success" Visible="false" />

        <!-- TABS -->
        <div class="tabs">
            <asp:Button ID="btnUsersTab"      runat="server" Text="👤 Users"      CssClass="tab-btn" OnClick="ShowUsersTab" />
            <asp:Button ID="btnCategoriesTab" runat="server" Text="🗂 Categories" CssClass="tab-btn" OnClick="ShowCategoriesTab" />
            <asp:HyperLink ID="lnkSkillsPage" runat="server"
                NavigateUrl="~/Pages/ManageSkills.aspx"
                CssClass="tab-btn-link"
                Text="🎯 Skills" />
            <asp:Button ID="btnRequestsTab"   runat="server" Text="📋 Requests"   CssClass="tab-btn" OnClick="ShowRequestsTab" />
        </div>

        <!-- USERS PANEL -->
        <asp:Panel ID="pnlUsers" runat="server" CssClass="section-card" Visible="false">
            <span class="section-label">User Management</span>
            <h2>Manage Users</h2>
            <div class="grid-wrap">
                <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="False"
                    DataKeyNames="UserID"
                    OnRowEditing="gvUsers_RowEditing"
                    OnRowUpdating="gvUsers_RowUpdating"
                    OnRowDeleting="gvUsers_RowDeleting"
                    OnRowCancelingEdit="gvUsers_RowCancelingEdit"
                    GridLines="None">
                    <Columns>
                        <asp:BoundField DataField="UserID"    HeaderText="ID"         ReadOnly="True" />
                        <asp:BoundField DataField="FirstName" HeaderText="First Name" />
                        <asp:BoundField DataField="LastName"  HeaderText="Last Name" />
                        <asp:BoundField DataField="Email"     HeaderText="Email" />
                        <asp:BoundField DataField="Role"      HeaderText="Role" />
                        <asp:CheckBoxField DataField="IsActive" HeaderText="Active" />
                        <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" />
                    </Columns>
                </asp:GridView>
            </div>
        </asp:Panel>

        <!-- CATEGORIES PANEL -->
        <asp:Panel ID="pnlCategories" runat="server" CssClass="section-card" Visible="false">
            <span class="section-label">Category Management</span>
            <h2>Manage Categories</h2>

            <div class="form-row">
                <label class="field-label">Category Name</label>
                <asp:TextBox ID="txtCategoryName" runat="server" CssClass="field-input" />
            </div>
            <div class="form-row">
                <label class="field-label">Description</label>
                <asp:TextBox ID="txtCategoryDescription" runat="server" CssClass="field-input" />
            </div>
            <div class="form-row">
                <asp:Button ID="btnAddCategory" runat="server" Text="+ Add Category"
                    OnClick="btnAddCategory_Click" CssClass="btn-add" />
            </div>

            <div class="grid-wrap">
                <asp:GridView ID="gvCategories" runat="server" AutoGenerateColumns="False"
                    DataKeyNames="CategoryID"
                    OnRowEditing="gvCategories_RowEditing"
                    OnRowUpdating="gvCategories_RowUpdating"
                    OnRowDeleting="gvCategories_RowDeleting"
                    OnRowCancelingEdit="gvCategories_RowCancelingEdit"
                    GridLines="None">
                    <Columns>
                        <asp:BoundField DataField="CategoryID"   HeaderText="ID"            ReadOnly="True" />
                        <asp:BoundField DataField="CategoryName" HeaderText="Category Name" />
                        <asp:BoundField DataField="Description"  HeaderText="Description" />
                        <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" />
                    </Columns>
                </asp:GridView>
            </div>
        </asp:Panel>

        <!-- REQUESTS PANEL -->
        <asp:Panel ID="pnlRequests" runat="server" CssClass="section-card" Visible="false">
            <span class="section-label">Request Management</span>
            <h2>Manage Requests</h2>
            <div class="grid-wrap">
                <asp:GridView ID="gvRequests" runat="server" AutoGenerateColumns="False"
                    DataKeyNames="RequestID"
                    OnRowEditing="gvRequests_RowEditing"
                    OnRowUpdating="gvRequests_RowUpdating"
                    OnRowDeleting="gvRequests_RowDeleting"
                    OnRowCancelingEdit="gvRequests_RowCancelingEdit"
                    GridLines="None">
                    <Columns>
                        <asp:BoundField DataField="RequestID"   HeaderText="ID"           ReadOnly="True" />
                        <asp:BoundField DataField="Learner"     HeaderText="Learner"       ReadOnly="True" />
                        <asp:BoundField DataField="Tutor"       HeaderText="Tutor"         ReadOnly="True" />
                        <asp:BoundField DataField="Skill"       HeaderText="Skill"         ReadOnly="True" />
                        <asp:BoundField DataField="Status"      HeaderText="Status" />
                        <asp:BoundField DataField="RequestDate" HeaderText="Request Date"  ReadOnly="True" DataFormatString="{0:yyyy-MM-dd HH:mm}" />
                        <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" />
                    </Columns>
                </asp:GridView>
            </div>
        </asp:Panel>

        <!-- LOGOUT -->
        <asp:HyperLink ID="lnkLogout" runat="server"
            NavigateUrl="~/Pages/Logout.aspx"
            Text="Logout"
            CssClass="btn-logout" />

    </div>

</form>
</body>
</html>