<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Available Food | FoodLoop</title>
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
                <h1>Available Food</h1>
                <p class="muted">Discover food donations available for your organization.</p>
            </div>
            <div class="profile-badge">N</div>
        </header>

        <section class="content-card">
            <h2>Find Food Donations</h2>
            <p class="muted">Search by food name or filter by category.</p>

            <div class="filter-bar">
                <input type="search" id="foodSearch"
                       placeholder="Search food donations..." aria-label="Search food">

                <select id="foodCategoryFilter" aria-label="Filter by food category">
                    <option value="all">All Categories</option>
                    <option value="cooked food">Cooked Food</option>
                    <option value="bakery">Bakery</option>
                    <option value="fruits">Fruits</option>
                    <option value="vegetables">Vegetables</option>
                    <option value="packaged food">Packaged Food</option>
                </select>
            </div>
        </section>

        <section class="food-grid available-food-grid" id="availableFoodGrid">

            <article class="food-card" data-category="cooked food">
                <div class="food-image">🍚</div>
                <div class="food-card-body">
                    <span class="food-category">Cooked Food</span>
                    <h3>Vegetable Rice</h3>
                    <p class="muted">Quantity: 20 servings</p>
                    <p class="muted">Donor: Green Leaf Restaurant</p>
                    <p class="muted">Pickup: Today, 5:00 PM</p>
                    <p class="muted">Location: Vijayawada</p>
                    <a class="btn btn-primary btn-block" href="food-details.jsp">View Details</a>
                </div>
            </article>

            <article class="food-card" data-category="bakery">
                <div class="food-image">🍞</div>
                <div class="food-card-body">
                    <span class="food-category">Bakery</span>
                    <h3>Fresh Bread</h3>
                    <p class="muted">Quantity: 30 packets</p>
                    <p class="muted">Donor: Sunrise Bakery</p>
                    <p class="muted">Pickup: Tomorrow, 10:00 AM</p>
                    <p class="muted">Location: Vijayawada</p>
                    <a class="btn btn-primary btn-block" href="food-details.jsp">View Details</a>
                </div>
            </article>

            <article class="food-card" data-category="fruits">
                <div class="food-image">🍎</div>
                <div class="food-card-body">
                    <span class="food-category">Fruits</span>
                    <h3>Fresh Fruit Boxes</h3>
                    <p class="muted">Quantity: 10 boxes</p>
                    <p class="muted">Donor: Fresh Mart</p>
                    <p class="muted">Pickup: Today, 6:00 PM</p>
                    <p class="muted">Location: Guntur</p>
                    <a class="btn btn-primary btn-block" href="food-details.jsp">View Details</a>
                </div>
            </article>

            <article class="food-card" data-category="vegetables">
                <div class="food-image">🥕</div>
                <div class="food-card-body">
                    <span class="food-category">Vegetables</span>
                    <h3>Fresh Vegetables</h3>
                    <p class="muted">Quantity: 15 kg</p>
                    <p class="muted">Donor: Local Vegetable Store</p>
                    <p class="muted">Pickup: Tomorrow, 9:00 AM</p>
                    <p class="muted">Location: Vijayawada</p>
                    <a class="btn btn-primary btn-block" href="food-details.jsp">View Details</a>
                </div>
            </article>

            <article class="food-card" data-category="packaged food">
                <div class="food-image">🥫</div>
                <div class="food-card-body">
                    <span class="food-category">Packaged Food</span>
                    <h3>Packaged Snacks</h3>
                    <p class="muted">Quantity: 25 packets</p>
                    <p class="muted">Donor: City Supermarket</p>
                    <p class="muted">Pickup: Tomorrow, 4:00 PM</p>
                    <p class="muted">Location: Guntur</p>
                    <a class="btn btn-primary btn-block" href="food-details.jsp">View Details</a>
                </div>
            </article>

            <article class="food-card" data-category="cooked food">
                <div class="food-image">🍛</div>
                <div class="food-card-body">
                    <span class="food-category">Cooked Food</span>
                    <h3>Vegetable Meals</h3>
                    <p class="muted">Quantity: 15 servings</p>
                    <p class="muted">Donor: Community Kitchen</p>
                    <p class="muted">Pickup: Today, 7:00 PM</p>
                    <p class="muted">Location: Vijayawada</p>
                    <a class="btn btn-primary btn-block" href="food-details.jsp">View Details</a>
                </div>
            </article>

        </section>

        <p id="noFoodResults" class="empty-message" hidden>
            No matching food donations found.
        </p>

        <footer class="page-footer">© 2026 FoodLoop</footer>
    </main>
</div>

</body>
</html>