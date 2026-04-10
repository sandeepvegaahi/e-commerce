<%@ page import="dao.BlogDAO,model.Blog" %>

<%
int id = Integer.parseInt(request.getParameter("id"));

BlogDAO dao = new BlogDAO();
Blog blog = null;

for(Blog b : dao.getAllBlogs()){
    if(b.getBlogId() == id){
        blog = b;
        break;
    }
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Edit Blog</title>
<link rel="icon" href="images/ican.jpg"> 

<style>
body {
    font-family:'Segoe UI';
    background:#f4f6f9;
    display:flex;
    justify-content:center;
    align-items:center;
    height:100vh;
}

.container {
    background:white;
    padding:30px;
    border-radius:10px;
    width:600px;
    box-shadow:0 5px 15px rgba(0,0,0,0.1);
}

h2 {
    text-align:center;
    color:#365c9c;
}

input, textarea {
    width:100%;
    padding:10px;
    margin:8px 0;
    border:1px solid #ccc;
    border-radius:5px;
}

input[type="submit"] {
    background:#365c9c;
    color:white;
    border:none;
    cursor:pointer;
}

input[type="submit"]:hover {
    background:#2e4f87;
}

.cancel {
    display:block;
    margin-top:10px;
    text-align:center;
    text-decoration:none;
    background:#dc3545;
    color:white;
    padding:8px;
    border-radius:5px;
}

.cancel:hover {
    background:#c82333;
}
</style>
</head>

<body>


<div class="container">

<h2>Edit Blog</h2>

<form action="UpdateBlogServlet" method="post">

<input type="hidden" name="id" value="<%= blog.getBlogId() %>">

<label>Title</label>
<input type="text" name="title" value="<%= blog.getTitle() %>" required>

<label>Image URL</label>
<input type="text" name="image" value="<%= blog.getImageUrl() %>">

<label>Content</label>
<textarea name="content" rows="5" required><%= blog.getContent() %></textarea>

<input type="submit" value="Update Blog">

</form>

<%--<a href="manage-blog.jsp" class="cancel">Cancel</a>  --%>
<a href="getblogs.jsp" class="cancel">Cancel</a>
</div>

</body>
</html>