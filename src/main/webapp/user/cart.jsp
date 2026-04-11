<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,model.CartItem" %>

<%
String path = request.getContextPath();
List<CartItem> list = (List<CartItem>) request.getAttribute("cartItems");
double total = 0;
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cart</title>

<style>
body {
    background: #f5efe6;  /* beige */
    font-family: Arial;
    margin: 0;
    padding: 0;
}

/* 🔝 TOP BAR */
.top-bar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 20px 40px;
    background: white;
    box-shadow: 0 2px 8px rgba(0,0,0,0.05);
}

.top-bar h2 {
    margin: 0;
}

.back-btn {
    text-decoration: none;
    color: #6b4c3b;
    font-weight: bold;
}

/* 🛒 CART GRID */
.cart {
    padding: 30px;
    display: flex;
    flex-direction: column;
     gap: 12px;   /* ✅ clean small spacing */
    margin-bottom: 120px;
}

/* 📦 CARD */
.card {
	background: #fffaf3;  /* light beige */
    border: 1px solid #e6d3b3;
    display: flex;
    align-items: center;
    justify-content: flex-start;  /* 🔥 IMPORTANT */
    gap:12px;
    background: white;
    border-radius: 12px;
   	padding: 12px;
    position: relative; 
   
}

.card:hover {
    transform: scale(1.01);
    box-shadow: 0 8px 18px rgba(0,0,0,0.12);
}

/* ✔ CHECKBOX */
.item-check {
    position: absolute;
    top: 10px;
    left: 10px;
    transform: scale(1.2);
    cursor: pointer;
    z-index: 100;   /* 🔥 stronger */
}
/* 🖼 IMAGE */
.card img {
    width: 140px;
    height: 100px;
    object-fit: contain;
    border-radius: 8px;
    background: #f8f8f8;
}

/* 📄 DETAILS */
.details {
    flex: 1;
}

.details h3 {
color: #4e342e; /* dark brown */
    margin: 0;
    font-size: 18px;
}

.price {
    color: #6b4c3b; /* coffee brown */
    font-weight: bold;
    margin: 5px 0;
}


/* 🔢 QTY */
.qty {
    display: flex;
    align-items: center;
    gap: 10px;
    margin: 10px 0;
}

.qty button {
    padding: 5px 10px;
    border: none;
    background: #6b4c3b;
    color: white;
    border-radius: 5px;
    cursor: pointer;
}

 
.qty button:hover,
.order-btn:hover {
    background: #4e342e;
}
/* ❌ REMOVE */
.remove {
    color: red;
    text-decoration: none;
    font-size: 14px;
}

/* 💰 TOTAL */
.total-box {
    position: fixed;
    bottom: 0;
    width: 100%;
    padding: 15px 40px;
    background: #fffaf3;
    border-top: 2px solid #e6d3b3;
    box-shadow: 0 -2px 10px rgba(0,0,0,0.1);

    display: flex;
    align-items: center;
}

/* LEFT */
.total-left {
    flex: 1;
    font-size: 18px;
    font-weight: bold;
}

/* CENTER */
.total-center {
    flex: 1;
    display: flex;
    justify-content: center;
}

/* RIGHT (empty but needed for perfect center) */
.total-right {
    flex: 1;
}
.order-btn {
    padding: 10px 20px;
    background: #6b4c3b;
    color: white;
    border: none;
    border-radius: 8px;
    cursor: pointer;

    white-space: nowrap; /* ✅ prevents cutting */
}
a {
    color: #6b4c3b;
}

/* 🛍 ORDER BUTTON */
.order-btn {
    margin-top: 10px;
    padding: 10px 20px;
    background: #6b4c3b;
    color: white;
    border: none;
    border-radius: 8px;
    cursor: pointer;
}

.order-btn:disabled {
    background: #aaa;
    cursor: not-allowed;
}

