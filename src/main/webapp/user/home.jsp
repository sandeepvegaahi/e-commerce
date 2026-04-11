<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home | ShopEase</title>

<style>
body{
margin:0;
font-family:'Segoe UI',sans-serif;
background:#f5ebe0;
}

/* Layout */
.main{
display:flex;
}

/* Sidebar */

.sidebar{
width:230px;
background:#fffaf5;
min-height:100vh;
padding:20px;
box-shadow:2px 0px 10px rgba(0,0,0,0.1);
}

.sidebar h3{
color:#9c6644;
display:flex;
align-items:center;
gap:8px;
}

.sidebar a{
display:flex;
align-items:center;
gap:8px;
padding:10px;
text-decoration:none;
color:#6d4c41;
border-radius:8px;
transition:0.3s;
}

.sidebar a:hover{
background:#fdf0e6;
transform:translateX(5px);
}

/* Icons inside sidebar */
.sidebar img{
width:18px;
}

/* Subcategory */

.sub{
margin-left:10px;
font-size:14px;
}

/* Content */

.content{
flex:1;
padding:30px;
}
</style>
</head>

<body>

<%@ include file="header.jsp" %>

<div class="main">

<!-- Sidebar -->

<div class="sidebar">
<!-- ALL PRODUCTS -->
<h3>🛒 Categories</h3>
<a href="home.jsp" class="sub">🛍️ All Products</a>

<!-- ELECTRONICS -->
<h3>📱 Electronics</h3>
<a href="home.jsp?category=laptop" class="sub">💻 Laptops</a>
<a href="home.jsp?category=phone" class="sub">📱 Phones</a>

<!-- FASHION -->
<h3>👗 Fashion</h3>
<a href="home.jsp?category=womens" class="sub">👩 Women Dresses</a>
<a href="home.jsp?category=mens" class="sub">👨 Men Dresses</a>
<a href="home.jsp?category=shoes" class="sub">👟 Shoes</a>

<!-- BEAUTY -->
<h3>💄 Beauty</h3>
<a href="home.jsp?category=makeup" class="sub">💄 Makeup</a>
<h3>📰 More</h3>
<a href="../getblogs.jsp">
📰 Blogs
</a>

</div>

<!-- Content -->

<div class="content">

 <jsp:include page="../getProduct.jsp" />

</div>

</div>

<%@ include file="footer.jsp" %>

</body>
</html>
<script>
function toggleFav(event, productId){
    event.stopPropagation();

    let icon = event.target;

    fetch("<%=request.getContextPath()%>/FavoriteServlet?id=" + productId)
    .then(res => res.text())
    .then(data => {

        data = data.trim();
        console.log("Response:", data);

        if(data === "added"){
            icon.innerHTML = "❤️";
        }
        else if(data === "removed"){
            icon.innerHTML = "🤍";
        }
    })
    .catch(err => console.log(err));
}
</script>