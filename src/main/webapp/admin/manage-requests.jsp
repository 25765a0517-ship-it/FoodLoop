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
    <title>Manage Requests | FoodLoop</title>
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
            <a class="active" href="manage-requests.jsp">☷ Manage Requests</a>
            <a href="statistics.jsp">▤ Statistics</a>
            <a class="logout-link" href="../logout.jsp">↪ Logout</a>
        </nav>
    </aside>

    <main class="main-content">

        <header class="topbar">
            <div>
                <h1 class="page-title">Manage Requests</h1>
                <p class="page-subtitle">
                    Monitor food requests submitted by NGOs.
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
            Request records are not connected yet. Integrate your existing
            food-request DAO to display real records.
        </div>

        <section class="content-card">

            <div class="card-heading">
                <div>
                    <h2>Food Request Records</h2>
                    <p class="card-description">
                        Review request IDs, NGOs and current statuses.
                    </p>
                </div>
            </div>

            <div class="toolbar">
                <input type="search"
                       id="tableSearch"
                       class="search-input"
                       placeholder="Search requests..."
                       aria-label="Search requests">

                <select id="statusFilter"
                        class="filter-select"
                        aria-label="Filter request status">
                    <option value="">All statuses</option>
                    <option value="pending">Pending</option>
                    <option value="approved">Approved</option>
                    <option value="rejected">Rejected</option>
                    <option value="completed">Completed</option>
                </select>
            </div>

            <div class="table-wrapper">
                <table class="data-table">

                    <thead>
                        <tr>
                            <th>Request ID</th>
                            <th>NGO Name</th>
                            <th>Food Item</th>
                            <th>Quantity</th>
                            <th>Request Date</th>
                            <th>Status</th>
                        </tr>
                    </thead>

                    <tbody>
                        <tr>
                            <td colspan="6" class="empty-state">
                                No live request data connected yet.
                                Connect your request DAO to populate this table.
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