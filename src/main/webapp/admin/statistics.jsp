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
    <title>Statistics | FoodLoop</title>
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
            <a href="manage-users.jsp">♙ Manage Users</a>
            <a href="manage-donations.jsp">♧ Manage Donations</a>
            <a href="manage-requests.jsp">☷ Manage Requests</a>
            <a class="active" href="statistics.jsp">▤ Statistics</a>
            <a class="logout-link" href="../logout.jsp">↪ Logout</a>
        </nav>
    </aside>

    <main class="main-content">

        <header class="topbar">
            <div>
                <h1 class="page-title">FoodLoop Statistics</h1>
                <p class="page-subtitle">
                    Understand the platform's food redistribution activity.
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
            These metrics are not calculated yet. Connect your DAOs and
            aggregate queries before displaying production statistics.
        </div>

        <section class="stats-grid">

            <article class="stat-card">
                <p class="stat-label">Registered Users</p>
                <h2 class="stat-value">—</h2>
                <p class="stat-note">Count from users table</p>
            </article>

            <article class="stat-card">
                <p class="stat-label">Total Donations</p>
                <h2 class="stat-value">—</h2>
                <p class="stat-note">Count from donations table</p>
            </article>

            <article class="stat-card">
                <p class="stat-label">Completed Requests</p>
                <h2 class="stat-value">—</h2>
                <p class="stat-note">Count completed request records</p>
            </article>

            <article class="stat-card">
                <p class="stat-label">Pending Requests</p>
                <h2 class="stat-value">—</h2>
                <p class="stat-note">Count pending request records</p>
            </article>

        </section>

        <section class="content-card">

            <div class="card-heading">
                <div>
                    <h2>Platform Activity</h2>
                    <p class="card-description">
                        Future chart area for donations and requests over time.
                    </p>
                </div>
            </div>

            <div class="chart-placeholder">
                <strong>Statistics chart will appear here.</strong>
                <br>
                Connect database aggregate queries and a charting component
                to show monthly donations, request completion and food saved.
            </div>

        </section>

        <section class="content-card">

            <div class="card-heading">
                <div>
                    <h2>Suggested Metrics</h2>
                    <p class="card-description">
                        Useful indicators for the FoodLoop project report.
                    </p>
                </div>
            </div>

            <div class="quick-links">

                <article class="quick-link">
                    <h3>Donation Activity</h3>
                    <p>Track total donations and donations marked completed.</p>
                </article>

                <article class="quick-link">
                    <h3>NGO Participation</h3>
                    <p>Count registered NGO accounts and active requests.</p>
                </article>

                <article class="quick-link">
                    <h3>Food Redistribution</h3>
                    <p>Calculate completed food redistribution using actual records.</p>
                </article>

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