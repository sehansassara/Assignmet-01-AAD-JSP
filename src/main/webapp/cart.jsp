<%--
&lt;%&ndash;
  Created by IntelliJ IDEA.
  User: Sehan
  Date: 26/01/2025
  Time: 07:58
  To change this template use File | Settings | File Templates.
&ndash;%&gt;
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        .cart-card {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .cart-card img {
            max-width: 80px;
            border-radius: 5px;
        }
        .cart-card .card-body {
            display: flex;
            flex-wrap: wrap;
            align-items: center;
        }
        .cart-card .card-body > * {
            flex: 1;
            margin: 10px;
        }
        .cart-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <h2 class="fw-bold text-center mb-4">Your Cart</h2>
    <div class="row">
        <%
            try {
                String dbUrl = "jdbc:mysql://localhost:3306/assignment";
                String dbUser = "root";
                String dbPassword = "Ijse@123";
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

                String query = "SELECT c.id AS cart_id, p.product_name, p.price, c.quantity, p.image_url FROM cart c JOIN products p ON c.product_id = p.id";
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(query);

                while (rs.next()) {
                    int cartId = rs.getInt("cart_id");
                    String productName = rs.getString("product_name");
                    double price = rs.getDouble("price");
                    int quantity = rs.getInt("quantity");
                    double total = price * quantity;
                    String imageUrl = rs.getString("image_url");
        %>
        <div class="col-md-6">
            <div class="cart-card">
                <div class="card-body">
                    <img src="<%= request.getContextPath() + "/" + imageUrl %>" alt="<%= productName %>">
                    <div>
                        <h5 class="card-title"><%= productName %></h5>
                        <p class="card-text">Price: Rs.<%= price %></p>
                        <p class="card-text">Total: Rs.<%= total %></p>
                    </div>
                    <div>
                        <label for="quantity-<%= cartId %>">Quantity:</label>
                        <input type="number" id="quantity-<%= cartId %>" class="form-control"
                               value="<%= quantity %>" onchange="updateQuantity(<%= cartId %>, this.value)">
                    </div>
                    <div class="cart-actions">
                        <button class="btn btn-danger btn-sm" onclick="removeFromCart(<%= cartId %>)">Remove</button>
                    </div>
                </div>
            </div>
        </div>
        <%
                }
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </div>
</div>
<script>
    function updateQuantity(cartId, quantity) {
        $.ajax({
            url: 'UpdateCartServlet',
            type: 'POST',
            data: { id: cartId, quantity: quantity },
            success: function () {
                location.reload();
            },
            error: function () {
                alert('Failed to update quantity. Please try again.');
            }
        });
    }

    function removeFromCart(cartId) {
        $.ajax({
            url: 'RemoveFromCartServlet',
            type: 'POST',
            data: { id: cartId },
            success: function () {
                location.reload();
            },
            error: function () {
                alert('Failed to remove item. Please try again.');
            }
        });
    }
</script>
</body>
</html>
--%>

<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #f5f7fa, #c3cfe2); /* Modern gradient background */
            padding: 20px 0;
        }

        .container {
            max-width: 1200px;
        }

        h2 {
            font-weight: 600;
            color: #333;
        }

        .cart-card {
            background: #fff;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .cart-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        }

        .cart-card img {
            max-width: 80px;
            border-radius: 8px;
        }

        .cart-card .card-body {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .cart-card .card-body > div {
            flex: 1;
            margin: 10px;
        }

        .cart-actions {
            display: flex;
            justify-content: flex-end;
        }

        .cart-actions button {
            background-color: #ff5c5c;
            border: none;
            color: white;
            padding: 8px 15px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .cart-actions button:hover {
            background-color: #e04f4f;
        }

        .cart-actions button:focus {
            outline: none;
        }

        .cart-info p {
            margin: 5px 0;
            font-size: 14px;
            color: #555;
        }

        .cart-info h5 {
            font-size: 18px;
            font-weight: 600;
            color: #333;
        }

        input[type="number"] {
            width: 70px;
            padding: 5px;
            border-radius: 5px;
            border: 1px solid #ddd;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <h2 class="fw-bold text-center mb-4">Your Cart</h2>
    <div class="row">
        <%
            try {
                String dbUrl = "jdbc:mysql://localhost:3306/assignment";
                String dbUser = "root";
                String dbPassword = "Ijse@123";
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

                String query = "SELECT c.id AS cart_id, p.product_name, p.price, c.quantity, p.image_url FROM cart c JOIN products p ON c.product_id = p.id";
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(query);

                while (rs.next()) {
                    int cartId = rs.getInt("cart_id");
                    String productName = rs.getString("product_name");
                    double price = rs.getDouble("price");
                    int quantity = rs.getInt("quantity");
                    double total = price * quantity;
                    String imageUrl = rs.getString("image_url");
        %>
        <div class="col-md-6">
            <div class="cart-card">
                <div class="card-body">
                    <img src="<%= request.getContextPath() + "/" + imageUrl %>" alt="<%= productName %>">
                    <div class="cart-info">
                        <h5 class="card-title"><%= productName %></h5>
                        <p class="card-text">Price: Rs.<%= price %></p>
                        <p class="card-text">Total: Rs.<%= total %></p>
                    </div>
                    <div>
                        <label for="quantity-<%= cartId %>">Quantity:</label>
                        <input type="number" id="quantity-<%= cartId %>" class="form-control"
                               value="<%= quantity %>" onchange="updateQuantity(<%= cartId %>, this.value)">
                    </div>
                    <div class="cart-actions">
                        <button class="btn btn-danger btn-sm" onclick="removeFromCart(<%= cartId %>)">Remove</button>
                    </div>
                </div>
            </div>
        </div>
        <%
                }
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </div>
    <div class="text-center mt-4">
        <button class="btn btn-success btn-lg" onclick="placeOrder()">Place Order</button>
    </div>
</div>

<script>
    function placeOrder() {
        // Check if user is logged in
        var username = sessionStorage.getItem('username'); // Assuming username is stored in sessionStorage
        if (!username) {
            // If user is not logged in, prompt login page or show a login modal
            let loginUrl = "log-in.jsp"; // Redirect to login page
            let signupUrl = "sign-up.jsp"; // Redirect to signup page

            // Redirect to login page, and after login, redirect back to the order form
            window.location.href = loginUrl;
            return;
        }
        // If the user is logged in, proceed with placing the order
        saveOrderDetails(username);
    }

    function saveOrderDetails(username) {
        // Get cart total amount
        let cartTotal = 0;
        $(".cart-card").each(function() {
            let total = parseFloat($(this).find(".cart-info p").eq(1).text().split("Rs.")[1]);
            cartTotal += total;
        });

        // Make an AJAX request to place the order
        $.ajax({
            url: 'PlaceOrderServlet', // Your servlet to handle the order
            type: 'POST',
            data: {
                username: username,
                totalAmount: cartTotal,
            },
            success: function(response) {
                alert("Order placed successfully!");
                // Update product quantity and clear cart
                updateProductQuantities();
                clearCart();
            },
            error: function() {
                alert('Failed to place order. Please try again.');
            }
        });
    }

    function updateProductQuantities() {
        // Update product quantity based on cart data
        $(".cart-card").each(function() {
            let cartId = $(this).data('cart-id');
            let quantity = $(this).find('input[type="number"]').val();

            $.ajax({
                url: 'UpdateProductQuantityServlet', // Servlet to update product quantity
                type: 'POST',
                data: {
                    cartId: cartId,
                    quantity: quantity
                },
                success: function(response) {
                    console.log('Product quantity updated');
                },
                error: function() {
                    alert('Failed to update product quantity.');
                }
            });
        });
    }

    function clearCart() {
        // Clear the cart after placing the order
        $.ajax({
            url: 'ClearCartServlet', // Servlet to clear cart
            type: 'POST',
            success: function(response) {
                location.reload(); // Reload the page to reflect the empty cart
            },
            error: function() {
                alert('Failed to clear the cart.');
            }
        });
    }

    function updateQuantity(cartId, quantity) {
        $.ajax({
            url: 'UpdateCartServlet',
            type: 'POST',
            data: { id: cartId, quantity: quantity},
            success: function () {
                location.reload();
            },
            error: function () {
                alert('Failed to update quantity. Please try again.');
            }
        });
    }

    function removeFromCart(cartId) {
        $.ajax({
            url: 'RemoveFromCartServlet',
            type: 'POST',
            data: { id: cartId },
            success: function () {
                location.reload();
            },
            error: function () {
                alert('Failed to remove item. Please try again.');
            }
        });
    }
</script>

</body>
</html>
