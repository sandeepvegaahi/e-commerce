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
%>

<!DOCTYPE html>
<html>
<head>
<title>Edit Product</title>
<style>

body {
    font-family: 'Segoe UI', Arial, sans-serif;
    background:  #f4f6f9;/*linear-gradient(135deg, #87CEEB, #f4d6a0)*/
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    margin: 0;
}

/* Center Container */
.container {
    background: #ffffff;
    padding: 30px;
    border-radius: 12px;
    width: 700px;
    margin: 80px auto;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
}

/* Title */
h2 {
    text-align: center;
    margin-bottom: 25px;
    color: #365c9c;   /* same blue */
}
.cancel-btn {
    flex: 1;
    text-align: center;
    padding: 15px;
    border-radius: 12px;
    background: rgba(255,255,255,0.3);
    color: white;
    text-decoration: none;
    font-weight: bold;
    transition: 0.3s;
}

.cancel-btn:hover {
    background: rgba(255,255,255,0.6);
    color: #365c9c;
}

/* 2 column layout */
.form-row {
    display: flex;
    gap: 20px;
    margin-bottom: 15px;
}

.form-group {
    flex: 1;
    display: flex;
    flex-direction: column;
}

label {
    font-weight: 600;
    margin-bottom: 6px;
    color: #333;
}

/* Inputs */
input[type="text"],
input[type="number"] {
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 6px;
    font-size: 14px;
}

input:focus {
    border-color: #365c9c;
    outline: none;
}

/* Description full width */
.full-width {
    display: flex;
    flex-direction: column;
    margin-bottom: 20px;
}

/* Button */
input[type="submit"] {
    width: 100%;
    background-color: #365c9c;  /* same blue button */
    color: white;
    
    border: none;
    padding: 15px;
    border-radius: 12px;
    font-weight: bold;
    cursor: pointer;
    transition: 0.3s;
}

input[type="submit"]:hover {
    background-color: #2e4f87;  /* darker blue hover */
    }
<%--

input[type="submit"] {
    flex: 1;
    padding: 15px;
    border-radius: 12px;
    
    background:  #365c9c;
    color:white;
    font-weight: bold;
    font-size: 15px;
    cursor: pointer;
    transition: 0.3s;
}

input[type="submit"]:hover {
    background: #2e4f87;
    color: white;
    transform: translateY(-3px);
}--%>


</style> 



</head>
<body>

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


<div >
    <input type="submit" value="Update Product">
    <!--  <a href="manage-products.jsp" class="cancel-btn">Cancel</a>-->
    <a href="getProduct.jsp" class="cancel-btn">Cancel</a>
</div>

</form>

</div>

</body>
</html>