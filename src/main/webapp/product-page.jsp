<%--<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Product Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            margin-top: 30px;
        }
        table img {
            border-radius: 5px;
        }
        .btn {
            margin-right: 5px;
        }
    </style>
</head>
<body>
<h1>Product Management</h1>

<!-- Form for Adding/Updating a Product -->
<form action="ProductServlet" method="post" enctype="multipart/form-data">
    <input type="hidden" name="action" value="<%= request.getParameter("editId") == null ? "save" : "update" %>">
    <%
        String editId = request.getParameter("editId");
        String name = "", description = "", price = "", cid = "", imageUrl = "", quantity = "";

        if (editId != null) {
            try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/assignment", "root", "Ijse@123");
                 PreparedStatement ps = conn.prepareStatement("SELECT * FROM products WHERE id = ?")) {

                Class.forName("com.mysql.cj.jdbc.Driver");
                ps.setInt(1, Integer.parseInt(editId));
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        name = rs.getString("name");
                        description = rs.getString("description");
                        price = rs.getString("price");
                        cid = rs.getString("cid");
                        imageUrl = rs.getString("image_url");
                        quantity = rs.getString("quantity");
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    %>
    <input type="hidden" name="id" value="<%= editId %>">
    <label>Product Name:</label>
    <input type="text" name="name" value="<%= name %>" required><br><br>

    <label>Description:</label>
    <textarea name="description"><%= description %></textarea><br><br>

    <label>Price:</label>
    <input type="number" step="0.01" name="price" value="<%= price %>" required><br><br>

    <label>Category:</label>
    <select name="cid" required>
        <option value="">Select Category</option>
        <%
            try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/assignment", "root", "Ijse@123");
                 PreparedStatement ps = conn.prepareStatement("SELECT cid, name FROM categories");
                 ResultSet rs = ps.executeQuery()) {

                Class.forName("com.mysql.cj.jdbc.Driver");
                while (rs.next()) {
                    int categoryId = rs.getInt("cid");
                    String categoryName = rs.getString("name");
                    boolean selected = cid.equals(String.valueOf(categoryId));
        %>
        <option value="<%= categoryId %>" <%= selected ? "selected" : "" %>>
            <%= categoryName %>
        </option>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </select><br><br>

    <div class="mb-3">
        <label for="image" class="form-label">Product Image:</label>
        <input type="file" class="form-control" name="image_url" id="image">
    </div>


    <label>Quantity:</label>
    <input type="number" name="quantity" value="<%= quantity %>" required><br><br>

    <button type="submit"><%= editId == null ? "Save Product" : "Update Product" %></button>
</form>

<!-- Product List Table -->
<h2>Product List</h2>
<table border="1">
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Description</th>
        <th>Price</th>
        <th>Category</th>
        <th>Image</th>
        <th>Quantity</th>
        <th>Actions</th>
    </tr>
    <%
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/assignment", "root", "Ijse@123");
             PreparedStatement ps = conn.prepareStatement(
                     "SELECT p.*, c.name AS category_name FROM products p " +
                             "LEFT JOIN categories c ON p.cid = c.cid");
             ResultSet rs = ps.executeQuery()) {

            Class.forName("com.mysql.cj.jdbc.Driver");
            while (rs.next()) {
    %>
    <tr>
        <td><%= rs.getInt("id") %></td>
        <td><%= rs.getString("name") %></td>
        <td><%= rs.getString("description") %></td>
        <td><%= rs.getDouble("price") %></td>
        <td><%= rs.getString("category_name") %></td>
        <td><img src="<%= rs.getString("image_url") %>" width="50"></td>
        <td><%= rs.getInt("quantity") %></td>
       &lt;%&ndash; <td>
            <a href="product-page.jsp?editId=<%= rs.getInt("id") %>">Edit</a>
            <a href="ProductServlet?action=delete&id=<%= rs.getInt("id") %>">Delete</a>
        </td>&ndash;%&gt;
        <td>
            <a href="ProductServlet?action=edit&editId=<%= rs.getInt("id") %>">Edit</a>
            <a href="ProductServlet?action=delete&id=<%= rs.getInt("id") %>">Delete</a>
        </td>

    </tr>
    <%
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
</table>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>--%>


<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f4f4f4;
        }
        .container {
            margin-top: 30px;
            background: #fff;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        h1, h2 {
            color: #343a40;
        }
        .form-label {
            font-weight: bold;
        }
        .form-control, .btn {
            border-radius: 8px;
        }
        .btn-primary {
            background: #007bff;
            border: none;
        }
        .btn-primary:hover {
            background: #0056b3;
        }
        table {
            margin-top: 20px;
        }
        table th, table td {
            text-align: center;
            vertical-align: middle;
        }
        table img {
            border-radius: 8px;
        }
        table th {
            background-color: #343a40;
            color: #fff;
        }
        table tbody tr:hover {
            background-color: #f1f1f1;
        }
        .action-btns a {
            margin-right: 8px;
        }
        .action-btns a.btn-edit {
            color: #007bff;
            text-decoration: none;
        }
        .action-btns a.btn-delete {
            color: #dc3545;
            text-decoration: none;
        }
        .action-btns a:hover {
            text-decoration: underline;
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
<div class="container">
    <h1 class="text-center mb-4">Product Management</h1>

    <!-- Form for Adding/Updating a Product -->
    <form action="ProductServlet" method="post" enctype="multipart/form-data" class="mb-4">
        <input type="hidden" name="action" value="<%= request.getParameter("editId") == null ? "save" : "update" %>">

        <%
            String editId = request.getParameter("editId");
            String name = "", description = "", price = "", cid = "", imageUrl = "", quantity = "";

            if (editId != null) {
                try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/assignment", "root", "Ijse@123");
                     PreparedStatement ps = conn.prepareStatement("SELECT * FROM products WHERE id = ?")) {

                    Class.forName("com.mysql.cj.jdbc.Driver");
                    ps.setInt(1, Integer.parseInt(editId));
                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            name = rs.getString("product_name");
                            description = rs.getString("description");
                            price = rs.getString("price");
                            cid = rs.getString("name");
                            imageUrl = rs.getString("image_url");
                            quantity = rs.getString("quantity");
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        %>
        <input type="hidden" name="id" value="<%= editId %>">

        <div class="mb-3">
            <label for="name" class="form-label">Product Name:</label>
            <input type="text" id="name" name="name" class="form-control" value="<%= name %>" required>
        </div>

        <div class="mb-3">
            <label for="description" class="form-label">Description:</label>
            <textarea id="description" name="description" class="form-control" rows="3"><%= description %></textarea>
        </div>

        <div class="mb-3">
            <label for="price" class="form-label">Price:</label>
            <input type="number" id="price" step="0.01" name="price" class="form-control" value="<%= price %>" required>
        </div>

        <div class="mb-3">
            <label for="category" class="form-label">Category:</label>
            <select id="category" name="cid" class="form-select" required>
                <option value="">Select Category</option>
                <%
                    try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/assignment", "root", "Ijse@123");
                         PreparedStatement ps = conn.prepareStatement("SELECT cid, name FROM categories");
                         ResultSet rs = ps.executeQuery()) {

                        Class.forName("com.mysql.cj.jdbc.Driver");
                        while (rs.next()) {
                            int categoryId = rs.getInt("cid");
                            String categoryName = rs.getString("name");
                            boolean selected = cid.equals(String.valueOf(categoryName));
                %>
                <option value="<%= categoryName %>" <%= selected ? "selected" : "" %>>
                    <%= categoryName %>
                </option>
                <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                %>
            </select>
        </div>

        <div class="mb-3">
            <label for="image" class="form-label">Product Image:</label>
            <input type="file" id="image" class="form-control" name="image_url">
        </div>

        <div class="mb-3">
            <label for="quantity" class="form-label">Quantity:</label>
            <input type="number" id="quantity" name="quantity" class="form-control" value="<%= quantity %>" required>
        </div>

        <button type="submit" class="btn btn-primary w-100"><%= editId == null ? "Save Product" : "Update Product" %></button>
    </form>

    <!-- Product List Table -->
    <h2 class="text-center">Product List</h2>
    <table class="table table-striped table-bordered">
        <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Description</th>
            <th>Price</th>
            <th>Category</th>
            <th>Image</th>
            <th>Quantity</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/assignment", "root", "Ijse@123");
                 PreparedStatement ps = conn.prepareStatement(
                         "SELECT p.*, c.name AS category_name FROM products p " +
                                 "LEFT JOIN categories c ON p.name = c.name");
                 ResultSet rs = ps.executeQuery()) {

                Class.forName("com.mysql.cj.jdbc.Driver");
                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getString("description") %></td>
            <td><%= rs.getDouble("price") %></td>
            <td><%= rs.getString("category_name") %></td>
            <td>
                <img src="<%= request.getContextPath() + rs.getString("image_url") %>"
                     alt="<%= rs.getString("name") %>"
                     width="220" height="200">
            </td>
            <td><%= rs.getInt("quantity") %></td>
            <td>
                <a href="ProductServlet?action=edit&editId=<%= rs.getInt("id") %>" class="btn btn-warning">Edit</a>
                <a href="ProductServlet?action=delete&id=<%= rs.getInt("id") %>" class="btn btn-danger">Delete</a>
            </td>
        </tr>

        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
        </tbody>
    </table>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