/* 📭 EMPTY */
.empty {
    text-align: center;
    font-size: 20px;
    margin-top: 50px;
}

/* 🔥 MODAL */
.modal {
    display: none;
    position: fixed;
    z-index: 1000;
    left: 0; 
    top: 0;
    width: 100%; 
    height: 100%;
    background: rgba(0,0,0,0.5); /* clean overlay */
}

.modal-content {
    background: white;
    margin: auto;
    padding: 20px;
    width: 70%;
    border-radius: 10px;
    max-height: 80vh;
    overflow-y: auto;
}
body.modal-open {
    overflow: hidden;
    
}
.close {
    float: right;
    font-size: 22px;
    cursor: pointer;
}
</style>
</head>

<body>

<div class="top-bar">
    <h2>🛒 My Cart</h2>
    <a href="<%= path %>/user/home.jsp" class="back-btn">← Back to Home</a>
</div>

<div class="cart">

<%
if(list != null && !list.isEmpty()){
for(CartItem item : list){ 
   double sub = item.getPrice() * item.getQuantity();
   total += sub;
%>

<div class="card" onclick="openProduct(<%= item.getProductId() %>)">

<input type="checkbox" class="item-check"
       data-price="<%= sub %>"
       data-id="<%= item.getProductId() %>"
       data-qty="<%= item.getQuantity() %>"
       <%= (item.getStockQuantity()==0 || item.getQuantity() > item.getStockQuantity()) ? "disabled" : "checked" %>
       onclick="event.stopPropagation(); updateTotal()">

<img src="<%= path %>/images/<%= item.getImage() %>">

<div class="details">

<h3><%= item.getName() %></h3>

<p class="price">₹ <%= item.getPrice() %></p>

<!-- STOCK -->
<p style="font-size:13px; font-weight:bold;
color:<%= item.getStockQuantity()==0 ? "#a94442" : 
         (item.getQuantity() > item.getStockQuantity() ? "#a94442" : 
         (item.getStockQuantity()<=5 ? "#c97b63" : "#6b4c3b")) %>;">
    
<% if(item.getStockQuantity()==0){ %>
    ❌ Out of Stock
<% } else if(item.getQuantity() > item.getStockQuantity()){ %>
    ❌ Only <%= item.getStockQuantity() %> available
<% } else if(item.getStockQuantity()<=5){ %>
    ⚠ Only <%= item.getStockQuantity() %> left
<% } else { %>
    ✔ In Stock
<% } %>
</p>

<!-- 🔥 QTY -->
<div class="qty" onclick="event.stopPropagation();">

<button onclick="event.stopPropagation(); updateQty(<%= item.getProductId() %>, 'dec', <%= item.getStockQuantity() %>)">➖</button>

<b id="qty-<%= item.getProductId() %>"><%= item.getQuantity() %></b>

<button onclick="event.stopPropagation(); updateQty(<%= item.getProductId() %>, 'inc', <%= item.getStockQuantity() %>)">➕</button>

</div>

<!-- 🔥 ADD ID FOR SUBTOTAL -->
<p>Subtotal: ₹ <span id="sub-<%= item.getProductId() %>"><%= sub %></span></p>

<button type="button"
        class="remove"
        onclick="event.stopPropagation(); removeItem(<%= item.getProductId() %>, event)">
    Remove
</button>

<br><br>

<% if(item.getStockQuantity()==0 || item.getQuantity() > item.getStockQuantity()){ %>
    <span style="color:#aaa;">Out of Stock</span>
<% } else { %>
    <a href="<%= path %>/BuyNowServlet?id=<%= item.getProductId() %>"
   onclick="event.stopPropagation();">
   ⚡ Buy Now
</a>
<% } %>

</div>
</div>

<% } } else { %>

<div class="empty">Your cart is empty 🛒</div>

<% } %>

