package controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import Model.Admins;
import Model.Blog;
import dao.BlogDAO;

@WebServlet("/AdminBlogServlet")
public class AdminBlog extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("admin-login.jsp");
            return;
        }

        Admins admin = (Admins) session.getAttribute("admin");

        Blog blog = new Blog();
        blog.setAdminId(admin.getAdminId());
        blog.setTitle(request.getParameter("title"));
        blog.setContent(request.getParameter("content"));
        blog.setImageUrl(request.getParameter("image"));

        BlogDAO dao = new BlogDAO();
        dao.addBlog(blog);

       // response.sendRedirect("manage-blog.jsp");
        response.sendRedirect("getblogs.jsp");
    }
}