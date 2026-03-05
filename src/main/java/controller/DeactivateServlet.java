package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import Model.User;
import dao.UserDAO;

@WebServlet("/DeactivateServlet")
public class DeactivateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if(session != null) {

            User user = (User) session.getAttribute("user");

            if(user != null) {

                int userId = user.getUserId();

                UserDAO dao = new UserDAO();
                dao.deleteUser(userId);

                // destroy session after deleting account
                session.invalidate();

                response.sendRedirect("user/register.jsp");
            }
        }
    }
}