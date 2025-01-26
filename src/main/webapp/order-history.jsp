<%--
  Created by IntelliJ IDEA.
  User: Sehan
  Date: 26/01/2025
  Time: 15:30
  To change this template use File | Settings | File Templates.
--%><%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.*" %>
<html>
<head>
    <title>Orders</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }

        h2 {
            text-align: center;
            color: #333;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 12px 15px;
            text-align: center;
            font-size: 16px;
        }

        th {
            background-color: #4CAF50;
            color: white;
            text-transform: uppercase;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        tr:hover {
            background-color: #ddd;
            cursor: pointer;
        }

        td {
            background-color: #fff;
            border-bottom: 1px solid #ddd;
        }

        .total-amount {
            font-weight: bold;
            color: #2d7b2f;
        }

        table, th, td {
            border: 1px solid #ddd;
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
    <a href="admin-dash.jsp" class="btn btn-success">Go to Admin Dashboard</a>
</div>
<h2>Order Details</h2>

<table>
    <thead>
    <tr>
        <th>Order ID</th>
        <th>Username</th>
        <th>Total Amount</th>
        <th>Order Date</th>
    </tr>
    </thead>
    <tbody>
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

            // Query to fetch order data
            String query = "SELECT order_id, username, total_amount, order_date FROM orders";

            stmt = conn.createStatement();
            rs = stmt.executeQuery(query);

            // Loop through the result set and display the data
            while (rs.next()) {
                int orderId = rs.getInt("order_id");
                String username = rs.getString("username");
                double totalAmount = rs.getDouble("total_amount");
                Timestamp orderDate = rs.getTimestamp("order_date");

                // Display each row in the table
    %>
    <tr>
        <td><%= orderId %></td>
        <td><%= username %></td>
        <td class="total-amount">Rs.<%= totalAmount %></td>
        <td><%= orderDate %></td>
    </tr>
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
    </tbody>
</table>

</body>
</html>
