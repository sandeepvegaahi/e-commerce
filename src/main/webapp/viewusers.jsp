<%@ page import="java.util.List" %>
<%@ page import="dao.UserDAO" %>
<%@ page import="model.User" %>

<%
UserDAO dao = new UserDAO();
List<User> list = dao.getAllUsers();
%>

<!DOCTYPE html>
<html>
<head>
<title>All Users</title>
<link rel="icon" href="images/ican.jpg"> 

<style>
 
 
/* PAGE BACKGROUND */

body {
    font-family: 'Segoe UI', Tahoma, sans-serif;
    background: linear-gradient(135deg, #dfe9f3, #ffffff);
    padding: 30px;
    
}

/* TITLE */
h2 {
    text-align: center;
    color: #2a5298;
    margin-bottom: 10px;
}

/* BACK BUTTON */
.back-btn {
    display: inline-block;
    padding: 10px 18px;
    background: linear-gradient(135deg, #2a5298, #1e3c72);
    color: white;
    text-decoration: none;
    border-radius: 8px;
    font-size: 14px;
    transition: 0.3s;
}

.back-btn:hover {
    background: linear-gradient(135deg, #1e3c72, #2a5298);
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(0,0,0,0.2);
}

/* TABLE */
table {
    width: 85%;
    margin: auto;
    border-collapse: collapse;
    background: #ffffff;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 10px 25px rgba(0,0,0,0.1);
}

/* HEADER */
th {
    background: linear-gradient(135deg, #2a5298, #1e3c72);
    color: white;
    padding: 14px;
    font-size: 16px;
}

/* ROWS */
td {
    padding: 12px;
    border-bottom: 1px solid #eee;
}

/* HOVER EFFECT */
tr:hover {
    background: #f1f6ff;
    transition: 0.3s;
}

/* LINK STYLE */
a {
    text-decoration: none;
    color: #2a5298;
    font-weight: 500;
}

a:hover {
    color: #1e3c72;
    text-decoration: underline;
}

/* POPUP BACKGROUND */
.popup {
    display: none;
    position: fixed;
    z-index: 999;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.6);
    animation: fadeIn 0.3s ease;
}

/* POPUP BOX */
.popup-content {
    background: #ffffff;
    width: 420px;
    margin: 100px auto;
    padding: 25px;
    border-radius: 15px;
    position: relative;
    box-shadow: 0 15px 40px rgba(0,0,0,0.3);
    animation: slideDown 0.4s ease;
}

/* CLOSE BUTTON */
.close {
    position: absolute;
    right: 15px;
    top: 10px;
    font-size: 22px;
    cursor: pointer;
    color: #555;
}

.close:hover {
    color: red;
}

/* POPUP TEXT */
.popup-content h2 {
    text-align: center;
    color: #2a5298;
    margin-bottom: 15px;
}

.popup-content p {
    font-size: 15px;
    margin: 10px 0;
    color: #333;
}

/* ANIMATIONS */
@keyframes fadeIn {
    from {opacity: 0;}
    to {opacity: 1;}
}

@keyframes slideDown {
    from {
        transform: translateY(-50px);
        opacity: 0;
    }
    to {
        transform: translateY(0);
        opacity: 1;
    }
}
</style>


</head>

<body>
<jsp:include page="navbar.jsp" />


<h2>User List</h2>


<table>
<tr>
    <th>ID</th>
    <th>Name</th>
</tr>

<% for(User u : list){ %>
<tr>
    <td><%= u.getUserId() %></td>

    <td>
        <a href="#" onclick="showUser(
            '<%= u.getFullName() %>',
            '<%= u.getEmail() %>',
            '<%= u.getPhone() %>',
            '<%= u.getCity() %>',
            '<%= u.getState() %>',
            '<%= u.getPincode() %>'
        )">
            <%= u.getFullName() %>
        </a>
    </td>
</tr>
<% } %>

</table>

<!-- POPUP -->
<div id="popup" class="popup">
    <div class="popup-content">
        <span class="close" onclick="closePopup()">&times;</span>

        <h2>User Details</h2>

        <p><b>Name:</b> <span id="name"></span></p>
        <p><b>Email:</b> <span id="email"></span></p>
        <p><b>Phone:</b> <span id="phone"></span></p>
        <p><b>City:</b> <span id="city"></span></p>
        <p><b>State:</b> <span id="state"></span></p>
        <p><b>Pincode:</b> <span id="pincode"></span></p>
    </div>
</div>

<script>
function showUser(name, email, phone, city, state, pincode) {

    document.getElementById("name").innerText = name;
    document.getElementById("email").innerText = email;
    document.getElementById("phone").innerText = phone;
    document.getElementById("city").innerText = city;
    document.getElementById("state").innerText = state;
    document.getElementById("pincode").innerText = pincode;

    document.getElementById("popup").style.display = "block";
}

function closePopup() {
    document.getElementById("popup").style.display = "none";
}

</script>
<!-- BACK BUTTON AFTER TABLE -->
<div style="text-align:center; margin-top:25px;">
    <a href="dashboard.jsp" class="back-btn">Back to Dashboard</a>
</div>

</body>
</html>