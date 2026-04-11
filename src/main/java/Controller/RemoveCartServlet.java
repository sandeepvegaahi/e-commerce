package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.CartDAO;
import model.User;

@WebServlet("/RemoveCartServlet")
public class RemoveCartServlet extends HttpServlet {

	 

	    protected void doGet(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {

	        int productId = Integer.parseInt(request.getParameter("id"));

	        HttpSession session = request.getSession();
	        User user = (User) session.getAttribute("user");

	        if(user == null){
	            response.sendRedirect("user/login.jsp?redirect=CartServlet");
	            return;
	        }

	        System.out.println("REMOVE CLICKED: " + productId);

	        CartDAO dao = new CartDAO();
	        dao.removeFromCart(user.getUserId(), productId);

	        response.setContentType("text/plain");
	        response.getWriter().write("success");
	    }
	}
