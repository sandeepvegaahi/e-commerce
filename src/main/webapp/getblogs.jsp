<%@ page import="java.util.*,dao.BlogDAO,Model.Blog" %>
<%@ page import="Model.Admins" %>

<%
Admins admin = (Admins) session.getAttribute("admin");
if(admin == null){
    response.sendRedirect("admin-login.jsp");
    return;
}

BlogDAO dao = new BlogDAO();
List<Blog> list = dao.getAllBlogs();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>All Blogs</title>

<style>

body {
    font-family: 'Segoe UI';
    background: #f4f6f9;
    padding: 20px;
}

/* Top Bar */
.top-bar {
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:25px;
}

.top-bar h2 {
    color:#365c9c;
    margin:0;
}

/* Add Button */
/* Keep Add Button style */
.add-btn {
    text-decoration:none;
    padding:10px 18px;
    background:#365c9c;
    color:white;
    border-radius:6px;
    font-weight:500;
    transition:0.3s;
    margin-right:10px; /* space between Add and Back buttons */
}

.add-btn:hover {
    background:#2e4f87;
}

/* Back Button overrides */
.back {
    background: #2a5298;
}

.back:hover {
    background: #218838;
}

/* Blog Cards */
.card-container {
    display:grid;
    grid-template-columns: repeat(auto-fill,minmax(320px,1fr));
    gap:20px;
}

.card {
    background:white;
    padding:15px;
    border-radius:10px;
    box-shadow:0 5px 15px rgba(0,0,0,0.1);
    transition:0.3s;
     
    height: 400px;  
}

.card:hover {
    transform:translateY(-5px);
}

.card img {
    width:100%;
    height:200px;
    object-fit:cover;
    border-radius:8px;
}

.card h3 {
    margin:10px 0 5px;
}

.card p {
    font-size:14px;
    color:#555;
}

/* Buttons */
.button-group {
    margin-top:12px;
}

.button-group a {
    text-decoration:none;
    padding:6px 12px;
    border-radius:5px;
    color:white;
    font-size:14px;
    margin-right:5px;
}

.edit { background:#28a745; }
.delete { background:#dc3545; }

.edit:hover { background:#218838; }
.delete:hover { background:#c82333; }

</style>
</head>

<body>


<div class="top-bar">
    <h2>All Blogs</h2>
    <div>
        <a href="addblogs.jsp" class="add-btn"> Add Blog</a>
        <a href="dashboard.jsp" class="add-btn back">Back</a>
    </div>
</div>
<!-- Blog List -->
<div class="card-container">

<%
for(Blog b : list){
%>

<div class="card">

    <img src="<%= request.getContextPath() %>/blogsimg/<%= b.getImageUrl() %>" alt="Blog Image">

    <h3><%= b.getTitle() %></h3>
  
    <p>
    <%= b.getContent().length() > 120 ? 
        b.getContent().substring(0,120) + "..." : 
        b.getContent() %>
    </p>

    <small>Posted on: <%= b.getCreatedAt() %></small>

    <div class="button-group">
        <a class="edit" href="edit-blog.jsp?id=<%= b.getBlogId() %>">Edit</a>

        <a class="delete"
           href="DeleteBlogServlet?id=<%= b.getBlogId() %>"
           onclick="return confirm('Are you sure you want to delete this blog?')">
           Delete
        </a>
    </div>

</div>

<%
}
%>

</div>

</body>
</html>