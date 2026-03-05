package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UserDAO;
import Model.User;
//import Util.PasswordUtil;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = new User();

        user.setFullName(request.getParameter("fullName"));
        user.setEmail(request.getParameter("email"));
        user.setPhone(request.getParameter("phone"));
        user.setPasswordHash(request.getParameter("password"));
                //PasswordUtil.hashPassword(request.getParameter("password"))
        //);
        user.setCity(request.getParameter("city"));
        user.setState(request.getParameter("state"));
        user.setPincode(request.getParameter("pincode"));

        UserDAO dao = new UserDAO();

        if (dao.registerUser(user)) {
            response.sendRedirect("user/login.jsp");
        } else {
            response.getWriter().println("Registration Failed!");
        }
    }
}