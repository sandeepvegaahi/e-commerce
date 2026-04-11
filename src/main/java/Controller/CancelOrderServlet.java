package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import dao.OrderDAO;
import dao.ProductDAO;
import model.OrderItem;

@WebServlet("/CancelOrderServlet")
public class CancelOrderServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int orderId = Integer.parseInt(request.getParameter("id"));

        OrderDAO dao = new OrderDAO();
        ProductDAO pdao = new ProductDAO();

        // 🔥 GET ITEMS
        List<OrderItem> items = dao.getOrderItems(orderId);

        // 🔥 RESTORE STOCK
        for(OrderItem item : items){
            pdao.increaseStock(item.getProductId(), item.getQuantity());
        }

        // 🔥 UPDATE STATUS
        dao.cancelOrder(orderId);

        response.getWriter().write("success");
     // 🔥 PREVENT DOUBLE CANCEL
     // (you need a method to get status)
     String status = dao.getOrderStatus(orderId);

     if("Cancelled".equals(status)){
         response.getWriter().write("already_cancelled");
         return;
     }
    }
}