<%@ page import="Model.Admins" %> 

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
    padding: 20px;
}

h2 {
    text-align:center;
    color:#365c9c;
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

/* Buttons styling */
.button-group {
    display: flex;
    gap: 10px; /* space between buttons */
    justify-content: flex-start; /* align left, can use center if you want centered */
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
    background: #365c9c; /* gray color */
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

<h2>Add New Blog</h2>

<form action="AdminBlogServlet" method="post">
    <label>Title</label>
    <input type="text" name="title" required>

    <label>Image Name </label>
    <input type="text" name="image">

    <label>Content</label>
    <textarea name="content" rows="5" required></textarea>

    <!-- Buttons side by side -->
    <div class="button-group">
        <input type="submit" value="Add Blog" class="submit-btn">
        <input type="button" value="Back" class="back-btn" onclick="window.location.href='dashboard.jsp';">
    </div>
</form>

</body>
</html>