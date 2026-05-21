<%@ page import="dao.BlogDAO,model.Blog" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // Fetch ID and Blog data
    int id = Integer.parseInt(request.getParameter("id"));
    BlogDAO dao = new BlogDAO();
    Blog blog = null;

    for(Blog b : dao.getAllBlogs()){
        if(b.getBlogId() == id){
            blog = b;
            break;
        }
    }
    
    // Safety check in case blog is not found
    if(blog == null) {
        response.sendRedirect("getblogs.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Post | <%= blog.getTitle() %></title>
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
            --danger: #ef4444;
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: var(--bg);
            margin: 0;
            color: var(--text-main);
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .main-wrapper {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px 20px;
        }

        .edit-container {
            background: var(--white);
            width: 100%;
            max-width: 850px;
            border-radius: 24px;
            border: 1px solid var(--border);
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.05);
            overflow: hidden;
            display: grid;
            grid-template-columns: 1fr;
        }

        /* Split view: Image Preview at top, form at bottom */
        .image-preview-header {
            height: 200px;
            background: #1e293b;
            position: relative;
            overflow: hidden;
        }

        .image-preview-header img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            opacity: 0.6;
            filter: blur(2px);
        }

        .header-content {
            position: absolute;
            inset: 0;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            color: white;
            text-align: center;
            padding: 20px;
        }

        .header-content h2 {
            margin: 0;
            font-size: 28px;
            font-weight: 800;
            letter-spacing: -1px;
        }

        .header-content p {
            font-size: 14px;
            opacity: 0.8;
            margin-top: 5px;
        }

        /* Form Styling */
        .form-section {
            padding: 40px;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .full-width {
            grid-column: span 2;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            font-size: 13px;
            font-weight: 700;
            color: var(--text-muted);
            text-transform: uppercase;
            margin-bottom: 8px;
            letter-spacing: 0.5px;
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

        input[type="text"], 
        textarea {
            width: 100%;
            padding: 14px 16px 14px 40px;
            border: 1px solid var(--border);
            border-radius: 12px;
            font-family: inherit;
            font-size: 15px;
            background-color: #fcfcfd;
            transition: all 0.2s;
            box-sizing: border-box;
        }

        textarea {
            padding: 14px 16px;
            resize: vertical;
            min-height: 180px;
        }

        input:focus, textarea:focus {
            outline: none;
            border-color: var(--primary);
            background-color: #fff;
            box-shadow: 0 0 0 4px rgba(37, 99, 235, 0.1);
        }

        /* Action Buttons */
        .button-row {
            display: flex;
            gap: 15px;
            margin-top: 20px;
        }

        .btn {
            flex: 1;
            padding: 14px 24px;
            border-radius: 12px;
            font-weight: 700;
            font-size: 15px;
            cursor: pointer;
            border: none;
            transition: all 0.2s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            text-decoration: none;
        }

        .btn-update {
            background: var(--primary);
            color: white;
        }

        .btn-update:hover {
            background: #1d4ed8;
            transform: translateY(-2px);
            box-shadow: 0 10px 15px -3px rgba(37, 99, 235, 0.3);
        }

        .btn-cancel {
            background: #fef2f2;
            color: var(--danger);
        }

        .btn-cancel:hover {
            background: #fee2e2;
        }

        @media (max-width: 600px) {
            .form-grid { grid-template-columns: 1fr; }
            .full-width { grid-column: span 1; }
        }
    </style>
</head>

<body>

    <jsp:include page="navbar.jsp" />

    <div class="main-wrapper">
        <div class="edit-container">
            
            <!-- Visual Header showing the current image -->
            <div class="image-preview-header">
                <img src="<%= request.getContextPath() %>/blogsimg/<%= blog.getImageUrl() %>" alt="Current Banner">
                <div class="header-content">
                    <i class="fa-solid fa-pen-nib fa-2x" style="margin-bottom: 10px;"></i>
                    <h2>Edit Blog Post</h2>
                    <p>Modify the details of your article below</p>
                </div>
            </div>

            <div class="form-section">
                <form action="UpdateBlogServlet" method="post">
                    <!-- Hidden ID -->
                    <input type="hidden" name="id" value="<%= blog.getBlogId() %>">

                    <div class="form-grid">
                        <!-- Title Field -->
                        <div class="form-group full-width">
                            <label>Post Title</label>
                            <div class="input-wrapper">
                                <i class="fa-solid fa-heading"></i>
                                <input type="text" name="title" value="<%= blog.getTitle() %>" required>
                            </div>
                        </div>

                        <!-- Image Field -->
                        <div class="form-group full-width">
                            <label>Image Filename</label>
                            <div class="input-wrapper">
                                <i class="fa-solid fa-image"></i>
                                <input type="text" name="image" value="<%= blog.getImageUrl() %>">
                            </div>
                        </div>

                        <!-- Content Field -->
                        <div class="form-group full-width">
                            <label>Article Content</label>
                            <textarea name="content" required><%= blog.getContent() %></textarea>
                        </div>
                    </div>

                    <div class="button-row">
                        <a href="getblogs.jsp" class="btn btn-cancel">
                            <i class="fa-solid fa-xmark"></i> Cancel
                        </a>
                        <button type="submit" class="btn btn-update">
                            <i class="fa-solid fa-cloud-arrow-up"></i> Save Changes
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

</body>
</html>