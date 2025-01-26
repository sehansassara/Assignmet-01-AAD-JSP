<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login - Shoe Store</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Custom CSS -->
  <style>
    body {
      background: linear-gradient(45deg, #ffafbd, #ffc3a0);
      height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
      font-family: 'Poppins', sans-serif;
    }
    .login-container {
      background: rgba(255, 255, 255, 0.1);
      backdrop-filter: blur(10px);
      -webkit-backdrop-filter: blur(10px);
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
      width: 100%;
      max-width: 400px;
      text-align: center;
      z-index: 100;
    }

    .login-container img.logo {
      width: 80px;
      height: auto;
      margin-bottom: 15px;
    }
    .login-container h1 {
      font-size: 26px;
      font-weight: bold;
      margin-bottom: 20px;
      color: #333;
    }
    .login-container .btn-primary {
      background: #ff6f61;
      border: none;
      transition: background 0.3s ease;
    }
    .login-container .btn-primary:hover {
      background: #e65550;
    }
    .login-container .sign-up-link {
      text-align: center;
      margin-top: 15px;
      font-size: 14px;
    }
    .login-container .sign-up-link a {
      color: #ff6f61;
      text-decoration: none;
      font-weight: bold;
    }
    .login-container .sign-up-link a:hover {
      text-decoration: underline;
    }
    .banner-container {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      overflow: hidden;
      background: url('image/sophisticated-nike-shoe-comparison-tool-digital-illustration_1036975-157439.png') center/cover no-repeat;
    }
    .banner-container img.banner {
      width: 100%;
      height: auto;
    }
  </style>
</head>
<body>

<!-- Banner Section -->
<div class="banner-container">
  <img src="image/Shoes.jpg" class="banner">
</div>

<!-- Login Form -->
<div class="login-container">
  <img src="image/Shoes.jpg" alt="Logo" class="logo">
  <h1>Welcome Back!</h1>
  <form action="log-in" method="post">
    <div class="mb-3 text-start">
      <label for="username" class="form-label">Username</label>
      <input type="text" class="form-control" id="username" name="username" placeholder="Enter your username" required>
    </div>
    <div class="mb-3 text-start">
      <label for="password" class="form-label">Password</label>
      <input type="password" class="form-control" id="password" name="password" placeholder="Enter your password" required>
    </div>
    <button type="submit" class="btn btn-primary w-100">Login</button>
  </form>
  <div class="sign-up-link">
    <p>Don't have an account? <a href="sign-up.jsp">Sign Up</a></p>
  </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>


