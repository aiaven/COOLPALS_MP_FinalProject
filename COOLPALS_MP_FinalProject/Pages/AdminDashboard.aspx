<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="COOLPALS_MP_FinalProject.AdminDashboard" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>PairEd - Admin Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 30px;
            background: #f7f7f7;
        }

        h1 {
            text-align: center;
            margin-bottom: 10px;
        }

        .message {
            color: green;
            font-weight: bold;
            margin-bottom: 15px;
        }

        .error {
            color: red;
            font-weight: bold;
            margin-bottom: 15px;
        }

        .tabs {
            margin: 20px 0;
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .tab-btn {
            padding: 10px 18px;
            border: none;
            background: #0D1B3E;
            color: white;
            cursor: pointer;
            border-radius: 6px;
            font-weight: bold;
        }

        .tab-btn:hover {
            background: #162348;
        }

        .section {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 1px 6px rgba(0,0,0,0.08);
            margin-bottom: 20px;
        }

        h2 {
            margin-top: 0;
        }

        .form-row {
            margin-bottom: 10px;
        }

        .form-row label {
            display: inline-block;
            width: 140px;
            font-weight: bold;
        }

        .grid {
            margin-top: 15px;
        }

        .top-actions {
            margin-top: 20px;
        }

        .tab-btn-link {
            padding: 10px 18px;
            border: none;
            background: #0D1B3E;
            color: white;
            cursor: pointer;
            border-radius: 6px;
            font-weight: bold;
            text-decoration: none;
            display: inline-block;
        }

        .tab-btn-link:hover {
            background: #162348;
        }
    </style>
</head>
<body>
<form id="form1" runat="server">

    <h1>Admin Dashboard</h1>
    <hr />

    <asp:Label ID="lblMessage" runat="server"></asp:Label>

    <div class="tabs">
        <asp:Button ID="btnUsersTab" runat="server" Text="Users" CssClass="tab-btn" OnClick="ShowUsersTab" />
        <asp:Button ID="btnCategoriesTab" runat="server" Text="Categories" CssClass="tab-btn" OnClick="ShowCategoriesTab" />

        <asp:HyperLink ID="lnkSkillsPage" runat="server"
            NavigateUrl="~/Pages/ManageSkills.aspx"
            CssClass="tab-btn-link"
            Text="Skills" />

        <asp:Button ID="btnRequestsTab" runat="server" Text="Requests" CssClass="tab-btn" OnClick="ShowRequestsTab" />
    </div>

    <asp:Panel ID="pnlUsers" runat="server" CssClass="section" Visible="false">
        <h2>Manage Users</h2>
        <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="False"
            DataKeyNames="UserID"
            OnRowEditing="gvUsers_RowEditing"
            OnRowUpdating="gvUsers_RowUpdating"
            OnRowDeleting="gvUsers_RowDeleting"
            OnRowCancelingEdit="gvUsers_RowCancelingEdit"
            CssClass="grid">
            <Columns>
                <asp:BoundField DataField="UserID" HeaderText="ID" ReadOnly="True" />
                <asp:BoundField DataField="FirstName" HeaderText="First Name" />
                <asp:BoundField DataField="LastName" HeaderText="Last Name" />
                <asp:BoundField DataField="Email" HeaderText="Email" />
                <asp:BoundField DataField="Role" HeaderText="Role" />
                <asp:CheckBoxField DataField="IsActive" HeaderText="Active" />
                <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" />
            </Columns>
        </asp:GridView>
    </asp:Panel>

    <asp:Panel ID="pnlCategories" runat="server" CssClass="section" Visible="false">
        <h2>Manage Categories</h2>

        <div class="form-row">
            <label>Category Name:</label>
            <asp:TextBox ID="txtCategoryName" runat="server"></asp:TextBox>
        </div>

        <div class="form-row">
            <label>Description:</label>
            <asp:TextBox ID="txtCategoryDescription" runat="server"></asp:TextBox>
        </div>

        <div class="form-row">
            <asp:Button ID="btnAddCategory" runat="server" Text="Add Category" OnClick="btnAddCategory_Click" />
        </div>

        <asp:GridView ID="gvCategories" runat="server" AutoGenerateColumns="False"
            DataKeyNames="CategoryID"
            OnRowEditing="gvCategories_RowEditing"
            OnRowUpdating="gvCategories_RowUpdating"
            OnRowDeleting="gvCategories_RowDeleting"
            OnRowCancelingEdit="gvCategories_RowCancelingEdit"
            CssClass="grid">
            <Columns>
                <asp:BoundField DataField="CategoryID" HeaderText="ID" ReadOnly="True" />
                <asp:BoundField DataField="CategoryName" HeaderText="Category Name" />
                <asp:BoundField DataField="Description" HeaderText="Description" />
                <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" />
            </Columns>
        </asp:GridView>
    </asp:Panel>

    

    <asp:Panel ID="pnlRequests" runat="server" CssClass="section" Visible="false">
        <h2>Manage Requests</h2>

        <asp:GridView ID="gvRequests" runat="server" AutoGenerateColumns="False"
            DataKeyNames="RequestID"
            OnRowEditing="gvRequests_RowEditing"
            OnRowUpdating="gvRequests_RowUpdating"
            OnRowDeleting="gvRequests_RowDeleting"
            OnRowCancelingEdit="gvRequests_RowCancelingEdit"
            CssClass="grid">
            <Columns>
                <asp:BoundField DataField="RequestID" HeaderText="ID" ReadOnly="True" />
                <asp:BoundField DataField="Learner" HeaderText="Learner" ReadOnly="True" />
                <asp:BoundField DataField="Tutor" HeaderText="Tutor" ReadOnly="True" />
                <asp:BoundField DataField="Skill" HeaderText="Skill" ReadOnly="True" />
                <asp:BoundField DataField="Status" HeaderText="Status" />
                <asp:BoundField DataField="RequestDate" HeaderText="Request Date" ReadOnly="True" DataFormatString="{0:yyyy-MM-dd HH:mm}" />
                <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" />
            </Columns>
        </asp:GridView>
    </asp:Panel>

    <div class="top-actions">
        <asp:HyperLink ID="lnkLogout" runat="server" NavigateUrl="~/Pages/Logout.aspx" Text="Logout" />
    </div>

</form>
</body>
</html>