<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
.footer{
background:linear-gradient(135deg,#6f4e37,#9c6644);
color:#fff;
padding:40px 20px;
margin-top:40px;
font-family:'Segoe UI',sans-serif;
}

.footer-columns{
display:flex;
justify-content:space-around;
flex-wrap:wrap;
gap:30px;
margin-bottom:25px;
}

.footer h4{
margin-bottom:12px;
font-size:18px;
border-bottom:2px solid #ddb892;
display:inline-block;
padding-bottom:5px;
}

.footer a{
color:#ffe8d6;
text-decoration:none;
display:block;
margin:6px 0;
font-size:14px;
transition:0.3s;
}

.footer a:hover{
color:#ffffff;
padding-left:5px;
}

/* Contact icons spacing */
.footer a span{
margin-right:6px;
}

/* Bottom line */

.footer-bottom{
text-align:center;
border-top:1px solid rgba(255,255,255,0.2);
padding-top:15px;
font-size:14px;
color:#f1dcc5;
}
</style>

<div class="footer">

<div class="footer-columns">

<div>
<h4>Get to Know Us</h4>
<a href="#">About Us</a>
<a href="#">Careers</a>
<a href="#">Blogs</a>
</div>

<div>
<h4>Help</h4>
<a href="#">Payments</a>
<a href="#">Shipping</a>
<a href="#">Returns</a>
<a href="#">FAQ</a>
</div>

<div>
<h4>Contact</h4>
<a href="tel:+919876543210"><span>📞</span>+91 98765 43210</a>
<a href="mailto:support@shopease.com"><span>📧</span>support@shopease.com</a>
<a href="#"><span>📍</span>India</a>
</div>

</div>

<div class="footer-bottom">
© 2026 ShopEase | Designed with ❤️
</div>

</div>