<%@ page import="lk.ijse.assignmet01aadjsp.CategoryDTO" %>
<%@ page import="lk.ijse.assignmet01aadjsp.CategoryDAO" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    int categoryId = Integer.parseInt(request.getParameter("id"));
    CategoryDAO categoryDAO = new CategoryDAO();
    CategoryDTO category = categoryDAO.selectCategoryById(categoryId);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Category</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            padding: 20px;
        }
        .form-container {
            margin-top: 30px;
        }
        .form-container form {
            max-width: 600px;
            margin: auto;
        }
        .form-container h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        .form-container a {
            display: block;
            margin-top: 20px;
            text-align: center;
        }
    </style>
</head>
<body>

<div class="form-container">
    <h2>Edit Category</h2>


    <form action="categories" method="post">
        <input type="hidden" name="id" value="<%= category.getId() %>">

        <div class="mb-3">
            <label for="name" class="form-label">Category Name</label>
            <input type="text" name="name" id="name" value="<%= category.getName() %>" class="form-control" placeholder="Category Name" required>
        </div>

        <div class="mb-3">
            <label for="description" class="form-label">Description</label>
            <textarea name="description" id="description" class="form-control" placeholder="Description" required><%= category.getDescription() %></textarea>
        </div>

        <button type="submit" name="action" value="update" class="btn btn-primary">Update Category</button>
    </form>

    <a href="category-list.jsp" class="btn btn-secondary">Back to Categories List</a>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
