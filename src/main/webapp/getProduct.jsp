<%@ page import="java.util.*,dao.ProductDAO,model.Product" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
ProductDAO dao = new ProductDAO();
List<Product> list = dao.getAllProducts();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>All Products</title>
<link rel="icon" href="images/ican.jpg"> 

<style>
body {
    font-family: 'Segoe UI', Arial, sans-serif;
    background: #f4f6f9;
}

.navbar-space {
    margin-bottom: 18px;
}

.top-bar {
    display: flex;
    gap: 15px;
    margin-bottom: 25px;
}

.top-bar h2 {
    margin: 0;
    color: #1e3c72;
    flex-grow: 1;
}

.add-btn, .back {
    text-decoration: none;
    padding: 10px 18px;
    color: white;
    border-radius: 6px;
}

.add-btn { background: #2a5298; }
.back { background: #2a5298; }

.card-container {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
    gap: 30px;
}

.card {
    background: white;
    border-radius: 12px;
    padding: 20px;
    box-shadow: 0 8px 20px rgba(0,0,0,0.15);
    text-align: center;
    cursor: pointer;
    transition: 0.3s;
}

.card:hover {
    transform: translateY(-5px);
}

.card img {
    width: 100%;
    height: 220px;
    object-fit: cover;
    border-radius: 10px;
}

.card h3 {
    margin: 10px 0;
    color: #2a5298;
}

/* BUTTONS */
.button-group {
    margin-top: 12px;
}

.button-group a {
    display: inline-block;
    padding: 7px 14px;
    margin: 5px;
    border-radius: 5px;
    color: white;
    text-decoration: none;
    font-size: 14px;
}

.edit { background: #28a745; }
.delete { background: #dc3545; }

/* MODAL */
.modal {
    display: none;
    position: fixed;
    z-index: 1000;
    left:0;
    top:0;
    width:100%;
    height:100%;
    background: rgba(0,0,0,0.6);
}

/* ✅ UPDATED MODAL WITH SCROLLBAR */
.modal-content {
    background:white;
    margin:50px auto;
    padding:20px;
    border-radius:10px;
    max-width:600px;
    position: relative;

    height: 400px;        /* ✅ fixed height */
    overflow-y: auto;     /* ✅ enable scroll */
}

/* ✅ SCROLLBAR STYLE */
.modal-content::-webkit-scrollbar {
    width: 8px;
}

.modal-content::-webkit-scrollbar-track {
    background: #f1f1f1;
    border-radius: 10px;
}

.modal-content::-webkit-scrollbar-thumb {
    background: #2a5298;
    border-radius: 10px;
}

.modal-content::-webkit-scrollbar-thumb:hover {
    background: #1e3c72;
}

/* Firefox */
.modal-content {
    scrollbar-width: thin;
    scrollbar-color: #2a5298 #f1f1f1;
}

.close {
    position: absolute;
    right:20px;
    top:10px;
    font-size:28px;
    cursor:pointer;
}
</style>
</head>

<body>

<div class="navbar-space">
    <jsp:include page="navbar.jsp" />
</div>

<div class="top-bar">
    <h2>All Products</h2>
    <a href="addProduct.jsp" class="add-btn">Add Product</a>
    <a href="dashboard.jsp" class="back">Back</a>
</div>

<div class="card-container">

<%
for(Product p : list){
%>

<div class="card" onclick="openModal('<%= p.getProductId() %>')">

    <img src="<%= request.getContextPath() %>/images/<%= p.getImageUrl() %>">

    <h3><%= p.getName() %></h3>
    <p><strong>Category:</strong> <%= p.getCategory() %></p>
    <p><strong>Price:</strong> ₹<%= p.getActualPrice() %></p>

    <div class="button-group" onclick="event.stopPropagation();">
        <a class="edit" href="edit-product.jsp?id=<%= p.getProductId() %>">Edit</a>

        <a class="delete" 
           href="DeleteProductServlet?id=<%= p.getProductId() %>" 
           onclick="return confirm('Are you sure to delete?')">
           Delete
        </a>
    </div>

</div>

<!-- MODAL -->
<div id="modal-<%= p.getProductId() %>" class="modal">
    <div class="modal-content">

        <span class="close" onclick="closeModal('<%= p.getProductId() %>')">&times;</span>

        <img src="<%= request.getContextPath() %>/images/<%= p.getImageUrl() %>" 
             style="width:90%;height:250px;object-fit:cover;">

        <h3><%= p.getName() %></h3>
        <p><strong>Category:</strong> <%= p.getCategory() %></p>
        <p><strong>Actual Price:</strong> ₹<%= p.getActualPrice() %></p>
        <p><strong>Offer Price:</strong> ₹<%= p.getOfferPrice() %></p>
        <p><strong>Stock:</strong> <%= p.getStockQuantity() %></p>
        <p><strong>Description:</strong> <%= p.getDescription() %></p>

    </div>
</div>

<%
}
%>

</div>

<script>
function openModal(id){
    document.getElementById('modal-' + id).style.display = 'block';
}

function closeModal(id){
    document.getElementById('modal-' + id).style.display = 'none';
}

window.onclick = function(event){
    document.querySelectorAll('.modal').forEach(function(modal){
        if(event.target === modal){
            modal.style.display = 'none';
        }
    });
}
</script>

</body>
</html>