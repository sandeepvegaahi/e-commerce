<%@ page import="java.util.*,dao.ProductDAO,model.Product" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
ProductDAO dao = new ProductDAO();
List<Product> list = dao.getAllProducts();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Inventory | Admin</title>
    
    <!-- Google Fonts & Icons -->
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root {
            --primary: #2563eb;
            --primary-dark: #1d4ed8;
            --bg-body: #f8fafc;
            --text-main: #1e293b;
            --text-muted: #64748b;
            --success: #10b981;
            --danger: #ef4444;
            --white: #ffffff;
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: var(--bg-body);
            margin: 0;
            color: var(--text-main);
            padding-bottom: 50px;
        }

        .container {
            max-width: 1300px;
            margin: 0 auto;
            padding: 0 20px;
        }

        /* HEADER SECTION */
        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 30px 0;
        }

        .top-bar h2 {
            font-size: 28px;
            font-weight: 700;
            margin: 0;
            letter-spacing: -0.5px;
        }

        .btn-group {
            display: flex;
            gap: 12px;
        }

        .btn {
            text-decoration: none;
            padding: 10px 20px;
            border-radius: 10px;
            font-weight: 600;
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: all 0.2s ease;
        }

        .btn-add { background: var(--primary); color: white; }
        .btn-add:hover { background: var(--primary-dark); transform: translateY(-2px); }
        .btn-back { background: white; color: var(--text-main); border: 1px solid #e2e8f0; }
        .btn-back:hover { background: #f1f5f9; }

        /* PRODUCT GRID */
        .card-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 25px;
        }

        .card {
            background: var(--white);
            border-radius: 16px;
            border: 1px solid #e2e8f0;
            overflow: hidden;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
        }

        .card:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 25px -5px rgba(0,0,0,0.1);
            border-color: var(--primary);
        }

        .image-wrapper {
            width: 100%;
            height: 200px;
            overflow: hidden;
            position: relative;
        }

        .image-wrapper img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s ease;
        }

        .card:hover .image-wrapper img {
            transform: scale(1.1);
        }

        .stock-badge {
            position: absolute;
            top: 12px;
            right: 12px;
            padding: 4px 10px;
            border-radius: 6px;
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(4px);
        }

        .card-content {
            padding: 20px;
        }

        .card-content h3 {
            margin: 0 0 8px 0;
            font-size: 18px;
            font-weight: 700;
            color: var(--text-main);
        }

        .category-tag {
            font-size: 12px;
            color: var(--primary);
            font-weight: 600;
            background: #eff6ff;
            padding: 2px 8px;
            border-radius: 4px;
        }

        .price-section {
            margin: 15px 0;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .price-actual {
            font-size: 20px;
            font-weight: 700;
            color: var(--text-main);
        }

        /* ACTIONS */
        .card-actions {
            display: flex;
            border-top: 1px solid #f1f5f9;
            background: #fafafa;
        }

        .action-link {
            flex: 1;
            text-align: center;
            padding: 12px;
            text-decoration: none;
            font-size: 13px;
            font-weight: 600;
            transition: 0.2s;
        }

        .edit-link { color: var(--success); border-right: 1px solid #f1f5f9; }
        .edit-link:hover { background: #ecfdf5; }
        .delete-link { color: var(--danger); }
        .delete-link:hover { background: #fef2f2; }

        /* MODAL DESIGN */
        .modal {
            display: none;
            position: fixed;
            inset: 0;
            background: rgba(15, 23, 42, 0.6);
            backdrop-filter: blur(4px);
            z-index: 2000;
            align-items: center;
            justify-content: center;
        }

        .modal-content {
            background: white;
            width: 90%;
            max-width: 500px;
            border-radius: 20px;
            padding: 30px;
            position: relative;
            max-height: 80vh;
            overflow-y: auto;
            box-shadow: 0 25px 50px -12px rgba(0,0,0,0.25);
        }

        .close-btn {
            position: absolute;
            top: 20px;
            right: 20px;
            font-size: 24px;
            cursor: pointer;
            color: var(--text-muted);
        }

        .modal-img {
            width: 100%;
            height: 250px;
            border-radius: 12px;
            object-fit: cover;
            margin-bottom: 20px;
        }

        .modal h3 { font-size: 24px; margin-bottom: 10px; }
        .detail-row { display: flex; justify-content: space-between; padding: 10px 0; border-bottom: 1px solid #f1f5f9; font-size: 14px; }
        .detail-row span:first-child { color: var(--text-muted); font-weight: 500; }
        .detail-row span:last-child { color: var(--text-main); font-weight: 600; }

    </style>
</head>

<body>

    <jsp:include page="navbar.jsp" />

    <div class="container">
        
        <div class="top-bar">
            <div>
                <h2>Product Inventory</h2>
                <p style="color: var(--text-muted); margin: 5px 0 0 0;">Manage your store catalog and stock levels.</p>
            </div>
            <div class="btn-group">
                <a href="dashboard.jsp" class="btn btn-back">
                    <i class="fa-solid fa-arrow-left"></i> Dashboard
                </a>
                <a href="addProduct.jsp" class="btn btn-add">
                    <i class="fa-solid fa-plus"></i> Add Product
                </a>
            </div>
        </div>

        <div class="card-container">
            <%
            for(Product p : list){
                // Dynamic stock color
                String stockColor = (p.getStockQuantity() < 10) ? "color: #ef4444;" : "color: #10b981;";
            %>
            
            <div class="card" onclick="openModal('<%= p.getProductId() %>')">
                <div class="image-wrapper">
                    <img src="<%= request.getContextPath() %>/images/<%= p.getImageUrl() %>" alt="Product Image">
                    <div class="stock-badge" style="<%= stockColor %>">
                        <i class="fa-solid fa-warehouse"></i> <%= p.getStockQuantity() %> units
                    </div>
                </div>

                <div class="card-content">
                    <span class="category-tag"><%= p.getCategory() %></span>
                    <h3><%= p.getName() %></h3>
                    
                    <div class="price-section">
                        <span class="price-actual">₹<%= p.getActualPrice() %></span>
                        <% if(p.getOfferPrice() < p.getActualPrice()) { %>
                            <span style="text-decoration: line-through; color: var(--text-muted); font-size: 14px;">₹<%= p.getOfferPrice() %></span>
                        <% } %>
                    </div>
                </div>

                <div class="card-actions" onclick="event.stopPropagation();">
                    <a class="action-link edit-link" href="edit-product.jsp?id=<%= p.getProductId() %>">
                        <i class="fa-solid fa-pen-to-square"></i> Edit
                    </a>
                    <a class="action-link delete-link" 
                       href="DeleteProductServlet?id=<%= p.getProductId() %>" 
                       onclick="return confirm('Archive this product?')">
                       <i class="fa-solid fa-trash-can"></i> Delete
                    </a>
                </div>
            </div>

            <!-- MODAL -->
            <div id="modal-<%= p.getProductId() %>" class="modal" onclick="closeModal('<%= p.getProductId() %>')">
                <div class="modal-content" onclick="event.stopPropagation();">
                    <span class="close-btn" onclick="closeModal('<%= p.getProductId() %>')">&times;</span>
                    
                    <img src="<%= request.getContextPath() %>/images/<%= p.getImageUrl() %>" class="modal-img">
                    
                    <h3><%= p.getName() %></h3>
                    <div class="detail-row"><span>Category</span><span><%= p.getCategory() %></span></div>
                    <div class="detail-row"><span>Actual Price</span><span>₹<%= p.getActualPrice() %></span></div>
                    <div class="detail-row"><span>Offer Price</span><span>₹<%= p.getOfferPrice() %></span></div>
                    <div class="detail-row"><span>In Stock</span><span style="<%= stockColor %>"><%= p.getStockQuantity() %></span></div>
                    
                    <div style="margin-top: 20px;">
                        <p style="font-size: 12px; font-weight: 700; color: var(--text-muted); text-transform: uppercase; margin-bottom: 5px;">Description</p>
                        <p style="font-size: 14px; line-height: 1.6; color: var(--text-main);"><%= p.getDescription() %></p>
                    </div>
                </div>
            </div>

            <% } %>
        </div>
    </div>

    <script>
        function openModal(id){
            const modal = document.getElementById('modal-' + id);
            modal.style.display = 'flex';
            document.body.style.overflow = 'hidden'; // Stop scrolling
        }

        function closeModal(id){
            const modal = document.getElementById('modal-' + id);
            modal.style.display = 'none';
            document.body.style.overflow = 'auto'; // Enable scrolling
        }

        // Close on escape key
        document.onkeydown = function(evt) {
            evt = evt || window.event;
            if (evt.keyCode == 27) {
                document.querySelectorAll('.modal').forEach(m => m.style.display = 'none');
                document.body.style.overflow = 'auto';
            }
        };
    </script>

</body>
</html>