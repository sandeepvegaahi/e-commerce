package controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.ProductDAO;
import model.Product;

@WebServlet("/UpdateProductServlet")
public class UpdateProduct extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Product product = new Product();

        product.setProductId(Integer.parseInt(request.getParameter("id")));
        product.setName(request.getParameter("name"));
        product.setCategory(request.getParameter("category"));
        product.setActualPrice(Double.parseDouble(request.getParameter("actualPrice")));
        product.setOfferPrice(Double.parseDouble(request.getParameter("offerPrice")));
        product.setStockQuantity(Integer.parseInt(request.getParameter("stock")));
        product.setImageUrl(request.getParameter("image"));
        product.setDescription(request.getParameter("description"));

        ProductDAO dao = new ProductDAO();
        dao.updateProduct(product);

        //response.sendRedirect("manage-products.jsp");
        response.sendRedirect("getProduct.jsp");
}
}