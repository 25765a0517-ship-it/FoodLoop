<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NGO Dashboard | FoodLoop</title>
    <link rel="stylesheet" href="../css/ngo.css">
    <script src="../js/ngo.js" defer></script>
</head>
<body>

<div class="dashboard-layout">

    <aside class="sidebar">
        <a class="brand" href="ngo-dashboard.jsp">FoodLoop<span>.</span></a>
        <p class="sidebar-label">NGO MENU</p>

        <nav>
            <a class="nav-link active" href="ngo-dashboard.jsp">🏠 Dashboard</a>
            <a class="nav-link" href="available-food.jsp">🍱 Available Food</a>
            <a class="nav-link" href="my-requests.jsp">📩 My Requests</a>
            <a class="nav-link" href="pickup-status.jsp">🚚 Pickup Status</a>
        </nav>

        <a class="nav-link logout-link" href="../index.html">↩ Back to Home</a>
    </aside>

    <main class="main-content">

        <header class="topbar">
            <div>
                <h1>NGO Dashboard</h1>
                <p class="muted">Welcome back! Help bring surplus food to people in need.</p>
            </div>
            <div class="profile-badge">N</div>
        </header>

        <section class="welcome-banner">
            <div>
                <p class="eyebrow">TOGETHER WE CAN MAKE A DIFFERENCE</p>
                <h2>Good Food. Greater Good. 🌱</h2>
                <p>Find available surplus food and connect with generous donors.</p>
                <a class="btn btn-light" href="available-food.jsp">Explore Available Food</a>
            </div>
            <div class="banner-emoji">🤝</div>
        </section>

        <section class="stats-grid">

            <article class="stat-card">
                <div class="stat-icon">📦</div>
                <p>Available Donations</p>
                <h2>18</h2>
                <span>Food donations listed</span>
            </article>

            <article class="stat-card">
                <div class="stat-icon">📩</div>
                <p>My Requests</p>
                <h2>12</h2>
                <span>Requests submitted</span>
            </article>

            <article class="stat-card">
                <div class="stat-icon">🚚</div>
                <p>Pickups Pending</p>
                <h2>3</h2>
                <span>Awaiting collection</span>
            </article>

            <article class="stat-card">
                <div class="stat-icon">✅</div>
                <p>Completed Pickups</p>
                <h2>9</h2>
                <span>Successfully collected</span>
            </article>

        </section>

        <section class="content-card">
            <div class="section-heading">
                <div>
                    <h2>Recently Available Food</h2>
                    <p class="muted">Explore the latest food donations.</p>
                </div>
                <a class="text-link" href="available-food.jsp">View All →</a>
            </div>

            <div class="food-grid">

                <article class="food-card">
                    <div class="food-image">🍚</div>
                    <div class="food-card-body">
                        <span class="food-category">Cooked Food</span>
                        <h3>Vegetable Rice</h3>
                        <p class="muted">Quantity: 20 servings</p>
                        <p class="muted">Pickup: Today, 5 PM</p>
                        <a class="btn btn-primary btn-block" href="food-details.jsp">View Details</a>
                    </div>
                </article>

                <article class="food-card">
                    <div class="food-image">🍞</div>
                    <div class="food-card-body">
                        <span class="food-category">Bakery</span>
                        <h3>Fresh Bread</h3>
                        <p class="muted">Quantity: 30 packets</p>
                        <p class="muted">Pickup: Tomorrow, 10 AM</p>
                        <a class="btn btn-primary btn-block" href="food-details.jsp">View Details</a>
                    </div>
                </article>

                <article class="food-card">
                    <div class="food-image">🍎</div>
                    <div class="food-card-body">
                        <span class="food-category">Fruits</span>
                        <h3>Fresh Fruit Boxes</h3>
                        <p class="muted">Quantity: 10 boxes</p>
                        <p class="muted">Pickup: Today, 6 PM</p>
                        <a class="btn btn-primary btn-block" href="food-details.jsp">View Details</a>
                    </div>
                </article>

            </div>
        </section>

        <section class="content-card">
            <div class="section-heading">
                <div>
                    <h2>Recent Requests</h2>
                    <p class="muted">Track the status of your food requests.</p>
                </div>
                <a class="text-link" href="my-requests.jsp">View All →</a>
            </div>

            <div class="table-wrapper">
                <table>
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
                        <tr>
                            <td>FL-R001</td>
                            <td>Vegetable Rice</td>
                            <td>10 servings</td>
                            <td>Today</td>
                            <td><span class="status pending">Pending</span></td>
                            <td><a class="table-link" href="my-requests.jsp">View</a></td>
                        </tr>

                        <tr>
                            <td>FL-R002</td>
                            <td>Fresh Bread</td>
                            <td>15 packets</td>
                            <td>Yesterday</td>
                            <td><span class="status approved">Approved</span></td>
                            <td><a class="table-link" href="pickup-status.jsp">Track Pickup</a></td>
                        </tr>

                        <tr>
                            <td>FL-R003</td>
                            <td>Fruit Boxes</td>
                            <td>5 boxes</td>
                            <td>Yesterday</td>
                            <td><span class="status completed">Completed</span></td>
                            <td><a class="table-link" href="pickup-status.jsp">View</a></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </section>

        <footer class="page-footer">
            © 2026 FoodLoop | Reducing Food Waste, Sharing Hope
        </footer>

    </main>
</div>

</body>
</html>