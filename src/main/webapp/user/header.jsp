<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
.navbar{
background-color:#fffaf5;
padding:12px 40px;
display:flex;
justify-content:space-between;
align-items:center;
box-shadow:0px 4px 12px rgba(212,163,115,0.2);
}

/* Left */

.left{
display:flex;
align-items:center;
gap:15px;
}

.company-name{
font-size:24px;
font-weight:bold;
color:#9c6644;
}

/* Right Icons */

.right{
display:flex;
align-items:center;
gap:18px;
}

/* Icons Styling */

.icon{
width:34px;
padding:6px;
border-radius:50%;
background:#fff;
border:2px solid #ddb892;
cursor:pointer;
transition:0.3s;
}

.icon:hover{
background:#fdf0e6;
transform:scale(1.1);
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
transition:0.3s;
}

.profile-icon:hover{
transform:scale(1.1);
}

/* Dropdown */

.dropdown{
display:none;
position:absolute;
right:0;
top:50px;
background:white;
min-width:160px;
border-radius:10px;
box-shadow:0px 6px 15px rgba(0,0,0,0.15);
overflow:hidden;
}

.dropdown a{
display:block;
padding:12px;
text-decoration:none;
color:#6d4c41;
transition:0.2s;
}

.dropdown a:hover{
background:#fdf0e6;
}
</style>

<div class="navbar">

<!-- Left -->
<div class="left">
<img src="<%=request.getContextPath()%>/images/menu.png" class="icon">
<div class="company-name">ShopEase</div>
</div>

<!-- Right -->
<div class="right">

<!-- Cart -->
<img src="<%=request.getContextPath()%>/images/cart.png"
class="icon"
title="Cart"
onclick="goToPage('CartServlet')">

<!-- Favourite -->
<img src="<%=request.getContextPath()%>/images/favourite.png"
class="icon"
title="Wishlist"
onclick="window.location.href='<%=request.getContextPath()%>/FavoriteServlet'">

<!-- Orders -->
<img src="<%=request.getContextPath()%>/images/order.png"
class="icon"
title="Orders"
onclick="window.location.href='<%=request.getContextPath()%>/user/orders.jsp'">
<!-- Profile -->
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
</div>
 
<script>
function goToPage(page){

    let isLoggedIn = "<%= (session.getAttribute("user") != null) %>";

    if(isLoggedIn === "true"){
        window.location.href = "<%=request.getContextPath()%>/" + page;
    }else{
        window.location.href = "<%=request.getContextPath()%>/user/login.jsp?redirect=" + page;
    }
}

function toggleProfileMenu(){
var m=document.getElementById("menu");
m.style.display = (m.style.display==="block") ? "none" : "block";
}

window.onclick=function(e){
if(!e.target.closest('.profile-section')){
document.getElementById("menu").style.display="none";
}
}
</script>