<div class="total-box">

    <div class="total-left">
        Total: ₹ <span id="totalAmount"><%= total %></span>
    </div>

    <div class="total-center">
        <form action="<%= path %>/OrderAllServlet" method="post" onsubmit="return prepareOrder()">
            <input type="hidden" name="selectedIds" id="selectedIds">
            <button type="submit" class="order-btn" id="orderBtn">🛒 Order Selected</button>
        </form>
    </div>

    <div class="total-right"></div> <!-- empty (balances layout) -->

</div>
</div>

<!-- MODAL -->
<div id="productModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal()">&times;</span>
        <div id="modalBody">Loading...</div>
    </div>
</div>

<script>
function removeItem(productId,event){

    fetch('<%= path %>/RemoveCartServlet?id=' + productId)
    .then(res => res.text())
    .then(msg => {

        if(msg.trim() === "success"){

            // 🔥 REMOVE CARD DIRECTLY USING BUTTON
            let btn = event.target;
            let card = btn.closest(".card");

            if(card){
                card.remove();
            }

            updateTotal();
        }
    })
    .catch(err => console.log(err));
}
// 🔥 UPDATED QTY FUNCTION WITH STOCK CHECK
function updateQty(productId, action, stock){

    let qtyElement = document.getElementById("qty-" + productId);
    let currentQty = parseInt(qtyElement.innerText);

    // 🔥 PREVENT EXCEED STOCK
    if(action === "inc" && currentQty >= stock){
        alert("Only " + stock + " items available!");
        return;
    }

    // 🔥 PREVENT BELOW 1
    if(action === "dec" && currentQty <= 1){
        return;
    }

    fetch('<%= path %>/UpdateCartServlet?id=' + productId + '&action=' + action)
    .then(res => res.text())
    .then(data => {

        let parts = data.split(",");

        let qty = parts[0].split(":")[1];
        let sub = parts[1].split(":")[1];
        let total = parts[2].split(":")[1];

        document.getElementById("qty-" + productId).innerText = qty;
        document.getElementById("sub-" + productId).innerText = sub;
        document.getElementById("totalAmount").innerText = total;

        // 🔥 UPDATE CHECKBOX DATA
        let cb = document.querySelector(`input[data-id='${productId}']`);
        cb.setAttribute("data-qty", qty);
        cb.setAttribute("data-price", sub);

        updateTotal();
    });
}


// 🔥 FIXED → LOAD YOUR viewProduct.jsp
function openProduct(id){
    document.getElementById("productModal").style.display="block";

    // ✅ ADD THIS BACK PROPERLY
    document.body.classList.add("modal-open");

    fetch('<%= path %>/viewProduct.jsp?id='+id+'&from=cart')
    .then(res=>res.text())
    .then(data=>{
        document.getElementById("modalBody").innerHTML=data;
    });
}

function closeModal(){
    document.getElementById("productModal").style.display = "none";

    // ✅ REMOVE CLASS (VERY IMPORTANT)
    document.body.classList.remove("modal-open");

    document.getElementById("modalBody").innerHTML = "";
}
window.onclick=function(e){
    let modal=document.getElementById("productModal");
    if(e.target===modal){
        closeModal();
    }
};
function updateTotal(){
    let checkboxes=document.querySelectorAll(".item-check");
    let total=0;
    let count=0;

    checkboxes.forEach(cb=>{
        if(cb.checked){
            total+=parseFloat(cb.getAttribute("data-price"));
            count++;
        }
    });

    document.getElementById("totalAmount").innerText=total.toFixed(2);
    document.getElementById("orderBtn").disabled=(count===0);
}

function prepareOrder(){
    let selected=[];

    document.querySelectorAll(".item-check:checked").forEach(cb=>{
        let id = cb.getAttribute("data-id");
        let qty = cb.getAttribute("data-qty");

        selected.push(id + ":" + qty);
    });

    document.getElementById("selectedIds").value = selected.join(",");
    return true;
}

updateTotal();

</script>

</body>
</html>