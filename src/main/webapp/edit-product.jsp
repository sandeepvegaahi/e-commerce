<%@ page import="dao.ProductDAO,model.Product" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    int id = Integer.parseInt(request.getParameter("id"));
    ProductDAO dao = new ProductDAO();
    Product product = null;

    for(Product p : dao.getAllProducts()){
        if(p.getProductId() == id){
            product = p;
            break;
        } 	
    }

    if(product == null){
        response.sendRedirect("getProduct.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
   
    <title>Edit Product | <%= product.getName() %></title>
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
            --warning: #f59e0b;
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: var(--bg);
            margin: 0;
            color: var(--text-main);
        }

        .page-wrapper {
            max-width: 1000px;
            margin: 50px auto;
            padding: 0 20px;
        }

        .header-section {
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header-section h2 {
            font-size: 28px;
            font-weight: 800;
            margin: 0;
            letter-spacing: -1px;
        }

        /* Two-Column Layout */
        .edit-grid {
            display: grid;
            grid-template-columns: 320px 1fr;
            gap: 30px;
        }

        /* Sidebar Preview */
        .preview-card {
            background: var(--white);
            border-radius: 20px;
            padding: 20px;
            border: 1px solid var(--border);
            height: fit-content;
            text-align: center;
        }

        .preview-card img {
            width: 100%;
            height: 200px;
            object-fit: contain;
            border-radius: 12px;
            background: #f1f5f9;
            margin-bottom: 15px;
        }

        .preview-card .status {
            display: inline-block;
            padding: 4px 12px;
            background: #fef3c7;
            color: #92400e;
            font-size: 12px;
            font-weight: 700;
            border-radius: 20px;
            margin-bottom: 10px;
        }

        /* Form Styling */
        .form-card {
            background: var(--white);
            padding: 35px;
            border-radius: 24px;
            border: 1px solid var(--border);
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.05);
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .full-width { grid-column: span 2; }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .form-group label {
            font-size: 13px;
            font-weight: 700;
            color: var(--text-muted);
            text-transform: uppercase;
        }

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

        input[type="text"], input[type="number"], textarea {
            width: 100%;
            padding: 12px 15px 12px 40px;
            border: 1px solid var(--border);
            border-radius: 10px;
            font-family: inherit;
            font-size: 15px;
            background: #fcfcfd;
            transition: all 0.2s;
            box-sizing: border-box;
        }

        textarea { padding: 12px 15px; resize: vertical; }

        input:focus, textarea:focus {
            outline: none;
            border-color: var(--primary);
            background: white;
            box-shadow: 0 0 0 4px rgba(37, 99, 235, 0.1);
        }

        /* Buttons */
        .action-group {
            display: flex;
            gap: 15px;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid var(--border);
        }

        .btn {
            padding: 14px 24px;
            border-radius: 12px;
            font-weight: 700;
            font-size: 15px;
            cursor: pointer;
            border: none;
            transition: 0.2s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            text-decoration: none;
        }

        .btn-update { background: var(--primary); color: white; flex: 2; }
        .btn-update:hover { background: #1d4ed8; transform: translateY(-2px); }

        .btn-cancel { background: #f1f5f9; color: var(--text-main); flex: 1; }
        .btn-cancel:hover { background: #e2e8f0; }

        @media (max-width: 850px) {
            .edit-grid { grid-template-columns: 1fr; }
            .preview-card { order: -1; }
        }
    </style>
</head>

<body>

    <jsp:include page="navbar.jsp" />

    <div class="page-wrapper">
        <div class="header-section">
            <h2><i class="fa-solid fa-pen-to-square" style="color: var(--primary);"></i> Edit Product</h2>
            <div style="color: var(--text-muted); font-size: 14px;">Product ID: #<%= product.getProductId() %></div>
        </div>

        <div class="edit-grid">
            <!-- Sidebar Preview -->
            <div class="preview-card">
                <div class="status">LIVE PREVIEW</div>
                <img src="<%= request.getContextPath() %>/images/<%= product.getImageUrl() %>" 
                     onerror="this.src='https://placehold.co/400x400?text=No+Image'" alt="Product">
                <h4 style="margin: 10px 0 5px 0;"><%= product.getName() %></h4>
                <p style="color: var(--primary); font-weight: 800; margin: 0;">₹<%= product.getOfferPrice() %></p>
            </div>

            <!-- Edit Form -->
            <div class="form-card">
                <form action="UpdateProductServlet" method="post">
                    <input type="hidden" name="id" value="<%= product.getProductId() %>">

                    <div class="form-grid">
                        <div class="form-group full-width">
                            <label>Product Name</label>
                            <div class="input-wrapper">
                                <i class="fa-solid fa-box"></i>
                                <input type="text" name="name" value="<%= product.getName() %>" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label>Category</label>
                            <div class="input-wrapper">
                                <i class="fa-solid fa-layer-group"></i>
                                <input type="text" name="category" value="<%= product.getCategory() %>" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label>Stock Quantity</label>
                            <div class="input-wrapper">
                                <i class="fa-solid fa-warehouse"></i>
                                <input type="number" name="stock" value="<%= product.getStockQuantity() %>" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label>Actual Price (₹)</label>
                            <div class="input-wrapper">
                                <i class="fa-solid fa-indian-rupee-sign"></i>
                                <input type="text" name="actualPrice" value="<%= product.getActualPrice() %>" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label>Offer Price (₹)</label>
                            <div class="input-wrapper">
                                <i class="fa-solid fa-tags"></i>
                                <input type="text" name="offerPrice" value="<%= product.getOfferPrice() %>" required>
                            </div>
                        </div>

                        <div class="form-group full-width">
                            <label>Image Filename</label>
                            <div class="input-wrapper">
                                <i class="fa-solid fa-link"></i>
                                <input type="text" name="image" value="<%= product.getImageUrl() %>">
                            </div>
                        </div>

                        <div class="form-group full-width">
                            <label>Description</label>
                            <textarea name="description" rows="4"><%= product.getDescription() %></textarea>
                        </div>
                    </div>

                    <div class="action-group">
                        <a href="getProduct.jsp" class="btn btn-cancel">Cancel</a>
                        <button type="submit" class="btn btn-update">
                            <i class="fa-solid fa-check-circle"></i> Update Product Details
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

</body>
</html>