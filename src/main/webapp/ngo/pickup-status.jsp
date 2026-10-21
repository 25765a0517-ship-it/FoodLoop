<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pickup Status | FoodLoop</title>
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
            <a class="nav-link" href="my-requests.jsp">📩 My Requests</a>
            <a class="nav-link active" href="pickup-status.jsp">🚚 Pickup Status</a>
        </nav>
        <a class="nav-link logout-link" href="../index.html">↩ Back to Home</a>
    </aside>

    <main class="main-content">

        <header class="topbar">
            <div>
                <h1>Pickup Status</h1>
                <p class="muted">Track your approved donations and collection progress.</p>
            </div>
            <div class="profile-badge">N</div>
        </header>

        <section class="content-card">
            <div class="section-heading">
                <div>
                    <h2>Current Pickup</h2>
                    <p class="muted">Request ID: FL-R002</p>
                </div>
                <span class="status approved">Approved</span>
            </div>

            <div class="pickup-summary">
                <div class="pickup-icon">🍞</div>
                <div>
                    <h3>Fresh Bread</h3>
                    <p class="muted">15 packets · Donor: Sunrise Bakery</p>
                    <p class="muted">Scheduled pickup: October 22, 2026, 10:00 AM</p>
                </div>
            </div>

            <div class="timeline">
                <div class="timeline-step complete">
                    <div class="timeline-dot">✓</div>
                    <div>
                        <h4>Request Submitted</h4>
                        <p>Your NGO submitted a food request.</p>
                    </div>
                </div>

                <div class="timeline-step complete">
                    <div class="timeline-dot">✓</div>
                    <div>
                        <h4>Request Approved</h4>
                        <p>The donor approved your request.</p>
                    </div>
                </div>

                <div class="timeline-step current">
                    <div class="timeline-dot">3</div>
                    <div>
                        <h4>Pickup Pending</h4>
                        <p>Collect the food at the agreed time and location.</p>
                    </div>
                </div>

                <div class="timeline-step">
                    <div class="timeline-dot">4</div>
                    <div>
                        <h4>Pickup Completed</h4>
                        <p>The collection will be marked complete after pickup.</p>
                    </div>
                </div>
            </div>

            <div class="form-note">
                ℹ️ This is a sample tracking timeline. Actual pickup status will come from the backend after integration.
            </div>
        </section>

        <section class="content-card">
            <div class="section-heading">
                <div>
                    <h2>Pickup History</h2>
                    <p class="muted">Previously requested food donations.</p>
                </div>
            </div>

            <div class="table-wrapper">
                <table>
                    <thead>
                        <tr>
                            <th>Request ID</th>
                            <th>Food Item</th>
                            <th>Pickup Date</th>
                            <th>Quantity</th>
                            <th>Status</th>
                        </tr>
                    </thead>

                    <tbody>
                        <tr>
                            <td>FL-R003</td>
                            <td>Fruit Boxes</td>
                            <td>October 19, 2026</td>
                            <td>5 boxes</td>
                            <td><span class="status completed">Completed</span></td>
                        </tr>

                        <tr>
                            <td>FL-R005</td>
                            <td>Vegetable Meals</td>
                            <td>October 17, 2026</td>
                            <td>12 servings</td>
                            <td><span class="status completed">Completed</span></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </section>

        <footer class="page-footer">© 2026 FoodLoop</footer>
    </main>
</div>

</body>
</html>