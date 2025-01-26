<%@ page import="java.util.List" %>
<%@ page import="lk.ijse.assignmet01aadjsp.CategoryDTO" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Category Management</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            padding: 20px;
        }
        .form-container {
            margin-bottom: 30px;
        }
        .table-container {
            margin-top: 20px;
        }
        .actions a {
            margin-right: 10px;
        }
        .search-form {
            margin-top: 20px;
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

<h2>Category Management</h2>
<div class="top-right-button">
    <a href="admin-dash.jsp" class="btn btn-success">Go to Admin Dashboard</a>
</div>
<div class="form-container">
    <form action="categories" method="post" class="form-inline">
        <input type="text" name="name" placeholder="Category Name" class="form-control mr-2" required>
        <textarea name="description" placeholder="Description" class="form-control mr-2" required></textarea>
        <button type="submit" name="action" value="insert" class="btn btn-primary">Add Category</button>
    </form>
</div>

<div class="search-form">
    <form action="categories" method="post" class="form-inline">
        <input type="text" name="searchTerm" placeholder="Search by Category Name" class="form-control mr-2" required>
        <button type="submit" name="action" value="search" class="btn btn-secondary">Search</button>
    </form>
</div>

<div class="table-container">
    <table class="table table-bordered table-striped">
        <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Description</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="category" items="${categories}">
            <tr>
                <td>${category.id}</td>
                <td>${category.name}</td>
                <td>${category.description}</td>
                <td class="actions">

                    <a href="category-form.jsp?id=${category.id}" class="btn btn-warning btn-sm">Edit</a>

                    <form action="categories" method="post" style="display:inline;">
                        <input type="hidden" name="id" value="${category.id}">
                        <button type="submit" name="action" value="delete" class="btn btn-danger btn-sm">Delete</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
