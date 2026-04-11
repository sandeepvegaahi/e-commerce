<%@ page import="java.util.*,dao.FavoriteDAO,model.Product" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
List<Product> list = (List<Product>) request.getAttribute("favList");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Wishlist</title>

<style>
body{
    font-family: Arial;
    background: #f5ebe0;
    margin:0;
    padding:0;
}

/* BACK BUTTON */
.back-btn{
    margin:15px;
    padding:8px 15px;
    background:#8d6e63;
    color:white;
    border:none;
    border-radius:6px;
    cursor:pointer;
}

/* TITLE */
h2{
    color:#6d4c41;
    margin-top:10px;
}

/* GRID */
.card-container{
    display:grid;
    grid-template-columns:repeat(auto-fill,minmax(250px,1fr));
    gap:20px;
    padding:20px;
}

/* CARD */
.card{
    position:relative;
    background:#fffaf5;
    padding:15px;
    border-radius:12px;
    text-align:center;
    box-shadow:0 5px 12px rgba(0,0,0,0.1);
    transition:0.3s;
}

.card:hover{
    transform:scale(1.03);
}

/* IMAGE */
.card img{
    width:100%;
    height:160px;
    object-fit:cover;
    border-radius:10px;
}

/* TEXT */
.card h3{
    color:#6d4c41;
    margin:10px 0 5px;
}

.card p{
    font-size:14px;
    margin:5px 0;
}

/* ❤️ HEART */
.heart{
    position:absolute;
    top:10px;
    right:10px;
    color:red;
    font-size:22px;
}

/* BUTTON */
.view-btn{
    display:inline-block;
    margin-top:10px;
    padding:8px 12px;
    background:#8d6e63;
    color:white;
    text-decoration:none;
    border-radius:6px;
    font-size:13px;
}

.view-btn:hover{
    background:#6d4c41;
}

/* EMPTY */
.empty{
    text-align:center;
    font-size:18px;
    margin-top:50px;
}
</style>

</head>

<body>

<!-- ✅ BACK BUTTON -->
<button class="back-btn" onclick="goHome()">⬅ Back to Home</button>

<h2 style="text-align:center;">❤️ My Wishlist</h2>

<div class="card-container">

<% if(list != null && !list.isEmpty()){ 
   for(Product p : list){ %>

<div class="card">

    <!-- ❤️ HEART -->
    <span class="heart">❤️</span>

    <img src="<%= request.getContextPath() %>/images/<%= p.getImageUrl() %>">

    <h3><%= p.getName() %></h3>

    <p>₹ <%= p.getOfferPrice() %></p>

    <button class="view-btn" onclick="openModal(<%=p.getProductId()%>)">
        View Product
    </button>

</div>

<% } } else { %>

<div class="empty">No favorites yet 😢</div>

<% } %>

</div>

<!-- MODAL -->
<div id="productModal" style="display:none; position:fixed; top:0; left:0; 
width:100%; height:100%; background:rgba(0,0,0,0.5); z-index:9999;">

    <div class="modal-content" style="
        background:#fffaf5;
        width:60%;
        margin:5% auto;
        border-radius:10px;
        padding:15px;
        position:relative;
    ">

        <span onclick="closeModal()" style="
            position:absolute;
            right:15px;
            top:10px;
            font-size:20px;
            cursor:pointer;">❌</span>

        <div id="modalBody"></div>

    </div>
</div>

</body>
</html>

<script>
function goHome(){
    window.location.href = "<%=request.getContextPath()%>/user/home.jsp";
}

function openModal(id){

    // ✅ FIXED PATH (important)
    fetch("<%=request.getContextPath()%>/viewProduct.jsp?id=" + id)
    .then(res => res.text())
    .then(data => {
        document.getElementById("modalBody").innerHTML = data;
        document.getElementById("productModal").style.display = "block";
    });
}

function closeModal(){
    document.getElementById("productModal").style.display = "none";
}

// close when clicking outside
window.onclick = function(e){
    let modal = document.getElementById("productModal");
    if(e.target === modal){
        modal.style.display = "none";
    }
}
</script>