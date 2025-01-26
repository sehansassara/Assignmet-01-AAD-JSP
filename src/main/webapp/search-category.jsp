<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: Sehan
  Date: 26/01/2025
  Time: 13:34
  To change this template use File | Settings | File Templates.
--%><!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Filtered Products</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-4">
    <h2 class="text-center mb-4">Filtered Products</h2>
    <div class="row">
        <%
            String filterType = request.getParameter("filterType");
            String query = "SELECT * FROM products";

            if (filterType != null && !filterType.isEmpty()) {
                if (filterType.startsWith("category:")) {
                    String category = filterType.replace("category:", "");
                    query = "SELECT * FROM products WHERE name = '" + category + "'";
                } else if (filterType.startsWith("product:")) {
                    String productName = filterType.replace("product:", "");
                    query = "SELECT * FROM products WHERE product_name = '" + productName + "'";
                } else if (filterType.equals("under10000")) {
                    query = "SELECT * FROM products WHERE price < 10000";
                } else if (filterType.equals("over10000")) {
                    query = "SELECT * FROM products WHERE price > 10000";
                }
            }

            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;

            String dbUrl = "jdbc:mysql://localhost:3306/assignment";
            String dbUser = "root";
            String dbPassword = "Ijse@123";

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
                stmt = ((Connection) conn).createStatement();
                rs = stmt.executeQuery(query);

                while (rs.next()) {
                    String productName = rs.getString("product_name");
                    double price = rs.getDouble("price");
                    String category = rs.getString("name");
                    String quantity = rs.getString("quantity");
                    String imageUrl = rs.getString("image_url");
        %>
        <div class="col-md-4 mb-4">
            <div class="card shadow-lg rounded">
                <img src="<%= request.getContextPath() + "/" + imageUrl %>"
                     alt="<%= productName %>"
                     class="card-img-top"
                     width="220"
                     height="200">
                <div class="card-body">
                    <h5 class="card-title text-truncate" style="max-width: 200px;"><%= productName %></h5>
                    <p class="card-text"><strong>Category:</strong> <%= category %></p>
                    <p class="card-text"><strong>Price:</strong> RS.<%= price %></p>
                    <p class="card-text"><strong>Quantity:</strong> <%= quantity %></p>
                    <button class="btn btn-primary w-100 mt-3" onclick="addToCart(<%= rs.getInt("id") %>)">Add to Cart</button>
                </div>
            </div>
        </div>
        <%
                }
            } catch (Exception e) {
                System.out.println("Error: " + e.getMessage());
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
</div>

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

</script>
</body>
</html>
