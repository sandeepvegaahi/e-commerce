package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.OrderDAO;

@WebServlet("/TrackOrderServlet")
public class TrackOrderServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int orderId = Integer.parseInt(request.getParameter("id"));

        OrderDAO dao = new OrderDAO();
        /*List<String> list = dao.getTrackingStatus(orderId);

        response.setContentType("text/html");

        for(String s : list){
            response.getWriter().write(
                "<div class='step'>"+s+"</div>"
            );
        }*/
    }
}