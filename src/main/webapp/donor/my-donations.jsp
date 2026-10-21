<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Donations | FoodLoop</title>
    <link rel="stylesheet" href="../css/donor.css">
    <script src="../js/donor.js" defer></script>
</head>
<body>

<div class="dashboard-layout">
    <aside class="sidebar">
        <a class="brand" href="donor-dashboard.jsp">FoodLoop<span>.</span></a>
        <p class="sidebar-label">DONOR MENU</p>
        <nav>
            <a class="nav-link" href="donor-dashboard.jsp">🏠 Dashboard</a>
            <a class="nav-link" href="add-donation.jsp">➕ Add Donation</a>
            <a class="nav-link active" href="my-donations.jsp">🍱 My Donations</a>
            <a class="nav-link" href="donation-requests.jsp">📩 Donation Requests</a>
            <a class="nav-link" href="donation-details.jsp">📋 Donation Details</a>
        </nav>
        <a class="nav-link logout-link" href="../index.html">↩ Back to Home</a>
    </aside>

    <main class="main-content">
        <header class="topbar">
            <div>
                <h1>My Donations</h1>
                <p class="muted">Track and manage the food you have donated.</p>
            </div>
            <div class="profile-badge">D</div>
        </header>

        <div class="page-actions">
            <div>
                <h2>Your Contributions</h2>
                <p class="muted">Demo records for frontend preview.</p>
            </div>
            <a class="btn btn-primary" href="add-donation.jsp">+ Add Donation</a>
        </div>

        <section class="content-card">
            <div class="filter-bar">
                <input type="search" id="donationSearch"
                       placeholder="Search by food name..." aria-label="Search donations">

                <select id="statusFilter" aria-label="Filter by status">
                    <option value="all">All Statuses</option>
                    <option value="pending">Pending</option>
                    <option value="approved">Approved</option>
                    <option value="completed">Completed</option>
                    <option value="rejected">Rejected</option>
                </select>
            </div>

            <div class="table-wrapper">
                <table id="donationsTable">
                    <thead>
                        <tr>
                            <th>Donation ID</th>
                            <th>Food Name</th>
                            <th>Quantity</th>
                            <th>Pickup Date</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr data-status="pending">
                            <td>FL-D001</td>
                            <td>Vegetable Rice</td>
                            <td>20 Servings</td>
                            <td>Today</td>
                            <td><span class="status pending">Pending</span></td>
                            <td><a class="table-link" href="donation-details.jsp">View</a></td>
                        </tr>
                        <tr data-status="approved">
                            <td>FL-D002</td>
                            <td>Fresh Bread</td>
                            <td>30 Packets</td>
                            <td>Tomorrow</td>
                            <td><span class="status approved">Approved</span></td>
                            <td><a class="table-link" href="donation-details.jsp">View</a></td>
                        </tr>
                        <tr data-status="completed">
                            <td>FL-D003</td>
                            <td>Fruit Boxes</td>
                            <td>10 Boxes</td>
                            <td>Yesterday</td>
                            <td><span class="status completed">Completed</span></td>
                            <td><a class="table-link" href="donation-details.jsp">View</a></td>
                        </tr>
                        <tr data-status="rejected">
                            <td>FL-D004</td>
                            <td>Dairy Products</td>
                            <td>5 Packets</td>
                            <td>Yesterday</td>
                            <td><span class="status rejected">Rejected</span></td>
                            <td><a class="table-link" href="donation-details.jsp">View</a></td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <p id="noDonations" class="empty-message" hidden>No matching donations found.</p>
        </section>

        <footer class="page-footer">© 2026 FoodLoop</footer>
    </main>
</div>

</body>
</html>