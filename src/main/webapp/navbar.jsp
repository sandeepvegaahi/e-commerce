<%@ page import="model.Admins" %>

<%
    Admins admin = (Admins) session.getAttribute("admin");
    if(admin == null){
        response.sendRedirect("index.jsp");
        return;
    }
%>

<!-- Google Fonts for a modern look -->
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
<!-- Font Awesome for icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
    :root {
        --primary-blue: #2563eb;
        --dark-blue: #1e40af;
        --bg-light: #f8fafc;
        --text-main: #1e293b;
    }

    body {
        margin: 0;
        font-family: 'Inter', sans-serif;
        background-color: var(--bg-light);
    }

    .navbar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        background: #ffffff; 
        padding: 0 40px;
        height: 70px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        position: sticky;
        top: 0;
        z-index: 1000;
    }

    /* Left Side: Brand/Admin Name */
    .brand-section {
        display: flex;
        align-items: center;
        gap: 12px;
    }

    .admin-avatar {
        width: 35px;
        height: 35px;
        background: var(--primary-blue);
        color: white;
        border-radius: 8px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: bold;
        text-transform: uppercase;
    }

    .navbar .title {
        font-size: 18px;
        font-weight: 600;
        color: var(--text-main);
    }

    /* Right Side: Navigation */
    .navbar ul {
        list-style: none;
        display: flex;
        gap: 8px;
        margin: 0;
        padding: 0;
        align-items: center;
    }

    .navbar ul li a {
        text-decoration: none;
        color: #64748b;
        font-size: 14px;
        font-weight: 500;
        padding: 10px 16px;
        border-radius: 8px;
        transition: all 0.2s ease;
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .navbar ul li a:hover {
        background: #f1f5f9;
        color: var(--primary-blue);
    }

    /* Special style for Logout */
    .navbar ul li a.logout-btn {
        color: #ef4444;
        background: #fef2f2;
        margin-left: 10px;
    }

    .navbar ul li a.logout-btn:hover {
        background: #fee2e2;
    }

    /* Active State (Example) */
    .navbar ul li a.active {
        background: var(--primary-blue);
        color: white;
    }
</style>

<div class="navbar">
    <div class="brand-section">
        <div class="admin-avatar">
            <%= admin.getName().substring(0,1) %>
        </div>
        <div class="title">
            <%= admin.getName() %> <span style="font-weight:400; color:#94a3b8; font-size:14px;">(Admin)</span>
        </div>
    </div>

    <ul>
        <li><a href="dashboard.jsp" class="active"><i class="fa-solid fa-house"></i> Home</a></li>
        <li><a href="getProduct.jsp"><i class="fa-solid fa-box"></i> Products</a></li>
        <li><a href="getblogs.jsp"><i class="fa-solid fa-pen-to-square"></i> Blogs</a></li>
        <li><a href="user/home.jsp" class="logout-btn"><i class="fa-solid fa-right-from-bracket"></i> Logout</a></li>
    </ul>
</div>