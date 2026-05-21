<%@ page import="model.Admins" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    Admins admin = (Admins) session.getAttribute("admin");
    if(admin == null){
        response.sendRedirect("index.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Product | Admin Inventory</title>
    <link rel="icon" href="images/ican.jpg"> 
    
    <!-- Google Fonts & FontAwesome -->
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root {
            --primary: #2563eb;
            --bg: #f8fafc;
            --white: #ffffff;
            --text-main: #1e293b;
            --text-muted: #64748b;
            --border: #e2e8f0;
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: var(--bg);
            margin: 0;
            color: var(--text-main);
        }

        .page-container {
            max-width: 900px;
            margin: 40px auto;
            padding: 0 20px;
        }

        /* Header Section */
        .header-box {
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
            margin-bottom: 30px;
        }

        .header-box h2 {
            font-size: 28px;
            font-weight: 800;
            margin: 0;
            color: var(--text-main);
        }

        .back-link {
            text-decoration: none;
            color: var(--primary);
            font-size: 14px;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        /* Form Card Styling */
        .form-card {
            background: var(--white);
            padding: 40px;
            border-radius: 20px;
            border: 1px solid var(--border);
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.05);
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 25px;
        }

        .full-row {
            grid-column: span 2;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .form-group label {
            font-size: 13px;
            font-weight: 700;
            color: var(--text-main);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        /* Input Styling */
        .input-wrapper {
            position: relative;
            display: flex;
            align-items: center;
        }

        .input-wrapper i {
            position: absolute;
            left: 15px;
            color: var(--text-muted);
            font-size: 14px;
        }

        .form-group input, 
        .form-group textarea {
            width: 100%;
            padding: 12px 15px 12px 40px; /* Space for icon */
            border: 1px solid var(--border);
            border-radius: 10px;
            font-family: inherit;
            font-size: 15px;
            transition: all 0.2s ease;
            background: #fcfcfd;
        }

        /* Special padding for textarea (no icon) */
        .form-group textarea {
            padding: 12px 15px;
            resize: vertical;
        }

        .form-group input:focus, 
        .form-group textarea:focus {
            outline: none;
            border-color: var(--primary);
            background: #fff;
            box-shadow: 0 0 0 4px rgba(37, 99, 235, 0.1);
        }

        /* Button Styling */
        .submit-area {
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid var(--border);
        }

        .submit-btn {
            background: var(--primary);
            color: white;
            border: none;
            padding: 15px;
            width: 100%;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 700;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            transition: 0.3s;
        }

        .submit-btn:hover {
            background: #1d4ed8;
            transform: translateY(-2px);
            box-shadow: 0 10px 15px -3px rgba(37, 99, 235, 0.3);
        }

        @media (max-width: 600px) {
            .form-grid { grid-template-columns: 1fr; }
            .full-row { grid-column: span 1; }
        }
    </style>
</head>

<body>

    <jsp:include page="navbar.jsp" />

    <div class="page-container">
        <div class="header-box">
            <div>
                <h2>Add New Product</h2>
                <p style="color: var(--text-muted); margin: 5px 0 0 0;">Fill in the details to expand your catalog.</p>
            </div>
            <a href="getProduct.jsp" class="back-link">
                <i class="fa-solid fa-arrow-left"></i> Back to List
            </a>
        </div>

        <div class="form-card">
            <form action="AdminProductServlet" method="post">
                
                <div class="form-grid">
                    <!-- Name -->
                    <div class="form-group">
                        <label>Product Name</label>
                        <div class="input-wrapper">
                            <i class="fa-solid fa-tag"></i>
                            <input type="text" name="name" placeholder="e.g. Wireless Headset" required>
                        </div>
                    </div>

                    <!-- Category -->
                    <div class="form-group">
                        <label>Category</label>
                        <div class="input-wrapper">
                            <i class="fa-solid fa-layer-group"></i>
                            <input type="text" name="category" placeholder="e.g. Electronics" required>
                        </div>
                    </div>

                    <!-- Actual Price -->
                    <div class="form-group">
                        <label>Actual Price (₹)</label>
                        <div class="input-wrapper">
                            <i class="fa-solid fa-indian-rupee-sign"></i>
                            <input type="text" name="actualPrice" placeholder="0.00" required>
                        </div>
                    </div>

                    <!-- Offer Price -->
                    <div class="form-group">
                        <label>Offer Price (₹)</label>
                        <div class="input-wrapper">
                            <i class="fa-solid fa-bolt"></i>
                            <input type="text" name="offerPrice" placeholder="0.00" required>
                        </div>
                    </div>

                    <!-- Stock -->
                    <div class="form-group">
                        <label>Initial Stock</label>
                        <div class="input-wrapper">
                            <i class="fa-solid fa-boxes-stacked"></i>
                            <input type="number" name="stock" placeholder="Quantity" required>
                        </div>
                    </div>

                    <!-- Image URL -->
                    <div class="form-group">
                        <label>Image Filename</label>
                        <div class="input-wrapper">
                            <i class="fa-solid fa-image"></i>
                            <input type="text" name="image" placeholder="product-image.jpg">
                        </div>
                    </div>

                    <!-- Description -->
                    <div class="form-group full-row">
                        <label>Description</label>
                        <textarea name="description" rows="5" placeholder="Describe the key features of the product..."></textarea>
                    </div>
                </div>

                <div class="submit-area">
                    <button type="submit" class="submit-btn">
                        <i class="fa-solid fa-circle-plus"></i> Add Product to Store
                    </button>
                </div>

            </form>
        </div>
    </div>

</body>
</html>