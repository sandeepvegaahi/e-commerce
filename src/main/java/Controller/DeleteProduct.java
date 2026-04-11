package controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.ProductDAO;

@WebServlet("/DeleteProductServlet")
public class DeleteProduct extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        ProductDAO dao = new ProductDAO();
        dao.deleteProduct(id);

        //response.sendRedirect("manage-products.jsp");
        response.sendRedirect("getProduct.jsp");
    }
}