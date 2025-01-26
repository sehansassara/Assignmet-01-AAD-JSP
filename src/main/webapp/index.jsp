<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.sql.*, java.util.*" %>
<html>
<head>
    <title>Home</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <style>

        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        main {
            flex: 1;
        }


        .hero {
            position: relative;
            height: 100vh;
            background: url('image/Shoes.jpg') no-repeat center center/cover;
            display: flex;
            justify-content: center;
            align-items: center;
            color: white;
            text-align: center;
        }

        .hero-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
        }

        .hero-content {
            position: relative;
            z-index: 1;
        }

        .hero h1 span {
            color: #007bff;
        }

        .hero a {
            margin-top: 1rem;
        }

        .search-bar {
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .search-bar input {
            border-radius: 20px;
            padding: 0.5rem 1rem;
            border: 1px solid #ddd;
            outline: none;
        }

        .search-bar button {
            margin-left: 0.5rem;
            border-radius: 20px;
        }


        .recent-launch .card {
            border: none;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .recent-launch .card:hover {
            transform: scale(1.05);
            box-shadow: 0 8px 15px rgba(0, 0, 0, 0.1);
        }


        footer {
            background: linear-gradient(90deg, #007bff, #6610f2); /* Gradient background */
            color: white;
            padding: 2rem 0;
        }

        footer .social-icons a {
            margin: 0 10px;
            color: white;
            font-size: 1.5rem;
            transition: color 0.3s ease;
        }

        footer .social-icons a:hover {
            color: #f8f9fa; /* Light color on hover */
        }

        footer .footer-links a {
            color: white;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        footer .footer-links a:hover {
            color: #f8f9fa;
        }
    </style>
</head>
<body>
<!-- Header -->
<header class="bg-light shadow">
    <nav class="navbar navbar-expand-lg navbar-light container">
        <a class="navbar-brand fw-bold" href="#">ShoeStore</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="#">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="#">Products</a></li>
                <!-- Dropdown for Category -->


                <!-- Dropdown for Filters -->
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="filtersDropdown" role="button" data-bs-toggle="dropdown">Filters</a>
                    <ul class="dropdown-menu">
                        <li>
                            <form action="search-category.jsp" method="GET">
                                <select class="form-select mb-2" name="filterType" id="filterType">
                                    <option value="" selected disabled>Choose Filter</option>

                                    <!-- Categories from Database -->
                                    <optgroup label="Categories">
                                        <%
                                            Connection conn = null;
                                            Statement stmt = null;
                                            ResultSet rs = null;
                                            String dbUrl = "jdbc:mysql://localhost:3306/assignment"; // Replace with your DB URL
                                            String dbUser = "root"; // Replace with your DB username
                                            String dbPassword = "Ijse@123"; // Replace with your DB password

                                            try {
                                                Class.forName("com.mysql.cj.jdbc.Driver");
                                                conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

                                                // Fetch categories
                                                String categoryQuery = "SELECT name FROM categories";
                                                stmt = conn.createStatement();
                                                rs = stmt.executeQuery(categoryQuery);

                                                while (rs.next()) {
                                                    String categoryName = rs.getString("name");
                                        %>
                                        <option value="category:<%= categoryName %>"><%= categoryName %></option>
                                        <%
                                                }
                                            } catch (Exception e) {
                                                e.printStackTrace();
                                            } finally {
                                                try {
                                                    if (rs != null) rs.close();
                                                    if (stmt != null) stmt.close();
                                                    if (conn != null) conn.close();
                                                } catch (SQLException e) {
                                                    e.printStackTrace();
                                                }
                                            }
                                        %>
                                    </optgroup>

                                    <!-- Products from Database -->
                                    <optgroup label="Products">
                                        <%
                                            try {
                                                conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
                                                String productQuery = "SELECT product_name FROM products";
                                                stmt = conn.createStatement();
                                                rs = stmt.executeQuery(productQuery);

                                                while (rs.next()) {
                                                    String productName = rs.getString("product_name");
                                        %>
                                        <option value="product:<%= productName %>"><%= productName %></option>
                                        <%
                                                }
                                            } catch (Exception e) {
                                                e.printStackTrace();
                                            } finally {
                                                try {
                                                    if (rs != null) rs.close();
                                                    if (stmt != null) stmt.close();
                                                    if (conn != null) conn.close();
                                                } catch (SQLException e) {
                                                    e.printStackTrace();
                                                }
                                            }
                                        %>
                                    </optgroup>

                                    <!-- Price Filters -->
                                    <optgroup label="Price">
                                        <option value="under10000">Under RS.10,000</option>
                                        <option value="over10000">Over RS.10,000</option>
                                    </optgroup>
                                </select>
                                <button class="btn btn-primary w-100 mt-2" type="submit">Apply Filter</button>
                            </form>
                        </li>
                    </ul>
                </li>
            </ul>


            <!-- Cart and Admin icons -->
            <a href="cart.jsp" class="me-3">
                <img src="image/icons8-cart-96.png" alt="Cart" width="30" height="30">
                <span id="cart-count" class="badge bg-danger rounded-circle" style="position: absolute; top: 0; right: 0; font-size: 14px; display: none;"></span>
            </a>

            <a href="log-in.jsp" class="me-3">
                <img src="image/icons8-admin-96.png" alt="Admin" width="30" height="30">
            </a>
            <a href="log-in.jsp" class="btn btn-outline-danger">Log Out</a>
        </div>
    </nav>
</header>

<!-- Hero Section -->
<main>
    <section class="hero">
        <div class="hero-overlay"></div>
        <div class="hero-content">
            <h1 class="display-4 fw-bold">Make A Good Journey <span class="text-primary">With Shoe</span></h1>
            <p class="lead">Exciting varieties available! Style your footwear, today.</p>
            <a href="log-in.jsp" class="btn btn-primary me-2">Log In</a>
            <a href="sign-up.jsp" class="btn btn-outline-primary">Sign Up</a>
        </div>
    </section>

    <section class="recent-launch container mt-5">
        <h2 class="fw-bold text-center mb-4">Recent Launch</h2>
        <div class="row g-4">
            <%


                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

                    String query = "SELECT * FROM products";
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery(query);

                    while (rs.next()) {
                        String productName = rs.getString("product_name");
                        String description = rs.getString("description");
                        double price = rs.getDouble("price");
                        String imageUrl = rs.getString("image_url"); // Relative path
                        int quantity = rs.getInt("quantity");
            %>
            <div class="col-md-4">
                <div class="card shadow">
                    <img src="<%= request.getContextPath() + "/" + imageUrl %>"
                         alt="<%= productName %>"
                         class="card-img-top"
                         width="220"
                         height="200">

                    <div class="card-body">
                        <h5 class="card-title"><%= productName %></h5>
                        <p class="card-text"><%= description %></p>
                        <p class="card-text">Rs.<%= price %></p>
                        <p class="card-text">In Stock: <%= quantity %></p>
                        <button class="btn btn-primary btn-sm" onclick="addToCart(<%= rs.getInt("id") %>)">ADD TO CART</button>
                    </div>
                </div>
            </div>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            %>
        </div>
    </section>

</main>


<!-- Footer -->
<footer>
    <div class="container">
        <div class="row text-center text-md-start">
            <!-- Footer content here -->
        </div>
        <hr class="my-4">
        <div class="text-center">
            <p>&copy; 2025 ShoeStore. All Rights Reserved.</p>
        </div>
    </div>
</footer>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script src="js/jquery-3.7.1.min.js"></script>
<script>
    function addToCart(productId) {
        $.ajax({
            url: 'AddToCartServlet',
            type: 'POST',
            data: { id: productId },
            success: function (response) {
                // Check if the response indicates success
                if (response.success) {
                    alert('Product added to cart!');
                    // Optionally, update UI or cart counter
                } else {
                    alert('Failed to add product to cart: ' + response.message);
                }
            },
            error: function (xhr, status, error) {
                console.error('AJAX Error:', status, error);
                alert('An error occurred while adding the product to the cart. Please try again.');
            }
        });
    }

    // Update the cart count
   /* function updateCartCount() {
        $.ajax({
            url: 'GetCartCountServlet', // This servlet will return the number of items in the cart
            type: 'GET',
            success: function (response) {
                var cartCount = response.cartCount;
                var cartCountElement = $('#cart-count');

                // Show the cart count only if there are items in the cart
                if (cartCount > 0) {
                    cartCountElement.text(cartCount).show();
                } else {
                    cartCountElement.hide();
                }
            },
            error: function (xhr, status, error) {
                console.error('AJAX Error:', status, error);
            }
        });
    }

    // Call this function when the page loads
    $(document).ready(function() {
        updateCartCount();
    });
*/
</script>

</body>
</html>
