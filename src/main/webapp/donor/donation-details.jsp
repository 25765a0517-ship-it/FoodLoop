<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Donation Details | FoodLoop</title>
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
            <a class="nav-link" href="my-donations.jsp">🍱 My Donations</a>
            <a class="nav-link" href="donation-requests.jsp">📩 Donation Requests</a>
            <a class="nav-link active" href="donation-details.jsp">📋 Donation Details</a>
        </nav>
        <a class="nav-link logout-link" href="../index.html">↩ Back to Home</a>
    </aside>

    <main class="main-content">
        <header class="topbar">
            <div>
                <h1>Donation Details</h1>
                <p class="muted">Review your donation information and status.</p>
            </div>
            <div class="profile-badge">D</div>
        </header>

        <div class="page-actions">
            <div>
                <h2>Donation FL-D001</h2>
                <p class="muted">Created on October 21, 2026</p>
            </div>
            <span class="status pending">Pending</span>
        </div>

        <section class="details-grid">
            <article class="content-card">
                <div class="food-illustration">🍱</div>
                <p class="eyebrow">DONATED FOOD</p>
                <h2>Vegetable Rice</h2>
                <p class="muted">Freshly prepared cooked food.</p>

                <div class="detail-row">
                    <span>Donation ID</span>
                    <strong>FL-D001</strong>
                </div>
                <div class="detail-row">
                    <span>Category</span>
                    <strong>Cooked Food</strong>
                </div>
                <div class="detail-row">
                    <span>Quantity</span>
                    <strong>20 servings</strong>
                </div>
                <div class="detail-row">
                    <span>Prepared Date</span>
                    <strong>October 21, 2026</strong>
                </div>
                <div class="detail-row">
                    <span>Best Before</span>
                    <strong>October 21, 2026</strong>
                </div>
                <div class="detail-row">
                    <span>Pickup Availability</span>
                    <strong>Today, 5:00 PM</strong>
                </div>
            </article>

            <article class="content-card">
                <h2>Pickup Information</h2>
                <div class="detail-row">
                    <span>Pickup Address</span>
                    <strong>FoodLoop Demo Address</strong>
                </div>
                <div class="detail-row">
                    <span>Contact Number</span>
                    <strong>9999999999</strong>
                </div>
                <div class="detail-row">
                    <span>Requested By</span>
                    <strong>Helping Hands NGO</strong>
                </div>
                <div class="detail-row">
                    <span>Request Status</span>
                    <strong>Awaiting Review</strong>
                </div>

                <h3 class="subheading">Description</h3>
                <p class="muted">
                    Fresh vegetable rice prepared for distribution to people in need.
                </p>

                <div class="form-note">
                    ℹ️ This page currently displays sample information. Live donation details will be loaded from the database after backend integration.
                </div>

                <div class="request-actions">
                    <a class="btn btn-outline" href="my-donations.jsp">← Back to Donations</a>
                    <button type="button" class="btn btn-primary"
                            data-demo-action="edit">Edit Donation</button>
                </div>
            </article>
        </section>

        <footer class="page-footer">© 2026 FoodLoop</footer>
    </main>
</div>

</body>
</html>