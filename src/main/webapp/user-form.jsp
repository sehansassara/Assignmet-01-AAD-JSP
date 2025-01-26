<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${user != null ? "Edit User" : "Add New User"}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2 class="text-center">${user != null ? "Edit User" : "Add New User"}</h2>
    <form action="${user != null ? 'update' : 'insert'}" method="post">
        <input type="hidden" name="id" value="${user != null ? user.id : ''}">
        <div class="mb-3">
            <label for="username" class="form-label">Username</label>
            <input type="text" class="form-control" id="username" name="username" value="${user != null ? user.username : ''}" required>
        </div>
        <div class="mb-3">
            <label for="email" class="form-label">Email</label>
            <input type="email" class="form-control" id="email" name="email" value="${user != null ? user.email : ''}" required>
        </div>
        <div class="mb-3">
            <label for="contact" class="form-label">Contact</label>
            <input type="text" class="form-control" id="contact" name="contact" value="${user != null ? user.contact : ''}" required>
        </div>
        <div class="mb-3">
            <label for="contact" class="form-label">Password</label>
            <input type="text" class="form-control" id="password" name="password" value="${user != null ? user.password : ''}" required>
        </div>
        <div class="mb-3">
            <label for="role" class="form-label">Role</label>
            <input type="text" class="form-control" id="role" name="role" value="${user != null ? user.role : ''}" required>
        </div>
        <div class="mb-3">
            <label for="status" class="form-label">Status</label>
            <input type="text" class="form-control" id="status" name="status" value="${user != null ? user.status : ''}" required>
        </div>
        <button type="submit" class="btn btn-success">${user != null ? "Update" : "Add"} User</button>
    </form>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
