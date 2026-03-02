<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register | ShopEase</title>

<style>
body {
    margin: 0;
    font-family: 'Segoe UI', sans-serif;
    background-color: #f5ebe0; /* beige */
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
}

.register-container {
    background-color: #fffaf5; /* cream */
    padding: 40px;
    width: 380px;
    border-radius: 15px;
    box-shadow: 0px 8px 20px rgba(212,163,115,0.25);
}

h2 {
    text-align: center;
    color: #9c6644;
    margin-bottom: 25px;
}

input[type="text"],
input[type="email"],
input[type="password"],
input[type="tel"] {
    width: 100%;
    padding: 12px;
    margin-bottom: 15px;
    border: 1px solid #e6ccb2;
    border-radius: 8px;
    background-color: #fdf0e6;
    font-size: 14px;
}

input:focus {
    outline: none;
    border-color: #ddb892;
    background-color: #fff;
}

input[type="submit"] {
    width: 100%;
    padding: 12px;
    background-color: #e5989b; /* peach */
    border: none;
    border-radius: 8px;
    font-size: 15px;
    color: white;
    cursor: pointer;
    transition: 0.3s ease;
}

input[type="submit"]:hover {
    background-color: #d88c9a;
}

.login-link {
    text-align: center;
    margin-top: 15px;
    font-size: 14px;
}

.login-link a {
    color: #b5838d;
    text-decoration: none;
}

.login-link a:hover {
    text-decoration: underline;
}
</style>
</head>

<body>

<div class="register-container">
    <h2>Create Account</h2>

    <form action="${pageContext.request.contextPath}/RegisterServlet" method="post">

        <input type="text" name="fullName" placeholder="Full Name" required>

        <input type="email" name="email" placeholder="Email Address" required>

        <input type="tel" name="phone" placeholder="Phone Number">

        <input type="password" name="password" placeholder="Password" required>

        <input type="text" name="city" placeholder="City" required>

        <input type="text" name="state" placeholder="State" required>

        <input type="text" name="pincode" placeholder="Pincode" required>

        <input type="submit" value="Register">

    </form>

    <div class="login-link">
        Already have an account?
        <a href="<%=request.getContextPath()%>/user/login.jsp">Login</a>
    </div>
</div>

</body>
</html>