<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.User" %>

<%
User user = (User) session.getAttribute("user");

if(user == null){
    response.sendRedirect(request.getContextPath()+"/user/login.jsp");
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Profile</title>

<style>

body{
font-family:Arial;
background:#f5ebe0;
}

.container{
width:420px;
margin:auto;
margin-top:80px;
background:white;
padding:30px;
border-radius:10px;
box-shadow:0 0 10px rgba(0,0,0,0.2);
}

h2{
text-align:center;
margin-bottom:20px;
color:#9c6644;
}

input{
width:100%;
padding:10px;
margin:8px 0;
border-radius:6px;
border:1px solid #ccc;
}

button{
width:100%;
padding:10px;
margin-top:15px;
background:#ddb892;
border:none;
border-radius:6px;
cursor:pointer;
font-size:15px;
}

button:hover{
background:#c89f7a;
}

</style>

</head>
<body>

<div class="container">

<h2>Edit Profile</h2>

<form action="<%=request.getContextPath()%>/UpdateProfileServlet" method="post">

<input type="hidden" name="userId" value="<%=user.getUserId()%>">

<input type="text" name="fullName" value="<%=user.getFullName()%>" required>

<input type="email" name="email" value="<%=user.getEmail()%>" required>

<input type="text" name="phone" value="<%=user.getPhone()%>" required>

<input type="text" name="city" value="<%=user.getCity()%>" required>

<input type="text" name="state" value="<%=user.getState()%>" required>

<input type="number" name="pincode" value="<%=user.getPincode()%>" required>

<button type="submit">Update Profile</button>

</form>

</div>

</body>
</html>