<%@ page import="java.util.*,dao.ProductDAO,Model.Product" %>
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

<style>
body {
    font-family: 'Segoe UI', Arial, sans-serif;
    background: #f4f6f9;
    padding: 20px;
}

.top-bar {
    display: flex;
    justify-content: flex-start;
    align-items: center;
    gap: 15px; /* spacing between buttons */
    margin-bottom: 25px;
}

.top-bar h2 {
    margin: 0;
    color: #1e3c72;
    flex-grow: 1; /* title takes available space */
}

.add-btn, .back {
    text-decoration: none;
    padding: 10px 18px;
    color: white;
    border-radius: 6px;
    font-weight: 500;
}

.add-btn {
    background: #2a5298;
}

.add-btn:hover {
    background: #1e3c72;
}

.back {
    background: #2a5298;
}

.back:hover {
    background: #218838;
}

.card-container {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
    gap: 30px;
}

.card {
    background: white;
    border-radius: 12px;
    padding: 25px;
    box-shadow: 0 8px 20px rgba(0,0,0,0.15);
    text-align: center;
    min-height: 520px;
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
    margin-bottom: 15px;
}

.card h3 {
    margin: 15px 0 8px;
    font-size: 22px;
    color: #2a5298;
}

.card p {
    margin: 4px 0;
    font-size: 15px;
}

.button-group {
    margin-top: 15px;
}

.button-group a {
    text-decoration: none;
    padding: 8px 14px;
    border-radius: 5px;
    color: white;
    font-size: 14px;
    margin: 4px;
}

.edit { background: #28a745; }
.delete { background: #dc3545; }

.edit:hover { background: #218838; }
.delete:hover { background: #c82333; }

</style>
</head>

<body>

<div class="top-bar">
    <h2>All Products</h2>
    <a href="addProduct.jsp" class="add-btn">Add Product</a>
    <a class="back" href="dashboard.jsp">Back</a>
</div>

<div class="card-container">

<%
for(Product p : list){
%>

<div class="card">
    <img src="<%= request.getContextPath() %>/images/<%= p.getImageUrl() %>">

    <h3><%= p.getName() %></h3>

    <p><strong>Category:</strong> <%= p.getCategory() %></p>
    <p><strong>Actual Price:</strong> ₹<%= p.getActualPrice() %></p>
    <p><strong>Offer Price:</strong> ₹<%= p.getOfferPrice() %></p>
    <p><strong>Stock:</strong> <%= p.getStockQuantity() %></p>
    <p><strong>Description:</strong> <%= p.getDescription() %></p>

    <div class="button-group">
        <a class="edit" href="edit-product.jsp?id=<%= p.getProductId() %>">Edit</a>
        <a class="delete" href="DeleteProductServlet?id=<%= p.getProductId() %>" 
           onclick="return confirm('Are you sure you want to delete this product?')">Delete</a>
    </div>
</div>

<%
}
%>
</div>

</body>
</html>