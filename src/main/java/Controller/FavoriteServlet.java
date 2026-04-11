package controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.FavoriteDAO;
import model.User;

@WebServlet("/FavoriteServlet")
public class FavoriteServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if(user == null){
            response.sendRedirect("user/login.jsp");
            return;
        }

        FavoriteDAO dao = new FavoriteDAO();
        request.setAttribute("favList", dao.getFavorites(user.getUserId()));

        RequestDispatcher rd = request.getRequestDispatcher("user/favorites.jsp");
        rd.forward(request, response);
    }
}