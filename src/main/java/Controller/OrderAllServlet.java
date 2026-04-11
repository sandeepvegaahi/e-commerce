package controller;

import java.io.IOException;
import java.util.*;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.*;
import model.*;

@WebServlet("/OrderAllServlet")
public class OrderAllServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        String selected = request.getParameter("selectedIds");

        if (selected == null || selected.isEmpty()) {
            response.sendRedirect("user/cart.jsp");
            return;
        }

        String[] items = selected.split(",");

        ProductDAO pdao = new ProductDAO();
        OrderDAO dao = new OrderDAO();
        CartDAO cdao = new CartDAO(); // optional

        for (String s : items) {

            String[] parts = s.split(":");

            int productId = Integer.parseInt(parts[0]);

            // 🔥 FIX: get actual quantity from DB
            int qty = cdao.getQuantity(user.getUserId(), productId);

            Product p = pdao.getProductById(productId);

            // STOCK CHECK
            if (qty > p.getStockQuantity()) {
                continue;
            }

            OrderItem item = new OrderItem();
            item.setProductId(productId);
            item.setQuantity(qty);
            item.setPriceAtPurchase(p.getOfferPrice());

            List<OrderItem> list = new ArrayList<>();
            list.add(item);

            double total = p.getOfferPrice() * qty;

            // ✅ separate order per item (your requirement)
            int orderId = dao.createOrder(user.getUserId(), total);
            dao.addOrderItems(orderId, list);

            // 🔥 update stock
            pdao.reduceStock(productId, qty);

            // 🔥 remove from cart
            cdao.removeItem(user.getUserId(), productId);
        }

        response.sendRedirect("user/orders.jsp");
    }
}