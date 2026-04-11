<%@ page import="java.util.*,dao.ProductDAO,model.Product,model.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
int id = Integer.parseInt(request.getParameter("id"));

ProductDAO dao = new ProductDAO();
Product p = dao.getProductById(id);

Object adminObj = session.getAttribute("admin");
Object userObj = session.getAttribute("user");

boolean isAdmin = (adminObj != null);
boolean isUser = (userObj != null);

String from = request.getParameter("from");
boolean fromCart = "cart".equals(from);
%>

<style>
/* MODAL CONTENT STYLE */
.product-box {
    padding: 15px;
    font-family: 'Segoe UI';

    max-height: 70vh;     /* 🔥 LIMIT HEIGHT */
    overflow-y: auto;     /* 🔥 ENABLE SCROLL */
}
 

/* IMAGE */
.product-box img {
    width: 100%;
    max-height: 250px;   /* 🔥 responsive */
    object-fit: contain; /* 🔥 no cropping */
}

/* TITLE */
.product-box h2 {
    color: #4e342e;
}

/* TEXT */
.product-box p {
    margin: 6px 0;
    color: #444;
}

/* BUTTON BASE */
.btn {
    padding: 10px 18px;
    border: none;
    border-radius: 6px;
    color: white;
    cursor: pointer;
    margin: 6px 5px 0 0;
    font-size: 14px;
    transition: 0.3s;
}

/* USER BUTTONS */
.cart {
    background: linear-gradient(45deg, #ff9800, #ff5722);
}
.cart:hover {
    background: linear-gradient(45deg, #fb8c00, #e64a19);
}

.order {
    background: linear-gradient(45deg, #4caf50, #2e7d32);
}
.order:hover {
    background: linear-gradient(45deg, #43a047, #1b5e20);
}

/* ADMIN BUTTONS */
.edit {
    background: linear-gradient(45deg, #3f51b5, #1a237e);
}
.delete {
    background: linear-gradient(45deg, #e53935, #b71c1c);
}

/* BUTTON ALIGN */
.btn-group {
    margin-top: 10px;
}
 
.order{
    background: linear-gradient(45deg, #4caf50, #2e7d32);
    color: white;
    padding: 10px 18px;
    border-radius: 6px;
    font-size: 14px;
    cursor: pointer;

    text-decoration: none;   /* remove underline */
    display: inline-block;   /* behave like button */
    margin: 6px 5px 0 0;

    transition: 0.3s;
}

.order:hover{
    background: linear-gradient(45deg, #43a047, #1b5e20);
}
 
</style>

<div class="product-box">

    <img src="<%=request.getContextPath()%>/images/<%=p.getImageUrl()%>">

    <h2><%=p.getName()%></h2>

    <p><b>Price:</b> ₹<%=p.getOfferPrice()%></p>
    <p><b>Category:</b> <%=p.getCategory()%></p>
    <p><%=p.getDescription()%></p>

    <% if(isAdmin){ %>
        <p><b>Stock:</b> <%=p.getStockQuantity()%></p>
    <% } %>

    <div class="btn-group">

    <% if(isAdmin){ %>

        <a href="edit-product.jsp?id=<%=p.getProductId()%>">
            <button class="btn edit">✏️ Edit</button>
        </a>

        <a href="DeleteProductServlet?id=<%=p.getProductId()%>">
            <button class="btn delete">🗑️ Delete</button>
        </a>

    <% } else if(!fromCart){ %>

    <!-- USER BUTTONS (ONLY if NOT from cart) -->

    <button class="btn cart" onclick="addToCart(<%=p.getProductId()%>)">
        🛒 Add to Cart
    </button>

    <a class="order" href="<%=request.getContextPath()%>/AddToCartServlet?id=<%= p.getProductId() %>&action=buy">Order</a>

	<% }   %>

    </div>

</div>
<script>
function addToCart(productId){

	fetch("<%=request.getContextPath()%>/AddToCartServlet?id=" + productId + "&action=cart")
    .then(response => {
        if(response.redirected){
            window.location.href = response.url; // login case
        }else{
            showToast("Item added to cart ✅");
        }
    });
}

// toast
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

    document.querySelector(".modal-content").appendChild(t);
    setTimeout(()=> t.remove(), 2000);
}
</script>
