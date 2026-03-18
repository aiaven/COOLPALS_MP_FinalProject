<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="COOLPALS_MP_FinalProject.AdminDashboard" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <%--TESTING--%>
    <title>Admin Dashboard</title>
<style>
        body {
            font-family: Arial, sans-serif;
            margin: 30px;
        }

        h1 {
            text-align: center;
        }

        h2 {
            margin-top: 30px;
        }

        .section {
            margin-bottom: 35px;
        }

        .form-row {
            margin-bottom: 10px;
        }

        .form-row label {
            display: inline-block;
            width: 140px;
            font-weight: bold;
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

        table, .aspNetDisabled {
            margin-top: 10px;
        }

        .grid {
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">

        <h1>Admin Dashboard</h1>
        <hr />

        <asp:Label ID="lblMessage" runat="server"></asp:Label>

        <!-- MANAGE USERS -->
        <div class="section">
            <h2>Manage Users</h2>
            <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="False" DataKeyNames="UserID"
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
        </div>

        <!-- MANAGE CATEGORIES -->
        <div class="section">
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

            <asp:GridView ID="gvCategories" runat="server" AutoGenerateColumns="False" DataKeyNames="CategoryID"
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
        </div>

        <!-- MANAGE SKILLS -->
        <div class="section">
            <h2>Manage Skills</h2>

            <div class="form-row">
                <label>Skill Name:</label>
                <asp:TextBox ID="txtSkillName" runat="server"></asp:TextBox>
            </div>
            <div class="form-row">
                <label>Category:</label>
                <asp:DropDownList ID="ddlSkillCategory" runat="server"></asp:DropDownList>
            </div>
            <div class="form-row">
                <label>Description:</label>
                <asp:TextBox ID="txtSkillDescription" runat="server"></asp:TextBox>
            </div>
            <div class="form-row">
                <asp:Button ID="btnAddSkill" runat="server" Text="Add Skill" OnClick="btnAddSkill_Click" />
            </div>

            <asp:GridView ID="gvSkills" runat="server" AutoGenerateColumns="False" DataKeyNames="SkillID"
                OnRowEditing="gvSkills_RowEditing"
                OnRowUpdating="gvSkills_RowUpdating"
                OnRowDeleting="gvSkills_RowDeleting"
                OnRowCancelingEdit="gvSkills_RowCancelingEdit"
                CssClass="grid">
                <Columns>
                    <asp:BoundField DataField="SkillID" HeaderText="ID" ReadOnly="True" />
                    <asp:BoundField DataField="SkillName" HeaderText="Skill Name" />
                    <asp:BoundField DataField="CategoryName" HeaderText="Category" ReadOnly="True" />
                    <asp:BoundField DataField="Description" HeaderText="Description" />
                    <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" />
                </Columns>
            </asp:GridView>
        </div>

        <!-- MANAGE REQUESTS -->
        <div class="section">
            <h2>Manage Requests</h2>

            <asp:GridView ID="gvRequests" runat="server" AutoGenerateColumns="False" DataKeyNames="RequestID"
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
        </div>

        <asp:HyperLink ID="lnkLogout" runat="server" NavigateUrl="~/Pages/Logout.aspx" Text="Logout" />

    </form>
</body>
</html>
