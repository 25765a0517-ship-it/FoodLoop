<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Donation Requests | FoodLoop</title>
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
            <a class="nav-link active" href="donation-requests.jsp">📩 Donation Requests</a>
            <a class="nav-link" href="donation-details.jsp">📋 Donation Details</a>
        </nav>
        <a class="nav-link logout-link" href="../index.html">↩ Back to Home</a>
    </aside>

    <main class="main-content">
        <header class="topbar">
            <div>
                <h1>Donation Requests</h1>
                <p class="muted">Review organizations requesting your donated food.</p>
            </div>
            <div class="profile-badge">D</div>
        </header>

        <section class="stats-grid request-stats">
            <article class="stat-card">
                <p>Total Requests</p>
                <h2>8</h2>
            </article>
            <article class="stat-card">
                <p>Pending Review</p>
                <h2>3</h2>
            </article>
            <article class="stat-card">
                <p>Accepted</p>
                <h2>4</h2>
            </article>
            <article class="stat-card">
                <p>Declined</p>
                <h2>1</h2>
            </article>
        </section>

        <section class="request-list">

            <article class="request-card">
                <div class="request-header">
                    <div class="organization-icon">🏢</div>
                    <div class="request-title">
                        <h3>Helping Hands NGO</h3>
                        <p class="muted">Requested: Vegetable Rice</p>
                    </div>
                    <span class="status pending">Pending</span>
                </div>

                <div class="request-info">
                    <p><strong>Quantity requested:</strong> 10 servings</p>
                    <p><strong>Pickup:</strong> Today, 5:00 PM</p>
                    <p><strong>Contact:</strong> helping.ngo@example.com</p>
                </div>

                <p class="request-message">
                    We would like to distribute these meals to families in need.
                </p>

                <div class="request-actions">
                    <button type="button" class="btn btn-primary"
                            data-request-action="accept">Accept Request</button>
                    <button type="button" class="btn btn-danger"
                            data-request-action="reject">Decline Request</button>
                    <a class="btn btn-outline" href="donation-details.jsp">View Donation</a>
                </div>
            </article>

            <article class="request-card">
                <div class="request-header">
                    <div class="organization-icon">🏫</div>
                    <div class="request-title">
                        <h3>Community Care Center</h3>
                        <p class="muted">Requested: Fresh Bread</p>
                    </div>
                    <span class="status pending">Pending</span>
                </div>

                <div class="request-info">
                    <p><strong>Quantity requested:</strong> 15 packets</p>
                    <p><strong>Pickup:</strong> Tomorrow, 10:00 AM</p>
                    <p><strong>Contact:</strong> care@example.com</p>
                </div>

                <p class="request-message">
                    The food will be shared with residents at our community center.
                </p>

                <div class="request-actions">
                    <button type="button" class="btn btn-primary"
                            data-request-action="accept">Accept Request</button>
                    <button type="button" class="btn btn-danger"
                            data-request-action="reject">Decline Request</button>
                    <a class="btn btn-outline" href="donation-details.jsp">View Donation</a>
                </div>
            </article>

            <article class="request-card">
                <div class="request-header">
                    <div class="organization-icon">🤝</div>
                    <div class="request-title">
                        <h3>Hope Foundation</h3>
                        <p class="muted">Requested: Fruit Boxes</p>
                    </div>
                    <span class="status approved">Accepted</span>
                </div>

                <div class="request-info">
                    <p><strong>Quantity requested:</strong> 5 boxes</p>
                    <p><strong>Pickup:</strong> Scheduled</p>
                    <p><strong>Contact:</strong> hope@example.com</p>
                </div>

                <div class="request-actions">
                    <a class="btn btn-outline" href="donation-details.jsp">View Donation</a>
                </div>
            </article>

        </section>

        <footer class="page-footer">© 2026 FoodLoop</footer>
    </main>
</div>

</body>
</html>