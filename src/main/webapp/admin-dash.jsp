<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.*" %>
<html>
<head>
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: Arial, sans-serif;
        }

        .dashboard-container {
            margin: 2rem auto;
            max-width: 1200px;
        }

        .card {
            border: none;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .card:hover {
            transform: scale(1.05);
            box-shadow: 0 8px 15px rgba(0, 0, 0, 0.1);
        }

        .dashboard-title {
            text-align: center;
            margin-bottom: 2rem;
            color: #343a40;
        }

        .btn-primary {
            margin: 0.2rem;
        }

        .counter-card {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 150px;
            font-size: 24px;
        }

        .counter-card .count {
            font-size: 36px;
            font-weight: bold;
        }

        .counter-card h5 {
            margin-bottom: 0;
            color: #888;
        }
        .top-right-button {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 100;
        }
    </style>
</head>
<body>
<div class="top-right-button">
    <a href="index.jsp" class="btn btn-success">Go to Customer Dashboard</a>
</div>
<div class="dashboard-container">
    <h1 class="dashboard-title">Administrator Dashboard</h1>

    <div class="row g-4">
        <!-- User Count -->
        <div class="col-md-3">
            <div class="card p-3 shadow counter-card">
                <div>
                    <h5>Total Users</h5>
                    <div class="count">
                        <%
                            // Database connection variables
                            Connection conn = null;
                            Statement stmt = null;
                            ResultSet rs = null;
                            String dbUrl = "jdbc:mysql://localhost:3306/assignment"; // Replace with your DB URL
                            String dbUser = "root"; // Replace with your DB username
                            String dbPassword = "Ijse@123"; // Replace with your DB password

                            try {
                                // Load the database driver and establish a connection
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

                                // Query to get the total number of users
                                String queryd = "SELECT COUNT(*) FROM users"; // Change this to your users table name
                                stmt = conn.createStatement();
                                rs = stmt.executeQuery(queryd);
                                if (rs.next()) {
                                    out.print(rs.getInt(1)); // Print the count to the page
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        %>
                    </div>
                </div>
            </div>
        </div>

        <!-- Order Count -->
        <div class="col-md-3">
            <div class="card p-3 shadow counter-card">
                <div>
                    <h5>Total Orders</h5>
                    <div class="count">
                        <%
                            // Query to get the total number of orders
                            String querya = "SELECT COUNT(*) FROM orders"; // Your orders table
                            try {
                                stmt = conn.createStatement();
                                rs = stmt.executeQuery(querya);
                                if (rs.next()) {
                                    out.print(rs.getInt(1)); // Print the count to the page
                                }
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        %>
                    </div>
                </div>
            </div>
        </div>

        <!-- Product Count -->
        <div class="col-md-3">
            <div class="card p-3 shadow counter-card">
                <div>
                    <h5>Total Products</h5>
                    <div class="count">
                        <%
                            // Query to get the total number of products
                            String querys = "SELECT COUNT(*) FROM products"; // Your products table
                            try {
                                stmt = conn.createStatement();
                                rs = stmt.executeQuery(querys);
                                if (rs.next()) {
                                    out.print(rs.getInt(1)); // Print the count to the page
                                }
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        %>
                    </div>
                </div>
            </div>
        </div>

        <!-- Category Count -->
        <div class="col-md-3">
            <div class="card p-3 shadow counter-card">
                <div>
                    <h5>Total Categories</h5>
                    <div class="count">
                        <%
                            // Query to get the total number of categories
                            String queryh = "SELECT COUNT(*) FROM categories"; // Your categories table
                            try {
                                stmt = conn.createStatement();
                                rs = stmt.executeQuery(queryh);
                                if (rs.next()) {
                                    out.print(rs.getInt(1)); // Print the count to the page
                                }
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        %>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Manage Sections -->
    <div class="row g-4 mt-4">
        <!-- Product Management -->
        <div class="col-md-6">
            <div class="card p-3 shadow">
                <h4>Product Management</h4>
                <p>Manage all products in the inventory.</p>
                <a href="product-page.jsp" class="btn btn-primary">Add Products</a>
            </div>
        </div>

        <!-- Category Management -->
        <div class="col-md-6">
            <div class="card p-3 shadow">
                <h4>Category Management</h4>
                <p>Manage product categories.</p>
                <a href="category-list.jsp" class="btn btn-primary">Add Categories</a>
            </div>
        </div>

        <!-- Order History -->
        <div class="col-md-6">
            <div class="card p-3 shadow">
                <h4>Order History</h4>
                <p>View all orders placed by customers.</p>
                <a href="order-history.jsp" class="btn btn-primary">View Orders</a>
            </div>
        </div>

        <!-- User Management -->
        <div class="col-md-6">
            <div class="card p-3 shadow">
                <h4>User Management</h4>
                <p>Manage customer accounts.</p>
                <a href="user-list.jsp" class="btn btn-primary">View Users</a>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
