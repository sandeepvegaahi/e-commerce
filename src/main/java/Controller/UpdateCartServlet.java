package controller;

import java.io.IOException;
import java.sql.*;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.CartDAO;
import model.User;
import util.DBConnection;

@WebServlet("/UpdateCartServlet")
public class UpdateCartServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int productId = Integer.parseInt(request.getParameter("id"));
        String action = request.getParameter("action");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        CartDAO dao = new CartDAO();

        Map<String, Object> data = dao.updateCartItem(user.getUserId(), productId, action);

        response.getWriter().write(
            "qty:" + data.get("qty") +
            ",sub:" + data.get("sub") +
            ",total:" + data.get("total")
        );
    }
}