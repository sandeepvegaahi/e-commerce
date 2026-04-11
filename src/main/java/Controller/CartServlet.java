package controller;

import java.io.IOException;
import java.sql.*;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.CartDAO;
import model.CartItem;
import model.User;
import util.DBConnection;

@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    	HttpSession session = request.getSession();
    	User user = (User) session.getAttribute("user");

    	if(user == null){
    	    response.sendRedirect("user/login.jsp?redirect=CartServlet");
    	    return;
    	}

    	CartDAO dao = new CartDAO();
    	List<CartItem> list = dao.getCartItems(user.getUserId());

    	request.setAttribute("cartItems", list);
    	request.getRequestDispatcher("user/cart.jsp").forward(request, response);
    }
}