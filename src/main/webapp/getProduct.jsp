<%@ page import="java.util.*,dao.ProductDAO,model.Product,dao.FavoriteDAO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%

String category = request.getParameter("category");

ProductDAO dao = new ProductDAO();
List<Product> list;

if(category != null){
    list = dao.getProductsByCategory(category);
}else{
    list = dao.getAllProducts();
}

Object userObj = session.getAttribute("user");
Object adminObj = session.getAttribute("admin");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Products</title>

<style>
body {
    font-family: 'Segoe UI', Arial;
    background: #f5ebe0;
    padding: 20px;
}

/* TOP */
.top-bar {
    display: flex;
    justify-content: space-between;
    margin-bottom: 20px;
}

.top-bar h2 {
    color: #6d4c41;
}

/* ADD BUTTON */
.add-btn {
    text-decoration: none;
    padding: 10px 16px;
    background: #8d6e63;
    color: white;
    border-radius: 6px;
}

.add-btn:hover {
    background: #6d4c41;
}

/* GRID */
.card-container {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
    gap: 20px;
}

/* CARD */
.card {
    background: #fffaf5;
    border-radius: 12px;
    padding: 15px;
    height: 440px;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    box-shadow: 0 5px 12px rgba(0,0,0,0.1);
    position: relative;
}

.card img {
    width: 100%;
    height: 160px;
    object-fit: cover;
    border-radius: 10px;
}

.card h3 {
    font-size: 17px;
    color: #6d4c41;
}

.card p {
    font-size: 13px;
    margin: 2px 0;
}

/* BUTTONS */
.button-group a {
    text-decoration: none;
    padding: 6px 10px;
    border-radius: 5px;
    color: white;
    font-size: 12px;
    margin: 3px;
    display: inline-block;
}

.read { background:#8d6e63; }
.cart { background:#ff9800; }
.order { background:#4caf50; }
.edit { background:#3f51b5; }
.delete { background:#e53935; }
.fav-icon {
    position: absolute;
    top: 10px;
    right: 12px;
    font-size: 22px;
    cursor: pointer;
    transition: 0.3s;
}

.fav-icon.active {
    color: red;
}
</style>
</head>

<body>

<!-- TOP -->
<div class="top-bar">
    

    <% if(adminObj != null){ %>
    <h2>🛍️ Products</h2>
        <a href="addProduct.jsp" class="add-btn">+ Add Product</a>
    <% } %>
</div>

<!-- PRODUCTS -->
<div class="card-container">

<%
for(Product p : list){
%>

<div class="card" onclick="openProduct(<%= p.getProductId() %>)">
	<%
FavoriteDAO favDAO = new FavoriteDAO();
boolean isFav = false;

if(session.getAttribute("user") != null){
    model.User u = (model.User) session.getAttribute("user");
    isFav = favDAO.isFavorite(u.getUserId(), p.getProductId());
}
%>

<span class="fav-icon"
      onclick="toggleFav(event, <%= p.getProductId() %>)">
    <%= isFav ? "❤️" : "🤍" %>
</span>

    <img src="<%= request.getContextPath() %>/images/<%= p.getImageUrl() %>">

    <h3><%= p.getName() %></h3>

    <p><b>Category:</b> <%= p.getCategory() %></p>
    <p><b>Price:</b> ₹<%= p.getOfferPrice() %></p>

    <!-- SHOW STOCK ONLY FOR ADMIN -->
    <% if(adminObj != null){ %>
        <p><b>Stock:</b> <%= p.getStockQuantity() %></p>
    <% } %>

    <div class="button-group" onclick="event.stopPropagation();">

    <!-- READ MORE -->
    <a class="read" onclick="openProduct(<%= p.getProductId() %>)">
    Read More
</a>

    <% if(adminObj == null){ %>
        <!-- SHOW FOR ALL USERS (LOGGED OR NOT) -->

        <a class="cart" href="javascript:void(0);" 
   			onclick="addToCart(<%= p.getProductId() %>)">
    		Cart
		</a>

		<a class="order" href="../AddToCartServlet?id=<%= p.getProductId() %>&action=buy">
    		Order
		</a>

    <% } else { %>
        <!-- ADMIN ONLY -->
        <a class="edit" href="edit-product.jsp?id=<%= p.getProductId() %>">
            Update
        </a>

        <a class="delete" href="DeleteProductServlet?id=<%= p.getProductId() %>"
           onclick="return confirm('Delete this product?')">
            Delete
        </a>
    <% } %>

</div>

</div>

<%
}
%>

</div>
<!-- MODAL -->
<div id="productModal" style="display:none; position:fixed; top:0; left:0;
width:100%; height:100%; background:rgba(0,0,0,0.6); z-index:1000;">

    <div style="background:white; width:60%; margin:60px auto; padding:20px;
    border-radius:10px; position:relative;">

        <span onclick="closeModal()" 
        style="position:absolute; right:15px; top:10px; font-size:25px; cursor:pointer;">&times;</span>

        <!-- LOAD VIEW PRODUCT HERE -->
        <div id="modalContent"></div>

    </div>
</div>
</body>
</html>

<script>
function addToCart(productId){

    fetch("../AddToCartServlet?id=" + productId + "&action=cart")
    .then(response => {
        if(response.redirected){
            // if not logged in → go to login
            window.location.href = response.url;
        }else{
            // success (no reload)
            showToast("Item added to cart ✅");
        }
    });
}

// simple toast
function showToast(msg){
    let t = document.createElement("div");
    t.innerText = msg;
    t.style.position = "fixed";
    t.style.bottom = "20px";
    t.style.right = "20px";
    t.style.background = "#4caf50";
    t.style.color = "white";
    t.style.padding = "10px 15px";
    t.style.borderRadius = "6px";
    t.style.zIndex = "9999";

    document.body.appendChild(t);

    setTimeout(()=> t.remove(), 2000);
}
function openProduct(id){
    document.getElementById("productModal").style.display = "block";

    fetch("../viewProduct.jsp?id=" + id)
    .then(res => res.text())
    .then(data => {
        document.getElementById("modalContent").innerHTML = data;
    });
}

function closeModal(){
    document.getElementById("productModal").style.display = "none";
}

// click outside closes modal
window.onclick = function(e){
    let modal = document.getElementById("productModal");
    if(e.target === modal){
        modal.style.display = "none";
    }
}

function toggleFav(event, productId){
    event.stopPropagation();

    let icon = event.target;

    fetch("../FavoriteServlet?id=" + productId)
    .then(res => res.text())
    .then(status => {

        if(status.trim() === "added"){
            icon.classList.add("active");
            icon.innerHTML = "❤️";
        } else if(status.trim() === "removed"){
            icon.classList.remove("active");
            icon.innerHTML = "🤍";
        }
    });
}
</script>