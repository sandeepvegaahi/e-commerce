<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>

<style>

body{
    margin:0;
    font-family: Arial, sans-serif;
    background: linear-gradient(120deg,#f7e6d4,#fceee3);
    height:100vh;
    display:flex;
    justify-content:center;
    align-items:center;
}

/* Login Card */

.login-container{
    background:white;
    padding:40px;
    width:350px;
    border-radius:12px;
    box-shadow:0 4px 15px rgba(0,0,0,0.1);
}

.login-container h2{
    text-align:center;
    margin-bottom:25px;
    color:#5a4a42;
}

/* Inputs */

input[type="email"],
input[type="password"]{

    width:100%;
    padding:12px;
    margin:10px 0;
    border-radius:6px;
    border:1px solid #ddd;
    font-size:14px;
}

/* Button */

input[type="submit"]{

    width:100%;
    padding:12px;
    background:#f4a896;
    border:none;
    color:white;
    font-size:16px;
    border-radius:6px;
    cursor:pointer;
}

input[type="submit"]:hover{
    background:#f08a72;
}

/* Register link */

.register-link{
    text-align:center;
    margin-top:15px;
}

.register-link a{
    color:#f08a72;
    text-decoration:none;
}

.register-link a:hover{
    text-decoration:underline;
}

/* Error Message */

.error-message{
    color:red;
    text-align:center;
    margin-bottom:10px;
}

</style>

</head>

<body>

<div class="login-container">

<h2>Welcome Back</h2>

<%
String error = (String) request.getAttribute("errorMessage");
if(error != null){
%>

<div class="error-message">
    <%= error %>
</div>

<%
}
%>

<form action="<%=request.getContextPath()%>/LoginServlet" method="post">

<input type="email" name="email" placeholder="Enter Email" required>

<input type="password" name="password" placeholder="Enter Password" required>

<input type="submit" value="Login">
 
</form>

<div class="register-link">
    Don't have an account? 
    <a href="<%=request.getContextPath()%>/user/register.jsp">Register</a>
</div>

</div>

</body>
</html>