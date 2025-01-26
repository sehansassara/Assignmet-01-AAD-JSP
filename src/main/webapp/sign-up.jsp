<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Sign-Up Page</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- SweetAlert2 CSS -->
  <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.20/dist/sweetalert2.min.css" rel="stylesheet">
  <!-- Custom CSS -->
  <style>
    body {
      background: linear-gradient(45deg, #ffafbd, #ffc3a0);
      height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
      font-family: Arial, sans-serif;
    }
    .signup-container {
      background: white;
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
      width: 100%;
      max-width: 450px;
    }
    .signup-container h1 {
      font-size: 24px;
      font-weight: bold;
      margin-bottom: 20px;
      color: #333;
      text-align: center;
    }
    .signup-container .btn-primary {
      background: #ff6f61;
      border: none;
    }
    .signup-container .btn-primary:hover {
      background: #e65550;
    }
    .signup-container .login-link {
      text-align: center;
      margin-top: 15px;
      font-size: 14px;
    }
    .signup-container .login-link a {
      color: #ff6f61;
      text-decoration: none;
      font-weight: bold;
    }
    .signup-container .login-link a:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>

<%
  String message = request.getParameter("message");
  String error = request.getParameter("error");
%>

<!-- SweetAlert2 JS -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.20/dist/sweetalert2.all.min.js"></script>

<!-- Display Success Message with SweetAlert2 -->
<%
  if (message != null) {
%>
<script>
  window.onload = function() {
    Swal.fire({
      icon: 'success',
      title: 'Success!',
      text: '<%= message %>',
      confirmButtonText: 'Okay'
    });
  };
</script>
<%
  }
%>

<!-- Display Error Message with SweetAlert2 -->
<%
  if (error != null) {
%>
<script>
  window.onload = function() {
    Swal.fire({
      icon: 'error',
      title: 'Oops!',
      text: '<%= error %>',
      confirmButtonText: 'Try Again'
    });
  };
</script>
<%
  }
%>

<div class="signup-container">
  <h1>Sign Up</h1>
  <form action="sign-up" method="post">
    <div class="mb-3">
      <label for="username" class="form-label">Username</label>
      <input type="text" class="form-control" id="username" name="username" placeholder="Enter your username" required>
    </div>
    <div class="mb-3">
      <label for="email" class="form-label">Email</label>
      <input type="email" class="form-control" id="email" name="email" placeholder="Enter your email" required>
    </div>
    <div class="mb-3">
      <label for="password" class="form-label">Password</label>
      <input type="password" class="form-control" id="password" name="password" placeholder="Enter your password" required>
    </div>
    <div class="mb-3">
      <label for="contact" class="form-label">Contact Number</label>
      <input type="text" class="form-control" id="contact" name="contact" placeholder="Enter your contact number" required>
    </div>
   <%-- <div class="mb-3">
      <label for="role" class="form-label">User Role</label>
      <select class="form-select" id="role" name="role" required>
        <option value="" disabled selected>Select a role</option>
        <option value="admin">Admin</option>
        <option value="customer">Customer</option>
      </select>
    </div>--%>
    <button type="submit" class="btn btn-primary w-100">Sign Up</button>
  </form>
  <div class="login-link">
    <p>Already have an account? <a href="log-in.jsp">Login</a></p>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>


