<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Food Details | FoodLoop</title>
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
            <a class="nav-link active" href="available-food.jsp">🍱 Available Food</a>
            <a class="nav-link" href="my-requests.jsp">📩 My Requests</a>
            <a class="nav-link" href="pickup-status.jsp">🚚 Pickup Status</a>
        </nav>
        <a class="nav-link logout-link" href="../index.html">↩ Back to Home</a>
    </aside>

    <main class="main-content">

        <header class="topbar">
            <div>
                <h1>Food Donation Details</h1>
                <p class="muted">Review the donation before requesting it.</p>
            </div>
            <div class="profile-badge">N</div>
        </header>

        <section class="details-grid">

            <article class="content-card">
                <div class="food-illustration">🍚</div>
                <p class="eyebrow">FOOD DONATION</p>
                <h2>Vegetable Rice</h2>
                <span class="status approved">Available</span>

                <div class="detail-row">
                    <span>Donation ID</span>
                    <strong>FL-D001</strong>
                </div>

                <div class="detail-row">
                    <span>Category</span>
                    <strong>Cooked Food</strong>
                </div>

                <div class="detail-row">
                    <span>Available Quantity</span>
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
                    <span>Pickup Deadline</span>
                    <strong>Today, 5:00 PM</strong>
                </div>

                <div class="detail-row">
                    <span>Donor</span>
                    <strong>Green Leaf Restaurant</strong>
                </div>
            </article>

            <article class="content-card">
                <h2>Pickup Information</h2>

                <div class="detail-row">
                    <span>Pickup Location</span>
                    <strong>Vijayawada</strong>
                </div>

                <div class="detail-row">
                    <span>Pickup Address</span>
                    <strong>Demo address provided by donor</strong>
                </div>

                <h3 class="subheading">About this Donation</h3>
                <p class="muted">
                    Freshly prepared vegetable rice intended for distribution
                    to people and families in need.
                </p>

                <div class="form-note">
                    🌱 Confirm food safety and pickup arrangements with the donor before collection.
                </div>

                <h3 class="subheading">Request Food</h3>

                <form id="foodRequestForm" novalidate>
                    <div class="form-group">
                        <label for="requestedQuantity">Quantity Required *</label>
                        <input type="number" id="requestedQuantity"
                               name="requestedQuantity" min="1" max="20" required>
                        <small id="requestedQuantityError" class="error-message"></small>
                    </div>

                    <div class="form-group">
                        <label for="requestMessage">Message to Donor</label>
                        <textarea id="requestMessage" name="requestMessage" rows="3"
                                  placeholder="Tell the donor about your collection plan"></textarea>
                    </div>

                    <button type="submit" class="btn btn-primary">
                        Submit Food Request
                    </button>

                    <p id="requestFormMessage" class="form-message" role="status"></p>
                </form>

                <a class="text-link back-link" href="available-food.jsp">← Back to Available Food</a>
            </article>

        </section>

        <footer class="page-footer">© 2026 FoodLoop</footer>
    </main>
</div>

</body>
</html>