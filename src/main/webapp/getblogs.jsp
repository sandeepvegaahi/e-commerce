<%@ page import="java.util.*,dao.BlogDAO,model.Blog" %>
<%@ page import="model.Admins" %>

<%
    Admins admin = (Admins) session.getAttribute("admin");
    if(admin == null){
        response.sendRedirect("admin-login.jsp");
        return;
    }

    BlogDAO dao = new BlogDAO();
    List<Blog> list = dao.getAllBlogs();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blog Management | Admin</title>
    <link rel="icon" href="images/ican.jpg"> 
    
    <!-- Google Fonts & FontAwesome -->
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root {
            --primary: #2563eb;
            --accent: #f97316;
            --bg: #f8fafc;
            --text-dark: #1e293b;
            --text-muted: #64748b;
            --white: #ffffff;
            --danger: #ef4444;
            --success: #10b981;
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: var(--bg);
            margin: 0;
            color: var(--text-dark);
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 40px 20px;
        }

        /* --- HEADER SECTION --- */
        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 40px;
        }

        .top-bar h2 {
            font-size: 32px;
            font-weight: 800;
            margin: 0;
            letter-spacing: -1px;
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
            transition: all 0.3s;
        }

        .btn-add { background: var(--primary); color: white; border: 1px solid var(--primary); }
        .btn-add:hover { background: #1d4ed8; transform: translateY(-2px); }
        .btn-back { background: white; color: var(--text-dark); border: 1px solid #e2e8f0; }
        .btn-back:hover { background: #f1f5f9; }

        /* --- CARD GRID --- */
        .card-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 30px;
        }

        .blog-card {
            background: var(--white);
            border-radius: 20px;
            border: 1px solid #e2e8f0;
            overflow: hidden;
            transition: 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            display: flex;
            flex-direction: column;
        }

        .blog-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.05);
            border-color: var(--primary);
        }

        .card-img-wrapper {
            position: relative;
            height: 200px;
            overflow: hidden;
        }

        .card-img-wrapper img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .date-badge {
            position: absolute;
            bottom: 12px;
            left: 12px;
            background: rgba(255, 255, 255, 0.9);
            padding: 4px 12px;
            border-radius: 6px;
            font-size: 11px;
            font-weight: 700;
            color: var(--primary);
            backdrop-filter: blur(4px);
        }

        .card-body {
            padding: 24px;
            flex-grow: 1;
        }

        .card-body h3 {
            margin: 0 0 12px 0;
            font-size: 20px;
            line-height: 1.4;
        }

        .card-body p {
            font-size: 14px;
            color: var(--text-muted);
            line-height: 1.6;
            margin-bottom: 20px;
        }

        .read-more {
            color: var(--primary);
            font-weight: 700;
            font-size: 13px;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 5px;
            cursor: pointer;
        }

        /* --- ACTIONS --- */
        .card-footer {
            padding: 15px 24px;
            background: #fafafa;
            border-top: 1px solid #f1f5f9;
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }

        .action-icon {
            width: 35px;
            height: 35px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            text-decoration: none;
            transition: 0.2s;
        }

        .edit-icon { background: #dcfce7; color: var(--success); }
        .edit-icon:hover { background: var(--success); color: white; }
        .delete-icon { background: #fee2e2; color: var(--danger); }
        .delete-icon:hover { background: var(--danger); color: white; }

        /* --- MODAL --- */
        .modal {
            display: none;
            position: fixed;
            inset: 0;
            background: rgba(15, 23, 42, 0.8);
            backdrop-filter: blur(8px);
            z-index: 2000;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .modal-content {
            background: white;
            width: 100%;
            max-width: 700px;
            border-radius: 24px;
            overflow: hidden;
            position: relative;
            animation: slideIn 0.3s ease-out;
            max-height: 90vh;
            display: flex;
            flex-direction: column;
        }

        @keyframes slideIn { from { transform: translateY(30px); opacity: 0; } to { transform: translateY(0); opacity: 1; } }

        .modal-header img { width: 100%; height: 300px; object-fit: cover; }
        
        .modal-body { padding: 40px; overflow-y: auto; }
        .modal-body h2 { margin-top: 0; font-size: 28px; }
        .modal-body p { line-height: 1.8; color: #475569; }

        .close-modal {
            position: absolute;
            top: 20px;
            right: 20px;
            background: white;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            z-index: 10;
        }
    </style>
</head>

<body>

    <jsp:include page="navbar.jsp" />

    <div class="container">
        
        <div class="top-bar">
            <div>
                <h2>Blog Articles</h2>
                <p style="color: var(--text-muted); margin: 5px 0 0 0;">Manage your shared stories and news.</p>
            </div>
            <div class="btn-group">
                <a href="dashboard.jsp" class="btn btn-back">
                    <i class="fa-solid fa-arrow-left"></i> Dashboard
                </a>
                <a href="addblogs.jsp" class="btn btn-add">
                    <i class="fa-solid fa-plus"></i> Create Post
                </a>
            </div>
        </div>

        <div class="card-container">
            <% for(Blog b : list) { %>

            <div class="blog-card">
                <div class="card-img-wrapper">
                    <img src="<%= request.getContextPath() %>/blogsimg/<%= b.getImageUrl() %>" alt="Blog Image">
                    <div class="date-badge"><%= b.getCreatedAt() %></div>
                </div>

                <div class="card-body">
                    <h3><%= b.getTitle() %></h3>
                    <p>
                        <%= b.getContent().length() > 110 ? 
                            b.getContent().substring(0, 110) + "..." : 
                            b.getContent() %>
                    </p>
                    <div class="read-more" onclick="openModal('<%= b.getBlogId() %>')">
                        Read Full Article <i class="fa-solid fa-arrow-right"></i>
                    </div>
                </div>

                <div class="card-footer">
                    <a href="edit-blog.jsp?id=<%= b.getBlogId() %>" class="action-icon edit-icon" title="Edit">
                        <i class="fa-solid fa-pen-to-square"></i>
                    </a>
                    <a href="DeleteBlogServlet?id=<%= b.getBlogId() %>" 
                       class="action-icon delete-icon" 
                       onclick="return confirm('Permanently delete this blog?')" title="Delete">
                        <i class="fa-solid fa-trash-can"></i>
                    </a>
                </div>
            </div>

            <!-- MODAL -->
            <div id="modal-<%= b.getBlogId() %>" class="modal" onclick="closeModal('<%= b.getBlogId() %>')">
                <div class="modal-content" onclick="event.stopPropagation()">
                    <div class="close-modal" onclick="closeModal('<%= b.getBlogId() %>')">
                        <i class="fa-solid fa-xmark"></i>
                    </div>
                    
                    <div class="modal-header">
                        <img src="<%= request.getContextPath() %>/blogsimg/<%= b.getImageUrl() %>">
                    </div>
                    
                    <div class="modal-body">
                        <small style="color: var(--primary); font-weight: 700; text-transform: uppercase;">Published: <%= b.getCreatedAt() %></small>
                        <h2><%= b.getTitle() %></h2>
                        <p><%= b.getContent() %></p>
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
            document.body.style.overflow = 'hidden'; // Stop background scrolling
        }

        function closeModal(id){
            const modal = document.getElementById('modal-' + id);
            modal.style.display = 'none';
            document.body.style.overflow = 'auto'; // Restore scrolling
        }

        // Close modal when pressing 'Esc'
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