package controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.ProductDAO;
import model.Admins;
import model.Product;

@WebServlet("/AdminProductServlet")
public class AdminProduct extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // ✅ SAFER METHOD
        if (session == null || session.getAttribute("admin") == null) {
           // response.sendRedirect("admin-login.jsp");
        	 response.sendRedirect("addProduct.jsp");
            return;
        }

        // Now safe to use session
        Admins adminData = (Admins) session.getAttribute("admin");
        int adminId = adminData.getAdminId();

        Product product = new Product();
        product.setAdminId(adminId);
        product.setName(request.getParameter("name"));
        product.setDescription(request.getParameter("description"));
        product.setCategory(request.getParameter("category"));
        product.setActualPrice(Double.parseDouble(request.getParameter("actualPrice")));
        product.setOfferPrice(Double.parseDouble(request.getParameter("offerPrice")));
        product.setStockQuantity(Integer.parseInt(request.getParameter("stock")));
        product.setImageUrl(request.getParameter("image"));

        ProductDAO dao = new ProductDAO();
        boolean status = dao.addProduct(product);

        if (status) {
            response.sendRedirect("getProduct.jsp");
        } else {
            response.getWriter().println("Error Adding Product");
        }
    }
}

//package controller;
//
//import java.io.IOException;
//import javax.servlet.*;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.*;
//
//import DAO.ProductDAO;
//import Model.Admins;
//import Model.Product;
//
//@WebServlet("/AdminProductServlet")
//public class AdminProduct extends HttpServlet {
//
//    /**
//	 * 
//	 */
//	private static final long serialVersionUID = 1L;
//
//	protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//		
//		
//
//        HttpSession session = request.getSession(false);
//        
//        Admins adminData=(Admins) session.getAttribute("admin");
//        
//        
//        
//        if (adminData == null ) {
//            response.sendRedirect("index.jsp");
//            return;
//        }
//
//
//        int adminId = adminData.getAdminId();
//        
//        System.out.println(adminId);
//       
//
//        Product product = new Product();
//
//        product.setAdminId(adminId);
//        product.setName(request.getParameter("name"));
//        product.setDescription(request.getParameter("description"));
//        product.setCategory(request.getParameter("category"));
//        product.setActualPrice(Double.parseDouble(request.getParameter("actualPrice")));
//        product.setOfferPrice(Double.parseDouble(request.getParameter("offerPrice")));
//        product.setStockQuantity(Integer.parseInt(request.getParameter("stock")));
//        product.setImageUrl(request.getParameter("image"));
//
//        ProductDAO dao = new ProductDAO();
//        boolean status = dao.addProduct(product);
//
//        if (status) {
//            response.sendRedirect("dashboard.jsp");
//        } else {
//            response.getWriter().println("Error Adding Product");
//        }
//    }
//}

//package controller;
//
//import java.io.IOException;
//import javax.servlet.*;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.*;
//
//import DAO.ProductDAO;
//import Model.Admins;
//import Model.Product;
//
//@WebServlet("/AdminProductServlet")
//public class AdminProduct extends HttpServlet {
//
//    private static final long serialVersionUID = 1L;
//
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        HttpSession session = request.getSession(false);
//
//        if (session == null) {
//            response.sendRedirect("index.jsp");
//            return;
//        }
//
//        Admins adminData = (Admins) session.getAttribute("admin");
//
//        if (adminData == null) {
//            response.sendRedirect("index.jsp");
//            return;
//        }
//
//        int adminId = adminData.getAdminId();
//
//        Product product = new Product();
//        product.setAdminId(adminId);
//        product.setName(request.getParameter("name"));
//        product.setDescription(request.getParameter("description"));
//        product.setCategory(request.getParameter("category"));
//
//        try {
//            product.setActualPrice(Double.parseDouble(request.getParameter("actualPrice")));
//            product.setOfferPrice(Double.parseDouble(request.getParameter("offerPrice")));
//            product.setStockQuantity(Integer.parseInt(request.getParameter("stock")));
//        } catch (NumberFormatException e) {
//            response.getWriter().println("Invalid price or stock value");
//            return;
//        }
//
//        product.setImageUrl(request.getParameter("image"));
//
//        ProductDAO dao = new ProductDAO();
//        boolean status = dao.addProduct(product);
//
//        if (status) {
//            response.sendRedirect("dashboard.jsp");
//        } else {
//            response.getWriter().println("Error Adding Product");
//        }
//    }
//}