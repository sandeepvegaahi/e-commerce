package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.CartDAO;
import model.User;

@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {

    // 🔥 COMMON METHOD (your existing logic moved here)
    private void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int productId = Integer.parseInt(request.getParameter("id"));

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // ✅ LOGIN CHECK (UNCHANGED)
        if(user == null){
            response.sendRedirect("user/login.jsp?redirect=AddToCartServlet?id=" 
                + productId + "&action=" + request.getParameter("action"));
            return;
        }

        CartDAO dao = new CartDAO();
        dao.addToCart(user.getUserId(), productId);

        String action = request.getParameter("action");

        // ✅ BEHAVIOR (UNCHANGED)
        if ("buy".equals(action)) {
            response.sendRedirect("CartServlet");
        } else {
            // 🔥 AJAX call → DO NOT REDIRECT
            response.setContentType("text/plain");
            response.getWriter().write("added");
        }
    }

    // ✅ HANDLE GET (existing behavior)
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        processRequest(request, response);
    }

    // 🔥 ADD THIS (FIX FOR 405)
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        processRequest(request, response);
    }
}