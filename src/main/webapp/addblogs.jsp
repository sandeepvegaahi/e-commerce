<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Admins" %>

<%
    Admins admin = (Admins) session.getAttribute("admin");
    if(admin == null){
        response.sendRedirect("admin-login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create New Blog Post | Admin</title>
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

        /* Container & Layout */
        .page-wrapper {
            max-width: 800px;
            margin: 60px auto;
            padding: 0 20px;
        }

        .header-section {
            text-align: center;
            margin-bottom: 40px;
        }

        .header-section h2 {
            font-size: 32px;
            font-weight: 800;
            margin: 0;
            letter-spacing: -1px;
        }

        .header-section p {
            color: var(--text-muted);
            margin-top: 10px;
        }

        /* Form Card */
        .form-card {
            background: var(--white);
            padding: 40px;
            border-radius: 24px;
            border: 1px solid var(--border);
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.05);
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-group label {
            display: block;
            font-size: 14px;
            font-weight: 600;
            margin-bottom: 8px;
            color: var(--text-main);
        }

        .form-group label i {
            margin-right: 8px;
            color: var(--primary);
            width: 20px;
        }

        /* Inputs */
        input[type="text"], 
        textarea {
            width: 100%;
            padding: 14px 16px;
            border: 1px solid var(--border);
            border-radius: 12px;
            font-family: inherit;
            font-size: 15px;
            box-sizing: border-box;
            transition: all 0.2s;
            background-color: #fafafa;
        }

        input[type="text"]:focus, 
        textarea:focus {
            outline: none;
            border-color: var(--primary);
            background-color: #fff;
            box-shadow: 0 0 0 4px rgba(37, 99, 235, 0.1);
        }

        textarea {
            resize: vertical;
            min-height: 150px;
        }

        /* Button Group */
        .button-group {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
            margin-top: 35px;
        }

        .btn {
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

        .btn-submit {
            background: var(--primary);
            color: white;
        }

        .btn-submit:hover {
            background: #1d4ed8;
            transform: translateY(-2px);
            box-shadow: 0 10px 15px -3px rgba(37, 99, 235, 0.3);
        }

        .btn-back {
            background: #f1f5f9;
            color: var(--text-main);
        }

        .btn-back:hover {
            background: #e2e8f0;
        }

        /* Helper text for the image field */
        .hint {
            font-size: 12px;
            color: var(--text-muted);
            margin-top: 5px;
        }
    </style>
</head>

<body>

    <jsp:include page="navbar.jsp" />

    <div class="page-wrapper">
        <div class="header-section">
            <h2>Create New Post</h2>
            <p>Publish a new article to your blog feed</p>
        </div>

        <div class="form-card">
            <form action="AdminBlogServlet" method="post">
                
                <div class="form-group">
                    <label><i class="fa-solid fa-heading"></i> Blog Title</label>
                    <input type="text" name="title" placeholder="Enter a catchy title..." required>
                </div>

                <div class="form-group">
                    <label><i class="fa-solid fa-image"></i> Image Filename</label>
                    <input type="text" name="image" placeholder="e.g., tech-news.jpg">
                    <div class="hint">Ensure the image exists in your /blogsimg/ folder.</div>
                </div>

                <div class="form-group">
                    <label><i class="fa-solid fa-paragraph"></i> Blog Content</label>
                    <textarea name="content" placeholder="Start writing your story here..." required></textarea>
                </div>

                <div class="button-group">
                    <button type="button" class="btn btn-back" onclick="window.location.href='getblogs.jsp';">
                        <i class="fa-solid fa-arrow-left"></i> Cancel
                    </button>
                    <button type="submit" class="btn btn-submit">
                        <i class="fa-solid fa-paper-plane"></i> Publish Blog
                    </button>
                </div>

            </form>
        </div>
    </div>

</body>
</html>