<%@ page import="java.util.*,dao.BlogDAO,model.Blog" %>
<%@ page import="model.Admins" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
Admins admin = (Admins) session.getAttribute("admin");
Object user = session.getAttribute("user");

boolean isAdmin = (admin != null);
boolean isUser = (user != null);

if(!isAdmin && !isUser){
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

/* PAGE */
body {
    font-family: 'Segoe UI', sans-serif;
    background: #f5ebe0;
    padding: 20px;
    margin: 0;
}

/* TOP BAR */
.top-bar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
}

.top-bar h2 {
    color: #4e342e;
}

/* BUTTONS */
.add-btn {
    text-decoration: none;
    padding: 10px 18px;
    background: #8d6e63;
    color: white;
    border-radius: 6px;
    font-weight: 500;
    transition: 0.3s;
    margin-right: 10px;
}

.add-btn:hover {
    background: #6d4c41;
}

.back {
    background: #a1887f;
}

.back:hover {
    background: #795548;
}

/* CARD CONTAINER */
.card-container {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
    gap: 20px;
}

/* CARD */
.card {
    background: #fffaf5;
    padding: 15px;
    border-radius: 12px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.08);
    transition: 0.3s;
    cursor: pointer;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    height: 420px;
}

.card:hover {
    transform: translateY(-5px);
}

/* CARD IMAGE */
.card img {
    width: 100%;
    height: 180px;
    object-fit: cover;
    border-radius: 10px;
}

/* CARD TEXT */
.card h3 {
    color: #4e342e;
    margin: 10px 0 5px;
}

.card p {
    font-size: 14px;
    color: #6d4c41;
    flex-grow: 1;
}

/* DATE */
.card small {
    color: #8d6e63;
    font-size: 12px;
}

/* BUTTON GROUP */
.button-group {
    margin-top: 10px;
}

.button-group a {
    text-decoration: none;
    padding: 6px 12px;
    border-radius: 5px;
    color: white;
    font-size: 13px;
    margin-right: 5px;
}

/* EDIT / DELETE */
.edit {
    background: #81c784;
}

.delete {
    background: #e57373;
}

.edit:hover {
    background: #66bb6a;
}

.delete:hover {
    background: #ef5350;
}

/* MODAL BACKGROUND */
/* MODAL BACKGROUND */
.modal {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;

    /* light overlay */
    background: rgba(0,0,0,0.4);

    /* center content */
    display: flex;
    align-items: center;
    justify-content: center;

    z-index: 999;
}

/* MODAL BOX (HALF POPUP STYLE) */
.modal-content {
    background: #fffaf5;
    width: 50%;              /* 🔥 HALF WIDTH */
    max-width: 600px;
    height: auto;
    max-height: 70vh;

    padding: 20px;
    border-radius: 12px;

    overflow-y: auto;

    /* animation */
    transform: scale(0.9);
    transition: 0.3s ease;
}

/* SHOW ANIMATION */
.modal.show .modal-content {
    transform: scale(1);
}
 
/* BLOG VIEW INSIDE MODAL */
.blog-view {
    display: flex;
    flex-direction: column;
    gap: 10px;
}

/* FIXED IMAGE IN MODAL */
.blog-img {
    width: 100%;
    max-height: 250px;
    object-fit: cover;
    border-radius: 10px;
}

/* MODAL TEXT */
.blog-view h2 {
    color: #4e342e;
    margin-top: 10px;
}

.blog-view .content {
    color: #5d4037;
    line-height: 1.6;
}
</style>
</head>

<body>

<div class="top-bar">
    <h2>All Blogs</h2>
    <div>
        <% if(isAdmin){ %>
            <a href="addblogs.jsp" class="add-btn">Add Blog</a>
        <% } %>
        <a href="dashboard.jsp" class="add-btn back">Back</a>
    </div>
</div>

<!-- Blog List -->
<div class="card-container">

<%
for(Blog b : list){
%>

<div class="card" onclick="openBlog(<%=b.getBlogId()%>)">

    <img src="<%= request.getContextPath() %>/blogsimg/<%= b.getImageUrl() %>" alt="Blog Image">

    <h3><%= b.getTitle() %></h3>
  
    <p>
    <%= b.getContent().length() > 120 ? 
        b.getContent().substring(0,120) + "..." : 
        b.getContent() %>
    </p>

    <small>Posted on: <%= b.getCreatedAt() %></small>

    <% if(isAdmin){ %>
    <div class="button-group" onclick="event.stopPropagation();">
        <a class="edit" href="edit-blog.jsp?id=<%= b.getBlogId() %>">Edit</a>

        <a class="delete"
           href="DeleteBlogServlet?id=<%= b.getBlogId() %>"
           onclick="return confirm('Are you sure you want to delete this blog?')">
           Delete
        </a>
    </div>
    <% } %>

</div>

<%
}
%>

</div>

<!-- MODAL -->
<div id="blogModal" class="modal">
    <div class="modal-content" id="modalContent"></div>
</div>

<script>
function openBlog(id){
    fetch("viewBlog.jsp?id=" + id)
    .then(res => res.text())
    .then(data => {
        document.getElementById("modalContent").innerHTML = data;
        let modal = document.getElementById("blogModal");
        modal.style.display = "flex";
        modal.classList.add("show");
    });
}

// close modal
window.onclick = function(e){
    let modal = document.getElementById("blogModal");
    if(e.target == modal){
        modal.style.display = "none";
        modal.classList.remove("show");
    }
}
</script>

</body>
</html>