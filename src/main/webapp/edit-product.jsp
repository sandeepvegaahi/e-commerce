<%@ page import="dao.ProductDAO,model.Product" %>

<%
int id = Integer.parseInt(request.getParameter("id"));
ProductDAO dao = new ProductDAO();
Product product = null;

for(Product p : dao.getAllProducts()){
    if(p.getProductId() == id){
        product = p;
        break;
    }
}

if(product == null){
    out.println("Product not found");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Edit Product</title>
<link rel="icon" href="images/ican.jpg"> 

<style>

body{
    font-family: 'Segoe UI', Arial, sans-serif;
    background:#f4f6f9;
    margin:0;
}

/* Center Container */
.container{
    background:#ffffff;
    padding:10px;
    border-radius:12px;
    width:700px;
    margin:80px auto;
    box-shadow:0 4px 12px rgba(0,0,0,0.1);
}

h2{
    text-align:center;
    margin-bottom:25px;
    color:#365c9c;
}

/* form rows */
.form-row{
    display:flex;
    gap:20px;
    margin-bottom:15px;
}

.form-group{
    flex:1;
    display:flex;
    flex-direction:column;
}

label{
    font-weight:600;
    margin-bottom:6px;
    color:#333;
}

input[type="text"],
input[type="number"]{
    padding:10px;
    border:1px solid #ccc;
    border-radius:6px;
    font-size:14px;
}

input:focus{
    border-color:#365c9c;
    outline:none;
}

.full-width{
    display:flex;
    flex-direction:column;
    margin-bottom:20px;
}

/* button */
input[type="submit"]{
    width:100%;
    background-color:#365c9c;
    color:white;
    border:none;
    padding:15px;
    border-radius:12px;
    font-weight:bold;
    cursor:pointer;
}

input[type="submit"]:hover{
    background-color:#2e4f87;
}

/* cancel button */
.cancel-btn{
    display:block;
    text-align:center;
    margin-top:10px;
    padding:12px;
    border-radius:8px;
    background:#ccc;
    text-decoration:none;
    color:black;
}

.cancel-btn:hover{
    background:#bbb;
}

</style>

</head>

<body>

<!-- NAVBAR -->
<jsp:include page="navbar.jsp"/>
<div style="height:9px;"></div>

<div class="container">

<h2>Edit Product</h2>

<form action="UpdateProductServlet" method="post">

<input type="hidden" name="id" value="<%= product.getProductId() %>">

<div class="form-row">
<div class="form-group">
<label>Name</label>
<input type="text" name="name" value="<%= product.getName() %>">
</div>

<div class="form-group">
<label>Category</label>
<input type="text" name="category" value="<%= product.getCategory() %>">
</div>
</div>

<div class="form-row">
<div class="form-group">
<label>Actual Price</label>
<input type="text" name="actualPrice" value="<%= product.getActualPrice() %>">
</div>

<div class="form-group">
<label>Offer Price</label>
<input type="text" name="offerPrice" value="<%= product.getOfferPrice() %>">
</div>
</div>

<div class="form-row">
<div class="form-group">
<label>Stock</label>
<input type="number" name="stock" value="<%= product.getStockQuantity() %>">
</div>

<div class="form-group">
<label>Image URL</label>
<input type="text" name="image" value="<%= product.getImageUrl() %>">
</div>
</div>

<div class="full-width">
<label>Description</label>
<input type="text" name="description" value="<%= product.getDescription() %>">
</div>

<input type="submit" value="Update Product">

<a href="getProduct.jsp" class="cancel-btn">Cancel</a>

</form>

</div>

</body>
</html>