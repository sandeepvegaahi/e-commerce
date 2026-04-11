package controller;

import java.io.IOException;
import java.util.*;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.*;
import model.*;

@WebServlet("/BuyNowServlet")
public class BuyNowServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("user/login.jsp");
            return;
        }

        int productId = Integer.parseInt(request.getParameter("id"));

        ProductDAO pdao = new ProductDAO();
        Product p = pdao.getProductById(productId);

        // 🔥 GET QUANTITY FROM CART
        CartDAO cdao = new CartDAO();
        int qty = cdao.getQuantity(user.getUserId(), productId); // 👈 you add this method
        // 🔥 GET QUANTITY FROM CART
        

        if(qty <= 0) qty = 1;

        // 🔥 CHECK STOCK
        if(p.getStockQuantity() < qty){
            response.getWriter().write("Out of stock!");
            return;
        }

        // 🔥 REDUCE STOCK (IMPORTANT)
        pdao.reduceStock(productId, qty);

        

        // CREATE ITEM
        OrderItem item = new OrderItem();
        item.setProductId(productId);
        item.setQuantity(qty);   // ✅ FIXED
        item.setPriceAtPurchase(p.getOfferPrice());

        List<OrderItem> list = new ArrayList<>();
        list.add(item);

        double total = p.getOfferPrice() * qty; // ✅ FIXED
    
        OrderDAO dao = new OrderDAO();
        int orderId = dao.createOrder(user.getUserId(), total);
        dao.addOrderItems(orderId, list);
        cdao.removeItem(user.getUserId(), productId);
        response.sendRedirect("user/orders.jsp");
    }
}