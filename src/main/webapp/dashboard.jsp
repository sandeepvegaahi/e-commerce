<%@ page import="dao.ProductDAO" %>
<%@ page import="dao.BlogDAO" %>
<%@ page import="dao.UserDAO" %>
<%@ page import="model.Admins" %>

<%
    Admins admin = (Admins) session.getAttribute("admin");
    if(admin == null){
        response.sendRedirect("index.jsp");
        return; 
    }

    ProductDAO dao = new ProductDAO();
    BlogDAO blogDAO = new BlogDAO();
    UserDAO userDAO = new UserDAO();

    int totalProducts = dao.getProductCount();
    int totalBlogs = blogDAO.getBlogCount();
    int totalUsers = userDAO.getUserCount();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard | Overview</title>
    <link rel="icon" href="images/ican.jpg"> 
    <!-- Google Fonts & Icons -->
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root {
            --primary: #2563eb;
            --success: #10b981;
            --warning: #f59e0b;
            --danger: #ef4444;
            --text-dark: #0f172a;
            --text-muted: #64748b;
            --bg-body: #f1f5f9;
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: var(--bg-body);
            margin: 0;
            color: var(--text-dark);
        }

        /* Welcome Section */
        .welcome-hero {
            padding: 40px 40px 20px 40px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .welcome-hero h2 {
            margin: 0;
            font-size: 28px;
            font-weight: 700;
        }

        .welcome-hero p {
            color: var(--text-muted);
            margin-top: 5px;
        }

        /* Grid Layout */
        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
            gap: 25px;
            padding: 20px 40px 40px 40px;
            max-width: 1200px;
            margin: 0 auto;
        }

        /* Card Styling */
        .stat-card {
            background: #ffffff;
            border-radius: 16px;
            padding: 24px;
            border: 1px solid rgba(0, 0, 0, 0.05);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
        }

        .card-icon {
            width: 48px;
            height: 48px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            margin-bottom: 20px;
        }

        /* Specific Colors for Icons */
        .icon-products { background: #dbeafe; color: #1d4ed8; }
        .icon-blogs    { background: #fef3c7; color: #b45309; }
        .icon-users    { background: #dcfce7; color: #15803d; }
        .icon-orders   { background: #fce7f3; color: #be185d; }

        .stat-card h3 {
            font-size: 14px;
            font-weight: 600;
            color: var(--text-muted);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin: 0;
        }

        .stat-card .number {
            font-size: 32px;
            font-weight: 700;
            margin: 10px 0;
            display: block;
        }

        .manage-link {
            text-decoration: none;
            font-size: 13px;
            font-weight: 600;
            color: var(--primary);
            display: flex;
            align-items: center;
            gap: 5px;
            transition: gap 0.2s;
        }

        .manage-link:hover {
            gap: 10px;
        }

        /* Subtle "Glass" Effect for the background */
        .bg-accent {
            position: fixed;
            top: 0;
            right: 0;
            width: 400px;
            height: 400px;
            background: radial-gradient(circle, rgba(37, 99, 235, 0.05) 0%, transparent 70%);
            z-index: -1;
        }

        @media (max-width: 640px) {
            .welcome-hero, .dashboard-grid { padding: 20px; }
        }
    </style>
</head>
<body>

<div class="bg-accent"></div>

<!-- Your Navbar -->
<jsp:include page="navbar.jsp" />

<div class="welcome-hero">
    <h2>Welcome back, <%= admin.getName() %> </h2>
    <p>Here is what's happening with your store today.</p>
</div>

<div class="dashboard-grid">
    
    <!-- Products -->
    <div class="stat-card">
        <div class="card-icon icon-products">
            <i class="fa-solid fa-box-open"></i>
        </div>
        <h3>Total Products</h3>
        <span class="number"><%= totalProducts %></span>
        <a href="getProduct.jsp" class="manage-link">Manage Inventory <i class="fa-solid fa-arrow-right"></i></a>
    </div>

    <!-- Blogs -->
    <div class="stat-card">
        <div class="card-icon icon-blogs">
            <i class="fa-solid fa-newspaper"></i>
        </div>
        <h3>Active Blogs</h3>
        <span class="number"><%= totalBlogs %></span>
        <a href="getblogs.jsp" class="manage-link">Edit Content <i class="fa-solid fa-arrow-right"></i></a>
    </div>

    <!-- Users -->
    <div class="stat-card">
        <div class="card-icon icon-users">
            <i class="fa-solid fa-users"></i>
        </div>
        <h3>Registered Users</h3>
        <span class="number"><%= totalUsers %></span>
        <a href="viewusers.jsp" class="manage-link">View Customers <i class="fa-solid fa-arrow-right"></i></a>
    </div>

    <!-- Orders -->
    <div class="stat-card">
        <div class="card-icon icon-orders">
            <i class="fa-solid fa-cart-shopping"></i>
        </div>
        <h3>New Orders</h3>
        <span class="number">5</span>
        <a href="getorders.jsp" class="manage-link">Review Orders <i class="fa-solid fa-arrow-right"></i></a>
    </div>

</div>

</body>
</html>