<%@ page import="model.Admins" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
Admins admin = (Admins) session.getAttribute("admin");

if(admin == null){
    response.sendRedirect("index.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Product</title>
<link rel="icon" href="images/ican.jpg"> 

<style>


/* Page Style */

body {
    font-family: 'Segoe UI', Arial, sans-serif;
    background: #f4f6f9;
    margin:0;
}

h2 {
    text-align: center;
    color: #1e3c72;
    margin-top: 20px;
}

form {
    background: white;
    padding: 25px;
    margin: 30px auto;
    max-width: 800px;
    border-radius: 10px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.1);
}

.form-row {
    display: flex;
    gap: 20px;
    margin-bottom: 15px;
}

.form-group {
    flex: 1;
    display: flex;
    flex-direction: column;
}

.form-group label {
    font-weight: bold;
    margin-bottom: 5px;
}

.form-group input,
textarea {
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 5px;
    width: 100%;
}

.full-width {
    margin-bottom: 15px;
}

input[type="submit"] {
    background: #2a5298;
    color: white;
    border: none;
    padding: 12px;
    border-radius: 6px;
    cursor: pointer;
    width: 100%;
}

input[type="submit"]:hover {
    background: #1e3c72;
}

</style>
</head>

<body>

<jsp:include page="navbar.jsp" />


<h2>Add Product</h2>

<form action="AdminProductServlet" method="post">

<div class="form-row">
    <div class="form-group">
        <label>Name</label>
        <input type="text" name="name" required>
    </div>

    <div class="form-group">
        <label>Category</label>
        <input type="text" name="category" required>
    </div>
</div>

<div class="form-row">
    <div class="form-group">
        <label>Actual Price</label>
        <input type="text" name="actualPrice" required>
    </div>

    <div class="form-group">
        <label>Offer Price</label>
        <input type="text" name="offerPrice" required>
    </div>
</div>

<div class="form-row">
    <div class="form-group">
        <label>Stock</label>
        <input type="number" name="stock" required>
    </div>

    <div class="form-group">
        <label>Image Name Url</label>
        <input type="text" name="image">
    </div>
</div>

<div class="full-width">
<label>Description</label>
<textarea name="description" rows="4"></textarea>
</div>

<input type="submit" value="Add Product">

</form>

</body>
</html>