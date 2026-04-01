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
<title>My Profile | ShopEase</title>

<style>

body{
margin:0;
font-family:'Segoe UI',sans-serif;
background:#f5ebe0;
display:flex;
justify-content:center;
align-items:center;
height:100vh;
}

/* Profile Card */

.container{
width:450px;
background:white;
padding:30px;
border-radius:12px;
box-shadow:0px 6px 15px rgba(0,0,0,0.15);
position:relative;
}

/* Title */

h2{
text-align:center;
margin-bottom:25px;
color:#9c6644;
}

/* User Info */

.info p{
font-size:15px;
margin:10px 0;
color:#4e342e;
}

/* Action buttons (top right) */

.top-right{
position:absolute;
top:15px;
right:15px;
display:flex;
gap:18px;
}

.action{
text-align:center;
text-decoration:none;
font-size:12px;
color:black;
}

.action img{
width:26px;
height:26px;
display:block;
margin:auto;
}

/* Back button */

.back{
text-align:center;
margin-top:25px;
}

.back a{
text-decoration:none;
background:#ddb892;
color:white;
padding:10px 18px;
border-radius:6px;
font-size:14px;
}

.back a:hover{
background:#c89f7a;
}

</style>

</head>
<body>

<div class="container">

<!-- Top Right Edit + Deactivate -->

<div class="top-right">

<a href="<%=request.getContextPath()%>/user/editProfile.jsp" class="action">
<img src="<%=request.getContextPath()%>/images/edit.jpg">
Edit
</a>

<a href="<%=request.getContextPath()%>/DeactivateServlet" class="action"
onclick="return confirm('Are you sure you want to deactivate your account?');">
<img src="<%=request.getContextPath()%>/images/delete.jpg">
Deactivate
</a>

</div>

<h2>My Profile</h2>

<div class="info">

<p><b>Name:</b> <%=user.getFullName()%></p>

<p><b>Email:</b> <%=user.getEmail()%></p>

<p><b>Phone:</b> <%=user.getPhone()%></p>

<p><b>City:</b> <%=user.getCity()%></p>

<p><b>State:</b> <%=user.getState()%></p>

<p><b>Pincode:</b> <%=user.getPincode()%></p>

</div>

<div class="back">
<a href="<%=request.getContextPath()%>/user/home.jsp">Back to Home</a>
</div>

</div>

</body>
</html>