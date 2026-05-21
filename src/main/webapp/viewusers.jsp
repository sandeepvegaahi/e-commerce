<%@ page import="java.util.List" %>
<%@ page import="dao.UserDAO" %>
<%@ page import="model.User" %>

<%
    UserDAO dao = new UserDAO();
    List<User> list = dao.getAllUsers();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Directory | Admin</title>
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

        .container {
            max-width: 1000px;
            margin: 40px auto;
            padding: 0 20px;
        }

        /* HEADER SECTION */
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .page-header h2 {
            font-size: 28px;
            font-weight: 800;
            margin: 0;
            letter-spacing: -1px;
        }

        .count-badge {
            background: #dbeafe;
            color: var(--primary);
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 700;
            margin-left: 10px;
        }

        /* TABLE STYLING */
        .table-container {
            background: var(--white);
            border-radius: 20px;
            border: 1px solid var(--border);
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.05);
            overflow: hidden;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
        }

        th {
            background: #f1f5f9;
            padding: 18px 24px;
            font-size: 13px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: var(--text-muted);
            border-bottom: 1px solid var(--border);
        }

        td {
            padding: 16px 24px;
            border-bottom: 1px solid #f1f5f9;
            font-size: 15px;
        }

        tr:last-child td { border-bottom: none; }

        tr:hover td {
            background-color: #f8fafc;
        }

        /* USER ROW STYLES */
        .user-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .avatar {
            width: 40px;
            height: 40px;
            background: var(--primary);
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            font-size: 14px;
            text-transform: uppercase;
        }

        .user-link {
            text-decoration: none;
            color: var(--primary);
            font-weight: 600;
            transition: 0.2s;
        }

        .user-link:hover {
            color: #1d4ed8;
            text-decoration: underline;
        }

        .view-btn {
            background: #f1f5f9;
            color: var(--text-main);
            padding: 8px 14px;
            border-radius: 8px;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            border: none;
            transition: 0.2s;
        }

        .view-btn:hover { background: #e2e8f0; }

        /* BACK BUTTON */
        .btn-back {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 20px;
            background: white;
            color: var(--text-main);
            text-decoration: none;
            border-radius: 12px;
            font-weight: 600;
            border: 1px solid var(--border);
            transition: 0.2s;
        }

        .btn-back:hover { background: #f8fafc; transform: translateX(-5px); }

        /* MODAL / POPUP */
        .modal {
            display: none;
            position: fixed;
            inset: 0;
            background: rgba(15, 23, 42, 0.7);
            backdrop-filter: blur(4px);
            z-index: 1000;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .modal-content {
            background: white;
            width: 100%;
            max-width: 450px;
            border-radius: 24px;
            padding: 35px;
            position: relative;
            box-shadow: 0 25px 50px -12px rgba(0,0,0,0.25);
            animation: popIn 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
        }

        @keyframes popIn { from { transform: scale(0.9); opacity: 0; } to { transform: scale(1); opacity: 1; } }

        .close-modal {
            position: absolute;
            top: 20px;
            right: 20px;
            cursor: pointer;
            color: var(--text-muted);
            font-size: 20px;
        }

        .detail-row {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px solid #f1f5f9;
        }

        .detail-row:last-of-type { border-bottom: none; }

        .detail-label { color: var(--text-muted); font-weight: 500; font-size: 14px; }
        .detail-value { color: var(--text-main); font-weight: 700; font-size: 14px; }
    </style>
</head>

<body>
    <jsp:include page="navbar.jsp" />

    <div class="container">
        
        <div class="page-header">
            <div>
                <h2>User Directory <span class="count-badge"><%= list.size() %> Users</span></h2>
            </div>
            <a href="dashboard.jsp" class="btn-back">
                <i class="fa-solid fa-arrow-left"></i> Dashboard
            </a>
        </div>

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>UID</th>
                        <th>User Profile</th>
                        <th style="text-align: right;">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <% for(User u : list){ 
                        // Extract initials for avatar
                        String initials = "";
                        if(u.getFullName() != null && !u.getFullName().isEmpty()){
                            initials = u.getFullName().substring(0,1);
                        }
                    %>
                    <tr>
                        <td style="color: var(--text-muted); font-weight: 600;">#<%= u.getUserId() %></td>
                        <td>
                            <div class="user-info">
                                <div class="avatar"><%= initials %></div>
                                <a href="javascript:void(0)" class="user-link" onclick="showUser(
                                    '<%= u.getFullName() %>', '<%= u.getEmail() %>', '<%= u.getPhone() %>',
                                    '<%= u.getCity() %>', '<%= u.getState() %>', '<%= u.getPincode() %>'
                                )">
                                    <%= u.getFullName() %>
                                </a>
                            </div>
                        </td>
                        <td style="text-align: right;">
                            <button class="view-btn" onclick="showUser(...)">Details</button>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <!-- USER DETAIL MODAL -->
    <div id="popup" class="modal" onclick="closePopup()">
        <div class="modal-content" onclick="event.stopPropagation()">
            <span class="close-modal" onclick="closePopup()"><i class="fa-solid fa-circle-xmark"></i></span>

            <div style="text-align: center; margin-bottom: 25px;">
                <div id="modal-avatar" style="width: 60px; height: 60px; background: var(--primary); color:white; border-radius: 50%; display:inline-flex; align-items:center; justify-content:center; font-size: 24px; font-weight: 800; margin-bottom: 10px;">?</div>
                <h2 id="m-name" style="margin:0; font-size: 22px;">User Name</h2>
                <p id="m-email" style="margin:5px 0 0 0; color: var(--text-muted); font-size: 14px;">email@example.com</p>
            </div>

            <div class="detail-row">
                <span class="detail-label"><i class="fa-solid fa-phone"></i> Contact</span>
                <span class="detail-value" id="m-phone">-</span>
            </div>
            <div class="detail-row">
                <span class="detail-label"><i class="fa-solid fa-city"></i> City</span>
                <span class="detail-value" id="m-city">-</span>
            </div>
            <div class="detail-row">
                <span class="detail-label"><i class="fa-solid fa-map-location-dot"></i> State</span>
                <span class="detail-value" id="m-state">-</span>
            </div>
            <div class="detail-row">
                <span class="detail-label"><i class="fa-solid fa-thumbtack"></i> Pincode</span>
                <span class="detail-value" id="m-pincode">-</span>
            </div>

            <button onclick="closePopup()" class="btn-back" style="width: 100%; justify-content: center; margin-top: 25px; background: var(--primary); color: white; border: none;">
                Close Profile
            </button>
        </div>
    </div>

    <script>
        function showUser(name, email, phone, city, state, pincode) {
            document.getElementById("m-name").innerText = name;
            document.getElementById("m-email").innerText = email;
            document.getElementById("m-phone").innerText = phone;
            document.getElementById("m-city").innerText = city;
            document.getElementById("m-state").innerText = state;
            document.getElementById("m-pincode").innerText = pincode;
            
            // Set Modal Avatar Initial
            document.getElementById("modal-avatar").innerText = name.charAt(0).toUpperCase();

            document.getElementById("popup").style.display = "flex";
            document.body.style.overflow = "hidden";
        }

        function closePopup() {
            document.getElementById("popup").style.display = "none";
            document.body.style.overflow = "auto";
        }
    </script>
</body>
</html>