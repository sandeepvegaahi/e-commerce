<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home | ShopEase</title>

<style>

body{
margin:0;
font-family:'Segoe UI',sans-serif;
background-color:#f5ebe0;
}

/* Navbar */

.navbar{
background-color:#fffaf5;
padding:15px 40px;
display:flex;
justify-content:space-between;
align-items:center;
box-shadow:0px 4px 12px rgba(212,163,115,0.2);
}

.company-section{
display:flex;
align-items:center;
gap:15px;
}

.company-name{
font-size:24px;
font-weight:bold;
color:#9c6644;
}

/* Menu icon */

.menu-container{
position:relative;
}

.menu-icon{
width:38px;
height:38px;
border-radius:50%;
cursor:pointer;
border:2px solid #ddb892;
padding:5px;
background:#fffaf5;
}

.menu-dropdown{
display:none;
position:absolute;
top:50px;
left:0;
background:white;
min-width:180px;
border-radius:10px;
box-shadow:0px 6px 15px rgba(0,0,0,0.15);
}

.menu-dropdown a{
display:block;
padding:12px;
text-decoration:none;
color:#6d4c41;
}

.menu-dropdown a:hover{
background:#fdf0e6;
}

/* Sub Categories */

.sub-category{
display:none;
padding-left:15px;
background:#faf3eb;
}

.sub-category a{
padding:10px;
font-size:14px;
}

/* Profile */

.profile-section{
position:relative;
}

.profile-icon{
width:38px;
height:38px;
border-radius:50%;
cursor:pointer;
border:2px solid #ddb892;
}

.dropdown{
display:none;
position:absolute;
right:0;
top:50px;
background:white;
min-width:160px;
border-radius:10px;
box-shadow:0px 6px 15px rgba(0,0,0,0.15);
}

.dropdown a{
display:block;
padding:12px;
text-decoration:none;
color:#6d4c41;
}

.dropdown a:hover{
background:#fdf0e6;
}

/* Page Content */

.content{
padding:40px;
text-align:center;
}

</style>
</head>

<body>

<!-- Navbar -->

<div class="navbar">

<div class="company-section">

<!-- Menu Icon -->

<div class="menu-container">

<img src="<%=request.getContextPath()%>/images/menu.png"
class="menu-icon"
onclick="toggleMainMenu()">

<div id="mainMenu" class="menu-dropdown">

<a href="javascript:void(0)" onclick="toggleCategories()">Categories</a>

<div id="categories" class="sub-category">

<a href="products.jsp?category=electronics">Electronics</a>
<a href="products.jsp?category=fashion">Fashion</a>
<a href="products.jsp?category=home">Home Decor</a>
<a href="products.jsp?category=beauty">Beauty</a>

</div>

<a href="blogs.jsp">Blogs</a>

</div>

</div>

<!-- Company Name -->

<div class="company-name">
ShopEase
</div>

</div>

<!-- Profile Section -->

<div class="profile-section">

<img src="<%=request.getContextPath()%>/images/profile.jpg"
class="profile-icon"
onclick="toggleProfileMenu()">

<div id="menu" class="dropdown">

<%
Object user = session.getAttribute("user");

if(user == null){
%>

<a href="login.jsp">Login</a>
<a href="register.jsp">Register</a>

<%
}else{
%>

<a href="profile.jsp">Profile</a>
<a href="<%=request.getContextPath()%>/LogoutServlet">Logout</a>

<%
}
%>

</div>

</div>

</div>

<!-- Page Content -->

<div class="content">

<h1>Welcome to ShopEase 🛍️</h1>

<p>
Discover the best products with comfort and style.
</p>

</div>


<script>

/* Profile Menu */

function toggleProfileMenu(){

var menu=document.getElementById("menu");

if(menu.style.display==="block"){
menu.style.display="none";
}else{
menu.style.display="block";
}

}

/* Main Menu */

function toggleMainMenu(){

var menu=document.getElementById("mainMenu");

if(menu.style.display==="block"){
menu.style.display="none";
}else{
menu.style.display="block";
}

}

/* Categories */

function toggleCategories(){

var cat=document.getElementById("categories");

if(cat.style.display==="block"){
cat.style.display="none";
}else{
cat.style.display="block";
}

}

/* Close menu when clicking outside */

window.onclick=function(event){

if(!event.target.closest('.profile-section') &&
   !event.target.closest('.menu-container')){

document.getElementById("menu").style.display="none";
document.getElementById("mainMenu").style.display="none";

}

}

</script>

</body>
</html>