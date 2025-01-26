<%@ page import="lk.ijse.assignmet01aadjsp.UserDTO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
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
<div class="container mt-5">
    <h2 class="text-center">User Management</h2>
    <a href="new" class="btn btn-primary mb-3">Add New User</a>

    <%--<%
        List<UserDTO> dataList = (List<UserDTO>) request.getAttribute("users");
        if (dataList != null && !dataList.isEmpty()) {
    %>--%>
    <table class="user table table-bordered table-striped">
        <thead>
        <tr>
            <th>ID</th>
            <th>Username</th>
            <th>Email</th>
            <th>Contact</th>
            <th>Role</th>
            <th>Status</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="user" items="${listUsers}">
            <tr>
                <td>${user.id}</td>
                <td>${user.username}</td>
                <td>${user.email}</td>
                <td>${user.contact}</td>
                <td>${user.role}</td>
                <td>${user.status}</td>
                <td>
                    <a href="edit?id=${user.id}" class="btn btn-warning btn-sm">Edit</a>
                    <a href="delete?id=${user.id}" class="btn btn-danger btn-sm">Delete</a>
                </td>
            </tr>
        </c:forEach>
     <%--  <%
           for(UserDTO userDTO : dataList) {
       %>
        <tr>
            <td><%=userDTO.getId()%></td>
            <td><%=userDTO.getUsername()%></td>
            <td><%=userDTO.getEmail()%></td>
            <td><%=userDTO.getContact()%></td>
            <td><%=userDTO.getRole()%></td>
            <td><%=userDTO.getStatus()%></td>
            <td>
                <a href="edit?id=<%= userDTO.getId() %>" class="btn btn-warning btn-sm">Edit</a>
                <a href="delete?id=<%= userDTO.getId() %>" class="btn btn-danger btn-sm">Delete</a>
            </td>
        </tr>
       <%
           }
       %>--%>
        </tbody>
    </table>
    <%--<%
        }
    %>--%>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
