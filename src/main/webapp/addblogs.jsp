<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Admins" %>

<%
Admins admin = (Admins) session.getAttribute("admin");
if(admin == null){
    response.sendRedirect("admin-login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Blog</title>

<style>

body {
    font-family: 'Segoe UI';
    background: #f4f6f9;
    margin:0;
}

/* Navbar */
.navbar{
    display:flex;
    justify-content:space-between;
    align-items:center;
    background:#1e3c72;
    padding:15px 40px;
    color:white;
}

.navbar .title{
    font-size:20px;
    font-weight:600;
}

.navbar ul{
    list-style:none;
    display:flex;
    gap:20px;
    margin:0;
    padding:0;
}

.navbar ul li a{
    text-decoration:none;
    color:white;
    font-size:15px;
    padding:8px 14px;
    border-radius:6px;
}

.navbar ul li a:hover{
    background:#2a5298;
}

/* Form */

h2 {
    text-align:center;
    color:#365c9c;
    margin-top:30px;
}

form {
    max-width:600px;
    margin:30px auto;
    background:white;
    padding:25px;
    border-radius:10px;
    box-shadow:0 5px 15px rgba(0,0,0,0.1);
}

input, textarea {
    width:100%;
    padding:10px;
    margin:8px 0;
    border:1px solid #ccc;
    border-radius:5px;
}

.button-group {
    display: flex;
    gap: 10px;
    margin-top: 10px;
}

.submit-btn {
    background: #365c9c;
    color: white;
    border: none;
    cursor: pointer;
    padding: 10px 20px;
    border-radius: 5px;
}

.submit-btn:hover {
    background: #2e4f87;
}

.back-btn {
    background: #365c9c;
    color: white;
    border: none;
    cursor: pointer;
    padding: 10px 20px;
    border-radius: 5px;
}

.back-btn:hover {
    background: #555;
}

</style>
</head>

<body>

<jsp:include page="navbar.jsp" />


<h2>Add New Blog</h2>

<form action="AdminBlogServlet" method="post">

<label>Title</label>
<input type="text" name="title" required>

<label>Image Name</label>
<input type="text" name="image">

<label>Content</label>
<textarea name="content" rows="5" required></textarea>

<div class="button-group">
<input type="submit" value="Add Blog" class="submit-btn">
<input type="button" value="Back" class="back-btn" onclick="window.location.href='dashboard.jsp';">
</div>

</form>

</body>
</html>