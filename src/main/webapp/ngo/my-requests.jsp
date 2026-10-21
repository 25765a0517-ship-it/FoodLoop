<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Requests | FoodLoop</title>
    <link rel="stylesheet" href="../css/ngo.css">
    <script src="../js/ngo.js" defer></script>
</head>
<body>

<div class="dashboard-layout">
    <aside class="sidebar">
        <a class="brand" href="ngo-dashboard.jsp">FoodLoop<span>.</span></a>
        <p class="sidebar-label">NGO MENU</p>
        <nav>
            <a class="nav-link" href="ngo-dashboard.jsp">🏠 Dashboard</a>
            <a class="nav-link" href="available-food.jsp">🍱 Available Food</a>
            <a class="nav-link active" href="my-requests.jsp">📩 My Requests</a>
            <a class="nav-link" href="pickup-status.jsp">🚚 Pickup Status</a>
        </nav>
        <a class="nav-link logout-link" href="../index.html">↩ Back to Home</a>
    </aside>

    <main class="main-content">

        <header class="topbar">
            <div>
                <h1>My Food Requests</h1>
                <p class="muted">View the status of food donations requested by your NGO.</p>
            </div>
            <div class="profile-badge">N</div>
        </header>

        <section class="stats-grid request-stats">
            <article class="stat-card">
                <p>Total Requests</p>
                <h2>12</h2>
            </article>
            <article class="stat-card">
                <p>Pending</p>
                <h2>2</h2>
            </article>
            <article class="stat-card">
                <p>Approved</p>
                <h2>3</h2>
            </article>
            <article class="stat-card">
                <p>Completed</p>
                <h2>7</h2>
            </article>
        </section>

        <section class="content-card">
            <div class="filter-bar">
                <input type="search" id="requestSearch"
                       placeholder="Search food or request ID..." aria-label="Search requests">

                <select id="requestStatusFilter" aria-label="Filter by request status">
                    <option value="all">All Statuses</option>
                    <option value="pending">Pending</option>
                    <option value="approved">Approved</option>
                    <option value="completed">Completed</option>
                    <option value="rejected">Rejected</option>
                </select>
            </div>

            <div class="table-wrapper">
                <table id="requestsTable">
                    <thead>
                        <tr>
                            <th>Request ID</th>
                            <th>Food Item</th>
                            <th>Quantity</th>
                            <th>Request Date</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>

                    <tbody>
                        <tr data-status="pending">
                            <td>FL-R001</td>
                            <td>Vegetable Rice</td>
                            <td>10 servings</td>
                            <td>October 21, 2026</td>
                            <td><span class="status pending">Pending</span></td>
                            <td><a class="table-link" href="food-details.jsp">View</a></td>
                        </tr>

                        <tr data-status="approved">
                            <td>FL-R002</td>
                            <td>Fresh Bread</td>
                            <td>15 packets</td>
                            <td>October 20, 2026</td>
                            <td><span class="status approved">Approved</span></td>
                            <td><a class="table-link" href="pickup-status.jsp">Track</a></td>
                        </tr>

                        <tr data-status="completed">
                            <td>FL-R003</td>
                            <td>Fruit Boxes</td>
                            <td>5 boxes</td>
                            <td>October 19, 2026</td>
                            <td><span class="status completed">Completed</span></td>
                            <td><a class="table-link" href="pickup-status.jsp">View</a></td>
                        </tr>

                        <tr data-status="rejected">
                            <td>FL-R004</td>
                            <td>Packaged Snacks</td>
                            <td>10 packets</td>
                            <td>October 18, 2026</td>
                            <td><span class="status rejected">Rejected</span></td>
                            <td><a class="table-link" href="available-food.jsp">Find Food</a></td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <p id="noRequests" class="empty-message" hidden>
                No matching requests found.
            </p>
        </section>

        <footer class="page-footer">© 2026 FoodLoop</footer>
    </main>
</div>

</body>
</html>