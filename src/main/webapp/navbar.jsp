<%@ page import="model.Admins" %>

<%
Admins admin = (Admins) session.getAttribute("admin");

if(admin == null){
    response.sendRedirect("index.jsp");
    return;
}
%>

<style>



.navbar{
  
    display:flex;
    justify-content:space-between;
    align-items:center;
    background:#365c9c;   /* new navbar color */
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
    transition:0.3s;
}

.navbar ul li a:hover{
    background:#2e4f87;   /* hover color */
}
</style>


<div class="navbar">

<div class="title">
<%= admin.getName() %> Dashboard
</div>

<ul>
<li><a href="dashboard.jsp">Home</a></li>
<li><a href="getProduct.jsp">Products</a></li>
<li><a href="getblogs.jsp">Blogs</a></li>
<li><a href="user/home.jsp">Logout</a></li>
</ul>

</div>