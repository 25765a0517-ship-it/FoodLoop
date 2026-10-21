<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpServletResponse" %>

<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp?unauthorized=1");
        return;
    }

    if (!"ADMIN".equalsIgnoreCase(String.valueOf(session.getAttribute("role")))) {
        response.sendError(HttpServletResponse.SC_FORBIDDEN, "Admin access required.");
        return;
    }

    String adminName = String.valueOf(session.getAttribute("fullName"));
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Users | FoodLoop</title>
    <link rel="stylesheet" href="../css/admin.css">
</head>
<body>

<div class="admin-layout">

    <aside class="sidebar">
        <a href="dashboard.jsp" class="brand">Food<span>Loop</span></a>
        <p class="sidebar-label">Administration</p>

        <button type="button" id="mobileMenuButton"
                class="mobile-menu-button"
                aria-expanded="false"
                aria-controls="sidebarNav">☰ Menu</button>

        <nav class="sidebar-nav open" id="sidebarNav">
            <a href="dashboard.jsp">▦ Dashboard</a>
            <a class="active" href="manage-users.jsp">♙ Manage Users</a>
            <a href="manage-donations.jsp">♧ Manage Donations</a>
            <a href="manage-requests.jsp">☷ Manage Requests</a>
            <a href="statistics.jsp">▤ Statistics</a>
            <a class="logout-link" href="../logout.jsp">↪ Logout</a>
        </nav>
    </aside>

    <main class="main-content">

        <header class="topbar">
            <div>
                <h1 class="page-title">Manage Users</h1>
                <p class="page-subtitle">
                    Review registered FoodLoop accounts.
                </p>
            </div>

            <div class="admin-profile">
                <div class="profile-icon">A</div>
                <div>
                    <p class="profile-name"><%= adminName %></p>
                    <p class="profile-role">Administrator</p>
                </div>
            </div>
        </header>

        <div class="notice">
            The table below is a layout preview. Connect UserDAO before
            displaying real users or enabling account-management actions.
        </div>

        <section class="content-card">

            <div class="card-heading">
                <div>
                    <h2>Registered Accounts</h2>
                    <p class="card-description">Donor and NGO accounts.</p>
                </div>
            </div>

            <div class="toolbar">
                <input type="search"
                       id="tableSearch"
                       class="search-input"
                       placeholder="Search name, email or role..."
                       aria-label="Search users">
            </div>

            <div class="table-wrapper">
                <table class="data-table">

                    <thead>
                        <tr>
                            <th>User ID</th>
                            <th>Full Name</th>
                            <th>Email</th>
                            <th>Role</th>
                            <th>Account Status</th>
                        </tr>
                    </thead>

                    <tbody>
                        <tr>
                            <td colspan="5" class="empty-state">
                                No live user data connected yet.
                                Connect UserDAO to populate this table.
                            </td>
                        </tr>
                    </tbody>

                </table>
            </div>

        </section>

        <footer class="page-footer">
            &copy; <span id="currentYear"></span> FoodLoop Admin Panel
        </footer>

    </main>
</div>

<script src="../js/admin.js"></script>
</body>
</html>