package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.AdminDAO;
import model.Admins;

@WebServlet("/Adminlogin")
public class Adminlongin extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("pass");

        AdminDAO dao = new AdminDAO();
        Admins admin = dao.login(email, password);

        if (admin != null) {

            HttpSession session = request.getSession(true);
            session.setAttribute("admin", admin);

            response.sendRedirect("dashboard.jsp");

        } else {
            response.getWriter().println("Invalid Email or Password");
        }
    }
}