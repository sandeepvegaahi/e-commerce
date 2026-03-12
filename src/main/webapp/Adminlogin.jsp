
<html>
<head>
<title>Admin Login</title>

<style>
    body {
        margin: 0;
        height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
        font-family: 'Segoe UI', sans-serif;
        background: linear-gradient(135deg, #e3f2fd, #f8fbff);
    }

    .login-container {
        background: white;
        padding: 40px;
        width: 350px;
        border-radius: 15px;
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        text-align: center;
    }

    h2 {
        margin-bottom: 30px;
        letter-spacing: 1px;
        color: #2a5298;
    }

    label {
        display: block;
        text-align: left;
        margin-bottom: 6px;
        font-size: 14px;
        color: #555;
    }

    input[type="text"],
    input[type="password"] {
        width: 100%;
        padding: 10px;
        margin-bottom: 20px;
        border: 1px solid #ddd;
        border-radius: 8px;
        outline: none;
        font-size: 14px;
        transition: 0.3s;
    }

    input[type="text"]:focus,
    input[type="password"]:focus {
        border-color: #2a5298;
        box-shadow: 0 0 5px rgba(42, 82, 152, 0.3);
    }

    input[type="submit"] {
        width: 100%;
        padding: 10px;
        border: none;
        border-radius: 8px;
        background: #2a5298;
        color: white;
        font-weight: bold;
        font-size: 15px;
        cursor: pointer;
        transition: 0.3s ease;
    }

    input[type="submit"]:hover {
        background: #1e3c72;
        transform: scale(1.03);
    }

</style>

</head>
<body>

<div class="login-container">
    <h2>Admin Login</h2>

    <form action="Adminlogin" method="post">

        <label>Email</label>
        <input type="text" name="email" placeholder="Enter your email" required>

        <label>Password</label>
        <input type="password" name="pass" placeholder="Enter your password" required>

        <input type="submit" value="Login">

    </form>
</div>
</body>
</html>