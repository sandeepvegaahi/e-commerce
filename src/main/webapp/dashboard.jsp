<%@ page import="dao.ProductDAO" %>
<%@ page import="dao.BlogDAO" %>
<%@ page import="dao.UserDAO" %>   <!-- ADDED -->
<%@ page import="model.Admins" %>

<%
Admins admin = (Admins) session.getAttribute("admin");

if(admin == null){
    response.sendRedirect("index.jsp");
    return; 
}

ProductDAO dao = new ProductDAO();
BlogDAO blogDAO = new BlogDAO();
UserDAO userDAO = new UserDAO();   // ADDED

int totalProducts = dao.getProductCount();
int totalBlogs = blogDAO.getBlogCount();
int totalUsers = userDAO.getUserCount();   // ADDED
%>

<!DOCTYPE html>
<html>
<head>
<title>Admin Dashboard</title>
<style>

body {
    font-family: 'Segoe UI', Arial, sans-serif;
    background: linear-gradient(135deg, #e6ecf5, #d2dff3);
    margin: 0;
}

/* Header */
.header {
    background: linear-gradient(90deg, #2a5298, #1e3c72);
    color: white;
    padding: 25px;
    text-align: center;
    box-shadow: 0 4px 10px rgba(0,0,0,0.1);
}

.header h2 {
    margin: 0;
    font-weight: 500;
}

/* Container */
.container {
    padding: 40px;
    display: flex;
    justify-content: center;
    gap: 40px;
    flex-wrap: wrap;
}

/* Cards */
.card {
    background: white;
    padding: 30px;
    width: 280px;
    border-radius: 15px;
    box-shadow: 0 10px 25px rgba(0,0,0,0.08);
    text-align: center;
    transition: 0.3s ease;
}

.card:hover {
    transform: translateY(-8px);
    box-shadow: 0 15px 30px rgba(0,0,0,0.15);
}

/* Numbers */
.card h1 {
    color: #2a5298;
    font-size: 45px;
    margin: 10px 0;
}

/* Title */
.card h3 {
    margin: 0;
    color: #333;
    font-weight: 500;
}

/* Button */
.card a {
    display: inline-block;
    margin-top: 15px;
    background: linear-gradient(90deg, #2a5298, #1e3c72);
    color: white;
    padding: 10px 18px;
    text-decoration: none;
    border-radius: 8px;
    font-size: 14px;
    transition: 0.3s;
}

.card a:hover {
    background: linear-gradient(90deg, #1e3c72, #2a5298);
}

/* Responsive */
@media (max-width: 768px) {
    .container {
        flex-direction: column;
        align-items: center;
    }
}
</style>
</head>
<body>

<jsp:include page="navbar.jsp" />

<div class="container">

<div class="card">
<h3>Total Products</h3>
<h1><%= totalProducts %></h1>
<a href="getProduct.jsp">Manage Products</a>
</div>

<div class="card">
<h3>Total Blogs</h3>
<h1><%= totalBlogs %></h1>
<a href="getblogs.jsp">Manage Blogs</a>
</div>

<!-- ADDED USER CARD -->
<div class="card">
<h3>Total Users</h3>
<h1><%= totalUsers %></h1>
<a href="viewusers.jsp">View Users</a>
</div>

<div class="card">
<h3>Total orders</h3>
<h1>5</h1>
<a href="getblogs.jsp">Manage orders</a>
</div>

</div>

</body>
</html>