package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.BlogDAO;
@WebServlet("/DeleteBlogServlet")
public class DeleteBlog extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        BlogDAO dao = new BlogDAO();
        dao.deleteBlog(id);

        //response.sendRedirect("manage-blog.jsp");
        response.sendRedirect("getblogs.jsp");
    }
}