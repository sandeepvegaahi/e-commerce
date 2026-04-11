<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*,dao.OrderDAO,model.User" %>
<%
User user = (User) session.getAttribute("user");

if(user == null){
    response.sendRedirect("../login.jsp");
    return;
}

OrderDAO dao = new OrderDAO();
List<Map<String,Object>> list = dao.getUserOrders(user.getUserId());

String path = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Orders</title>

<style>
body{
    background:#f5efe6;
    font-family: Arial;
    margin:0;
}

/* TOP BAR */
.top{
    padding:15px 20px;
    background:white;
    display:flex;
    justify-content:space-between;
    align-items:center;
}

.top a{
    text-decoration:none;
    color:#6b4c3b;
}

/* ORDER CARD */
.order{
    margin:20px;
    padding:15px;
    background:white;
    border-radius:10px;
    box-shadow:0 2px 8px rgba(0,0,0,0.1);
}

/* HEADER */
.order-header{
    display:flex;
    justify-content:space-between;
    border-bottom:1px solid #ddd;
    padding-bottom:10px;
}

/* ITEMS */
.item{
    display:flex;
    align-items:center;
    gap:15px;
    margin-top:10px;
}

.item img{
    width:80px;
    height:80px;
    object-fit:contain;
}

/* STATUS */
.status{
    font-weight:bold;
    color:green;
}

/* BUTTONS */
.btn{
    padding:5px 10px;
    border:none;
    border-radius:5px;
    cursor:pointer;
    margin-top:5px;
}

.cancel{
    background:#ff4d4d;
    color:white;
}

.track{
    background:#6b4c3b;
    color:white;
}

/* MODAL */
.modal{
    display:none;
    position:fixed;
    width:100%;
    height:100%;
    background:rgba(0,0,0,0.5);
    top:0;
    left:0;
}

.modal-content{
    background:white;
    margin:60px auto;
    padding:20px;
    width:400px;
    border-radius:10px;
}

/* TIMELINE */
.timeline{
    border-left:3px solid #6b4c3b;
    margin-left:20px;
    padding-left:20px;
}

.step{
    margin:15px 0;
    position:relative;
}

.step::before{
    content:'';
    position:absolute;
    left:-29px;
    top:5px;
    width:12px;
    height:12px;
    background:#6b4c3b;
    border-radius:50%;
}

.close{
    float:right;
    cursor:pointer;
    font-size:20px;
}

.empty{
    text-align:center;
    margin-top:50px;
    font-size:20px;
}
</style>
</head>

<body>

<div class="top">
    <h2>📦 My Orders</h2>
    <a href="<%=path%>/user/home.jsp">← Back</a>
</div>

<%
if(list.isEmpty()){
%>
<div class="empty">No orders yet 😢</div>
<%
}else{

int currentOrder = -1;

for(Map<String,Object> row : list){

int orderId = (int)row.get("orderId");

if(orderId != currentOrder){
    if(currentOrder != -1){
%>
</div>
<%
    }
    currentOrder = orderId;
%>

<div class="order" id="order-<%=orderId%>">

<div class="order-header">

<div>
    <b>Order ID:</b> <%=orderId%><br>
    <b>Date:</b> <%=row.get("date")%>
</div>

<div>
    <b>Total:</b> ₹<%=row.get("total")%><br>

    <span class="status" id="status-<%=orderId%>">
        <%=row.get("status")%>
    </span><br>

    <% if(!"Delivered".equals(row.get("status")) && !"Cancelled".equals(row.get("status"))){ %>
        <button class="btn cancel" onclick="cancelOrder(<%=orderId%>)">Cancel</button>
    <% } %>

    <button class="btn track" onclick="trackOrder(<%=orderId%>)">Track</button>
</div>

</div>

<%
}
%>

<div class="item">
    <img src="<%=path%>/images/<%=row.get("image")%>">

    <div>
        <b><%=row.get("name")%></b><br>
        Qty: <%=row.get("qty")%><br>
        ₹ <%=row.get("price")%>
    </div>
</div>

<%
}
%>
</div>
<%
}
%>

<!-- TRACK MODAL -->
<div id="trackModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeTrack()">&times;</span>
        <h3>📍 Order Tracking</h3>
        <div id="trackBody"></div>
    </div>
</div>

<script>

/* CANCEL ORDER (NO REFRESH) */
function cancelOrder(orderId){

    fetch("<%=path%>/CancelOrderServlet?id=" + orderId)
    .then(res => res.text())
    .then(() => {

        // update UI instantly
        document.getElementById("status-" + orderId).innerText = "Cancelled";

        alert("Order Cancelled");
    });
}


/* TRACK ORDER MODAL */
function trackOrder(orderId){

    document.getElementById("trackModal").style.display = "block";

    fetch("<%=path%>/TrackOrderServlet?id=" + orderId)
    .then(res => res.text())
    .then(data => {

        document.getElementById("trackBody").innerHTML =
            "<div class='timeline'>" + data + "</div>";
    });
}

function closeTrack(){
    document.getElementById("trackModal").style.display = "none";
}

</script>

</body>
</html>