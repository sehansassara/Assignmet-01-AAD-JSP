<%--
  Created by IntelliJ IDEA.
  User: Sehan
  Date: 26/01/2025
  Time: 10:29
  To change this template use File | Settings | File Templates.
--%><%@ page import="java.sql.*" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Confirmation</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: #f8f9fa;
            padding: 20px;
        }

        .order-summary {
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
        }

        .order-summary h3 {
            margin-bottom: 20px;
        }

        .order-summary .order-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }

        .order-summary .total {
            font-weight: bold;
            font-size: 18px;
        }
    </style>
</head>
<body>

<div class="container mt-5">
    <%
        String username = (String) session.getAttribute("username");
        Integer userId = (Integer) session.getAttribute("id");

        if (username == null) {
            response.sendRedirect("log-in.jsp");
            return;
        }

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        double totalAmount = 0;

        try {
            String dbUrl = "jdbc:mysql://localhost:3306/assignment";
            String dbUser = "root";
            String dbPassword = "Ijse@123";
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

            // Fetch cart items for the logged-in user using user_id
            String query = "SELECT c.id AS cart_id, p.product_name, p.price, c.quantity, p.image_url " +
                    "FROM cart c " +
                    "JOIN products p ON c.product_id = p.id";

            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();

            if (!rs.isBeforeFirst()) {
                System.out.println("No items in the cart.");
            }
            String productName = "";
            while (rs.next()) {
                 productName = rs.getString("product_name");
                double price = rs.getDouble("price");
                int quantity = rs.getInt("quantity");
                totalAmount += price * quantity;

                // Debugging: Output values
                System.out.println("Product: " + productName + ", Price: " + price + ", Quantity: " + quantity);
    %>

    <!-- Display Username -->
    <div class="alert alert-info">
        Logged in as: <strong><%= username %></strong>
    </div>
    <div class="order-summary">
        <h3>Your Order Summary</h3>
        <div class="order-item">
            <span><%= productName %> (x<%= quantity %>)</span>
            <span>Rs. <%= price * quantity %></span>
        </div>
    </div>
    <%
            }

            // Debugging: Ensure totalAmount is correctly set
            System.out.println("Total Amount: " + totalAmount);

            // Insert order details into orders and order_details tables
            String insertOrderQuery = "INSERT INTO orders (username, total_amount, order_date) VALUES (?, ?, NOW())";
            PreparedStatement orderStmt = conn.prepareStatement(insertOrderQuery, Statement.RETURN_GENERATED_KEYS);
            orderStmt.setString(1, username);
            orderStmt.setDouble(2, totalAmount);
            orderStmt.executeUpdate();
            rs = orderStmt.getGeneratedKeys();
            int orderId = 0;
            if (rs.next()) {
                orderId = rs.getInt(1);
            }

            // Insert each item in the cart into the order_details table
            String insertOrderDetailsQuery = "INSERT INTO order_details (order_id, product_name, quantity, price) VALUES (?, ?, ?, ?)";
            PreparedStatement orderDetailsStmt = conn.prepareStatement(insertOrderDetailsQuery);
            rs = ps.executeQuery();
            while (rs.next()) {
                String productId = rs.getString("product_name");
                int quantity = rs.getInt("quantity");
                double price = rs.getDouble("price");

                orderDetailsStmt.setInt(1, orderId);
                orderDetailsStmt.setString(2, productName);
                orderDetailsStmt.setInt(3, quantity);
                orderDetailsStmt.setDouble(4, price);
                orderDetailsStmt.executeUpdate();
            }

            // Update the product quantities in the products table
            String updateProductQuery = "UPDATE products SET quantity = quantity - ? WHERE product_name = ?";
            PreparedStatement updateProductStmt = conn.prepareStatement(updateProductQuery);
            rs = ps.executeQuery();
            while (rs.next()) {
                String productId = rs.getString("product_name");
                int quantity = rs.getInt("quantity");

                updateProductStmt.setInt(1, quantity);
                updateProductStmt.setString(2, productName);
                updateProductStmt.executeUpdate();
            }

            // Clear the cart after placing the order
            String clearCartQuery = "DELETE FROM cart";
            PreparedStatement clearCartStmt = conn.prepareStatement(clearCartQuery);
            clearCartStmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    %>

    <div class="order-summary">
        <div class="total">
            Total Amount: Rs. <%= totalAmount %>
        </div>
        <button class="btn btn-success btn-lg mt-3" onclick="window.location.href='index.jsp'">Complete Order</button>
    </div>


</div>

</body>
</html>
