<%@ Page Title="Admin" Language="C#" MasterPageFile="~/KeyRush/Pages/MasterPage.master" AutoEventWireup="true" CodeFile="admin.aspx.cs" Inherits="pages_admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" />
    <link href="../Styles/General.css" rel="stylesheet" />
    <link href="../Styles/Admin.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="page-content">

    <h1>Admin Dashboard</h1>

    <div class="card-dark">
        <form runat="server">
            <div style="display:flex; flex-wrap:wrap; gap:1rem; align-items:flex-end; margin-bottom:1.5rem;">
                <div>
                    <label style="display:block; margin-bottom:0.3rem;">Search by username</label>
                    <input type="text" id="searchName" name="searchName" placeholder="Username…" />
                </div>
                <input type="button" value="Search" runat="server" id="btnSearch" name="btnSearch" onserverclick="ClickSearch" class="btn-accent" />
            </div>

            <div style="display:flex; flex-wrap:wrap; gap:1rem; align-items:center; margin-bottom:1.5rem;">
                <div>
                    <label style="display:block; margin-bottom:0.3rem;">Sort by column</label>
                    <select id="columns" name="columns" runat="server">
                        <option value="empty">Pick a column</option>
                        <option value="username">Username</option>
                        <option value="email">Email</option>
                        <option value="birthDate">Birthdate</option>
                    </select>
                </div>
                <div style="display:flex; align-items:center; gap:0.5rem; padding-top:1.2rem;">
                    <input type="radio" id="ASC" value="ASC" checked runat="server" /><label for="ASC">ASC</label>
                    <input type="radio" id="DESC" value="DESC" runat="server" /><label for="DESC">DESC</label>
                </div>
                <div style="padding-top:1.2rem; display:flex; gap:0.75rem;">
                    <input type="button" value="Sort" runat="server" id="btnSort" name="btnSort" onserverclick="ClickSort" class="btn-accent" />
                    <input type="button" value="Delete Selected" id="delete" name="delete" runat="server" onserverclick="DeleteUsers" class="btn-secondary-dark" style="border-color:#f87171; color:#f87171;" />
                </div>
            </div>

            <div class="table-scroll-wrapper">
                <div id="showUsersTable" runat="server"></div>
            </div>
        </form>
    </div>

</div>
</asp:Content>
