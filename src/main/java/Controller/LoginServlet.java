package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.UserDAO;
import model.User;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        //String hashedPassword = PasswordUtil.hashPassword(password);

        UserDAO dao = new UserDAO();
        User user = dao.loginUser(email, password);

        if (user != null) {

            HttpSession session = request.getSession();
            session.setAttribute("user", user);
 
         // 🔥 NEW CODE
            String redirect = request.getParameter("redirect");

            if (redirect != null && !redirect.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/" + redirect);
            } else {
                response.sendRedirect("user/home.jsp");
            }

        } else {
        	 request.setAttribute("errorMessage", "Wrong credentials! Try again");
        	 request.getRequestDispatcher("/user/login.jsp").forward(request, response);
        }
        
    }
}