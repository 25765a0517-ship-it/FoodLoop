<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    if (session.getAttribute("userId") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp?unauthorized=1");
        return;
    }

    String role = String.valueOf(session.getAttribute("role"));

    if (!"ADMIN".equalsIgnoreCase(role)) {
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

    <title>Admin Dashboard | FoodLoop</title>

    <link rel="stylesheet" href="../css/admin.css">
</head>
<body>

<div class="admin-layout">

    <aside class="sidebar">

        <a href="dashboard.jsp" class="brand">Food<span>Loop</span></a>

        <p class="sidebar-label">Administration</p>

        <button
            type="button"
            id="mobileMenuButton"
            class="mobile-menu-button"
            aria-expanded="false"
            aria-controls="sidebarNav">
            ☰ Menu
        </button>

        <nav class="sidebar-nav open" id="sidebarNav">
            <a class="active" href="dashboard.jsp">▦ Dashboard</a>
            <a href="manage-users.jsp">♙ Manage Users</a>
            <a href="manage-donations.jsp">♧ Manage Donations</a>
            <a href="manage-requests.jsp">☷ Manage Requests</a>
            <a href="statistics.jsp">▤ Statistics</a>
            <a class="logout-link" href="../logout.jsp">↪ Logout</a>
        </nav>

    </aside>

    <main class="main-content">

        <header class="topbar">

            <div>
                <h1 class="page-title">Admin Dashboard</h1>
                <p class="page-subtitle">
                    Welcome back! Monitor your FoodLoop platform.
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
            Dashboard preview: statistics below are placeholders until connected
            to your Oracle database.
        </div>

        <section class="stats-grid">

            <article class="stat-card">
                <p class="stat-label">Total Users</p>
                <h2 class="stat-value">—</h2>
                <p class="stat-note">Connect UserDAO for live data</p>
            </article>

            <article class="stat-card">
                <p class="stat-label">Total Donations</p>
                <h2 class="stat-value">—</h2>
                <p class="stat-note">Connect DonationDAO for live data</p>
            </article>

            <article class="stat-card">
                <p class="stat-label">Food Requests</p>
                <h2 class="stat-value">—</h2>
                <p class="stat-note">Connect request DAO for live data</p>
            </article>

            <article class="stat-card">
                <p class="stat-label">Pending Requests</p>
                <h2 class="stat-value">—</h2>
                <p class="stat-note">Calculate from actual request statuses</p>
            </article>

        </section>

        <section class="content-card">

            <div class="card-heading">
                <div>
                    <h2>Admin Quick Actions</h2>
                    <p class="card-description">
                        Open a section to review FoodLoop data.
                    </p>
                </div>
            </div>

            <div class="quick-links">

                <a href="manage-users.jsp" class="quick-link">
                    <h3>♙ Manage Users</h3>
                    <p>Review registered donors and NGO accounts.</p>
                </a>

                <a href="manage-donations.jsp" class="quick-link">
                    <h3>♧ Manage Donations</h3>
                    <p>Monitor surplus food donation records.</p>
                </a>

                <a href="manage-requests.jsp" class="quick-link">
                    <h3>☷ Manage Requests</h3>
                    <p>Review requests submitted by NGOs.</p>
                </a>

                <a href="statistics.jsp" class="quick-link">
                    <h3>▤ Statistics</h3>
                    <p>View overall platform metrics.</p>
                </a>

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