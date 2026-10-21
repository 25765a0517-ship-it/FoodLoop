<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Donation | FoodLoop</title>
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
            <a class="nav-link active" href="add-donation.jsp">➕ Add Donation</a>
            <a class="nav-link" href="my-donations.jsp">🍱 My Donations</a>
            <a class="nav-link" href="donation-requests.jsp">📩 Donation Requests</a>
            <a class="nav-link" href="donation-details.jsp">📋 Donation Details</a>
        </nav>
        <a class="nav-link logout-link" href="../index.html">↩ Back to Home</a>
    </aside>

    <main class="main-content">
        <header class="topbar">
            <div>
                <h1>Add Food Donation</h1>
                <p class="muted">Provide details about the surplus food you want to share.</p>
            </div>
            <div class="profile-badge">D</div>
        </header>

        <section class="content-card form-card">
            <h2>Donation Information</h2>
            <p class="muted">Please fill in all required fields.</p>

            <form id="donationForm" novalidate>
                <div class="form-grid">

                    <div class="form-group">
                        <label for="foodName">Food Name *</label>
                        <input type="text" id="foodName" name="foodName"
                               placeholder="e.g. Vegetable Rice" required>
                        <small class="error-message" id="foodNameError"></small>
                    </div>

                    <div class="form-group">
                        <label for="foodType">Food Category *</label>
                        <select id="foodType" name="foodType" required>
                            <option value="">Select category</option>
                            <option value="Cooked Food">Cooked Food</option>
                            <option value="Bakery">Bakery</option>
                            <option value="Fruits">Fruits</option>
                            <option value="Vegetables">Vegetables</option>
                            <option value="Packaged Food">Packaged Food</option>
                            <option value="Other">Other</option>
                        </select>
                        <small class="error-message" id="foodTypeError"></small>
                    </div>

                    <div class="form-group">
                        <label for="quantity">Quantity *</label>
                        <input type="number" id="quantity" name="quantity"
                               min="1" placeholder="e.g. 20" required>
                        <small class="error-message" id="quantityError"></small>
                    </div>

                    <div class="form-group">
                        <label for="unit">Quantity Unit *</label>
                        <select id="unit" name="unit" required>
                            <option value="">Select unit</option>
                            <option value="Servings">Servings</option>
                            <option value="Packets">Packets</option>
                            <option value="Kilograms">Kilograms</option>
                            <option value="Boxes">Boxes</option>
                            <option value="Litres">Litres</option>
                        </select>
                        <small class="error-message" id="unitError"></small>
                    </div>

                    <div class="form-group">
                        <label for="preparedDate">Prepared Date *</label>
                        <input type="date" id="preparedDate" name="preparedDate" required>
                        <small class="error-message" id="preparedDateError"></small>
                    </div>

                    <div class="form-group">
                        <label for="expiryDate">Best Before / Expiry Date *</label>
                        <input type="date" id="expiryDate" name="expiryDate" required>
                        <small class="error-message" id="expiryDateError"></small>
                    </div>

                    <div class="form-group">
                        <label for="pickupTime">Available Until *</label>
                        <input type="datetime-local" id="pickupTime" name="pickupTime" required>
                        <small class="error-message" id="pickupTimeError"></small>
                    </div>

                    <div class="form-group">
                        <label for="contactNumber">Contact Number *</label>
                        <input type="tel" id="contactNumber" name="contactNumber"
                               placeholder="10-digit mobile number" required>
                        <small class="error-message" id="contactNumberError"></small>
                    </div>

                    <div class="form-group full-width">
                        <label for="address">Pickup Address *</label>
                        <textarea id="address" name="address" rows="3"
                                  placeholder="Enter complete pickup address" required></textarea>
                        <small class="error-message" id="addressError"></small>
                    </div>

                    <div class="form-group full-width">
                        <label for="description">Additional Information</label>
                        <textarea id="description" name="description" rows="3"
                                  placeholder="Ingredients, storage instructions, etc."></textarea>
                    </div>

                </div>

                <div class="form-note">
                    🌱 Please donate only food that is safe for consumption and has been stored appropriately.
                </div>

                <div class="form-actions">
                    <button type="reset" class="btn btn-outline">Clear Form</button>
                    <button type="submit" class="btn btn-primary">Submit Donation</button>
                </div>

                <p id="formMessage" class="form-message" role="status"></p>
            </form>
        </section>

        <footer class="page-footer">© 2026 FoodLoop</footer>
    </main>
</div>

</body>
</html>