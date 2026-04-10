<%@ page import="java.util.*,dao.BlogDAO,model.Blog" %>
<%@ page import="model.Admins" %>

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
<link rel="icon" href="images/ican.jpg"> 

<style>
body {
    font-family: 'Segoe UI';
    background: #f4f6f9;
    margin:0;
    padding:15--px;
}

.top-bar {
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:25px;
}

.add-btn {
    text-decoration:none;
    padding:10px 18px;
    background:#365c9c;
    color:white;
    border-radius:6px;
}

/* CARDS */
.card-container {
    display:grid;
    grid-template-columns: repeat(auto-fill,minmax(300px,1fr));
    gap:25px;
}

.card {
    background:white;
    border-radius:12px;
    box-shadow:0 8px 20px rgba(0,0,0,0.08);
    overflow:hidden;
    transition:0.3s;
}

.card:hover {
    transform:translateY(-8px);
}

.card img {
    width:100%;
    height:180px;
    object-fit:cover;
}

.card-body {
    padding:15px;
}

.card p {
    font-size:14px;
    color:#666;
}

/* ✅ READ MORE BUTTON */
.read-btn {
    display:inline-block;
    margin-top:10px;
    padding:8px 14px;
    background:#ff6b4a;
    color:white;
    border-radius:6px;
    text-decoration:none;
}

.read-btn:hover {
    background:#e85a3c;
}


.card-actions {
    padding:10px;
    text-align:center;
}

.card-actions a {
    text-decoration:none;
    padding:6px 12px;
    border-radius:5px;
    color:white;
    margin:4px;
    font-size:13px;
}

.edit-btn {
    background:#28a745;
}

.delete-btn {
    background:#dc3545;
}

/* MODAL */
.modal {
    display:none;
    position:fixed;
    z-index:1000;
    left:0;
    top:0;
    width:100%;
    height:100%;
    background: rgba(0,0,0,0.6);
}

.modal-content {
    background:white;
    margin:50px auto;
    padding:20px;
    border-radius:10px;
    max-width:600px;
    position:relative;
}

.close {
    position:absolute;
    right:20px;
    top:10px;
    font-size:28px;
    cursor:pointer;
}

.modal-content img {
    width:100%;
    height:250px;
    object-fit:cover;
}
</style>
</head>

<body>

<jsp:include page="navbar.jsp" />

<div class="top-bar">
    <h2>Latest Blogs</h2>
    <div>
        <a href="addblogs.jsp" class="add-btn">Add Blog</a>
        <a href="dashboard.jsp" class="add-btn">Back</a>
    </div>
</div>

<div class="card-container">

<%
for(Blog b : list){
%>

<!-- ✅ CARD -->
<div class="card">

    <img src="<%= request.getContextPath() %>/blogsimg/<%= b.getImageUrl() %>">

    <div class="card-body">
        <h3><%= b.getTitle() %></h3>

        <p>
            <%= b.getContent().length() > 100 ? 
                b.getContent().substring(0,100) + "..." : 
                b.getContent() %>
        </p>

        <!-- ✅ READ MORE BUTTON -->
        <a href="#" class="read-btn" onclick="openModal('<%= b.getBlogId() %>')">
            Read More
        </a>
    </div>

    <!-- ✅ EDIT & DELETE BEFORE POPUP -->
    <div class="card-actions">
        <a href="edit-blog.jsp?id=<%= b.getBlogId() %>" class="edit-btn">Edit</a>

        <a href="DeleteBlogServlet?id=<%= b.getBlogId() %>" 
           class="delete-btn"
           onclick="return confirm('Are you sure to delete?')">
           Delete
        </a>
    </div>

</div>

<!-- ✅ MODAL -->
<div id="modal-<%= b.getBlogId() %>" class="modal">
    <div class="modal-content">
        
        <span class="close" onclick="closeModal('<%= b.getBlogId() %>')">&times;</span>

        <img src="<%= request.getContextPath() %>/blogsimg/<%= b.getImageUrl() %>">

        <h3><%= b.getTitle() %></h3>

        <p><%= b.getContent() %></p>

        <small>Posted on: <%= b.getCreatedAt() %></small>

    </div>
</div>

<%
}
%>

</div>

<script>

// OPEN MODAL
function openModal(id){
    const modal = document.getElementById('modal-' + id);
    modal.style.display = 'block';
    document.body.style.overflow = 'hidden'; // disable scroll
}

// CLOSE MODAL
function closeModal(id){
    const modal = document.getElementById('modal-' + id);
    modal.style.display = 'none';
    document.body.style.overflow = 'auto'; // enable scroll
}

// CLOSE WHEN CLICK OUTSIDE
window.addEventListener('click', function(event){
    document.querySelectorAll('.modal').forEach(function(modal){
        if(event.target === modal){
            modal.style.display = 'none';
            document.body.style.overflow = 'auto';
        }
    });
});

// CLOSE WITH ESC KEY 🔥
window.addEventListener('keydown', function(event){
    if(event.key === "Escape"){
        document.querySelectorAll('.modal').forEach(function(modal){
            modal.style.display = 'none';
        });
        document.body.style.overflow = 'auto';
    }
});

</script>

</body>
</html>